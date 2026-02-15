
-- 0. Cleanup
DROP FUNCTION IF EXISTS save_section_progress(TEXT, UUID, JSONB, INTEGER, INTEGER, TEXT, FLOAT, TEXT);
DROP FUNCTION IF EXISTS get_unit_progress_stats(UUID, TEXT);
DROP FUNCTION IF EXISTS get_course_progress_stats(UUID, TEXT);
DROP FUNCTION IF EXISTS get_all_user_progress();
DROP FUNCTION IF EXISTS get_current_incorrect_questions();

-- A. Create Question Attempts Table
CREATE TABLE IF NOT EXISTS question_attempts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id),
    question_id TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT false,
    selected_answer JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
ALTER TABLE question_attempts ENABLE ROW LEVEL SECURITY;

-- Policy (Drop and Recreate to avoid DO block issues)
DROP POLICY IF EXISTS "Users can manage their own attempts" ON question_attempts;
CREATE POLICY "Users can manage their own attempts" ON question_attempts FOR ALL USING (auth.uid() = user_id);

-- B. RPC: Get list of questions where the LATEST attempt is incorrect
CREATE OR REPLACE FUNCTION get_current_incorrect_questions()
RETURNS TABLE (question_id TEXT) AS $func$
BEGIN
    RETURN QUERY
    SELECT latest.question_id
    FROM (
        SELECT DISTINCT ON (qa.question_id) qa.question_id, qa.is_correct
        FROM question_attempts qa
        WHERE qa.user_id = auth.uid()
        ORDER BY qa.question_id, qa.created_at DESC
    ) latest
    WHERE latest.is_correct = false;
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;


-- C. RPC: Get All User Progress
CREATE OR REPLACE FUNCTION get_all_user_progress()
RETURNS SETOF user_section_progress AS $func$
BEGIN
    RETURN QUERY SELECT * FROM user_section_progress WHERE user_id = auth.uid();
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;


-- D. RPC: Save Section Progress
CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id TEXT,
    p_user_id UUID,
    p_data JSONB,
    p_completed_items INTEGER,
    p_total_items INTEGER,
    p_status TEXT DEFAULT 'in_progress',
    p_score FLOAT DEFAULT 0,
    p_entity_type TEXT DEFAULT 'section'
)
RETURNS JSONB AS $func$
DECLARE
    v_current_status TEXT;
BEGIN
    SELECT status INTO v_current_status
    FROM user_section_progress
    WHERE user_id = p_user_id AND section_id = p_section_id;

    INSERT INTO user_section_progress (
        user_id,
        section_id,
        status,
        data,
        correct_questions,
        total_questions,
        score,
        last_accessed_at,
        entity_type
    )
    VALUES (
        p_user_id,
        p_section_id,
        p_status,
        p_data,
        p_completed_items, 
        p_total_items,
        p_score,
        NOW(),
        p_entity_type
    )
    ON CONFLICT (user_id, section_id)
    DO UPDATE SET
        status = EXCLUDED.status,
        data = EXCLUDED.data,
        correct_questions = EXCLUDED.correct_questions,
        total_questions = EXCLUDED.total_questions,
        score = EXCLUDED.score,
        last_accessed_at = NOW();

    RETURN jsonb_build_object('success', true);
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;


-- E. RPC: Unit Progress Stats
CREATE OR REPLACE FUNCTION get_unit_progress_stats(p_user_id UUID, p_topic_id TEXT)
RETURNS JSONB AS $func$
DECLARE
    v_practice_score FLOAT := 0;
    v_test_score FLOAT := 0;
    v_final_score FLOAT := 0;
    v_practice_count INT;
    v_test_found BOOLEAN;
BEGIN
    SELECT 
        COALESCE(AVG(
            CASE 
                WHEN usp.total_questions > 0 THEN (CAST(usp.correct_questions AS FLOAT) / usp.total_questions) * 100
                ELSE 0 
            END
        ), 0),
        COUNT(*)
    INTO v_practice_score, v_practice_count
    FROM sections s
    LEFT JOIN user_section_progress usp ON s.id = usp.section_id AND usp.user_id = p_user_id
    WHERE s.topic_id = p_topic_id 
      AND (s.is_unit_test = false);

    SELECT 
        COALESCE(MAX(
            CASE 
                WHEN usp.total_questions > 0 THEN (CAST(usp.correct_questions AS FLOAT) / usp.total_questions) * 100
                ELSE 0 
            END
        ), 0),
        COUNT(*) > 0
    INTO v_test_score, v_test_found
    FROM sections s
    LEFT JOIN user_section_progress usp ON s.id = usp.section_id AND usp.user_id = p_user_id
    WHERE s.topic_id = p_topic_id 
      AND s.is_unit_test = true;

    IF v_practice_count = 0 THEN
        v_final_score := v_test_score;
    ELSE
        v_final_score := (v_practice_score * 0.8) + (v_test_score * 0.2);
    END IF;

    RETURN jsonb_build_object(
        'unit_id', p_topic_id,
        'progress_percentage', v_final_score,
        'practice_avg', v_practice_score,
        'test_score', v_test_score
    );
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;


-- F. RPC: Course Progress
CREATE OR REPLACE FUNCTION get_course_progress_stats(p_user_id UUID, p_course_scope TEXT DEFAULT 'Both')
RETURNS JSONB AS $func$
DECLARE
    v_avg_progress FLOAT := 0;
BEGIN
    WITH unit_scores AS (
        SELECT 
            s.topic_id,
            get_unit_progress_stats(p_user_id, s.topic_id)->>'progress_percentage' as score
        FROM sections s
        WHERE (s.course_scope = p_course_scope OR s.course_scope = 'both' OR p_course_scope = 'Both')
        GROUP BY s.topic_id
    )
    SELECT AVG(CAST(score AS FLOAT)) INTO v_avg_progress FROM unit_scores;
    
    RETURN jsonb_build_object(
        'course', p_course_scope,
        'progress_percentage', COALESCE(v_avg_progress, 0)
    );
END;
$func$ LANGUAGE plpgsql SECURITY DEFINER;
