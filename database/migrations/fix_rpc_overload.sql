DROP FUNCTION IF EXISTS submit_attempt(UUID, BOOLEAN, JSONB, INTEGER, TEXT);
DROP FUNCTION IF EXISTS submit_attempt(TEXT, BOOLEAN, JSONB, INTEGER, TEXT);

-- Now recreate the correct one mapping to the questions table
CREATE OR REPLACE FUNCTION submit_attempt(
    p_question_id TEXT,
    p_is_correct BOOLEAN,
    p_selected_answer JSONB DEFAULT NULL,
    p_time_spent INTEGER DEFAULT NULL,
    p_mode TEXT DEFAULT 'practice'
)
RETURNS JSONB AS $$
DECLARE
    v_user_id UUID;
    v_topic_id TEXT;
    v_current_mastery FLOAT;
    v_new_mastery FLOAT;
    v_weight FLOAT;
    v_attempt_id UUID;
BEGIN
    v_user_id := auth.uid();
    
    -- 1. Get question details
    SELECT topic_id, mastery_weight 
    INTO v_topic_id, v_weight 
    FROM questions 
    WHERE id = p_question_id;

    IF v_topic_id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Question not found');
    END IF;

    -- 2. Record the attempt
    INSERT INTO question_attempts (
        user_id,
        question_id,
        is_correct,
        selected_answer,
        time_spent_seconds,
        mode
    ) VALUES (
        v_user_id,
        p_question_id,
        p_is_correct,
        p_selected_answer,
        p_time_spent,
        p_mode
    ) RETURNING id INTO v_attempt_id;

    -- 3. Update Mastery IF it's a real attempt
    IF p_mode IN ('practice', 'test', 'algorithmic') THEN
        -- Get current mastery or default to 0
        SELECT mastery_score INTO v_current_mastery
        FROM topic_mastery
        WHERE user_id = v_user_id AND topic_id = v_topic_id;

        IF NOT FOUND THEN
            v_current_mastery := 0;
            
            INSERT INTO topic_mastery (user_id, topic_id, mastery_score)
            VALUES (v_user_id, v_topic_id, 0);
        END IF;

        -- Simple SM-2 inspired update: + weight if correct, - (weight/2) if wrong
        IF p_is_correct THEN
            v_new_mastery := LEAST(100.0, v_current_mastery + (v_weight * 20)); -- e.g. 0.5 * 20 = 10%
        ELSE
            v_new_mastery := GREATEST(0.0, v_current_mastery - (v_weight * 10));
        END IF;

        -- Save
        UPDATE topic_mastery 
        SET 
            mastery_score = v_new_mastery,
            last_practiced_at = NOW(),
            total_attempts = total_attempts + 1,
            correct_attempts = correct_attempts + CASE WHEN p_is_correct THEN 1 ELSE 0 END
        WHERE user_id = v_user_id AND topic_id = v_topic_id;
        
        RETURN jsonb_build_object(
            'success', true, 
            'attempt_id', v_attempt_id,
            'old_mastery', v_current_mastery,
            'new_mastery', v_new_mastery
        );
    END IF;

    RETURN jsonb_build_object('success', true, 'attempt_id', v_attempt_id);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
