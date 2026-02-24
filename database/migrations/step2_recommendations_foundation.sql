-- =====================================================
-- STEP 2: Recommendation Engine Data Foundation
-- Indexes, Mapping Views, and Fast Aggregation Functions
-- =====================================================

-- ==========================================
-- 2.1 Performance Indexes (B-Tree & GIN)
-- ==========================================

-- question_attempts
CREATE INDEX IF NOT EXISTS idx_qa_user_created_desc ON public.question_attempts (user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_qa_user_question_created_desc ON public.question_attempts (user_id, question_id, created_at DESC);

-- user_question_state
CREATE INDEX IF NOT EXISTS idx_uqs_user_next_review ON public.user_question_state (user_id, next_review_at);

-- questions
CREATE INDEX IF NOT EXISTS idx_q_topic_status ON public.questions (topic_id, status);
CREATE INDEX IF NOT EXISTS idx_q_topic_section_status ON public.questions (topic_id, section_id, status);

-- question_skills
CREATE INDEX IF NOT EXISTS idx_qs_skill_question ON public.question_skills (skill_id, question_id);

-- attempt_errors
CREATE INDEX IF NOT EXISTS idx_ae_error_tag_id ON public.attempt_errors (error_tag_id);
-- The attempt_errors table has attempt_id as the primary key constraint alongside error_tag_id, 
-- but a dedicated index on attempt_id helps joins.
CREATE INDEX IF NOT EXISTS idx_ae_attempt_id ON public.attempt_errors (attempt_id);

-- GIN Indexes for Array Fields in questions
-- Need to use GIN indexing since they are arrays
CREATE INDEX IF NOT EXISTS idx_q_error_tags_gin ON public.questions USING GIN (error_tags);
CREATE INDEX IF NOT EXISTS idx_q_supporting_skill_ids_gin ON public.questions USING GIN (supporting_skill_ids);
CREATE INDEX IF NOT EXISTS idx_q_skill_tags_gin ON public.questions USING GIN (skill_tags);


-- ==========================================
-- 2.2 Mapping Cache Views
-- ==========================================

-- Skill Mapping View
CREATE OR REPLACE VIEW public.v_skill_cluster_map AS
SELECT 
    s.id AS skill_id,
    c.id AS cluster_id,
    c.name AS cluster_name,
    c.category AS cluster_category
FROM public.skills s
LEFT JOIN public.skill_clusters c ON s.cluster_id = c.id;

-- Error Tag Mapping View
CREATE OR REPLACE VIEW public.v_error_cluster_map AS
SELECT 
    e.id AS error_tag_id,
    c.id AS cluster_id,
    c.name AS cluster_name,
    c.category AS cluster_category
FROM public.error_tags e
LEFT JOIN public.error_tag_clusters c ON e.cluster_id = c.id;


-- ==========================================
-- 2.3 Core Aggregation Functions
-- ==========================================

-- A) get_recent_attempts(user_id, k)
DROP FUNCTION IF EXISTS public.get_recent_attempts(uuid, integer);
CREATE OR REPLACE FUNCTION public.get_recent_attempts(
    p_user_id UUID,
    p_k INTEGER DEFAULT 10
)
RETURNS TABLE (
    question_id UUID,
    is_correct BOOLEAN,
    time_spent_seconds NUMERIC,
    created_at TIMESTAMPTZ
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        qa.question_id, 
        qa.is_correct, 
        qa.time_spent_seconds::NUMERIC, 
        qa.created_at
    FROM public.question_attempts qa
    WHERE qa.user_id = p_user_id
    ORDER BY qa.created_at DESC
    LIMIT p_k;
END;
$$;


-- B) get_recent_error_frequencies(user_id, days)
DROP FUNCTION IF EXISTS public.get_recent_error_frequencies(uuid, integer);
CREATE OR REPLACE FUNCTION public.get_recent_error_frequencies(
    p_user_id UUID,
    p_days INTEGER DEFAULT 7
)
RETURNS TABLE (
    error_tag_id TEXT,
    count BIGINT
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN QUERY 
    -- We can extract error tags from attempting directly if they are stored in the array
    -- Or we can join through attempt_errors if that's being populated
    -- We'll union both sources to be perfectly safe, but using the array is much faster if maintained:
    SELECT 
        unnest(qa.error_tags) AS error_tag_id,
        COUNT(*) AS count
    FROM public.question_attempts qa
    WHERE qa.user_id = p_user_id
      AND qa.created_at >= NOW() - (p_days || ' days')::INTERVAL
      AND array_length(qa.error_tags, 1) > 0
    GROUP BY unnest(qa.error_tags)
    ORDER BY count DESC;
END;
$$;


-- C) get_normalized_skill_mastery(user_id)
DROP FUNCTION IF EXISTS public.get_normalized_skill_mastery(uuid);
CREATE OR REPLACE FUNCTION public.get_normalized_skill_mastery(
    p_user_id UUID
)
RETURNS TABLE (
    skill_id VARCHAR,
    normalized_mastery NUMERIC,
    confidence NUMERIC
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        usm.skill_id,
        (usm.mastery_score / 100.0)::NUMERIC AS normalized_mastery,
        usm.confidence
    FROM public.user_skill_mastery usm
    WHERE usm.user_id = p_user_id;
END;
$$;


-- Grant permissions
GRANT SELECT ON public.v_skill_cluster_map TO authenticated, service_role;
GRANT SELECT ON public.v_error_cluster_map TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.get_recent_attempts(uuid, integer) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.get_recent_error_frequencies(uuid, integer) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.get_normalized_skill_mastery(uuid) TO authenticated, service_role;
