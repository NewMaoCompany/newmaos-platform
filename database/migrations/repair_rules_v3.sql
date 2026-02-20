-- ============================================================
-- Fix missing Enum Value for points_ledger
-- ============================================================
ALTER TABLE public.points_ledger DROP CONSTRAINT IF EXISTS points_ledger_type_check;

ALTER TABLE public.points_ledger ADD CONSTRAINT points_ledger_type_check 
    CHECK (type IN (
        'practice_complete', 'unit_test_complete', 'error_correction',
        'daily_checkin', 'checkin_bonus',
        'like_received', 'comment_received', 'follower_gained', 'friend_added',
        'pro_redeem', 'manual_adjustment',
        'gift_claim', 'streak_repair'
    ));

-- ============================================================
-- Check-in System: Repair Rules v3
-- Fixes:
-- 1. Disallows repairing dates before the user's account creation (created_at).
-- 2. Strictly disallows repairing future dates.
-- 3. Implements standard named parameters (p_user_id, p_target_date).
-- ============================================================

DROP FUNCTION IF EXISTS public.repair_specific_day(uuid, date);

CREATE OR REPLACE FUNCTION public.repair_specific_day(p_user_id UUID, p_target_date DATE)
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
    v_created_at TIMESTAMPTZ;
BEGIN
    -- 1. Validation - Future Dates
    IF p_target_date >= v_today THEN
        RETURN jsonb_build_object('success', false, 'message', 'Cannot repair today or future dates.');
    END IF;

    -- 2. Validation - Before Registration
    SELECT created_at INTO v_created_at FROM auth.users WHERE id = p_user_id;
    IF v_created_at IS NOT NULL AND p_target_date < (v_created_at AT TIME ZONE 'UTC')::DATE THEN
        RETURN jsonb_build_object('success', false, 'message', 'Cannot repair dates before account registration.');
    END IF;

    -- 3. Validation - Already Checked In
    IF EXISTS (SELECT 1 FROM user_checkins WHERE user_id = p_user_id AND checkin_date = p_target_date) THEN
        RETURN jsonb_build_object('success', false, 'message', 'Date already checked in.');
    END IF;

    -- 4. Cost calculation based on monthly repairs
    SELECT COUNT(*) INTO v_repairs_this_month
    FROM points_ledger
    WHERE user_id = p_user_id 
      AND type = 'streak_repair'
      AND date_trunc('month', created_at) = date_trunc('month', v_today);

    v_cost := 100 * power(2, v_repairs_this_month);

    -- 5. Balance Check
    SELECT balance INTO v_balance FROM user_points WHERE user_id = p_user_id;
    IF v_balance < v_cost THEN
        RETURN jsonb_build_object('success', false, 'reason', 'insufficient_points', 'required', v_cost);
    END IF;

    -- 6. Deduct and record cost
    UPDATE user_points SET balance = balance - v_cost, updated_at = NOW() WHERE user_id = p_user_id;
    INSERT INTO points_ledger (user_id, amount, type, description)
    VALUES (p_user_id, -v_cost, 'streak_repair', 'Streak restoration for ' || p_target_date);

    -- 7. Calculate retroactive stats for that specific day
    v_streak_at_target := get_streak_for_date(p_user_id, (p_target_date - INTERVAL '1 day')::DATE) + 1;
    v_base_points := LEAST(30, 10 + FLOOR((v_streak_at_target - 1) / 7) * 5);
    v_multiplier := LEAST(2.0, 1.0 + (v_streak_at_target - 1) * 0.1);
    v_total_points := ROUND(v_base_points * v_multiplier);

    -- 8. Insert retroactive checkin
    INSERT INTO user_checkins (user_id, checkin_date, streak_day, points_awarded, bonus_points)
    VALUES (p_user_id, p_target_date, v_streak_at_target, v_total_points, 0);

    -- 9. Award retroactive points
    v_idem_key := 'repair_' || p_user_id || '_' || p_target_date;
    PERFORM public.award_points(p_user_id, v_total_points, 'daily_checkin', NULL, 'Retroactive Day ' || v_streak_at_target || ' check-in', v_idem_key);

    -- 10. Recalculate CURRENT streak
    v_new_current_streak := get_streak_for_date(p_user_id, v_today);
    
    -- If user hasn't checked in yet TODAY, their active streak displays as yesterday's
    IF NOT EXISTS (SELECT 1 FROM user_checkins WHERE user_id = p_user_id AND checkin_date = v_today) THEN
        v_new_current_streak := get_streak_for_date(p_user_id, (v_today - INTERVAL '1 day')::DATE);
    END IF;

    UPDATE user_profiles SET streak_days = v_new_current_streak WHERE id = p_user_id;

    RETURN jsonb_build_object(
        'success', true,
        'cost', v_cost,
        'retroactive_points', v_total_points,
        'new_current_streak', v_new_current_streak
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
