-- Fix Foreign Keys to point to public.user_profiles instead of auth.users
-- This allows PostgREST to perform the join: .select('*, user:user_profiles(...)')

-- 1. Forum Messages
ALTER TABLE public.forum_messages
DROP CONSTRAINT IF EXISTS forum_messages_user_id_fkey; -- standard naming

ALTER TABLE public.forum_messages
ADD CONSTRAINT forum_messages_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE CASCADE;

-- 2. Direct Messages
ALTER TABLE public.direct_messages
DROP CONSTRAINT IF EXISTS direct_messages_user_id_fkey;

ALTER TABLE public.direct_messages
ADD CONSTRAINT direct_messages_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE CASCADE;

-- 3. Direct Chat Participants (Check this too)
ALTER TABLE public.direct_chat_participants
DROP CONSTRAINT IF EXISTS direct_chat_participants_user_id_fkey;

ALTER TABLE public.direct_chat_participants
ADD CONSTRAINT direct_chat_participants_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE CASCADE;
