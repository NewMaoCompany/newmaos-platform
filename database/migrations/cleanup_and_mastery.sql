-- =====================================================
-- 1. Data Cleanup: Standardize Topic IDs
-- =====================================================

-- Fix 'ABBC_Analytical' to 'Both_Analytical' to ensure aggregation works for Unit 5
UPDATE sections 
SET topic_id = 'Both_Analytical' 
WHERE topic_id = 'ABBC_Analytical';

-- =====================================================
-- 2. Schema Cleanup: Drop Unused Tables
-- =====================================================

DROP TABLE IF EXISTS user_unit_mastery;
DROP TABLE IF EXISTS user_topic_mastery;
DROP TABLE IF EXISTS units;
DROP TABLE IF EXISTS topics;

-- =====================================================
-- 3. Mastery Logic: Weighted 80/20 Completion
-- =====================================================

CREATE OR REPLACE FUNCTION get_unit_progress_stats(p_user_id UUID, p_topic_id TEXT)
RETURNS JSONB AS $$
DECLARE
    v_practice_score FLOAT := 0;
    v_test_score FLOAT := 0;
    v_final_score FLOAT := 0;
    v_practice_total_sections INT := 0;
    v_practice_completed_sections INT := 0;
    v_unit_test_exists BOOLEAN := false;
BEGIN
    -- 1. Calculate Practice Score (80% weight)
    -- Logic: Based on COMPLETION of sections (total_questions > 0).
    
    WITH practice_stats AS (
        SELECT 
            COUNT(*) as total_sections,
            COUNT(CASE WHEN usp.total_questions > 0 THEN 1 END) as completed_sections
        FROM sections s
        LEFT JOIN user_section_progress usp 
            ON s.id = usp.section_id 
            AND usp.user_id = p_user_id
        WHERE s.topic_id = p_topic_id 
          AND s.is_unit_test = false
    )
    SELECT 
        total_sections,
        CASE 
            WHEN total_sections > 0 THEN (CAST(completed_sections AS FLOAT) / total_sections) * 100
            ELSE 0 
        END
    INTO v_practice_total_sections, v_practice_score
    FROM practice_stats;

    -- 2. Calculate Unit Test Score (20% weight)
    -- Logic: If Unit Test is completed (total_questions > 0), score is 100%. Else 0%.
    SELECT 
        CASE 
            WHEN COUNT(CASE WHEN usp.total_questions > 0 THEN 1 END) > 0 THEN 100.0
            ELSE 0.0
        END,
        COUNT(*) > 0
    INTO v_test_score, v_unit_test_exists
    FROM sections s
    LEFT JOIN user_section_progress usp 
        ON s.id = usp.section_id 
        AND usp.user_id = p_user_id
    WHERE s.topic_id = p_topic_id 
      AND s.is_unit_test = true;

    -- 3. Combine scores
    -- Formula: 80% Practice Completion + 20% Unit Test Completion
    v_final_score := (v_practice_score * 0.8) + (v_test_score * 0.2);

    -- Return JSON with precise internal values
    RETURN jsonb_build_object(
        'unit_id', p_topic_id,
        'progress_percentage', v_final_score, -- Precise float
        'practice_avg', v_practice_score,
        'test_score', v_test_score
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
