-- Supabase Security Vulnerabilities Fix

-- 1. Enable RLS on tables where policies exist but RLS is disabled
ALTER TABLE public.question_error_patterns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_versions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;

-- 2. Enable RLS on user tables that were completely public
ALTER TABLE public.user_checkins ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_points ENABLE ROW LEVEL SECURITY;

-- 3. Create SELECT policies for user_checkins and user_points
-- We only grant SELECT because inserts/updates should be handled by secure RPCs (Security Definer) 
-- or backend, preventing users from arbitrarily modifying their points or checkins.

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'user_checkins' AND policyname = 'Users can view own checkins'
    ) THEN
        CREATE POLICY "Users can view own checkins" ON public.user_checkins FOR SELECT USING (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'user_points' AND policyname = 'Users can view own points'
    ) THEN
        CREATE POLICY "Users can view own points" ON public.user_points FOR SELECT USING (auth.uid() = user_id);
    END IF;
END $$;

-- 4. Change views from Security Definer to Security Invoker
-- Supabase recommends Security Invoker for views unless specifically needed, to ensure RLS is respected.
ALTER VIEW public.v_skill_cluster_map SET (security_invoker = on);
ALTER VIEW public.v_error_cluster_map SET (security_invoker = on);
ALTER VIEW public.v_question_profiles SET (security_invoker = on);
ALTER VIEW public.vw_research_skill_aggregation SET (security_invoker = on);
ALTER VIEW public.vw_research_prediction_calibration SET (security_invoker = on);
