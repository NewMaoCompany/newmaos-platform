-- Insert Script for Unit 3.6 Questions (Higher-Order Derivatives)
-- Unit: Unit3_Composite_Implicit_Inverse / 3.6

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U3.6-P1', 'U3.6-P2', 'U3.6-P3', 'U3.6-P4', 'U3.6-P5');

-- ============================================================
-- U3.6-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.6-P1', 'Both', 'ABBC_Composite', '3.6', '3.6', 'MCQ', FALSE,
        2, 90, '{higher_order_derivatives}', '{higher_order_derivative_misread}', 'text',
        $txt$If $f(x)=x^3-5x$, what is $f''(x)$?$txt$,
        $txt$If $f(x)=x^3-5x$, what is $f''(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$3x^2-5$", "type": "text", "explanation": "This is $f'(x)$, not $f''(x)$."},
          {"id": "B", "label": "B", "value": "$6x$", "type": "text", "explanation": "Correct: $f'(x)=3x^2-5$, so $f''(x)=6x$."},
          {"id": "C", "label": "C", "value": "$6x-5$", "type": "text", "explanation": "This incorrectly keeps the constant term from $f'(x)$."},
          {"id": "D", "label": "D", "value": "$3x$", "type": "text", "explanation": "This is missing the factor 2 when differentiating $3x^2$."}
        ]$txt$,
        'B',
        $txt$Differentiate twice: first derivative then second derivative.$txt$,
        '{higher_order_derivatives}',
        'published', 1, 2, 0.95, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'higher_order_derivatives', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'higher_order_derivative_misread' FROM new_question;

-- ============================================================
-- U3.6-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.6-P2', 'Both', 'ABBC_Composite', '3.6', '3.6', 'MCQ', FALSE,
        3, 120, '{higher_order_derivatives}', '{higher_order_compute_error}', 'text',
        $txt$If $g(x)=(2x-1)^4$, what is $g''(x)$?$txt$,
        $txt$If $g(x)=(2x-1)^4$, what is $g''(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$16(2x-1)^3$", "type": "text", "explanation": "This is proportional to the first derivative, not the second."},
          {"id": "B", "label": "B", "value": "$48(2x-1)^2$", "type": "text", "explanation": "This is missing a factor from the second differentiation step."},
          {"id": "C", "label": "C", "value": "$96(2x-1)^2$", "type": "text", "explanation": "Correct: $g'(x)=8(2x-1)^3$, then $g''(x)=8\\cdot 3(2x-1)^2\\cdot 2=96(2x-1)^2$."},
          {"id": "D", "label": "D", "value": "$96(2x-1)^3$", "type": "text", "explanation": "This keeps the power at 3 after the second differentiation; it should drop to 2."}
        ]$txt$,
        'C',
        $txt$Differentiate twice using chain rule each time and simplify carefully.$txt$,
        '{higher_order_derivatives}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'higher_order_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'higher_order_compute_error' FROM new_question;

-- ============================================================
-- U3.6-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.6-P3', 'Both', 'ABBC_Composite', '3.6', '3.6', 'MCQ', FALSE,
        3, 120, '{higher_order_derivatives}', '{higher_order_compute_error}', 'text',
        $txt$If $h(x)=\sin(x)$, what is $h'''(x)$?$txt$,
        $txt$If $h(x)=\sin(x)$, what is $h'''(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\cos(x)$", "type": "text", "explanation": "This is the first derivative, not the third."},
          {"id": "B", "label": "B", "value": "$-\\sin(x)$", "type": "text", "explanation": "This is the second derivative, not the third."},
          {"id": "C", "label": "C", "value": "$-\\cos(x)$", "type": "text", "explanation": "Correct: $h'(x)=\\cos x$, $h''(x)=-\\sin x$, $h'''(x)=-\\cos x$."},
          {"id": "D", "label": "D", "value": "$\\sin(x)$", "type": "text", "explanation": "This is the negative of the correct third derivative."}
        ]$txt$,
        'C',
        $txt$Differentiate repeatedly and track signs carefully.$txt$,
        '{higher_order_derivatives}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'higher_order_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_with_trig_exp_log', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'higher_order_compute_error' FROM new_question;

-- ============================================================
-- U3.6-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.6-P4', 'Both', 'ABBC_Composite', '3.6', '3.6', 'MCQ', FALSE,
        4, 150, '{higher_order_meaning}', '{higher_order_derivative_misread}', 'text',
        $txt$A function has $f'(2)=0$ and $f''(2)<0$. Which statement must be true about $f$ at $x=2$?$txt$,
        $txt$A function has $f'(2)=0$ and $f''(2)<0$. Which statement must be true about $f$ at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=2$.", "type": "text", "explanation": "Correct: $f'(2)=0$ and $f''(2)<0$ implies a local maximum."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=2$.", "type": "text", "explanation": "A local minimum would require $f''(2)>0$ (concave up)."},
          {"id": "C", "label": "C", "value": "$f$ is increasing at $x=2$.", "type": "text", "explanation": "If $f'(2)=0$, the function is not increasing at that exact point."},
          {"id": "D", "label": "D", "value": "$f$ is concave up at $x=2$.", "type": "text", "explanation": "Concave up would mean $f''(2)>0$, not negative."}
        ]$txt$,
        'A',
        $txt$If the slope is zero and the concavity is down at that point, the point is a local maximum by the second derivative test.$txt$,
        '{higher_order_meaning}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'higher_order_meaning', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'higher_order_derivatives', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'higher_order_derivative_misread' FROM new_question;

-- ============================================================
-- U3.6-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.6-P5', 'Both', 'ABBC_Composite', '3.6', '3.6', 'MCQ', FALSE,
        5, 180, '{higher_order_derivatives}', '{method_choice_wrong_unit3}', 'text',
        $txt$Let $f(x)=\arctan(x^2)$. Which process is most appropriate to find $f''(x)$?$txt$,
        $txt$Let $f(x)=\arctan(x^2)$. Which process is most appropriate to find $f''(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use inverse trig derivative with chain rule to find $f'(x)$, then differentiate again.", "type": "text", "explanation": "Correct: $\\arctan$ requires the inverse trig derivative formula and chain rule, then repeat differentiation."},
          {"id": "B", "label": "B", "value": "Use implicit differentiation twice without simplifying.", "type": "text", "explanation": "Implicit differentiation is not needed because the function is explicit."},
          {"id": "C", "label": "C", "value": "Use inverse function derivative rule directly.", "type": "text", "explanation": "Inverse function derivative applies to $f^{-1}$, not $\\arctan(x^2)$."},
          {"id": "D", "label": "D", "value": "Find $f''(x)$ without finding $f'(x)$." , "type": "text", "explanation": "A second derivative comes from differentiating the first derivative."}
        ]$txt$,
        'A',
        $txt$To get a second derivative, you compute the first derivative with the correct method, then differentiate again.$txt$,
        '{higher_order_derivatives}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'higher_order_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;
