
-- =====================================================
-- FORUM CHANNEL MEMBERSHIP SYSTEM
-- Table: channel_members (Many-to-Many: Users <-> Channels)
-- =====================================================

-- 1. Create Table
CREATE TABLE IF NOT EXISTS public.channel_members (
    channel_id UUID REFERENCES public.forum_channels(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (channel_id, user_id)
);

-- 2. Enable RLS
ALTER TABLE public.channel_members ENABLE ROW LEVEL SECURITY;

-- 3. Policies
-- Policy: Anyone can view channel members
DROP POLICY IF EXISTS "Public view channel members" ON public.channel_members;
CREATE POLICY "Public view channel members" ON public.channel_members FOR SELECT USING (true);

-- Policy: Authenticated users can join a channel
DROP POLICY IF EXISTS "Users can join channels" ON public.channel_members;
CREATE POLICY "Users can join channels" ON public.channel_members FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Policy: Users can leave a channel
DROP POLICY IF EXISTS "Users can leave channels" ON public.channel_members;
CREATE POLICY "Users can leave channels" ON public.channel_members FOR DELETE USING (auth.uid() = user_id);

-- 4. Indices
CREATE INDEX IF NOT EXISTS idx_channel_members_user ON public.channel_members(user_id);
CREATE INDEX IF NOT EXISTS idx_channel_members_channel ON public.channel_members(channel_id);

-- 5. Realtime
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.channel_members;
  END IF;
EXCEPTION
  WHEN duplicate_object OR sqlstate '42710' THEN
    NULL;
END $$;
