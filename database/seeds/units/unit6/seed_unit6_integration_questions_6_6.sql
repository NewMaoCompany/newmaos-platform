-- Insert Script for 6.6 (Applying Properties of Definite Integrals)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.6-P1', 'U6.6-P2', 'U6.6-P3', 'U6.6-P4', 'U6.6-P5'
);

-- ============================================================
-- U6.6-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P1', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        2, 120, '{integral_properties_basic}', '{integral_additivity_error}', 'text',
        $txt$Given $\int_0^2 f(x)\,dx=5$ and $\int_2^6 f(x)\,dx=-1$, what is $\int_0^6 f(x)\,dx$?$txt$,
        $txt$Given $\int_0^2 f(x)\,dx=5$ and $\int_2^6 f(x)\,dx=-1$, what is $\int_0^6 f(x)\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "Correct: add the two pieces."},
          {"id": "B", "label": "B", "value": "$6$", "type": "text", "explanation": "Would come from subtracting the negative incorrectly."},
          {"id": "C", "label": "C", "value": "$-4$", "type": "text", "explanation": "Wrong sign; does not match 5 + (−1)."},
          {"id": "D", "label": "D", "value": "$-6$", "type": "text", "explanation": "Wrong magnitude and sign."}
        ]$txt$,
        'A',
        $txt$Use additivity: $\int_0^6 f=\int_0^2 f+\int_2^6 f=5+(-1)=4$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_additivity_error' FROM new_question;

-- ============================================================
-- U6.6-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P2', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        2, 120, '{integral_properties_basic}', '{integral_bounds_reversal_error}', 'text',
        $txt$If $\int_0^6 f(x)\,dx=4$, what is $\int_6^0 f(x)\,dx$?$txt$,
        $txt$If $\int_0^6 f(x)\,dx=4$, what is $\int_6^0 f(x)\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "Does not account for reversing bounds."},
          {"id": "B", "label": "B", "value": "$-4$", "type": "text", "explanation": "Correct: reversing bounds negates the integral."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{4}$", "type": "text", "explanation": "No rule gives a reciprocal here."},
          {"id": "D", "label": "D", "value": "$0$", "type": "text", "explanation": "Would only be true if the original integral were 0."}
        ]$txt$,
        'B',
        $txt$Reversing bounds changes the sign: $\int_6^0 f= -\int_0^6 f=-4$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_bounds_reversal_error' FROM new_question;

-- ============================================================
-- U6.6-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P3', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        3, 150, '{integral_properties_basic}', '{integral_additivity_error}', 'text',
        $txt$Use the table of given integral values. What is $\int_0^6 \left(2f(x)-g(x)\right)\,dx$?$txt$,
        $txt$Use the table of given integral values. What is $\int_0^6 (2f(x)-g(x))\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "Correct: apply constant multiple and subtraction rules."},
          {"id": "B", "label": "B", "value": "$8$", "type": "text", "explanation": "Would happen if you forgot to subtract the $\\int g$ term."},
          {"id": "C", "label": "C", "value": "$0$", "type": "text", "explanation": "Would happen if you incorrectly assumed the two terms cancel."},
          {"id": "D", "label": "D", "value": "$-4$", "type": "text", "explanation": "Wrong sign; does not match 8−4."}
        ]$txt$,
        'A',
        $txt$Linearity: $\int_0^6(2f-g)=2\int_0^6 f-\int_0^6 g=2(4)-4=4$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Table required (U6_6.6-P3_table.png).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_additivity_error' FROM new_question;

-- ============================================================
-- U6.6-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P4', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        2, 120, '{integral_properties_basic}', '{integral_additivity_error}', 'text',
        $txt$If $\int_a^b f(x)\,dx=3$ and $\int_a^b g(x)\,dx=-2$, what is $\int_a^b (f(x)+g(x))\,dx$?$txt$,
        $txt$If $\int_a^b f(x)\,dx=3$ and $\int_a^b g(x)\,dx=-2$, what is $\int_a^b (f(x)+g(x))\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-5$", "type": "text", "explanation": "Would come from multiplying instead of adding."},
          {"id": "B", "label": "B", "value": "$-1$", "type": "text", "explanation": "Would come from subtracting $-2$ incorrectly."},
          {"id": "C", "label": "C", "value": "$1$", "type": "text", "explanation": "Correct: 3 + (−2) = 1."},
          {"id": "D", "label": "D", "value": "$5$", "type": "text", "explanation": "Would come from adding absolute values."}
        ]$txt$,
        'C',
        $txt$Additivity: $\int (f+g)=\int f+\int g=3+(-2)=1$.$txt$,
        '{integral_properties_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_properties_basic', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'integral_additivity_error' FROM new_question;

-- ============================================================
-- U6.6-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.6-P5', 'Both', 'ABBC_Integration', '6.6', '6.6', 'MCQ', FALSE,
        3, 150, '{integral_symmetry_even_odd}', '{symmetry_even_odd_misuse}', 'text',
        $txt$Suppose $f$ is an odd function. What must be true about $\int_{-2}^{2} f(x)\,dx$?$txt$,
        $txt$Suppose $f$ is an odd function. What must be true about $\int_{-2}^{2} f(x)\,dx$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "It equals $0$.", "type": "text", "explanation": "Correct: symmetry cancellation for odd functions."},
          {"id": "B", "label": "B", "value": "It is positive.", "type": "text", "explanation": "Not guaranteed; cancellation can produce 0."},
          {"id": "C", "label": "C", "value": "It is negative.", "type": "text", "explanation": "Not guaranteed; cancellation can produce 0."},
          {"id": "D", "label": "D", "value": "It equals $2\\int_0^2 f(x)\\,dx$.", "type": "text", "explanation": "That relationship holds for even functions, not odd functions."}
        ]$txt$,
        'A',
        $txt$For an odd function, areas on symmetric intervals cancel, so the integral over $[-2,2]$ is 0.$txt$,
        '{integral_symmetry_even_odd}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_symmetry_even_odd', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'symmetry_even_odd_misuse' FROM new_question;
