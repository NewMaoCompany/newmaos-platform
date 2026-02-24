-- =====================================================
-- STEP 6: Master Scoring Engine
-- Implements the robust, explainable recommendation scoring formula
-- taking in candidates and returning the final sorted array
-- =====================================================

DROP FUNCTION IF EXISTS public.score_and_rank_candidates(uuid, text, text, text, integer, uuid[]);

CREATE OR REPLACE FUNCTION public.score_and_rank_candidates(
    p_user_id UUID,
    p_mode TEXT,
    p_topic_id TEXT,
    p_section_id TEXT DEFAULT NULL,
    p_limit INTEGER DEFAULT 20,
    p_exclude_question_ids UUID[] DEFAULT '{}'::UUID[]
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    -- Model Weights Defaults
    -- Adaptive: High Gain, High Risk (ZPD), Medium Diversity
    -- Review: High ReviewBoost, High Gain, Low Diversity
    -- Random: Balanced
    v_a1 NUMERIC := 1.0; v_a2 NUMERIC := 0.7;
    v_d1 NUMERIC := 0.5; v_d2 NUMERIC := 0.8;
    v_gamma1 NUMERIC := 1.0; v_gamma2 NUMERIC := 0.8;
    v_delta NUMERIC := 0.4;
    v_wP NUMERIC := 0.3;
    
    v_wG NUMERIC := 1.2; v_wI NUMERIC := 0.5; v_wR NUMERIC := 1.0; 
    v_wC NUMERIC := 0.4; v_wD NUMERIC := 0.35; v_wB NUMERIC := 0.2;
    
    -- Candidate iteration variables
    v_cand RECORD;
    v_skill_item JSONB;
    v_cluster_id VARCHAR;
    v_error_tag VARCHAR;
    
    -- Feature Variables
    v_P_ui NUMERIC;
    v_Info_ui NUMERIC;
    v_GainSkill NUMERIC := 0;
    v_GainCluster NUMERIC := 0;
    v_Risk NUMERIC;
    v_Cost NUMERIC;
    v_DiversitySkill NUMERIC := 0;
    v_DiversityCluster NUMERIC := 0;
    v_ReviewBoost NUMERIC := 0;
    
    -- Intermediate calcs
    v_m_us NUMERIC;
    v_cluster_m NUMERIC;
    v_cluster_conf_sum NUMERIC;
    v_cluster_weighted_m NUMERIC;
    
    v_recent_skills VARCHAR[];
    v_recent_clusters VARCHAR[];
    v_skill_intersection_count INTEGER;
    v_skill_union_count INTEGER;
    v_cluster_intersection_count INTEGER;
    v_cluster_union_count INTEGER;
    
    v_err_freq BIGINT;
    v_err_severity INTEGER;
    v_mastery_weight NUMERIC;
    
    -- Final scoring
    v_GainTotal NUMERIC;
    v_DiversityTotal NUMERIC;
    v_RawScore NUMERIC;
    v_FinalScore NUMERIC;
    
    -- Result Accumulator
    v_results JSONB := '[]'::JSONB;
    v_reason_detail JSONB;
    
    v_eps NUMERIC := 1e-6;
BEGIN

    -- 1. Mode Configure Weights
    IF p_mode = 'review' THEN
        v_wG := 0.7; v_wI := 0.1; v_wR := 0.7; v_wC := 0.2; v_wD := 0.25; v_wB := 1.6;
    ELSIF p_mode = 'random' THEN
        v_wG := 0.6; v_wI := 0.1; v_wR := 0.6; v_wC := 0.2; v_wD := 0.6;  v_wB := 0.2;
    END IF;

    -- 2. Pre-fetch Recent Skills & Clusters for Diversity (Jaccard)
    -- This fetches from the last 15 attempts to see what the user just saw
    SELECT 
        array_agg(DISTINCT s.id),
        array_agg(DISTINCT s.cluster_id)
    INTO v_recent_skills, v_recent_clusters
    FROM public.get_recent_attempts(p_user_id, 15) ra
    JOIN public.question_skills qs ON qs.question_id = ra.question_id
    JOIN public.skills s ON s.id = qs.skill_id;
    
    v_recent_skills := COALESCE(v_recent_skills, '{}'::VARCHAR[]);
    v_recent_clusters := COALESCE(v_recent_clusters, '{}'::VARCHAR[]);

    -- 3. Iterate through generated candidates from Step 5
    FOR v_cand IN 
        SELECT 
            c.*, 
            q.mastery_weight,
            q.error_tags
        FROM public.get_recommendation_candidates(
            p_user_id, p_mode, p_topic_id, p_section_id, p_limit * 2, p_exclude_question_ids
        ) c
        JOIN public.questions q ON q.id = c.question_id
    LOOP
        -- Reset Feature Accumulators
        v_GainSkill := 0; v_GainCluster := 0; v_ReviewBoost := 0;
        
        -- A) Get P(u,i) from Step 4 prediction
        v_P_ui := (public.calculate_question_prediction(p_user_id, v_cand.question_id)->>'p_ui')::NUMERIC;
        
        -- B) Calculate Info(u,i)
        v_Info_ui := v_P_ui * (1.0 - v_P_ui);
        
        -- C) Calculate Cost(u,i)
        v_Cost := v_delta * (COALESCE(v_cand.t_target, 90)::NUMERIC / 90.0);
        
        -- D) Calculate Risk(u,i) [ZPD = 0.55 to 0.85]
        v_Risk := v_gamma1 * POWER(GREATEST(0, 0.55 - v_P_ui), 2) 
                + v_gamma2 * POWER(GREATEST(0, v_P_ui - 0.85), 2);
                
        -- E) Calculate GainSkill & Arrays for Jaccard
        v_mastery_weight := COALESCE(v_cand.mastery_weight, 1.0);
        
        IF v_cand.w_is IS NOT NULL AND jsonb_array_length(v_cand.w_is) > 0 THEN
            FOR v_skill_item IN SELECT * FROM jsonb_array_elements(v_cand.w_is)
            LOOP
                -- Get User Mastery For this skill
                SELECT normalized_mastery INTO v_m_us
                FROM public.get_normalized_skill_mastery(p_user_id)
                WHERE skill_id = (v_skill_item->>'skill_id')::VARCHAR;
                
                v_m_us := COALESCE(v_m_us, 0.5);
                v_GainSkill := v_GainSkill + ((v_skill_item->>'weight')::NUMERIC * (1.0 - v_m_us));
            END LOOP;
            v_GainSkill := v_mastery_weight * v_GainSkill;
        END IF;

        -- F) Calculate GainCluster
        IF v_cand.c_i IS NOT NULL AND array_length(v_cand.c_i, 1) > 0 THEN
            FOR i IN 1 .. array_length(v_cand.c_i, 1)
            LOOP
                v_cluster_id := v_cand.c_i[i];
                -- Calculate Cluster Mastery
                SELECT 
                    COALESCE(SUM(COALESCE(usm.confidence, 0.0) * (COALESCE(usm.mastery_score, 50.0) / 100.0)), 0),
                    COALESCE(SUM(COALESCE(usm.confidence, 0.0)), 0)
                INTO v_cluster_weighted_m, v_cluster_conf_sum
                FROM public.skills s
                LEFT JOIN public.user_skill_mastery usm 
                       ON usm.skill_id = s.id AND usm.user_id = p_user_id
                WHERE s.cluster_id = v_cluster_id;
                
                v_cluster_m := v_cluster_weighted_m / (v_cluster_conf_sum + v_eps);
                v_GainCluster := v_GainCluster + (1.0 - v_cluster_m);
            END LOOP;
            v_GainCluster := v_GainCluster / array_length(v_cand.c_i, 1);
        END IF;
        
        -- G) Calculate Diversity (Jaccard)
        -- Jaccard = Intersection / Union
        -- Extract just the string array of current skills
        WITH cur_skills AS (
            SELECT (jsonb_array_elements(v_cand.w_is)->>'skill_id')::VARCHAR AS s_id
        )
        SELECT 
            (SELECT COUNT(*) FROM cur_skills cs WHERE cs.s_id = ANY(v_recent_skills)),
            (SELECT COUNT(*) FROM (SELECT s_id FROM cur_skills UNION SELECT unnest(v_recent_skills)) u)
        INTO v_skill_intersection_count, v_skill_union_count;
        
        v_DiversitySkill := 1.0 - (COALESCE(v_skill_intersection_count, 0)::NUMERIC / NULLIF(v_skill_union_count, 0));
        v_DiversitySkill := COALESCE(v_DiversitySkill, 1.0); -- If union 0, completely diverse
        
        -- Cluster Jaccard
        WITH cur_clusters AS (SELECT unnest(v_cand.c_i) AS c_id)
        SELECT 
            (SELECT COUNT(*) FROM cur_clusters cc WHERE cc.c_id = ANY(v_recent_clusters)),
            (SELECT COUNT(*) FROM (SELECT c_id FROM cur_clusters UNION SELECT unnest(v_recent_clusters)) u)
        INTO v_cluster_intersection_count, v_cluster_union_count;
        
        v_DiversityCluster := 1.0 - (COALESCE(v_cluster_intersection_count, 0)::NUMERIC / NULLIF(v_cluster_union_count, 0));
        v_DiversityCluster := COALESCE(v_DiversityCluster, 1.0);

        -- H) ReviewBoost (14d Error Tag Freq)
        IF v_cand.error_tags IS NOT NULL AND array_length(v_cand.error_tags, 1) > 0 THEN
            FOR i IN 1 .. array_length(v_cand.error_tags, 1)
            LOOP
                v_error_tag := v_cand.error_tags[i];
                -- Get frequency
                SELECT count INTO v_err_freq 
                FROM public.get_recent_error_frequencies(p_user_id, 14)
                WHERE error_tag_id = v_error_tag;
                
                -- Get severity (default 1 if missing)
                SELECT COALESCE(severity, 1) INTO v_err_severity 
                FROM public.error_tags WHERE id = v_error_tag;
                
                v_ReviewBoost := v_ReviewBoost + ((0.5 + 0.2 * v_err_severity) * COALESCE(v_err_freq, 0));
            END LOOP;
        END IF;

        -- I) Final Aggregation!
        v_GainTotal := (v_a1 * v_GainSkill) + (v_a2 * v_GainCluster);
        v_DiversityTotal := (v_d1 * v_DiversitySkill) + (v_d2 * v_DiversityCluster);
        
        v_RawScore := (v_wG * v_GainTotal) 
                    + (v_wI * v_Info_ui) 
                    - (v_wR * v_Risk) 
                    - (v_wC * v_Cost) 
                    + (v_wD * v_DiversityTotal) 
                    + (v_wB * v_ReviewBoost) 
                    - (v_wP * COALESCE(v_cand.cluster_penalty, 0));
                    
        v_FinalScore := public.math_sigmoid(v_RawScore);

        -- J) Build final object
        v_reason_detail := jsonb_build_object(
            'mode', p_mode,
            'topic_id', p_topic_id,
            'p_ui', ROUND(v_P_ui, 3),
            'gain_total', ROUND(v_GainTotal, 3),
            'info', ROUND(v_Info_ui, 3),
            'risk', ROUND(v_Risk, 3),
            'diversity', ROUND(v_DiversityTotal, 3),
            'review_boost', ROUND(v_ReviewBoost, 3),
            'penalty', COALESCE(v_cand.cluster_penalty, 0),
            'raw_score', ROUND(v_RawScore, 3)
        );

        v_results := v_results || jsonb_build_object(
            'question_id', v_cand.question_id,
            'score', ROUND(v_FinalScore, 4),
            'reason', v_cand.reason,
            'reason_detail', v_reason_detail,
            'skill_id', (v_cand.w_is->0->>'skill_id') -- Primary skill fallback
        );

    END LOOP;

    -- 4. Sort results by score descending and return top K
    RETURN (
        SELECT jsonb_agg(elem)
        FROM (
            SELECT value AS elem 
            FROM jsonb_array_elements(v_results)
            ORDER BY (value->>'score')::NUMERIC DESC
            LIMIT p_limit
        ) sub
    );

END;
$$;

GRANT EXECUTE ON FUNCTION public.score_and_rank_candidates(uuid, text, text, text, integer, uuid[]) TO authenticated, service_role;
