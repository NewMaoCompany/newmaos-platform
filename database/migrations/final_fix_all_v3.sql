-- ============================================================
-- FINAL CONSOLIDATED FIX for Progress Tracking
-- Run this ENTIRE file in Supabase SQL Editor to fix all issues.
-- ============================================================

-- 0. PRE-CLEANUP: Drop existing functions to avoid signature conflicts
-- (This resolves the "cannot remove parameter defaults" error)
DROP FUNCTION IF EXISTS save_section_progress(VARCHAR, JSONB, INTEGER, VARCHAR);
DROP FUNCTION IF EXISTS complete_section_session(VARCHAR, INTEGER, INTEGER, INTEGER, JSONB);
DROP FUNCTION IF EXISTS get_all_user_progress();


-- 1. FIX: save_section_progress (Prevent Overwriting 'Completed')
-- This ensures that auto-save does NOT revert a completed unit to in_progress.
CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id VARCHAR,
    p_data JSONB,
    p_time_spent INTEGER,
    p_entity_type VARCHAR DEFAULT 'section'
) RETURNS BOOLEAN AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    -- Update or Insert
    INSERT INTO public.user_section_progress (
        user_id,
        section_id,
        status,
        data,
        last_accessed_at
    ) VALUES (
        v_user_id,
        p_section_id,
        'in_progress',
        p_data,
        NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        -- PROTECTION: Only update status to 'in_progress' if it's NOT ALREADY 'completed'
        status = CASE 
            WHEN user_section_progress.status = 'completed' THEN 'completed' 
            ELSE 'in_progress' 
        END,
        data = p_data,
        last_accessed_at = NOW();

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 2. FIX: complete_section_session (Safe Completion)
-- Removes dependency on 'sections' table to ensure completion saving never fails.
CREATE OR REPLACE FUNCTION complete_section_session(
    p_section_id VARCHAR,
    p_score INTEGER,
    p_total_questions INTEGER,
    p_correct_questions INTEGER,
    p_data JSONB
) RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    -- Always Force COMPLETED status
    INSERT INTO public.user_section_progress (
        user_id,
        section_id,
        status,
        data,
        score,
        total_questions,
        correct_questions,
        last_accessed_at
    ) VALUES (
        v_user_id,
        p_section_id,
        'completed',
        p_data,
        p_score,
        p_total_questions,
        p_correct_questions,
        NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'completed',
        data = p_data,
        score = GREATEST(user_section_progress.score, p_score),
        total_questions = p_total_questions,
        correct_questions = GREATEST(user_section_progress.correct_questions, p_correct_questions),
        last_accessed_at = NOW();

    RETURN jsonb_build_object('success', true);
EXCEPTION WHEN OTHERS THEN
    RAISE WARNING 'Error in complete_section_session: %', SQLERRM;
    RETURN jsonb_build_object('success', false, 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 3. FIX: get_all_user_progress (NO PARAMETERS)
-- Matches frontend call signature and bypasses RLS issues.
CREATE OR REPLACE FUNCTION get_all_user_progress()
RETURNS TABLE (
    section_id VARCHAR,
    status VARCHAR,
    data JSONB,
    score INTEGER,
    correct_questions INTEGER,
    total_questions INTEGER,
    last_accessed_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        usp.section_id,
        usp.status,
        usp.data,
        usp.score,
        usp.correct_questions,
        usp.total_questions,
        usp.last_accessed_at
    FROM public.user_section_progress usp
    WHERE usp.user_id = auth.uid();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
