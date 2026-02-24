-- =====================================================
-- STEP 7: End-to-End Orchestrator 
-- Softmax selection, why_text explanation, and saving to public.recommendations
-- Replaces the stub function created in Step 1
-- =====================================================

DROP FUNCTION IF EXISTS public.generate_practice_recommendations(uuid, text, text, text, integer, uuid[]);

CREATE OR REPLACE FUNCTION public.generate_practice_recommendations(
    p_user_id UUID DEFAULT auth.uid(),
    p_mode TEXT DEFAULT 'adaptive',
    p_topic_id TEXT DEFAULT 'Both_Limits',
    p_section_id TEXT DEFAULT NULL,
    p_limit INTEGER DEFAULT 5,
    p_exclude_question_ids UUID[] DEFAULT '{}'::UUID[]
)
RETURNS SETOF public.recommendations
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_scores JSONB;
    v_item JSONB;
    v_question_id UUID;
    v_raw_score NUMERIC;
    v_reason_detail JSONB;
    v_base_reason VARCHAR;
    v_why_text TEXT;
    
    -- Explanation extraction vars
    v_top_skill VARCHAR;
    v_top_cluster VARCHAR;
    v_p_ui NUMERIC;
    v_target_band_min NUMERIC := 0.55;
    v_target_band_max NUMERIC := 0.85;
    
    -- Softmax vars
    v_T NUMERIC := 0.5; -- Temperature
    v_sum_exp NUMERIC := 0;
    v_prob NUMERIC;
    
    -- Output arrays
    v_candidates_with_prob JSONB := '[]'::JSONB;
    v_selected_candidates JSONB := '[]'::JSONB;
    v_inserted_ids UUID[] := '{}'::UUID[];
BEGIN
    
    -- 1. Call Step 6 Master Scoring Engine
    -- We fetch slightly more to allow softmax sampling to have choices
    SELECT public.score_and_rank_candidates(
        p_user_id, p_mode, p_topic_id, p_section_id, p_limit * 2, p_exclude_question_ids
    ) INTO v_scores;
    
    IF v_scores IS NULL OR jsonb_array_length(v_scores) = 0 THEN
        RETURN; -- No questions available
    END IF;

    -- 2. Calculate Softmax Probabilities
    FOR v_item IN SELECT * FROM jsonb_array_elements(v_scores)
    LOOP
        v_raw_score := (v_item->'reason_detail'->>'raw_score')::NUMERIC;
        v_sum_exp := v_sum_exp + EXP(v_raw_score / v_T);
    END LOOP;
    
    FOR v_item IN SELECT * FROM jsonb_array_elements(v_scores)
    LOOP
        v_raw_score := (v_item->'reason_detail'->>'raw_score')::NUMERIC;
        v_prob := EXP(v_raw_score / v_T) / v_sum_exp;
        
        v_candidates_with_prob := v_candidates_with_prob || (v_item || jsonb_build_object('softmax_prob', v_prob));
    END LOOP;

    -- 3. Softmax Roulette Wheel Selection (Select Top p_limit)
    -- Postgres random() is 0.0 to 1.0. We iterate and select.
    -- To keep it simple but somewhat randomized, we sort by prob DESC,
    -- and pick them. For a true roulette, it takes complex looping.
    -- Here, we just add slight noise to the prob and sort to achieve a similar soft-selection.
    SELECT jsonb_agg(elem) INTO v_selected_candidates
    FROM (
        SELECT value AS elem 
        FROM jsonb_array_elements(v_candidates_with_prob)
        ORDER BY ((value->>'softmax_prob')::NUMERIC * (0.8 + 0.4 * random())) DESC
        LIMIT p_limit
    ) sub;


    -- 4. Generate Explanations and Insert into recommendations table
    FOR v_item IN SELECT * FROM jsonb_array_elements(v_selected_candidates)
    LOOP
        v_question_id := (v_item->>'question_id')::UUID;
        v_base_reason := (v_item->>'reason')::VARCHAR;
        v_reason_detail := v_item->'reason_detail';
        v_p_ui := (v_reason_detail->>'p_ui')::NUMERIC;
        
        -- Extract Skill and Cluster from question profile for templating
        SELECT (w_is->0->>'skill_id')::VARCHAR, c_i[1] 
        INTO v_top_skill, v_top_cluster
        FROM public.v_question_profiles
        WHERE question_id = v_question_id;
        
        v_top_skill := COALESCE(v_top_skill, 'General Skill');
        v_top_cluster := COALESCE(v_top_cluster, 'General Concept');

        -- Generate why_text Template
        IF p_mode = 'adaptive' THEN
            v_why_text := '你在 [' || v_top_cluster || '] 的掌握度偏低。这题主要覆盖 [' || v_top_skill || ']，预计正确率 ' || round(v_p_ui * 100, 1) || '% 落在学习甜区，将优先提升该能力。';
        ELSIF p_mode = 'review' THEN
            IF v_base_reason = 'review_due' THEN
                v_why_text := '这题已到复习时间，用于巩固 [' || v_top_cluster || ']，防遗忘回落。';
            ELSE
                v_why_text := '你最近常在类似 [' || v_top_cluster || '] 的题出错，本题专门对应该错因，建议立即纠正。';
            END IF;
        ELSE
            v_why_text := '用于保持记忆与迁移：覆盖 [' || v_top_cluster || ']，避免只练同一类题。';
        END IF;

        -- Enhance reason_detail
        v_reason_detail := v_reason_detail || jsonb_build_object(
            'target_band', ARRAY[v_target_band_min, v_target_band_max],
            'top_skill_id', v_top_skill,
            'top_skill_cluster_id', v_top_cluster,
            'why_text', v_why_text
        );
        
        v_inserted_ids := v_inserted_ids || v_question_id;

        -- Upsert to recommendations table
        INSERT INTO public.recommendations (
            user_id, question_id, mode, status, priority, score, reason, reason_detail, expires_at
        ) VALUES (
            p_user_id,
            v_question_id,
            p_mode,
            'pending',
            (v_item->>'score')::NUMERIC, -- use final score as priority
            (v_item->>'score')::NUMERIC, -- also populate the required score column
            v_base_reason,
            v_reason_detail,
            NOW() + INTERVAL '1 day'
        ) 
        ON CONFLICT (user_id, question_id, mode, status) 
        DO UPDATE SET 
            priority = EXCLUDED.priority,
            score = EXCLUDED.score,
            reason_detail = EXCLUDED.reason_detail,
            updated_at = NOW();

    END LOOP;

    -- 5. Return the newly inserted row objects matching Postgres SETOF behavior
    RETURN QUERY 
    SELECT * FROM public.recommendations 
    WHERE user_id = p_user_id 
      AND mode = p_mode 
      AND status = 'pending'
      AND question_id = ANY(v_inserted_ids)
    ORDER BY priority DESC;

END;
$$;

GRANT EXECUTE ON FUNCTION public.generate_practice_recommendations(uuid, text, text, text, integer, uuid[]) TO authenticated, service_role;
