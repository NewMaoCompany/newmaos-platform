-- Insert Script for Chapter 1.7 Questions (Selecting Procedures for Determining Limits)
-- Unit: Both_Limits / 1.7

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.7-P1', '1.7-P2', '1.7-P3', '1.7-P4', '1.7-P5');

-- ============================================================
-- 1.7-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.7-P1', 'Both', 'Both_Limits', '1.7', '1.7', 'MCQ', FALSE,
        1, 120, '{method_selection,limit_laws}', '{wrong_method_choice}', 'text',
        $txt$Which method is most appropriate to evaluate $\lim_{x\to 2} (x^3-4x+1)$?$txt$,
        $txt$Which method is most appropriate to evaluate $\lim_{x\to 2} (x^3-4x+1)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Direct substitution", "type": "text", "explanation": "Correct: direct substitution works for polynomials."},
          {"id": "B", "label": "B", "value": "Factor and cancel", "type": "text", "explanation": "Factoring is unnecessary because substitution does not give an indeterminate form."},
          {"id": "C", "label": "C", "value": "Multiply by a conjugate", "type": "text", "explanation": "Conjugates are used for radicals, not polynomials."},
          {"id": "D", "label": "D", "value": "Use the Squeeze Theorem", "type": "text", "explanation": "Squeeze is not needed for a polynomial limit."}
        ]$txt$,
        'A',
        $txt$Polynomials are continuous, so the limit can be found by direct substitution.$txt$,
        '{method_selection}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Target time: 2 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_laws', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice' FROM new_question;


-- ============================================================
-- 1.7-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.7-P2', 'Both', 'Both_Limits', '1.7', '1.7', 'MCQ', FALSE,
        2, 180, '{method_selection,algebraic_simplification}', '{illegal_substitution_0over0}', 'text',
        $txt$Which method is most appropriate to evaluate $\lim_{x\to 3} \frac{x^2-9}{x-3}$?$txt$,
        $txt$Which method is most appropriate to evaluate $\lim_{x\to 3} \frac{x^2-9}{x-3}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Direct substitution", "type": "text", "explanation": "Substitution gives $0/0$, so more work is needed."},
          {"id": "B", "label": "B", "value": "Factor and cancel", "type": "text", "explanation": "Correct: factor $x^2-9=(x-3)(x+3)$ and cancel."},
          {"id": "C", "label": "C", "value": "Multiply by a conjugate", "type": "text", "explanation": "Conjugates are used for radicals, not this factorable expression."},
          {"id": "D", "label": "D", "value": "Use a table of values", "type": "text", "explanation": "A table is optional, but algebra is the standard exact method."}
        ]$txt$,
        'B',
        $txt$Direct substitution gives $0/0$, so factoring and canceling is the appropriate strategy.$txt$,
        '{method_selection}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'illegal_substitution_0over0' FROM new_question;


-- ============================================================
-- 1.7-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.7-P3', 'Both', 'Both_Limits', '1.7', '1.7', 'MCQ', FALSE,
        3, 240, '{method_selection,conjugate_rationalization}', '{conjugate_setup_error}', 'text',
        $txt$Which method is most appropriate to evaluate $\lim_{x\to 0} \frac{\sqrt{x+9}-3}{x}$?$txt$,
        $txt$Which method is most appropriate to evaluate $\lim_{x\to 0} \frac{\sqrt{x+9}-3}{x}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Direct substitution", "type": "text", "explanation": "Substitution gives $0/0$, so it does not finish the problem."},
          {"id": "B", "label": "B", "value": "Factor and cancel", "type": "text", "explanation": "Factoring does not remove the radical difference form."},
          {"id": "C", "label": "C", "value": "Multiply by a conjugate", "type": "text", "explanation": "Correct: conjugate rationalization removes the radical and cancels $x$."},
          {"id": "D", "label": "D", "value": "Use IVT", "type": "text", "explanation": "IVT is about existence of roots, not evaluating a limit."}
        ]$txt$,
        'C',
        $txt$Substitution gives $0/0$, and the expression involves a radical difference, so multiplying by the conjugate is the correct method.$txt$,
        '{method_selection}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'conjugate_rationalization', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'conjugate_setup_error' FROM new_question;


-- ============================================================
-- 1.7-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.7-P4', 'Both', 'Both_Limits', '1.7', '1.7', 'MCQ', FALSE,
        3, 240, '{method_selection,limits_at_infinity}', '{infinity_degree_mistake}', 'text',
        $txt$Which method is most appropriate to evaluate $\lim_{x\to \infty} \frac{5x^3-2}{2x^3+7x}$?$txt$,
        $txt$Which method is most appropriate to evaluate $\lim_{x\to \infty} \frac{5x^3-2}{2x^3+7x}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Direct substitution", "type": "text", "explanation": "Substitution does not work for $x\\to\\infty$."},
          {"id": "B", "label": "B", "value": "Divide numerator and denominator by the highest power of $x$", "type": "text", "explanation": "Correct: dividing by $x^3$ reveals the ratio of leading coefficients."},
          {"id": "C", "label": "C", "value": "Multiply by a conjugate", "type": "text", "explanation": "Conjugates apply to radical expressions, not polynomial ratios."},
          {"id": "D", "label": "D", "value": "Use the Squeeze Theorem", "type": "text", "explanation": "Squeeze is not the standard approach here."}
        ]$txt$,
        'B',
        $txt$For rational functions as $x\to\infty$, dividing by the highest power of $x$ is the standard method to determine the limit.$txt$,
        '{method_selection}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limits_at_infinity', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinity_degree_mistake' FROM new_question;


-- ============================================================
-- 1.7-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.7-P5', 'Both', 'Both_Limits', '1.7', '1.7', 'MCQ', FALSE,
        4, 300, '{method_selection,infinite_limits_asymptotes}', '{infinite_limit_meaning}', 'text',
        $txt$Which statement best describes $\lim_{x\to 0} \frac{1}{x^2}$?$txt$,
        $txt$Which statement best describes $\lim_{x\to 0} \frac{1}{x^2}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "The values do not approach 0; they grow large."},
          {"id": "B", "label": "B", "value": "$-\\infty$", "type": "text", "explanation": "The expression is always positive near 0, so it cannot approach $-\\infty$."},
          {"id": "C", "label": "C", "value": "$\\infty$", "type": "text", "explanation": "Correct: the function grows without bound as $x\\to 0$."},
          {"id": "D", "label": "D", "value": "DNE because the function is undefined at $x=0$", "type": "text", "explanation": "A limit can exist even if the function is not defined at the point."}
        ]$txt$,
        'C',
        $txt$As $x$ approaches 0 from either side, $x^2$ becomes a very small positive number, so $\frac{1}{x^2}$ increases without bound. The limit is $\infty$.$txt$,
        '{method_selection}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'infinite_limits_asymptotes', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinite_limit_meaning' FROM new_question;
