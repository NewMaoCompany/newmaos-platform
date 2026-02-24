-- ============================================================
-- Migration: Notification Bulk Generation (Cron-based) v2
-- Description: Fixes a critical bug where loyal users who checked
--              in yesterday were not receiving today's check-in reminder.
--              Now unconditionally creates 1 check-in reminder per day
--              for active users, deleting stale ones.
-- ============================================================

CREATE OR REPLACE FUNCTION public.generate_daily_notifications_bulk()
RETURNS VOID AS $$
DECLARE
    r RECORD;
    r_topic RECORD;
    v_accuracy NUMERIC;
    v_solved INTEGER;
    v_seconds BIGINT;
    v_minutes INTEGER;
    v_streak INTEGER;
    v_sub_tier TEXT;
    v_sub_end TIMESTAMPTZ;
    v_prefix TEXT;
    v_new_val TEXT;
    v_unread_count INTEGER;
    v_has_practiced_yesterday BOOLEAN;
    v_has_checked_in_yesterday BOOLEAN;
    v_user_balance INTEGER;
    v_target_date DATE := CURRENT_DATE - INTERVAL '1 day';
BEGIN
    -- Prevent overlapping executions
    IF NOT pg_try_advisory_xact_lock(hashtext('generate_daily_notifications_bulk')) THEN
        RAISE NOTICE 'Skipping execution: Locked by another transaction.';
        RETURN;
    END IF;

    -- Loop through all active users (users who have a profile)
    FOR r IN SELECT id FROM public.user_profiles LOOP
        
        -- ============================================================
        -- FETCH DATA FOR USER
        -- ============================================================
        SELECT accuracy_rate, unique_questions_attempted, total_time_spent_seconds 
        INTO v_accuracy, v_solved, v_seconds
        FROM public.user_stats
        WHERE user_id = r.id;
        
        SELECT streak_days, subscription_tier, subscription_period_end 
        INTO v_streak, v_sub_tier, v_sub_end 
        FROM public.user_profiles WHERE id = r.id;

        -- Check if user practiced YESTERDAY
        v_has_practiced_yesterday := EXISTS (
            SELECT 1 FROM public.user_stats 
            WHERE user_id = r.id 
            AND last_practiced IS NOT NULL
            AND last_practiced::DATE = v_target_date
        );

        -- Check if user checked in YESTERDAY (Manual check-in)
        v_has_checked_in_yesterday := EXISTS (
            SELECT 1 FROM public.user_checkins
            WHERE user_id = r.id
            AND checkin_date = v_target_date
        );

        -- Get user points balance
        SELECT balance INTO v_user_balance
        FROM public.user_points WHERE user_id = r.id;
        v_user_balance := COALESCE(v_user_balance, 0);

        -- ============================================================
        -- ANALYSIS NOTIFICATIONS (4 items) — only if practiced yesterday
        -- ============================================================
        IF v_has_practiced_yesterday AND v_solved IS NOT NULL AND v_solved > 0 THEN

            -- 1. ACCURACY
            v_prefix := '[Analysis - Accuracy]';
            v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
            
            IF NOT EXISTS (
                SELECT 1 FROM public.notifications 
                WHERE user_id = r.id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE
            ) THEN
                INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                VALUES (r.id, v_prefix || ' ' || v_new_val, '/analysis', true, CURRENT_TIMESTAMP);
            END IF;

            -- 2. SOLVED
            v_prefix := '[Analysis - Solved]';
            v_new_val := COALESCE(v_solved, 0)::TEXT;
            
            IF NOT EXISTS (
                SELECT 1 FROM public.notifications 
                WHERE user_id = r.id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE
            ) THEN
                INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                VALUES (r.id, v_prefix || ' ' || v_new_val, '/analysis', true, CURRENT_TIMESTAMP);
            END IF;

            -- 3. STUDY TIME
            v_prefix := '[Analysis - Time]';
            v_minutes := COALESCE((v_seconds / 60)::INTEGER, 0);
            v_new_val := v_minutes || 'm';

            IF NOT EXISTS (
                SELECT 1 FROM public.notifications 
                WHERE user_id = r.id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE
            ) THEN
                INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                VALUES (r.id, v_prefix || ' ' || v_new_val, '/analysis', true, CURRENT_TIMESTAMP);
            END IF;

            -- 4. STREAK
            v_prefix := '[Analysis - Streak]';
            v_new_val := COALESCE(v_streak, 0) || ' days';

            IF NOT EXISTS (
                SELECT 1 FROM public.notifications 
                WHERE user_id = r.id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE
            ) THEN
                INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                VALUES (r.id, v_prefix || ' ' || v_new_val, '/analysis', true, CURRENT_TIMESTAMP);
            END IF;

        END IF;

        -- ============================================================
        -- MEMBERSHIP NOTIFICATION — conditional
        -- ============================================================
        v_prefix := '[Membership]';
        
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = r.id AND text LIKE v_prefix || '%' AND created_at::DATE = CURRENT_DATE
        ) THEN
            IF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NOT NULL AND v_sub_end < NOW()) THEN
                INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                VALUES (r.id, v_prefix || ' Your Pro plan has ended. Click here to renew!', '/settings/subscription', true, CURRENT_TIMESTAMP);

            ELSIF COALESCE(v_sub_tier, 'basic') = 'basic' AND v_user_balance >= 199 THEN
                SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
                WHERE user_id = r.id AND text LIKE v_prefix || '%' AND unread = true;
                
                IF v_unread_count = 0 THEN
                    INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                    VALUES (r.id, v_prefix || ' You have enough coins to upgrade to Pro! Redeem now.', '/settings/subscription', true, CURRENT_TIMESTAMP);
                END IF;
            END IF;
        END IF;

        -- ============================================================
        -- PRACTICE ERROR REVIEW NOTIFICATIONS (Dynamic per topic)
        -- Maps sessionTopic (e.g. 'Limits') to frontend route ID (e.g. 'Both_Limits')
        -- ============================================================
        -- Find all algorithmic sessions for this user that have currentIncorrectIds
        FOR r_topic IN 
            SELECT DISTINCT 
                CASE 
                    -- Already has correct prefix (Both_ or BC_)
                    WHEN data->>'sessionTopic' LIKE 'Both_%' OR data->>'sessionTopic' LIKE 'BC_%'
                        THEN data->>'sessionTopic'
                    -- Map short topic names to their full prefixed IDs
                    WHEN data->>'sessionTopic' IN ('Limits','Derivatives','Composite','Applications','Analytical','Integration','DiffEq','AppIntegration')
                        THEN 'Both_' || (data->>'sessionTopic')
                    ELSE NULL
                END as topic_id
            FROM public.user_section_progress
            WHERE user_id = r.id
              AND entity_type = 'algorithmic'
              AND (data->>'currentIncorrectIds') IS NOT NULL
              AND (data->>'currentIncorrectIds') <> '[]'
              AND length(data->>'currentIncorrectIds') > 4
              AND data->>'sessionTopic' IS NOT NULL
        LOOP
            -- Skip rows where topic_id mapping returned NULL (e.g. 'General', 'Calculus AB')
            IF r_topic.topic_id IS NULL THEN
                CONTINUE;
            END IF;

            v_prefix := '[Practice - Review]';
            
            -- Prevent duplicate generation: only skip if an UNREAD one exists for today
            IF NOT EXISTS (
                SELECT 1 FROM public.notifications 
                WHERE user_id = r.id 
                AND text LIKE v_prefix || '%'
                AND link = '/practice/unit/' || r_topic.topic_id
                AND created_at::DATE = CURRENT_DATE
                AND unread = true
            ) THEN
                -- Delete older notifications for this exact topic (both read and unread)
                DELETE FROM public.notifications 
                WHERE user_id = r.id 
                AND text LIKE v_prefix || '%'
                AND link = '/practice/unit/' || r_topic.topic_id;

                -- Insert new reminder for today
                INSERT INTO public.notifications (user_id, text, link, unread, created_at)
                VALUES (r.id, v_prefix || ' You have pending mistakes to review. Fix them to boost your mastery!', '/practice/unit/' || r_topic.topic_id, true, CURRENT_TIMESTAMP);
            END IF;
        END LOOP;

        -- ============================================================
        -- DAILY CHECK-IN REMINDER 
        -- Creates a reminder for TODAY at 00:00 AM for EVERY user.
        -- We no longer check "did they check in yesterday" to suppress it,
        -- because everyone (active or not) needs a new check-in reminder 
        -- for the new day!
        -- ============================================================
        v_prefix := '📅 Daily Check-in available!';
        
        -- Prevent duplicate generation on the SAME day
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = r.id 
            AND (text LIKE v_prefix || '%' OR text LIKE '[Daily Check-in]%')
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            -- Delete old unread reminders from previous days to avoid clutter
            DELETE FROM public.notifications 
            WHERE user_id = r.id 
            AND (text LIKE v_prefix || '%' OR text LIKE '[Daily Check-in]%') 
            AND unread = true;

            -- Insert new reminder for today
            INSERT INTO public.notifications (user_id, text, link, unread, created_at)
            VALUES (r.id, '📅 Daily Check-in available! Maintain your streak & earn rewards.', '/checkin', true, CURRENT_TIMESTAMP);
        END IF;

    END LOOP;

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
