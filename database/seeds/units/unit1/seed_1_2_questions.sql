-- Insert Script for Chapter 1.2 Questions (Defining Limits and Using Limit Notation)
-- Unit: Both_Limits / 1.2

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.2-P1', '1.2-P2', '1.2-P3', '1.2-P4', '1.2-P5');

-- ============================================================
-- 1.2-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.2-P1', 'Both', 'Both_Limits', '1.2', '1.2', 'MCQ', FALSE,
        1, 120, '{limit_notation,limit_concept}', '{notation_misread}', 'text',
        $txt$Suppose $\lim_{x\to 2} f(x)=5$. Which statement must be true?$txt$,
        $txt$Suppose $\lim_{x\to 2} f(x)=5$. Which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(2)=5$", "type": "text", "explanation": "The limit can exist even if $f(2)$ is not defined or not equal to 5."},
          {"id": "B", "label": "B", "value": "As $x$ gets close to $2$, $f(x)$ gets close to $5$.", "type": "text", "explanation": "Correct: this is exactly what the limit statement means."},
          {"id": "C", "label": "C", "value": "$f(x)=5$ for all $x$ near $2$.", "type": "text", "explanation": "A limit does not require the function to be constant near the point."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 5} f(x)=2$", "type": "text", "explanation": "This changes both the input value and the limit value, so it is unrelated."}
        ]$txt$,
        'B',
        $txt$The statement $\lim_{x\to 2} f(x)=5$ means that as $x$ approaches $2$, the values of $f(x)$ approach $5$.$txt$,
        '{limit_notation}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Target time: 2 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_notation', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'notation_misread' FROM new_question;


-- ============================================================
-- 1.2-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.2-P2', 'Both', 'Both_Limits', '1.2', '1.2', 'MCQ', FALSE,
        2, 120, '{limit_notation,method_selection}', '{two_sided_requires_match}', 'text',
        $txt$If $\lim_{x\to 4^-} f(x)=2$ and $\lim_{x\to 4^+} f(x)=7$, what is $\lim_{x\to 4} f(x)$?$txt$,
        $txt$If $\lim_{x\to 4^-} f(x)=2$ and $\lim_{x\to 4^+} f(x)=7$, what is $\lim_{x\to 4} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "2", "type": "text", "explanation": "This is only the left-hand limit, not the two-sided limit."},
          {"id": "B", "label": "B", "value": "7", "type": "text", "explanation": "This is only the right-hand limit, not the two-sided limit."},
          {"id": "C", "label": "C", "value": "$\\frac{9}{2}$", "type": "text", "explanation": "A two-sided limit is not found by averaging the one-sided limits."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Correct: the one-sided limits do not match, so the limit is DNE."}
        ]$txt$,
        'D',
        $txt$A two-sided limit exists only if the left-hand and right-hand limits are equal. Since $2\ne 7$, the limit does not exist.$txt$,
        '{limit_notation}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_notation', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'two_sided_requires_match' FROM new_question;


-- ============================================================
-- 1.2-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.2-P3', 'Both', 'Both_Limits', '1.2', '1.2', 'MCQ', FALSE,
        2, 180, '{limit_notation,algebraic_simplification}', '{limit_vs_value}', 'text',
        $txt$Suppose $\lim_{x\to 1} f(x)=3$ and $f(1)=8$. What can be concluded?$txt$,
        $txt$Suppose $\lim_{x\to 1} f(x)=3$ and $f(1)=8$. What can be concluded?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(x)=3$ for all $x$ near 1.", "type": "text", "explanation": "A limit does not mean the function is constant near the point."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 1} f(x)=8$.", "type": "text", "explanation": "The limit is given as 3, not 8."},
          {"id": "C", "label": "C", "value": "$f$ is not continuous at $x=1$.", "type": "text", "explanation": "Correct: the limit value and function value are different, so the function is not continuous at 1."},
          {"id": "D", "label": "D", "value": "$f(1)$ must be undefined.", "type": "text", "explanation": "The function value is explicitly given as $f(1)=8$."}
        ]$txt$,
        'C',
        $txt$Continuity at $x=1$ requires $\lim_{x\to 1} f(x)=f(1)$. Here $\lim_{x\to 1} f(x)=3$ but $f(1)=8$, so $f$ is not continuous at $x=1$.$txt$,
        '{limit_notation}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_notation', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'limit_vs_value' FROM new_question;


-- ============================================================
-- 1.2-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.2-P4', 'Both', 'Both_Limits', '1.2', '1.2', 'MCQ', FALSE,
        3, 240, '{limit_estimation_table,limit_notation}', '{table_trend_misread}', 'text',
        $txt$A function $f$ is shown in the table. What is the best estimate of $\lim_{x\to 2} f(x)$?

\[
\begin{array}{c|cccc}
 x & 1.9 & 1.99 & 2.01 & 2.1 \\
\hline
 f(x) & 3.61 & 3.9601 & 4.0401 & 4.41
\end{array}
\]$txt$,
        $txt$A function $f$ is shown in the table. What is the best estimate of $\lim_{x\to 2} f(x)$?

\[
\begin{array}{c|cccc}
 x & 1.9 & 1.99 & 2.01 & 2.1 \\
\hline
 f(x) & 3.61 & 3.9601 & 4.0401 & 4.41
\end{array}
\]$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "3.96", "type": "text", "explanation": "This is a nearby value but not the best two-sided estimate."},
          {"id": "B", "label": "B", "value": "4", "type": "text", "explanation": "Correct: values near $x=2$ approach 4 from both sides."},
          {"id": "C", "label": "C", "value": "4.04", "type": "text", "explanation": "This is a nearby value but not the best two-sided estimate."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The table shows both sides approaching the same value, so the limit exists."}
        ]$txt$,
        'B',
        $txt$As $x$ approaches 2 from both sides, the values of $f(x)$ approach 4. The best estimate is 4.$txt$,
        '{limit_estimation_table}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_trend_misread' FROM new_question;


-- ============================================================
-- 1.2-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.2-P5', 'Both', 'Both_Limits', '1.2', '1.2', 'MCQ', FALSE,
        3, 240, '{limits_at_infinity,limit_laws}', '{infinity_degree_mistake}', 'text',
        $txt$Evaluate $\lim_{x\to \infty} \frac{3x^2+1}{x^2-5}$.$txt$,
        $txt$Evaluate $\lim_{x\to \infty} \frac{3x^2+1}{x^2-5}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "This would be true only if the numerator had lower degree than the denominator."},
          {"id": "B", "label": "B", "value": "3", "type": "text", "explanation": "Correct: ratio of leading coefficients is $\\frac{3}{1}=3$."},
          {"id": "C", "label": "C", "value": "$\\infty$", "type": "text", "explanation": "A rational function with equal degrees approaches a finite value, not infinity."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The limit exists and is finite."}
        ]$txt$,
        'B',
        $txt$Divide numerator and denominator by $x^2$: $\frac{3+\frac{1}{x^2}}{1-\frac{5}{x^2}}\to \frac{3}{1}=3$.$txt$,
        '{limits_at_infinity}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limits_at_infinity', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_laws', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinity_degree_mistake' FROM new_question;
