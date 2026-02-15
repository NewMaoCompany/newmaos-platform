-- =====================================================
-- Agent Insight Triggers & Functions
-- Run this AFTER agent_insight_schema.sql
-- Automatic updates driven by question_attempts
-- =====================================================

-- =====================================================
-- PART 1: TRIGGER - Update user_stats on new attempt
-- =====================================================

CREATE OR REPLACE FUNCTION update_user_stats_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_last_date DATE;
    v_new_streak INTEGER;
BEGIN
    -- Get the last streak date for this user
    SELECT last_streak_date INTO v_last_date
    FROM public.user_stats
    WHERE user_id = NEW.user_id;

    -- Calculate new streak
    IF v_last_date IS NULL OR v_last_date < v_today - 1 THEN
        v_new_streak := 1;  -- Start new streak
    ELSIF v_last_date = v_today - 1 THEN
        v_new_streak := COALESCE((
            SELECT current_streak_days FROM public.user_stats WHERE user_id = NEW.user_id
        ), 0) + 1;  -- Continue streak
    ELSE
        v_new_streak := COALESCE((
            SELECT current_streak_days FROM public.user_stats WHERE user_id = NEW.user_id
        ), 1);  -- Same day, no change
    END IF;

    -- Upsert user_stats
    INSERT INTO public.user_stats (
        user_id,
        total_attempts,
        correct_attempts,
        accuracy_rate,
        unique_questions_attempted,
        streak_correct,
        streak_wrong,
        current_streak_days,
        longest_streak_days,
        total_time_spent_seconds,
        last_practiced,
        last_streak_date
    ) VALUES (
        NEW.user_id,
        1,
        CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        CASE WHEN NEW.is_correct THEN 100 ELSE 0 END,
        1,
        CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        CASE WHEN NEW.is_correct THEN 0 ELSE 1 END,
        v_new_streak,
        v_new_streak,
        COALESCE(NEW.time_spent_seconds, 0),
        NOW(),
        v_today
    )
    ON CONFLICT (user_id) DO UPDATE SET
        total_attempts = user_stats.total_attempts + 1,
        correct_attempts = user_stats.correct_attempts + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        accuracy_rate = ROUND(
            ((user_stats.correct_attempts + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END)::NUMERIC / 
             (user_stats.total_attempts + 1) * 100), 2
        ),
        unique_questions_attempted = (
            SELECT COUNT(DISTINCT question_id) 
            FROM public.question_attempts 
            WHERE user_id = NEW.user_id
        ),
        streak_correct = CASE 
            WHEN NEW.is_correct THEN user_stats.streak_correct + 1 
            ELSE 0 
        END,
        streak_wrong = CASE 
            WHEN NEW.is_correct THEN 0 
            ELSE user_stats.streak_wrong + 1 
        END,
        current_streak_days = v_new_streak,
        longest_streak_days = GREATEST(user_stats.longest_streak_days, v_new_streak),
        total_time_spent_seconds = user_stats.total_time_spent_seconds + COALESCE(NEW.time_spent_seconds, 0),
        last_practiced = NOW(),
        last_streak_date = v_today,
        updated_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_update_user_stats ON public.question_attempts;
CREATE TRIGGER trg_update_user_stats
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_user_stats_on_attempt();


-- =====================================================
-- PART 2: TRIGGER - Update user_skill_mastery on new attempt
-- =====================================================

CREATE OR REPLACE FUNCTION update_skill_mastery_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_skill RECORD;
    v_delta NUMERIC;
    v_new_mastery NUMERIC;
    v_confidence NUMERIC;
BEGIN
    -- Loop through all skills linked to this question
    FOR v_skill IN 
        SELECT qs.skill_id, qs.weight, qs.role
        FROM public.question_skills qs
        WHERE qs.question_id = NEW.question_id
    LOOP
        -- Calculate mastery delta based on correctness and skill weight
        IF NEW.is_correct THEN
            v_delta := 5.0 * v_skill.weight;  -- Gain mastery
        ELSE
            v_delta := -3.0 * v_skill.weight;  -- Lose mastery
        END IF;

        -- Upsert user_skill_mastery
        INSERT INTO public.user_skill_mastery (
            user_id,
            skill_id,
            mastery_score,
            confidence,
            last_practiced,
            streak_correct,
            streak_wrong
        ) VALUES (
            NEW.user_id,
            v_skill.skill_id,
            GREATEST(0, LEAST(100, 50 + v_delta)),  -- Start at 50, apply delta
            0.3,  -- Initial confidence
            NOW(),
            CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
            CASE WHEN NEW.is_correct THEN 0 ELSE 1 END
        )
        ON CONFLICT (user_id, skill_id) DO UPDATE SET
            mastery_score = GREATEST(0, LEAST(100, 
                user_skill_mastery.mastery_score + v_delta
            )),
            confidence = LEAST(1.0, user_skill_mastery.confidence + 0.05),
            last_practiced = NOW(),
            streak_correct = CASE 
                WHEN NEW.is_correct THEN user_skill_mastery.streak_correct + 1 
                ELSE 0 
            END,
            streak_wrong = CASE 
                WHEN NEW.is_correct THEN 0 
                ELSE user_skill_mastery.streak_wrong + 1 
            END;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_update_skill_mastery ON public.question_attempts;
CREATE TRIGGER trg_update_skill_mastery
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_skill_mastery_on_attempt();


-- =====================================================
-- PART 3: TRIGGER - Update topic_mastery on new attempt
-- =====================================================

CREATE OR REPLACE FUNCTION update_topic_mastery_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_topic_id VARCHAR(50);
    v_delta NUMERIC;
BEGIN
    -- Get the topic_id from the question
    SELECT topic_id INTO v_topic_id
    FROM public.questions
    WHERE id = NEW.question_id;

    IF v_topic_id IS NULL THEN
        RETURN NEW;  -- No topic linked, skip
    END IF;

    -- Calculate mastery delta
    IF NEW.is_correct THEN
        v_delta := 3.0;
    ELSE
        v_delta := -2.0;
    END IF;

    -- Upsert topic_mastery
    INSERT INTO public.topic_mastery (
        user_id,
        subject,
        topic_id,
        mastery_score,
        full_mark
    ) VALUES (
        NEW.user_id,
        v_topic_id,  -- Use topic_id as subject for now
        v_topic_id,
        GREATEST(0, LEAST(100, 50 + v_delta)),
        100
    )
    ON CONFLICT (user_id, topic_id) WHERE topic_id IS NOT NULL DO UPDATE SET
        mastery_score = GREATEST(0, LEAST(100, 
            topic_mastery.mastery_score + v_delta
        )),
        topic_id = COALESCE(topic_mastery.topic_id, excluded.topic_id),
        updated_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_update_topic_mastery ON public.question_attempts;
CREATE TRIGGER trg_update_topic_mastery
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_topic_mastery_on_attempt();


-- =====================================================
-- PART 4: TRIGGER - Update user_question_state (spaced repetition)
-- =====================================================

CREATE OR REPLACE FUNCTION update_question_state_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_current_ef NUMERIC;
    v_current_interval INTEGER;
    v_review_count INTEGER;
    v_new_ef NUMERIC;
    v_new_interval INTEGER;
    v_quality INTEGER;  -- SM-2 quality (0-5)
BEGIN
    -- Get current state
    SELECT ease_factor, interval_days, review_count 
    INTO v_current_ef, v_current_interval, v_review_count
    FROM public.user_question_state
    WHERE user_id = NEW.user_id AND question_id = NEW.question_id;

    -- Default values if no state exists
    v_current_ef := COALESCE(v_current_ef, 2.5);
    v_current_interval := COALESCE(v_current_interval, 1);
    v_review_count := COALESCE(v_review_count, 0);

    -- Calculate SM-2 quality based on correctness and time
    IF NEW.is_correct THEN
        -- Fast and correct = quality 5, slow but correct = quality 3
        IF NEW.time_spent_seconds < 60 THEN
            v_quality := 5;
        ELSIF NEW.time_spent_seconds < 120 THEN
            v_quality := 4;
        ELSE
            v_quality := 3;
        END IF;
    ELSE
        -- Wrong = quality 0-2
        v_quality := 1;
    END IF;

    -- SM-2 Ease Factor calculation
    v_new_ef := v_current_ef + (0.1 - (5 - v_quality) * (0.08 + (5 - v_quality) * 0.02));
    v_new_ef := GREATEST(1.3, v_new_ef);  -- Minimum EF is 1.3

    -- Calculate new interval
    IF v_quality < 3 THEN
        -- Failed: reset interval
        v_new_interval := 1;
    ELSIF v_review_count = 0 THEN
        v_new_interval := 1;
    ELSIF v_review_count = 1 THEN
        v_new_interval := 6;
    ELSE
        v_new_interval := CEIL(v_current_interval * v_new_ef);
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
        v_new_ef,
        v_new_interval,
        1,
        NOW() + (v_new_interval || ' days')::INTERVAL,
        NOW()
    )
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        last_attempt_id = NEW.id,
        ease_factor = v_new_ef,
        interval_days = v_new_interval,
        review_count = user_question_state.review_count + 1,
        next_review_at = NOW() + (v_new_interval || ' days')::INTERVAL,
        updated_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_update_question_state ON public.question_attempts;
CREATE TRIGGER trg_update_question_state
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_question_state_on_attempt();


-- =====================================================
-- PART 5: TRIGGER - Create activity on attempt
-- =====================================================

CREATE OR REPLACE FUNCTION create_activity_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_title VARCHAR(255);
    v_description TEXT;
    v_score INTEGER;
BEGIN
    -- Build activity title
    IF NEW.is_correct THEN
        v_title := '✅ Answered correctly';
        v_score := 100;
    ELSE
        v_title := '❌ Needs review';
        v_score := 0;
    END IF;

    -- Build description
    SELECT CONCAT('Question in ', COALESCE(q.topic_id, q.topic))
    INTO v_description
    FROM public.questions q
    WHERE q.id = NEW.question_id;

    -- Insert activity
    INSERT INTO public.activities (user_id, type, title, description, score)
    VALUES (NEW.user_id, 'practice', v_title, v_description, v_score);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_create_activity ON public.question_attempts;
CREATE TRIGGER trg_create_activity
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION create_activity_on_attempt();


-- =====================================================
-- PART 6: FUNCTION - Generate recommendations
-- =====================================================

CREATE OR REPLACE FUNCTION generate_recommendations(p_user_id UUID, p_limit INTEGER DEFAULT 10)
RETURNS TABLE (
    question_id UUID,
    score NUMERIC,
    reason VARCHAR(50),
    reason_detail TEXT,
    skill_id VARCHAR(50)
) AS $$
BEGIN
    -- Clear old recommendations
    DELETE FROM public.recommendations 
    WHERE user_id = p_user_id;

    -- Insert new recommendations based on low mastery skills
    INSERT INTO public.recommendations (user_id, question_id, score, reason, reason_detail, skill_id, priority)
    SELECT DISTINCT ON (q.id)
        p_user_id,
        q.id,
        (1 - usm.mastery_score / 100.0) AS score,
        'low_mastery',
        CONCAT('Your mastery of "', s.name, '" is ', usm.mastery_score::INTEGER, '%'),
        usm.skill_id,
        ROW_NUMBER() OVER (ORDER BY usm.mastery_score ASC, usm.last_practiced ASC)
    FROM public.user_skill_mastery usm
    JOIN public.skills s ON s.id = usm.skill_id
    JOIN public.question_skills qs ON qs.skill_id = usm.skill_id
    JOIN public.questions q ON q.id = qs.question_id
    WHERE usm.user_id = p_user_id
      AND usm.mastery_score < 70
      AND q.status IN ('active', 'published')
      AND NOT EXISTS (
          SELECT 1 FROM public.question_attempts qa 
          WHERE qa.user_id = p_user_id 
            AND qa.question_id = q.id 
            AND qa.is_correct = true
            AND qa.created_at > NOW() - INTERVAL '7 days'
      )
    ORDER BY q.id, usm.mastery_score ASC
    LIMIT p_limit;

    -- Add spaced review recommendations
    INSERT INTO public.recommendations (user_id, question_id, score, reason, reason_detail, priority)
    SELECT 
        p_user_id,
        uqs.question_id,
        0.8,
        'spaced_review',
        'Due for spaced repetition review',
        100 + ROW_NUMBER() OVER (ORDER BY uqs.next_review_at ASC)
    FROM public.user_question_state uqs
    WHERE uqs.user_id = p_user_id
      AND uqs.next_review_at <= NOW()
    ORDER BY uqs.next_review_at ASC
    LIMIT p_limit
    ON CONFLICT (user_id, question_id) DO NOTHING;

    -- Return all recommendations
    RETURN QUERY
    SELECT r.question_id, r.score, r.reason, r.reason_detail, r.skill_id
    FROM public.recommendations r
    WHERE r.user_id = p_user_id
    ORDER BY r.priority ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- =====================================================
-- DONE!
-- =====================================================
-- Triggers & Functions complete:
-- ✅ trg_update_user_stats - Updates stats on each attempt
-- ✅ trg_update_skill_mastery - Updates skill mastery
-- ✅ trg_update_topic_mastery - Updates topic mastery
-- ✅ trg_update_question_state - SM-2 spaced repetition
-- ✅ trg_create_activity - Creates timeline activity
-- ✅ generate_recommendations() - Creates personalized recommendations
