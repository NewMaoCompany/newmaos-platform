-- =====================================================
-- STEP 8: Post-Answer Closed-loop Update Triggers
-- Upgrades SM-2 and Skill Mastery calculations to strict formulas
-- Links attempt_errors directly from question_attempts
-- =====================================================

-- 8.1 / 8.2: Populate attempt_errors securely after attempt insert
CREATE OR REPLACE FUNCTION public.process_attempt_errors()
RETURNS TRIGGER AS $$
DECLARE
    v_error_tag VARCHAR;
BEGIN
    -- Only log specific errors if the attempt was incorrect and tags were provided
    IF NOT NEW.is_correct AND NEW.error_tags IS NOT NULL AND array_length(NEW.error_tags, 1) > 0 THEN
        FOR i IN 1 .. array_length(NEW.error_tags, 1) LOOP
            v_error_tag := NEW.error_tags[i];
            
            INSERT INTO public.attempt_errors (attempt_id, error_tag_id)
            VALUES (NEW.id, v_error_tag)
            ON CONFLICT DO NOTHING;
        END LOOP;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_process_attempt_errors ON public.question_attempts;
CREATE TRIGGER trg_process_attempt_errors
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION public.process_attempt_errors();


-- 8.3: SM-2 Variant with Time Penalty limits
CREATE OR REPLACE FUNCTION public.update_question_state_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_current_ef NUMERIC;
    v_current_interval INTEGER;
    v_review_count INTEGER;
    v_new_ef NUMERIC;
    v_new_interval INTEGER;
    v_quality INTEGER;  
    v_target_time INTEGER;
BEGIN
    -- Get current state
    SELECT ease_factor, interval_days, review_count 
    INTO v_current_ef, v_current_interval, v_review_count
    FROM public.user_question_state
    WHERE user_id = NEW.user_id AND question_id = NEW.question_id;

    -- Defaults
    v_current_ef := COALESCE(v_current_ef, 2.5);
    v_current_interval := COALESCE(v_current_interval, 1);
    v_review_count := COALESCE(v_review_count, 0);

    -- Target time from Step 3 profile
    SELECT t_target INTO v_target_time FROM public.v_question_profiles WHERE question_id = NEW.question_id;
    v_target_time := COALESCE(v_target_time, 90);

    -- Calculate SM-2 quality (0-5) factoring in time spent
    IF NEW.is_correct THEN
        IF COALESCE(NEW.time_spent_seconds, 0) <= v_target_time THEN
            v_quality := 5; -- Correct and Fast
        ELSE
            v_quality := 3; -- Correct but Slow/Struggled
        END IF;
    ELSE
        v_quality := 1; -- Wrong
    END IF;

    -- Update EF regardless
    v_new_ef := GREATEST(1.3, v_current_ef + 0.1 - (5.0 - v_quality) * (0.08 + (5.0 - v_quality) * 0.02));

    -- Calculate new interval
    IF v_quality < 3 THEN
        -- Failed: reset interval
        v_new_interval := 1;
    ELSIF v_review_count = 0 THEN
        v_new_interval := 1;
    ELSIF v_review_count = 1 THEN
        v_new_interval := 6;
    ELSE
        -- Success: Scale by ease factor
        v_new_interval := ROUND(v_current_interval * v_new_ef);
    END IF;

    -- Upsert user_question_state
    INSERT INTO public.user_question_state (
        user_id,
        question_id,
        last_attempt_id,
        ease_factor,
        interval_days,
        review_count,
        next_review_at,
        updated_at
    ) VALUES (
        NEW.user_id,
        NEW.question_id,
        NEW.id,
        ROUND(v_new_ef, 3),
        v_new_interval,
        1,
        NOW() + (v_new_interval || ' days')::INTERVAL,
        NOW()
    )
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        last_attempt_id = NEW.id,
        ease_factor = ROUND(v_new_ef, 3),
        interval_days = v_new_interval,
        review_count = user_question_state.review_count + 1,
        next_review_at = NOW() + (v_new_interval || ' days')::INTERVAL,
        updated_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 8.4: Skill Mastery Delta updates (Eta Smoothed)
CREATE OR REPLACE FUNCTION public.update_skill_mastery_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_w_is JSONB;
    v_skill_item JSONB;
    v_skill_id VARCHAR;
    v_weight NUMERIC;
    
    v_mastery_score NUMERIC;
    v_M NUMERIC;
    v_conf NUMERIC;
    v_delta NUMERIC;
    v_eta NUMERIC := 0.05; -- Learning learning rate
    
    v_target_time INTEGER;
BEGIN
    -- Extract weighted skills for this question
    SELECT w_is, t_target INTO v_w_is, v_target_time 
    FROM public.v_question_profiles WHERE question_id = NEW.question_id;
    
    v_target_time := COALESCE(v_target_time, 90);

    IF v_w_is IS NOT NULL AND jsonb_array_length(v_w_is) > 0 THEN
        FOR v_skill_item IN SELECT * FROM jsonb_array_elements(v_w_is)
        LOOP
            v_skill_id := (v_skill_item->>'skill_id')::VARCHAR;
            v_weight := (v_skill_item->>'weight')::NUMERIC;
            
            -- Fetch current M and Confidence
            SELECT mastery_score, confidence INTO v_mastery_score, v_conf
            FROM public.user_skill_mastery
            WHERE user_id = NEW.user_id AND skill_id = v_skill_id;
            
            v_mastery_score := COALESCE(v_mastery_score, 50.0);
            v_conf := COALESCE(v_conf, 0.3);
            v_M := v_mastery_score / 100.0;
            
            -- Delta computation
            IF NEW.is_correct THEN
                v_delta := v_eta * v_weight * (1.0 - v_M);
                v_conf := LEAST(1.0, v_conf + 0.02); -- Gain Confidence
            ELSE
                v_delta := -v_eta * v_weight * v_M;
                v_conf := GREATEST(0.0, v_conf - 0.03); -- Lose Confidence
            END IF;
            
            -- Squeeze penalty if they took excessively long
            IF COALESCE(NEW.time_spent_seconds, 0) > 1.2 * v_target_time THEN
                v_delta := 0.6 * v_delta;
            END IF;
            
            -- Final boundaries
            v_M := GREATEST(0, LEAST(1.0, v_M + v_delta));
            v_mastery_score := v_M * 100.0;
            
            -- Upsert
            INSERT INTO public.user_skill_mastery (
                user_id, skill_id, mastery_score, confidence, last_practiced,
                streak_correct, streak_wrong
            ) VALUES (
                NEW.user_id, v_skill_id, ROUND(v_mastery_score, 2), ROUND(v_conf, 2), NOW(),
                CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
                CASE WHEN NEW.is_correct THEN 0 ELSE 1 END
            )
            ON CONFLICT (user_id, skill_id) DO UPDATE SET
                mastery_score = ROUND(v_mastery_score, 2),
                confidence = ROUND(v_conf, 2),
                last_practiced = NOW(),
                streak_correct = CASE WHEN NEW.is_correct THEN user_skill_mastery.streak_correct + 1 ELSE 0 END,
                streak_wrong = CASE WHEN NEW.is_correct THEN 0 ELSE user_skill_mastery.streak_wrong + 1 END;
                
        END LOOP;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- 8.5: Aggregation Research Analytical Views (Optional execution)
-- Creates views to study the predictive curves over time.
-- =====================================================
CREATE OR REPLACE VIEW public.vw_research_skill_aggregation AS
SELECT 
    s.cluster_id,
    usm.skill_id,
    AVG(usm.mastery_score) as avg_mastery,
    AVG(usm.confidence) as avg_confidence,
    COUNT(DISTINCT usm.user_id) as users_tracked
FROM public.user_skill_mastery usm
JOIN public.skills s ON s.id = usm.skill_id
GROUP BY s.cluster_id, usm.skill_id
ORDER BY s.cluster_id, avg_mastery ASC;

CREATE OR REPLACE VIEW public.vw_research_prediction_calibration AS
SELECT 
    DATE(qa.created_at) as test_date,
    ROUND(AVG(
        (public.calculate_question_prediction(qa.user_id, qa.question_id)->>'p_ui')::NUMERIC
    ), 3) as avg_predicted_correctness,
    ROUND(AVG(CASE WHEN qa.is_correct THEN 1 ELSE 0 END)::NUMERIC, 3) as actual_correctness_ratio,
    COUNT(*) as attempt_volume
FROM public.question_attempts qa
GROUP BY DATE(qa.created_at)
ORDER BY test_date DESC;
