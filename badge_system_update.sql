-- Add badge tracking and onboarding flags to user_profiles
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS last_analysis_view_time TIMESTAMPTZ DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_practice_rec_view_time TIMESTAMPTZ DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_pro_reminder_date DATE,
ADD COLUMN IF NOT EXISTS has_claimed_welcome_gift BOOLEAN DEFAULT false;

-- To sync unread forum counts, we need a way to track last_forum_read_time
ALTER TABLE public.user_profiles
ADD COLUMN IF NOT EXISTS last_forum_read_time TIMESTAMPTZ DEFAULT NOW();
-- Function to fetch all 5 badge states for a user efficiently
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
    SELECT EXISTS (
        SELECT 1 FROM public.points_ledger 
        WHERE user_id = p_user_id AND type = 'login_streak' AND DATE(created_at) = CURRENT_DATE
    ) INTO v_has_checked_in;
    v_dashboard_badge := NOT v_has_checked_in;

    -- 3. Practice Badge (Recommendations)
    -- We assume new recommendations are generated every day. If they haven't viewed practice since midnight, show it.
    -- Or we check if there are unhandled recommendations. For simplicity, we check if last_practice_rec_view_time is before today.
    IF DATE(COALESCE(v_profile.last_practice_rec_view_time, '1970-01-01'::DATE)) < CURRENT_DATE THEN
        v_practice_badge := true;
    ELSE
        v_practice_badge := false;
    END IF;

    -- 4. Analysis Badge
    -- Check if there are ANY question attempts strictly newer than their last view time
    SELECT EXISTS (
        SELECT 1 FROM public.question_attempts 
        WHERE user_id = p_user_id 
        AND created_at > COALESCE(v_profile.last_analysis_view_time, '1970-01-01'::TIMESTAMPTZ)
    ) INTO v_analysis_badge;

    -- 5. Forum Badge
    -- Count unread items (for now, simply count forum notifications or activities newer than last read)
    -- As bell notifications are removed, we can use the activities table or direct queries.
    -- Assuming we still track forum mentions/replies in a table...
    SELECT COUNT(*) INTO v_forum_unread_count
    FROM public.activities
    WHERE user_id = p_user_id
    AND created_at > COALESCE(v_profile.last_forum_read_time, '1970-01-01'::TIMESTAMPTZ)
    AND type IN ('forum_reply', 'forum_like', 'forum_mention', 'friend_request', 'friend_accept');

    -- 6. Settings Badge
    -- Check if Basic plan AND hasn't been reminded today
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
