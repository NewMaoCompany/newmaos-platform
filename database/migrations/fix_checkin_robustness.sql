-- ============================================================
-- Fix Check-in Robustness & Reward Consistency
-- 
-- 1. Robust Streak Calculation: Uses walk-back instead of fragile column lookup.
-- 2. Timezone Support: Maintains p_client_date support from SYNC_BACKEND.
-- 3. Unified Reward Scaling: matches the logic expected by users.
-- ============================================================

-- Ensure helper function exists
CREATE OR REPLACE FUNCTION get_streak_for_date(p_user_id UUID, p_target_date DATE)
RETURNS INTEGER AS $$
DECLARE
    v_streak INTEGER := 0;
    v_current_date DATE := p_target_date;
BEGIN
    WHILE EXISTS (SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_current_date) LOOP
        v_streak := v_streak + 1;
        v_current_date := v_current_date - INTERVAL '1 day';
    END LOOP;
    RETURN v_streak;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- Overhaul perform_daily_checkin
CREATE OR REPLACE FUNCTION public.perform_daily_checkin(
    p_user_id UUID,
    p_client_date DATE DEFAULT CURRENT_DATE
)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := p_client_date;
    v_yesterday DATE := p_client_date - 1;
    v_streak INTEGER;
    v_base_points INTEGER;
    v_multiplier NUMERIC;
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
                'base_points', points_awarded, -- Map awarded points back to base for UI
                'total_points', points_awarded + bonus_points
            ) FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today
        );
    END IF;

    -- Calculate ROBUST streak based on unbroken history ending yesterday
    v_streak := get_streak_for_date(p_user_id, v_yesterday) + 1;

    -- Calculate Base Points: 10, 15, 20, 25 based on streak milestones (1, 8, 15, 22)
    -- This matches the LEAST(30, 10 + FLOOR((v_streak - 1) / 7) * 5) logic from v2
    v_base_points := LEAST(30, 10 + FLOOR((v_streak - 1) / 7) * 5);

    -- Calculate Multiplier: Starts at 1.0, +0.1 per day, max 2.0.
    v_multiplier := LEAST(2.0, 1.0 + (v_streak - 1) * 0.1);

    -- Total
    v_total_points := ROUND(v_base_points * v_multiplier);

    -- Record checkin
    INSERT INTO public.user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (p_user_id, v_today, v_streak, v_total_points, 0);

    -- Award points
    v_idem_key := 'checkin_rob_' || p_user_id || '_' || v_today;
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
        'month_checkins', v_month_checkins,
        'is_milestone', false -- Milestones are handled via multiplier in v2
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- Robust get_checkin_status
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
    v_repairs_this_month INTEGER;
BEGIN
    -- Today's status
    SELECT EXISTS (SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today) INTO v_checked_in;

    -- Current true streak (ROBUST)
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
        'is_milestone', bonus_points > 0
    ) ORDER BY checkin_date), '[]'::jsonb) INTO v_month_calendar
    FROM public.user_checkins
    WHERE user_id = p_user_id
    AND date_trunc('month', checkin_date) = date_trunc('month', v_today);

    SELECT COUNT(*) INTO v_month_count FROM public.user_checkins
    WHERE user_id = p_user_id AND date_trunc('month', checkin_date) = date_trunc('month', v_today);

    SELECT COUNT(*) INTO v_repairs_this_month FROM points_ledger
    WHERE user_id = p_user_id AND type = 'streak_repair' AND date_trunc('month', created_at) = date_trunc('month', (v_today || ' 00:00:00')::timestamp);

    RETURN jsonb_build_object(
        'checked_in_today', v_checked_in,
        'current_streak', v_streak,
        'month_checkins', v_month_count,
        'month_calendar', v_month_calendar,
        'next_repair_cost', 100 * power(2, v_repairs_this_month)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
