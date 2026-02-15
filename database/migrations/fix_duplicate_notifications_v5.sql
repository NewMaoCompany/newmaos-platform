-- ============================================================
-- Migration: Fix Duplicate System Notifications v5
-- 1. Add strict serialization (pg_advisory_xact_lock) to prevent race conditions
-- 2. Clean up existing duplicate "Daily Check-in available!" notifications
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
    v_welcome_notif_exists BOOLEAN;
BEGIN
    -- ============================================================
    -- CRITICAL: Prevent concurrent execution for the same user
    -- Utilizes transaction-level advisory lock based on user ID hash.
    -- This ensures that only one call proceeds at a time per user, 
    -- acting as a critical section.
    -- ============================================================
    PERFORM pg_advisory_xact_lock(hashtext('generate_system_notifications' || p_user_id::text));

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
    -- 0. WELCOME NOTIFICATION (Notification Only)
    -- ============================================================
    v_welcome_notif_exists := EXISTS (
        SELECT 1 FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE '%Welcome to NewMaoS%'
    );

    IF NOT v_welcome_notif_exists THEN
        INSERT INTO public.notifications (user_id, text, link, unread)
        VALUES (p_user_id, 'Welcome to NewMaoS! Start your first session.', '/dashboard', true);
    END IF;

    -- ============================================================
    -- ANALYSIS NOTIFICATIONS (4 items) — only if practiced today
    -- ============================================================
    IF v_has_practiced_today AND v_solved IS NOT NULL AND v_solved > 0 THEN

        -- 1. ACCURACY
        v_prefix := '[Analysis - Accuracy]';
        v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
        
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
    
    IF NOT EXISTS (
        SELECT 1 FROM public.notifications 
        WHERE user_id = p_user_id 
        AND text LIKE v_prefix || '%'
        AND created_at::DATE = CURRENT_DATE
    ) THEN
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
        END IF;
    END IF;

    -- ============================================================
    -- DAILY CHECK-IN REMINDER (Fixing duplication via strict checks)
    -- ============================================================
    v_prefix := '📅 Daily Check-in available!';
    
    -- Check if user has NOT practiced/checked-in today
    IF NOT EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id 
        AND last_practiced::DATE = CURRENT_DATE
    ) THEN
        -- Check if ANY unread reminder already exists (regardless of creation date, limit 1 active reminder)
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id 
        AND (text LIKE v_prefix || '%' OR text LIKE '[Daily Check-in]%')
        AND unread = true;
        
        IF v_unread_count = 0 THEN
             -- Double check: Did we send one TODAY even if read?
            IF NOT EXISTS (
                SELECT 1 FROM public.notifications 
                WHERE user_id = p_user_id 
                AND (text LIKE v_prefix || '%' OR text LIKE '[Daily Check-in]%')
                AND created_at::DATE = CURRENT_DATE
            ) THEN
                INSERT INTO public.notifications (user_id, text, link, unread)
                VALUES (p_user_id, '📅 Daily Check-in available! Maintain your streak & earn rewards.', '/checkin', true);
            END IF;
        END IF;
    ELSE
        -- If they HAVE practiced/checked-in, clear ALL reminders
        DELETE FROM public.notifications WHERE user_id = p_user_id AND (text LIKE v_prefix || '%' OR text LIKE '[Daily Check-in]%') AND unread = true;
    END IF;

    -- ============================================================
    -- Update rate-limit timestamp
    -- ============================================================
    UPDATE public.user_profiles SET last_notif_generated_at = NOW() WHERE id = p_user_id;

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- Clean up: Remove duplicate "Daily Check-in available!" notifications
-- Keep only the most recent one per user
-- ============================================================
DELETE FROM public.notifications 
WHERE id IN (
    SELECT id FROM (
        SELECT id, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at DESC) as rn
        FROM public.notifications
        WHERE text LIKE '📅 Daily Check-in available!%'
        AND unread = true
    ) ranked
    WHERE rn > 1
);
