-- Insert Script for 6.1 (Accumulation of Change)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.1-P1', 'U6.1-P2', 'U6.1-P3', 'U6.1-P4', 'U6.1-P5'
);

-- ============================================================
-- U6.1-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.1-P1', 'Both', 'ABBC_Integration', '6.1', '6.1', 'MCQ', FALSE,
        2, 90, '{accumulation_concept}', '{net_vs_total_change_confusion}', 'text',
        $txt$A tank’s water level changes according to a rate r(t) that is sometimes positive and sometimes negative. Which statement is always true?

I. Net change over a time interval equals (final amount) − (initial amount).
II. Total change over a time interval ignores whether the rate is positive or negative.
III. If the net change is 0, then the total change must be 0.$txt$,
        $txt$A tank’s water level changes according to a rate r(t) that is sometimes positive and sometimes negative. Which statement is always true?

I. Net change over a time interval equals (final amount) − (initial amount).
II. Total change over a time interval ignores whether the rate is positive or negative.
III. If the net change is 0, then the total change must be 0.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "I only", "type": "text", "explanation": "Misses that II is also always true for total change."},
          {"id": "B", "label": "B", "value": "I and II only", "type": "text", "explanation": "Correct: I and II are always true; III is not."},
          {"id": "C", "label": "C", "value": "II and III only", "type": "text", "explanation": "III is not always true; net 0 does not force total 0."},
          {"id": "D", "label": "D", "value": "I, II, and III", "type": "text", "explanation": "III fails when increases and decreases cancel in net change."}
        ]$txt$,
        'B',
        $txt$I is true by definition of net change. II is true because total change treats decreases as positive contributions (it measures total amount of change). III is false: net change can be 0 even if the quantity went up and then down.$txt$,
        '{accumulation_concept}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Supportive skill: none (0).', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_concept', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'net_vs_total_change_confusion' FROM new_question;

-- ============================================================
-- U6.1-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.1-P2', 'Both', 'ABBC_Integration', '6.1', '6.1', 'MCQ', FALSE,
        3, 150, '{area_under_curve_interpretation,accumulation_concept}', '{area_sign_misread}', 'text',
        $txt$Refer to Figure U6 6.1-P2. The graph shows the rate r(t) (liters/hour) at which water is flowing into a tank (positive means in, negative means out). What is the net change in the amount of water in the tank from t = 0 to t = 6 hours?$txt$,
        $txt$Refer to Figure U6 6.1-P2. The graph shows the rate r(t) (liters/hour) at which water is flowing into a tank (positive means in, negative means out). What is the net change in the amount of water in the tank from t = 0 to t = 6 hours?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "8 liters", "type": "text", "explanation": "Correct: net change is signed area, giving 8 liters."},
          {"id": "B", "label": "B", "value": "12 liters", "type": "text", "explanation": "This counts only the positive area and ignores the negative part."},
          {"id": "C", "label": "C", "value": "4 liters", "type": "text", "explanation": "This subtracts too much or miscomputes one of the regions."},
          {"id": "D", "label": "D", "value": "-4 liters", "type": "text", "explanation": "This treats the overall change as negative despite larger positive area."}
        ]$txt$,
        'A',
        $txt$Net change equals the signed area under r(t). The positive area from 0 to 4 hours is 12 liters, and the negative area from 4 to 6 hours is 4 liters, so the net change is 12 − 4 = 8 liters.$txt$,
        '{area_under_curve_interpretation}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Graph figure required.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'area_under_curve_interpretation', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'accumulation_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'area_sign_misread' FROM new_question;

-- ============================================================
-- U6.1-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.1-P3', 'Both', 'ABBC_Integration', '6.1', '6.1', 'MCQ', FALSE,
        2, 90, '{units_and_context_integrals,area_under_curve_interpretation}', '{units_not_interpreted}', 'text',
        $txt$A car’s velocity v(t) is measured in miles per hour, and time t is measured in hours. Which best describes the units of the net change found by accumulating velocity over a time interval?$txt$,
        $txt$A car’s velocity v(t) is measured in miles per hour, and time t is measured in hours. Which best describes the units of the net change found by accumulating velocity over a time interval?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "miles per hour", "type": "text", "explanation": "That is the unit of velocity, not accumulated change."},
          {"id": "B", "label": "B", "value": "miles", "type": "text", "explanation": "Correct: (miles/hour) × (hours) = miles."},
          {"id": "C", "label": "C", "value": "hours", "type": "text", "explanation": "Time is the input unit, not the accumulated output unit."},
          {"id": "D", "label": "D", "value": "miles per hour squared", "type": "text", "explanation": "That would correspond to accumulating acceleration-like units, not velocity."}
        ]$txt$,
        'B',
        $txt$Accumulating velocity (miles/hour) over time (hours) produces miles, which represents displacement (net change in position).$txt$,
        '{units_and_context_integrals}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'units_and_context_integrals', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'area_under_curve_interpretation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'units_not_interpreted' FROM new_question;

-- ============================================================
-- U6.1-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.1-P4', 'Both', 'ABBC_Integration', '6.1', '6.1', 'MCQ', FALSE,
        3, 180, '{riemann_sum_from_table,accumulation_concept}', '{table_interval_misuse}', 'text',
        $txt$Refer to Table U6 6.1-P4. The table gives values of a rate r(t) in meters per minute at equally spaced times t (in minutes). Use the trapezoidal rule on each 1-minute subinterval to approximate the net change from t = 0 to t = 5 minutes.$txt$,
        $txt$Refer to Table U6 6.1-P4. The table gives values of a rate r(t) in meters per minute at equally spaced times t (in minutes). Use the trapezoidal rule on each 1-minute subinterval to approximate the net change from t = 0 to t = 5 minutes.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "7 meters", "type": "text", "explanation": "Correct: trapezoids over five 1-minute intervals sum to 7 meters."},
          {"id": "B", "label": "B", "value": "7.5 meters", "type": "text", "explanation": "This often comes from treating all contributions as positive or mis-adding one trapezoid."},
          {"id": "C", "label": "C", "value": "6.5 meters", "type": "text", "explanation": "This typically comes from missing an interval or using the wrong widths."},
          {"id": "D", "label": "D", "value": "8 meters", "type": "text", "explanation": "This commonly comes from using rectangles instead of trapezoids."}
        ]$txt$,
        'A',
        $txt$Apply trapezoids with width 1 minute: add (r_i + r_{i+1})/2 for i = 0 to 4. The sum is 7 meters (net change).$txt$,
        '{riemann_sum_from_table}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Table required.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'riemann_sum_from_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'accumulation_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_interval_misuse' FROM new_question;

-- ============================================================
-- U6.1-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.1-P5', 'Both', 'ABBC_Integration', '6.1', '6.1', 'MCQ', FALSE,
        2, 120, '{accumulation_concept,area_under_curve_interpretation}', '{net_vs_total_change_confusion}', 'text',
        $txt$Over a time interval, the signed area above the t-axis under a rate graph is 10 units and the signed area below the t-axis is 4 units (meaning 4 units of negative area). Which is correct?

A. Net change is 6 units, total change is 14 units.
B. Net change is 14 units, total change is 6 units.
C. Net change is 10 units, total change is 4 units.
D. Net change is 0 units, total change is 14 units.$txt$,
        $txt$Over a time interval, the signed area above the t-axis under a rate graph is 10 units and the signed area below the t-axis is 4 units (meaning 4 units of negative area). Which is correct?

A. Net change is 6 units, total change is 14 units.
B. Net change is 14 units, total change is 6 units.
C. Net change is 10 units, total change is 4 units.
D. Net change is 0 units, total change is 14 units.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "A", "type": "text", "explanation": "Correct: net subtracts, total adds magnitudes."},
          {"id": "B", "label": "B", "value": "B", "type": "text", "explanation": "Swaps net and total ideas."},
          {"id": "C", "label": "C", "value": "C", "type": "text", "explanation": "Treats the two regions as separate outputs rather than combining them appropriately."},
          {"id": "D", "label": "D", "value": "D", "type": "text", "explanation": "Net would be 0 only if the positive and negative magnitudes matched."}
        ]$txt$,
        'A',
        $txt$Net change uses signed area: 10 − 4 = 6. Total change adds magnitudes: 10 + 4 = 14.$txt$,
        '{accumulation_concept}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_concept', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'area_under_curve_interpretation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'net_vs_total_change_confusion' FROM new_question;
