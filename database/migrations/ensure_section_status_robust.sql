-- =====================================================
-- Ensure Section Status Tracking Exists
-- =====================================================

-- 1. Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.user_section_progress (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    section_id VARCHAR(50) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('in_progress', 'completed')),
    data JSONB DEFAULT '{}'::jsonb,
    score INTEGER DEFAULT 0,
    total_questions INTEGER DEFAULT 0,
    correct_questions INTEGER DEFAULT 0,
    last_accessed_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, section_id)
);

-- 2. Ensure 'status' column exists (safe alter)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'user_section_progress' AND column_name = 'status') THEN
        ALTER TABLE public.user_section_progress ADD COLUMN status VARCHAR(20) CHECK (status IN ('in_progress', 'completed'));
    END IF;
END $$;

-- 3. Enable RLS
ALTER TABLE public.user_section_progress ENABLE ROW LEVEL SECURITY;

-- 4. Policies (Drop first to avoid conflicts in 'create if not exists' context limited support)
DROP POLICY IF EXISTS "Users can view own section progress" ON public.user_section_progress;
CREATE POLICY "Users can view own section progress" ON public.user_section_progress
    FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage own section progress" ON public.user_section_progress;
CREATE POLICY "Users can manage own section progress" ON public.user_section_progress
    FOR ALL USING (auth.uid() = user_id);

-- 5. RPC Functions (Idempotent by nature of OR REPLACE)

-- Save session progress
CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id VARCHAR,
    p_data JSONB,
    p_time_spent INTEGER DEFAULT 0
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO public.user_section_progress (
        user_id, section_id, status, data, last_accessed_at
    ) VALUES (
        auth.uid(), p_section_id, 'in_progress', p_data, NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'in_progress',
        data = p_data,
        last_accessed_at = NOW();
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get Topic Progress
CREATE OR REPLACE FUNCTION get_topic_section_progress(p_topic_id VARCHAR)
RETURNS TABLE (
    section_id VARCHAR,
    status VARCHAR,
    score INTEGER,
    correct_questions INTEGER,
    total_questions INTEGER,
    last_accessed_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        usp.section_id,
        usp.status,
        usp.score,
        usp.correct_questions,
        usp.total_questions,
        usp.last_accessed_at
    FROM public.user_section_progress usp
    JOIN public.sections s ON s.id = usp.section_id
    WHERE usp.user_id = auth.uid() AND s.topic_id = p_topic_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
