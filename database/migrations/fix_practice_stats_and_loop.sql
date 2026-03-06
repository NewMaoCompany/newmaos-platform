-- =====================================================
-- FIX PRACTICE STATS DOUBLE-COUNTING
-- This script ensures that user_stats only increments 
-- total_attempts and correct_attempts on the FIRST attempt of a question.
-- =====================================================

CREATE OR REPLACE FUNCTION update_user_stats_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_last_date DATE;
    v_new_streak INTEGER;
    v_capped_time INTEGER;
    v_is_first_attempt BOOLEAN;
BEGIN
    SELECT last_streak_date INTO v_last_date FROM public.user_stats WHERE user_id = NEW.user_id;

    -- Cap time at 10 minutes (600s) to prevent outliers (e.g. left tab open)
    v_capped_time := LEAST(COALESCE(NEW.time_spent_seconds, 0), 600);
    
    -- Check if this is the first attempt for this question by this user
    -- Since the row is already inserted (AFTER INSERT trigger), COUNT(*) will be 1 if it's the first.
    SELECT (COUNT(*) = 1) INTO v_is_first_attempt 
    FROM public.question_attempts 
    WHERE user_id = NEW.user_id AND question_id = NEW.question_id;

    -- Streak Logic
    IF v_last_date IS NULL OR v_last_date < v_today - 1 THEN
        v_new_streak := 1;
    ELSIF v_last_date = v_today - 1 THEN
        v_new_streak := COALESCE((SELECT current_streak_days FROM public.user_stats WHERE user_id = NEW.user_id), 0) + 1;
    ELSE
        v_new_streak := COALESCE((SELECT current_streak_days FROM public.user_stats WHERE user_id = NEW.user_id), 1);
    END IF;

    -- Upsert Stats
    INSERT INTO public.user_stats (
        user_id, total_attempts, correct_attempts, accuracy_rate, unique_questions_attempted,
        streak_correct, streak_wrong, current_streak_days, longest_streak_days,
        total_time_spent_seconds, last_practiced, last_streak_date
    ) VALUES (
        NEW.user_id, 
        CASE WHEN v_is_first_attempt THEN 1 ELSE 0 END,
        CASE WHEN v_is_first_attempt AND NEW.is_correct THEN 1 ELSE 0 END,
        CASE WHEN v_is_first_attempt AND NEW.is_correct THEN 100 ELSE 0 END,
        CASE WHEN v_is_first_attempt THEN 1 ELSE 0 END,
        CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        CASE WHEN NEW.is_correct THEN 0 ELSE 1 END,
        v_new_streak, v_new_streak,
        v_capped_time,
        NOW(), v_today
    )
    ON CONFLICT (user_id) DO UPDATE SET
        total_attempts = user_stats.total_attempts + CASE WHEN v_is_first_attempt THEN 1 ELSE 0 END,
        correct_attempts = user_stats.correct_attempts + CASE WHEN v_is_first_attempt AND NEW.is_correct THEN 1 ELSE 0 END,
        accuracy_rate = CASE 
            WHEN (user_stats.total_attempts + CASE WHEN v_is_first_attempt THEN 1 ELSE 0 END) > 0 
            THEN ROUND(((user_stats.correct_attempts + CASE WHEN v_is_first_attempt AND NEW.is_correct THEN 1 ELSE 0 END)::NUMERIC / (user_stats.total_attempts + CASE WHEN v_is_first_attempt THEN 1 ELSE 0 END) * 100), 2)
            ELSE 0 
        END,
        unique_questions_attempted = user_stats.unique_questions_attempted + CASE WHEN v_is_first_attempt THEN 1 ELSE 0 END,
        streak_correct = CASE WHEN NEW.is_correct THEN user_stats.streak_correct + 1 ELSE 0 END,
        streak_wrong = CASE WHEN NEW.is_correct THEN 0 ELSE user_stats.streak_wrong + 1 END,
        current_streak_days = v_new_streak,
        longest_streak_days = GREATEST(user_stats.longest_streak_days, v_new_streak),
        total_time_spent_seconds = user_stats.total_time_spent_seconds + v_capped_time,
        last_practiced = NOW(),
        last_streak_date = v_today,
        updated_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
