-- =====================================================
-- Add Hierarchy Status Support (Course / Unit / Section)
-- =====================================================

-- 1. Add entity_type column
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'user_section_progress' AND column_name = 'entity_type') THEN
        ALTER TABLE public.user_section_progress 
        ADD COLUMN entity_type VARCHAR(20) DEFAULT 'section' CHECK (entity_type IN ('course', 'unit', 'section'));
    END IF;
END $$;

-- 2. Update save_section_progress to support entity_type
CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id VARCHAR,
    p_data JSONB,
    p_time_spent INTEGER DEFAULT 0,
    p_entity_type VARCHAR DEFAULT 'section'
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO public.user_section_progress (
        user_id, section_id, status, data, last_accessed_at, entity_type
    ) VALUES (
        auth.uid(), p_section_id, 'in_progress', p_data, NOW(), p_entity_type
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'in_progress',
        data = p_data,
        last_accessed_at = NOW(),
        entity_type = p_entity_type; -- Ensure type is set correctly
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Helper: Complete Entity (Generic)
-- This can be used for Course/Unit completion too if logic permits
CREATE OR REPLACE FUNCTION complete_entity_progress(
    p_id VARCHAR,
    p_entity_type VARCHAR
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO public.user_section_progress (
        user_id, section_id, status, entity_type, last_accessed_at
    ) VALUES (
        auth.uid(), p_id, 'completed', p_entity_type, NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'completed',
        last_accessed_at = NOW(),
        entity_type = p_entity_type;
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Get specific section/entity progress (Update to include entity_type)
CREATE OR REPLACE FUNCTION get_section_progress(p_section_id VARCHAR)
RETURNS TABLE (
    section_id VARCHAR,
    status VARCHAR,
    data JSONB,
    score INTEGER,
    correct_questions INTEGER,
    total_questions INTEGER,
    last_accessed_at TIMESTAMPTZ,
    entity_type VARCHAR
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
        usp.last_accessed_at,
        usp.entity_type
    FROM public.user_section_progress usp
    WHERE usp.user_id = auth.uid() AND usp.section_id = p_section_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Complete Section Session (Previously missing from this file, critical for completion)
CREATE OR REPLACE FUNCTION complete_section_session(
    p_section_id VARCHAR,
    p_score INTEGER,
    p_total_questions INTEGER,
    p_correct_questions INTEGER,
    p_data JSONB
) RETURNS BOOLEAN AS $$
DECLARE
    v_entity_type VARCHAR;
BEGIN
    -- Determine entity type based on ID convention if possible, default to 'section'
    -- (Frontend usually knows best, but this RPC signature is legacy fixed)
    v_entity_type := 'section'; 
    
    INSERT INTO public.user_section_progress (
        user_id, section_id, status, score, total_questions, correct_questions, data, last_accessed_at, entity_type
    ) VALUES (
        auth.uid(), p_section_id, 'completed', p_score, p_total_questions, p_correct_questions, p_data, NOW(), v_entity_type
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'completed',
        score = p_score,
        total_questions = p_total_questions,
        correct_questions = p_correct_questions,
        data = p_data,
        last_accessed_at = NOW(),
        entity_type = v_entity_type;
        
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
