-- =====================================================
-- STEP 5: Candidate Generation Engine
-- Unified filter and dynamic fetches per mode
-- =====================================================

DROP FUNCTION IF EXISTS public.get_recommendation_candidates(uuid, text, text, text, integer, uuid[]);

CREATE OR REPLACE FUNCTION public.get_recommendation_candidates(
    p_user_id UUID,
    p_mode TEXT,
    p_topic_id TEXT,
    p_section_id TEXT DEFAULT NULL,
    p_limit INTEGER DEFAULT 20,
    p_exclude_question_ids UUID[] DEFAULT '{}'::UUID[]
)
RETURNS TABLE (
    question_id UUID,
    reason VARCHAR,
    b_i NUMERIC,
    w_is JSONB,
    c_i VARCHAR[],
    t_target INTEGER,
    cluster_penalty INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    -- General Filter Variables
    v_recent_ids UUID[];
    v_over_attempted_ids UUID[];
    v_due_review_ids UUID[];
    v_exclude UUID[];
    
    -- Cluster Penalty Variables
    v_recent_clusters VARCHAR[];
    
    -- Mode Specific
    v_weak_skills VARCHAR[];
    v_weak_clusters VARCHAR[];
    v_mid_clusters VARCHAR[];
    v_strong_clusters VARCHAR[];
    v_error_clusters VARCHAR[];
BEGIN
    
    -- ==========================================
    -- 5.1 GENERAL FILTERS & CLUSTER PENALTY PREP
    -- ==========================================

    -- 1. Get Due Review IDs (We NEVER exclude due reviews)
    SELECT array_agg(q_id) INTO v_due_review_ids
    FROM (
        SELECT qs.question_id as q_id
        FROM public.user_question_state qs
        WHERE qs.user_id = p_user_id
          AND qs.next_review_at <= NOW()
    ) sub;
    v_due_review_ids := COALESCE(v_due_review_ids, '{}'::UUID[]);

    -- 2. Exclude questions done in the last 30 minutes
    SELECT array_agg(q_id) INTO v_recent_ids
    FROM (
        SELECT DISTINCT qa.question_id as q_id
        FROM public.question_attempts qa
        WHERE qa.user_id = p_user_id 
          AND qa.created_at > NOW() - INTERVAL '30 minutes'
    ) sub;
    v_recent_ids := COALESCE(v_recent_ids, '{}'::UUID[]);

    -- 3. Exclude questions repeated > 3 times (unless DUE)
    SELECT array_agg(q_id) INTO v_over_attempted_ids
    FROM (
        SELECT qa.question_id as q_id
        FROM public.question_attempts qa
        WHERE qa.user_id = p_user_id
        GROUP BY qa.question_id
        HAVING COUNT(qa.id) > 3
    ) sub
    WHERE NOT (q_id = ANY(v_due_review_ids));
    v_over_attempted_ids := COALESCE(v_over_attempted_ids, '{}'::UUID[]);

    -- 4. Combine all exclusions
    v_exclude := COALESCE(p_exclude_question_ids, '{}'::UUID[]) || v_recent_ids || v_over_attempted_ids;

    -- 5. Calculate Recent Clusters for Penalty (last 10 attempts)
    SELECT array_agg(c_id) INTO v_recent_clusters
    FROM (
        SELECT c.id as c_id
        FROM public.get_recent_attempts(p_user_id, 10) ra
        JOIN public.questions q ON q.id = ra.question_id
        JOIN public.skills s ON s.id = q.primary_skill_id
        JOIN public.skill_clusters c ON c.id = s.cluster_id
        WHERE c.id IS NOT NULL
    ) sub;
    v_recent_clusters := COALESCE(v_recent_clusters, '{}'::VARCHAR[]);


    -- ==========================================
    -- 5.2 REVIEW MODE
    -- ==========================================
    IF p_mode = 'review' THEN
        
        -- Get top error clusters (last 14 days)
        SELECT array_agg(error_tag_id) INTO v_error_clusters
        FROM (
            SELECT error_tag_id 
            FROM public.get_recent_error_frequencies(p_user_id, 14) 
            LIMIT 5
        ) sub;
        
        RETURN QUERY
        SELECT 
            vq.question_id,
            (CASE WHEN vq.question_id = ANY(v_due_review_ids) THEN 'review_due' ELSE 'review_error' END)::VARCHAR AS reason,
            vq.b_i, vq.w_is, vq.c_i, vq.t_target,
            -- Penalty Calculation
            (SELECT COUNT(*)::INTEGER FROM unnest(v_recent_clusters) c WHERE c = ANY(vq.c_i)) AS cluster_penalty
        FROM public.v_question_profiles vq
        WHERE vq.topic_id = p_topic_id
          AND vq.status IN ('active', 'published')
          AND (p_section_id IS NULL OR vq.section_id = p_section_id)
          AND NOT (vq.question_id = ANY(v_exclude))
          -- MUST be Due OR contain a Top Error Cluster
          AND (vq.question_id = ANY(v_due_review_ids) OR (vq.c_i && v_error_clusters))
        LIMIT p_limit;

    -- ==========================================
    -- 5.3 ADAPTIVE MODE
    -- ==========================================
    ELSIF p_mode = 'adaptive' THEN
        
        -- Get Top 8 Weakest Skills
        SELECT array_agg(skill_id) INTO v_weak_skills
        FROM (
            SELECT skill_id 
            FROM public.get_normalized_skill_mastery(p_user_id)
            ORDER BY normalized_mastery ASC
            LIMIT 8
        ) sub;
        v_weak_skills := COALESCE(v_weak_skills, '{}'::VARCHAR[]);

        RETURN QUERY
        SELECT 
            vq.question_id,
            (CASE 
                -- If it contains a weak skill, tag as adaptive_gain
                WHEN EXISTS (
                    SELECT 1 FROM jsonb_array_elements(vq.w_is) js 
                    WHERE (js->>'skill_id')::VARCHAR = ANY(v_weak_skills)
                ) THEN 'adaptive_gain' 
                ELSE 'adaptive_explore' 
            END)::VARCHAR AS reason,
            vq.b_i, vq.w_is, vq.c_i, vq.t_target,
            (SELECT COUNT(*)::INTEGER FROM unnest(v_recent_clusters) c WHERE c = ANY(vq.c_i)) AS cluster_penalty
        FROM public.v_question_profiles vq
        WHERE vq.topic_id = p_topic_id
          AND vq.status IN ('active', 'published')
          AND (p_section_id IS NULL OR vq.section_id = p_section_id)
          AND NOT (vq.question_id = ANY(v_exclude))
        ORDER BY RANDOM() -- Let Step 6 do the heavy scoring, here we just randomize the candidate pool
        LIMIT p_limit * 3; -- Fetch more candidates for Step 6 to score

    -- ==========================================
    -- 5.4 RANDOM MODE (Stratified)
    -- ==========================================
    ELSE
        RETURN QUERY
        SELECT 
            vq.question_id,
            'random_bucket'::VARCHAR AS reason,
            vq.b_i, vq.w_is, vq.c_i, vq.t_target,
            (SELECT COUNT(*)::INTEGER FROM unnest(v_recent_clusters) c WHERE c = ANY(vq.c_i)) AS cluster_penalty
        FROM public.v_question_profiles vq
        WHERE vq.topic_id = p_topic_id
          AND vq.status IN ('active', 'published')
          AND (p_section_id IS NULL OR vq.section_id = p_section_id)
          AND NOT (vq.question_id = ANY(v_exclude))
        ORDER BY RANDOM()
        LIMIT p_limit * 3;
    END IF;
    
END;
$$;

GRANT EXECUTE ON FUNCTION public.get_recommendation_candidates(uuid, text, text, text, integer, uuid[]) TO authenticated, service_role;
