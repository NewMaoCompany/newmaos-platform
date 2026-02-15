-- =====================================================
-- FIX: Refine "Problems Solved" Metric Logic
-- =====================================================

-- This update ensures that 'unique_questions_solved' only counts questions 
-- where the MOST RECENT attempt within the time range is correct.
-- This accurately reflects "currently solved" state for today.

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
  WITH latest_per_question AS (
    SELECT DISTINCT ON (question_id) 
      is_correct
    FROM question_attempts
    WHERE user_id = auth.uid()
    AND created_at >= p_start_timestamp
    ORDER BY question_id, created_at DESC
  )
  SELECT
    COALESCE((
      SELECT SUM(time_spent_seconds) 
      FROM question_attempts 
      WHERE user_id = auth.uid() AND created_at >= p_start_timestamp
    ), 0)::NUMERIC as total_time_seconds,
    COALESCE((
      SELECT COUNT(*)::INT 
      FROM latest_per_question 
      WHERE is_correct = true
    ), 0) as unique_questions_solved,
    COALESCE((
      SELECT COUNT(*)::INT 
      FROM question_attempts 
      WHERE user_id = auth.uid() AND created_at >= p_start_timestamp AND is_correct = true
    ), 0) as correct_attempts,
    COALESCE((
      SELECT COUNT(*)::INT 
      FROM question_attempts 
      WHERE user_id = auth.uid() AND created_at >= p_start_timestamp
    ), 0) as total_attempts;
END;
$$;

-- Ensure permissions
GRANT EXECUTE ON FUNCTION get_daily_user_stats(TIMESTAMPTZ) TO authenticated;
GRANT EXECUTE ON FUNCTION get_daily_user_stats(TIMESTAMPTZ) TO service_role;
