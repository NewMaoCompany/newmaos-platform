-- =====================================================
-- Progress Tracking RPC
-- Run this in Supabase SQL Editor
-- Adds get_topic_progress function
-- =====================================================

CREATE OR REPLACE FUNCTION get_topic_progress(p_topic_id VARCHAR, p_user_id UUID)
RETURNS TABLE (
    sub_topic_id VARCHAR(20),
    total_questions BIGINT,
    attempted_questions BIGINT,
    correct_questions BIGINT,
    last_activity TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    WITH topic_questions AS (
        SELECT id, sub_topic_id
        FROM public.questions
        WHERE topic = p_topic_id
          AND status IN ('active', 'published')
    ),
    user_attempts AS (
        SELECT 
            qa.question_id,
            qa.is_correct,
            qa.created_at
        FROM public.question_attempts qa
        WHERE qa.user_id = p_user_id
    )
    SELECT 
        tq.sub_topic_id,
        COUNT(DISTINCT tq.id) AS total_questions,
        COUNT(DISTINCT ua.question_id) AS attempted_questions,
        COUNT(DISTINCT CASE WHEN ua.is_correct THEN ua.question_id END) AS correct_questions,
        MAX(ua.created_at) AS last_activity
    FROM topic_questions tq
    LEFT JOIN user_attempts ua ON tq.id = ua.question_id
    WHERE tq.sub_topic_id IS NOT NULL
    GROUP BY tq.sub_topic_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
