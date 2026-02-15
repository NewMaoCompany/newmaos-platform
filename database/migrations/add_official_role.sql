
-- 1. Add is_official column to user_profiles if not exists
ALTER TABLE public.user_profiles ADD COLUMN IF NOT EXISTS is_official BOOLEAN DEFAULT false;

-- 2. Mark newmao6120@gmail.com as official
-- We leverage auth.users to find the UUID safely
UPDATE public.user_profiles 
SET is_official = true 
WHERE id IN (
    SELECT id FROM auth.users WHERE email = 'newmao6120@gmail.com'
);

-- 3. Update channels created by newmao6120@gmail.com to 'Official' category
-- This will automatically show "OFFICIAL" in the browse badge
UPDATE public.forum_channels
SET category = 'Official'
WHERE creator_id IN (
    SELECT id FROM auth.users WHERE email = 'newmao6120@gmail.com'
);

-- Done
