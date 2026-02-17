-- Enable Channel Deletion (Final Robust Fix)
-- This script handles:
-- 1. Dangling data cleanup
-- 2. Foreign Key constraints (CASCADE/SET NULL)
-- 3. Schema patches for notifications
-- 4. Removal of buggy triggers

BEGIN;

-- ==========================================================
-- 1. DATA CLEANUP (Prevent FK violations)
-- ==========================================================

-- Clean up dangling message reactions
DELETE FROM public.message_reactions 
WHERE message_id NOT IN (SELECT id FROM public.forum_messages);

-- Clean up dangling notifications (if any pointing to invalid channels)
DELETE FROM public.notifications
WHERE channel_id IS NOT NULL 
  AND channel_id NOT IN (SELECT id FROM public.forum_channels);

-- ==========================================================
-- 2. DROPPING BUGGY TRIGGERS
-- ==========================================================

-- This trigger (from fix_forum_channel_delete_v2.sql) tries to insert 'title' 
-- into notifications, which might not exist. We drop it to ensure deletion works.
DROP TRIGGER IF EXISTS trg_notify_members_on_channel_delete ON public.forum_channels;
DROP FUNCTION IF EXISTS public.notify_members_on_channel_delete();

-- ==========================================================
-- 3. FOREIGN KEY UPDATES (CASCADE)
-- ==========================================================

-- A. forum_messages -> forum_channels
ALTER TABLE public.forum_messages
DROP CONSTRAINT IF EXISTS forum_messages_channel_id_fkey;

ALTER TABLE public.forum_messages
ADD CONSTRAINT forum_messages_channel_id_fkey
FOREIGN KEY (channel_id)
REFERENCES public.forum_channels(id)
ON DELETE CASCADE;

-- B. channel_members -> forum_channels
ALTER TABLE public.channel_members
DROP CONSTRAINT IF EXISTS channel_members_channel_id_fkey;

ALTER TABLE public.channel_members
ADD CONSTRAINT channel_members_channel_id_fkey
FOREIGN KEY (channel_id)
REFERENCES public.forum_channels(id)
ON DELETE CASCADE;

-- C. notifications -> forum_channels
-- Ensure column exists first
ALTER TABLE public.notifications 
ADD COLUMN IF NOT EXISTS channel_id UUID;

ALTER TABLE public.notifications
DROP CONSTRAINT IF EXISTS notifications_channel_id_fkey;

ALTER TABLE public.notifications
ADD CONSTRAINT notifications_channel_id_fkey
FOREIGN KEY (channel_id)
REFERENCES public.forum_channels(id)
ON DELETE CASCADE;

-- D. forum_messages self-reference (reply_to_id)
ALTER TABLE public.forum_messages
DROP CONSTRAINT IF EXISTS forum_messages_reply_to_id_fkey;

ALTER TABLE public.forum_messages
ADD CONSTRAINT forum_messages_reply_to_id_fkey
FOREIGN KEY (reply_to_id)
REFERENCES public.forum_messages(id)
ON DELETE SET NULL;

-- E. message_reactions -> forum_messages
-- Drop old constraint (by finding it dynamicall or knowing the name)
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (
        SELECT constraint_name
        FROM information_schema.key_column_usage
        WHERE table_name = 'message_reactions' AND column_name = 'message_id'
    ) LOOP
        EXECUTE 'ALTER TABLE public.message_reactions DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END $$;

ALTER TABLE public.message_reactions
ADD CONSTRAINT message_reactions_message_id_fkey
FOREIGN KEY (message_id)
REFERENCES public.forum_messages(id)
ON DELETE CASCADE;

-- ==========================================================
-- 4. SCHEMA PATCHES (Ensure notifications table dictates)
-- ==========================================================

ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS type TEXT;
ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS title TEXT;
ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS metadata JSONB;

-- ==========================================================
-- 5. RLS POLICIES
-- ==========================================================

DROP POLICY IF EXISTS "Users can delete their own channels" ON public.forum_channels;
CREATE POLICY "Users can delete their own channels"
ON public.forum_channels
FOR DELETE
USING (auth.uid() = creator_id);

COMMIT;
