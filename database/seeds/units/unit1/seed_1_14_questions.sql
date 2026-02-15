-- Insert Script for Chapter 1.14 Questions (Connecting Infinite Limits and Vertical Asymptotes)
-- Unit: Both_Limits / 1.14

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.14-P1', '1.14-P2', '1.14-P3', '1.14-P4', '1.14-P5');

-- ============================================================
-- 1.14-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.14-P1', 'Both', 'Both_Limits', '1.14', '1.14', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_estimation_graph}', '{asymptote_confusion}', 'text',
        $txt$Use the graph provided. Which statement is correct?$txt$,
        $txt$Use the graph provided. Which statement is correct?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 1^-} f(x)=\\infty$ and $\\lim_{x\\to 1^+} f(x)=\\infty$", "type": "text", "explanation": "Left side goes downward, not upward."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 1^-} f(x)=-\\infty$ and $\\lim_{x\\to 1^+} f(x)=\\infty$", "type": "text", "explanation": "Correct: opposite infinite behavior on the two sides."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 1^-} f(x)=0$ and $\\lim_{x\\to 1^+} f(x)=0$", "type": "text", "explanation": "The function does not approach 0 near the asymptote."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 1} f(x)$ exists and equals 1", "type": "text", "explanation": "With opposite infinite behavior, the two-sided limit does not exist."}
        ]$txt$,
        'B',
        $txt$The graph shows a vertical asymptote at $x=1$. The left side decreases without bound ($-\infty$) and the right side increases without bound ($\infty$).$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_graph', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'asymptote_confusion' FROM new_question;


-- ============================================================
-- 1.14-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.14-P2', 'Both', 'Both_Limits', '1.14', '1.14', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_concept}', '{infinite_limit_meaning}', 'text',
        $txt$Which statement best describes $\lim_{x\to 0} \frac{1}{x^2}$?$txt$,
        $txt$Which statement best describes $\lim_{x\to 0} \frac{1}{x^2}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "The values grow large, not toward 0."},
          {"id": "B", "label": "B", "value": "$-\\infty$", "type": "text", "explanation": "The expression is positive near 0, so it cannot approach $-\\infty$."},
          {"id": "C", "label": "C", "value": "$\\infty$", "type": "text", "explanation": "Correct: it increases without bound from both sides."},
          {"id": "D", "label": "D", "value": "DNE because the function is undefined at $x=0$", "type": "text", "explanation": "A limit may exist even if the function is undefined at the point."}
        ]$txt$,
        'C',
        $txt$As $x\to 0$, $x^2$ becomes a small positive number, so $1/x^2$ grows without bound in the positive direction. The limit is $\infty$.$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinite_limit_meaning' FROM new_question;


-- ============================================================
-- 1.14-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.14-P3', 'Both', 'Both_Limits', '1.14', '1.14', 'MCQ', FALSE,
        4, 300, '{infinite_limits_asymptotes,algebraic_simplification}', '{quotient_law_denominator_zero}', 'text',
        $txt$Which value of $x$ gives a vertical asymptote for $f(x)=\frac{x+1}{x^2-4}$?$txt$,
        $txt$Which value of $x$ gives a vertical asymptote for $f(x)=\frac{x+1}{x^2-4}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=-1$", "type": "text", "explanation": "At $x=-1$, the denominator is not 0."},
          {"id": "B", "label": "B", "value": "$x=0$", "type": "text", "explanation": "At $x=0$, the denominator is -4, not 0."},
          {"id": "C", "label": "C", "value": "$x=2$ and $x=-2$", "type": "text", "explanation": "Correct: denominator is 0 at $\\pm 2$ and nothing cancels."},
          {"id": "D", "label": "D", "value": "$x=4$", "type": "text", "explanation": "At $x=4$, the denominator is not 0."}
        ]$txt$,
        'C',
        $txt$Vertical asymptotes occur where the denominator is 0 and does not cancel. Here $x^2-4=(x-2)(x+2)$, so $x=2$ and $x=-2$ create vertical asymptotes.$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_law_denominator_zero' FROM new_question;


-- ============================================================
-- 1.14-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.14-P4', 'Both', 'Both_Limits', '1.14', '1.14', 'MCQ', FALSE,
        4, 300, '{infinite_limits_asymptotes,limit_estimation_graph}', '{infinite_limit_meaning}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to -2} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to -2} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\infty$", "type": "text", "explanation": "Correct: both sides approach positive infinity."},
          {"id": "B", "label": "B", "value": "$-\\infty$", "type": "text", "explanation": "The graph does not go downward without bound."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "The graph does not approach 0 near $x=-2$."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "An infinite limit here is a valid limit statement ($\\infty$)."}
        ]$txt$,
        'A',
        $txt$The graph shows a vertical asymptote at $x=-2$ and both sides rise upward without bound, so the limit is $\infty$.$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_graph', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'infinite_limit_meaning' FROM new_question;


-- ============================================================
-- 1.14-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.14-P5', 'Both', 'Both_Limits', '1.14', '1.14', 'MCQ', FALSE,
        5, 360, '{infinite_limits_asymptotes,limit_notation}', '{notation_misread}', 'text',
        $txt$Which statement correctly interprets $\lim_{x\to 3^-} f(x)=-\infty$?$txt$,
        $txt$Which statement correctly interprets $\lim_{x\to 3^-} f(x)=-\infty$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "As $x$ approaches 3 from the left, $f(x)$ decreases without bound.", "type": "text", "explanation": "Correct: left-hand approach and values go down without bound."},
          {"id": "B", "label": "B", "value": "As $x$ approaches 3 from the right, $f(x)$ decreases without bound.", "type": "text", "explanation": "This incorrectly uses the right-hand side."},
          {"id": "C", "label": "C", "value": "As $x$ approaches 3 from the left, $f(x)$ approaches 0.", "type": "text", "explanation": "$-\\infty$ does not mean approaching 0."},
          {"id": "D", "label": "D", "value": "As $x$ approaches 3, $f(3)$ must be undefined.", "type": "text", "explanation": "The function could be defined at 3; the statement only describes behavior near 3 from the left."}
        ]$txt$,
        'A',
        $txt$The notation $x\to 3^-$ means approaching 3 from values less than 3, and $-\infty$ means the function values decrease without bound.$txt$,
        '{infinite_limits_asymptotes}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'infinite_limits_asymptotes', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'notation_misread' FROM new_question;
