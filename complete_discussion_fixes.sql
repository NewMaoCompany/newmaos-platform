-- Add support for forum_messages table and RLS policies

-- 1. Create the table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.forum_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content TEXT NOT NULL,
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    question_id TEXT NOT NULL, -- The ID of the practice question this is attached to
    channel_id UUID,           -- Optional: if tied to a specific channel (like ap-calculus-ab)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create the forum_channels table if it doesn't exist (referenced in frontend)
CREATE TABLE IF NOT EXISTS public.forum_channels (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Enable RLS
ALTER TABLE public.forum_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.forum_channels ENABLE ROW LEVEL SECURITY;

-- 4. Create policies for forum_messages
-- Allow everyone to read messages
DROP POLICY IF EXISTS "Anyone can read forum messages" ON public.forum_messages;
CREATE POLICY "Anyone can read forum messages"
    ON public.forum_messages FOR SELECT
    USING (true);

-- Allow authenticated users to insert their own messages
DROP POLICY IF EXISTS "Users can insert their own messages" ON public.forum_messages;
CREATE POLICY "Users can insert their own messages"
    ON public.forum_messages FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Allow users to update their own messages (optional, frontend doesn't use it yet but good practice)
DROP POLICY IF EXISTS "Users can update their own messages" ON public.forum_messages;
CREATE POLICY "Users can update their own messages"
    ON public.forum_messages FOR UPDATE
    USING (auth.uid() = user_id);

-- Allow users to delete their own messages
DROP POLICY IF EXISTS "Users can delete their own messages" ON public.forum_messages;
CREATE POLICY "Users can delete their own messages"
    ON public.forum_messages FOR DELETE
    USING (auth.uid() = user_id);

-- 5. Create policies for forum_channels
-- Anyone can read channels
DROP POLICY IF EXISTS "Anyone can read forum channels" ON public.forum_channels;
CREATE POLICY "Anyone can read forum channels"
    ON public.forum_channels FOR SELECT
    USING (true);

-- Ensure a default channel exists if needed by the frontend (optional, since channel_id is nullable)
INSERT INTO public.forum_channels (slug, name, description)
VALUES ('ap-calculus-ab', 'AP Calculus AB', 'General discussion for AP Calculus AB')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.forum_channels (slug, name, description)
VALUES ('ap-calculus-bc', 'AP Calculus BC', 'General discussion for AP Calculus BC')
ON CONFLICT (slug) DO NOTHING;
