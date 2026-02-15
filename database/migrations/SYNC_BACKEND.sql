-- ============================================================
-- BACKEND SYNC SCRIPT: Check-in Timezone Fix
-- ============================================================
-- ⚠️ IMPORTANT: Run this in Supabase SQL Editor to fix the 
-- "Could not find function" error.
-- ============================================================

-- 1. Drop old versions to prevent signature conflicts
DROP FUNCTION IF EXISTS public.perform_daily_checkin(UUID);
DROP FUNCTION IF EXISTS public.get_checkin_status(UUID);
DROP FUNCTION IF EXISTS public.record_login_streak(UUID);

-- 2. Create New Version: perform_daily_checkin
CREATE OR REPLACE FUNCTION public.perform_daily_checkin(
    p_user_id UUID,
    p_client_date DATE DEFAULT CURRENT_DATE
)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := p_client_date;
    v_yesterday DATE := p_client_date - 1;
    v_last_checkin DATE;
    v_last_streak INTEGER;
    v_new_streak INTEGER;
    v_base_points INTEGER;
    v_bonus_points INTEGER := 0;
    v_total_points INTEGER;
    v_idem_key TEXT;
    v_month_checkins INTEGER;
BEGIN
    -- Already checked in today?
    IF EXISTS (SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today) THEN
        RETURN (
            SELECT jsonb_build_object(
                'success', false,
                'reason', 'already_checked_in',
                'streak_day', streak_day,
                'points_awarded', points_awarded,
                'bonus_points', bonus_points
            ) FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today
        );
    END IF;

    -- Get last checkin info
    SELECT checkin_date, streak_day INTO v_last_checkin, v_last_streak
    FROM public.user_checkins
    WHERE user_id = p_user_id
    ORDER BY checkin_date DESC
    LIMIT 1;

    -- Calculate streak
    IF v_last_checkin = v_yesterday THEN
        v_new_streak := COALESCE(v_last_streak, 0) + 1;
    ELSE
        v_new_streak := 1; -- Reset streak
    END IF;

    IF v_new_streak > 30 THEN
        v_new_streak := 1;
    END IF;

    -- 30-Day Blueprint
    CASE
        WHEN v_new_streak BETWEEN 1 AND 6 THEN v_base_points := 10;
        WHEN v_new_streak = 7 THEN v_base_points := 10; v_bonus_points := 50;
        WHEN v_new_streak BETWEEN 8 AND 13 THEN v_base_points := 15;
        WHEN v_new_streak = 14 THEN v_base_points := 15; v_bonus_points := 80;
        WHEN v_new_streak BETWEEN 15 AND 20 THEN v_base_points := 20;
        WHEN v_new_streak = 21 THEN v_base_points := 20; v_bonus_points := 120;
        WHEN v_new_streak BETWEEN 22 AND 29 THEN v_base_points := 25;
        WHEN v_new_streak = 30 THEN v_base_points := 25; v_bonus_points := 300;
        ELSE v_base_points := 10;
    END CASE;

    v_total_points := v_base_points + v_bonus_points;

    -- Record checkin
    INSERT INTO public.user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (p_user_id, v_today, v_new_streak, v_base_points, v_bonus_points);

    -- Award points
    v_idem_key := 'checkin_v2_' || p_user_id || '_' || v_today;
    PERFORM public.award_points(p_user_id, v_base_points, 'daily_checkin', NULL, 'Day ' || v_new_streak || ' check-in', v_idem_key);
    IF v_bonus_points > 0 THEN
        PERFORM public.award_points(p_user_id, v_bonus_points, 'checkin_bonus', NULL, 'Day ' || v_new_streak || ' milestone bonus!', v_idem_key || '_bonus');
    END IF;

    -- Sync streak
    UPDATE public.user_profiles SET streak_days = v_new_streak WHERE id = p_user_id;

    -- Count month
    SELECT COUNT(*) INTO v_month_checkins FROM public.user_checkins
    WHERE user_id = p_user_id
    AND EXTRACT(YEAR FROM checkin_date) = EXTRACT(YEAR FROM v_today)
    AND EXTRACT(MONTH FROM checkin_date) = EXTRACT(MONTH FROM v_today);

    RETURN jsonb_build_object(
        'success', true,
        'streak_day', v_new_streak,
        'base_points', v_base_points,
        'bonus_points', v_bonus_points,
        'total_points', v_total_points,
        'month_checkins', v_month_checkins,
        'is_milestone', v_bonus_points > 0
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Create New Version: get_checkin_status
CREATE OR REPLACE FUNCTION public.get_checkin_status(
    p_user_id UUID,
    p_client_date DATE DEFAULT CURRENT_DATE
)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := p_client_date;
    v_checked_in BOOLEAN;
    v_streak INTEGER;
    v_month_calendar JSONB;
    v_month_count INTEGER;
BEGIN
    SELECT EXISTS (SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today) INTO v_checked_in;

    SELECT COALESCE(streak_day, 0) INTO v_streak
    FROM public.user_checkins WHERE user_id = p_user_id ORDER BY checkin_date DESC LIMIT 1;

    SELECT COALESCE(jsonb_agg(jsonb_build_object(
        'date', checkin_date,
        'streak_day', streak_day,
        'points', points_awarded + bonus_points,
        'is_milestone', bonus_points > 0
    ) ORDER BY checkin_date), '[]'::jsonb) INTO v_month_calendar
    FROM public.user_checkins
    WHERE user_id = p_user_id
    AND EXTRACT(YEAR FROM checkin_date) = EXTRACT(YEAR FROM v_today)
    AND EXTRACT(MONTH FROM checkin_date) = EXTRACT(MONTH FROM v_today);

    SELECT COUNT(*) INTO v_month_count
    FROM public.user_checkins
    WHERE user_id = p_user_id
    AND EXTRACT(YEAR FROM checkin_date) = EXTRACT(YEAR FROM v_today)
    AND EXTRACT(MONTH FROM checkin_date) = EXTRACT(MONTH FROM v_today);

    RETURN jsonb_build_object(
        'checked_in_today', v_checked_in,
        'current_streak', CASE WHEN v_checked_in THEN v_streak ELSE 0 END,
        'month_checkins', v_month_count,
        'month_calendar', v_month_calendar
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Create New Version: record_login_streak
CREATE OR REPLACE FUNCTION public.record_login_streak(
    p_user_id UUID,
    p_client_date DATE DEFAULT CURRENT_DATE
)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := p_client_date;
    v_yesterday DATE := p_client_date - 1;
    v_last_login DATE;
    v_old_streak INTEGER;
    v_new_streak INTEGER;
    v_points INTEGER := 10;
    v_idem_key TEXT;
    v_already_logged BOOLEAN;
BEGIN
    SELECT last_login_at::DATE = v_today INTO v_already_logged FROM public.user_profiles WHERE id = p_user_id;

    IF v_already_logged THEN
        SELECT streak_days INTO v_old_streak FROM public.user_profiles WHERE id = p_user_id;
        RETURN jsonb_build_object('success', false, 'reason', 'already_logged_today', 'streak', COALESCE(v_old_streak, 0), 'points', 0);
    END IF;

    SELECT streak_days, last_login_at::DATE INTO v_old_streak, v_last_login FROM public.user_profiles WHERE id = p_user_id;

    IF v_last_login = v_yesterday THEN
        v_new_streak := COALESCE(v_old_streak, 0) + 1;
    ELSE
        v_new_streak := 1;
    END IF;

    UPDATE public.user_profiles SET streak_days = v_new_streak, last_login_at = NOW() WHERE id = p_user_id;

    v_idem_key := 'login_streak_v2_' || p_user_id || '_' || v_today;
    PERFORM public.award_points(p_user_id, v_points, 'login_streak', NULL, 'Daily login streak Day ' || v_new_streak, v_idem_key);

    RETURN jsonb_build_object('success', true, 'streak', v_new_streak, 'points', v_points);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
