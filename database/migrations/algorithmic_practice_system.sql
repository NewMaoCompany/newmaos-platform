CREATE TABLE IF NOT EXISTS public.algorithmic_question_state (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    question_id VARCHAR NOT NULL,
    times_encountered INTEGER DEFAULT 0,
    times_correct INTEGER DEFAULT 0,
    times_incorrect INTEGER DEFAULT 0,
    last_encountered_at TIMESTAMPTZ DEFAULT NOW(),
    last_status VARCHAR,
    UNIQUE(user_id, question_id)
);

-- Enable RLS
ALTER TABLE public.algorithmic_question_state ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can manage their own algorithmic question state"
    ON public.algorithmic_question_state
    FOR ALL
    USING (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION submit_algorithmic_attempt(
    p_question_id VARCHAR,
    p_is_correct BOOLEAN,
    p_selected_option_id VARCHAR,
    p_time_spent_seconds INTEGER,
    p_session_id VARCHAR
) RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    INSERT INTO public.algorithmic_question_state (
        user_id,
        question_id,
        times_encountered,
        times_correct,
        times_incorrect,
        last_status,
        last_encountered_at
    ) VALUES (
        v_user_id,
        p_question_id,
        1,
        CASE WHEN p_is_correct THEN 1 ELSE 0 END,
        CASE WHEN NOT p_is_correct THEN 1 ELSE 0 END,
        CASE WHEN p_is_correct THEN 'correct' ELSE 'incorrect' END,
        NOW()
    )
    ON CONFLICT (user_id, question_id) DO UPDATE SET
        times_encountered = algorithmic_question_state.times_encountered + 1,
        times_correct = algorithmic_question_state.times_correct + CASE WHEN p_is_correct THEN 1 ELSE 0 END,
        times_incorrect = algorithmic_question_state.times_incorrect + CASE WHEN NOT p_is_correct THEN 1 ELSE 0 END,
        last_status = CASE WHEN p_is_correct THEN 'correct' ELSE 'incorrect' END,
        last_encountered_at = NOW();

    -- Also we could insert into question_attempts with an algorithmic flag, or a new table
    -- but for simplicity, we just keep the state.

    RETURN jsonb_build_object('success', true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION submit_algorithmic_attempt TO authenticated;
GRANT EXECUTE ON FUNCTION submit_algorithmic_attempt TO service_role;
