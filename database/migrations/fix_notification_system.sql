-- =====================================================
-- FIX NOTIFICATION SYSTEM (Realtime & Muting)
-- 1. Add chat_id to notifications for robust filtering
-- 2. Enable Realtime for notifications table
-- 3. Update triggers to populate chat_id
-- =====================================================

-- 1. Add chat_id column
ALTER TABLE public.notifications 
ADD COLUMN IF NOT EXISTS chat_id UUID REFERENCES public.direct_chats(id) ON DELETE CASCADE;

-- 2. Enable Realtime for notifications
-- (Check if already added, if not add it)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables 
    WHERE pubname = 'supabase_realtime' 
    AND schemaname = 'public' 
    AND tablename = 'notifications'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;
  END IF;
END $$;

-- 3. Update Trigger: Friend Request Sent (No chat_id needed here, but ensure it works)
-- (No change needed for friend requests as they don't have a chat_id yet)

-- 4. Update Trigger: Enforce Strict Friend-Only DMs & Notify
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

    -- Get sender name
    SELECT name INTO sender_name FROM public.user_profiles WHERE id = NEW.user_id;

    -- Insert notification with chat_id
    INSERT INTO public.notifications (user_id, text, link, unread, chat_id)
    VALUES (
        other_user_id,
        'New message from ' || COALESCE(sender_name, 'Friend'),
        '/forum?chat_id=' || NEW.chat_id, 
        true,
        NEW.chat_id -- <--- POPULATE CHAT_ID
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
