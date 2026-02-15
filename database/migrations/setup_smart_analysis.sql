-- =====================================================
-- SMART ANALYSIS SETUP (Consolidated & Complete & Safe)
-- Run this file to enable:
-- 1. Real-time User Stats (Total Focus, Avg Speed)
-- 2. Smart Study Queue data
-- 3. Efficiency Insights
-- =====================================================

-- 1. Ensure user_stats table exists and has all columns
-- We use DO block to safely add columns if they don't exist
DO $$
BEGIN
    -- Create table if it doesn't exist
    CREATE TABLE IF NOT EXISTS public.user_stats (
        user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE
    );

    -- Safely add columns
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS total_attempts INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS correct_attempts INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS accuracy_rate NUMERIC(5,2) DEFAULT 0 CHECK (accuracy_rate BETWEEN 0 AND 100);
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS unique_questions_attempted INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS streak_correct INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS streak_wrong INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS current_streak_days INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS longest_streak_days INTEGER DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS total_time_spent_seconds BIGINT DEFAULT 0;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS last_practiced TIMESTAMPTZ;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS last_streak_date DATE;
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();
    ALTER TABLE public.user_stats ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();
END $$;

-- Enable RLS safely
ALTER TABLE public.user_stats ENABLE ROW LEVEL SECURITY;

-- Re-apply RLS policies (drop first to avoid conflicts)
DROP POLICY IF EXISTS "Users can view own stats" ON public.user_stats;
DROP POLICY IF EXISTS "Users can update own stats" ON public.user_stats;
DROP POLICY IF EXISTS "Users can insert own stats" ON public.user_stats;

CREATE POLICY "Users can view own stats" ON public.user_stats FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own stats" ON public.user_stats FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own stats" ON public.user_stats FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Initialize OR RECALCULATE user_stats for all users based on full history
INSERT INTO public.user_stats (
    user_id,
    total_attempts,
    correct_attempts,
    accuracy_rate,
    unique_questions_attempted,
    last_practiced,
    total_time_spent_seconds
)
SELECT 
    u.id,
    COALESCE(COUNT(qa.id), 0),
    COALESCE(COUNT(qa.id) FILTER (WHERE qa.is_correct), 0),
    COALESCE(ROUND((COUNT(qa.id) FILTER (WHERE qa.is_correct)::NUMERIC / NULLIF(COUNT(qa.id), 0) * 100), 2), 0),
    COALESCE(COUNT(DISTINCT qa.question_id), 0),
    MAX(qa.created_at),
    COALESCE(SUM(LEAST(qa.time_spent_seconds, 600)), 0)
FROM public.user_profiles u
LEFT JOIN public.question_attempts qa ON u.id = qa.user_id
GROUP BY u.id
ON CONFLICT (user_id) DO UPDATE SET
    total_attempts = EXCLUDED.total_attempts,
    correct_attempts = EXCLUDED.correct_attempts,
    accuracy_rate = EXCLUDED.accuracy_rate,
    unique_questions_attempted = EXCLUDED.unique_questions_attempted,
    last_practiced = EXCLUDED.last_practiced,
    total_time_spent_seconds = EXCLUDED.total_time_spent_seconds,
    updated_at = NOW();

-- 2. Create Trigger Function to Update user_stats on Attempt
CREATE OR REPLACE FUNCTION update_user_stats_on_attempt()
RETURNS TRIGGER AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_last_date DATE;
    v_new_streak INTEGER;
    v_capped_time INTEGER;
BEGIN
    SELECT last_streak_date INTO v_last_date FROM public.user_stats WHERE user_id = NEW.user_id;

    -- Cap time at 10 minutes (600s) to prevent outliers (e.g. left tab open)
    v_capped_time := LEAST(COALESCE(NEW.time_spent_seconds, 0), 600);

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
        NEW.user_id, 1,
        CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        CASE WHEN NEW.is_correct THEN 100 ELSE 0 END,
        1,
        CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        CASE WHEN NEW.is_correct THEN 0 ELSE 1 END,
        v_new_streak, v_new_streak,
        v_capped_time,
        NOW(), v_today
    )
    ON CONFLICT (user_id) DO UPDATE SET
        total_attempts = user_stats.total_attempts + 1,
        correct_attempts = user_stats.correct_attempts + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END,
        accuracy_rate = ROUND(((user_stats.correct_attempts + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END)::NUMERIC / (user_stats.total_attempts + 1) * 100), 2),
        unique_questions_attempted = (SELECT COUNT(DISTINCT question_id) FROM public.question_attempts WHERE user_id = NEW.user_id),
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

-- Attach Trigger
DROP TRIGGER IF EXISTS trg_update_user_stats ON public.question_attempts;
CREATE TRIGGER trg_update_user_stats
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW
    EXECUTE FUNCTION update_user_stats_on_attempt();

-- 3. Ensure get_user_insights RPC exists and returns correct fields (FULL VERSION)
CREATE OR REPLACE FUNCTION get_user_insights()
RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_stats JSONB;
    v_weak_skills JSONB;
    v_top_errors JSONB;
    v_review_queue JSONB;
    v_recommendations JSONB;
BEGIN
    IF v_user_id IS NULL THEN RAISE EXCEPTION 'User not authenticated'; END IF;

    -- Get user stats
    SELECT jsonb_build_object(
        'total_attempts', total_attempts,
        'correct_attempts', correct_attempts,
        'accuracy_rate', accuracy_rate,
        'unique_questions', unique_questions_attempted,
        'streak_days', current_streak_days,
        'longest_streak', longest_streak_days,
        'total_time_minutes', ROUND(total_time_spent_seconds / 60.0, 1),
        'last_practiced', last_practiced
    ) INTO v_stats
    FROM public.user_stats
    WHERE user_id = v_user_id;

    -- Get weakest skills (top 5) - Safely assuming tables exist, if not returns empty
    BEGIN
        SELECT COALESCE(jsonb_agg(skill_data), '[]'::jsonb) INTO v_weak_skills
        FROM (
            SELECT jsonb_build_object(
                'skill_id', usm.skill_id,
                'skill_name', s.name,
                'mastery', usm.mastery_score,
                'confidence', usm.confidence,
                'streak_wrong', usm.streak_wrong
            ) AS skill_data
            FROM public.user_skill_mastery usm
            JOIN public.skills s ON s.id = usm.skill_id
            WHERE usm.user_id = v_user_id
            ORDER BY usm.mastery_score ASC
            LIMIT 5
        ) sub;
    EXCEPTION WHEN undefined_table THEN
        v_weak_skills := '[]'::jsonb;
    END;

    -- Get top error types (top 5)
    BEGIN
        SELECT COALESCE(jsonb_agg(error_data), '[]'::jsonb) INTO v_top_errors
        FROM (
            SELECT jsonb_build_object(
                'error_tag_id', ae.error_tag_id,
                'error_name', et.name,
                'category', et.category,
                'count', COUNT(*)
            ) AS error_data
            FROM public.attempt_errors ae
            JOIN public.question_attempts qa ON qa.id = ae.attempt_id
            JOIN public.error_tags et ON et.id = ae.error_tag_id
            WHERE qa.user_id = v_user_id
            GROUP BY ae.error_tag_id, et.name, et.category
            ORDER BY COUNT(*) DESC
            LIMIT 5
        ) sub;
    EXCEPTION WHEN undefined_table THEN
         v_top_errors := '[]'::jsonb;
    END;

    -- Get review queue (due for review)
    BEGIN
        SELECT COALESCE(jsonb_agg(review_data), '[]'::jsonb) INTO v_review_queue
        FROM (
            SELECT jsonb_build_object(
                'question_id', uqs.question_id,
                'next_review_at', uqs.next_review_at,
                'review_count', uqs.review_count,
                'interval_days', uqs.interval_days
            ) AS review_data
            FROM public.user_question_state uqs
            WHERE uqs.user_id = v_user_id
              AND uqs.next_review_at <= NOW() + INTERVAL '1 day'
            ORDER BY uqs.next_review_at ASC
            LIMIT 10
        ) sub;
    EXCEPTION WHEN undefined_table THEN
         v_review_queue := '[]'::jsonb;
    END;

    -- Get recommendations (Optional: skips if complex logic is missing)
    v_recommendations := '[]'::jsonb;

    -- Return complete insights
    RETURN jsonb_build_object(
        'stats', COALESCE(v_stats, '{}'::jsonb),
        'weak_skills', COALESCE(v_weak_skills, '[]'::jsonb), 
        'top_errors', COALESCE(v_top_errors, '[]'::jsonb),
        'review_queue', COALESCE(v_review_queue, '[]'::jsonb),
        'recommendations', COALESCE(v_recommendations, '[]'::jsonb)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
