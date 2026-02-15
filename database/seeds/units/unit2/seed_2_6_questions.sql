-- Insert Script for Unit 2.6 Questions (Linearity Rules)
-- Unit: ABBC_Derivatives / 2.6

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.6-P1', 'U2.6-P2', 'U2.6-P3', 'U2.6-P4', 'U2.6-P5');

-- ============================================================
-- U2.6-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.6-P1', 'Both', 'ABBC_Derivatives', '2.6', '2.6', 'MCQ', FALSE,
        2, 90, '{linearity_rules}', '{linearity_missing_term}', 'text',
        $txt$If $f(x)=3x^4+7x$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=3x^4+7x$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$12x^3 + 7$", "type": "text", "explanation": "Correct. Term-by-term derivative gives 12x^3+7."},
          {"id": "B", "label": "B", "value": "$12x^4 + 7x$", "type": "text", "explanation": "This does not reduce the exponent and keeps the original term 7x."},
          {"id": "C", "label": "C", "value": "$3x^3 + 7$", "type": "text", "explanation": "This forgets to multiply by 4 in the power rule."},
          {"id": "D", "label": "D", "value": "$12x^3 + 7x$", "type": "text", "explanation": "This incorrectly keeps x in the derivative of 7x."}
        ]$txt$,
        'A',
        $txt$By linearity, differentiate term-by-term. $(3x^4)'=12x^3$ and $(7x)'=7$. So $f'(x)=12x^3+7$.$txt$,
        '{linearity_rules}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearity_rules', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'linearity_missing_term' FROM new_question;

-- ============================================================
-- U2.6-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.6-P2', 'Both', 'ABBC_Derivatives', '2.6', '2.6', 'MCQ', FALSE,
        3, 120, '{linearity_rules,power_rule_basic}', '{constant_derivative_error}', 'text',
        $txt$If $f(x)=5(x^3-2x+4)$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=5(x^3-2x+4)$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$15x^2 - 10$", "type": "text", "explanation": "Correct. Constant multiple rule + derivative inside gives 15x^2-10."},
          {"id": "B", "label": "B", "value": "$15x^3 - 10x + 20$", "type": "text", "explanation": "This differentiates incorrectly (exponents and constants are not handled correctly)."},
          {"id": "C", "label": "C", "value": "$5(3x^2 - 2 + 4)$", "type": "text", "explanation": "This incorrectly treats the derivative of 4 as 4 instead of 0."},
          {"id": "D", "label": "D", "value": "$15x^2 - 10 + 20$", "type": "text", "explanation": "This incorrectly keeps a +20 from the constant term."}
        ]$txt$,
        'A',
        $txt$Pull out the constant multiple 5, then differentiate inside: $(x^3)'=3x^2$, $(-2x)'=-2$, and $(4)'=0$. Multiply by 5: $f'(x)=5(3x^2-2)=15x^2-10$.$txt$,
        '{linearity_rules}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearity_rules', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'power_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'constant_derivative_error' FROM new_question;

-- ============================================================
-- U2.6-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.6-P3', 'Both', 'ABBC_Derivatives', '2.6', '2.6', 'MCQ', FALSE,
        3, 150, '{linearity_rules}', '{linearity_missing_term}', 'text',
        $txt$If $f(x)=\frac{1}{2}x^6-x^2+9$, what is $f'(x)$?$txt$,
        $txt$If $f(x)=\frac{1}{2}x^6-x^2+9$, what is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$3x^5 - 2x$", "type": "text", "explanation": "Correct. Each term is differentiated correctly."},
          {"id": "B", "label": "B", "value": "$3x^6 - 2x^2 + 9$", "type": "text", "explanation": "This is the original function, not its derivative."},
          {"id": "C", "label": "C", "value": "$3x^5 - x$", "type": "text", "explanation": "This differentiates -x^2 incorrectly as -x."},
          {"id": "D", "label": "D", "value": "$x^5 - 2x$", "type": "text", "explanation": "This drops the factor 3 from the first term."}
        ]$txt$,
        'A',
        $txt$Differentiate term-by-term: $(\frac{1}{2}x^6)'=3x^5$, $(-x^2)'=-2x$, and $(9)'=0$. So $f'(x)=3x^5-2x$.$txt$,
        '{linearity_rules}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearity_rules', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'linearity_missing_term' FROM new_question;

-- ============================================================
-- U2.6-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.6-P4', 'Both', 'ABBC_Derivatives', '2.6', '2.6', 'MCQ', FALSE,
        4, 180, '{linearity_rules,power_rule_basic}', '{linearity_missing_term}', 'text',
        $txt$Let $f(x)=2x^5-3x^4+x^2-7$. What is $f'(x)$?$txt$,
        $txt$Let $f(x)=2x^5-3x^4+x^2-7$. What is $f'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$10x^4 - 12x^3 + 2x$", "type": "text", "explanation": "Correct. All terms are differentiated correctly and constants vanish."},
          {"id": "B", "label": "B", "value": "$10x^5 - 12x^4 + 2x^2 - 7$", "type": "text", "explanation": "This fails to reduce exponents and keeps the constant -7."},
          {"id": "C", "label": "C", "value": "$10x^4 - 12x^3 + x^2$", "type": "text", "explanation": "This differentiates x^2 incorrectly as x^2 instead of 2x."},
          {"id": "D", "label": "D", "value": "$10x^4 - 3x^4 + 2x$", "type": "text", "explanation": "This does not apply the power rule to the -3x^4 term."}
        ]$txt$,
        'A',
        $txt$Differentiate term-by-term: $(2x^5)'=10x^4$, $(-3x^4)'=-12x^3$, $(x^2)'=2x$, and $(-7)'=0$. So $f'(x)=10x^4-12x^3+2x$.$txt$,
        '{linearity_rules}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearity_rules', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'power_rule_basic', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'linearity_missing_term' FROM new_question;

-- ============================================================
-- U2.6-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.6-P5', 'Both', 'ABBC_Derivatives', '2.6', '2.6', 'MCQ', FALSE,
        4, 180, '{method_selection_derivatives,linearity_rules}', '{wrong_method_choice_derivative}', 'text',
        $txt$A student wants to find the derivative of $f(x)=7x^3-4x+6$. Which approach is most efficient?$txt$,
        $txt$A student wants to find the derivative of $f(x)=7x^3-4x+6$. Which approach is most efficient?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use linearity and the power rule directly.", "type": "text", "explanation": "Correct. Rules are fastest and exact for polynomials."},
          {"id": "B", "label": "B", "value": "Make a table and estimate slopes near a point.", "type": "text", "explanation": "Tables are approximate and take longer than direct rules."},
          {"id": "C", "label": "C", "value": "Graph the function and estimate the tangent slope.", "type": "text", "explanation": "Graphs are approximate and unnecessary here."},
          {"id": "D", "label": "D", "value": "Use the limit definition for every derivative.", "type": "text", "explanation": "The definition works but is not efficient for polynomials."}
        ]$txt$,
        'A',
        $txt$Since $f$ is a polynomial, using linearity and the power rule gives an exact derivative quickly. Tables/graphs approximate, and the definition is slower than necessary.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'linearity_rules', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;
