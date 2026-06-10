CREATE OR REPLACE FUNCTION get_user_badges(p_user_id UUID)
RETURNS JSON AS $$
DECLARE
    v_has_checked_in BOOLEAN;
    v_dashboard_badge BOOLEAN;
    v_practice_badge BOOLEAN;
    v_analysis_badge BOOLEAN;
    v_forum_unread_count INT;
    v_settings_badge BOOLEAN;
    v_profile RECORD;
BEGIN
    -- 1. Get user profile data
    SELECT * INTO v_profile FROM public.user_profiles WHERE id = p_user_id;

    -- 2. Dashboard Badge (Check-in)
    -- Fix: Check user_checkins table instead of points_ledger with incorrect type
    SELECT EXISTS (
        SELECT 1 FROM public.user_checkins 
        WHERE user_id = p_user_id AND checkin_date = CURRENT_DATE
    ) INTO v_has_checked_in;
    
    -- Fallback: Also check points_ledger for 'daily_checkin' type just in case
    IF NOT v_has_checked_in THEN
        SELECT EXISTS (
            SELECT 1 FROM public.points_ledger 
            WHERE user_id = p_user_id AND type IN ('daily_checkin', 'login_streak') AND DATE(created_at) = CURRENT_DATE
        ) INTO v_has_checked_in;
    END IF;

    v_dashboard_badge := NOT v_has_checked_in;

    -- 3. Practice Badge (Recommendations)
    IF DATE(COALESCE(v_profile.last_practice_rec_view_time, '1970-01-01'::DATE)) < CURRENT_DATE THEN
        v_practice_badge := true;
    ELSE
        v_practice_badge := false;
    END IF;

    -- 4. Analysis Badge
    SELECT EXISTS (
        SELECT 1 FROM public.question_attempts 
        WHERE user_id = p_user_id 
        AND created_at > COALESCE(v_profile.last_analysis_view_time, '1970-01-01'::TIMESTAMPTZ)
    ) INTO v_analysis_badge;

    -- 5. Forum Badge
    SELECT COUNT(*) INTO v_forum_unread_count
    FROM public.activities
    WHERE user_id = p_user_id
    AND created_at > COALESCE(v_profile.last_forum_read_time, '1970-01-01'::TIMESTAMPTZ)
    AND type IN ('forum_reply', 'forum_like', 'forum_mention', 'friend_request', 'friend_accept');

    -- 6. Settings Badge
    IF v_profile.subscription_tier = 'basic' AND COALESCE(v_profile.last_pro_reminder_date, '1970-01-01'::DATE) < CURRENT_DATE THEN
        v_settings_badge := true;
    ELSE
        v_settings_badge := false;
    END IF;

    -- Return as JSON
    RETURN json_build_object(
        'dashboard', v_dashboard_badge,
        'practice', v_practice_badge,
        'analysis', v_analysis_badge,
        'forum', v_forum_unread_count,
        'settings', v_settings_badge,
        'has_claimed_welcome_gift', COALESCE(v_profile.has_claimed_welcome_gift, false)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
