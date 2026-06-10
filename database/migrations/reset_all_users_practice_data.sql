-- ============================================================
-- GLOBAL PRACTICE DATA RESET (Keeps Coins, Titles, Prestige)
-- Run ALL statements in Supabase SQL Editor
-- ============================================================

DO $$
BEGIN
    -- 1. Delete dependent error records
    BEGIN
        DELETE FROM public.attempt_errors;
        RAISE NOTICE 'Deleted attempt_errors';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table attempt_errors does not exist, skipping';
    END;

    -- 2. Delete all question attempts
    BEGIN
        DELETE FROM public.question_attempts;
        RAISE NOTICE 'Deleted question_attempts';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table question_attempts does not exist, skipping';
    END;

    -- 3. Delete all section progress
    BEGIN
        DELETE FROM public.user_section_progress;
        RAISE NOTICE 'Deleted user_section_progress';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_section_progress does not exist, skipping';
    END;

    -- 4. Delete activities (history events)
    BEGIN
        DELETE FROM public.activities;
        RAISE NOTICE 'Deleted activities';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table activities does not exist, skipping';
    END;

    -- 5. Delete course progress
    BEGIN
        DELETE FROM public.course_progress;
        RAISE NOTICE 'Deleted course_progress';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table course_progress does not exist, skipping';
    END;

    -- 6. Delete user progress
    BEGIN
        DELETE FROM public.user_progress;
        RAISE NOTICE 'Deleted user_progress';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_progress does not exist, skipping';
    END;

    -- 7. Delete recommendations
    BEGIN
        DELETE FROM public.recommendations;
        RAISE NOTICE 'Deleted recommendations';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table recommendations does not exist, skipping';
    END;

    -- 8. Delete user question states (starred, notes, spaced repetition)
    BEGIN
        DELETE FROM public.user_question_state;
        RAISE NOTICE 'Deleted user_question_state';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_question_state does not exist, skipping';
    END;

    -- 9. Delete unit mastery
    BEGIN
        DELETE FROM public.unit_mastery;
        RAISE NOTICE 'Deleted unit_mastery';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table unit_mastery does not exist, skipping';
    END;

    -- 10. Delete skill mastery
    BEGIN
        DELETE FROM public.user_skill_mastery;
        RAISE NOTICE 'Deleted user_skill_mastery';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_skill_mastery does not exist, skipping';
    END;

    -- 11. Reset user_stats (Analysis Data)
    BEGIN
        UPDATE public.user_stats SET 
            total_attempts = 0,
            correct_attempts = 0,
            accuracy_rate = 0,
            unique_questions_attempted = 0,
            total_time_spent_seconds = 0;
        RAISE NOTICE 'Reset user_stats';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_stats does not exist, skipping';
    END;

    -- 12. Reset specific fields in user_profiles
    BEGIN
        UPDATE public.user_profiles SET
            problems_solved = 0,
            study_hours = '[0, 0, 0, 0, 0, 0, 0]'::jsonb;
        RAISE NOTICE 'Reset user_profiles learning fields';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table user_profiles does not exist, skipping';
    END;

    -- 13. Delete practice-related notifications
    BEGIN
        DELETE FROM public.notifications 
        WHERE text LIKE '[Practice%';
        RAISE NOTICE 'Deleted practice notifications';
    EXCEPTION WHEN undefined_table THEN
        RAISE NOTICE 'Table notifications does not exist, skipping';
    END;

    RAISE NOTICE '✅ ALL GLOBAL PRACTICE DATA HAS BEEN CLEARED SUCCESSFULLY.';
END $$;
