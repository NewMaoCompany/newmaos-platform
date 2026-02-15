-- ============================================================
-- Fix Realtime Reactions (Final Check)
-- Ensures that DELETE events contain the full row data
-- ============================================================

-- Ensure the table is in the realtime publication
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' 
        AND schemaname = 'public' 
        AND tablename = 'message_reactions'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.message_reactions;
    END IF;
END $$;

-- Set REPLICA IDENTITY FULL for detailed DELETE payloads
ALTER TABLE public.message_reactions REPLICA IDENTITY FULL;

-- Double check pending_points as well
ALTER TABLE public.pending_points REPLICA IDENTITY FULL;
