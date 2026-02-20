-- ============================================================
-- Check-in System v2 (Massive Overhaul)
-- Features: 
-- 1. Base reward scaling (10 -> 30, +5 per 7-day milestone)
-- 2. Multiplier scaling (1.0x -> 2.0x, +0.1 per day)
-- 3. Retroactive specific-day repair with scaling cost (100 * 2^n)
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


-- Retroactive Repair RPC
DROP FUNCTION IF EXISTS public.repair_specific_day(uuid, date);
CREATE OR REPLACE FUNCTION public.repair_specific_day(user_uuid UUID, target_date DATE)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_balance INTEGER;
    v_repairs_this_month INTEGER;
    v_cost INTEGER;
    v_streak_at_target INTEGER;
    v_base_points INTEGER;
    v_multiplier NUMERIC;
    v_total_points INTEGER;
    v_idem_key TEXT;
    v_new_current_streak INTEGER;
BEGIN
    -- 1. Validation
    IF target_date >= v_today THEN
        RETURN jsonb_build_object('success', false, 'message', 'Cannot repair today or future dates.');
    END IF;

    IF EXISTS (SELECT 1 FROM user_checkins WHERE user_id = user_uuid AND checkin_date = target_date) THEN
        RETURN jsonb_build_object('success', false, 'message', 'Date already checked in.');
    END IF;

    -- 2. Cost calculation based on monthly repairs
    SELECT COUNT(*) INTO v_repairs_this_month
    FROM points_ledger
    WHERE user_id = user_uuid 
      AND type = 'streak_repair'
      AND date_trunc('month', created_at) = date_trunc('month', v_today);

    v_cost := 100 * power(2, v_repairs_this_month);

    -- 3. Balance Check
    SELECT balance INTO v_balance FROM user_points WHERE user_id = user_uuid;
    IF v_balance < v_cost THEN
        RETURN jsonb_build_object('success', false, 'reason', 'insufficient_points', 'required', v_cost);
    END IF;

    -- 4. Deduct and record cost
    UPDATE user_points SET balance = balance - v_cost, updated_at = NOW() WHERE user_id = user_uuid;
    INSERT INTO points_ledger (user_id, amount, type, description)
    VALUES (user_uuid, -v_cost, 'streak_repair', 'Streak restoration for ' || target_date);

    -- 5. Calculate retroactive stats for that specific day
    v_streak_at_target := get_streak_for_date(user_uuid, (target_date - INTERVAL '1 day')::DATE) + 1;
    v_base_points := LEAST(30, 10 + FLOOR((v_streak_at_target - 1) / 7) * 5);
    v_multiplier := LEAST(2.0, 1.0 + (v_streak_at_target - 1) * 0.1);
    v_total_points := ROUND(v_base_points * v_multiplier);

    -- 6. Insert retroactive checkin
    INSERT INTO user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (user_uuid, target_date, v_streak_at_target, v_total_points, 0);

    -- 7. Award retroactive points
    v_idem_key := 'repair_' || user_uuid || '_' || target_date;
    PERFORM public.award_points(user_uuid, v_total_points, 'daily_checkin', NULL, 'Retroactive Day ' || v_streak_at_target || ' check-in', v_idem_key);

    -- 8. Recalculate CURRENT streak
    v_new_current_streak := get_streak_for_date(user_uuid, v_today);
    IF NOT EXISTS (SELECT 1 FROM user_checkins WHERE user_id = user_uuid AND checkin_date = v_today) THEN
        v_new_current_streak := get_streak_for_date(user_uuid, (v_today - INTERVAL '1 day')::DATE);
    END IF;

    UPDATE user_profiles SET streak_days = v_new_current_streak WHERE id = user_uuid;

    RETURN jsonb_build_object(
        'success', true,
        'cost', v_cost,
        'retroactive_points', v_total_points,
        'new_current_streak', v_new_current_streak
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- Update get_checkin_status to return repair cost info
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
