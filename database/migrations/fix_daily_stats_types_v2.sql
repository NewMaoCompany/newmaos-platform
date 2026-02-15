-- =====================================================
-- FIX: Daily Stats RPC Type Mismatch and Logic
-- =====================================================

-- This migration enforces explicit type casting to match the RETURNS TABLE signature.
-- It also restores the "latest per question" logic for accurate daily solving counts.

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
    ), 0)::INT as unique_questions_solved,
    
    COALESCE((
      SELECT COUNT(*)::INT 
      FROM question_attempts 
      WHERE user_id = auth.uid() AND created_at >= p_start_timestamp AND is_correct = true
    ), 0)::INT as correct_attempts,
    
    COALESCE((
      SELECT COUNT(*)::INT 
      FROM question_attempts 
      WHERE user_id = auth.uid() AND created_at >= p_start_timestamp
    ), 0)::INT as total_attempts;
END;
$$;

GRANT EXECUTE ON FUNCTION get_daily_user_stats(TIMESTAMPTZ) TO authenticated;
GRANT EXECUTE ON FUNCTION get_daily_user_stats(TIMESTAMPTZ) TO service_role;
