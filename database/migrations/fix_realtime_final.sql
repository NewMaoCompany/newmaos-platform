-- ============================================================
-- FINAL REALTIME FIX (Idempotent Version)
-- Ensures Friend Requests and Likes are broadcasted correctly
-- ============================================================

-- 1. Ensure tables are in the publication (Idempotent)
DO $$
BEGIN
    -- add friend_requests
    BEGIN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.friend_requests;
    EXCEPTION WHEN duplicate_object OR sqlstate '42710' THEN
        NULL; -- Already exists, ignore
    END;

    -- add message_reactions
    BEGIN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.message_reactions;
    EXCEPTION WHEN duplicate_object OR sqlstate '42710' THEN
        NULL;
    END;

    -- add forum_messages
    BEGIN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.forum_messages;
    EXCEPTION WHEN duplicate_object OR sqlstate '42710' THEN
        NULL;
    END;

    -- add direct_messages
    BEGIN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.direct_messages;
    EXCEPTION WHEN duplicate_object OR sqlstate '42710' THEN
        NULL;
    END;

    -- add notifications (CRITICAL FIX FOR RED DOT)
    BEGIN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;
    EXCEPTION WHEN duplicate_object OR sqlstate '42710' THEN
        NULL;
    END;
END $$;

-- 2. Set REPLICA IDENTITY FULL
-- This is critical for DELETE events to contain the old row data
ALTER TABLE public.message_reactions REPLICA IDENTITY FULL;
ALTER TABLE public.friend_requests REPLICA IDENTITY FULL;
ALTER TABLE public.forum_messages REPLICA IDENTITY FULL;
ALTER TABLE public.direct_messages REPLICA IDENTITY FULL;
ALTER TABLE public.notifications REPLICA IDENTITY FULL;
