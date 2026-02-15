-- Insert Script for Chapter 1.6 Questions (Determining Limits Using Algebraic Manipulation)
-- Unit: Both_Limits / 1.6

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.6-P1', '1.6-P2', '1.6-P3', '1.6-P4', '1.6-P5');

-- ============================================================
-- 1.6-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.6-P1', 'Both', 'Both_Limits', '1.6', '1.6', 'MCQ', FALSE,
        2, 180, '{algebraic_simplification,method_selection}', '{factor_cancel_mistake}', 'text',
        $txt$Evaluate $\lim_{x\to 3} \frac{x^2-9}{x-3}$.$txt$,
        $txt$Evaluate $\lim_{x\to 3} \frac{x^2-9}{x-3}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "This comes from using $x^2-9=0$ at $x=3$ without simplification."},
          {"id": "B", "label": "B", "value": "3", "type": "text", "explanation": "This happens if the +3 is forgotten after cancellation."},
          {"id": "C", "label": "C", "value": "6", "type": "text", "explanation": "Correct: simplifies to $x+3$, so the limit is 6."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "After simplification, the limit exists."}
        ]$txt$,
        'C',
        $txt$Factor: $x^2-9=(x-3)(x+3)$. Cancel $(x-3)$ to get $x+3$. Substitute $x=3$ to get 6.$txt$,
        '{algebraic_simplification}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'algebraic_simplification', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'factor_cancel_mistake' FROM new_question;


-- ============================================================
-- 1.6-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.6-P2', 'Both', 'Both_Limits', '1.6', '1.6', 'MCQ', FALSE,
        3, 240, '{conjugate_rationalization,method_selection}', '{conjugate_setup_error}', 'text',
        $txt$Evaluate $\lim_{x\to 0} \frac{\sqrt{x+9}-3}{x}$.$txt$,
        $txt$Evaluate $\lim_{x\to 0} \frac{\sqrt{x+9}-3}{x}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{6}$", "type": "text", "explanation": "Correct: rationalizing gives $\\frac{1}{\\sqrt{x+9}+3}\\to\\frac{1}{6}$."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{3}$", "type": "text", "explanation": "This comes from substituting incorrectly in the denominator."},
          {"id": "C", "label": "C", "value": "6", "type": "text", "explanation": "This is the reciprocal of the correct answer."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "After rationalizing, the limit exists."}
        ]$txt$,
        'A',
        $txt$Multiply by the conjugate: $\frac{\sqrt{x+9}-3}{x}\cdot\frac{\sqrt{x+9}+3}{\sqrt{x+9}+3}=\frac{1}{\sqrt{x+9}+3}$. Substitute $x=0$ to get $\frac{1}{6}$.$txt$,
        '{conjugate_rationalization}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'conjugate_rationalization', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'conjugate_setup_error' FROM new_question;


-- ============================================================
-- 1.6-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.6-P3', 'Both', 'Both_Limits', '1.6', '1.6', 'MCQ', FALSE,
        3, 240, '{algebraic_simplification,limit_laws}', '{quotient_law_denominator_zero}', 'text',
        $txt$Evaluate $\lim_{x\to 1} \frac{x-1}{x^2-1}$.$txt$,
        $txt$Evaluate $\lim_{x\to 1} \frac{x-1}{x^2-1}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "0 comes from claiming $0/0$ becomes 0 without simplification."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{2}$", "type": "text", "explanation": "Correct: simplifies to $\\frac{1}{x+1}\\to\\frac{1}{2}$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{2x}$", "type": "text", "explanation": "This is the simplified expression written incorrectly as a final value."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "After cancellation, the limit exists."}
        ]$txt$,
        'B',
        $txt$Factor $x^2-1=(x-1)(x+1)$. Cancel $(x-1)$ to get $\frac{1}{x+1}$. Substitute $x=1$ to get $\frac{1}{2}$.$txt$,
        '{algebraic_simplification}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'algebraic_simplification', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_laws', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_law_denominator_zero' FROM new_question;


-- ============================================================
-- 1.6-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.6-P4', 'Both', 'Both_Limits', '1.6', '1.6', 'MCQ', FALSE,
        4, 300, '{algebraic_simplification,method_selection}', '{illegal_substitution_0over0}', 'text',
        $txt$Evaluate $\lim_{x\to 2} \frac{x^2-5x+6}{x-2}$.$txt$,
        $txt$Evaluate $\lim_{x\to 2} \frac{x^2-5x+6}{x-2}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-1$", "type": "text", "explanation": "Correct: simplifies to $x-3\\to-1$."},
          {"id": "B", "label": "B", "value": "0", "type": "text", "explanation": "0 often comes from stopping at $0/0$ or incorrect cancellation."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "1 is a common sign mistake after simplification."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "After simplification, the limit exists."}
        ]$txt$,
        'A',
        $txt$Factor $x^2-5x+6=(x-2)(x-3)$. Cancel $(x-2)$ to get $x-3$. Substitute $x=2$ to get $-1$.$txt$,
        '{algebraic_simplification}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'algebraic_simplification', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'illegal_substitution_0over0' FROM new_question;


-- ============================================================
-- 1.6-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.6-P5', 'Both', 'Both_Limits', '1.6', '1.6', 'MCQ', FALSE,
        4, 300, '{conjugate_rationalization,algebraic_simplification}', '{conjugate_setup_error}', 'text',
        $txt$Evaluate $\lim_{x\to 0} \frac{\sqrt{1+x}-1}{x}$.$txt$,
        $txt$Evaluate $\lim_{x\to 0} \frac{\sqrt{1+x}-1}{x}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{2}$", "type": "text", "explanation": "Correct: the simplified expression approaches $\\frac{1}{2}$."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "2 is the reciprocal of the correct limit."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{\\sqrt{1+x}+1}$", "type": "text", "explanation": "This is the simplified form, but not the final evaluated limit."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "After rationalizing, the limit exists."}
        ]$txt$,
        'A',
        $txt$Multiply by the conjugate: $\frac{\sqrt{1+x}-1}{x}\cdot\frac{\sqrt{1+x}+1}{\sqrt{1+x}+1}=\frac{1}{\sqrt{1+x}+1}$. Then substitute $x=0$ to get $\frac{1}{2}$.$txt$,
        '{conjugate_rationalization}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'conjugate_rationalization', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'conjugate_setup_error' FROM new_question;
