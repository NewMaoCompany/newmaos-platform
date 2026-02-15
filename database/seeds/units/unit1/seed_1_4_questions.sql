-- Insert Script for Chapter 1.4 Questions (Estimating Limit Values from Tables)
-- Unit: Both_Limits / 1.4

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.4-P1', '1.4-P2', '1.4-P3', '1.4-P4', '1.4-P5');

-- ============================================================
-- 1.4-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.4-P1', 'Both', 'Both_Limits', '1.4', '1.4', 'MCQ', FALSE,
        2, 180, '{limit_estimation_table,limit_concept}', '{table_trend_misread}', 'text',
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 3} f(x)$?$txt$,
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 3} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "8.94", "type": "text", "explanation": "This is a nearby left-side value, not the best two-sided estimate."},
          {"id": "B", "label": "B", "value": "9", "type": "text", "explanation": "Correct: the trend from both sides approaches 9."},
          {"id": "C", "label": "C", "value": "9.06", "type": "text", "explanation": "This is a nearby right-side value, not the best two-sided estimate."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The table suggests a single approaching value, so the limit exists."}
        ]$txt$,
        'B',
        $txt$Values of $f(x)$ approach 9 as $x$ approaches 3 from both sides, so the best estimate is 9.$txt$,
        '{limit_estimation_table}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_trend_misread' FROM new_question;


-- ============================================================
-- 1.4-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.4-P2', 'Both', 'Both_Limits', '1.4', '1.4', 'MCQ', FALSE,
        2, 180, '{limit_estimation_table,limit_notation}', '{one_sided_from_data}', 'text',
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 0^+} g(x)$?$txt$,
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 0^+} g(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "0 is the x-value approached, not the y-value trend."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Correct: the values approach 2 as $x\\to 0^+$."},
          {"id": "C", "label": "C", "value": "2.1", "type": "text", "explanation": "2.1 is only the value at $x=0.1$, not the limit trend."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "A one-sided limit can exist; the table shows it approaches 2."}
        ]$txt$,
        'B',
        $txt$As $x$ approaches 0 from the right, the values of $g(x)$ approach 2.$txt$,
        '{limit_estimation_table}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'one_sided_from_data' FROM new_question;


-- ============================================================
-- 1.4-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.4-P3', 'Both', 'Both_Limits', '1.4', '1.4', 'MCQ', FALSE,
        3, 240, '{limit_estimation_table,limit_notation}', '{two_sided_requires_match}', 'text',
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 0} h(x)$?$txt$,
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 0} h(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-1$", "type": "text", "explanation": "This matches only the left-side trend."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "This matches only the right-side trend."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "0 is not supported by the table’s left or right trends."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Correct: the left and right behaviors differ, so the limit is DNE."}
        ]$txt$,
        'D',
        $txt$From the table, values approach $-1$ from the left and 1 from the right, so the two-sided limit does not exist.$txt$,
        '{limit_estimation_table}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'two_sided_requires_match' FROM new_question;


-- ============================================================
-- 1.4-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.4-P4', 'Both', 'Both_Limits', '1.4', '1.4', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_estimation_table}', '{infinite_limit_meaning}', 'text',
        $txt$Use the table provided. What is the best description of $\lim_{x\to 2} p(x)$?$txt$,
        $txt$Use the table provided. What is the best description of $\lim_{x\to 2} p(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 2} p(x)=0$", "type": "text", "explanation": "The table values are not approaching 0."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 2} p(x)=10$", "type": "text", "explanation": "10 appears only farther from 2; near 2 the values get much larger."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 2} p(x)=\\infty$", "type": "text", "explanation": "Correct: the trend suggests the function increases without bound near 2."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 2} p(x)$ does not exist because it is infinite", "type": "text", "explanation": "An infinite limit is still a valid limit description on AP."}
        ]$txt$,
        'C',
        $txt$The values grow very large near $x=2$ from both sides, indicating the limit increases without bound, so the limit is $\infty$.$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_table', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinite_limit_meaning' FROM new_question;


-- ============================================================
-- 1.4-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.4-P5', 'Both', 'Both_Limits', '1.4', '1.4', 'MCQ', FALSE,
        2, 180, '{limit_estimation_table,limit_concept}', '{limit_vs_value}', 'text',
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 1} q(x)$?$txt$,
        $txt$Use the table provided. What is the best estimate of $\lim_{x\to 1} q(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-0.01$", "type": "text", "explanation": "This is only one nearby value, not the two-sided trend."},
          {"id": "B", "label": "B", "value": "0", "type": "text", "explanation": "Correct: the values get closer to 0 on both sides."},
          {"id": "C", "label": "C", "value": "0.01", "type": "text", "explanation": "This is only one nearby value, not the two-sided trend."},
          {"id": "D", "label": "D", "value": "1", "type": "text", "explanation": "This is the x-value being approached, not the limit value."}
        ]$txt$,
        'B',
        $txt$As $x$ approaches 1, the values of $q(x)$ approach 0 from both sides, so the limit is 0.$txt$,
        '{limit_estimation_table}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'limit_vs_value' FROM new_question;
