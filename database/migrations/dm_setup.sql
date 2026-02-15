-- =====================================================
-- DIRECT MESSAGING SYSTEM
-- Tables: direct_chats, direct_chat_participants, direct_messages
-- =====================================================

-- 1. Chats (Conversations)
CREATE TABLE IF NOT EXISTS public.direct_chats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Participants (Many-to-Many: Users <-> Chats)
CREATE TABLE IF NOT EXISTS public.direct_chat_participants (
    chat_id UUID REFERENCES public.direct_chats(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (chat_id, user_id)
);

-- 3. Messages
CREATE TABLE IF NOT EXISTS public.direct_messages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    chat_id UUID REFERENCES public.direct_chats(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. RLS Policies
ALTER TABLE public.direct_chats ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.direct_chat_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.direct_messages ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view chats they are participants of
CREATE POLICY "View own chats" ON public.direct_chats
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.direct_chat_participants
            WHERE chat_id = id AND user_id = auth.uid()
        )
    );

-- Policy: Users can create chats (anyone can start, but subsequent logic handles participants)
CREATE POLICY "Create chats" ON public.direct_chats FOR INSERT WITH CHECK (true);

-- Policy: Participants
CREATE POLICY "View participants" ON public.direct_chat_participants
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.direct_chat_participants participants
            WHERE participants.chat_id = chat_id AND participants.user_id = auth.uid()
        )
    );

CREATE POLICY "Insert participants" ON public.direct_chat_participants FOR INSERT WITH CHECK (true);

-- Policy: Messages
CREATE POLICY "View messages in own chats" ON public.direct_messages
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.direct_chat_participants
            WHERE chat_id = direct_messages.chat_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "Insert messages in own chats" ON public.direct_messages
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.direct_chat_participants
            WHERE chat_id = direct_messages.chat_id AND user_id = auth.uid()
        )
    );

-- 5. Realtime
DO $$
BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.direct_messages;
EXCEPTION
  WHEN duplicate_object OR sqlstate '42710' THEN
    NULL;
END $$;

-- 6. Helper Function: Get or Create DM Channel
-- Returns the chat_id for a conversation between auth.uid() and target_user_id
CREATE OR REPLACE FUNCTION public.get_or_create_dm(target_user_id UUID)
RETURNS UUID AS $$
DECLARE
    v_chat_id UUID;
BEGIN
    -- 1. Check if a chat already exists with EXACTLY these two users
    SELECT c.id INTO v_chat_id
    FROM public.direct_chats c
    JOIN public.direct_chat_participants p1 ON c.id = p1.chat_id
    JOIN public.direct_chat_participants p2 ON c.id = p2.chat_id
    WHERE p1.user_id = auth.uid() 
      AND p2.user_id = target_user_id
    GROUP BY c.id
    HAVING COUNT(DISTINCT c.id) = 1; -- Simply find one that matches

    -- 2. If found, return it
    IF v_chat_id IS NOT NULL THEN
        RETURN v_chat_id;
    END IF;

    -- 3. If not found, create new
    INSERT INTO public.direct_chats DEFAULT VALUES RETURNING id INTO v_chat_id;

    -- 4. Add participants
    INSERT INTO public.direct_chat_participants (chat_id, user_id)
    VALUES (v_chat_id, auth.uid()), (v_chat_id, target_user_id);

    RETURN v_chat_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
