-- =====================================================
-- FRIEND SYSTEM
-- Tables: friend_requests
-- =====================================================

-- 1. Friend Requests Table
-- Tracks the state of a relationship: pending -> accepted (friends) or rejected
CREATE TABLE IF NOT EXISTS public.friend_requests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    sender_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    receiver_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    status VARCHAR NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Ensure unique relationship pair (A -> B). 
    -- Application logic should check for B -> A as well, or we can enforce robustly.
    -- For simplicity, we ensure one active request direction at a time.
    CONSTRAINT unique_friend_request UNIQUE (sender_id, receiver_id)
);

-- 2. RLS Policies
ALTER TABLE public.friend_requests ENABLE ROW LEVEL SECURITY;

-- Policy: View requests involved in
CREATE POLICY "View own friend requests" ON public.friend_requests
    FOR SELECT USING (
        auth.uid() = sender_id OR auth.uid() = receiver_id
    );

-- Policy: Create request (Sender must be auth user)
CREATE POLICY "Create friend request" ON public.friend_requests
    FOR INSERT WITH CHECK (
        auth.uid() = sender_id
    );

-- Policy: Update request (Receiver accepts/rejects, or Sender cancels)
CREATE POLICY "Update own friend interaction" ON public.friend_requests
    FOR UPDATE USING (
        auth.uid() = sender_id OR auth.uid() = receiver_id
    );

-- Policy: Delete request (Sender cancels or Receiver removes)
CREATE POLICY "Delete own friend interaction" ON public.friend_requests
    FOR DELETE USING (
        auth.uid() = sender_id OR auth.uid() = receiver_id
    );

-- 3. Realtime
DO $$
BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.friend_requests;
EXCEPTION
  WHEN duplicate_object OR sqlstate '42710' THEN
    NULL;
END $$;
