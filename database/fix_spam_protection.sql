-- ========================================================
-- Anti-Spam Rate Limiting Triggers & Spammer Cleanup
-- ========================================================

-- 1. Clean up the spammer and all their garbage data immediately
-- The user ID of the spammer is '89cbd5dd-d761-4756-bbaa-1142473ed143'
DELETE FROM public.forum_messages WHERE user_id = '89cbd5dd-d761-4756-bbaa-1142473ed143';
DELETE FROM public.direct_messages WHERE user_id = '89cbd5dd-d761-4756-bbaa-1142473ed143';
DELETE FROM public.friend_requests WHERE sender_id = '89cbd5dd-d761-4756-bbaa-1142473ed143';
DELETE FROM public.user_profiles WHERE id = '89cbd5dd-d761-4756-bbaa-1142473ed143';

-- 2. Anti-spam for forum_messages (Max 5 messages per 10 seconds)
CREATE OR REPLACE FUNCTION public.check_forum_message_rate_limit()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    recent_message_count integer;
BEGIN
    SELECT count(*)
    INTO recent_message_count
    FROM public.forum_messages
    WHERE user_id = NEW.user_id
    AND created_at >= NOW() - INTERVAL '10 seconds';

    IF recent_message_count >= 5 THEN
        RAISE EXCEPTION 'Rate limit exceeded. Please wait before sending more messages.';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS enforce_forum_message_rate_limit ON public.forum_messages;
CREATE TRIGGER enforce_forum_message_rate_limit
    BEFORE INSERT ON public.forum_messages
    FOR EACH ROW
    EXECUTE FUNCTION public.check_forum_message_rate_limit();


-- 3. Anti-spam for direct_messages (Max 5 messages per 10 seconds)
CREATE OR REPLACE FUNCTION public.check_direct_message_rate_limit()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    recent_message_count integer;
BEGIN
    SELECT count(*)
    INTO recent_message_count
    FROM public.direct_messages
    WHERE user_id = NEW.user_id
    AND created_at >= NOW() - INTERVAL '10 seconds';

    IF recent_message_count >= 5 THEN
        RAISE EXCEPTION 'Rate limit exceeded. Please wait before sending more messages.';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS enforce_direct_message_rate_limit ON public.direct_messages;
CREATE TRIGGER enforce_direct_message_rate_limit
    BEFORE INSERT ON public.direct_messages
    FOR EACH ROW
    EXECUTE FUNCTION public.check_direct_message_rate_limit();


-- 4. Anti-spam for friend_requests (Max 3 requests per 10 seconds)
CREATE OR REPLACE FUNCTION public.check_friend_request_rate_limit()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    recent_request_count integer;
BEGIN
    SELECT count(*)
    INTO recent_request_count
    FROM public.friend_requests
    WHERE sender_id = NEW.sender_id
    AND created_at >= NOW() - INTERVAL '10 seconds';

    IF recent_request_count >= 3 THEN
        RAISE EXCEPTION 'Rate limit exceeded. Please wait before sending more requests.';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS enforce_friend_request_rate_limit ON public.friend_requests;
CREATE TRIGGER enforce_friend_request_rate_limit
    BEFORE INSERT ON public.friend_requests
    FOR EACH ROW
    EXECUTE FUNCTION public.check_friend_request_rate_limit();
