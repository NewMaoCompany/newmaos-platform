-- ============================================================
-- Check-in System v1
-- Creates: user_checkins table + perform_daily_checkin RPC
-- 30-Day Blueprint with Tiered Rewards
-- ============================================================

-- 1. CHECK-IN TABLE
CREATE TABLE IF NOT EXISTS public.user_checkins (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    checkin_date DATE NOT NULL DEFAULT CURRENT_DATE,
    streak_day INTEGER NOT NULL DEFAULT 1,
    points_awarded INTEGER NOT NULL DEFAULT 0,
    bonus_points INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, checkin_date)
);

CREATE INDEX IF NOT EXISTS idx_checkins_user_date ON public.user_checkins(user_id, checkin_date DESC);

-- Enable RLS
ALTER TABLE public.user_checkins ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own checkins" ON public.user_checkins
    FOR SELECT USING (auth.uid() = user_id);

-- ============================================================
-- 2. RPC: perform_daily_checkin
-- 30-Day Blueprint:
--   Day 1-6:   10 pts/day
--   Day 7:     10 + 50 bonus (Week 1 Milestone)
--   Day 8-13:  15 pts/day
--   Day 14:    15 + 80 bonus (2-Week Milestone)
--   Day 15-20: 20 pts/day
--   Day 21:    20 + 120 bonus (3-Week Milestone)
--   Day 22-29: 25 pts/day
--   Day 30:    25 + 300 bonus (Monthly Champion!)
-- ============================================================
CREATE OR REPLACE FUNCTION public.perform_daily_checkin(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_yesterday DATE := CURRENT_DATE - 1;
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
        -- Return existing checkin info
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

    -- Cap at 30 for blueprint cycle, then restart
    IF v_new_streak > 30 THEN
        v_new_streak := 1;
    END IF;

    -- 30-Day Blueprint: Calculate base + bonus
    CASE
        WHEN v_new_streak BETWEEN 1 AND 6 THEN
            v_base_points := 10;
        WHEN v_new_streak = 7 THEN
            v_base_points := 10;
            v_bonus_points := 50;
        WHEN v_new_streak BETWEEN 8 AND 13 THEN
            v_base_points := 15;
        WHEN v_new_streak = 14 THEN
            v_base_points := 15;
            v_bonus_points := 80;
        WHEN v_new_streak BETWEEN 15 AND 20 THEN
            v_base_points := 20;
        WHEN v_new_streak = 21 THEN
            v_base_points := 20;
            v_bonus_points := 120;
        WHEN v_new_streak BETWEEN 22 AND 29 THEN
            v_base_points := 25;
        WHEN v_new_streak = 30 THEN
            v_base_points := 25;
            v_bonus_points := 300;
        ELSE
            v_base_points := 10;
    END CASE;

    v_total_points := v_base_points + v_bonus_points;

    -- Record checkin
    INSERT INTO public.user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (p_user_id, v_today, v_new_streak, v_base_points, v_bonus_points);

    -- Award points via award_points RPC (idempotent)
    v_idem_key := 'checkin_' || p_user_id || '_' || v_today;
    PERFORM public.award_points(
        p_user_id, v_base_points, 'daily_checkin',
        NULL, 'Day ' || v_new_streak || ' check-in',
        v_idem_key
    );

    -- Award bonus if any
    IF v_bonus_points > 0 THEN
        PERFORM public.award_points(
            p_user_id, v_bonus_points, 'checkin_bonus',
            NULL, 'Day ' || v_new_streak || ' milestone bonus!',
            v_idem_key || '_bonus'
        );
    END IF;

    -- Sync streak_days in user_profiles
    UPDATE public.user_profiles
    SET streak_days = v_new_streak
    WHERE id = p_user_id;

    -- Count this month's checkins
    SELECT COUNT(*) INTO v_month_checkins
    FROM public.user_checkins
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

-- ============================================================
-- 3. RPC: get_checkin_status
-- ============================================================
CREATE OR REPLACE FUNCTION public.get_checkin_status(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_checked_in BOOLEAN;
    v_streak INTEGER;
    v_month_calendar JSONB;
    v_month_count INTEGER;
BEGIN
    -- Today's status
    SELECT EXISTS (
        SELECT 1 FROM public.user_checkins WHERE user_id = p_user_id AND checkin_date = v_today
    ) INTO v_checked_in;

    -- Current streak
    SELECT COALESCE(streak_day, 0) INTO v_streak
    FROM public.user_checkins
    WHERE user_id = p_user_id
    ORDER BY checkin_date DESC
    LIMIT 1;

    -- This month's checkin dates
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
