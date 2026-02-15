-- ============================================================
-- Migration: Enable Realtime for pending_points table
-- ============================================================

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' 
        AND schemaname = 'public' 
        AND tablename = 'pending_points'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.pending_points;
    END IF;
END $$;
