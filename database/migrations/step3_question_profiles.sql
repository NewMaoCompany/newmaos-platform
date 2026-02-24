-- =====================================================
-- STEP 3: Question Feature Construction (Question Profiling)
-- View: v_question_profiles
-- Translates raw questions into mathematically ready tensors
-- for the recommendation algorithm
-- =====================================================

-- We use a view so it's always perfectly in sync with the live database 
-- and requires no extra trigger syncing.
DROP VIEW IF EXISTS public.v_question_profiles CASCADE;

CREATE OR REPLACE VIEW public.v_question_profiles AS
WITH 

-- 1. Parse weights from question_skills table (New Architecture)
-- If a question exists here, we use the explicitly defined weights.
explicit_skills AS (
    SELECT 
        qs.question_id,
        qs.skill_id,
        qs.weight AS w_is
    FROM public.question_skills qs
),

-- 2. Fallback to legacy fields in questions table (Old Architecture)
-- Extract primary_skill_id
fallback_primary AS (
    SELECT 
        q.id AS question_id,
        q.primary_skill_id AS skill_id,
        COALESCE(q.weight_primary, 1.0) AS w_is
    FROM public.questions q
    WHERE q.primary_skill_id IS NOT NULL
      AND NOT EXISTS (SELECT 1 FROM explicit_skills es WHERE es.question_id = q.id)
),

-- Extract supporting_skill_ids array and split weight evenly
fallback_supporting AS (
    SELECT 
        q.id AS question_id,
        unnest(q.supporting_skill_ids) AS skill_id,
        COALESCE(q.weight_supporting, 0.5) / 
            NULLIF(array_length(q.supporting_skill_ids, 1), 0) AS w_is
    FROM public.questions q
    WHERE array_length(q.supporting_skill_ids, 1) > 0
      AND NOT EXISTS (SELECT 1 FROM explicit_skills es WHERE es.question_id = q.id)
),

-- Combine all skill weight vectors into one comprehensive list
all_question_skills AS (
    SELECT * FROM explicit_skills
    UNION ALL
    SELECT * FROM fallback_primary
    UNION ALL
    SELECT * FROM fallback_supporting
),

-- Group the skills by question to formulate the final array outputs
aggregated_skills AS (
    SELECT 
        aqs.question_id,
        -- Generate JSON array of {skill_id: string, weight: numeric}
        jsonb_agg(jsonb_build_object(
            'skill_id', aqs.skill_id,
            'weight', aqs.w_is
        )) AS skills_with_weights,
        
        -- Distinct list of clusters mapped from those skills
        -- Using array_agg(DISTINCT) is clean mapping C(i)
        array_remove(array_agg(DISTINCT s.cluster_id), NULL) AS cluster_ids
    FROM all_question_skills aqs
    LEFT JOIN public.skills s ON s.id = aqs.skill_id
    GROUP BY aqs.question_id
)

-- 3. Final Assembly of the Profile
SELECT 
    q.id AS question_id,
    q.topic_id,
    q.section_id,
    q.status,
    
    -- t_target(i)
    COALESCE(q.target_time_seconds, 90) AS t_target,
    
    -- b(i) Difficulty Scalar
    -- Formula: beta0(0) + beta_d(0.9) * difficulty + beta_r(0.7) * reasoning_level
    (0 + (0.9 * COALESCE(q.difficulty, 3)) + (0.7 * COALESCE(q.reasoning_level, 3)))::NUMERIC(5,2) AS b_i,
    
    -- Skills(i) + w(i,s)
    COALESCE(ags.skills_with_weights, '[]'::JSONB) AS w_is,
    
    -- Clusters(i)
    COALESCE(ags.cluster_ids, '{}'::VARCHAR[]) AS c_i
    
FROM public.questions q
LEFT JOIN aggregated_skills ags ON ags.question_id = q.id;

-- Grant permissions
GRANT SELECT ON public.v_question_profiles TO authenticated, service_role;
