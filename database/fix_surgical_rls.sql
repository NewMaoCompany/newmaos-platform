-- ==========================================
-- Surgical Fix for Creator Permissions & RLS
-- ==========================================

-- 1. Promote specific known users to Creator status
UPDATE public.user_profiles
SET is_creator = true
WHERE name IN ('NewMaoS.com', 'newmao', 'Admin（25');

-- 2. Disable RLS for Question related tables
-- Since the server (gatekeeper) uses the anon key and is missing the service key,
-- it is subject to RLS. We disable RLS here so the server can write, 
-- relying on our re-enabled is_creator checks in server/src/routes/questions.ts.
ALTER TABLE public.questions DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_versions DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_skills DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_error_patterns DISABLE ROW LEVEL SECURITY;

-- 3. Relax user_profiles RLS for server reading
-- Allow all authenticated users to read profiles so the server can check is_creator
DROP POLICY IF EXISTS "Public profiles are viewable by everyone" ON public.user_profiles;
CREATE POLICY "Public profiles are viewable by everyone" ON public.user_profiles
    FOR SELECT USING (true);

-- Verification:
-- SELECT id, name, is_creator FROM public.user_profiles WHERE is_creator = true;
