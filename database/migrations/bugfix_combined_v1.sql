-- ============================================================
-- COMBINED FIX: All three bugs in one migration
-- Run this in Supabase SQL Editor
-- ============================================================

-- ============================================================
-- FIX 1: Add 'gift_claim' to points_ledger type CHECK
-- ============================================================
ALTER TABLE public.points_ledger DROP CONSTRAINT IF EXISTS points_ledger_type_check;

ALTER TABLE public.points_ledger ADD CONSTRAINT points_ledger_type_check 
    CHECK (type IN (
        'practice_complete', 'unit_test_complete', 'error_correction',
        'daily_checkin', 'checkin_bonus',
        'like_received', 'comment_received', 'follower_gained', 'friend_added',
        'pro_redeem', 'manual_adjustment',
        'gift_claim'
    ));

-- ============================================================
-- FIX 2: Add rate-limiting column for notifications
-- ============================================================
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS last_notif_generated_at TIMESTAMPTZ DEFAULT NULL;

-- ============================================================
-- FIX 3: Rewrite generate_system_notifications v2 (English, rate-limited)
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
BEGIN
    -- RATE LIMIT: Only run once per calendar day
    SELECT last_notif_generated_at INTO v_last_gen
    FROM public.user_profiles WHERE id = p_user_id;

    IF v_last_gen IS NOT NULL AND v_last_gen::DATE = CURRENT_DATE THEN
        RETURN;
    END IF;

    -- CLEANUP: Remove old Chinese prefix notifications
    DELETE FROM public.notifications 
    WHERE user_id = p_user_id AND text LIKE '🔔 每日簽到提醒%' AND unread = true;

    -- FETCH CURRENT DATA
    SELECT accuracy_rate, unique_questions_attempted, total_time_spent_seconds 
    INTO v_accuracy, v_solved, v_seconds
    FROM public.user_stats WHERE user_id = p_user_id;
    
    SELECT streak_days, subscription_tier, subscription_period_end 
    INTO v_streak, v_sub_tier, v_sub_end 
    FROM public.user_profiles WHERE id = p_user_id;

    v_has_practiced_today := EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id 
        AND last_practiced IS NOT NULL
        AND last_practiced::DATE = CURRENT_DATE
    );

    SELECT balance INTO v_user_balance
    FROM public.user_points WHERE user_id = p_user_id;

    -- ============================================================
    -- ANALYSIS (4 items) — only if user practiced today
    -- ============================================================
    IF v_has_practiced_today AND v_solved IS NOT NULL AND v_solved > 0 THEN

        v_prefix := '[Analysis - Accuracy]';
        v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        END IF;

        v_prefix := '[Analysis - Solved]';
        v_new_val := COALESCE(v_solved, 0)::TEXT;
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        END IF;

        v_prefix := '[Analysis - Time]';
        v_minutes := COALESCE((v_seconds / 60)::INTEGER, 0);
        v_new_val := v_minutes || 'm';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        END IF;

        v_prefix := '[Analysis - Streak]';
        v_new_val := COALESCE(v_streak, 0) || ' days';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        END IF;

    END IF;

    -- ============================================================
    -- MEMBERSHIP — conditional
    -- ============================================================
    v_prefix := '[Membership]';
    IF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NOT NULL AND v_sub_end < NOW()) THEN
        UPDATE public.user_profiles SET subscription_tier = 'basic' WHERE id = p_user_id;
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        INSERT INTO public.notifications (user_id, text, link, unread)
        VALUES (p_user_id, v_prefix || ' Your Pro plan has ended. Click here to renew!', '/settings/subscription', true);
    ELSIF COALESCE(v_sub_tier, 'basic') = 'basic' AND COALESCE(v_user_balance, 0) >= 199 THEN
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        IF v_unread_count = 0 THEN
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' You have enough coins to upgrade to Pro! Redeem now.', '/settings/subscription', true);
        END IF;
    ELSIF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NULL OR v_sub_end >= NOW()) THEN
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
    END IF;

    -- ============================================================
    -- DAILY CHECK-IN REMINDER (English)
    -- ============================================================
    v_prefix := '[Daily Check-in]';
    IF NOT EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id 
        AND last_practiced::DATE = CURRENT_DATE
    ) THEN
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        IF v_unread_count = 0 THEN
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' Don''t forget to claim your daily reward!', '/checkin', true);
        END IF;
    ELSE
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
    END IF;

    -- Update rate-limit timestamp
    UPDATE public.user_profiles SET last_notif_generated_at = NOW() WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- FIX 4: Ensure redeem_pro_with_points uses correct cost (199, not 1999)
-- ============================================================
CREATE OR REPLACE FUNCTION public.redeem_pro_with_points(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_balance INTEGER;
    v_cost INTEGER := 199;
    v_period_end TIMESTAMPTZ;
    v_idem_key TEXT;
BEGIN
    SELECT balance INTO v_balance FROM public.user_points WHERE user_id = p_user_id;

    IF v_balance IS NULL OR v_balance < v_cost THEN
        RETURN jsonb_build_object(
            'success', false,
            'reason', 'insufficient_points',
            'balance', COALESCE(v_balance, 0),
            'cost', v_cost,
            'shortfall', v_cost - COALESCE(v_balance, 0)
        );
    END IF;

    SELECT subscription_period_end INTO v_period_end FROM public.user_profiles WHERE id = p_user_id;
    IF v_period_end IS NOT NULL AND v_period_end > NOW() THEN
        v_period_end := v_period_end + INTERVAL '1 month';
    ELSE
        v_period_end := NOW() + INTERVAL '1 month';
    END IF;

    v_idem_key := 'pro_redeem_' || p_user_id || '_' || to_char(NOW(), 'YYYY-MM');

    IF EXISTS (SELECT 1 FROM public.points_ledger WHERE idempotency_key = v_idem_key) THEN
        RETURN jsonb_build_object('success', false, 'reason', 'already_redeemed_this_month');
    END IF;

    UPDATE public.user_points
    SET balance = balance - v_cost, updated_at = NOW()
    WHERE user_id = p_user_id;

    INSERT INTO public.points_ledger (user_id, amount, type, description, idempotency_key)
    VALUES (p_user_id, -v_cost, 'pro_redeem', 'Pro Monthly Subscription', v_idem_key);

    UPDATE public.user_profiles
    SET subscription_tier = 'pro',
        subscription_period_end = v_period_end
    WHERE id = p_user_id;

    RETURN jsonb_build_object(
        'success', true,
        'new_balance', (SELECT balance FROM public.user_points WHERE user_id = p_user_id),
        'period_end', v_period_end
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- CLEANUP: Delete all existing stale notifications for fresh start
-- (Run this to clear duplicates from old bug)
-- ============================================================
DELETE FROM public.notifications WHERE text LIKE '🔔 每日簽到提醒%';
DELETE FROM public.notifications WHERE text LIKE '[Daily Analysis]%';
