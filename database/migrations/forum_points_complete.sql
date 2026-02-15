-- ============================================================
-- COMPLETE FORUM POINTS SYSTEM SETUP
-- This is a SINGLE, ALL-IN-ONE migration script.
-- Run this AFTER bugfix_combined_v1.sql
-- ============================================================

-- ============================================================
-- STEP 1: Create message_reactions table (if not exists)
-- ============================================================

CREATE TABLE IF NOT EXISTS public.message_reactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    message_id UUID NOT NULL,
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    reaction_type TEXT NOT NULL DEFAULT 'like',
    emoji TEXT DEFAULT '👍',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(message_id, user_id, reaction_type)
);

CREATE INDEX IF NOT EXISTS idx_reactions_message ON public.message_reactions(message_id);
CREATE INDEX IF NOT EXISTS idx_reactions_user ON public.message_reactions(user_id);

-- Enable RLS
ALTER TABLE public.message_reactions ENABLE ROW LEVEL SECURITY;

-- Drop old policies if exist and recreate
DROP POLICY IF EXISTS "Users can view reactions" ON public.message_reactions;
DROP POLICY IF EXISTS "Users can insert own reactions" ON public.message_reactions;
DROP POLICY IF EXISTS "Users can delete own reactions" ON public.message_reactions;

CREATE POLICY "Users can view reactions" ON public.message_reactions
    FOR SELECT USING (true);

CREATE POLICY "Users can insert own reactions" ON public.message_reactions
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own reactions" ON public.message_reactions
    FOR DELETE USING (auth.uid() = user_id);

-- ============================================================
-- STEP 2: Ensure friend_requests table exists
-- ============================================================

CREATE TABLE IF NOT EXISTS public.friend_requests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    sender_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    receiver_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    status VARCHAR NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_friend_request UNIQUE (sender_id, receiver_id)
);

-- Enable RLS
ALTER TABLE public.friend_requests ENABLE ROW LEVEL SECURITY;

-- Drop old policies if exist and recreate
DROP POLICY IF EXISTS "View own friend requests" ON public.friend_requests;
DROP POLICY IF EXISTS "Create friend request" ON public.friend_requests;
DROP POLICY IF EXISTS "Update own friend interaction" ON public.friend_requests;
DROP POLICY IF EXISTS "Delete own friend interaction" ON public.friend_requests;

CREATE POLICY "View own friend requests" ON public.friend_requests
    FOR SELECT USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

CREATE POLICY "Create friend request" ON public.friend_requests
    FOR INSERT WITH CHECK (auth.uid() = sender_id);

CREATE POLICY "Update own friend interaction" ON public.friend_requests
    FOR UPDATE USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

CREATE POLICY "Delete own friend interaction" ON public.friend_requests
    FOR DELETE USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

-- ============================================================
-- STEP 3: Award Points Triggers
-- ============================================================

-- ============================================================
-- TRIGGER 1: Award points for receiving a LIKE (5 points)
-- ============================================================

CREATE OR REPLACE FUNCTION award_like_points()
RETURNS TRIGGER AS $$
DECLARE
    v_message_author_id UUID;
BEGIN
    -- Only for 'like' reactions
    IF NEW.reaction_type = 'like' THEN
        -- Get the message author
        SELECT user_id INTO v_message_author_id 
        FROM forum_messages 
        WHERE id = NEW.message_id;
        
        -- Award points only if:
        -- 1. Message author exists
        -- 2. Liker is not the author (no self-like points)
        IF v_message_author_id IS NOT NULL AND v_message_author_id <> NEW.user_id THEN
            -- Call award_points RPC with idempotency key
            PERFORM award_points(
                v_message_author_id,                                    -- recipient
                5,                                                       -- amount
                'like_received',                                         -- type
                NEW.message_id::TEXT,                                    -- source_id
                'Received a like on your message',                       -- description
                'like_' || NEW.message_id || '_' || NEW.user_id          -- idempotency_key
            );
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists and recreate
DROP TRIGGER IF EXISTS trigger_award_like_points ON public.message_reactions;

CREATE TRIGGER trigger_award_like_points
AFTER INSERT ON public.message_reactions
FOR EACH ROW
EXECUTE FUNCTION award_like_points();

-- ============================================================
-- TRIGGER 2: Award points for receiving a COMMENT (10 points)
-- ============================================================

CREATE OR REPLACE FUNCTION award_comment_points()
RETURNS TRIGGER AS $$
DECLARE
    v_parent_author_id UUID;
BEGIN
    -- Only when this is a reply (reply_to_id is not null)
    IF NEW.reply_to_id IS NOT NULL THEN
        -- Get the parent message author
        SELECT user_id INTO v_parent_author_id 
        FROM forum_messages 
        WHERE id = NEW.reply_to_id;
        
        -- Award points only if:
        -- 1. Parent author exists
        -- 2. Commenter is not the parent author (no self-comment points)
        IF v_parent_author_id IS NOT NULL AND v_parent_author_id <> NEW.user_id THEN
            -- Call award_points RPC with idempotency key
            PERFORM award_points(
                v_parent_author_id,                                      -- recipient
                10,                                                      -- amount
                'comment_received',                                      -- type
                NEW.id::TEXT,                                            -- source_id (the new comment's ID)
                'Received a comment on your message',                    -- description
                'comment_' || NEW.reply_to_id || '_' || NEW.id           -- idempotency_key
            );
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists and recreate
DROP TRIGGER IF EXISTS trigger_award_comment_points ON public.forum_messages;

CREATE TRIGGER trigger_award_comment_points
AFTER INSERT ON public.forum_messages
FOR EACH ROW
EXECUTE FUNCTION award_comment_points();

-- ============================================================
-- TRIGGER 3: Award points for FRIEND acceptance (10 points each)
-- ============================================================

CREATE OR REPLACE FUNCTION award_friend_points()
RETURNS TRIGGER AS $$
BEGIN
    -- Only when status changes from pending → accepted
    IF NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status = 'pending') THEN
        
        -- Award 10 points to SENDER (who initiated the friend request)
        PERFORM award_points(
            NEW.sender_id,                                               -- recipient
            10,                                                          -- amount
            'friend_added',                                              -- type
            NEW.id::TEXT,                                                -- source_id
            'Friend request accepted',                                   -- description
            'friend_sender_' || NEW.sender_id || '_' || NEW.receiver_id  -- idempotency_key
        );
        
        -- Award 10 points to RECEIVER (who accepted the request)
        PERFORM award_points(
            NEW.receiver_id,                                             -- recipient
            10,                                                          -- amount
            'friend_added',                                              -- type
            NEW.id::TEXT,                                                -- source_id
            'New friend added',                                          -- description
            'friend_receiver_' || NEW.receiver_id || '_' || NEW.sender_id -- idempotency_key
        );
        
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists and recreate
DROP TRIGGER IF EXISTS trigger_award_friend_points ON public.friend_requests;

CREATE TRIGGER trigger_award_friend_points
AFTER UPDATE ON public.friend_requests
FOR EACH ROW
EXECUTE FUNCTION award_friend_points();

-- ============================================================
-- VERIFICATION
-- ============================================================

-- Check if triggers are active
SELECT 
    tgname AS trigger_name, 
    tgrelid::regclass AS table_name,
    tgenabled AS enabled
FROM pg_trigger 
WHERE tgname LIKE '%award%points%'
ORDER BY tgname;

-- ============================================================
-- END OF MIGRATION
-- ============================================================
