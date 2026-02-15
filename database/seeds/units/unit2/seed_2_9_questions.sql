-- Insert Script for Unit 2.9 Questions (Quotient Rule)
-- Unit: ABBC_Derivatives / 2.9

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.9-P1', 'U2.9-P2', 'U2.9-P3', 'U2.9-P4', 'U2.9-P5');

-- ============================================================
-- U2.9-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.9-P1', 'Both', 'ABBC_Derivatives', '2.9', '2.9', 'MCQ', FALSE,
        3, 150, '{quotient_rule}', '{quotient_rule_structure_error}', 'text',
        $txt$If $f(x)=\frac{x^2}{x+1}$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\frac{x^2}{x+1}$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{(2x)(x+1) - x^2(1)}{(x+1)^2}$", "type": "text", "explanation": "Correct. This matches (u'v - uv')/v^2."},
          {"id": "B", "label": "B", "value": "$\\frac{(2x)(x+1) + x^2(1)}{(x+1)^2}$", "type": "text", "explanation": "This uses + instead of - in the numerator."},
          {"id": "C", "label": "C", "value": "$\\frac{2x}{x+1}$", "type": "text", "explanation": "This differentiates the numerator only and ignores the quotient rule."},
          {"id": "D", "label": "D", "value": "$\\frac{x^2}{(x+1)^2}$", "type": "text", "explanation": "This changes the denominator but does not compute the numerator correctly."}
        ]$txt$,
        'A',
        $txt$Use the quotient rule: $(u/v)'=\frac{u'v-uv'}{v^2}$. Here $u=x^2$, $v=x+1$, so $u'=2x$ and $v'=1$. Substitute to get $\frac{(2x)(x+1)-x^2(1)}{(x+1)^2}$.$txt$,
        '{quotient_rule}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'quotient_rule', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_rule_structure_error' FROM new_question;

-- ============================================================
-- U2.9-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.9-P2', 'Both', 'ABBC_Derivatives', '2.9', '2.9', 'MCQ', FALSE,
        4, 180, '{quotient_rule,power_rule_basic}', '{quotient_rule_sign_error}', 'text',
        $txt$If $f(x)=\frac{3x^2 - 1}{x}$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\frac{3x^2 - 1}{x}$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{(6x)(x) - (3x^2 - 1)(1)}{x^2}$", "type": "text", "explanation": "Correct. This is u'v - uv' over v^2."},
          {"id": "B", "label": "B", "value": "$\\frac{(6x)(x) + (3x^2 - 1)(1)}{x^2}$", "type": "text", "explanation": "This incorrectly uses + instead of -."},
          {"id": "C", "label": "C", "value": "$\\frac{6x}{x}$", "type": "text", "explanation": "This differentiates u but ignores the quotient structure."},
          {"id": "D", "label": "D", "value": "$\\frac{(3x^2 - 1)(1) - (6x)(x)}{x^2}$", "type": "text", "explanation": "This reverses the numerator order, causing a sign error."}
        ]$txt$,
        'A',
        $txt$Let $u=3x^2-1$ and $v=x$. Then $u'=6x$ and $v'=1$. Quotient rule gives $\frac{u'v-uv'}{v^2} = \frac{(6x)(x)-(3x^2-1)(1)}{x^2}$.$txt$,
        '{quotient_rule}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'quotient_rule', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'power_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_rule_sign_error' FROM new_question;

-- ============================================================
-- U2.9-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.9-P3', 'Both', 'ABBC_Derivatives', '2.9', '2.9', 'MCQ', FALSE,
        4, 180, '{quotient_rule,trig_derivatives_basic}', '{quotient_rule_structure_error}', 'text',
        $txt$If $f(x)=\frac{\sin x}{x^2}$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\frac{\sin x}{x^2}$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{(\\cos x)(x^2) - (\\sin x)(2x)}{(x^2)^2}$", "type": "text", "explanation": "Correct. This is u'v - uv' over v^2."},
          {"id": "B", "label": "B", "value": "$\\frac{(\\cos x)(x^2) + (\\sin x)(2x)}{(x^2)^2}$", "type": "text", "explanation": "This uses + instead of - in the numerator."},
          {"id": "C", "label": "C", "value": "$\\frac{\\cos x}{x^2}$", "type": "text", "explanation": "This differentiates the numerator only and ignores the quotient rule."},
          {"id": "D", "label": "D", "value": "$\\frac{\\sin x}{2x}$", "type": "text", "explanation": "This is not a valid derivative result for a quotient."}
        ]$txt$,
        'A',
        $txt$Use quotient rule with $u=\sin x$ and $v=x^2$. Then $u'=\cos x$ and $v'=2x$. So $f'(x)=\frac{(\cos x)(x^2)-(\sin x)(2x)}{(x^2)^2}$.$txt$,
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

-- ============================================================
-- U2.9-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.9-P4', 'Both', 'ABBC_Derivatives', '2.9', '2.9', 'MCQ', FALSE,
        5, 210, '{quotient_rule,log_derivatives_basic}', '{quotient_rule_sign_error}', 'text',
        $txt$If $f(x)=\frac{\ln x}{x}$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\frac{\ln x}{x}$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{(1/x)(x) - (\\ln x)(1)}{x^2}$", "type": "text", "explanation": "Correct. u'v - uv' over v^2 gives the right structure."},
          {"id": "B", "label": "B", "value": "$\\frac{(1/x)(x) + (\\ln x)(1)}{x^2}$", "type": "text", "explanation": "This uses + instead of - in the numerator."},
          {"id": "C", "label": "C", "value": "$\\frac{1/x}{x}$", "type": "text", "explanation": "This ignores the subtraction term from the quotient rule."},
          {"id": "D", "label": "D", "value": "$\\frac{\\ln x}{x^2}$", "type": "text", "explanation": "This changes only the denominator and is missing the u'v term."}
        ]$txt$,
        'A',
        $txt$Let $u=\ln x$ and $v=x$. Then $u'=1/x$ and $v'=1$. Quotient rule gives $f'(x)=\frac{(1/x)(x)-(\ln x)(1)}{x^2}$.$txt$,
        '{quotient_rule}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'quotient_rule', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'log_derivatives_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_rule_sign_error' FROM new_question;

-- ============================================================
-- U2.9-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.9-P5', 'Both', 'ABBC_Derivatives', '2.9', '2.9', 'MCQ', FALSE,
        4, 150, '{method_selection_derivatives,quotient_rule}', '{wrong_method_choice_derivative}', 'text',
        $txt$Which method is most efficient for finding the derivative of $f(x)=\frac{x^2+1}{x-3}$?$txt$,
        $txt$Which method is most efficient for finding the derivative of $f(x)=\frac{x^2+1}{x-3}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use the quotient rule.", "type": "text", "explanation": "Correct. A quotient requires the quotient rule for an exact derivative."},
          {"id": "B", "label": "B", "value": "Use only the power rule on $x^2+1$ and keep the denominator the same.", "type": "text", "explanation": "This ignores the derivative of the denominator and misses the quotient structure."},
          {"id": "C", "label": "C", "value": "Estimate the slope from a graph.", "type": "text", "explanation": "Graphing gives only an approximation and is unnecessary."},
          {"id": "D", "label": "D", "value": "Use a table and estimate slopes near a point.", "type": "text", "explanation": "Tables give only approximations and take longer."}
        ]$txt$,
        'A',
        $txt$This is a quotient of differentiable functions, so the quotient rule produces an exact derivative efficiently.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'quotient_rule', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;
