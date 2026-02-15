-- Insert Script for Unit 3.3 Questions (Inverse Functions)
-- Unit: Unit3_Composite_Implicit_Inverse / 3.3

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U3.3-P1', 'U3.3-P2', 'U3.3-P3', 'U3.3-P4', 'U3.3-P5');

-- ============================================================
-- U3.3-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.3-P1', 'Both', 'ABBC_Composite', '3.3', '3.3', 'MCQ', FALSE,
        3, 120, '{inverse_function_derivative}', '{inverse_derivative_reciprocal_confusion}', 'text',
        $txt$If $f(2)=5$ and $f'(2)=3$, what is $(f^{-1})'(5)$?$txt$,
        $txt$If $f(2)=5$ and $f'(2)=3$, what is $(f^{-1})'(5)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$3$", "type": "text", "explanation": "This incorrectly uses $f'(2)$ instead of taking its reciprocal."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{3}$", "type": "text", "explanation": "Correct: $(f^{-1})'(5)=1/f'(2)=1/3$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{5}$", "type": "text", "explanation": "This incorrectly uses the output value 5 in the reciprocal step."},
          {"id": "D", "label": "D", "value": "$\\frac{5}{3}$", "type": "text", "explanation": "This mixes the output and derivative values incorrectly."}
        ]$txt$,
        'B',
        $txt$Use the inverse derivative relationship: the derivative of the inverse at 5 is the reciprocal of the original derivative at the corresponding input value 2.$txt$,
        '{inverse_function_derivative}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_function_derivative', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_derivative_reciprocal_confusion' FROM new_question;

-- ============================================================
-- U3.3-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at, representation_type
    ) VALUES (
        'U3.3-P2', 'Both', 'ABBC_Composite', '3.3', '3.3', 'MCQ', FALSE,
        4, 180, '{inverse_from_table_graph}', '{inverse_table_lookup_error}', 'text',
        $txt$The table below gives values of $f$ and $f'$. What is $(f^{-1})'(5)$?$txt$,
        $txt$The table below gives values of $f$ and $f'$. What is $(f^{-1})'(5)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$4$", "type": "text", "explanation": "This uses $f'(2)$ directly instead of taking the reciprocal."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{4}$", "type": "text", "explanation": "Correct: since $f(2)=5$, we use $(f^{-1})'(5)=1/f'(2)=1/4$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{5}$", "type": "text", "explanation": "This incorrectly uses the output 5 as if it were the derivative value."},
          {"id": "D", "label": "D", "value": "$\\frac{5}{4}$", "type": "text", "explanation": "This incorrectly mixes the output with the derivative."}
        ]$txt$,
        'B',
        $txt$Find the input value where $f(x)=5$ from the table, then take the reciprocal of $f'(x)$ at that input.$txt$,
        '{inverse_from_table_graph}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Uses a provided table image.', 0.8, 0.2, NOW(), NOW(), 'table'
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_from_table_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'inverse_function_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_table_lookup_error' FROM new_question;

-- ============================================================
-- U3.3-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.3-P3', 'Both', 'ABBC_Composite', '3.3', '3.3', 'MCQ', FALSE,
        3, 120, '{inverse_function_derivative}', '{inverse_derivative_reciprocal_confusion}', 'text',
        $txt$If $f(1)=4$ and $f'(1)=-2$, what is $(f^{-1})'(4)$?$txt$,
        $txt$If $f(1)=4$ and $f'(1)=-2$, what is $(f^{-1})'(4)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-2$", "type": "text", "explanation": "This uses $f'(1)$ instead of taking its reciprocal."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{2}$", "type": "text", "explanation": "This ignores the negative sign from $f'(1)=-2$."},
          {"id": "C", "label": "C", "value": "$-\\frac{1}{2}$", "type": "text", "explanation": "Correct: $(f^{-1})'(4)=1/f'(1)=-1/2$."},
          {"id": "D", "label": "D", "value": "$2$", "type": "text", "explanation": "This is the opposite sign and wrong magnitude."}
        ]$txt$,
        'C',
        $txt$Use the reciprocal rule at the corresponding input: since $f(1)=4$, evaluate the reciprocal of $f'(1)$.$txt$,
        '{inverse_function_derivative}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_function_derivative', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_derivative_reciprocal_confusion' FROM new_question;

-- ============================================================
-- U3.3-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at, representation_type
    ) VALUES (
        'U3.3-P4', 'Both', 'ABBC_Composite', '3.3', '3.3', 'MCQ', FALSE,
        4, 180, '{inverse_from_table_graph}', '{inverse_derivative_wrong_input}', 'text',
        $txt$The graph of $f$ is shown. The tangent line at $x=3$ is drawn. What is $(f^{-1})'(1)$?$txt$,
        $txt$The graph of $f$ is shown. The tangent line at $x=3$ is drawn. What is $(f^{-1})'(1)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$2$", "type": "text", "explanation": "This uses the tangent slope directly instead of taking the reciprocal."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{2}$", "type": "text", "explanation": "Correct: the tangent slope at $x=3$ is $2$, so the inverse slope at the corresponding output is $1/2$."},
          {"id": "C", "label": "C", "value": "$-2$", "type": "text", "explanation": "This incorrectly changes the sign of the slope."},
          {"id": "D", "label": "D", "value": "$-\\frac{1}{2}$", "type": "text", "explanation": "This uses the reciprocal but incorrectly changes the sign."}
        ]$txt$,
        'B',
        $txt$Use the fact that $(f^{-1})'(y)=1/f'(x)$ where $f(x)=y$. The tangent slope at $x=3$ gives $f'(3)$.$txt$,
        '{inverse_from_table_graph}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Uses a provided graph image with tangent line.', 0.8, 0.2, NOW(), NOW(), 'graph'
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_from_table_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'inverse_function_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_derivative_wrong_input' FROM new_question;

-- ============================================================
-- U3.3-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.3-P5', 'Both', 'ABBC_Composite', '3.3', '3.3', 'MCQ', FALSE,
        5, 210, '{inverse_function_derivative}', '{inverse_derivative_wrong_input}', 'text',
        $txt$Let $f$ be differentiable and invertible. If $f(3)=4$ and $f'(3)=5$, find $\frac{d}{dx}\left[f^{-1}(x^2)\right]$ at $x=2$.$txt$,
        $txt$Let $f$ be differentiable and invertible. If $f(3)=4$ and $f'(3)=5$, find $\frac{d}{dx}\left[f^{-1}(x^2)\right]$ at $x=2$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{5}$", "type": "text", "explanation": "This uses $(f^{-1})'(4)=1/5 but forgets to multiply by $2x$ at $x=2$."},
          {"id": "B", "label": "B", "value": "$\\frac{2}{5}$", "type": "text", "explanation": "This multiplies by $2$ instead of by $2x$ at $x=2$."},
          {"id": "C", "label": "C", "value": "$\\frac{4}{5}$", "type": "text", "explanation": "Correct: $(f^{-1})'(4)=1/f'(3)=1/5$, then multiply by $2x=4$ giving $4/5$."},
          {"id": "D", "label": "D", "value": "$\\frac{5}{4}$", "type": "text", "explanation": "This flips the fraction and mixes inputs incorrectly."}
        ]$txt$,
        'C',
        $txt$Use chain rule with the inverse derivative rule: derivative is $(f^{-1})'(x^2)\cdot 2x$, then evaluate using matching input/output values from $f$.$txt$,
        '{inverse_function_derivative}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_function_derivative', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_derivative_wrong_input' FROM new_question;
