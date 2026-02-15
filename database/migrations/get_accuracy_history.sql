-- =====================================================
-- RPC to fetch Accuracy History (Trend)
-- Aggregates question_attempts by day
-- Used for "Accuracy Rate" chart on Dashboard
-- =====================================================

CREATE OR REPLACE FUNCTION get_accuracy_history(p_days INTEGER DEFAULT NULL)
RETURNS TABLE (
    date TEXT,
    total_attempts INTEGER,
    correct_attempts INTEGER,
    accuracy NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_start_date TIMESTAMPTZ;
BEGIN
    -- Determine start date based on input
    IF p_days IS NOT NULL THEN
        v_start_date := NOW() - (p_days || ' days')::INTERVAL;
    ELSE
        -- Default to beginning of time (or reasonable past) if NULL (ALL)
        v_start_date := '2000-01-01'::TIMESTAMPTZ;
    END IF;

    RETURN QUERY
    SELECT 
        -- Format date as YYYY-MM-DD for consistency
        to_char(date_trunc('day', qa.created_at), 'YYYY-MM-DD') as date,
        COUNT(*)::INTEGER as total_attempts,
        COUNT(*) FILTER (WHERE qa.is_correct = true)::INTEGER as correct_attempts,
        CASE 
            WHEN COUNT(*) > 0 THEN 
                ROUND((COUNT(*) FILTER (WHERE qa.is_correct = true)::NUMERIC / COUNT(*)::NUMERIC) * 100, 1)
            ELSE 0 
        END as accuracy
    FROM question_attempts qa
    WHERE qa.user_id = v_user_id
    AND qa.created_at >= v_start_date
    GROUP BY 1
    ORDER BY 1 ASC;
END;
$$;

-- Permissions
GRANT EXECUTE ON FUNCTION get_accuracy_history(INTEGER) TO authenticated;
GRANT EXECUTE ON FUNCTION get_accuracy_history(INTEGER) TO service_role;
