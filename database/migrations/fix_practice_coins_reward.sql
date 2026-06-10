-- ============================================================
-- FIX: Atomic Practice Coin Rewards in submit_attempt
-- Ensures strict 5 coin reward for FIRST correct answer per question
-- ============================================================

CREATE OR REPLACE FUNCTION public.submit_attempt(
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
    v_prior_correct_count INT;
    v_coins_awarded INT := 0;
    v_idempotency_key TEXT;
BEGIN
    -- 1. Check how many attempts exist
    SELECT COUNT(*) + 1 INTO v_attempt_no
    FROM public.question_attempts
    WHERE user_id = auth.uid() AND question_id = p_question_id::UUID;

    -- 2. Check if user already answered this correctly in the past
    SELECT COUNT(*) INTO v_prior_correct_count
    FROM public.question_attempts
    WHERE user_id = auth.uid() AND question_id = p_question_id::UUID AND is_correct = true;

    -- 3. Insert the new attempt
    INSERT INTO public.question_attempts (
        user_id, question_id, is_correct,
        selected_option_id, answer_numeric,
        time_spent_seconds, error_tags
    ) VALUES (
        auth.uid(), p_question_id::UUID, p_is_correct,
        p_selected_option_id, p_answer_numeric,
        COALESCE(p_time_spent_seconds, 0),
        COALESCE(p_error_tags, '{}')
    ) RETURNING id INTO v_attempt_id;

    -- 4. Calculate and award coins STRICTLY
    -- If they got it right NOW, and had ZERO prior correct answers, they earn exactly 5 coins
    IF p_is_correct = true AND v_prior_correct_count = 0 THEN
        v_idempotency_key := 'practice_reward_' || auth.uid()::TEXT || '_' || p_question_id;

        -- Ensure user_points exists
        INSERT INTO public.user_points (user_id, balance, lifetime_earned)
        VALUES (auth.uid(), 0, 0)
        ON CONFLICT (user_id) DO NOTHING;

        -- Insert ledger entry. If it conflicts (somehow already rewarded), do nothing.
        BEGIN
            INSERT INTO public.points_ledger (user_id, amount, type, source_id, description, idempotency_key)
            VALUES (auth.uid(), 5, 'earned', 'practice_reward', 'Practice Correct Answer', v_idempotency_key);

            -- If insert succeeded, update balance
            UPDATE public.user_points
            SET balance = balance + 5,
                lifetime_earned = lifetime_earned + 5
            WHERE user_id = auth.uid();

            v_coins_awarded := 5;
        EXCEPTION WHEN unique_violation THEN
            -- Already rewarded according to ledger
            v_coins_awarded := 0;
        END;
    END IF;

    RETURN jsonb_build_object(
        'success', true,
        'attempt_id', v_attempt_id,
        'attempt_no', v_attempt_no,
        'is_correct', p_is_correct,
        'coins_awarded', v_coins_awarded
    );
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object(
        'success', false,
        'error', SQLERRM
    );
END;
$$;

GRANT EXECUTE ON FUNCTION submit_attempt(TEXT, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO authenticated;
GRANT EXECUTE ON FUNCTION submit_attempt(TEXT, BOOLEAN, TEXT, NUMERIC, NUMERIC, TEXT[]) TO service_role;
