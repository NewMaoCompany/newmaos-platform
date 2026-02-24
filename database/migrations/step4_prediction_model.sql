-- =====================================================
-- STEP 4: User Prediction Math Engine
-- Calculates P(u,i) (Predicted Accuracy) and Cluster Mastery
-- =====================================================

-- ==========================================
-- 4.1 & 4.2 Helper function for Logit Calculation
-- ==========================================
CREATE OR REPLACE FUNCTION public.math_logit(p_prob NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql IMMUTABLE
AS $$
BEGIN
    -- logit(p) = ln(p/(1-p))
    -- Clip intentionally handled outside per spec (0.01 to 0.99)
    RETURN ln(p_prob / (1.0 - p_prob));
END;
$$;

-- ==========================================
-- Helper function for Sigmoid Calculation
-- ==========================================
CREATE OR REPLACE FUNCTION public.math_sigmoid(p_x NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql IMMUTABLE
AS $$
BEGIN
    -- sigmoid(x) = 1/(1+e^(-x))
    RETURN 1.0 / (1.0 + exp(-p_x));
END;
$$;


-- ==========================================
-- 4.3 CORE PREDICTIVE MODEL
-- Single Question Prediction for a User
-- ==========================================
DROP FUNCTION IF EXISTS public.calculate_question_prediction(uuid, uuid);
CREATE OR REPLACE FUNCTION public.calculate_question_prediction(
    p_user_id UUID,
    p_question_id UUID
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_b_i NUMERIC;
    v_w_is JSONB;
    v_c_i VARCHAR[];
    
    v_skill_item JSONB;
    v_skill_id VARCHAR;
    v_weight NUMERIC;
    
    v_m_us NUMERIC;
    v_conf_us NUMERIC;
    v_clipped_m NUMERIC;
    
    v_A_ui NUMERIC := 0;
    v_P_ui NUMERIC;
    
    v_contributing_skills JSONB := '[]'::JSONB;
    v_contributing_clusters JSONB := '[]'::JSONB;
    
    v_cluster_id VARCHAR;
    v_cluster_m NUMERIC;
    v_cluster_conf_sum NUMERIC;
    v_cluster_weighted_m NUMERIC;
    v_eps NUMERIC := 1e-6;
BEGIN
    -- 1. Fetch Question Features (b_i, w_is, c_i) from Step 3 View
    SELECT b_i, w_is, c_i 
    INTO v_b_i, v_w_is, v_c_i
    FROM public.v_question_profiles
    WHERE question_id = p_question_id;

    IF v_b_i IS NULL THEN
        RAISE EXCEPTION 'Question % not found or profile invalid', p_question_id;
    END IF;

    -- 2. Iterate through Skills to calculate A(u,i) and collect Skill Contributions
    FOR v_skill_item IN SELECT * FROM jsonb_array_elements(v_w_is)
    LOOP
        v_skill_id := (v_skill_item->>'skill_id')::VARCHAR;
        v_weight := (v_skill_item->>'weight')::NUMERIC;
        
        -- Fetch M(u,s) and conf(u,s)
        SELECT normalized_mastery, confidence 
        INTO v_m_us, v_conf_us
        FROM public.get_normalized_skill_mastery(p_user_id)
        WHERE skill_id = v_skill_id;
        
        -- Default for unseen skills
        v_m_us := COALESCE(v_m_us, 0.5);   -- Assume average mastery if never seen
        v_conf_us := COALESCE(v_conf_us, 0);
        
        -- Clip M to [0.01, 0.99]
        v_clipped_m := GREATEST(0.01, LEAST(0.99, v_m_us));
        
        -- A(u,i) += w(i,s) * logit(clipped_m)
        v_A_ui := v_A_ui + (v_weight * public.math_logit(v_clipped_m));
        
        -- Store Skill Contribution: we sort by weight * (1 - M) to find "biggest weakness"
        v_contributing_skills := v_contributing_skills || jsonb_build_object(
            'skill_id', v_skill_id,
            'mastery', v_m_us,
            'weight', v_weight,
            'contribution_score', v_weight * (1.0 - v_m_us)
        );
    END LOOP;

    -- 3. Calculate P(u,i) = sigmoid(A(u,i) - b(i))
    v_P_ui := public.math_sigmoid(v_A_ui - v_b_i);
    
    -- 4. Calculate Cluster Mastery for the involved Clusters
    -- Formula: ClusterMastery(u,c) = sum(conf * M) / sum(conf + eps) over all skills in cluster
    IF v_c_i IS NOT NULL AND array_length(v_c_i, 1) > 0 THEN
        FOR i IN 1 .. array_length(v_c_i, 1)
        LOOP
            v_cluster_id := v_c_i[i];
            
            -- Aggregate skills belonging to this specific cluster
            SELECT 
                COALESCE(SUM(COALESCE(usm.confidence, 0.0) * (COALESCE(usm.mastery_score, 50.0) / 100.0)), 0),
                COALESCE(SUM(COALESCE(usm.confidence, 0.0)), 0)
            INTO v_cluster_weighted_m, v_cluster_conf_sum
            FROM public.skills s
            LEFT JOIN public.user_skill_mastery usm 
                   ON usm.skill_id = s.id AND usm.user_id = p_user_id
            WHERE s.cluster_id = v_cluster_id;
            
            v_cluster_m := v_cluster_weighted_m / (v_cluster_conf_sum + v_eps);
            
            -- Store Cluster Contribution
            v_contributing_clusters := v_contributing_clusters || jsonb_build_object(
                'cluster_id', v_cluster_id,
                'cluster_mastery', v_cluster_m,
                'weakness_score', 1.0 - v_cluster_m
            );
        END LOOP;
    END IF;

    -- 5. Sort the JSON Arrays descending by weakness score
    -- Extracted via subqueries to respect Postgres jsonb sorting mechanics
    IF jsonb_array_length(v_contributing_skills) > 0 THEN
        SELECT jsonb_agg(elem) INTO v_contributing_skills 
        FROM (
            SELECT value AS elem FROM jsonb_array_elements(v_contributing_skills)
            ORDER BY (value->>'contribution_score')::NUMERIC DESC
        ) sub;
    END IF;
    
    IF jsonb_array_length(v_contributing_clusters) > 0 THEN
        SELECT jsonb_agg(elem) INTO v_contributing_clusters 
        FROM (
            SELECT value AS elem FROM jsonb_array_elements(v_contributing_clusters)
            ORDER BY (value->>'weakness_score')::NUMERIC DESC
        ) sub;
    END IF;

    v_contributing_skills := COALESCE(v_contributing_skills, '[]'::JSONB);
    v_contributing_clusters := COALESCE(v_contributing_clusters, '[]'::JSONB);

    -- 6. Return Final P(u,i) Payload
    RETURN jsonb_build_object(
        'p_ui', ROUND(v_P_ui, 4),
        'top_contributing_skills', v_contributing_skills,
        'top_contributing_clusters', v_contributing_clusters
    );
END;
$$;

GRANT EXECUTE ON FUNCTION public.calculate_question_prediction(uuid, uuid) TO authenticated, service_role;
