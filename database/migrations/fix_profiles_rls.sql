-- Ensure user_profiles is readable by everyone (for chat names)
DROP POLICY IF EXISTS "Public profiles" ON public.user_profiles;
CREATE POLICY "Public profiles" ON public.user_profiles FOR SELECT USING (true);

-- Explicitly grant usage and select to ensuring anon/authenticated can read
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT SELECT ON TABLE public.user_profiles TO anon, authenticated;
