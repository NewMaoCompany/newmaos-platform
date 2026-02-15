-- ============================================================
-- Forum Points Auto-Award System
-- Part 1: Fix message_reactions schema
-- Part 2: Create triggers for Like/Comment/Friend points
-- ============================================================

-- ============================================================
-- PART 1: Fix message_reactions schema (emoji → reaction_type)
-- ============================================================

-- Add reaction_type column if not exists
ALTER TABLE public.message_reactions 
ADD COLUMN IF NOT EXISTS reaction_type TEXT;

-- Migrate existing data
UPDATE public.message_reactions 
SET reaction_type = CASE 
    WHEN emoji = '👍' THEN 'like'
    WHEN emoji = '❤️' THEN 'love'
    ELSE 'like'
END
WHERE reaction_type IS NULL;

-- Set NOT NULL constraint
ALTER TABLE public.message_reactions 
ALTER COLUMN reaction_type SET DEFAULT 'like',
ALTER COLUMN reaction_type SET NOT NULL;

-- Drop old emoji column (optional, keep for backward compatibility)
-- ALTER TABLE public.message_reactions DROP COLUMN emoji;

-- Update unique constraint
ALTER TABLE public.message_reactions DROP CONSTRAINT IF EXISTS message_reactions_message_id_user_id_emoji_key;
ALTER TABLE public.message_reactions ADD CONSTRAINT message_reactions_message_id_user_id_reaction_type_key 
    UNIQUE (message_id, user_id, reaction_type);

-- ============================================================
-- PART 2: Award Points Triggers
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
-- VERIFICATION QUERIES (run after migration to check)
-- ============================================================

-- Check if triggers are active
-- SELECT * FROM pg_trigger WHERE tgname LIKE '%award%points%';

-- Check recent points awards
-- SELECT * FROM points_ledger WHERE type IN ('like_received', 'comment_received', 'friend_added') ORDER BY created_at DESC LIMIT 20;

-- ============================================================
-- END OF MIGRATION
-- ============================================================
