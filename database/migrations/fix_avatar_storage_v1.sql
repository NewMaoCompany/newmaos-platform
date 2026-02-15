-- =====================================================
-- FIX: Avatar Storage Bucket Initialization
-- =====================================================

-- 1. Create the 'avatars' bucket if it doesn't exist
INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO NOTHING;

-- IMPORTANT NOTICE:
-- If you see "must be owner of table objects" or "RLS violation",
-- it means your database user doesn't have permissions to run SQL for policies.
-- 
-- PLEASE MANUALLY SET POLICIES IN THE DASHBOARD:
-- 1. Go to Storage -> 'avatars' -> Policies.
-- 2. Add an "INSERT" policy: Allow 'authenticated' users.
-- 3. Add a "SELECT" policy: Allow 'everyone'.
-- 4. Add an "UPDATE" policy: Allow 'authenticated' users.


