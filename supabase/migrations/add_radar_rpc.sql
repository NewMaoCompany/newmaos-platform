-- =====================================================
-- RPC to fetch scores for multiple units at once
-- Used for Radar Chart on Dashboard
-- =====================================================

CREATE OR REPLACE FUNCTION get_unit_scores(p_unit_ids TEXT[])
RETURNS TABLE (
  unit_id VARCHAR,
  score NUMERIC,
  correct_questions INTEGER,
  total_questions INTEGER,
  status VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT
    section_id as unit_id,
    -- If score is null, calculate from questions if possible, else 0
    COALESCE(usp.score, 0) as score,
    COALESCE(usp.correct_questions, 0) as correct_questions,
    COALESCE(usp.total_questions, 0) as total_questions,
    usp.status
  FROM user_section_progress usp
  WHERE usp.user_id = auth.uid()
  AND usp.section_id = ANY(p_unit_ids);
END;
$$;

-- Permissions
GRANT EXECUTE ON FUNCTION get_unit_scores(TEXT[]) TO authenticated;
GRANT EXECUTE ON FUNCTION get_unit_scores(TEXT[]) TO service_role;
