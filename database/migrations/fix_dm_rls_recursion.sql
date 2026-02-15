-- =====================================================
-- FIX: Infinite Recursion in RLS Policies
-- =====================================================

-- 1. Create a Helper Function (Security Definer)
-- This function runs with owner permissions, bypassing RLS.
-- This breaks the infinite loop when policies check membership.
CREATE OR REPLACE FUNCTION public.is_dm_participant(p_chat_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 
        FROM public.direct_chat_participants 
        WHERE chat_id = p_chat_id 
          AND user_id = auth.uid()
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Fix direct_chat_participants Policy
-- Drop the recursive policy
DROP POLICY IF EXISTS "View participants" ON public.direct_chat_participants;

-- Create new safe policy: 
-- Users can see rows if they are the user in the row OR if they are a participant in that chat
CREATE POLICY "View participants" ON public.direct_chat_participants
    FOR SELECT USING (
        user_id = auth.uid() -- Can always see own membership
        OR
        public.is_dm_participant(chat_id) -- Can see others in chats I belong to (Safe check)
    );

-- 3. Fix direct_messages Policy (Insert Check)
-- The insert policy was also triggering recursion by querying participants
DROP POLICY IF EXISTS "Insert messages in own chats" ON public.direct_messages;

CREATE POLICY "Insert messages in own chats" ON public.direct_messages
    FOR INSERT WITH CHECK (
        public.is_dm_participant(chat_id)
    );

-- 4. Fix direct_messages Policy (Select Check)
DROP POLICY IF EXISTS "View messages in own chats" ON public.direct_messages;

CREATE POLICY "View messages in own chats" ON public.direct_messages
    FOR SELECT USING (
        public.is_dm_participant(chat_id)
    );

-- 5. Fix direct_chats Policy (View own chats)
DROP POLICY IF EXISTS "View own chats" ON public.direct_chats;

CREATE POLICY "View own chats" ON public.direct_chats
    FOR SELECT USING (
        public.is_dm_participant(id)
    );
