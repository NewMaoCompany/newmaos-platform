-- =====================================================
-- FORUM DATA INTEGRITY & RLS CHECK
-- Use this to verify the state of forum and DM tables.
-- =====================================================

-- 1. Check Row Counts
SELECT 'forum_channels' as table_name, count(*) FROM public.forum_channels
UNION ALL
SELECT 'forum_messages', count(*) FROM public.forum_messages
UNION ALL
SELECT 'direct_chats', count(*) FROM public.direct_chats
UNION ALL
SELECT 'direct_messages', count(*) FROM public.direct_messages;

-- 2. Check for "Orphaned" messages (messages with invalid channel_id)
SELECT count(*) as orphaned_forum_messages 
FROM public.forum_messages fm
LEFT JOIN public.forum_channels fc ON fm.channel_id = fc.id
WHERE fc.id IS NULL;

-- 3. Verify RLS Policies on forum_messages
SELECT tablename, policyname, permissive, roles, cmd, qual, with_check 
FROM pg_policies 
WHERE tablename = 'forum_messages';

-- 4. Check Realtime Status
SELECT tablename, schemaname 
FROM pg_publication_tables 
WHERE pubname = 'supabase_realtime' 
AND tablename IN ('forum_messages', 'direct_messages');
