-- RPC to get study time history
CREATE OR REPLACE FUNCTION public.get_study_time_history(
    target_user_id UUID, 
    range_type TEXT -- '1W', '1M', '1Y', 'ALL'
)
RETURNS TABLE (
    date TEXT,
    minutes NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    start_date TIMESTAMPTZ;
BEGIN
    -- Determine start date based on range
    IF range_type = '1W' THEN
        start_date := now() - INTERVAL '7 days';
    ELSIF range_type = '1M' THEN
        start_date := now() - INTERVAL '1 month';
    ELSIF range_type = '1Y' THEN
        start_date := now() - INTERVAL '1 year';
    ELSE -- ALL
        start_date := '2000-01-01'::TIMESTAMPTZ; -- Beginning of time
    END IF;

    RETURN QUERY
    SELECT 
        to_char(created_at AT TIME ZONE 'UTC', 'YYYY-MM-DD') as date,
        ROUND(SUM(time_spent_seconds)::NUMERIC / 60, 1) as minutes
    FROM 
        public.question_attempts
    WHERE 
        user_id = target_user_id
        AND created_at >= start_date
    GROUP BY 
        1
    ORDER BY 
        1 ASC;
END;
$$;
