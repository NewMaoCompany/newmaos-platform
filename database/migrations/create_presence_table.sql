-- FORCE REFRESH: Drop old table to ensure clean state
DROP TABLE IF EXISTS public.user_presence CASCADE;

-- Create a table for persistent presence state (Strict Isolation)
CREATE TABLE public.user_presence (
    -- Change FK to user_profiles to allow automatic PostgREST joins
    user_id UUID PRIMARY KEY REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    last_seen_at TIMESTAMPTZ DEFAULT NOW(),
    current_context_id UUID,
    current_context_type TEXT CHECK (current_context_type IN ('channel', 'dm')),
    online_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.user_presence ENABLE ROW LEVEL SECURITY;

-- Policies
-- 1. Users can update their OWN presence
CREATE POLICY "Users within own presence" ON public.user_presence
    FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 2. Users can read presence (Public Read, filtered by client)
CREATE POLICY "Users can read presence" ON public.user_presence
    FOR SELECT
    USING (true);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_user_presence_context ON public.user_presence(current_context_id);
CREATE INDEX IF NOT EXISTS idx_user_presence_last_seen ON public.user_presence(last_seen_at);

-- Heartbeat Function (Use INVOKER SECURITY to respect RLS and auth context)
CREATE OR REPLACE FUNCTION public.update_heartbeat(
    p_context_id UUID,
    p_context_type TEXT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO public.user_presence (user_id, last_seen_at, current_context_id, current_context_type, online_at)
    VALUES (auth.uid(), NOW(), p_context_id, p_context_type, NOW())
    ON CONFLICT (user_id)
    DO UPDATE SET
        last_seen_at = NOW(),
        current_context_id = EXCLUDED.current_context_id,
        current_context_type = EXCLUDED.current_context_type;
END;
$$ LANGUAGE plpgsql; -- Removed SECURITY DEFINER to rely on RLS

-- Grant permissions explicitly
GRANT ALL ON public.user_presence TO authenticated;
GRANT ALL ON public.user_presence TO service_role;

-- Enable Realtime
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
    CREATE PUBLICATION supabase_realtime;
  END IF;
END
$$;
ALTER PUBLICATION supabase_realtime ADD TABLE public.user_presence;
