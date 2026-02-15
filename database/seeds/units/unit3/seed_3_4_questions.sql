-- Insert Script for Unit 3.4 Questions (Inverse Trig Derivatives)
-- Unit: Unit3_Composite_Implicit_Inverse / 3.4

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U3.4-P1', 'U3.4-P2', 'U3.4-P3', 'U3.4-P4', 'U3.4-P5');

-- ============================================================
-- U3.4-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.4-P1', 'Both', 'ABBC_Composite', '3.4', '3.4', 'MCQ', FALSE,
        3, 120, '{inverse_trig_derivatives}', '{inverse_trig_wrong_formula}', 'text',
        $txt$Find the derivative of $y=\arcsin(x)$.$txt$,
        $txt$Find the derivative of $y=\arcsin(x)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{\\sqrt{1-x^2}}$", "type": "text", "explanation": "Correct: the derivative of $\\arcsin(x)$ is $\\frac{1}{\\sqrt{1-x^2}}$."},
          {"id": "B", "label": "B", "value": "$\\frac{-1}{\\sqrt{1-x^2}}$", "type": "text", "explanation": "A negative sign is not part of the $\\arcsin$ derivative formula."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{\\sqrt{1+x^2}}$", "type": "text", "explanation": "This matches the inverse tangent pattern, not inverse sine."},
          {"id": "D", "label": "D", "value": "$\\sqrt{1-x^2}$", "type": "text", "explanation": "This is the reciprocal of the correct structure and is not a derivative formula."}
        ]$txt$,
        'A',
        $txt$Recall the standard derivative formula for the inverse sine function.$txt$,
        '{inverse_trig_derivatives}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_trig_derivatives', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_trig_wrong_formula' FROM new_question;

-- ============================================================
-- U3.4-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.4-P2', 'Both', 'ABBC_Composite', '3.4', '3.4', 'MCQ', FALSE,
        4, 180, '{inverse_trig_chain}', '{inverse_trig_missing_chain}', 'text',
        $txt$Find the derivative of $y=\arctan(3x)$.$txt$,
        $txt$Find the derivative of $y=\arctan(3x)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{1+(3x)^2}$", "type": "text", "explanation": "This misses the chain rule factor from differentiating $3x$."},
          {"id": "B", "label": "B", "value": "$\\frac{3}{1+9x^2}$", "type": "text", "explanation": "Correct: derivative is $\\frac{1}{1+(3x)^2}\\cdot 3=\\frac{3}{1+9x^2}$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{1+9x^2}$", "type": "text", "explanation": "This is missing the factor 3 from the chain rule."},
          {"id": "D", "label": "D", "value": "$\\frac{3}{\\sqrt{1-9x^2}}$", "type": "text", "explanation": "This uses the inverse sine structure instead of inverse tangent."}
        ]$txt$,
        'B',
        $txt$Use the inverse tangent derivative formula and multiply by the derivative of the inside expression.$txt$,
        '{inverse_trig_chain}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_trig_chain', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_trig_missing_chain' FROM new_question;

-- ============================================================
-- U3.4-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.4-P3', 'Both', 'ABBC_Composite', '3.4', '3.4', 'MCQ', FALSE,
        4, 180, '{inverse_trig_chain}', '{inverse_trig_missing_chain}', 'text',
        $txt$Find the derivative of $y=\arcsin(x^2)$.$txt$,
        $txt$Find the derivative of $y=\arcsin(x^2)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{\\sqrt{1-x^4}}$", "type": "text", "explanation": "This forgets the chain rule factor $2x$."},
          {"id": "B", "label": "B", "value": "$\\frac{2x}{\\sqrt{1-x^4}}$", "type": "text", "explanation": "Correct: $\\frac{1}{\\sqrt{1-(x^2)^2}}\\cdot 2x=\\frac{2x}{\\sqrt{1-x^4}}$."},
          {"id": "C", "label": "C", "value": "$\\frac{2}{\\sqrt{1-x^4}}$", "type": "text", "explanation": "This differentiates the inside incorrectly as a constant."},
          {"id": "D", "label": "D", "value": "$\\frac{2x}{\\sqrt{1-x^2}}$", "type": "text", "explanation": "This uses $1-x^2$ instead of $1-x^4$ inside the square root."}
        ]$txt$,
        'B',
        $txt$Apply the inverse sine derivative formula with $u=x^2$, then multiply by $u'$.$txt$,
        '{inverse_trig_chain}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_trig_chain', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_trig_missing_chain' FROM new_question;

-- ============================================================
-- U3.4-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.4-P4', 'Both', 'ABBC_Composite', '3.4', '3.4', 'MCQ', FALSE,
        5, 210, '{inverse_trig_chain}', '{inverse_trig_sign_domain_confusion}', 'text',
        $txt$Find the derivative of $y=\arccos(2x-1)$.$txt$,
        $txt$Find the derivative of $y=\arccos(2x-1)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{2}{\\sqrt{1-(2x-1)^2}}$", "type": "text", "explanation": "This misses the required negative sign for $\\arccos(u)$."},
          {"id": "B", "label": "B", "value": "$\\frac{-2}{\\sqrt{1-(2x-1)^2}}$", "type": "text", "explanation": "Correct: $\\frac{d}{dx}[\\arccos(u)]= -\\frac{u'}{\\sqrt{1-u^2}}$ with $u'=2$."},
          {"id": "C", "label": "C", "value": "$\\frac{-1}{\\sqrt{1-(2x-1)^2}}$", "type": "text", "explanation": "This uses the correct sign but misses the factor 2 from differentiating $2x-1$."},
          {"id": "D", "label": "D", "value": "$\\frac{2}{\\sqrt{1+(2x-1)^2}}$", "type": "text", "explanation": "This matches the inverse tangent structure, not inverse cosine."}
        ]$txt$,
        'B',
        $txt$The derivative of $\arccos(u)$ includes a negative sign and requires a chain rule factor $u'$.$txt$,
        '{inverse_trig_chain}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_trig_chain', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'chain_rule_with_trig_exp_log', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inverse_trig_sign_domain_confusion' FROM new_question;

-- ============================================================
-- U3.4-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U3.4-P5', 'Both', 'ABBC_Composite', '3.4', '3.4', 'MCQ', FALSE,
        4, 180, '{inverse_trig_derivatives}', '{method_choice_wrong_unit3}', 'text',
        $txt$Which derivative is correct?$txt$,
        $txt$Which derivative is correct?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{d}{dx}[\\arctan(x)]=\\frac{1}{\\sqrt{1-x^2}}$", "type": "text", "explanation": "This is the $\\arcsin(x)$ structure, not $\\arctan(x)$."},
          {"id": "B", "label": "B", "value": "$\\frac{d}{dx}[\\arcsin(x)]=\\frac{1}{1+x^2}$", "type": "text", "explanation": "This is the $\\arctan(x)$ structure, not $\\arcsin(x)$."},
          {"id": "C", "label": "C", "value": "$\\frac{d}{dx}[\\arccos(x)]=\\frac{-1}{\\sqrt{1-x^2}}$", "type": "text", "explanation": "Correct: $\\arccos(x)$ differentiates to a negative inverse-sine-style denominator."},
          {"id": "D", "label": "D", "value": "$\\frac{d}{dx}[\\arctan(x)]=\\frac{-1}{1+x^2}$", "type": "text", "explanation": "This incorrectly adds a negative sign to the $\\arctan(x)$ derivative."}
        ]$txt$,
        'C',
        $txt$Only one option matches a correct inverse trig derivative formula.$txt$,
        '{inverse_trig_derivatives}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inverse_trig_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit3', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'method_choice_wrong_unit3' FROM new_question;
