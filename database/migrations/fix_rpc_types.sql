-- Fix RPC Return Type Mismatch

DROP FUNCTION IF EXISTS get_unit_scores(TEXT[]);

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
    CAST(u_id AS VARCHAR) as unit_id,
    COALESCE(CAST((get_unit_progress_stats(auth.uid(), u_id)->>'progress_percentage') AS NUMERIC), 0.0) as score,
    CAST(0 AS INTEGER) as correct_questions,
    CAST(0 AS INTEGER) as total_questions,
    CAST('calculated' AS VARCHAR) as status
  FROM unnest(p_unit_ids) as u_id;
END;
$$;
