-- =====================================================
-- RPC to fetch recent user activities (Global)
-- Used for "Recent Activity" list on Dashboard
-- =====================================================

CREATE OR REPLACE FUNCTION get_recent_activities(p_limit INTEGER DEFAULT 10)
RETURNS TABLE (
    id UUID,
    type VARCHAR,
    title VARCHAR,
    description VARCHAR,
    -- timestamp removed to avoid reserved keyword conflict and since frontend calculates it from created_at
    score INTEGER,
    created_at TIMESTAMPTZ
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_id UUID := auth.uid();
BEGIN
    RETURN QUERY
    SELECT
        ua.id,
        'practice'::VARCHAR as type, -- Currently only have practice, can expand later
        -- Generate a friendly title from section ID (e.g., 'Unit 1: Limits')
        -- Using simple string manipulation for now, can join with sections table if needed for perfect titles
        CONCAT('Practice: ', split_part(ua.section_id, '_', 2))::VARCHAR as title,
        
        -- Description showing score
        CONCAT('Scored ', ua.correct_count, '/', ua.total_questions, ' correct (' || ua.score || '%)')::VARCHAR as description,
        
        -- Timestamp calculation moved to frontend or derived from created_at
        
        ua.score,
        ua.created_at
    FROM user_activities ua
    WHERE ua.user_id = v_user_id
    ORDER BY ua.created_at DESC
    LIMIT p_limit;
END;
$$;

-- Permissions
GRANT EXECUTE ON FUNCTION get_recent_activities(INTEGER) TO authenticated;
GRANT EXECUTE ON FUNCTION get_recent_activities(INTEGER) TO service_role;
