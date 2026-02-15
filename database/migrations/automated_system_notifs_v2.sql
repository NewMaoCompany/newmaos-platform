-- ============================================================
-- Migration: Restructure System Notification Strategy v2
-- 1. Add last_notif_generated_at column for daily rate-limiting
-- 2. Rewrite generate_system_notifications with proper conditions
-- ============================================================

-- Step 1: Add rate-limiting column
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS last_notif_generated_at TIMESTAMPTZ DEFAULT NULL;

-- Step 2: Rewrite the RPC
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

    -- ============================================================
    -- ANALYSIS NOTIFICATIONS (4 items) — only if practiced today
    -- ============================================================
    IF v_has_practiced_today AND v_solved IS NOT NULL AND v_solved > 0 THEN

        -- 1. ACCURACY
        v_prefix := '[Analysis - Accuracy]';
        v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;

        -- Only insert if value changed from last notification
        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        END IF;

        -- 2. SOLVED
        v_prefix := '[Analysis - Solved]';
        v_new_val := COALESCE(v_solved, 0)::TEXT;
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;

        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        END IF;

        -- 3. STUDY TIME
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

        -- 4. STREAK
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
    -- MEMBERSHIP NOTIFICATION — conditional
    -- ============================================================
    v_prefix := '[Membership]';

    IF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NOT NULL AND v_sub_end < NOW()) THEN
        -- Pro expired → downgrade + remind to renew
        UPDATE public.user_profiles SET subscription_tier = 'basic' WHERE id = p_user_id;
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        INSERT INTO public.notifications (user_id, text, link, unread)
        VALUES (p_user_id, v_prefix || ' Your Pro plan has ended. Click here to renew!', '/settings/subscription', true);

    ELSIF COALESCE(v_sub_tier, 'basic') = 'basic' AND COALESCE(v_user_balance, 0) >= 199 THEN
        -- Basic + enough points → remind to upgrade (once per day max)
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        IF v_unread_count = 0 THEN
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' You have enough coins to upgrade to Pro! Redeem now.', '/settings/subscription', true);
        END IF;

    ELSIF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NULL OR v_sub_end >= NOW()) THEN
        -- Active Pro → clean up any stale membership notifications
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
    END IF;
    -- Basic + not enough points → do nothing (no spam for new users)

    -- ============================================================
    -- DAILY CHECK-IN REMINDER (unchanged logic)
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

    -- ============================================================
    -- Update rate-limit timestamp
    -- ============================================================
    UPDATE public.user_profiles SET last_notif_generated_at = NOW() WHERE id = p_user_id;

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
