-- ============================================================
-- Separate Login Streak from Manual Daily Check-in
-- 
-- TWO reward systems:
--   1. record_login_streak: auto on app entry, fixed 10 pts
--   2. perform_daily_checkin: manual button press, 30-day blueprint
-- ============================================================

-- ============================================================
-- 1. RPC: record_login_streak
-- Called automatically when user enters Dashboard/Practice
-- Awards FIXED 10 NMS Points, updates streak in user_profiles
-- Idempotent: only awards once per day
-- ============================================================
CREATE OR REPLACE FUNCTION public.record_login_streak(p_user_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_yesterday DATE := CURRENT_DATE - 1;
    v_last_login DATE;
    v_old_streak INTEGER;
    v_new_streak INTEGER;
    v_points INTEGER := 10;
    v_idem_key TEXT;
    v_already_logged BOOLEAN;
BEGIN
    -- Check if already logged in today (idempotent)
    SELECT last_login_at::DATE = v_today INTO v_already_logged
    FROM public.user_profiles
    WHERE id = p_user_id;

    IF v_already_logged THEN
        -- Already recorded today, just return current info
        SELECT streak_days INTO v_old_streak
        FROM public.user_profiles
        WHERE id = p_user_id;

        RETURN jsonb_build_object(
            'success', false,
            'reason', 'already_logged_today',
            'streak', COALESCE(v_old_streak, 0),
            'points', 0
        );
    END IF;

    -- Get current streak info
    SELECT streak_days, last_login_at::DATE INTO v_old_streak, v_last_login
    FROM public.user_profiles
    WHERE id = p_user_id;

    -- Calculate new streak
    IF v_last_login = v_yesterday THEN
        v_new_streak := COALESCE(v_old_streak, 0) + 1;
    ELSE
        v_new_streak := 1; -- Reset
    END IF;

    -- Update profile
    UPDATE public.user_profiles
    SET streak_days = v_new_streak,
        last_login_at = NOW()
    WHERE id = p_user_id;

    -- Award fixed 10 points (idempotent)
    v_idem_key := 'login_streak_' || p_user_id || '_' || v_today;
    PERFORM public.award_points(
        p_user_id, v_points, 'login_streak',
        NULL, 'Daily login streak Day ' || v_new_streak,
        v_idem_key
    );

    RETURN jsonb_build_object(
        'success', true,
        'streak', v_new_streak,
        'points', v_points
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
