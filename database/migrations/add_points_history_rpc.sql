-- ============================================================
-- RPC: get_points_history
-- Returns daily income and expenditure for a user
-- ============================================================

CREATE OR REPLACE FUNCTION public.get_points_history(
    p_user_id UUID,
    p_days INTEGER DEFAULT 7
)
RETURNS TABLE (
    date DATE,
    income INTEGER,
    expense INTEGER
) AS $$
BEGIN
    RETURN QUERY
    WITH date_series AS (
        SELECT generate_series(
            CURRENT_DATE - (p_days - 1),
            CURRENT_DATE,
            '1 day'::interval
        )::DATE AS date
    ),
    daily_stats AS (
        SELECT
            created_at::DATE AS day,
            COALESCE(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 0) as inc,
            COALESCE(ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)), 0) as exp
        FROM
            public.points_ledger
        WHERE
            user_id = p_user_id
            AND created_at >= (CURRENT_DATE - (p_days - 1))
        GROUP BY
            created_at::DATE
    )
    SELECT
        ds.date,
        COALESCE(s.inc, 0)::INTEGER as income,
        COALESCE(s.exp, 0)::INTEGER as expense
    FROM
        date_series ds
    LEFT JOIN
        daily_stats s ON ds.date = s.day
    ORDER BY
        ds.date;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
