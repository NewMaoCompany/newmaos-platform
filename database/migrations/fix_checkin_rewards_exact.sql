-- ============================================================
-- Fix Check-in Exact Rewards & Milestone Consistency
-- 
-- 1. Updates calculation exactly to match frontend: min(60, 5 + streak * 5)
-- 2. Adds +10 * streak bonus every 7 days (7, 14, 21...)
-- ============================================================

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
                'base_points', points_awarded,
                'total_points', points_awarded + bonus_points
            ) FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today
        );
    END IF;

    -- Calculate ROBUST streak based on unbroken history ending yesterday
    v_streak := get_streak_for_date(p_user_id, v_yesterday) + 1;

    -- Calculate Reward: min(60, 5 + streak * 5)
    v_base_points := LEAST(60, 5 + (v_streak * 5));

    -- Calculate Milestone Bonus: + (10 * streak) every 7 days
    IF v_streak > 0 AND v_streak % 7 = 0 THEN
        v_bonus_points := v_streak * 10;
    END IF;

    -- Total
    v_total_points := v_base_points + v_bonus_points;

    -- Record checkin
    INSERT INTO public.user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (p_user_id, v_today, v_streak, v_base_points, v_bonus_points);

    -- Award points (Wallet crediting)
    v_idem_key := 'checkin_exact_' || p_user_id || '_' || v_today;
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
        'bonus_points', v_bonus_points,
        'total_points', v_total_points,
        'month_checkins', v_month_checkins,
        'is_milestone', (v_bonus_points > 0)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
