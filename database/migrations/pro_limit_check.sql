-- Check daily practice limit RPC
CREATE OR REPLACE FUNCTION check_daily_practice_limit()
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_is_pro BOOLEAN;
    v_daily_count INT;
    v_limit INT := 10;
BEGIN
    -- Check if user is PRO
    SELECT (subscription_tier = 'pro' OR is_creator = true) INTO v_is_pro
    FROM public.user_profiles
    WHERE id = auth.uid();

    IF v_is_pro THEN
        RETURN jsonb_build_object('allowed', true, 'is_pro', true, 'count', 0, 'limit', NULL);
    END IF;

    -- Count today's attempts (unique questions)
    SELECT COUNT(DISTINCT question_id) INTO v_daily_count
    FROM public.question_attempts
    WHERE user_id = auth.uid() 
      AND created_at >= CURRENT_DATE;

    IF v_daily_count >= v_limit THEN
        RETURN jsonb_build_object('allowed', false, 'is_pro', false, 'count', v_daily_count, 'limit', v_limit);
    END IF;

    RETURN jsonb_build_object('allowed', true, 'is_pro', false, 'count', v_daily_count, 'limit', v_limit);
END;
$$;
