-- =====================================================
-- RESET ALL USER HISTORY [SAFE MODE V4 - Foreign Keys]
-- =====================================================

-- 0. Clear Dependent Tables FIRST (Foreign Key Constraints)
-- "user_question_state" references "question_attempts" or helps track state
-- We must delete this first to allow deleting attempts.
DELETE FROM public.user_question_state WHERE user_id = auth.uid();

-- 1. Clear Granular Attempts (Dashboard Data Source)
DELETE FROM public.question_attempts WHERE user_id = auth.uid();

-- 2. Clear Section Progress
DELETE FROM public.user_section_progress WHERE user_id = auth.uid();

-- 3. Clear Session History (Optional, if exists)
-- DELETE FROM public.user_activities WHERE user_id = auth.uid();
