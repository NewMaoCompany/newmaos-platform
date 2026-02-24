-- =====================================================
-- NUCLEAR FIX: Submit Attempt + Progress Functions
-- 
-- Root cause: uuid = text type mismatch in WHERE clauses
-- question_attempts.question_id is UUID in the actual DB
-- but functions pass TEXT parameters without casting.
-- =====================================================

-- 1. NUCLEAR DROP ALL submit_attempt overloads
DROP FUNCTION IF EXISTS public.submit_attempt(text, boolean, text, numeric, numeric, text[]);
DROP FUNCTION IF EXISTS public.submit_attempt(uuid, boolean, text, numeric, numeric, text[]);
DROP FUNCTION IF EXISTS public.submit_attempt(text, boolean, text, numeric, integer, text[]);
DROP FUNCTION IF EXISTS public.submit_attempt(uuid, boolean, text, numeric, integer, text[]);
DROP FUNCTION IF EXISTS public.submit_attempt(uuid, boolean, character varying, numeric, integer, text[]);
DROP FUNCTION IF EXISTS public.submit_attempt(text, boolean, character varying, numeric, integer, text[]);
DROP FUNCTION IF EXISTS public.submit_attempt(uuid, boolean, jsonb, integer, text);
DROP FUNCTION IF EXISTS public.submit_attempt(text, boolean, jsonb, integer, text);

-- 2. Recreate with explicit UUID casting
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
    -- Cast TEXT to UUID for comparison with UUID column
    SELECT COUNT(*) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = auth.uid() AND question_id = p_question_id::UUID;

    INSERT INTO public.question_attempts (
        user_id, question_id, is_correct,
        selected_option_id, answer_numeric,
        time_spent_seconds, error_tags
    ) VALUES (
        auth.uid(), p_question_id::UUID, p_is_correct,
        p_selected_option_id, p_answer_numeric,
        COALESCE(p_time_spent_seconds, 0),
        COALESCE(p_error_tags, '{}')
    ) RETURNING id INTO v_attempt_id;

    RETURN jsonb_build_object(
        'success', true,
        'attempt_id', v_attempt_id,
        'attempt_no', v_attempt_no,
        'is_correct', p_is_correct
    );
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object(
        'success', false,
        'error', SQLERRM
    );
END;
$$;

GRANT EXECUTE ON FUNCTION submit_attempt(TEXT, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO authenticated;
GRANT EXECUTE ON FUNCTION submit_attempt(TEXT, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO service_role;


-- =====================================================
-- 3. Progress Functions
-- =====================================================

DROP FUNCTION IF EXISTS get_unit_progress_stats(UUID, TEXT);
DROP FUNCTION IF EXISTS get_course_progress_stats(UUID, TEXT);

-- Unit Progress = correctly-answered unique questions / total questions × 100%
CREATE OR REPLACE FUNCTION get_unit_progress_stats(p_user_id UUID, p_topic_id TEXT)
RETURNS JSONB AS $func$
DECLARE
    v_total INT := 0;
    v_correct INT := 0;
    v_pct FLOAT := 0;
    v_base_topic TEXT;
BEGIN
    IF position('_' in p_topic_id) > 0 THEN
        v_base_topic := substring(p_topic_id from position('_' in p_topic_id) + 1);
    ELSE
        v_base_topic := p_topic_id;
    END IF;

    -- Count ALL published/active questions for this topic
    SELECT COUNT(*) INTO v_total
    FROM public.questions q
    WHERE (q.status = 'published' OR q.status = 'active')
      AND (
          q.topic = p_topic_id
          OR q.topic = 'Both_' || v_base_topic
          OR q.topic = 'AB_' || v_base_topic
          OR q.topic = 'BC_' || v_base_topic
          OR q.topic LIKE '%\_' || v_base_topic
      );

    -- Count unique questions answered correctly at least once
    -- question_attempts.question_id is UUID, questions.id is UUID — direct join works
    SELECT COUNT(DISTINCT qa.question_id) INTO v_correct
    FROM public.question_attempts qa
    JOIN public.questions q ON qa.question_id = q.id
    WHERE qa.user_id = p_user_id
      AND qa.is_correct = true
      AND (q.status = 'published' OR q.status = 'active')
      AND (
          q.topic = p_topic_id
          OR q.topic = 'Both_' || v_base_topic
          OR q.topic = 'AB_' || v_base_topic
          OR q.topic = 'BC_' || v_base_topic
          OR q.topic LIKE '%\_' || v_base_topic
      );

    IF v_total > 0 THEN
        v_pct := (v_correct::FLOAT / v_total) * 100.0;
    END IF;

    RETURN jsonb_build_object(
        'unit_id', p_topic_id,
        'progress_percentage', ROUND(v_pct::NUMERIC, 1),
        'questions_correct', v_correct,
        'questions_total', v_total
    );
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;


-- Course Progress = average of all unit progresses
CREATE OR REPLACE FUNCTION get_course_progress_stats(p_user_id UUID, p_course_scope TEXT DEFAULT 'Both')
RETURNS JSONB AS $func$
DECLARE
    v_avg_progress FLOAT := 0;
    v_unit_count INT := 0;
BEGIN
    WITH unit_scores AS (
        SELECT
            s.topic_id,
            (get_unit_progress_stats(p_user_id, s.topic_id)->>'progress_percentage')::FLOAT as score
        FROM sections s
        WHERE (s.course_scope = p_course_scope OR s.course_scope = 'both' OR p_course_scope = 'Both')
        GROUP BY s.topic_id
    )
    SELECT AVG(score), COUNT(*) INTO v_avg_progress, v_unit_count FROM unit_scores;

    RETURN jsonb_build_object(
        'course', p_course_scope,
        'progress_percentage', ROUND(COALESCE(v_avg_progress, 0)::NUMERIC, 1),
        'unit_count', v_unit_count
    );
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;
