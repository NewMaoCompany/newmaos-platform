-- =====================================================
-- NewMaoS: Fix ON CONFLICT mismatch in Unit Mastery trigger
-- =====================================================

-- 1. Ensure unit_mastery has a robust UNIQUE constraint (not partial)
DROP INDEX IF EXISTS idx_topic_mastery_user_topic;
DROP INDEX IF EXISTS idx_unit_mastery_user_topic;

CREATE UNIQUE INDEX idx_unit_mastery_user_topic ON public.unit_mastery(user_id, topic_id);

-- 2. Update the trigger function to match the index perfectly
CREATE OR REPLACE FUNCTION update_topic_mastery_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_unit_id VARCHAR(50);
    v_total_questions_in_unit INTEGER;
    v_accuracy_score NUMERIC;
    v_completion_score NUMERIC;
    v_final_mastery NUMERIC;
    v_unique_solved INTEGER;
BEGIN
    -- Resolve unit_id (topic_id) from the question
    SELECT topic_id INTO v_unit_id
    FROM public.questions
    WHERE id = NEW.question_id;

    IF v_unit_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Get total questions available in this unit
    SELECT COUNT(*) INTO v_total_questions_in_unit
    FROM public.questions
    WHERE topic_id = v_unit_id AND status IN ('active', 'published');

    -- Ensure a record exists for this user/unit (using unit_mastery table)
    -- The ON CONFLICT now matches the standard unique index created above
    INSERT INTO public.unit_mastery (user_id, topic_id, subject)
    VALUES (NEW.user_id, v_unit_id, v_unit_id)
    ON CONFLICT (user_id, topic_id) DO NOTHING;

    -- Calculate current stats from question_attempts
    -- 1. Total & Correct Attempts
    SELECT 
        COUNT(*),
        COUNT(*) FILTER (WHERE is_correct = true)
    INTO 
        v_final_mastery,
        v_accuracy_score
    FROM public.question_attempts qa
    JOIN public.questions q ON qa.question_id = q.id
    WHERE qa.user_id = NEW.user_id AND q.topic_id = v_unit_id;

    -- 2. Unique Questions Solved Correctly (for Completion)
    SELECT COUNT(DISTINCT question_id) INTO v_unique_solved
    FROM public.question_attempts qa
    JOIN public.questions q ON qa.question_id = q.id
    WHERE qa.user_id = NEW.user_id 
      AND q.topic_id = v_unit_id
      AND qa.is_correct = true;

    -- Calculate Component Scores
    v_accuracy_score := LEAST(100, (v_accuracy_score::NUMERIC / NULLIF(v_final_mastery, 0)) / 0.85 * 100);
    v_completion_score := LEAST(100, (v_unique_solved::NUMERIC / NULLIF(v_total_questions_in_unit, 0)) * 100);
    v_final_mastery := (COALESCE(v_accuracy_score, 0) * 0.5) + (COALESCE(v_completion_score, 0) * 0.5);

    -- Update unit_mastery table
    UPDATE public.unit_mastery SET
        total_attempts = (SELECT COUNT(*) FROM public.question_attempts qa JOIN public.questions q ON qa.question_id = q.id WHERE qa.user_id = NEW.user_id AND q.topic_id = v_unit_id),
        correct_attempts = (SELECT COUNT(*) FILTER (WHERE is_correct = true) FROM public.question_attempts qa JOIN public.questions q ON qa.question_id = q.id WHERE qa.user_id = NEW.user_id AND q.topic_id = v_unit_id),
        unique_questions_solved = v_unique_solved,
        accuracy_rate = ROUND(COALESCE(v_accuracy_score, 0), 2),
        completion_rate = ROUND(COALESCE(v_completion_score, 0), 2),
        mastery_score = ROUND(v_final_mastery, 2),
        updated_at = NOW()
    WHERE user_id = NEW.user_id AND topic_id = v_unit_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Re-attach trigger
DROP TRIGGER IF EXISTS trg_update_topic_mastery ON public.question_attempts;
CREATE TRIGGER trg_update_topic_mastery
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_topic_mastery_on_attempt();
