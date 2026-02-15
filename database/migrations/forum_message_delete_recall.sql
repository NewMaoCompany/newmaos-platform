-- Migration: Enable message recall (delete for all) and ensure realtime DELETE events work
-- Run this in Supabase SQL Editor

-- 1. Enable REPLICA IDENTITY FULL on forum_messages so DELETE events include the old row data
-- This is required for Supabase Realtime to broadcast DELETE events with the row info
ALTER TABLE public.forum_messages REPLICA IDENTITY FULL;

-- 2. Enable RLS on forum_messages (if not already enabled) and add policies
-- Users can read all messages in channels they have access to
-- Users can only delete their own messages (for recall functionality)

-- Check if RLS is already enabled; if not, enable it
DO $$
BEGIN
    -- Enable RLS
    ALTER TABLE public.forum_messages ENABLE ROW LEVEL SECURITY;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'RLS may already be enabled on forum_messages';
END $$;

-- Policy: Anyone authenticated can SELECT messages
DROP POLICY IF EXISTS "Anyone can read forum messages" ON public.forum_messages;
CREATE POLICY "Anyone can read forum messages"
    ON public.forum_messages
    FOR SELECT
    USING (true);

-- Policy: Authenticated users can INSERT messages
DROP POLICY IF EXISTS "Authenticated users can send messages" ON public.forum_messages;
CREATE POLICY "Authenticated users can send messages"
    ON public.forum_messages
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Policy: Users can UPDATE their own messages (for pin toggle by anyone for now)
DROP POLICY IF EXISTS "Anyone can update forum messages" ON public.forum_messages;
CREATE POLICY "Anyone can update forum messages"
    ON public.forum_messages
    FOR UPDATE
    USING (true);

-- Policy: Users can DELETE their own messages (for recall)
DROP POLICY IF EXISTS "Users can delete own messages" ON public.forum_messages;
CREATE POLICY "Users can delete own messages"
    ON public.forum_messages
    FOR DELETE
    USING (auth.uid() = user_id);

-- 3. Ensure the forum_messages table is added to the Supabase Realtime publication
-- (This may already be done, but running it again is safe)
DO $$
BEGIN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.forum_messages;
EXCEPTION WHEN duplicate_object THEN
    RAISE NOTICE 'forum_messages already in supabase_realtime publication';
END $$;

-- Verify
SELECT tablename, schemaname FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'forum_messages';
