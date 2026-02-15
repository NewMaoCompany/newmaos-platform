-- ==============================================================================
-- FIX V2: ADD MISSING CASCADES FOR NESTED DEPENDENCIES
-- Purpose: Fix "Grandchild" dependencies that block cascading deletes.
-- ==============================================================================

-- 1. FIX attempt_errors (Blocks deletion of question_attempts)
-- This was the likely cause of the "Database error" after the first fix.
ALTER TABLE public.attempt_errors
DROP CONSTRAINT IF EXISTS attempt_errors_attempt_id_fkey;

ALTER TABLE public.attempt_errors
ADD CONSTRAINT attempt_errors_attempt_id_fkey
FOREIGN KEY (attempt_id) REFERENCES public.question_attempts(id)
ON DELETE CASCADE;

-- 2. FIX user_question_state (Blocks deletion of question_attempts via last_attempt_id)
-- Even if user_question_state is deleted by user cascade, the FK constraint itself might be strict.
ALTER TABLE public.user_question_state
DROP CONSTRAINT IF EXISTS user_question_state_last_attempt_id_fkey;

ALTER TABLE public.user_question_state
ADD CONSTRAINT user_question_state_last_attempt_id_fkey
FOREIGN KEY (last_attempt_id) REFERENCES public.question_attempts(id)
ON DELETE SET NULL;

-- 3. FIX user_question_state (Ensure main user FK has cascade, just in case)
ALTER TABLE public.user_question_state
DROP CONSTRAINT IF EXISTS user_question_state_user_id_fkey;

ALTER TABLE public.user_question_state
ADD CONSTRAINT user_question_state_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 4. FIX user_stats (Ensure it has cascade)
ALTER TABLE public.user_stats
DROP CONSTRAINT IF EXISTS user_stats_user_id_fkey;

ALTER TABLE public.user_stats
ADD CONSTRAINT user_stats_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 5. FIX user_profiles (Ensure base profile cascades from auth.users)
-- This is critical for complete user removal.
ALTER TABLE public.user_profiles
DROP CONSTRAINT IF EXISTS user_profiles_id_fkey;

ALTER TABLE public.user_profiles
ADD CONSTRAINT user_profiles_id_fkey
FOREIGN KEY (id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 6. FIX user_checkins (Ensure checkins cascade from user_profiles)
-- Ensures streak data is wiped when user is deleted.
ALTER TABLE public.user_checkins
DROP CONSTRAINT IF EXISTS user_checkins_user_id_fkey;

ALTER TABLE public.user_checkins
ADD CONSTRAINT user_checkins_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE CASCADE;
