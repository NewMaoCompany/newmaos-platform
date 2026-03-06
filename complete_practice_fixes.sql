-- DROP confusing overloads
DROP FUNCTION IF EXISTS public.submit_attempt(UUID, UUID, BOOLEAN, INTEGER, TEXT, NUMERIC, TEXT[]);
DROP FUNCTION IF EXISTS public.submit_attempt(UUID, BOOLEAN, VARCHAR(100), NUMERIC, INTEGER, TEXT[]);
DROP FUNCTION IF EXISTS public.submit_attempt(UUID, BOOLEAN, TEXT, NUMERIC, INTEGER, TEXT[]);

-- 1. Create or Replace the exact signature called by AppContext.tsx
CREATE OR REPLACE FUNCTION submit_attempt(
    p_question_id UUID,
    p_is_correct BOOLEAN,
    p_selected_option_id TEXT DEFAULT NULL,
    p_answer_numeric NUMERIC DEFAULT NULL,
    p_time_spent_seconds INTEGER DEFAULT 0,
    p_error_tags TEXT[] DEFAULT '{}'
) RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_attempt_id UUID;
    v_attempt_no INTEGER;
    v_is_first BOOLEAN;
    v_tag TEXT;
BEGIN
    -- Validate user
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'User not authenticated';
    END IF;

    -- Get attempt number for this user-question pair
    SELECT COALESCE(MAX(attempt_no), 0) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = v_user_id AND question_id = p_question_id;

    v_is_first := (v_attempt_no = 1);

    -- Insert attempt (triggers will handle the stats and mastery updates based on is_first_attempt)
    INSERT INTO public.question_attempts (
        user_id,
        question_id,
        is_correct,
        selected_option_id,
        answer_numeric,
        time_spent_seconds,
        attempt_no,
        error_tags,
        is_first_attempt
    ) VALUES (
        v_user_id,
        p_question_id,
        p_is_correct,
        p_selected_option_id,
        p_answer_numeric,
        p_time_spent_seconds,
        v_attempt_no,
        p_error_tags,
        v_is_first
    )
    RETURNING id INTO v_attempt_id;

    -- Insert error tags into attempt_errors safely (ignore if tag not found in master list)
    IF p_error_tags IS NOT NULL THEN
        FOREACH v_tag IN ARRAY p_error_tags
        LOOP
            INSERT INTO public.attempt_errors (attempt_id, error_tag_id)
            SELECT v_attempt_id, id 
            FROM public.error_tags 
            WHERE id = v_tag
            ON CONFLICT DO NOTHING;
        END LOOP;
    END IF;

    -- Return result matching expected AppContext.tsx structure
    RETURN jsonb_build_object(
        'success', true,
        'attempt_id', v_attempt_id,
        'attempt_no', v_attempt_no,
        'is_correct', p_is_correct,
        'is_first_attempt', v_is_first
    );
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object(
        'success', false,
        'error', SQLERRM
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 2. Ensure Trigger for updating stats is bulletproof
CREATE OR REPLACE FUNCTION update_user_stats_on_attempt()
RETURNS TRIGGER AS $$
BEGIN
    -- Only update these stats if this is the user's first attempt at this question
    IF NEW.is_first_attempt = TRUE THEN
        -- 1. Update user_stats (for attempts and accuracy)
        INSERT INTO public.user_stats (
            user_id, total_attempts, correct_attempts, accuracy_rate, unique_questions_attempted,
            total_time_spent_seconds, created_at, updated_at
        ) VALUES (
            NEW.user_id, 1, CASE WHEN NEW.is_correct THEN 1 ELSE 0 END, CASE WHEN NEW.is_correct THEN 100 ELSE 0 END, 1,
            NEW.time_spent_seconds, NOW(), NOW()
        )
        ON CONFLICT (user_id) DO UPDATE SET
            total_attempts = user_stats.total_attempts + 1,
            correct_attempts = user_stats.correct_attempts + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
            accuracy_rate = CASE 
                WHEN (user_stats.total_attempts + 1) > 0 
                THEN ROUND(((user_stats.correct_attempts + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END)::NUMERIC / (user_stats.total_attempts + 1) * 100), 2)
                ELSE 0 
            END,
            unique_questions_attempted = user_stats.unique_questions_attempted + 1,
            total_time_spent_seconds = user_stats.total_time_spent_seconds + NEW.time_spent_seconds,
            updated_at = NOW();

        -- 2. Update user_profiles (for problems_solved)
        UPDATE user_profiles
        SET 
            problems_solved = problems_solved + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
            updated_at = NOW()
        WHERE id = NEW.user_id;

        -- We DO NOT accumulate study_hours here anymore because they are array based [0,0,0,0,0,0,0]
        -- Dashboard gets time from question_attempts
    ELSE
        -- If it's a review or retry, only update time spent in user_stats
        UPDATE public.user_stats
        SET 
            total_time_spent_seconds = total_time_spent_seconds + NEW.time_spent_seconds,
            updated_at = NOW()
        WHERE user_id = NEW.user_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_user_stats_on_attempt ON question_attempts;
CREATE TRIGGER trigger_update_user_stats_on_attempt
AFTER INSERT ON question_attempts
FOR EACH ROW
EXECUTE FUNCTION update_user_stats_on_attempt();
