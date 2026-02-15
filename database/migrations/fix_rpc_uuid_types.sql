-- =====================================================
-- FIX: UUID Type Mismatch in RPC
-- =====================================================

-- 1. Drop the incorrect TEXT version (which caused the error)
DROP FUNCTION IF EXISTS public.submit_attempt(text, boolean, text, numeric, numeric, text[]);

-- 2. Drop potential UUID version to ensure clean slate
DROP FUNCTION IF EXISTS public.submit_attempt(uuid, boolean, text, numeric, numeric, text[]);

-- 3. Re-define RPC with **UUID** parameter for question_id
-- This matches the existing table schema where question_id is likely UUID type.
CREATE OR REPLACE FUNCTION submit_attempt(
    p_question_id UUID,  -- Changed from TEXT to UUID
    p_is_correct BOOLEAN,
    p_selected_option_id TEXT DEFAULT NULL,
    p_answer_numeric NUMERIC DEFAULT NULL,
    p_time_spent_seconds NUMERIC DEFAULT 0,
    p_error_tags TEXT[] DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_attempt_id UUID;
    v_attempt_no INT;
BEGIN
    -- Calculate attempt number
    -- Now comparing UUID = UUID (Valid)
    SELECT COUNT(*) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = auth.uid() AND question_id = p_question_id;

    -- Insert record
    INSERT INTO public.question_attempts (
        user_id,
        question_id,
        is_correct,
        selected_option_id,
        answer_numeric,
        time_spent_seconds,
        error_tags
    ) VALUES (
        auth.uid(),
        p_question_id,
        p_is_correct,
        p_selected_option_id,
        p_answer_numeric,
        COALESCE(p_time_spent_seconds, 0),
        COALESCE(p_error_tags, '{}')
    ) RETURNING id INTO v_attempt_id;

    RETURN jsonb_build_object(
        'success', true,
        'attempt_id', v_attempt_id,
        'attempt_no', v_attempt_no
    );
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object(
        'success', false,
        'error', SQLERRM
    );
END;
$$;

-- Grant permissions
GRANT EXECUTE ON FUNCTION submit_attempt(UUID, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO authenticated;
GRANT EXECUTE ON FUNCTION submit_attempt(UUID, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO service_role;
