-- =====================================================
-- FIX: Auto-update Section Progress on Every Attempt
-- =====================================================

-- 1. Performance Index
CREATE INDEX IF NOT EXISTS idx_questions_sub_topic_id ON public.questions(sub_topic_id);
CREATE INDEX IF NOT EXISTS idx_question_attempts_question_correct ON public.question_attempts(user_id, question_id, is_correct);

-- 2. Trigger Function
CREATE OR REPLACE FUNCTION update_section_progress_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_section_id VARCHAR;
    v_total_questions INTEGER;
    v_correct_questions INTEGER;
    v_score INTEGER;
    v_status VARCHAR;
BEGIN
    -- Get section_id (sub_topic_id) for the question
    SELECT sub_topic_id INTO v_section_id
    FROM public.questions
    WHERE id = NEW.question_id::uuid; -- Cast if necessary, assuming questions.id is UUID

    -- If no section/subtopic linked, ignore
    IF v_section_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Calculate Stats for this Section
    -- Total Questions in Section
    SELECT COUNT(*) INTO v_total_questions
    FROM public.questions
    WHERE sub_topic_id = v_section_id;

    -- Correct Questions (Distinct) for User in this Section
    -- Link attempts to questions via question_id, filter by section
    SELECT COUNT(DISTINCT qa.question_id) INTO v_correct_questions
    FROM public.question_attempts qa
    JOIN public.questions q ON q.id = qa.question_id::uuid
    WHERE qa.user_id = NEW.user_id
      AND qa.is_correct = TRUE
      AND q.sub_topic_id = v_section_id;

    -- Calculate Score
    IF v_total_questions > 0 THEN
        v_score := (v_correct_questions::NUMERIC / v_total_questions::NUMERIC * 100)::INTEGER;
    ELSE
        v_score := 0;
    END IF;

    -- Determine Status
    IF v_score >= 100 THEN
        v_status := 'completed';
    ELSE
        v_status := 'in_progress';
    END IF;

    -- Upsert Progress
    INSERT INTO public.user_section_progress (
        user_id,
        section_id,
        status,
        score,
        total_questions,
        correct_questions,
        last_accessed_at,
        created_at
    ) VALUES (
        NEW.user_id,
        v_section_id,
        v_status,
        v_score,
        v_total_questions,
        v_correct_questions,
        NOW(),
        NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = CASE 
            WHEN user_section_progress.status = 'completed' THEN 'completed' -- Once completed, stay completed? Or allow regression? 
            -- User complained about lack of progress. Let's allow update to completed.
            -- Using NEW status is safer to reflect reality.
            ELSE EXCLUDED.status
        END,
        score = EXCLUDED.score,
        total_questions = EXCLUDED.total_questions,
        correct_questions = EXCLUDED.correct_questions,
        last_accessed_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Create Trigger
DROP TRIGGER IF EXISTS trigger_update_section_progress ON public.question_attempts;
CREATE TRIGGER trigger_update_section_progress
AFTER INSERT ON public.question_attempts
FOR EACH ROW
EXECUTE FUNCTION update_section_progress_on_attempt();
