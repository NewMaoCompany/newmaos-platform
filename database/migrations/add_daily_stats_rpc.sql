-- =====================================================
-- Add Daily Stats RPC for Dashboard "24h Refresh" Metrics
-- =====================================================

CREATE OR REPLACE FUNCTION get_daily_user_stats(p_start_timestamp TIMESTAMPTZ)
RETURNS TABLE (
  total_time_seconds NUMERIC,
  unique_questions_solved INT,
  correct_attempts INT,
  total_attempts INT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT
    COALESCE(SUM(time_spent_seconds), 0) as total_time_seconds,
    COUNT(DISTINCT question_id) as unique_questions_solved,
    COUNT(*) FILTER (WHERE is_correct = true) as correct_attempts,
    COUNT(*) as total_attempts
  FROM question_attempts
  WHERE user_id = auth.uid()
  AND created_at >= p_start_timestamp;
END;
$$;

-- Grant execution to authenticated users
GRANT EXECUTE ON FUNCTION get_daily_user_stats(TIMESTAMPTZ) TO authenticated;
GRANT EXECUTE ON FUNCTION get_daily_user_stats(TIMESTAMPTZ) TO service_role;
