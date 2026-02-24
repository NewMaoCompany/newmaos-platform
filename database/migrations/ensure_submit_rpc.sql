-- =====================================================
-- CONNECT SUPABASE DATA: Question Attempts & RPC (SAFE MODE)
-- =====================================================

-- 1. Create table if not exists
CREATE TABLE IF NOT EXISTS public.question_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    question_id TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL,
    selected_option_id TEXT,
    answer_numeric NUMERIC,
    time_spent_seconds NUMERIC DEFAULT 0,
    error_tags TEXT[] DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS (Idempotent)
ALTER TABLE public.question_attempts ENABLE ROW LEVEL SECURITY;

-- 2. Drop existing policies to avoid conflicts
DROP POLICY IF EXISTS "Users can view own attempts" ON public.question_attempts;
DROP POLICY IF EXISTS "Users can insert own attempts" ON public.question_attempts;

-- 3. Re-create Policies
CREATE POLICY "Users can view own attempts" ON public.question_attempts
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own attempts" ON public.question_attempts
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 4. RPC: Submit Attempt (Idempotent Replacement)
CREATE OR REPLACE FUNCTION submit_attempt(
    p_question_id TEXT,
    p_is_correct BOOLEAN,
    p_selected_option_id TEXT DEFAULT NULL,
    p_answer_numeric NUMERIC DEFAULT NULL,
    p_time_spent_seconds NUMERIC DEFAULT 0,
    p_error_tags TEXT[] DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_attempt_id UUID;
    v_attempt_no INT;
BEGIN
    -- Calculate attempt number (1-based)
    SELECT COUNT(*) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = auth.uid() AND question_id = p_question_id;

    INSERT INTO public.question_attempts (
        user_id,
        question_id,
        is_correct,
        selected_option_id,
        answer_numeric,
        time_spent_seconds,
        error_tags
    ) VALUES (
        auth.uid(),
        p_question_id,
        p_is_correct,
        p_selected_option_id,
        p_answer_numeric,
        COALESCE(p_time_spent_seconds, 0),
        COALESCE(p_error_tags, '{}'::text[])
    ) RETURNING id INTO v_attempt_id;

    -- Return success payload matching AppContext interface
    RETURN jsonb_build_object(
        'success', true,
        'attempt_id', v_attempt_id,
        'attempt_no', v_attempt_no,
        'is_correct', p_is_correct
    );
END;
$$;

-- Grant permissions (Idempotent)
GRANT EXECUTE ON FUNCTION submit_attempt(TEXT, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO authenticated;
GRANT EXECUTE ON FUNCTION submit_attempt(TEXT, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO service_role;
