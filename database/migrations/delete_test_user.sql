-- ============================================================
-- COMPLETELY DELETE A USER AND ALL THEIR DATA
-- Run this in Supabase SQL Editor.
-- Replace 'newmao6120@gmail.com' with the email of the user you want to delete.
-- ============================================================

DO $$
DECLARE
    v_target_user_id UUID;
BEGIN
    -- 1. Find the user ID by email
    SELECT id INTO v_target_user_id
    FROM auth.users
    WHERE email = 'newmao6120@gmail.com';

    IF v_target_user_id IS NULL THEN
        RAISE EXCEPTION 'User not found. Please check the email.';
    END IF;

    -- 2. Delete all dependencies in public schema (to avoid foreign key errors)
    DELETE FROM public.question_attempts WHERE user_id = v_target_user_id;
    DELETE FROM public.points_ledger WHERE user_id = v_target_user_id;
    DELETE FROM public.user_points WHERE user_id = v_target_user_id;
    DELETE FROM public.user_section_progress WHERE user_id = v_target_user_id;
    DELETE FROM public.user_stats WHERE user_id = v_target_user_id;
    DELETE FROM public.user_question_state WHERE user_id = v_target_user_id;
    DELETE FROM public.activities WHERE user_id = v_target_user_id;
    DELETE FROM public.user_titles WHERE user_id = v_target_user_id;
    DELETE FROM public.user_badges WHERE user_id = v_target_user_id;
    DELETE FROM public.forum_posts WHERE author_id = v_target_user_id;
    DELETE FROM public.forum_comments WHERE author_id = v_target_user_id;
    DELETE FROM public.forum_likes WHERE user_id = v_target_user_id;
    DELETE FROM public.user_prestige WHERE user_id = v_target_user_id;
    
    -- Finally, delete the public.users profile
    DELETE FROM public.users WHERE id = v_target_user_id;

    -- 3. Delete the user from auth.users (Authentication)
    DELETE FROM auth.users WHERE id = v_target_user_id;

    RAISE NOTICE 'Successfully deleted user % and all associated data.', v_target_user_id;
END $$;
