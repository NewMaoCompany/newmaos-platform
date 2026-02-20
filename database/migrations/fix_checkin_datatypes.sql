-- ============================================================
-- Fix Datatypes for interval subtraction without breaking repair rules
-- ============================================================

-- Function to perfectly calculate continuous streak up to a specific date
CREATE OR REPLACE FUNCTION get_streak_for_date(p_user_id UUID, p_target_date DATE)
RETURNS INTEGER AS $$
DECLARE
    v_streak INTEGER := 0;
    v_current_date DATE := p_target_date;
BEGIN
    WHILE EXISTS (SELECT 1 FROM user_checkins WHERE user_id = p_user_id AND checkin_date = v_current_date) LOOP
        v_streak := v_streak + 1;
        v_current_date := v_current_date - INTERVAL '1 day';
    END LOOP;
    RETURN v_streak;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- Overhaul perform_daily_checkin
CREATE OR REPLACE FUNCTION public.perform_daily_checkin(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_yesterday DATE := CURRENT_DATE - 1;
    v_streak INTEGER;
    v_base_points INTEGER;
    v_multiplier NUMERIC;
    v_total_points INTEGER;
    v_idem_key TEXT;
    v_month_checkins INTEGER;
BEGIN
    -- Already checked in today?
    IF EXISTS (SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today) THEN
        RETURN jsonb_build_object('success', false, 'reason', 'already_checked_in');
    END IF;

    -- Calculate TRUE streak based on unbroken history ending yesterday
    v_streak := get_streak_for_date(p_user_id, v_yesterday) + 1;

    -- Calculate Base Points: Starts at 10, +5 every 7 days, max 30.
    v_base_points := LEAST(30, 10 + FLOOR((v_streak - 1) / 7) * 5);

    -- Calculate Multiplier: Starts at 1.0, +0.1 per day, max 2.0.
    v_multiplier := LEAST(2.0, 1.0 + (v_streak - 1) * 0.1);

    -- Total
    v_total_points := ROUND(v_base_points * v_multiplier);

    -- Record checkin
    INSERT INTO public.user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (p_user_id, v_today, v_streak, v_total_points, 0);

    -- Award points
    v_idem_key := 'checkin_' || p_user_id || '_' || v_today;
    PERFORM public.award_points(p_user_id, v_total_points, 'daily_checkin', NULL, 'Day ' || v_streak || ' check-in', v_idem_key);

    -- Sync profile
    UPDATE public.user_profiles SET streak_days = v_streak WHERE id = p_user_id;

    -- Count Month
    SELECT COUNT(*) INTO v_month_checkins FROM public.user_checkins
    WHERE user_id = p_user_id AND date_trunc('month', checkin_date) = date_trunc('month', v_today);

    RETURN jsonb_build_object(
        'success', true,
        'streak_day', v_streak,
        'base_points', v_base_points,
        'multiplier', v_multiplier,
        'total_points', v_total_points,
        'month_checkins', v_month_checkins
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- Update get_checkin_status to return repair cost info
DROP FUNCTION IF EXISTS public.get_checkin_status(uuid, date);
DROP FUNCTION IF EXISTS public.get_checkin_status(uuid);
CREATE OR REPLACE FUNCTION public.get_checkin_status(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_checked_in BOOLEAN;
    v_streak INTEGER;
    v_month_calendar JSONB;
    v_month_count INTEGER;
    v_repairs_this_month INTEGER;
BEGIN
    -- Today's status
    SELECT EXISTS (SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today) INTO v_checked_in;

    -- Current true streak
    IF v_checked_in THEN
        v_streak := get_streak_for_date(p_user_id, v_today);
    ELSE
        v_streak := get_streak_for_date(p_user_id, (v_today - INTERVAL '1 day')::DATE);
    END IF;

    -- Calendar
    SELECT COALESCE(jsonb_agg(jsonb_build_object(
        'date', checkin_date,
        'streak_day', streak_day,
        'points', points_awarded + bonus_points,
        'is_milestone', false
    ) ORDER BY checkin_date), '[]'::jsonb) INTO v_month_calendar
    FROM public.user_checkins
    WHERE user_id = p_user_id
    AND date_trunc('month', checkin_date) = date_trunc('month', v_today);

    SELECT COUNT(*) INTO v_month_count FROM public.user_checkins
    WHERE user_id = p_user_id AND date_trunc('month', checkin_date) = date_trunc('month', v_today);

    SELECT COUNT(*) INTO v_repairs_this_month FROM points_ledger
    WHERE user_id = p_user_id AND type = 'streak_repair' AND date_trunc('month', created_at) = date_trunc('month', v_today);

    RETURN jsonb_build_object(
        'checked_in_today', v_checked_in,
        'current_streak', v_streak,
        'month_checkins', v_month_count,
        'month_calendar', v_month_calendar,
        'next_repair_cost', 100 * power(2, v_repairs_this_month)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
