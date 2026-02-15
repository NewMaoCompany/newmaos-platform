-- =====================================================
-- Protect 'completed' status during Review sessions
-- =====================================================

-- 2. RPC: Save session progress (In Progress)
CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id VARCHAR,
    p_data JSONB,
    p_time_spent INTEGER DEFAULT 0,
    p_entity_type VARCHAR DEFAULT 'section',
    p_skip_status_update BOOLEAN DEFAULT FALSE
) RETURNS BOOLEAN AS $$
BEGIN
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
        -- Only set to in_progress if currently NOT completed OR if NOT skipping status update
        status = CASE 
            WHEN p_skip_status_update THEN user_section_progress.status
            WHEN user_section_progress.status = 'completed' THEN 'completed'
            ELSE 'in_progress'
        END,
        data = p_data,
        last_accessed_at = NOW();

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 3. RPC: Complete session (Finished)
CREATE OR REPLACE FUNCTION complete_section_session(
    p_section_id VARCHAR,
    p_score INTEGER,
    p_total_questions INTEGER,
    p_correct_questions INTEGER,
    p_data JSONB,
    p_skip_status_update BOOLEAN DEFAULT FALSE
) RETURNS JSONB AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_topic_id VARCHAR;
    v_course_id VARCHAR;
    v_total_sections INTEGER;
    v_completed_sections INTEGER;
    v_new_course_status VARCHAR;
BEGIN
    -- 1. Update user_section_progress
    INSERT INTO public.user_section_progress (
        user_id,
        section_id,
        status,
        data,
        score,
        total_questions,
        correct_questions,
        last_accessed_at
    ) VALUES (
        v_user_id,
        p_section_id,
        CASE WHEN p_skip_status_update THEN 'in_progress' ELSE 'completed' END,
        p_data,
        p_score,
        p_total_questions,
        p_correct_questions,
        NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = CASE 
            WHEN p_skip_status_update THEN user_section_progress.status 
            ELSE 'completed' 
        END,
        data = p_data,
        -- Only update scores if they are higher OR if NOT skipping status update (master session)
        score = CASE 
            WHEN p_skip_status_update THEN user_section_progress.score 
            ELSE GREATEST(user_section_progress.score, p_score) 
        END,
        total_questions = CASE 
            WHEN p_skip_status_update THEN user_section_progress.total_questions 
            ELSE p_total_questions 
        END,
        correct_questions = CASE 
            WHEN p_skip_status_update THEN user_section_progress.correct_questions 
            ELSE GREATEST(user_section_progress.correct_questions, p_correct_questions) 
        END,
        last_accessed_at = NOW();

    -- Only bubble up and update course stats if NOT skipping status update
    IF NOT p_skip_status_update THEN
        -- Existing bubble logic...
        SELECT topic_id INTO v_topic_id FROM public.sections WHERE id = p_section_id;
        
        IF v_topic_id IS NOT NULL THEN
            IF v_topic_id LIKE 'AB_%' THEN v_course_id := 'AB';
            ELSIF v_topic_id LIKE 'BC_%' THEN v_course_id := 'BC';
            END IF;
        END IF;

        IF v_course_id IS NOT NULL THEN
            INSERT INTO public.course_progress (user_id, course_id, status)
            VALUES (v_user_id, v_course_id, 'In Progress')
            ON CONFLICT (user_id, course_id) DO NOTHING;

            SELECT COUNT(*) INTO v_total_sections FROM public.sections s WHERE s.topic_id LIKE v_course_id || '_%';
            SELECT COUNT(DISTINCT sp.section_id) INTO v_completed_sections FROM public.user_section_progress sp JOIN public.sections s ON s.id = sp.section_id WHERE sp.user_id = v_user_id AND sp.status = 'completed' AND s.topic_id LIKE v_course_id || '_%';
            
            IF v_completed_sections >= v_total_sections AND v_total_sections > 0 THEN v_new_course_status := 'Completed';
            ELSE v_new_course_status := 'In Progress';
            END IF;

            UPDATE public.course_progress SET status = v_new_course_status, updated_at = NOW() WHERE user_id = v_user_id AND course_id = v_course_id;
        END IF;
    END IF;

    -- Update User Profile Stats (Always count problems solved)
    UPDATE public.user_profiles SET problems_solved = problems_solved + p_total_questions, updated_at = NOW() WHERE id = v_user_id;

    RETURN jsonb_build_object(
        'success', true,
        'section_id', p_section_id,
        'status', CASE WHEN p_skip_status_update THEN 'review_saved' ELSE 'completed' END
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
