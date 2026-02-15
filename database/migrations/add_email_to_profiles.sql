-- Add email column to user_profiles if it doesn't exist
ALTER TABLE public.user_profiles ADD COLUMN IF NOT EXISTS email TEXT;

-- Create an index on email for faster searching
CREATE INDEX IF NOT EXISTS idx_user_profiles_email ON public.user_profiles(email);

-- Create an index on name for faster searching (since we added name search)
CREATE INDEX IF NOT EXISTS idx_user_profiles_name_trgm ON public.user_profiles USING gin (name gin_trgm_ops);

-- Backfill email from auth.users
-- Note: This requires running with sufficient privileges (superuser or via dashboard SQL editor)
UPDATE public.user_profiles
SET email = au.email
FROM auth.users au
WHERE public.user_profiles.id = au.id
AND public.user_profiles.email IS NULL;
