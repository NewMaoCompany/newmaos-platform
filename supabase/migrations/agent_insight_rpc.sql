-- =====================================================
-- Agent Insight RPC Functions
-- Run this AFTER agent_insight_triggers.sql
-- Provides atomic operations for frontend
-- =====================================================

-- =====================================================
-- PART 1: submit_attempt RPC
-- Atomic operation for submitting an answer
-- =====================================================

CREATE OR REPLACE FUNCTION submit_attempt(
    p_question_id UUID,
    p_is_correct BOOLEAN,
    p_selected_option_id VARCHAR(100) DEFAULT NULL,
    p_answer_numeric NUMERIC DEFAULT NULL,
    p_time_spent_seconds INTEGER DEFAULT 0,
    p_error_tags TEXT[] DEFAULT '{}'
) RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_attempt_id UUID;
    v_attempt_no INTEGER;
    v_question_version_id UUID;
    v_tag TEXT;
BEGIN
    -- Validate user
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'User not authenticated';
    END IF;

    -- Get attempt number for this user-question pair
    SELECT COALESCE(MAX(attempt_no), 0) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = v_user_id AND question_id = p_question_id;

    -- Get latest question version
    SELECT id INTO v_question_version_id
    FROM public.question_versions
    WHERE question_id = p_question_id
    ORDER BY version DESC
    LIMIT 1;

    -- Insert attempt (triggers will handle the rest)
    INSERT INTO public.question_attempts (
        user_id,
        question_id,
        is_correct,
        selected_option_id,
        answer_numeric,
        time_spent_seconds,
        attempt_no,
        error_tags,
        question_version_id
    ) VALUES (
        v_user_id,
        p_question_id,
        p_is_correct,
        p_selected_option_id,
        p_answer_numeric,
        p_time_spent_seconds,
        v_attempt_no,
        p_error_tags,
        v_question_version_id
    )
    RETURNING id INTO v_attempt_id;

    -- Insert error tags into attempt_errors
    FOREACH v_tag IN ARRAY p_error_tags
    LOOP
        INSERT INTO public.attempt_errors (attempt_id, error_tag_id)
        VALUES (v_attempt_id, v_tag)
        ON CONFLICT DO NOTHING;
    END LOOP;

    -- Return result
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
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- PART 2: get_user_insights RPC
-- Returns comprehensive user analytics
-- =====================================================

CREATE OR REPLACE FUNCTION get_user_insights()
RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_stats JSONB;
    v_weak_skills JSONB;
    v_top_errors JSONB;
    v_review_queue JSONB;
    v_recommendations JSONB;
BEGIN
    -- Validate user
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'User not authenticated';
    END IF;

    -- Get user stats
    SELECT jsonb_build_object(
        'total_attempts', total_attempts,
        'correct_attempts', correct_attempts,
        'accuracy_rate', accuracy_rate,
        'unique_questions', unique_questions_attempted,
        'streak_days', current_streak_days,
        'longest_streak', longest_streak_days,
        'total_time_minutes', ROUND(total_time_spent_seconds / 60.0, 1),
        'last_practiced', last_practiced
    ) INTO v_stats
    FROM public.user_stats
    WHERE user_id = v_user_id;

    -- Get weakest skills (top 5)
    SELECT COALESCE(jsonb_agg(skill_data), '[]'::jsonb) INTO v_weak_skills
    FROM (
        SELECT jsonb_build_object(
            'skill_id', usm.skill_id,
            'skill_name', s.name,
            'mastery', usm.mastery_score,
            'confidence', usm.confidence,
            'streak_wrong', usm.streak_wrong
        ) AS skill_data
        FROM public.user_skill_mastery usm
        JOIN public.skills s ON s.id = usm.skill_id
        WHERE usm.user_id = v_user_id
        ORDER BY usm.mastery_score ASC
        LIMIT 5
    ) sub;

    -- Get top error types (top 5)
    SELECT COALESCE(jsonb_agg(error_data), '[]'::jsonb) INTO v_top_errors
    FROM (
        SELECT jsonb_build_object(
            'error_tag_id', ae.error_tag_id,
            'error_name', et.name,
            'category', et.category,
            'count', COUNT(*)
        ) AS error_data
        FROM public.attempt_errors ae
        JOIN public.question_attempts qa ON qa.id = ae.attempt_id
        JOIN public.error_tags et ON et.id = ae.error_tag_id
        WHERE qa.user_id = v_user_id
        GROUP BY ae.error_tag_id, et.name, et.category
        ORDER BY COUNT(*) DESC
        LIMIT 5
    ) sub;

    -- Get review queue (due for review)
    SELECT COALESCE(jsonb_agg(review_data), '[]'::jsonb) INTO v_review_queue
    FROM (
        SELECT jsonb_build_object(
            'question_id', uqs.question_id,
            'next_review_at', uqs.next_review_at,
            'review_count', uqs.review_count,
            'interval_days', uqs.interval_days
        ) AS review_data
        FROM public.user_question_state uqs
        WHERE uqs.user_id = v_user_id
          AND uqs.next_review_at <= NOW() + INTERVAL '1 day'
        ORDER BY uqs.next_review_at ASC
        LIMIT 10
    ) sub;

    -- Generate fresh recommendations
    PERFORM generate_recommendations(v_user_id);

    -- Get recommendations
    SELECT COALESCE(jsonb_agg(rec_data), '[]'::jsonb) INTO v_recommendations
    FROM (
        SELECT jsonb_build_object(
            'question_id', r.question_id,
            'score', r.score,
            'reason', r.reason,
            'reason_detail', r.reason_detail,
            'skill_id', r.skill_id
        ) AS rec_data
        FROM public.recommendations r
        WHERE r.user_id = v_user_id
        ORDER BY r.priority ASC
        LIMIT 10
    ) sub;

    -- Return complete insights
    RETURN jsonb_build_object(
        'stats', COALESCE(v_stats, '{}'::jsonb),
        'weak_skills', v_weak_skills,
        'top_errors', v_top_errors,
        'review_queue', v_review_queue,
        'recommendations', v_recommendations
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- PART 3: get_review_queue RPC
-- Returns questions due for spaced repetition review
-- =====================================================

CREATE OR REPLACE FUNCTION get_review_queue(p_limit INTEGER DEFAULT 20)
RETURNS TABLE (
    question_id UUID,
    next_review_at TIMESTAMPTZ,
    review_count INTEGER,
    interval_days INTEGER,
    is_overdue BOOLEAN,
    question_topic VARCHAR(50),
    question_prompt TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        uqs.question_id,
        uqs.next_review_at,
        uqs.review_count,
        uqs.interval_days,
        uqs.next_review_at < NOW() AS is_overdue,
        q.topic_id AS question_topic,
        LEFT(q.prompt, 100) AS question_prompt
    FROM public.user_question_state uqs
    JOIN public.questions q ON q.id = uqs.question_id
    WHERE uqs.user_id = auth.uid()
      AND uqs.next_review_at IS NOT NULL
    ORDER BY 
        CASE WHEN uqs.next_review_at < NOW() THEN 0 ELSE 1 END,
        uqs.next_review_at ASC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- PART 4: Question State Management RPCs
-- =====================================================

-- Mark question as starred
CREATE OR REPLACE FUNCTION toggle_question_starred(p_question_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    v_new_state BOOLEAN;
BEGIN
    INSERT INTO public.user_question_state (user_id, question_id, is_starred)
    VALUES (auth.uid(), p_question_id, true)
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        is_starred = NOT user_question_state.is_starred,
        updated_at = NOW()
    RETURNING is_starred INTO v_new_state;

    RETURN v_new_state;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Mark question as flagged
CREATE OR REPLACE FUNCTION toggle_question_flagged(p_question_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    v_new_state BOOLEAN;
BEGIN
    INSERT INTO public.user_question_state (user_id, question_id, is_flagged)
    VALUES (auth.uid(), p_question_id, true)
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        is_flagged = NOT user_question_state.is_flagged,
        updated_at = NOW()
    RETURNING is_flagged INTO v_new_state;

    RETURN v_new_state;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Add personal note to question
CREATE OR REPLACE FUNCTION update_question_note(
    p_question_id UUID,
    p_note TEXT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO public.user_question_state (user_id, question_id, personal_note)
    VALUES (auth.uid(), p_question_id, p_note)
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        personal_note = p_note,
        updated_at = NOW();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Add personal tags to question
CREATE OR REPLACE FUNCTION update_question_tags(
    p_question_id UUID,
    p_tags TEXT[]
) RETURNS VOID AS $$
BEGIN
    INSERT INTO public.user_question_state (user_id, question_id, personal_tags)
    VALUES (auth.uid(), p_question_id, p_tags)
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        personal_tags = p_tags,
        updated_at = NOW();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- PART 5: Get starred/flagged questions
-- =====================================================

CREATE OR REPLACE FUNCTION get_starred_questions(p_limit INTEGER DEFAULT 50)
RETURNS TABLE (
    question_id UUID,
    question_prompt TEXT,
    topic_id VARCHAR(50),
    difficulty INTEGER,
    starred_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        uqs.question_id,
        q.prompt AS question_prompt,
        q.topic_id,
        q.difficulty,
        uqs.created_at AS starred_at
    FROM public.user_question_state uqs
    JOIN public.questions q ON q.id = uqs.question_id
    WHERE uqs.user_id = auth.uid()
      AND uqs.is_starred = true
    ORDER BY uqs.updated_at DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_flagged_questions(p_limit INTEGER DEFAULT 50)
RETURNS TABLE (
    question_id UUID,
    question_prompt TEXT,
    topic_id VARCHAR(50),
    difficulty INTEGER,
    flagged_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        uqs.question_id,
        q.prompt AS question_prompt,
        q.topic_id,
        q.difficulty,
        uqs.created_at AS flagged_at
    FROM public.user_question_state uqs
    JOIN public.questions q ON q.id = uqs.question_id
    WHERE uqs.user_id = auth.uid()
      AND uqs.is_flagged = true
    ORDER BY uqs.updated_at DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- DONE!
-- =====================================================
-- RPC Functions complete:
-- ✅ submit_attempt() - Atomic answer submission
-- ✅ get_user_insights() - Complete user analytics
-- ✅ get_review_queue() - Spaced repetition queue
-- ✅ toggle_question_starred() - Star/unstar question
-- ✅ toggle_question_flagged() - Flag/unflag question
-- ✅ update_question_note() - Add personal note
-- ✅ update_question_tags() - Add personal tags
-- ✅ get_starred_questions() - Get starred list
-- ✅ get_flagged_questions() - Get flagged list
