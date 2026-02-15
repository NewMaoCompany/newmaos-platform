-- ============================================
-- Cleanup: Remove unwanted forum channels
-- Channels to delete: "test1", "1", "a-bc", and any other
-- non-standard channels from the database.
-- Keep ONLY: "Announcements" (Information) and "General" (Community)
-- ============================================

BEGIN;

-- 1. First, delete all messages in the channels we're removing
DELETE FROM public.forum_messages
WHERE channel_id IN (
    SELECT id FROM public.forum_channels
    WHERE name IN ('test1', '1')
    OR (category = 'Community' AND name NOT IN ('General'))
);

-- 2. Delete channel_members for those channels
DELETE FROM public.channel_members
WHERE channel_id IN (
    SELECT id FROM public.forum_channels
    WHERE name IN ('test1', '1')
    OR (category = 'Community' AND name NOT IN ('General'))
);

-- 3. Delete the channels themselves
-- Remove "test1" and "1" (Community channels that aren't General)
DELETE FROM public.forum_channels
WHERE name IN ('test1', '1')
OR (category = 'Community' AND name NOT IN ('General'));

-- Verify remaining channels
SELECT id, name, category, slug FROM public.forum_channels ORDER BY category, position, name;

COMMIT;
