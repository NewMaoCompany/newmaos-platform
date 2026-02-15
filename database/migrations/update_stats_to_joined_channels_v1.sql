-- =====================================================
-- UPDATE: Change 'Influence' to 'Joined Channels'
-- =====================================================

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

    -- Count Joined Channels
    -- This reflects the number of channels the user is a member of
    SELECT COUNT(*) INTO channels_count
    FROM public.channel_members
    WHERE user_id = target_user_id;

    RETURN jsonb_build_object(
        'posts', posts_count,
        'friends', friends_count,
        'channels', channels_count
    );
END;
$$;
