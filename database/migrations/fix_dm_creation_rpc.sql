-- =====================================================
-- FIX: GET OR CREATE DM RPC
-- Ensures the function exists and handles chat creation robustly
-- =====================================================

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
    LIMIT 1; -- Ensure we only get one if multiples exist

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
