-- Insert Script for Unit 2.10 Questions (Trig Derivatives Part 2)
-- Unit: ABBC_Derivatives / 2.10

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.10-P1', 'U2.10-P2', 'U2.10-P3', 'U2.10-P4', 'U2.10-P5');

-- ============================================================
-- U2.10-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.10-P1', 'Both', 'ABBC_Derivatives', '2.10', '2.10', 'MCQ', FALSE,
        2, 90, '{trig_derivatives_basic}', '{trig_derivative_swap_error}', 'text',
        $txt$If $f(x)=\tan x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\tan x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\sec^2 x$", "type": "text", "explanation": "Correct. d/dx(tan x)=sec^2 x."},
          {"id": "B", "label": "B", "value": "$\\csc^2 x$", "type": "text", "explanation": "csc^2 x is the derivative of -cot x, not tan x."},
          {"id": "C", "label": "C", "value": "$\\sec x$", "type": "text", "explanation": "sec x is not the derivative of tan x."},
          {"id": "D", "label": "D", "value": "$-\\sec^2 x$", "type": "text", "explanation": "The derivative is positive sec^2 x, not negative."}
        ]$txt$,
        'A',
        $txt$The derivative of $\tan x$ is $\sec^2 x$.$txt$,
        '{trig_derivatives_basic}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'trig_derivatives_basic', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'trig_derivative_swap_error' FROM new_question;

-- ============================================================
-- U2.10-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.10-P2', 'Both', 'ABBC_Derivatives', '2.10', '2.10', 'MCQ', FALSE,
        3, 120, '{trig_derivatives_basic,linearity_rules}', '{trig_derivative_swap_error}', 'text',
        $txt$If $f(x)=3\tan x - 2\cos x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=3\tan x - 2\cos x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$3\\sec^2 x + 2\\sin x$", "type": "text", "explanation": "Correct. tan becomes sec^2, and -cos becomes +sin."},
          {"id": "B", "label": "B", "value": "$3\\sec^2 x - 2\\sin x$", "type": "text", "explanation": "The sign on the derivative of -2cos x is wrong."},
          {"id": "C", "label": "C", "value": "$3\\sec x + 2\\sin x$", "type": "text", "explanation": "sec x is not the derivative of tan x."},
          {"id": "D", "label": "D", "value": "$3\\tan x + 2\\sin x$", "type": "text", "explanation": "This fails to differentiate tan x correctly."}
        ]$txt$,
        'A',
        $txt$Differentiate term-by-term: $\frac{d}{dx}(3\tan x)=3\sec^2 x$ and $\frac{d}{dx}(-2\cos x)=+2\sin x$. So $f'(x)=3\sec^2 x + 2\sin x$.$txt$,
        '{trig_derivatives_basic}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'trig_derivatives_basic', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'linearity_rules', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'trig_derivative_swap_error' FROM new_question;

-- ============================================================
-- U2.10-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.10-P3', 'Both', 'ABBC_Derivatives', '2.10', '2.10', 'MCQ', FALSE,
        3, 150, '{method_selection_derivatives,trig_derivatives_basic}', '{wrong_method_choice_derivative}', 'text',
        $txt$A student wants to find the derivative of $f(x)=\tan x + \sin x$. Which approach is most efficient?$txt$,
        $txt$A student wants to find the derivative of $f(x)=\tan x + \sin x$. Which approach is most efficient?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use known derivative rules and apply linearity.", "type": "text", "explanation": "Correct. Direct rules + linearity is quickest and exact."},
          {"id": "B", "label": "B", "value": "Use the limit definition for both terms.", "type": "text", "explanation": "The definition works but is not efficient here."},
          {"id": "C", "label": "C", "value": "Graph the function and estimate slopes.", "type": "text", "explanation": "Graphs give estimates, not exact derivatives."},
          {"id": "D", "label": "D", "value": "Make a table and estimate slopes near a point.", "type": "text", "explanation": "Tables give estimates and are slower than rules."}
        ]$txt$,
        'A',
        $txt$Both $\tan x$ and $\sin x$ have standard derivative rules, so using them with linearity is fastest and exact.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'trig_derivatives_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;

-- ============================================================
-- U2.10-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.10-P4', 'Both', 'ABBC_Derivatives', '2.10', '2.10', 'MCQ', FALSE,
        4, 180, '{product_rule,trig_derivatives_basic}', '{product_rule_structure_error}', 'text',
        $txt$If $f(x)=(\tan x)(x^2)$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=(\tan x)(x^2)$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\sec^2 x \\cdot x^2 + \\tan x \\cdot 2x$", "type": "text", "explanation": "Correct. u'v + uv' is sec^2 x * x^2 + tan x * 2x."},
          {"id": "B", "label": "B", "value": "$\\sec^2 x \\cdot 2x$", "type": "text", "explanation": "This differentiates both factors but multiplies them instead of adding terms."},
          {"id": "C", "label": "C", "value": "$\\tan x \\cdot x^2$", "type": "text", "explanation": "This does not differentiate at all."},
          {"id": "D", "label": "D", "value": "$\\sec^2 x \\cdot x^2$", "type": "text", "explanation": "This includes only the u'v part and misses uv'."}
        ]$txt$,
        'A',
        $txt$This is a product: $u=\tan x$ and $v=x^2$. Then $u'=\sec^2 x$ and $v'=2x$. Product rule gives $f'(x)=u'v+uv' = \sec^2 x \cdot x^2 + \tan x \cdot 2x$.$txt$,
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
-- U2.10-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.10-P5', 'Both', 'ABBC_Derivatives', '2.10', '2.10', 'MCQ', FALSE,
        4, 180, '{quotient_rule,trig_derivatives_basic}', '{quotient_rule_structure_error}', 'text',
        $txt$If $f(x)=\frac{\tan x}{x}$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\frac{\tan x}{x}$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{(\\sec^2 x)(x) - (\\tan x)(1)}{x^2}$", "type": "text", "explanation": "Correct. u'v - uv' over v^2 gives the right form."},
          {"id": "B", "label": "B", "value": "$\\frac{(\\sec^2 x)(x) + (\\tan x)(1)}{x^2}$", "type": "text", "explanation": "This uses + instead of - in the numerator."},
          {"id": "C", "label": "C", "value": "$\\frac{\\sec^2 x}{x}$", "type": "text", "explanation": "This misses the subtraction term from the quotient rule."},
          {"id": "D", "label": "D", "value": "$\\frac{\\tan x}{x^2}$", "type": "text", "explanation": "This is missing the u'v term."}
        ]$txt$,
        'A',
        $txt$Use the quotient rule with $u=\tan x$ and $v=x$. Then $u'=\sec^2 x$ and $v'=1$. So $f'(x)=\frac{(\sec^2 x)(x)-(\tan x)(1)}{x^2}$.$txt$,
        '{quotient_rule}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'quotient_rule', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'trig_derivatives_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_rule_structure_error' FROM new_question;
