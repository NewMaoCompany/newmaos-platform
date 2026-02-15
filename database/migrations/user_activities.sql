-- =====================================================
-- Session History & User Activities Migration
-- =====================================================

-- 1. Update user_section_progress to track high-level history stats
ALTER TABLE public.user_section_progress 
ADD COLUMN IF NOT EXISTS first_attempt_score INTEGER,
ADD COLUMN IF NOT EXISTS first_attempt_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS review_count INTEGER DEFAULT 0;

-- 2. Create user_activities table for detailed session snapshots
CREATE TABLE IF NOT EXISTS public.user_activities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    section_id VARCHAR(50) NOT NULL,
    attempt_type VARCHAR(20) NOT NULL CHECK (attempt_type IN ('first_attempt', 'review')),
    score INTEGER NOT NULL,
    correct_count INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    data JSONB NOT NULL DEFAULT '{}'::jsonb, -- Store snapshot of userAnswers and questionResults
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.user_activities ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view own activities" ON public.user_activities
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own activities" ON public.user_activities
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 3. RPC: Log User Activity
-- Logs a snapshot only if correct_count >= 1 (User requirement)
CREATE OR REPLACE FUNCTION log_user_activity(
    p_section_id VARCHAR,
    p_attempt_type VARCHAR,
    p_score INTEGER,
    p_correct_count INTEGER,
    p_total_questions INTEGER,
    p_data JSONB
) RETURNS UUID AS $$
DECLARE
    v_activity_id UUID;
BEGIN
    -- Only log if at least one question was correct (User Requirement)
    IF p_correct_count < 1 THEN
        RETURN NULL;
    END IF;

    INSERT INTO public.user_activities (
        user_id,
        section_id,
        attempt_type,
        score,
        correct_count,
        total_questions,
        data
    ) VALUES (
        auth.uid(),
        p_section_id,
        p_attempt_type,
        p_score,
        p_correct_count,
        p_total_questions,
        p_data
    ) RETURNING id INTO v_activity_id;

    -- Update summary stats in user_section_progress
    IF p_attempt_type = 'first_attempt' THEN
        UPDATE public.user_section_progress
        SET 
            first_attempt_score = p_score,
            first_attempt_at = NOW()
        WHERE user_id = auth.uid() AND section_id = p_section_id
          AND first_attempt_at IS NULL;
    ELSE
        UPDATE public.user_section_progress
        SET review_count = review_count + 1
        WHERE user_id = auth.uid() AND section_id = p_section_id;
    END IF;

    RETURN v_activity_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. RPC: Get User Activities for a section
CREATE OR REPLACE FUNCTION get_user_activities(p_section_id VARCHAR)
RETURNS TABLE (
    id UUID,
    attempt_type VARCHAR,
    score INTEGER,
    correct_count INTEGER,
    total_questions INTEGER,
    data JSONB,
    created_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ua.id,
        ua.attempt_type,
        ua.score,
        ua.correct_count,
        ua.total_questions,
        ua.data,
        ua.created_at
    FROM public.user_activities ua
    WHERE ua.user_id = auth.uid() AND ua.section_id = p_section_id
    ORDER BY ua.created_at ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
