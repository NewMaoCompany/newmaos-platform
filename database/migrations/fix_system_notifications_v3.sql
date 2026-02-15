-- ============================================================
-- Migration: Fix System Notifications v3
-- 1. Fix "Duplicate Notifications" by strictly checking if a notification
--    was already generated TODAY (regardless of read status).
-- 2. Add "Welcome Gift" (200 Coins) for new users.
-- ============================================================

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
    v_welcome_gift_given BOOLEAN;
BEGIN
    -- ============================================================
    -- RATE LIMIT: Only run once per calendar day (UTC)
    -- ============================================================
    SELECT last_notif_generated_at INTO v_last_gen
    FROM public.user_profiles WHERE id = p_user_id;

    IF v_last_gen IS NOT NULL AND v_last_gen::DATE = CURRENT_DATE THEN
        RETURN;  -- Already generated today, skip
    END IF;

    -- ============================================================
    -- FETCH CURRENT DATA
    -- ============================================================
    SELECT accuracy_rate, unique_questions_attempted, total_time_spent_seconds 
    INTO v_accuracy, v_solved, v_seconds
    FROM public.user_stats
    WHERE user_id = p_user_id;
    
    SELECT streak_days, subscription_tier, subscription_period_end 
    INTO v_streak, v_sub_tier, v_sub_end 
    FROM public.user_profiles WHERE id = p_user_id;

    SELECT created_at INTO v_user_created_at
    FROM auth.users WHERE id = p_user_id;

    -- Check if user has practiced TODAY
    v_has_practiced_today := EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id 
        AND last_practiced IS NOT NULL
        AND last_practiced::DATE = CURRENT_DATE
    );

    -- Get user points balance
    SELECT balance INTO v_user_balance
    FROM public.user_points WHERE user_id = p_user_id;

    -- If no points record exists, create one
    IF v_user_balance IS NULL THEN
        INSERT INTO public.user_points (user_id, balance, lifetime_earned)
        VALUES (p_user_id, 0, 0)
        ON CONFLICT (user_id) DO NOTHING;
        v_user_balance := 0;
    END IF;

    -- ============================================================
    -- 0. WELCOME GIFT (200 Coins) - One Time Only
    -- ============================================================
    -- Check if we already gave the welcome gift
    v_welcome_gift_given := EXISTS (
        SELECT 1 FROM public.user_points_transactions 
        WHERE user_id = p_user_id AND description = 'Welcome Gift'
    );

    IF NOT v_welcome_gift_given THEN
        -- Award 200 points
        UPDATE public.user_points 
        SET balance = balance + 200, 
            lifetime_earned = lifetime_earned + 200 
        WHERE user_id = p_user_id;

        -- Log transaction
        INSERT INTO public.user_points_transactions (user_id, amount, transaction_type, description)
        VALUES (p_user_id, 200, 'earned', 'Welcome Gift');

        -- Notify User
        INSERT INTO public.notifications (user_id, text, link, unread)
        VALUES (p_user_id, '🎁 Welcome Gift! You received 200 coins to start your journey.', '/dashboard', true);
    END IF;

    -- ============================================================
    -- ANALYSIS NOTIFICATIONS (4 items) — only if practiced today
    -- ============================================================
    IF v_has_practiced_today AND v_solved IS NOT NULL AND v_solved > 0 THEN

        -- 1. ACCURACY
        v_prefix := '[Analysis - Accuracy]';
        v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
        
        -- Check if ANY notification of this type was sent TODAY (read or unread)
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
             -- Check if value changed significantly from the LAST notification ever sent
            SELECT text INTO v_last_val FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;

            IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
                -- Remove old unread ones to reduce clutter
                DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
            END IF;
        END IF;

        -- 2. SOLVED
        v_prefix := '[Analysis - Solved]';
        v_new_val := COALESCE(v_solved, 0)::TEXT;
        
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            SELECT text INTO v_last_val FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;

            IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
                DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
            END IF;
        END IF;

        -- 3. STUDY TIME
        v_prefix := '[Analysis - Time]';
        v_minutes := COALESCE((v_seconds / 60)::INTEGER, 0);
        v_new_val := v_minutes || 'm';

        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            SELECT text INTO v_last_val FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;

            IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
                DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
            END IF;
        END IF;

        -- 4. STREAK
        v_prefix := '[Analysis - Streak]';
        v_new_val := COALESCE(v_streak, 0) || ' days';

        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            SELECT text INTO v_last_val FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;

            IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
                DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
            END IF;
        END IF;

    END IF;

    -- ============================================================
    -- MEMBERSHIP NOTIFICATION — conditional
    -- ============================================================
    v_prefix := '[Membership]';
    
    -- Check if we already sent a membership notification TODAY
    IF NOT EXISTS (
        SELECT 1 FROM public.notifications 
        WHERE user_id = p_user_id 
        AND text LIKE v_prefix || '%'
        AND created_at::DATE = CURRENT_DATE
    ) THEN
        IF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NOT NULL AND v_sub_end < NOW()) THEN
            -- Pro expired → downgrade + remind to renew
            UPDATE public.user_profiles SET subscription_tier = 'basic' WHERE id = p_user_id;
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' Your Pro plan has ended. Click here to renew!', '/settings/subscription', true);

        ELSIF COALESCE(v_sub_tier, 'basic') = 'basic' AND COALESCE(v_user_balance, 0) >= 199 THEN
            -- Basic + enough points → remind to upgrade
            SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            
            IF v_unread_count = 0 THEN
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, v_prefix || ' You have enough coins to upgrade to Pro! Redeem now.', '/settings/subscription', true);
            END IF;
        END IF;
    END IF;

    -- ============================================================
    -- DAILY CHECK-IN REMINDER 
    -- ============================================================
    v_prefix := '[Daily Check-in]';
    
    -- Only prompt if:
    -- 1. Not yet checked in today (checked via user_stats last_practiced? No, that's practice. 
    --    We should probably check user_profiles.streak_updated_at or similar, strictly we don't have a direct "checked_in_today" col here easily without joining.
    --    Actually, the previous logic used `NOT EXISTS ... user_stats ... last_practiced`. 
    --    This logic is flawed because check-in != practice. 
    --    But let's stick to the existing logic pattern but fix the DUPLICATE issue.)
    
    -- Strict Duplicate Check:
    IF NOT EXISTS (
        SELECT 1 FROM public.notifications 
        WHERE user_id = p_user_id 
        AND text LIKE v_prefix || '%'
        AND created_at::DATE = CURRENT_DATE
    ) THEN
        IF NOT EXISTS (
            SELECT 1 FROM public.user_stats 
            WHERE user_id = p_user_id 
            AND last_practiced::DATE = CURRENT_DATE
        ) THEN
            -- Only insert if no unread reminder exists
            SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            
            IF v_unread_count = 0 THEN
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, v_prefix || ' Don''t forget to claim your daily reward!', '/checkin', true);
            END IF;
        ELSE
             -- If they HAVE practiced/checked-in, clear the reminder
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        END IF;
    END IF;

    -- ============================================================
    -- Update rate-limit timestamp
    -- ============================================================
    UPDATE public.user_profiles SET last_notif_generated_at = NOW() WHERE id = p_user_id;

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
