CREATE OR REPLACE FUNCTION submit_attempt(
    p_question_id TEXT,
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
    SELECT COUNT(*) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = auth.uid() AND question_id = p_question_id;

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
        COALESCE(p_error_tags, '{}'::text[])
    ) RETURNING id INTO v_attempt_id;

    RETURN jsonb_build_object(
        'success', true,
        'attempt_id', v_attempt_id,
        'attempt_no', v_attempt_no,
        'is_correct', p_is_correct
    );
END;
$$;
