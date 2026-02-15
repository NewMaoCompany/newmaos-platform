-- Insert Script for Chapter 1.8 Questions (Determining Limits Using the Squeeze Theorem)
-- Unit: Both_Limits / 1.8

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.8-P1', '1.8-P2', '1.8-P3', '1.8-P4', '1.8-P5');

-- ============================================================
-- 1.8-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.8-P1', 'Both', 'Both_Limits', '1.8', '1.8', 'MCQ', FALSE,
        2, 180, '{squeeze_theorem,limit_concept}', '{wrong_method_choice}', 'text',
        $txt$Evaluate $\lim_{x\to 0} x^2\sin\left(\frac{1}{x}\right)$.$txt$,
        $txt$Evaluate $\lim_{x\to 0} x^2\sin\left(\frac{1}{x}\right)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-1$", "type": "text", "explanation": "The expression is squeezed to 0, not -1."},
          {"id": "B", "label": "B", "value": "0", "type": "text", "explanation": "Correct: the bounds force the limit to be 0."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "The expression does not approach 1; it shrinks to 0."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Although $\\sin(1/x)$ oscillates, multiplying by $x^2$ forces the limit to 0."}
        ]$txt$,
        'B',
        $txt$Since $-1\le\sin(1/x)\le 1$, we have $-x^2\le x^2\sin(1/x)\le x^2$. Both bounds approach 0 as $x\to 0$, so the limit is 0.$txt$,
        '{squeeze_theorem}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'squeeze_theorem', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice' FROM new_question;


-- ============================================================
-- 1.8-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.8-P2', 'Both', 'Both_Limits', '1.8', '1.8', 'MCQ', FALSE,
        2, 180, '{squeeze_theorem,limit_laws}', '{squeeze_bounds_incorrect}', 'text',
        $txt$Evaluate $\lim_{x\to 0} |x|\cos\left(\frac{1}{x}\right)$.$txt$,
        $txt$Evaluate $\lim_{x\to 0} |x|\cos\left(\frac{1}{x}\right)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-1$", "type": "text", "explanation": "The expression is forced toward 0 by the factor $|x|$."},
          {"id": "B", "label": "B", "value": "0", "type": "text", "explanation": "Correct: squeeze gives the limit 0."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "The value does not stay near 1; it shrinks to 0."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Oscillation alone does not prevent a limit if it is squeezed to a single value."}
        ]$txt$,
        'B',
        $txt$Because $-1\le \cos(1/x)\le 1$, we get $-|x|\le |x|\cos(1/x)\le |x|$. Both bounds approach 0, so the limit is 0.$txt$,
        '{squeeze_theorem}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'squeeze_theorem', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_laws', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'squeeze_bounds_incorrect' FROM new_question;


-- ============================================================
-- 1.8-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.8-P3', 'Both', 'Both_Limits', '1.8', '1.8', 'MCQ', FALSE,
        3, 240, '{squeeze_theorem,limit_concept}', '{squeeze_bounds_incorrect}', 'text',
        $txt$Evaluate $\lim_{x\to \infty} \frac{\sin x}{x}$.$txt$,
        $txt$Evaluate $\lim_{x\to \infty} \frac{\sin x}{x}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-1$", "type": "text", "explanation": "The expression shrinks toward 0 because the denominator grows without bound."},
          {"id": "B", "label": "B", "value": "0", "type": "text", "explanation": "Correct: it is squeezed between $\\pm 1/x$ which go to 0."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "The expression does not stay near 1."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Even though $\\sin x$ oscillates, the factor $1/x$ forces the limit to 0."}
        ]$txt$,
        'B',
        $txt$Since $-1\le \sin x\le 1$, dividing by $x>0$ (for large $x$) gives $-\frac{1}{x}\le \frac{\sin x}{x}\le \frac{1}{x}$. Both bounds approach 0 as $x\to\infty$, so the limit is 0.$txt$,
        '{squeeze_theorem}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'squeeze_theorem', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'squeeze_bounds_incorrect' FROM new_question;


-- ============================================================
-- 1.8-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.8-P4', 'Both', 'Both_Limits', '1.8', '1.8', 'MCQ', FALSE,
        3, 240, '{squeeze_theorem,method_selection}', '{wrong_method_choice}', 'text',
        $txt$Evaluate $\lim_{x\to 0} x\sin\left(\frac{1}{x^2}\right)$.$txt$,
        $txt$Evaluate $\lim_{x\to 0} x\sin\left(\frac{1}{x^2}\right)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "Correct: squeezed between $-x$ and $x$ which go to 0."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "The expression does not approach 1; it shrinks toward 0."},
          {"id": "C", "label": "C", "value": "$-1$", "type": "text", "explanation": "It cannot approach -1 because the factor $x$ goes to 0."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Oscillation does not prevent the squeeze limit from existing."}
        ]$txt$,
        'A',
        $txt$Because $-1\le \sin(1/x^2)\le 1$, we have $-x\le x\sin(1/x^2)\le x$. Both bounds approach 0 as $x\to 0$, so the limit is 0.$txt$,
        '{squeeze_theorem}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'squeeze_theorem', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice' FROM new_question;


-- ============================================================
-- 1.8-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.8-P5', 'Both', 'Both_Limits', '1.8', '1.8', 'MCQ', FALSE,
        4, 300, '{squeeze_theorem,limit_concept}', '{squeeze_bounds_incorrect}', 'text',
        $txt$Evaluate $\lim_{x\to 0} \frac{x^2\cos\left(\frac{1}{x}\right)}{|x|}$.$txt$,
        $txt$Evaluate $\lim_{x\to 0} \frac{x^2\cos\left(\frac{1}{x}\right)}{|x|}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "Correct: it simplifies to a squeezed expression approaching 0."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "The factor $|x|$ forces the expression to 0, not 1."},
          {"id": "C", "label": "C", "value": "$-1$", "type": "text", "explanation": "The expression cannot approach -1 because it shrinks in magnitude to 0."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The squeeze theorem guarantees the limit exists and equals 0."}
        ]$txt$,
        'A',
        $txt$Rewrite as $\frac{x^2}{|x|}\cos(1/x)=|x|\cos(1/x)$. Since $-1\le\cos(1/x)\le 1$, we have $-|x|\le |x|\cos(1/x)\le |x|$, so the limit is 0.$txt$,
        '{squeeze_theorem}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'squeeze_theorem', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'squeeze_bounds_incorrect' FROM new_question;
