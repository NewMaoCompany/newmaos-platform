-- =====================================================
-- Agent Insight Schema Migration
-- Run this in Supabase SQL Editor
-- Creates user_question_state table and converts user_stats VIEW to TABLE
-- =====================================================

-- =====================================================
-- PART 1: CREATE user_question_state TABLE
-- User's long-term memory for each question
-- =====================================================

CREATE TABLE IF NOT EXISTS public.user_question_state (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    
    -- User preferences
    is_starred BOOLEAN DEFAULT false,
    is_flagged BOOLEAN DEFAULT false,
    personal_tags TEXT[] DEFAULT '{}',
    personal_note TEXT,
    
    -- Spaced Repetition (SM-2 algorithm)
    next_review_at TIMESTAMPTZ,
    ease_factor NUMERIC(4,2) DEFAULT 2.5 CHECK (ease_factor >= 1.3),
    interval_days INTEGER DEFAULT 1,
    review_count INTEGER DEFAULT 0,
    
    -- Link to last attempt
    last_attempt_id UUID REFERENCES public.question_attempts(id),
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    PRIMARY KEY (user_id, question_id)
);

-- Enable RLS
ALTER TABLE public.user_question_state ENABLE ROW LEVEL SECURITY;

-- Indexes for common queries
CREATE INDEX IF NOT EXISTS idx_user_question_state_starred 
ON public.user_question_state(user_id, is_starred) WHERE is_starred = true;

CREATE INDEX IF NOT EXISTS idx_user_question_state_flagged 
ON public.user_question_state(user_id, is_flagged) WHERE is_flagged = true;

CREATE INDEX IF NOT EXISTS idx_user_question_state_review 
ON public.user_question_state(user_id, next_review_at) 
WHERE next_review_at IS NOT NULL;

-- RLS Policies: Users can only access their own data
CREATE POLICY "Users can view own question state" ON public.user_question_state
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own question state" ON public.user_question_state
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own question state" ON public.user_question_state
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own question state" ON public.user_question_state
    FOR DELETE USING (auth.uid() = user_id);


-- =====================================================
-- PART 2: CONVERT user_stats FROM VIEW TO TABLE
-- =====================================================

-- 2a. Drop the existing VIEW
DROP VIEW IF EXISTS public.user_stats;

-- 2b. Create user_stats as a TABLE
CREATE TABLE IF NOT EXISTS public.user_stats (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    
    -- Attempt statistics
    total_attempts INTEGER DEFAULT 0,
    correct_attempts INTEGER DEFAULT 0,
    accuracy_rate NUMERIC(5,2) DEFAULT 0 CHECK (accuracy_rate BETWEEN 0 AND 100),
    unique_questions_attempted INTEGER DEFAULT 0,
    
    -- Streak tracking
    streak_correct INTEGER DEFAULT 0,
    streak_wrong INTEGER DEFAULT 0,
    current_streak_days INTEGER DEFAULT 0,
    longest_streak_days INTEGER DEFAULT 0,
    
    -- Time tracking
    total_time_spent_seconds BIGINT DEFAULT 0,
    last_practiced TIMESTAMPTZ,
    last_streak_date DATE,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.user_stats ENABLE ROW LEVEL SECURITY;

-- Index for leaderboard queries
CREATE INDEX IF NOT EXISTS idx_user_stats_accuracy 
ON public.user_stats(accuracy_rate DESC);

CREATE INDEX IF NOT EXISTS idx_user_stats_streak 
ON public.user_stats(current_streak_days DESC);

-- RLS Policies
CREATE POLICY "Users can view own stats" ON public.user_stats
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own stats" ON public.user_stats
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own stats" ON public.user_stats
    FOR UPDATE USING (auth.uid() = user_id);


-- =====================================================
-- PART 3: INITIALIZE user_stats FOR EXISTING USERS
-- =====================================================

-- Insert initial stats for all existing users who have attempts
INSERT INTO public.user_stats (
    user_id,
    total_attempts,
    correct_attempts,
    accuracy_rate,
    unique_questions_attempted,
    last_practiced
)
SELECT 
    u.id AS user_id,
    COALESCE(COUNT(qa.id), 0) AS total_attempts,
    COALESCE(COUNT(qa.id) FILTER (WHERE qa.is_correct), 0) AS correct_attempts,
    COALESCE(
        ROUND((COUNT(qa.id) FILTER (WHERE qa.is_correct)::NUMERIC / 
               NULLIF(COUNT(qa.id), 0) * 100), 2),
        0
    ) AS accuracy_rate,
    COALESCE(COUNT(DISTINCT qa.question_id), 0) AS unique_questions_attempted,
    MAX(qa.created_at) AS last_practiced
FROM public.user_profiles u
LEFT JOIN public.question_attempts qa ON u.id = qa.user_id
GROUP BY u.id
ON CONFLICT (user_id) DO UPDATE SET
    total_attempts = EXCLUDED.total_attempts,
    correct_attempts = EXCLUDED.correct_attempts,
    accuracy_rate = EXCLUDED.accuracy_rate,
    unique_questions_attempted = EXCLUDED.unique_questions_attempted,
    last_practiced = EXCLUDED.last_practiced,
    updated_at = NOW();


-- =====================================================
-- PART 4: ADD question_error_patterns TABLE
-- Links questions to expected error patterns
-- =====================================================

CREATE TABLE IF NOT EXISTS public.question_error_patterns (
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    error_tag_id VARCHAR(50) REFERENCES public.error_tags(id) ON DELETE CASCADE,
    option_id VARCHAR(100),  -- Which wrong option triggers this error
    frequency NUMERIC(3,2) DEFAULT 0.5 CHECK (frequency BETWEEN 0 AND 1),
    PRIMARY KEY (question_id, error_tag_id)
);

-- Enable RLS
ALTER TABLE public.question_error_patterns ENABLE ROW LEVEL SECURITY;

-- Index
CREATE INDEX IF NOT EXISTS idx_question_error_patterns_error 
ON public.question_error_patterns(error_tag_id);

-- RLS: Public read, creator write
CREATE POLICY "Anyone can view question error patterns" ON public.question_error_patterns
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "Creators can manage question error patterns" ON public.question_error_patterns
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );


-- =====================================================
-- DONE!
-- =====================================================
-- Schema migration complete:
-- ✅ user_question_state table created
-- ✅ user_stats converted from VIEW to TABLE
-- ✅ question_error_patterns table created
-- ✅ All RLS policies applied
