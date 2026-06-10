-- ============================================================
-- COMPLETELY DELETE A USER AND ALL THEIR DATA
-- Run this in Supabase SQL Editor.
-- Replace '27zc0001@wwprsd.org' with the email of the user you want to delete.
-- ============================================================

DO $$
DECLARE
    v_target_user_id UUID;
BEGIN
    -- 1. Find the user ID by email
    SELECT id INTO v_target_user_id
    FROM auth.users
    WHERE email = '27zc0001@wwprsd.org';

    IF v_target_user_id IS NULL THEN
        RAISE EXCEPTION 'User not found. Please check the email.';
    END IF;

    -- 2. Delete all dependencies safely
    -- We use dynamic SQL to ignore missing tables
    
    -- List of known tables with user_id or author_id
    BEGIN EXECUTE 'DELETE FROM public.question_attempts WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.points_ledger WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.user_points WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.user_section_progress WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.user_stats WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.user_question_state WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.activities WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.user_titles WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.recommendations WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.unit_mastery WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.user_skill_mastery WHERE user_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.friends WHERE user_id = $1 OR friend_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.friend_requests WHERE sender_id = $1 OR receiver_id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;

    -- Finally, delete the public.user_profiles
    BEGIN EXECUTE 'DELETE FROM public.user_profiles WHERE id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;
    BEGIN EXECUTE 'DELETE FROM public.users WHERE id = $1' USING v_target_user_id; EXCEPTION WHEN OTHERS THEN END;

    -- 3. Delete the user from auth.users (Authentication)
    DELETE FROM auth.users WHERE id = v_target_user_id;

    RAISE NOTICE 'Successfully deleted user % and all associated data.', v_target_user_id;
END $$;
