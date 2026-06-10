-- ============================================================
-- DEFINITIVE FIX: get_user_badges RPC
-- Settings badge: shows whenever user is Basic plan (no date condition)
-- Settings badge ONLY disappears when user upgrades to Pro
-- ============================================================

CREATE OR REPLACE FUNCTION public.get_user_badges(p_user_id UUID)
RETURNS JSON AS $$
DECLARE
    v_dashboard_badge BOOLEAN;
    v_practice_badge BOOLEAN;
    v_analysis_badge BOOLEAN;
    v_forum_unread_count INT;
    v_settings_badge BOOLEAN;
    v_profile RECORD;
    v_forum_details JSON;
BEGIN
    -- 1. Get user profile data
    SELECT * INTO v_profile FROM public.user_profiles WHERE id = p_user_id;

    -- 2. Dashboard Badge: no check-in today
    SELECT NOT EXISTS (
        SELECT 1 FROM public.user_checkins
        WHERE user_id = p_user_id AND checkin_date = CURRENT_DATE
    ) INTO v_dashboard_badge;

    -- 3. Practice Badge: hasn't viewed practice recommendations today
    IF DATE(COALESCE(v_profile.last_practice_rec_view_time, '1970-01-01'::DATE)) < CURRENT_DATE THEN
        v_practice_badge := true;
    ELSE
        v_practice_badge := false;
    END IF;

    -- 4. Analysis Badge: has new question attempts since last analysis view (within 24h)
    SELECT EXISTS (
        SELECT 1 FROM public.question_attempts
        WHERE user_id = p_user_id
        AND created_at > COALESCE(v_profile.last_analysis_view_time, '1970-01-01'::TIMESTAMPTZ)
        AND created_at >= NOW() - INTERVAL '24 hours'
    ) INTO v_analysis_badge;

    -- 5. Forum Badge: unread notifications (chats/channels) + unread activities
    SELECT COALESCE(json_object_agg(id, cnt), '{}'::JSON) INTO v_forum_details
    FROM (
        SELECT COALESCE(chat_id::TEXT, channel_id::TEXT) as id, count(*) as cnt
        FROM public.notifications
        WHERE user_id = p_user_id AND unread = true AND (chat_id IS NOT NULL OR channel_id IS NOT NULL)
        GROUP BY COALESCE(chat_id::TEXT, channel_id::TEXT)
    ) t;

    SELECT COALESCE(SUM(cnt), 0) INTO v_forum_unread_count
    FROM (
        SELECT count(*) as cnt
        FROM public.notifications
        WHERE user_id = p_user_id AND unread = true AND (chat_id IS NOT NULL OR channel_id IS NOT NULL)
        GROUP BY COALESCE(chat_id::TEXT, channel_id::TEXT)
    ) t2;

    v_forum_unread_count := v_forum_unread_count + (
        SELECT COUNT(*)
        FROM public.activities
        WHERE user_id = p_user_id
        AND created_at > COALESCE(v_profile.last_forum_read_time, '1970-01-01'::TIMESTAMPTZ)
        AND type IN ('forum_reply', 'forum_like', 'forum_mention', 'friend_request', 'friend_accept')
    );

    -- 6. Settings Badge: ONLY condition = user is on Basic plan
    -- This badge NEVER disappears from just viewing Settings or dismissing popups
    -- It ONLY goes away when the user successfully upgrades to Pro
    IF COALESCE(v_profile.subscription_tier, 'basic') = 'basic' THEN
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
        'forum_unread_details', v_forum_details,
        'settings', v_settings_badge,
        'has_claimed_welcome_gift', COALESCE(v_profile.has_claimed_welcome_gift, false)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
