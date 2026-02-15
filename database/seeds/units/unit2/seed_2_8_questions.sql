-- Insert Script for Unit 2.8 Questions (Product Rule)
-- Unit: ABBC_Derivatives / 2.8

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.8-P1', 'U2.8-P2', 'U2.8-P3', 'U2.8-P4', 'U2.8-P5');

-- ============================================================
-- U2.8-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.8-P1', 'Both', 'ABBC_Derivatives', '2.8', '2.8', 'MCQ', FALSE,
        2, 90, '{product_rule}', '{product_rule_structure_error}', 'text',
        $txt$If $f(x)=x^2\sin x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=x^2\sin x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$2x \\sin x + x^2 \\cos x$", "type": "text", "explanation": "Correct. Product rule gives 2x sin x + x^2 cos x."},
          {"id": "B", "label": "B", "value": "$2x \\cos x + x^2 \\sin x$", "type": "text", "explanation": "This mixes up which factor gets differentiated into cos x."},
          {"id": "C", "label": "C", "value": "$x^2 \\cos x$", "type": "text", "explanation": "This only differentiates sin x and ignores the derivative of x^2."},
          {"id": "D", "label": "D", "value": "$2x \\sin x$", "type": "text", "explanation": "This only differentiates x^2 and ignores the derivative of sin x."}
        ]$txt$,
        'A',
        $txt$Use the product rule: $(uv)'=u'v+uv'$. Let $u=x^2$ and $v=\sin x$. Then $u'=2x$ and $v'=\cos x$, so $f'(x)=2x \sin x + x^2 \cos x$.$txt$,
        '{product_rule}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'product_rule', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'product_rule_structure_error' FROM new_question;

-- ============================================================
-- U2.8-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.8-P2', 'Both', 'ABBC_Derivatives', '2.8', '2.8', 'MCQ', FALSE,
        3, 150, '{product_rule,power_rule_basic}', '{product_rule_structure_error}', 'text',
        $txt$If $f(x)=(x^3-1)(x^2+4)$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=(x^3-1)(x^2+4)$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$3x^2(x^2 + 4) + (x^3 - 1)(2x)$", "type": "text", "explanation": "Correct. This is exactly u'v + uv'."},
          {"id": "B", "label": "B", "value": "$3x^2(x^2 + 4)$", "type": "text", "explanation": "This only includes u'v and forgets uv'."},
          {"id": "C", "label": "C", "value": "$(x^3 - 1)(2x)$", "type": "text", "explanation": "This only includes uv' and forgets u'v."},
          {"id": "D", "label": "D", "value": "$5x^4 + 12x^2$", "type": "text", "explanation": "This comes from expanding incorrectly and is not reliably derived."}
        ]$txt$,
        'A',
        $txt$Apply the product rule to $u=x^3-1$ and $v=x^2+4$. Then $u'=3x^2$ and $v'=2x$, so $f'(x)=u'v+uv' = 3x^2(x^2+4) + (x^3-1)(2x)$.$txt$,
        '{product_rule}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'product_rule', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'power_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'product_rule_structure_error' FROM new_question;

-- ============================================================
-- U2.8-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.8-P3', 'Both', 'ABBC_Derivatives', '2.8', '2.8', 'MCQ', FALSE,
        4, 180, '{product_rule,trig_derivatives_basic}', '{product_rule_structure_error}', 'text',
        $txt$If $f(x)=(\cos x)(e^x)$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=(\cos x)(e^x)$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-\\sin x \\cdot e^x + \\cos x \\cdot e^x$", "type": "text", "explanation": "Correct. Product rule gives (-sin x)e^x + (cos x)e^x."},
          {"id": "B", "label": "B", "value": "$-\\sin x \\cdot e^x$", "type": "text", "explanation": "This differentiates cos x but ignores the derivative of e^x."},
          {"id": "C", "label": "C", "value": "$\\cos x \\cdot e^x$", "type": "text", "explanation": "This ignores the derivative of cos x entirely."},
          {"id": "D", "label": "D", "value": "$\\sin x \\cdot e^x + \\cos x \\cdot e^x$", "type": "text", "explanation": "The derivative of cos x is -sin x, not +sin x."}
        ]$txt$,
        'A',
        $txt$Use the product rule. $(\cos x)'=-\sin x$ and $(e^x)'=e^x$. So $f'(x)=(-\sin x)e^x + (\cos x)e^x$.$txt$,
        '{product_rule}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'product_rule', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'trig_derivatives_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'product_rule_structure_error' FROM new_question;

-- ============================================================
-- U2.8-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.8-P4', 'Both', 'ABBC_Derivatives', '2.8', '2.8', 'MCQ', FALSE,
        4, 180, '{product_rule,log_derivatives_basic}', '{product_rule_structure_error}', 'text',
        $txt$If $f(x)=x\ln x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=x\ln x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\ln x + 1$", "type": "text", "explanation": "Correct. Product rule gives ln x + 1."},
          {"id": "B", "label": "B", "value": "1/x", "type": "text", "explanation": "This is only the derivative of ln x, missing the product rule."},
          {"id": "C", "label": "C", "value": "x/x", "type": "text", "explanation": "This simplifies to 1 but does not represent the full derivative."},
          {"id": "D", "label": "D", "value": "$x \\ln x + 1$", "type": "text", "explanation": "This incorrectly keeps x ln x in the derivative."}
        ]$txt$,
        'A',
        $txt$Use the product rule: $(x)'\cdot\ln x + x\cdot(\ln x)'$. That is $1\cdot\ln x + x\cdot(1/x) = \ln x + 1$.$txt$,
        '{product_rule}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'product_rule', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'log_derivatives_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'product_rule_structure_error' FROM new_question;

-- ============================================================
-- U2.8-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.8-P5', 'Both', 'ABBC_Derivatives', '2.8', '2.8', 'MCQ', FALSE,
        5, 210, '{method_selection_derivatives,product_rule}', '{wrong_method_choice_derivative}', 'text',
        $txt$Which method is most efficient for finding the derivative of $f(x)=(x^2+1)(\sin x)$?$txt$,
        $txt$Which method is most efficient for finding the derivative of $f(x)=(x^2+1)(\sin x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use the product rule.", "type": "text", "explanation": "Correct. A product requires the product rule for an exact result."},
          {"id": "B", "label": "B", "value": "Use only the power rule on $x^2+1$.", "type": "text", "explanation": "Differentiating only one factor misses the contribution from sin x."},
          {"id": "C", "label": "C", "value": "Use only the derivative of $\\sin x$.", "type": "text", "explanation": "Differentiating only sin x ignores the derivative of x^2+1."},
          {"id": "D", "label": "D", "value": "Estimate the derivative from a table.", "type": "text", "explanation": "A table only approximates and is slower than rules."}
        ]$txt$,
        'A',
        $txt$This function is a product of two differentiable functions, so the product rule gives an exact derivative efficiently.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'product_rule', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;
