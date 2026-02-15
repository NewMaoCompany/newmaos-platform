-- Add columns for streak tracking and stats
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS last_login_at TIMESTAMPTZ DEFAULT now(),
ADD COLUMN IF NOT EXISTS last_repair_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS prev_streak_days INTEGER DEFAULT 0;

-- RPC to handle daily login
CREATE OR REPLACE FUNCTION public.handle_daily_login(user_uuid UUID, p_timezone TEXT DEFAULT 'UTC')
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    current_streak INTEGER;
    last_login TIMESTAMPTZ;
    prev_streak INTEGER;
    today_date DATE;
    last_login_date DATE;
    v_reg_date DATE;
    v_seniority_days INTEGER;
BEGIN
    SELECT streak_days, last_login_at, prev_streak_days
    INTO current_streak, last_login, prev_streak
    FROM public.user_profiles
    WHERE id = user_uuid;

    -- Localized date calculation
    today_date := (now() AT TIME ZONE p_timezone)::DATE;

    -- [NEW] Seniority Title Logic (Runs on every login)
    SELECT (created_at AT TIME ZONE p_timezone)::DATE INTO v_reg_date 
    FROM auth.users WHERE id = user_uuid;
    
    v_seniority_days := (today_date - v_reg_date);
    
    IF v_seniority_days > 0 THEN
        PERFORM public.check_and_unlock_titles(user_uuid, 'seniority', v_seniority_days);
    END IF;

    -- If first time login ever
    IF last_login IS NULL THEN
        UPDATE public.user_profiles
        SET streak_days = 1, last_login_at = now()
        WHERE id = user_uuid;
        -- Unlock titles (Day 1)
        PERFORM public.check_and_unlock_titles(user_uuid, 'streak', 1);
        RETURN jsonb_build_object('status', 'first_login', 'streak', 1);
    END IF;

    last_login_date := (last_login AT TIME ZONE p_timezone)::DATE;
    
    -- If logged in same day, do nothing (seniority checked above)
    IF (today_date = last_login_date) THEN
        RETURN jsonb_build_object('status', 'same_day', 'streak', current_streak);
    END IF;

    -- If yesterday, increment
    IF (today_date - last_login_date) = 1 THEN
        UPDATE public.user_profiles
        SET streak_days = current_streak + 1, last_login_at = now()
        WHERE id = user_uuid;
        -- Unlock titles
        PERFORM public.check_and_unlock_titles(user_uuid, 'streak', current_streak + 1);
        RETURN jsonb_build_object('status', 'increased', 'streak', current_streak + 1);
    END IF;

    -- Missed more than 1 day, reset
    UPDATE public.user_profiles
    SET streak_days = 1, 
        prev_streak_days = current_streak,
        last_login_at = now()
    WHERE id = user_uuid;
    -- Unlock titles (Day 1)
    PERFORM public.check_and_unlock_titles(user_uuid, 'streak', 1);
    
    RETURN jsonb_build_object('status', 'reset', 'streak', 1, 'prev_streak', current_streak);
END;
$$;

-- RPC to use monthly repair
CREATE OR REPLACE FUNCTION public.use_monthly_repair(user_uuid UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    current_repair TIMESTAMPTZ;
    prev_streak INTEGER;
    current_streak INTEGER;
BEGIN
    SELECT last_repair_at, prev_streak_days, streak_days
    INTO current_repair, prev_streak, current_streak
    FROM public.user_profiles
    WHERE id = user_uuid;

    -- Check if used this month
    IF current_repair IS NOT NULL AND 
       DATE_PART('year', current_repair) = DATE_PART('year', now()) AND
       DATE_PART('month', current_repair) = DATE_PART('month', now()) THEN
        RETURN jsonb_build_object('success', false, 'message', 'Already used repair this month');
    END IF;

    -- Check if there is a streak to repair
    -- Only allow repair if they currently have streak=1 (meaning they just reset) AND have a prev_streak
    IF prev_streak <= 0 THEN
         RETURN jsonb_build_object('success', false, 'message', 'No streak to repair');
    END IF;

    -- Restore streak (prev + 1 for today)
    UPDATE public.user_profiles
    SET streak_days = prev_streak + 1,
        prev_streak_days = 0, -- consume backup
        last_repair_at = now()
    WHERE id = user_uuid;

    RETURN jsonb_build_object('success', true, 'new_streak', prev_streak + 1);
END;
$$;

-- RPC to get accurate user stats
CREATE OR REPLACE FUNCTION public.get_user_stats(target_user_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    posts_count INTEGER;
    friends_count INTEGER;
    channels_count INTEGER;
BEGIN
    -- Count Forum Messages (Posts)
    SELECT COUNT(*) INTO posts_count
    FROM public.forum_messages
    WHERE user_id = target_user_id;

    -- Count Friends (Accepted) - Check both sender/receiver
    SELECT COUNT(*) INTO friends_count
    FROM public.friend_requests
    WHERE (sender_id = target_user_id OR receiver_id = target_user_id)
    AND status = 'accepted';

    -- Count Influence (Total members in channels created by the user, excluding the creator)
    SELECT COALESCE(SUM(member_count), 0) INTO channels_count
    FROM (
        SELECT 
            (SELECT COUNT(*) FROM public.channel_members cm WHERE cm.channel_id = fc.id AND cm.user_id != target_user_id) as member_count
        FROM public.forum_channels fc
        WHERE fc.creator_id = target_user_id
    ) as influence_calc;

    RETURN jsonb_build_object(
        'posts', posts_count,
        'friends', friends_count,
        'channels', channels_count
    );
END;
$$;
