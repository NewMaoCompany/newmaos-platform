-- =====================================================
-- FRIEND SYSTEM ENHANCEMENTS & RESTRICTIONS
-- 1. Notifications for Friend Requests
-- 2. Strict Friend-Only DMs
-- 3. Channel Creation Limits (1 per user, unlimited for Admin)
-- 4. Notifications for DMs
-- =====================================================

-- 1. Helper: Insert Notification
CREATE OR REPLACE FUNCTION public.create_notification(
    target_user_id UUID,
    notif_text TEXT,
    notif_link TEXT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO public.notifications (user_id, text, link, unread)
    VALUES (target_user_id, notif_text, notif_link, true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Trigger: Friend Request Sent
CREATE OR REPLACE FUNCTION public.notify_friend_request()
RETURNS TRIGGER AS $$
DECLARE
    sender_name TEXT;
BEGIN
    SELECT name INTO sender_name FROM public.user_profiles WHERE id = NEW.sender_id;
    IF sender_name IS NULL THEN sender_name := 'Someone'; END IF;

    PERFORM public.create_notification(
        NEW.receiver_id,
        sender_name || ' sent you a friend request!',
        '/forum?action=friend_request&sender_id=' || NEW.sender_id
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_friend_request_created ON public.friend_requests;
CREATE TRIGGER on_friend_request_created
    AFTER INSERT ON public.friend_requests
    FOR EACH ROW EXECUTE FUNCTION public.notify_friend_request();

-- 3. Trigger: Friend Request Accepted
CREATE OR REPLACE FUNCTION public.notify_friend_acceptance()
RETURNS TRIGGER AS $$
DECLARE
    receiver_name TEXT;
BEGIN
    IF NEW.status = 'accepted' AND OLD.status != 'accepted' THEN
        SELECT name INTO receiver_name FROM public.user_profiles WHERE id = NEW.receiver_id;
        IF receiver_name IS NULL THEN receiver_name := 'Someone'; END IF;

        PERFORM public.create_notification(
            NEW.sender_id,
            receiver_name || ' accepted your friend request!',
            '/forum?action=friend_accepted&friend_id=' || NEW.receiver_id
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_friend_request_accepted ON public.friend_requests;
CREATE TRIGGER on_friend_request_accepted
    AFTER UPDATE ON public.friend_requests
    FOR EACH ROW EXECUTE FUNCTION public.notify_friend_acceptance();

-- 4. Trigger: Enforce Strict Friend-Only DMs & Notify
CREATE OR REPLACE FUNCTION public.check_dm_permission_and_notify()
RETURNS TRIGGER AS $$
DECLARE
    is_friend BOOLEAN;
    other_user_id UUID;
    sender_name TEXT;
BEGIN
    -- Find receiver
    SELECT user_id INTO other_user_id
    FROM public.direct_chat_participants
    WHERE chat_id = NEW.chat_id AND user_id != NEW.user_id
    LIMIT 1;

    -- Self-chat or system? Allow.
    IF other_user_id IS NULL THEN RETURN NEW; END IF;

    -- Check Friendship (Must be accepted)
    SELECT EXISTS (
        SELECT 1 FROM public.friend_requests
        WHERE (sender_id = NEW.user_id AND receiver_id = other_user_id AND status = 'accepted')
           OR (sender_id = other_user_id AND receiver_id = NEW.user_id AND status = 'accepted')
    ) INTO is_friend;

    IF NOT is_friend THEN
        RAISE EXCEPTION 'You must be friends to send messages to this user.';
    END IF;

    -- If Friend, Create Notification via Trigger?
    -- Note: To avoid spamming notifications for every message, we might limit this.
    -- But user requested "Send Message ... must be displayed in Notification".
    -- Let's add it.
    SELECT name INTO sender_name FROM public.user_profiles WHERE id = NEW.user_id;

    -- Insert notification for the receiver
    -- We can use a different link if we have a way to open specific DM
    INSERT INTO public.notifications (user_id, text, link, unread)
    VALUES (
        other_user_id,
        'New message from ' || COALESCE(sender_name, 'Friend'),
        '/forum?chat_id=' || NEW.chat_id, -- Client can use this to filter muted chats or auto-open
        true
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS enforce_dm_permission ON public.direct_messages;
CREATE TRIGGER enforce_dm_permission
    BEFORE INSERT ON public.direct_messages
    FOR EACH ROW EXECUTE FUNCTION public.check_dm_permission_and_notify();


-- 5. Trigger: Channel Creation Limit (1 per user, Unlimited for Admin)
CREATE OR REPLACE FUNCTION public.check_channel_limit()
RETURNS TRIGGER AS $$
DECLARE
    channel_count INTEGER;
    user_email TEXT;
BEGIN
    -- Get Creator Email
    SELECT email INTO user_email FROM auth.users WHERE id = NEW.creator_id;

    -- Admin Override
    IF user_email = 'newmao6120@gmail.com' THEN
        RETURN NEW;
    END IF;

    -- Check Count
    SELECT COUNT(*) INTO channel_count
    FROM public.forum_channels
    WHERE creator_id = NEW.creator_id;

    IF channel_count >= 1 THEN
        RAISE EXCEPTION 'You can only create one channel.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_create_channel_limit ON public.forum_channels;
CREATE TRIGGER on_create_channel_limit
    BEFORE INSERT ON public.forum_channels
    FOR EACH ROW EXECUTE FUNCTION public.check_channel_limit();

