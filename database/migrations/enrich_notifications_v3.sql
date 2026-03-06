-- Phase 19: Notification Triggers with Reply Support
-- Updates the triggers to generate specific "Replied to you" notifications

-- 1. ENHANCED CHANNEL TRIGGER WITH REPLY SUPPORT
CREATE OR REPLACE FUNCTION public.notify_channel_message()
RETURNS TRIGGER AS $$
DECLARE
    sender_name TEXT;
    channel_name TEXT;
    msg_snippet TEXT;
    parent_user_id UUID;
    member_record RECORD;
BEGIN
    -- Get names and snippet
    SELECT name INTO sender_name FROM public.user_profiles WHERE id = NEW.user_id;
    SELECT name INTO channel_name FROM public.forum_channels WHERE id = NEW.channel_id;
    msg_snippet := public.get_message_snippet(NEW.content);

    -- Check if this is a reply
    IF NEW.reply_to_id IS NOT NULL THEN
        SELECT user_id INTO parent_user_id FROM public.forum_messages WHERE id = NEW.reply_to_id;
        
        -- If replying to someone else, send them a specific "Replied to you" notification
        IF parent_user_id IS NOT NULL AND parent_user_id != NEW.user_id THEN
            INSERT INTO public.notifications (user_id, text, link, unread, channel_id, type)
            VALUES (
                parent_user_id,
                COALESCE(sender_name, 'Someone') || ' replied to your message: "' || msg_snippet || '"',
                '/forum?channel_id=' || NEW.channel_id || '&message_id=' || NEW.id,
                true,
                NEW.channel_id,
                'reply'
            );
        END IF;
    END IF;

    -- Notify all channel members (except sender and the person already notified via reply)
    FOR member_record IN 
        SELECT user_id FROM public.channel_members WHERE channel_id = NEW.channel_id AND user_id != NEW.user_id
    LOOP
        IF parent_user_id IS NULL OR member_record.user_id != parent_user_id THEN
            INSERT INTO public.notifications (user_id, text, link, unread, channel_id, type)
            VALUES (
                member_record.user_id,
                '[' || COALESCE(channel_name, 'Channel') || '] ' || COALESCE(sender_name, 'User') || ': ' || msg_snippet,
                '/forum?channel_id=' || NEW.channel_id,
                true,
                NEW.channel_id,
                'channel_message'
            );
        END IF;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. RE-BIND CHANNEL TRIGGER (Just in case, though CREATE OR REPLACE FUNCTION is usually enough)
DROP TRIGGER IF EXISTS on_channel_message_created ON public.forum_messages;
CREATE TRIGGER on_channel_message_created
    AFTER INSERT ON public.forum_messages
    FOR EACH ROW EXECUTE FUNCTION public.notify_channel_message();

