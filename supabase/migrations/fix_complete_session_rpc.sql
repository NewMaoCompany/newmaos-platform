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
    -- 1. Update user_section_progress to COMPLETED
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
        'completed', -- Explicitly set to completed
        p_data,
        p_score,
        p_total_questions,
        p_correct_questions,
        NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'completed', -- Force status to completed
        data = p_data,
        score = GREATEST(user_section_progress.score, p_score),
        total_questions = p_total_questions,
        correct_questions = GREATEST(user_section_progress.correct_questions, p_correct_questions),
        last_accessed_at = NOW();

    -- Return success
    RETURN jsonb_build_object('success', true);
EXCEPTION WHEN OTHERS THEN
    -- Log error (optional) or just return false
    RAISE WARNING 'Error in complete_section_session: %', SQLERRM;
    RETURN jsonb_build_object('success', false, 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
