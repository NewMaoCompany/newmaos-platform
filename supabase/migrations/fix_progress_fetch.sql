-- RPC to fetch ALL user section progress (bypassing potential RLS complexity or filter issues)
CREATE OR REPLACE FUNCTION get_all_user_progress()
RETURNS TABLE (
    section_id VARCHAR,
    status VARCHAR,
    data JSONB,
    score INTEGER,
    correct_questions INTEGER,
    total_questions INTEGER,
    last_accessed_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        usp.section_id,
        usp.status,
        usp.data,
        usp.score,
        usp.correct_questions,
        usp.total_questions,
        usp.last_accessed_at
    FROM public.user_section_progress usp
    WHERE usp.user_id = auth.uid();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
