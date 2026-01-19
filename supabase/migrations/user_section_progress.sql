-- =====================================================
-- User Section Progress & Session Persistence
-- Run this in Supabase SQL Editor
-- =====================================================

-- 1. Create table for tracking section progress
CREATE TABLE IF NOT EXISTS public.user_section_progress (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    section_id VARCHAR(50) NOT NULL, -- Corresponds to sections.id
    status VARCHAR(20) CHECK (status IN ('in_progress', 'completed')),
    data JSONB DEFAULT '{}'::jsonb, -- Store userAnswers, questionResults, etc.
    score INTEGER DEFAULT 0,
    total_questions INTEGER DEFAULT 0,
    correct_questions INTEGER DEFAULT 0,
    last_accessed_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, section_id)
);

-- Enable RLS
ALTER TABLE public.user_section_progress ENABLE ROW LEVEL SECURITY;

-- RLS: Users can only access their own progress
CREATE POLICY "Users can view own section progress" ON public.user_section_progress
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can manage own section progress" ON public.user_section_progress
    FOR ALL USING (auth.uid() = user_id);


-- 2. RPC: Save session progress (In Progress)
CREATE OR REPLACE FUNCTION save_section_progress(
    p_section_id VARCHAR,
    p_data JSONB,
    p_time_spent INTEGER DEFAULT 0
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
        status = 'in_progress', -- Ensure status is in_progress if re-saving
        data = p_data,
        last_accessed_at = NOW();

    -- Optional: Update study hours in usage profile if needed, 
    -- but usually better to do on completion or via separate heartbeat
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 3. RPC: Complete session (Finished)
CREATE OR REPLACE FUNCTION complete_section_session(
    p_section_id VARCHAR,
    p_score INTEGER,
    p_total_questions INTEGER,
    p_correct_questions INTEGER,
    p_data JSONB
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
        'completed',
        p_data,
        p_score,
        p_total_questions,
        p_correct_questions,
        NOW()
    )
    ON CONFLICT (user_id, section_id) DO UPDATE SET
        status = 'completed',
        data = p_data,
        score = GREATEST(user_section_progress.score, p_score), -- Keep highest score
        total_questions = p_total_questions,
        correct_questions = GREATEST(user_section_progress.correct_questions, p_correct_questions),
        last_accessed_at = NOW();

    -- 2. Get Topic and Course info for this section
    -- Assuming we can derive it or pass it. 
    -- For now, let's fetch from sections table if available, else try to parse.
    -- We'll assume the sections table from the schema exists.
    SELECT topic_id INTO v_topic_id FROM public.sections WHERE id = p_section_id;
    
    -- If sections table not populated or section not found, fallback logic could go here.
    -- Assuming standard format like "AB_Limits" -> Course "AB"
    IF v_topic_id IS NOT NULL THEN
        IF v_topic_id LIKE 'AB_%' THEN v_course_id := 'AB';
        ELSIF v_topic_id LIKE 'BC_%' THEN v_course_id := 'BC';
        END IF;
    END IF;

    -- 3. Update Course Progress (if course identified)
    IF v_course_id IS NOT NULL THEN
        -- Verify course_progress record exists
        INSERT INTO public.course_progress (user_id, course_id, status)
        VALUES (v_user_id, v_course_id, 'In Progress')
        ON CONFLICT (user_id, course_id) DO NOTHING;

        -- Calculate progress
        -- Count total sections for this course
        SELECT COUNT(*) INTO v_total_sections
        FROM public.sections s
        WHERE s.topic_id LIKE v_course_id || '_%';

        -- Count user completed sections
        SELECT COUNT(DISTINCT sp.section_id) INTO v_completed_sections
        FROM public.user_section_progress sp
        JOIN public.sections s ON s.id = sp.section_id
        WHERE sp.user_id = v_user_id 
          AND sp.status = 'completed'
          AND s.topic_id LIKE v_course_id || '_%';
        
        -- Determine status
        IF v_completed_sections >= v_total_sections AND v_total_sections > 0 THEN
            v_new_course_status := 'Completed';
        ELSE
            v_new_course_status := 'In Progress';
        END IF;

        -- Update course_progress
        UPDATE public.course_progress
        SET 
            status = v_new_course_status,
            updated_at = NOW()
        WHERE user_id = v_user_id AND course_id = v_course_id;
    END IF;

    -- 4. Update User Profile Stats
    UPDATE public.user_profiles
    SET 
        problems_solved = problems_solved + p_total_questions, -- Simplification: counting all attempted in session
        updated_at = NOW()
    WHERE id = v_user_id;

    RETURN jsonb_build_object(
        'success', true,
        'section_id', p_section_id,
        'status', 'completed'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 4. RPC: Get section progress
CREATE OR REPLACE FUNCTION get_section_progress(p_section_id VARCHAR)
RETURNS TABLE (
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
        usp.status,
        usp.data,
        usp.score,
        usp.correct_questions,
        usp.total_questions,
        usp.last_accessed_at
    FROM public.user_section_progress usp
    WHERE usp.user_id = auth.uid() AND usp.section_id = p_section_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. RPC: Get topic section progress (Bulk)
CREATE OR REPLACE FUNCTION get_topic_section_progress(p_topic_id VARCHAR)
RETURNS TABLE (
    section_id VARCHAR,
    status VARCHAR,
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
        usp.score,
        usp.correct_questions,
        usp.total_questions,
        usp.last_accessed_at
    FROM public.user_section_progress usp
    -- Join with sections if we wanted to enforce topic, but since section_ids are unique enough or client filters
    -- For performance, it's better to just return all the user has for this topic if the client knows what it wants.
    -- Or we can assume section_id naming convention or join sections table.
    -- Let's try to join sections table for safety.
    JOIN public.sections s ON s.id = usp.section_id
    WHERE usp.user_id = auth.uid() AND s.topic_id = p_topic_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
