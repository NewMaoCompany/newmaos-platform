
-- =====================================================
-- JOINED CHANNELS & PRESENCE SYSTEM CONSOLIDATED FIX (V2)
-- EXECUTE THIS IN SUPABASE SQL EDITOR
-- =====================================================

-- 1. Ensure creator_id exists in forum_channels
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'forum_channels' AND column_name = 'creator_id') THEN 
        ALTER TABLE public.forum_channels ADD COLUMN creator_id UUID REFERENCES auth.users(id) ON DELETE SET NULL; 
    END IF; 
END $$;

-- 2. Create channel_members table
CREATE TABLE IF NOT EXISTS public.channel_members (
    channel_id UUID REFERENCES public.forum_channels(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (channel_id, user_id)
);

-- 3. Enable RLS and set policies for memberships
ALTER TABLE public.channel_members ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public view channel members" ON public.channel_members;
CREATE POLICY "Public view channel members" ON public.channel_members FOR SELECT USING (true);
DROP POLICY IF EXISTS "Users can join channels" ON public.channel_members;
CREATE POLICY "Users can join channels" ON public.channel_members FOR INSERT WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "Users can leave channels" ON public.channel_members;
CREATE POLICY "Users can leave channels" ON public.channel_members FOR DELETE USING (auth.uid() = user_id);

-- 4. Set default creator for existing channels if still NULL
UPDATE public.forum_channels 
SET creator_id = (SELECT id FROM auth.users WHERE email = 'newmao6120@gmail.com' LIMIT 1)
WHERE creator_id IS NULL;

-- 5. Helper Function: Ensure creator is always a member
CREATE OR REPLACE FUNCTION public.sync_channel_creator_membership() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.creator_id IS NOT NULL THEN
        INSERT INTO public.channel_members (channel_id, user_id)
        VALUES (NEW.id, NEW.creator_id)
        ON CONFLICT (channel_id, user_id) DO NOTHING;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 6. Add Triggers for Automatic Membership
DROP TRIGGER IF EXISTS tr_auto_join_creator ON public.forum_channels;
CREATE TRIGGER tr_auto_join_creator
AFTER INSERT OR UPDATE OF creator_id ON public.forum_channels
FOR EACH ROW EXECUTE FUNCTION public.sync_channel_creator_membership();

-- 7. Sync existing creators to membership table
INSERT INTO public.channel_members (channel_id, user_id)
SELECT id, creator_id 
FROM public.forum_channels 
WHERE creator_id IS NOT NULL
ON CONFLICT (channel_id, user_id) DO NOTHING;

-- 8. Ensure Presence Table and RPCs exist
CREATE TABLE IF NOT EXISTS public.user_presence (
    user_id UUID PRIMARY KEY REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    last_seen_at TIMESTAMPTZ DEFAULT NOW(),
    current_context_id UUID,
    current_context_type TEXT CHECK (current_context_type IN ('channel', 'dm')),
    online_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.user_presence ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users within own presence" ON public.user_presence;
CREATE POLICY "Users within own presence" ON public.user_presence FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "Users can read presence" ON public.user_presence;
CREATE POLICY "Users can read presence" ON public.user_presence FOR SELECT USING (true);

CREATE OR REPLACE FUNCTION public.update_heartbeat(p_context_id UUID, p_context_type TEXT)
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
$$ LANGUAGE plpgsql;

-- 9. Enable Realtime
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.channel_members;
    ALTER PUBLICATION supabase_realtime ADD TABLE public.user_presence;
  END IF;
EXCEPTION WHEN OTHERS THEN NULL;
END $$;
