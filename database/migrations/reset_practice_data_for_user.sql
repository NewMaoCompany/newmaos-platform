-- ============================================================
-- RESET PRACTICE DATA FOR TESTING
-- Clears only practice attempts, section progress, and Practice-related coin transactions.
-- Does not touch overall points balance (to keep their Pro tier/coins intact)
-- ============================================================

-- 1. Delete all question attempts for current user
DELETE FROM public.question_attempts
WHERE user_id = auth.uid();

-- 2. Delete practice-related coin transactions for current user from points_ledger
-- This allows them to earn the first-time correct bonus again
DELETE FROM public.points_ledger
WHERE user_id = auth.uid()
  AND (idempotency_key LIKE 'practice_reward_%' OR idempotency_key LIKE 'practice_%');

-- 3. Delete section progress
DELETE FROM public.user_section_progress
WHERE user_id = auth.uid();

-- 4. Delete user stats (accuracy, total attempts)
DELETE FROM public.user_stats
WHERE user_id = auth.uid();

-- 5. Delete user question states (reviews, stars, flags)
DELETE FROM public.user_question_state
WHERE user_id = auth.uid();

-- Optional: Delete recent activities related to practice
DELETE FROM public.activities
WHERE user_id = auth.uid() AND type IN ('practice_complete', 'section_complete', 'first_attempt');
