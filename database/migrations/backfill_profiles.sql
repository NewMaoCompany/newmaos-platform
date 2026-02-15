-- Backfill public.user_profiles from auth.users
-- This fixes "Unknown User" for users who signed up but have no profile row
-- NOTE: user_profiles does not have an email column in this schema version
INSERT INTO public.user_profiles (id, name, avatar_url)
SELECT 
    id, 
    COALESCE(raw_user_meta_data->>'full_name', raw_user_meta_data->>'name', 'User ' || substr(id::text, 1, 4)), 
    raw_user_meta_data->>'avatar_url'
FROM auth.users
WHERE id NOT IN (SELECT id FROM public.user_profiles);

-- Also ensure RLS allows reading
GRANT SELECT ON public.user_profiles TO anon, authenticated;
