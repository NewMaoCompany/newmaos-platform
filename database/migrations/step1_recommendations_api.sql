-- =====================================================
-- STEP 1: Recommendation Engine Unified Protocol
-- Defines the core RPC interface and handles logging
-- =====================================================

-- Drop the old version if it exists to avoid conflicts
DROP FUNCTION IF EXISTS public.generate_practice_recommendations(uuid, text, text, text, integer, uuid[]);

CREATE OR REPLACE FUNCTION public.generate_practice_recommendations(
    p_user_id UUID,
    p_mode TEXT, -- 'adaptive', 'review', 'random'
    p_topic_id TEXT,
    p_section_id TEXT DEFAULT NULL,
    p_limit INTEGER DEFAULT 20,
    p_exclude_question_ids UUID[] DEFAULT '{}'::UUID[]
)
RETURNS TABLE (
    question_id UUID,
    score NUMERIC,
    reason VARCHAR,
    reason_detail TEXT,
    expires_at TIMESTAMPTZ,
    skill_id VARCHAR
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_expires_at TIMESTAMPTZ := NOW() + INTERVAL '24 hours';
BEGIN
    -- 1. Input Validation
    IF p_mode NOT IN ('adaptive', 'review', 'random') THEN
        RAISE EXCEPTION 'Invalid mode. Must be adaptive, review, or random';
    END IF;

    -- 2. Clear old recommendations for this specific topic to keep it fresh
    -- (Optional, but good practice before a new session generating fresh batch)
    DELETE FROM public.recommendations 
    WHERE public.recommendations.user_id = p_user_id 
      AND (public.recommendations.expires_at < NOW() OR public.recommendations.expires_at IS NULL);

    -- 3. Dynamic Sub-Routing based on Mode (Skeleton for Step 1)
    -- In Step 1, we just build the protocol. We'll use a basic randomized fetch matching the topic/section
    -- to prove the interface and logging work perfectly. The real algorithms plug in here later.

    -- Create a temporary table to hold our results before inserting to recommendations table
    CREATE TEMP TABLE temp_recs (
        q_id UUID,
        r_score NUMERIC,
        r_reason VARCHAR,
        r_reason_detail TEXT,
        r_skill_id VARCHAR
    ) ON COMMIT DROP;

    IF p_mode = 'random' OR p_mode = 'adaptive' OR p_mode = 'review' THEN
        -- Basic fetch pipeline for Step 1 Validation
        INSERT INTO temp_recs (q_id, r_score, r_reason, r_reason_detail, r_skill_id)
        SELECT 
            q.id,
            RANDOM()::NUMERIC AS r_score,
            (CASE 
                WHEN p_mode = 'adaptive' THEN 'adaptive_explore'
                WHEN p_mode = 'review' THEN 'review_due'
                ELSE 'random_bucket'
            END)::VARCHAR AS r_reason,
            json_build_object(
                'mode', p_mode,
                'topic_id', p_topic_id,
                'section_id', p_section_id,
                'generated_at', NOW()
            )::text AS r_reason_detail,
            q.primary_skill_id
        FROM public.questions q
        WHERE q.topic_id = p_topic_id
          AND q.status IN ('active', 'published')
          AND (p_section_id IS NULL OR q.section_id = p_section_id)
          AND NOT (q.id = ANY(COALESCE(p_exclude_question_ids, '{}'::UUID[])))
        ORDER BY RANDOM()
        LIMIT p_limit;
    END IF;

    -- 4. Flush to public.recommendations table (Mandatory Requirement)
    INSERT INTO public.recommendations (
        user_id, question_id, score, reason, reason_detail, skill_id, priority, expires_at
    )
    SELECT 
        p_user_id, 
        t.q_id, 
        t.r_score, 
        t.r_reason, 
        t.r_reason_detail, 
        t.r_skill_id, 
        ROW_NUMBER() OVER(), 
        v_expires_at
    FROM temp_recs t;

    -- 5. Return the exact mapped Output
    RETURN QUERY 
    SELECT 
        t.q_id as question_id,
        t.r_score as score,
        t.r_reason as reason,
        t.r_reason_detail as reason_detail,
        v_expires_at as expires_at,
        t.r_skill_id as skill_id
    FROM temp_recs t;

END;
$$;

-- Grant permissions so frontend can call it securely
GRANT EXECUTE ON FUNCTION public.generate_practice_recommendations(uuid, text, text, text, integer, uuid[]) TO authenticated;
GRANT EXECUTE ON FUNCTION public.generate_practice_recommendations(uuid, text, text, text, integer, uuid[]) TO service_role;
