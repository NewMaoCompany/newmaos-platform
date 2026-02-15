-- Insert Script for Chapter 1.15 Questions (Connecting Limits at Infinity and Horizontal Asymptotes)
-- Unit: Both_Limits / 1.15

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.15-P1', '1.15-P2', '1.15-P3', '1.15-P4', '1.15-P5');

-- ============================================================
-- 1.15-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.15-P1', 'Both', 'Both_Limits', '1.15', '1.15', 'MCQ', FALSE,
        3, 240, '{limits_at_infinity,limit_laws}', '{infinity_degree_mistake}', 'text',
        $txt$Evaluate $\lim_{x\to \infty} \frac{4x^2-3}{2x^2+7x}$.$txt$,
        $txt$Evaluate $\lim_{x\to \infty} \frac{4x^2-3}{2x^2+7x}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "0 would occur if the denominator had higher degree, but degrees are equal here."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Correct: equal degree gives ratio of leading coefficients $4/2=2$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{2}$", "type": "text", "explanation": "This is the reciprocal of the correct ratio."},
          {"id": "D", "label": "D", "value": "$\\infty$", "type": "text", "explanation": "A rational function with equal degree approaches a finite value, not infinity."}
        ]$txt$,
        'B',
        $txt$Divide numerator and denominator by $x^2$: $\frac{4-3/x^2}{2+7/x}\to \frac{4}{2}=2$.$txt$,
        '{limits_at_infinity}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limits_at_infinity', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_laws', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinity_degree_mistake' FROM new_question;


-- ============================================================
-- 1.15-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.15-P2', 'Both', 'Both_Limits', '1.15', '1.15', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_estimation_graph}', '{asymptote_confusion}', 'text',
        $txt$Use the graph provided. What is the horizontal asymptote of the function?$txt$,
        $txt$Use the graph provided. What is the horizontal asymptote of the function?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$y=0$", "type": "text", "explanation": "The graph does not level off at 0."},
          {"id": "B", "label": "B", "value": "$y=1$", "type": "text", "explanation": "The graph levels off higher than 1."},
          {"id": "C", "label": "C", "value": "$y=2$", "type": "text", "explanation": "Correct: end behavior approaches 2."},
          {"id": "D", "label": "D", "value": "$y=5$", "type": "text", "explanation": "The graph does not approach 5 for large $|x|$."}
        ]$txt$,
        'C',
        $txt$From the graph, as $x\to \pm\infty$, the curve levels off at $y=2$. That is the horizontal asymptote.$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_graph', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'asymptote_confusion' FROM new_question;


-- ============================================================
-- 1.15-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.15-P3', 'Both', 'Both_Limits', '1.15', '1.15', 'MCQ', FALSE,
        4, 300, '{limits_at_infinity,method_selection}', '{wrong_method_choice}', 'text',
        $txt$Which method is most appropriate to evaluate $\lim_{x\to \infty} \frac{7x-5}{x^2+1}$?$txt$,
        $txt$Which method is most appropriate to evaluate $\lim_{x\to \infty} \frac{7x-5}{x^2+1}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Direct substitution", "type": "text", "explanation": "Substitution does not apply for $x\\to\\infty$."},
          {"id": "B", "label": "B", "value": "Divide by the highest power of $x$ in the denominator", "type": "text", "explanation": "Correct: dividing by $x^2$ reveals the limit is 0."},
          {"id": "C", "label": "C", "value": "Multiply by a conjugate", "type": "text", "explanation": "Conjugates are for radicals, not end behavior."},
          {"id": "D", "label": "D", "value": "Use IVT", "type": "text", "explanation": "IVT is unrelated to evaluating limits at infinity."}
        ]$txt$,
        'B',
        $txt$As $x\to\infty$ for rational functions, divide by the highest power of $x$ (here $x^2$). This shows the limit approaches 0.$txt$,
        '{limits_at_infinity}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limits_at_infinity', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice' FROM new_question;


-- ============================================================
-- 1.15-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.15-P4', 'Both', 'Both_Limits', '1.15', '1.15', 'MCQ', FALSE,
        3, 240, '{limit_estimation_table,limits_at_infinity}', '{table_trend_misread}', 'text',
        $txt$Use the table provided for $f(x)$. What is the most likely value of $\lim_{x\to \infty} f(x)$?$txt$,
        $txt$Use the table provided for $f(x)$. What is the most likely value of $\lim_{x\to \infty} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "The values are close to 3, not 0."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "The values are much larger than 1."},
          {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "Correct: the table indicates the function approaches 3."},
          {"id": "D", "label": "D", "value": "It increases without bound", "type": "text", "explanation": "The values are not growing without bound; they level off near 3."}
        ]$txt$,
        'C',
        $txt$The values in the table are approaching 3 as $x$ becomes large, so the limit at infinity is most likely 3.$txt$,
        '{limit_estimation_table}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'limits_at_infinity', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_trend_misread' FROM new_question;


-- ============================================================
-- 1.15-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.15-P5', 'Both', 'Both_Limits', '1.15', '1.15', 'MCQ', FALSE,
        5, 360, '{limits_at_infinity,infinite_limits_asymptotes}', '{asymptote_confusion}', 'text',
        $txt$A rational function has a horizontal asymptote $y=-2$. Which statement must be true?$txt$,
        $txt$A rational function has a horizontal asymptote $y=-2$. Which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to \\infty} f(x)=-2$ or $\\lim_{x\\to -\\infty} f(x)=-2$ (or both)", "type": "text", "explanation": "Correct: this is the definition of a horizontal asymptote."},
          {"id": "B", "label": "B", "value": "$f(x)=-2$ for all $x$", "type": "text", "explanation": "An asymptote is approached, not necessarily equal everywhere."},
          {"id": "C", "label": "C", "value": "$f(x)$ can never cross $y=-2$", "type": "text", "explanation": "Functions may cross horizontal asymptotes."},
          {"id": "D", "label": "D", "value": "$f$ has a vertical asymptote", "type": "text", "explanation": "Horizontal asymptotes do not imply vertical asymptotes."}
        ]$txt$,
        'A',
        $txt$A horizontal asymptote $y=L$ means the function approaches $L$ as $x\to\infty$ and/or $x\to -\infty$. It does not require the function to equal $L$.$txt$,
        '{limits_at_infinity}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limits_at_infinity', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'infinite_limits_asymptotes', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'asymptote_confusion' FROM new_question;
