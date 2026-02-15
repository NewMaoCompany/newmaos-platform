-- =====================================================
-- CLEANUP SCRIPT: Remove Friendship and Chat with 'zhu'
-- =====================================================

-- 1. Remove Friend Request (Accepted or Pending)
DELETE FROM public.friend_requests
WHERE 
    (sender_id IN (SELECT id FROM public.user_profiles WHERE name = 'zhu') 
     AND receiver_id IN (SELECT id FROM public.user_profiles WHERE name = 'newmao'))
    OR 
    (sender_id IN (SELECT id FROM public.user_profiles WHERE name = 'newmao') 
     AND receiver_id IN (SELECT id FROM public.user_profiles WHERE name = 'zhu'));

-- 2. Remove Direct Chat (Optional: if you want to wipe the chat history too)
-- Finds the chat where EXACTLY these two users are participants
WITH target_chat AS (
    SELECT c.id
    FROM public.direct_chats c
    JOIN public.direct_chat_participants p1 ON c.id = p1.chat_id
    JOIN public.direct_chat_participants p2 ON c.id = p2.chat_id
    WHERE p1.user_id IN (SELECT id FROM public.user_profiles WHERE name = 'zhu')
      AND p2.user_id IN (SELECT id FROM public.user_profiles WHERE name = 'newmao')
)
DELETE FROM public.direct_chats
WHERE id IN (SELECT id FROM target_chat);

-- Note: user_profiles names are case-sensitive usually, ensure 'zhu' and 'newmao' are correct matches.
