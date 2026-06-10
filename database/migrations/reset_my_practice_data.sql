-- ============================================================
-- PRECISE PRACTICE DATA RESET
-- Run this in Supabase SQL Editor.
-- Replace 'YOUR_EMAIL_HERE' with your actual login email (e.g. 'newmao6120@gmail.com')
-- ============================================================

DO $$
DECLARE
    v_target_user_id UUID;
BEGIN
    -- 1. Find the user ID by email
    SELECT id INTO v_target_user_id
    FROM auth.users
    WHERE email = 'newmao6120@gmail.com'; -- Replace with your actual email if needed

    IF v_target_user_id IS NULL THEN
        RAISE EXCEPTION 'User not found. Please check the email.';
    END IF;

    -- 2. Delete all question attempts for this user
    DELETE FROM public.question_attempts
    WHERE user_id = v_target_user_id;

    -- 3. Delete ONLY practice-related coin transactions (so Pro tier / welcome gift is kept intact)
    DELETE FROM public.points_ledger
    WHERE user_id = v_target_user_id
      AND (idempotency_key LIKE 'practice_reward_%' OR idempotency_key LIKE 'practice_%');

    -- 4. Delete section progress
    DELETE FROM public.user_section_progress
    WHERE user_id = v_target_user_id;

    -- 5. Delete user stats (accuracy, total attempts)
    DELETE FROM public.user_stats
    WHERE user_id = v_target_user_id;

    -- 6. Delete user question states (reviews, stars, flags)
    DELETE FROM public.user_question_state
    WHERE user_id = v_target_user_id;

    -- 7. Delete recent activities related to practice
    DELETE FROM public.activities
    WHERE user_id = v_target_user_id AND type IN ('practice_complete', 'section_complete', 'first_attempt');

    RAISE NOTICE 'Successfully wiped all practice history for user %', v_target_user_id;
END $$;
