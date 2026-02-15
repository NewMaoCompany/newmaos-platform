-- Insert Script for Unit 2.5 Questions (Power Rule)
-- Unit: ABBC_Derivatives / 2.5

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.5-P1', 'U2.5-P2', 'U2.5-P3', 'U2.5-P4', 'U2.5-P5');

-- ============================================================
-- U2.5-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.5-P1', 'Both', 'ABBC_Derivatives', '2.5', '2.5', 'MCQ', FALSE,
        2, 90, '{power_rule_basic}', '{power_rule_exponent_error}', 'text',
        $txt$If $f(x)=x^7$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=x^7$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$7x^6$", "type": "text", "explanation": "Correct. Apply the power rule: 7x^6."},
          {"id": "B", "label": "B", "value": "$x^6$", "type": "text", "explanation": "This drops the coefficient 7 from the power rule."},
          {"id": "C", "label": "C", "value": "$7x^7$", "type": "text", "explanation": "This keeps the exponent instead of subtracting 1."},
          {"id": "D", "label": "D", "value": "$x^7$", "type": "text", "explanation": "This incorrectly treats the derivative as unchanged."}
        ]$txt$,
        'A',
        $txt$By the power rule, the derivative of $x^n$ is $n \cdot x^{n-1}$. With $n=7$, $f'(x)=7x^6$.$txt$,
        '{power_rule_basic}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'power_rule_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'power_rule_exponent_error' FROM new_question;

-- ============================================================
-- U2.5-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.5-P2', 'Both', 'ABBC_Derivatives', '2.5', '2.5', 'MCQ', FALSE,
        3, 120, '{power_rule_basic,linearity_rules}', '{linearity_missing_term}', 'text',
        $txt$If $f(x)=4x^5-3x^2$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=4x^5-3x^2$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$20x^4 - 6x$", "type": "text", "explanation": "Correct. Power rule on each term gives 20x^4-6x."},
          {"id": "B", "label": "B", "value": "$20x^5 - 6x^2$", "type": "text", "explanation": "This forgets to reduce the exponent by 1."},
          {"id": "C", "label": "C", "value": "$5x^4 - 2x$", "type": "text", "explanation": "This forgets to multiply by the original coefficients 4 and -3."},
          {"id": "D", "label": "D", "value": "$20x^4 - 3x^2$", "type": "text", "explanation": "This differentiates the first term but not the second term correctly."}
        ]$txt$,
        'A',
        $txt$Differentiate each term: $(4x^5)'=20x^4$ and $(-3x^2)'=-6x$. So $f'(x)=20x^4-6x$.$txt$,
        '{power_rule_basic}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'power_rule_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'linearity_rules', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'linearity_missing_term' FROM new_question;

-- ============================================================
-- U2.5-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.5-P3', 'Both', 'ABBC_Derivatives', '2.5', '2.5', 'MCQ', FALSE,
        3, 150, '{power_rule_basic}', '{power_rule_exponent_error}', 'text',
        $txt$If $f(x)=x^{1/2}$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=x^{1/2}$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{2}x^{-1/2}$", "type": "text", "explanation": "Correct. Multiply by 1/2 and subtract 1 from the exponent."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{2}x^{1/2}$", "type": "text", "explanation": "This multiplies by 1/2 but forgets to change the exponent."},
          {"id": "C", "label": "C", "value": "$x^{-1/2}$", "type": "text", "explanation": "This misses the coefficient 1/2."},
          {"id": "D", "label": "D", "value": "$-\\frac{1}{2}x^{-3/2}$", "type": "text", "explanation": "This uses the wrong exponent change."}
        ]$txt$,
        'A',
        $txt$Apply the power rule: $\frac{d}{dx}[x^n]=n \cdot x^{n-1}$. With $n=1/2$, $f'(x)=\frac{1}{2}x^{-1/2}$.$txt$,
        '{power_rule_basic}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'power_rule_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'power_rule_exponent_error' FROM new_question;

-- ============================================================
-- U2.5-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.5-P4', 'Both', 'ABBC_Derivatives', '2.5', '2.5', 'MCQ', FALSE,
        4, 180, '{power_rule_basic,linearity_rules}', '{constant_derivative_error}', 'text',
        $txt$If $f(x)=6-2x^3+x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=6-2x^3+x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-6x^2 + 1$", "type": "text", "explanation": "Correct. Constant disappears, and power rule gives -6x^2+1."},
          {"id": "B", "label": "B", "value": "$6 - 6x^2 + 1$", "type": "text", "explanation": "This incorrectly keeps the constant 6 in the derivative."},
          {"id": "C", "label": "C", "value": "$-2x^2 + 1$", "type": "text", "explanation": "This forgets to multiply by the 3 in the power rule."},
          {"id": "D", "label": "D", "value": "$-6x^3 + 1$", "type": "text", "explanation": "This reduces incorrectly or differentiates x^3 wrong."}
        ]$txt$,
        'A',
        $txt$Differentiate each term: derivative of constant 6 is 0, derivative of $-2x^3$ is $-6x^2$, derivative of $x$ is 1. So $f'(x)=-6x^2+1$.$txt$,
        '{power_rule_basic}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'power_rule_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'linearity_rules', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'constant_derivative_error' FROM new_question;

-- ============================================================
-- U2.5-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.5-P5', 'Both', 'ABBC_Derivatives', '2.5', '2.5', 'MCQ', FALSE,
        4, 180, '{method_selection_derivatives,power_rule_basic}', '{wrong_method_choice_derivative}', 'text',
        $txt$Which method is most efficient for finding the derivative of $f(x)=x^9-5x$ at $x=2$?$txt$,
        $txt$Which method is most efficient for finding the derivative of $f(x)=x^9-5x$ at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use the derivative rules for powers and linear terms.", "type": "text", "explanation": "Correct. Power rule and linearity make this quick and exact."},
          {"id": "B", "label": "B", "value": "Estimate the derivative from a table of values near $x=2$.", "type": "text", "explanation": "A table only gives an approximation and is slower."},
          {"id": "C", "label": "C", "value": "Estimate the derivative from a graph.", "type": "text", "explanation": "A graph is also approximate and unnecessary for a polynomial."},
          {"id": "D", "label": "D", "value": "Use the limit definition of the derivative every time.", "type": "text", "explanation": "The limit definition works, but it is not the most efficient method."}
        ]$txt$,
        'A',
        $txt$For a polynomial, derivative rules are fastest and exact. Table and graph methods only approximate, and the limit definition is slower than necessary here.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'power_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;
