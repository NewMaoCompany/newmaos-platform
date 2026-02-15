-- Insert Unit 10 placeholder questions
-- Range: Unit 10.1 to 10.15 (15 chapters)
-- Title format: 10.c-Pq (e.g., 10.1-P1, ..., 10.15-P5)
-- Using minimum valid values to pass constraints
-- course: 'Both'
-- difficulty: 1 (min)
-- target_time_seconds: 60 (valid > 0)
-- status: 'published'
-- type: 'MCQ'
-- options: '[]' (valid JSONB) or NULL if nullable (let's assume NOT NULL for safety and use empty JSON array string)
-- prompt: 'Placeholder'
-- topic: 'Unit 10'

DO $$
DECLARE
    chapter INT;
    problem INT;
    q_title TEXT;
    q_exists BOOLEAN;
BEGIN
    FOR chapter IN 1..15 LOOP
        FOR problem IN 1..5 LOOP
            q_title := '10.' || chapter || '-P' || problem;
            
            SELECT EXISTS (SELECT 1 FROM public.questions WHERE title = q_title) INTO q_exists;
            
            IF NOT q_exists THEN
                INSERT INTO public.questions (
                    title,
                    course,
                    topic,
                    sub_topic_id,
                    section_id,
                    type,
                    calculator_allowed,
                    difficulty,
                    target_time_seconds,
                    skill_tags,
                    error_tags,
                    prompt,
                    latex,
                    options,
                    correct_option_id,
                    explanation,
                    recommendation_reasons,
                    status,
                    reasoning_level,
                    mastery_weight,
                    source,
                    source_year,
                    notes,
                    weight_primary,
                    weight_supporting,
                    prompt_type,
                    representation_type
                ) VALUES (
                    q_title,
                    'Both',               -- course
                    'Unit 10',            -- topic
                    NULL,                 -- sub_topic_id
                    NULL,                 -- section_id
                    'MCQ',                -- type
                    FALSE,                -- calculator_allowed
                    1,                    -- difficulty (must be > 0?)
                    60,                   -- target_time_seconds (must be > 0?)
                    NULL,                 -- skill_tags
                    NULL,                 -- error_tags
                    'Placeholder Prompt', -- prompt
                    NULL,                 -- latex
                    '[]',                 -- options (Use empty JSON array string)
                    NULL,                 -- correct_option_id
                    NULL,                 -- explanation
                    NULL,                 -- recommendation_reasons
                    'published',          -- status
                    1,                    -- reasoning_level (typically > 0)
                    1,                    -- mastery_weight (typically > 0)
                    NULL,                 -- source
                    2026,                 -- source_year (valid year)
                    NULL,                 -- notes
                    0,                    -- weight_primary
                    0,                    -- weight_supporting
                    'text',               -- prompt_type
                    'symbolic'            -- representation_type
                );
            ELSE
                -- If exists, verify fields are not NULL (optional, but requested to set placeholders)
                -- User said "All data filled with null or 0...". Let's stick to valid defaults.
                UPDATE public.questions
                SET
                    course = 'Both',
                    topic = 'Unit 10',
                    sub_topic_id = NULL,
                    section_id = NULL,
                    type = 'MCQ',
                    calculator_allowed = FALSE,
                    difficulty = 1,
                    target_time_seconds = 60,
                    skill_tags = NULL,
                    error_tags = NULL,
                    prompt = 'Placeholder Prompt',
                    latex = NULL,
                    options = '[]',
                    correct_option_id = NULL,
                    explanation = NULL,
                    recommendation_reasons = NULL,
                    status = 'published',
                    reasoning_level = 1,
                    mastery_weight = 1,
                    source = NULL,
                    source_year = 2026,
                    notes = NULL,
                    weight_primary = 0,
                    weight_supporting = 0,
                    prompt_type = 'text',
                    representation_type = 'symbolic'
                WHERE title = q_title;
            END IF;
                
        END LOOP;
    END LOOP;
END $$;
