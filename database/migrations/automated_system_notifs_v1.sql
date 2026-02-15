-- Phase 19: Automated System Notifications (Daily & Monthly)
-- This RPC will be called by the frontend to "lazy-trigger" system notifications.

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
BEGIN
    -- CLEANUP OLD LEGACY PREFIX (One-time cleanup)
    DELETE FROM public.notifications 
    WHERE user_id = p_user_id AND text LIKE '[Daily Analysis]%' AND unread = true;

    -- FETCH CURRENT DATA
    SELECT accuracy_rate, unique_questions_attempted, total_time_spent_seconds 
    INTO v_accuracy, v_solved, v_seconds
    FROM public.user_stats
    WHERE user_id = p_user_id;
    
    SELECT streak_days, subscription_tier, subscription_period_end 
    INTO v_streak, v_sub_tier, v_sub_end 
    FROM public.user_profiles WHERE id = p_user_id;

    IF FOUND THEN
        -- 1. ACCURACY
        v_prefix := '[Analysis - Accuracy]';
        v_new_val := ROUND(COALESCE(v_accuracy, 0), 1) || '%';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;

        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        ELSIF v_unread_count > 1 THEN
            DELETE FROM public.notifications WHERE id IN (
                SELECT id FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true ORDER BY created_at DESC OFFSET 1
            );
        END IF;

        -- 2. SOLVED
        v_prefix := '[Analysis - Solved]';
        v_new_val := COALESCE(v_solved, 0)::TEXT;
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;

        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        ELSIF v_unread_count > 1 THEN
            DELETE FROM public.notifications WHERE id IN (
                SELECT id FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true ORDER BY created_at DESC OFFSET 1
            );
        END IF;

        -- 3. STUDY TIME
        v_prefix := '[Analysis - Time]';
        v_minutes := COALESCE((v_seconds / 60)::INTEGER, 0);
        v_new_val := v_minutes || 'm';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;

        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        ELSIF v_unread_count > 1 THEN
            DELETE FROM public.notifications WHERE id IN (
                SELECT id FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true ORDER BY created_at DESC OFFSET 1
            );
        END IF;

        -- 4. STREAK
        v_prefix := '[Analysis - Streak]';
        v_new_val := COALESCE(v_streak, 0) || ' days';
        SELECT text INTO v_last_val FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' ORDER BY created_at DESC LIMIT 1;
        
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;

        IF v_last_val IS NULL OR v_last_val <> (v_prefix || ' ' || v_new_val) THEN
            DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' ' || v_new_val, '/analysis', true);
        ELSIF v_unread_count > 1 THEN
            DELETE FROM public.notifications WHERE id IN (
                SELECT id FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true ORDER BY created_at DESC OFFSET 1
            );
        END IF;
    END IF;

    -- 5. MEMBERSHIP (Strictly 1 unread limit)
    v_prefix := '[Membership]';
    IF COALESCE(v_sub_tier, 'basic') = 'pro' AND (v_sub_end IS NOT NULL AND v_sub_end < NOW()) THEN
        UPDATE public.user_profiles SET subscription_tier = 'basic' WHERE id = p_user_id;
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        INSERT INTO public.notifications (user_id, text, link, unread)
        VALUES (p_user_id, v_prefix || ' Your Pro plan has ended. Click here to renew!', '/settings/subscription', true);
    ELSIF COALESCE(v_sub_tier, 'basic') = 'basic' THEN
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        IF v_unread_count = 0 THEN
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || ' Upgrade to Pro for exclusive features and detailed analysis!', '/settings/subscription', true);
        ELSIF v_unread_count > 1 THEN
            DELETE FROM public.notifications WHERE id IN (
                SELECT id FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true ORDER BY created_at DESC OFFSET 1
            );
        END IF;
    ELSE
        -- Active Pro: Pure cleanup of any accidental unread membership messages
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
    END IF;

    -- 6. DAILY CHECK-IN REMINDER
    v_prefix := '🔔 每日簽到提醒';
    -- Check if user has NOT checked in today
    IF NOT EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id 
        AND last_practiced::DATE = CURRENT_DATE
    ) THEN
        -- Check if an unread reminder already exists
        SELECT COUNT(*) INTO v_unread_count FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
        
        IF v_unread_count = 0 THEN
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix || '：別忘了領取今天的積分獎勵！', '/checkin', true);
        END IF;
    ELSE
        -- If already checked in, clear any existing unread reminders
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
