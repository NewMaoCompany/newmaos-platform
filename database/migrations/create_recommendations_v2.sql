-- =====================================================
-- PART 4: FINALIZE RECOMMENDATIONS TABLE & LOGIC
-- Ensures valid structure and adds expires_at logic
-- =====================================================

-- 1. Create table if not exists
CREATE TABLE IF NOT EXISTS public.recommendations (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    score NUMERIC(4,3),
    reason VARCHAR(50),
    reason_detail TEXT,
    skill_id VARCHAR(50),  -- Optional link to skill
    priority INTEGER DEFAULT 999,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, question_id)
);

-- Safely add expires_at if it doesn't exist (for existing tables)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'recommendations' AND column_name = 'expires_at') THEN
        ALTER TABLE public.recommendations ADD COLUMN expires_at TIMESTAMPTZ DEFAULT (NOW() + INTERVAL '24 hours');
    END IF;
END $$;

-- Enable RLS
ALTER TABLE public.recommendations ENABLE ROW LEVEL SECURITY;

-- Drop policy to avoid "already exists" error
DROP POLICY IF EXISTS "Users can view own recommendations" ON public.recommendations;

CREATE POLICY "Users can view own recommendations" ON public.recommendations
    FOR SELECT USING (auth.uid() = user_id);

-- 2. Update Generator Function to populate expires_at
-- Must drop first because return type signature is changing
DROP FUNCTION IF EXISTS generate_recommendations(uuid, integer);

CREATE OR REPLACE FUNCTION generate_recommendations(p_user_id UUID, p_limit INTEGER DEFAULT 10)
RETURNS TABLE (
    question_id UUID,
    score NUMERIC,
    reason VARCHAR(50),
    reason_detail TEXT,
    skill_id VARCHAR(50),
    expires_at TIMESTAMPTZ
) AS $$
BEGIN
    -- Clear old recommendations
    DELETE FROM public.recommendations 
    WHERE user_id = p_user_id;

    -- Insert new recommendations based on low mastery skills
    INSERT INTO public.recommendations (user_id, question_id, score, reason, reason_detail, skill_id, priority, expires_at)
    SELECT DISTINCT ON (q.id)
        p_user_id,
        q.id,
        (1 - usm.mastery_score / 100.0) AS score,
        'low_mastery',
        CONCAT('Your mastery of "', s.name, '" is ', usm.mastery_score::INTEGER, '%'),
        usm.skill_id,
        ROW_NUMBER() OVER (ORDER BY usm.mastery_score ASC, usm.last_practiced ASC),
        NOW() + INTERVAL '24 hours' -- Set expiration
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
    INSERT INTO public.recommendations (user_id, question_id, score, reason, reason_detail, priority, expires_at)
    SELECT 
        p_user_id,
        uqs.question_id,
        0.8,
        'spaced_review',
        'Due for spaced repetition review',
        100 + ROW_NUMBER() OVER (ORDER BY uqs.next_review_at ASC),
        NOW() + INTERVAL '24 hours'
    FROM public.user_question_state uqs
    WHERE uqs.user_id = p_user_id
        AND uqs.next_review_at <= NOW()
    ORDER BY uqs.next_review_at ASC
    LIMIT p_limit
    ON CONFLICT (user_id, question_id) DO NOTHING;

    -- Return all recommendations
    RETURN QUERY
    SELECT r.question_id, r.score, r.reason, r.reason_detail, r.skill_id, r.expires_at
    FROM public.recommendations r
    WHERE r.user_id = p_user_id
    ORDER BY r.priority ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
