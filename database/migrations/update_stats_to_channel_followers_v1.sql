-- =====================================================
-- UPDATE: Change 'Joined Channels' to 'Channel Followers'
-- =====================================================

CREATE OR REPLACE FUNCTION public.get_user_stats(target_user_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    posts_count INTEGER;
    friends_count INTEGER;
    followers_count INTEGER;
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

    -- Count Followers (Total members in channels created by the user, excluding the creator themselves)
    SELECT COALESCE(SUM(member_count), 0) INTO followers_count
    FROM (
        SELECT 
            (SELECT COUNT(*) FROM public.channel_members cm WHERE cm.channel_id = fc.id AND cm.user_id != target_user_id) as member_count
        FROM public.forum_channels fc
        WHERE fc.creator_id = target_user_id
    ) as follower_calc;

    RETURN jsonb_build_object(
        'posts', posts_count,
        'friends', friends_count,
        'channels', followers_count
    );
END;
$$;
