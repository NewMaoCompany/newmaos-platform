-- ============================================================
-- COMPLETE PRACTICE DATA CLEANUP for newmao6120@gmail.com
-- Run ALL statements in Supabase SQL Editor
-- ============================================================

-- Step 0: Get the user's UUID
DO $$
DECLARE
    v_user_id UUID;
BEGIN
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'newmao6120@gmail.com';
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'User not found: newmao6120@gmail.com';
    END IF;
    RAISE NOTICE 'User ID: %', v_user_id;

    -- 1. Delete attempt errors FIRST (before question_attempts, since it references them)
    BEGIN
        DELETE FROM public.attempt_errors 
        WHERE attempt_id IN (
            SELECT id FROM public.question_attempts WHERE user_id = v_user_id
        );
        RAISE NOTICE 'Deleted attempt_errors';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table attempt_errors does not exist, skipping';
    WHEN undefined_column THEN
        RAISE NOTICE 'Table attempt_errors has unexpected schema, skipping';
    END;

    -- 2. Delete question attempts
    DELETE FROM public.question_attempts WHERE user_id = v_user_id;
    RAISE NOTICE 'Deleted question_attempts';

    -- 3. Delete ALL section progress (both section and algorithmic)
    DELETE FROM public.user_section_progress WHERE user_id = v_user_id;
    RAISE NOTICE 'Deleted user_section_progress';

    -- 4. Delete activities
    DELETE FROM public.activities WHERE user_id = v_user_id;
    RAISE NOTICE 'Deleted activities';

    -- 5. Delete course progress (if exists)
    BEGIN
        DELETE FROM public.course_progress WHERE user_id = v_user_id;
        RAISE NOTICE 'Deleted course_progress';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table course_progress does not exist, skipping';
    END;

    -- 6. Delete user progress (if exists)
    BEGIN
        DELETE FROM public.user_progress WHERE user_id = v_user_id;
        RAISE NOTICE 'Deleted user_progress';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_progress does not exist, skipping';
    END;

    -- 7. Delete practice-related notifications
    DELETE FROM public.notifications 
    WHERE user_id = v_user_id 
    AND text LIKE '[Practice%';
    RAISE NOTICE 'Deleted practice notifications';

    RAISE NOTICE '✅ ALL practice data cleaned for newmao6120@gmail.com';
END $$;

-- Verify: Should all return 0
SELECT 'question_attempts' as t, count(*) FROM question_attempts WHERE user_id IN (SELECT id FROM auth.users WHERE email = 'newmao6120@gmail.com')
UNION ALL
SELECT 'user_section_progress', count(*) FROM user_section_progress WHERE user_id IN (SELECT id FROM auth.users WHERE email = 'newmao6120@gmail.com')
UNION ALL  
SELECT 'activities', count(*) FROM activities WHERE user_id IN (SELECT id FROM auth.users WHERE email = 'newmao6120@gmail.com');
