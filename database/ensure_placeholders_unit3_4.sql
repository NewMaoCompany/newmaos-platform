-- Ensure Placeholders for Unit 3 and Unit 4
-- This script inserts placeholder rows for any missing questions in Unit 3 and Unit 4.
-- Run this BEFORE running the Update scripts to ensure the rows exist.
-- REVISED: Removed ON CONFLICT (title) because the unique constraint might not exist.
-- Uses explicit EXISTS check instead.

DO $block$
DECLARE
    titles text[] := ARRAY['3.1-P1', '3.1-P2', '3.1-P3', '3.1-P4', '3.1-P5', '3.2-P1', '3.2-P2', '3.2-P3', '3.2-P4', '3.2-P5', '3.3-P1', '3.3-P2', '3.3-P3', '3.3-P4', '3.3-P5', '3.4-P1', '3.4-P2', '3.4-P3', '3.4-P4', '3.4-P5', '3.5-P1', '3.5-P2', '3.5-P3', '3.5-P4', '3.5-P5', '3.6-P1', '3.6-P2', '3.6-P3', '3.6-P4', '3.6-P5', '3.0-UT-Q1', '3.0-UT-Q2', '3.0-UT-Q3', '3.0-UT-Q4', '3.0-UT-Q5', '3.0-UT-Q6', '3.0-UT-Q7', '3.0-UT-Q8', '3.0-UT-Q9', '3.0-UT-Q10', '3.0-UT-Q11', '3.0-UT-Q12', '3.0-UT-Q13', '3.0-UT-Q14', '3.0-UT-Q15', '3.0-UT-Q16', '3.0-UT-Q17', '3.0-UT-Q18', '3.0-UT-Q19', '3.0-UT-Q20', '4.1-P1', '4.1-P2', '4.1-P3', '4.1-P4', '4.1-P5', '4.2-P1', '4.2-P2', '4.2-P3', '4.2-P4', '4.2-P5', '4.3-P1', '4.3-P2', '4.3-P3', '4.3-P4', '4.3-P5', '4.4-P1', '4.4-P2', '4.4-P3', '4.4-P4', '4.4-P5', '4.5-P1', '4.5-P2', '4.5-P3', '4.5-P4', '4.5-P5', '4.6-P1', '4.6-P2', '4.6-P3', '4.6-P4', '4.6-P5', '4.7-P1', '4.7-P2', '4.7-P3', '4.7-P4', '4.7-P5', '4.0-UT-Q1', '4.0-UT-Q2', '4.0-UT-Q3', '4.0-UT-Q4', '4.0-UT-Q5', '4.0-UT-Q6', '4.0-UT-Q7', '4.0-UT-Q8', '4.0-UT-Q9', '4.0-UT-Q10', '4.0-UT-Q11', '4.0-UT-Q12', '4.0-UT-Q13', '4.0-UT-Q14', '4.0-UT-Q15', '4.0-UT-Q16', '4.0-UT-Q17', '4.0-UT-Q18', '4.0-UT-Q19', '4.0-UT-Q20'];
    t text;
    sub_id text;
    sec_id text;
BEGIN
    FOREACH t IN ARRAY titles
    LOOP
        -- Determine sub_topic_id
        IF t LIKE '%UT%' THEN
            sub_id := 'unit_test';
            sec_id := 'unit_test';
        ELSE
            -- Extract generic ID like '3.1'
            sub_id := substring(t from '^([0-9]+\.[0-9]+)');
            sec_id := sub_id;
        END IF;

        -- Check if row exists. INSERT only if it does NOT exist.
        IF NOT EXISTS (SELECT 1 FROM public.questions WHERE title = t) THEN
            INSERT INTO public.questions (
                title,
                course,
                topic,
                sub_topic_id,
                section_id,
                type,
                difficulty,
                prompt,
                options,
                status,
                reasoning_level,
                mastery_weight,
                source_year,
                prompt_type,
                representation_type,
                calculator_allowed,
                target_time_seconds,
                skill_tags,
                error_tags,
                recommendation_reasons,
                notes,
                latex,
                explanation,
                topic_id,
                version
            ) VALUES (
                t,
                'Both',
                'Both_Applications',
                sub_id,
                sec_id,
                'MCQ',
                1,
                'Placeholder',
                '[]'::jsonb,
                'draft',
                1,
                1.0,
                2026,
                'text',
                'symbolic',
                FALSE,
                60,
                ARRAY[]::text[],
                ARRAY[]::text[],
                ARRAY[]::text[],
                '',
                '',
                '',
                'Both_Applications',
                1
            );
        END IF;

    END LOOP;
END $block$;
