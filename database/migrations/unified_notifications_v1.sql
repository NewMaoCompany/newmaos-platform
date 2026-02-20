-- ============================================================
-- Migration: Unified System Notifications v1
-- Implements the 4-quadrant notification requirements:
-- 1. Dashboard: Daily Check-in reminder if not checked in today.
-- 2. Analysis: Daily stats update if charts changed (last_practiced today).
-- 3. Settings: Pro reminder if balance >= 200 and tier is basic.
-- 4. Auto-Delete: Clean up all notifications older than 3 days.
-- ============================================================

CREATE OR REPLACE FUNCTION public.generate_system_notifications(p_user_id UUID)
RETURNS VOID AS $$
DECLARE
    v_sub_tier TEXT;
    v_sub_end TIMESTAMPTZ;
    v_has_practiced_today BOOLEAN;
    v_has_checked_today BOOLEAN;
    v_user_balance INTEGER;
    v_prefix TEXT;
BEGIN
    -- ============================================================
    -- FETCH CURRENT DATA
    -- ============================================================
    SELECT subscription_tier, subscription_period_end 
    INTO v_sub_tier, v_sub_end 
    FROM public.user_profiles WHERE id = p_user_id;

    -- Check if user has practiced TODAY (charts changed)
    v_has_practiced_today := EXISTS (
        SELECT 1 FROM public.user_stats 
        WHERE user_id = p_user_id 
        AND last_practiced IS NOT NULL
        AND last_practiced::DATE = CURRENT_DATE
    );

    -- Check if user has checked in TODAY
    v_has_checked_today := EXISTS (
        SELECT 1 FROM public.user_checkins
        WHERE user_id = p_user_id
        AND checkin_date = CURRENT_DATE
    );

    -- Get user points balance
    SELECT balance INTO v_user_balance
    FROM public.user_points WHERE user_id = p_user_id;
    IF v_user_balance IS NULL THEN
        v_user_balance := 0;
    END IF;

    -- ============================================================
    -- 1. DASHBOARD: DAILY CHECK-IN REMINDER
    -- If not checked in today, ensure there is exactly 1 reminder today.
    -- If already checked in today, clear any reminders for today.
    -- ============================================================
    v_prefix := '📅 Daily Check-in available!';
    IF NOT v_has_checked_today THEN
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            -- Delete older unread check-in reminders so they don't pile up
            DELETE FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, '📅 Daily Check-in available! Maintain your streak & earn rewards.', '/checkin', true);
        END IF;
    ELSE
        -- Clear if already checked in
        DELETE FROM public.notifications 
        WHERE user_id = p_user_id AND text LIKE v_prefix || '%';
    END IF;

    -- ============================================================
    -- 2. ANALYSIS: DAILY STATS UPDATE
    -- If practiced today, ensure there is exactly 1 analysis update today.
    -- ============================================================
    v_prefix := '📊 Your daily analysis charts have been updated!';
    IF v_has_practiced_today THEN
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            -- Delete previous unread analysis notifications
            DELETE FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
            
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, v_prefix, '/analysis', true);
        END IF;
    END IF;

    -- ============================================================
    -- 3. SETTINGS: MEMBERSHIP REMINDER
    -- If >=200 coins and basic, remind once per day until subscribed.
    -- ============================================================
    v_prefix := '[Membership]';
    IF COALESCE(v_sub_tier, 'basic') = 'basic' AND COALESCE(v_user_balance, 0) >= 200 THEN
        IF NOT EXISTS (
            SELECT 1 FROM public.notifications 
            WHERE user_id = p_user_id 
            AND text LIKE v_prefix || '%'
            AND created_at::DATE = CURRENT_DATE
        ) THEN
            -- Delete old unread membership notifications
            DELETE FROM public.notifications 
            WHERE user_id = p_user_id AND text LIKE v_prefix || '%' AND unread = true;
                
            INSERT INTO public.notifications (user_id, text, link, unread)
            VALUES (p_user_id, '[Membership] You have 200+ coins! Redeem them for a free Pro upgrade.', '/settings/subscription', true);
        END IF;
    ELSE
        -- Clean up if they subscribed or lost coins
        DELETE FROM public.notifications WHERE user_id = p_user_id AND text LIKE v_prefix || '%';
    END IF;

    -- ============================================================
    -- 4. CLEANUP: DELETE ALL NOTIFICATIONS OLDER THAN 3 DAYS
    -- ============================================================
    DELETE FROM public.notifications 
    WHERE user_id = p_user_id 
    AND created_at < NOW() - INTERVAL '3 days';

    -- Cleanup old [Analysis] specific ones we no longer use
    DELETE FROM public.notifications 
    WHERE user_id = p_user_id AND text LIKE '[Analysis - %';

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
