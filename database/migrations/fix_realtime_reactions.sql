-- Add message_reactions to the realtime publication
-- This allows the frontend to receive INSERT/UPDATE/DELETE events
ALTER PUBLICATION supabase_realtime ADD TABLE public.message_reactions;

-- Set REPLICA IDENTITY FULL
-- This ensures that DELETE events contain the full row data (including message_id and reaction_type)
-- which is required for the frontend to correctly identify which reaction was removed.
ALTER TABLE public.message_reactions REPLICA IDENTITY FULL;
