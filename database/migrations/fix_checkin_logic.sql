-- Fix handle_daily_login to ONLY update streak (login streak), NOT check-in.
DROP FUNCTION IF EXISTS handle_daily_login(UUID, TEXT);

CREATE OR REPLACE FUNCTION handle_daily_login(user_uuid UUID, p_timezone TEXT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_last_login TIMESTAMPTZ;
    v_current_streak INTEGER;
    v_now TIMESTAMPTZ := NOW();
    v_yesterday DATE;
    v_today DATE;
    v_last_login_local DATE;
    v_new_streak INTEGER;
BEGIN
    -- Get current user data
    SELECT last_login_at, streak_days INTO v_last_login, v_current_streak
    FROM user_profiles
    WHERE id = user_uuid;

    -- Handle Timezones
    v_today := (v_now AT TIME ZONE p_timezone)::DATE;
    
    IF v_last_login IS NULL THEN
        -- First login
        v_new_streak := 1;
    ELSE
        v_last_login_local := (v_last_login AT TIME ZONE p_timezone)::DATE;
        v_yesterday := v_today - 1;

        IF v_last_login_local = v_today THEN
            -- Already logged in today, keep streak
            v_new_streak := v_current_streak;
        ELSIF v_last_login_local = v_yesterday THEN
            -- Logged in yesterday, increment streak
            v_new_streak := v_current_streak + 1;
        ELSE
            -- Missed a day (or more), reset streak
            v_new_streak := 1;
        END IF;
    END IF;

    -- Update user_profiles
    UPDATE user_profiles
    SET 
        last_login_at = v_now,
        streak_days = v_new_streak
    WHERE id = user_uuid;

    -- NOTE: We do NOT insert into user_checkins here. That is for manual check-in.
    
    RETURN jsonb_build_object(
        'success', true,
        'streak', v_new_streak,
        'message', 'Login processed'
    );
END;
$$;
