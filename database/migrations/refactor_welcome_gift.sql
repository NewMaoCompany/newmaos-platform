-- ============================================================
-- REFACTOR: Welcome Gift (200 NMS Points)
-- 1. Remove auto-award logic from generate_system_notifications
-- 2. Create RPC for frontend to claim gift manually
-- ============================================================

-- 1. Redefine generate_system_notifications (v4)
-- This removes the "0. WELCOME GIFT" section logic.
CREATE OR REPLACE FUNCTION public.generate_system_notifications(p_user_id UUID)
RETURNS VOID AS $$
DECLARE
    v_accuracy NUMERIC;
    v_solved INTEGER;
    v_seconds BIGINT;
    v_minutes INTEGER;
    v_streak INTEGER;
    v_last_val TEXT;
    v_new_val TEXT;
    v_sub_tier TEXT;
    v_sub_end TIMESTAMPTZ;
    v_prefix TEXT;
    v_unread_count INTEGER;
    v_last_gen TIMESTAMPTZ;
    v_has_practiced_today BOOLEAN;
    v_user_balance INTEGER;
    v_user_created_at TIMESTAMPTZ;
BEGIN
    -- RATE LIMIT: Only run once per calendar day (UTC)
    SELECT last_notif_generated_at INTO v_last_gen
    FROM public.user_profiles WHERE id = p_user_id;

    IF v_last_gen IS NOT NULL AND v_last_gen::DATE = CURRENT_DATE THEN
        RETURN;
    END IF;

    -- FETCH CURRENT DATA
    SELECT accuracy_rate, unique_questions_attempted, total_time_spent_seconds 
    INTO v_accuracy, v_solved, v_seconds
    FROM public.user_stats WHERE user_id = p_user_id;
    
    SELECT streak_days, subscription_tier, subscription_period_end 
    INTO v_streak, v_sub_tier, v_sub_end 
    FROM public.user_profiles WHERE id = p_user_id;

    SELECT balance INTO v_user_balance
    FROM public.user_points WHERE user_id = p_user_id;

    IF v_user_balance IS NULL THEN
        INSERT INTO public.user_points (user_id, balance, lifetime_earned)
        VALUES (p_user_id, 0, 0) ON CONFLICT (user_id) DO NOTHING;
        v_user_balance := 0;
    END IF;

    -- NOTE: WELCOME GIFT LOGIC REMOVED FROM HERE.
    -- It is now handled by process_claim_welcome_gift() RPC via frontend popup.

    -- [Rest of the analysis, membership, and check-in logic follows...]
    -- (Keeping logic from bugfix_combined_v1.sql / fix_system_notifications_v3.sql)
    
    v_has_practiced_today := EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id AND last_practiced::DATE = CURRENT_DATE
    );

    IF v_has_practiced_today AND v_solved IS NOT NULL AND v_solved > 0 THEN
        -- Accuracy
        v_prefix := '[Analysis - Accuracy]';
        v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
        IF NOT EXISTS (SELECT 1 FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE) THEN
            SELECT text INTO v_last_val FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
            IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
                DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                INSERT INTO public.notifications (user_id, text, link, unread) VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
            END IF;
        END IF;

        -- Solved
        v_prefix := '[Analysis - Solved]';
        v_new_val := COALESCE(v_solved, 0)::TEXT;
        IF NOT EXISTS (SELECT 1 FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE) THEN
            SELECT text INTO v_last_val FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
            IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
                DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                INSERT INTO public.notifications (user_id, text, link, unread) VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
            END IF;
        END IF;
    END IF;

    -- Membership
    v_prefix := '[Membership]';
    IF NOT EXISTS (SELECT 1 FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE) THEN
        IF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NOT NULL AND v_sub_end < NOW()) THEN
            UPDATE public.user_profiles SET subscription_tier = 'basic' WHERE id = p_user_id;
            INSERT INTO public.notifications (user_id, text, link, unread) VALUES (p_user_id, v_prefix || ' Your Pro plan has ended. Click here to renew!', '/settings/subscription', true);
        ELSIF COALESCE(v_sub_tier, 'basic') = 'basic' AND v_user_balance >= 199 THEN
            IF NOT EXISTS (SELECT 1 FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true) THEN
                INSERT INTO public.notifications (user_id, text, link, unread) VALUES (p_user_id, v_prefix || ' You have enough coins to upgrade to Pro! Redeem now.', '/settings/subscription', true);
            END IF;
        END IF;
    END IF;

    -- Daily Check-in Reminder
    v_prefix := '[Daily Check-in]';
    IF NOT EXISTS (SELECT 1 FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE) THEN
        IF NOT EXISTS (SELECT 1 FROM public.user_stats WHERE user_id = p_user_id AND last_practiced::DATE = CURRENT_DATE) THEN
            IF NOT EXISTS (SELECT 1 FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true) THEN
                INSERT INTO public.notifications (user_id, text, link, unread) VALUES (p_user_id, v_prefix || ' Don''t forget to claim your daily reward!', '/checkin', true);
            END IF;
        ELSE
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        END IF;
    END IF;

    UPDATE public.user_profiles SET last_notif_generated_at = NOW() WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 2. Define RPC to claim welcome gift
CREATE OR REPLACE FUNCTION public.claim_welcome_gift()
RETURNS JSONB AS $$
DECLARE
    v_user_id UUID;
    v_already_claimed BOOLEAN;
BEGIN
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Not authenticated');
    END IF;

    -- Check if gift already claimed (check transactions)
    v_already_claimed := EXISTS (
        SELECT 1 FROM public.user_points_transactions 
        WHERE user_id = v_user_id AND description = 'Welcome Gift'
    );

    IF v_already_claimed THEN
        RETURN jsonb_build_object('success', false, 'error', 'Already claimed');
    END IF;

    -- 1. Ensure user_points record exists
    INSERT INTO public.user_points (user_id, balance, lifetime_earned)
    VALUES (v_user_id, 0, 0)
    ON CONFLICT (user_id) DO NOTHING;

    -- 2. Award Points
    UPDATE public.user_points 
    SET balance = balance + 200,
        lifetime_earned = lifetime_earned + 200
    WHERE user_id = v_user_id;

    -- 3. Log Transaction
    INSERT INTO public.user_points_transactions (user_id, amount, transaction_type, description)
    VALUES (v_user_id, 200, 'earned', 'Welcome Gift');

    -- 4. Mark any existing welcome gift notifications as read/deleted for cleanliness
    DELETE FROM public.notifications 
    WHERE user_id = v_user_id AND text LIKE '%Welcome Gift%';

    RETURN jsonb_build_object('success', true, 'amount', 200);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
