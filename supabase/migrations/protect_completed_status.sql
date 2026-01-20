CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id VARCHAR,
    p_data JSONB,
    p_time_spent INTEGER DEFAULT 0,
    p_entity_type VARCHAR DEFAULT 'section'
) RETURNS BOOLEAN AS $$
DECLARE
    v_current_status VARCHAR;
BEGIN
    -- Check current status
    SELECT status INTO v_current_status
    FROM public.user_section_progress
    WHERE user_id = auth.uid() AND section_id = p_section_id;

    -- If already completed, DO NOT overwrite status with 'in_progress'
    -- helping prevent race conditions where auto-save runs after completion
    IF v_current_status = 'completed' THEN
        UPDATE public.user_section_progress
        SET 
            data = p_data, -- Still allow updating data (e.g. user answers)
            last_accessed_at = NOW()
        WHERE user_id = auth.uid() AND section_id = p_section_id;
    ELSE
        INSERT INTO public.user_section_progress (
            user_id,
            section_id,
            status,
            data,
            last_accessed_at
        ) VALUES (
            auth.uid(),
            p_section_id,
            'in_progress',
            p_data,
            NOW()
        )
        ON CONFLICT (user_id, section_id) DO UPDATE SET
            status = 'in_progress',
            data = p_data,
            last_accessed_at = NOW();
    END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
