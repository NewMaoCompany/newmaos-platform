-- Phase 18 (REVISED): Nuclear Notification Logic Reset & Enrichment
-- This script drops all previous triggers and functions to ensure a clean state.

-- 1. CLEANUP OLD TRIGGERS & FUNCTIONS
DROP TRIGGER IF EXISTS enforce_dm_permission ON public.direct_messages;
DROP TRIGGER IF EXISTS on_channel_message_created ON public.forum_messages;
DROP TRIGGER IF EXISTS notify_dm_receiver ON public.direct_messages; -- Potential other name

-- 2. SCHEMA UPDATE
ALTER TABLE public.notifications 
ADD COLUMN IF NOT EXISTS channel_id UUID REFERENCES public.forum_channels(id) ON DELETE CASCADE,
ADD COLUMN IF NOT EXISTS type TEXT,
ADD COLUMN IF NOT EXISTS metadata JSONB;

-- 3. UTILITY: SNIPPET GENERATOR
CREATE OR REPLACE FUNCTION public.get_message_snippet(content TEXT)
RETURNS TEXT AS $$
BEGIN
    IF length(content) > 40 THEN
        RETURN substring(content from 1 for 37) || '...';
    ELSE
        RETURN content;
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 4. LOGIC: ENHANCED DM TRIGGER
CREATE OR REPLACE FUNCTION public.check_dm_permission_and_notify()
RETURNS TRIGGER AS $$
DECLARE
    is_friend BOOLEAN;
    other_user_id UUID;
    sender_name TEXT;
    msg_snippet TEXT;
BEGIN
    -- Find receiver
    SELECT user_id INTO other_user_id
    FROM public.direct_chat_participants
    WHERE chat_id = NEW.chat_id AND user_id != NEW.user_id
    LIMIT 1;

    -- Self-chat or system? Allow.
    IF other_user_id IS NULL THEN RETURN NEW; END IF;

    -- Check Friendship
    SELECT EXISTS (
        SELECT 1 FROM public.friend_requests
        WHERE (sender_id = NEW.user_id AND receiver_id = other_user_id AND status = 'accepted')
           OR (sender_id = other_user_id AND receiver_id = NEW.user_id AND status = 'accepted')
    ) INTO is_friend;

    IF NOT is_friend THEN
        RAISE EXCEPTION 'You must be friends to send messages to this user.';
    END IF;

    -- Get sender name and snippet
    SELECT name INTO sender_name FROM public.user_profiles WHERE id = NEW.user_id;
    msg_snippet := public.get_message_snippet(NEW.content);

    -- Insert notification with Name: Snippet
    INSERT INTO public.notifications (user_id, text, link, unread, chat_id)
    VALUES (
        other_user_id,
        COALESCE(sender_name, 'Friend') || ': ' || msg_snippet,
        '/forum?chat_id=' || NEW.chat_id, 
        true,
        NEW.chat_id
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. LOGIC: ENHANCED CHANNEL TRIGGER
CREATE OR REPLACE FUNCTION public.notify_channel_message()
RETURNS TRIGGER AS $$
DECLARE
    sender_name TEXT;
    channel_name TEXT;
    msg_snippet TEXT;
    member_record RECORD;
BEGIN
    -- Get names and snippet
    SELECT name INTO sender_name FROM public.user_profiles WHERE id = NEW.user_id;
    SELECT name INTO channel_name FROM public.forum_channels WHERE id = NEW.channel_id;
    msg_snippet := public.get_message_snippet(NEW.content);

    -- Notify all channel members (except sender)
    FOR member_record IN 
        SELECT user_id FROM public.channel_members WHERE channel_id = NEW.channel_id AND user_id != NEW.user_id
    LOOP
        INSERT INTO public.notifications (user_id, text, link, unread, channel_id)
        VALUES (
            member_record.user_id,
            '[' || COALESCE(channel_name, 'Channel') || '] ' || COALESCE(sender_name, 'User') || ': ' || msg_snippet,
            '/forum?channel_id=' || NEW.channel_id,
            true,
            NEW.channel_id
        );
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. RE-BIND TRIGGERS
CREATE TRIGGER enforce_dm_permission
    BEFORE INSERT ON public.direct_messages
    FOR EACH ROW EXECUTE FUNCTION public.check_dm_permission_and_notify();

CREATE TRIGGER on_channel_message_created
    AFTER INSERT ON public.forum_messages
    FOR EACH ROW EXECUTE FUNCTION public.notify_channel_message();
