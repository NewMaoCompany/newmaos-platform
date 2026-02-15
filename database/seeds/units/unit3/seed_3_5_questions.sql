-- Insert Script for Unit 3.5 Questions (Strategy Selection)
-- Unit: Unit3_Composite_Implicit_Inverse / 3.5

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U3.5-P1', 'U3.5-P2', 'U3.5-P3', 'U3.5-P4', 'U3.5-P5');

-- ============================================================
-- U3.5-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.5-P1', 'Both', 'ABBC_Composite', '3.5', '3.5', 'MCQ', FALSE,
        2, 90, '{method_selection_unit3}', '{method_choice_wrong_unit3}', 'text',
        $txt$Which method is most appropriate to find the derivative of $y=(5x-1)^6$?$txt$,
        $txt$Which method is most appropriate to find the derivative of $y=(5x-1)^6$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Implicit differentiation", "type": "text", "explanation": "Implicit differentiation is unnecessary because $y$ is already explicit."},
          {"id": "B", "label": "B", "value": "Chain rule", "type": "text", "explanation": "Correct: it is a power of a linear inside function."},
          {"id": "C", "label": "C", "value": "Derivative of an inverse function", "type": "text", "explanation": "No inverse function is involved."},
          {"id": "D", "label": "D", "value": "Higher-order differentiation", "type": "text", "explanation": "Higher-order derivatives are not requested."}
        ]$txt$,
        'B',
        $txt$This function is a basic composite power, so the chain rule is the direct method.$txt$,
        '{method_selection_unit3}',
        'published', 1, 2, 0.95, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;

-- ============================================================
-- U3.5-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.5-P2', 'Both', 'ABBC_Composite', '3.5', '3.5', 'MCQ', FALSE,
        3, 120, '{method_selection_unit3}', '{method_choice_wrong_unit3}', 'text',
        $txt$Which method is most appropriate to find $\frac{dy}{dx}$ if $x^2+y^2=10$?$txt$,
        $txt$Which method is most appropriate to find $\frac{dy}{dx}$ if $x^2+y^2=10$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Implicit differentiation", "type": "text", "explanation": "Correct: $y$ is not isolated, so implicit differentiation is appropriate."},
          {"id": "B", "label": "B", "value": "Derivative of an inverse function", "type": "text", "explanation": "No inverse function information is given."},
          {"id": "C", "label": "C", "value": "Inverse trig derivatives", "type": "text", "explanation": "No inverse trig functions appear."},
          {"id": "D", "label": "D", "value": "Higher-order derivatives", "type": "text", "explanation": "Second or higher derivatives are not requested."}
        ]$txt$,
        'A',
        $txt$The equation defines $y$ implicitly as a relation with $x$, so implicit differentiation is the natural method.$txt$,
        '{method_selection_unit3}',
        'published', 1, 3, 1.05, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'implicit_diff_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;

-- ============================================================
-- U3.5-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.5-P3', 'Both', 'ABBC_Composite', '3.5', '3.5', 'MCQ', FALSE,
        4, 150, '{method_selection_unit3}', '{inverse_derivative_wrong_input}', 'text',
        $txt$Given $f(4)=7$ and $f'(4)=2$, which expression equals $(f^{-1})'(7)$?$txt$,
        $txt$Given $f(4)=7$ and $f'(4)=2$, which expression equals $(f^{-1})'(7)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{f'(7)}$", "type": "text", "explanation": "This uses the wrong input: you should not plug 7 into $f'$."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{f'(4)}$", "type": "text", "explanation": "Correct: since $f(4)=7$, we use the reciprocal of $f'(4)$."},
          {"id": "C", "label": "C", "value": "$f'(4)$", "type": "text", "explanation": "This forgets the reciprocal relationship."},
          {"id": "D", "label": "D", "value": "$f'(7)$", "type": "text", "explanation": "This uses the wrong input and forgets the reciprocal."}
        ]$txt$,
        'B',
        $txt$For inverse derivatives, use the reciprocal of $f'(x)$ at the input where $f(x)$ matches the inverse input.$txt$,
        '{method_selection_unit3}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'inverse_function_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_derivative_wrong_input' FROM new_question;

-- ============================================================
-- U3.5-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.5-P4', 'Both', 'ABBC_Composite', '3.5', '3.5', 'MCQ', FALSE,
        4, 150, '{method_selection_unit3}', '{method_choice_wrong_unit3}', 'text',
        $txt$Which method is most appropriate to find the derivative of $y=\ln(\sin x)$?$txt$,
        $txt$Which method is most appropriate to find the derivative of $y=\ln(\sin x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Chain rule (log outer, trig inner)", "type": "text", "explanation": "Correct: differentiate $\\ln(u)$ and multiply by the derivative of $u=\\sin x$."},
          {"id": "B", "label": "B", "value": "Implicit differentiation", "type": "text", "explanation": "No implicit relationship is given; $y$ is explicit."},
          {"id": "C", "label": "C", "value": "Derivative of an inverse function", "type": "text", "explanation": "No inverse function appears."},
          {"id": "D", "label": "D", "value": "Higher-order derivative rules only", "type": "text", "explanation": "You still need the first derivative method; higher-order is not the main idea here."}
        ]$txt$,
        'A',
        $txt$This is a composite function with a logarithm outside and a trig function inside, so chain rule is required.$txt$,
        '{method_selection_unit3}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_with_trig_exp_log', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;

-- ============================================================
-- U3.5-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.5-P5', 'Both', 'ABBC_Composite', '3.5', '3.5', 'MCQ', FALSE,
        5, 180, '{method_selection_unit3}', '{method_choice_wrong_unit3}', 'text',
        $txt$Which method is most appropriate to find $\frac{dy}{dx}$ if $x^2y+\sin(y)=3$?$txt$,
        $txt$Which method is most appropriate to find $\frac{dy}{dx}$ if $x^2y+\sin(y)=3$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Implicit differentiation (with product rule on $x^2y$)", "type": "text", "explanation": "Correct: $x^2y$ requires product structure and $\\sin(y)$ requires dy/dx."},
          {"id": "B", "label": "B", "value": "Derivative of an inverse function", "type": "text", "explanation": "No inverse relationship is given."},
          {"id": "C", "label": "C", "value": "Only the chain rule", "type": "text", "explanation": "Chain rule alone is not sufficient; the equation is implicit."},
          {"id": "D", "label": "D", "value": "Higher-order derivatives first", "type": "text", "explanation": "You must find the first derivative method before thinking about higher-order."}
        ]$txt$,
        'A',
        $txt$Because $y$ appears in multiple places and is not solved explicitly, implicit differentiation is necessary.$txt$,
        '{method_selection_unit3}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit3', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'implicit_diff_product_quotient', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;
