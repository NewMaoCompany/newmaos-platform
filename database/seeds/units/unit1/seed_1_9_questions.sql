-- Insert Script for Chapter 1.9 Questions (Connecting Multiple Representations of Limits)
-- Unit: Both_Limits / 1.9

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.9-P1', '1.9-P2', '1.9-P3', '1.9-P4', '1.9-P5');

-- ============================================================
-- 1.9-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.9-P1', 'Both', 'Both_Limits', '1.9', '1.9', 'MCQ', FALSE,
        3, 240, '{limit_estimation_table,continuity_concept}', '{limit_vs_value}', 'text',
        $txt$A function $f$ is shown in the table and it is known that $f(2)=7$. What can be concluded about $\lim_{x\to 2} f(x)$ and continuity at $x=2$?$txt$,
        $txt$A function $f$ is shown in the table and it is known that $f(2)=7$. What can be concluded about $\lim_{x\to 2} f(x)$ and continuity at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 2} f(x)=7$ and $f$ is continuous at $x=2$", "type": "text", "explanation": "7 is the function value at $x=2$, not the limit from nearby x-values."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 2} f(x)=3$ and $f$ is continuous at $x=2$", "type": "text", "explanation": "Continuity would require $f(2)=3$, but it is 7."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 2} f(x)=3$ and $f$ is not continuous at $x=2$", "type": "text", "explanation": "Correct: the limit is 3 but the function value is 7, so not continuous."},
          {"id": "D", "label": "D", "value": "The limit does not exist", "type": "text", "explanation": "The table shows a clear two-sided approach to 3, so the limit exists."}
        ]$txt$,
        'C',
        $txt$The table shows $f(x)$ approaches 3 as $x\to 2$. Since $f(2)=7\ne 3$, the function is not continuous at $x=2$.$txt$,
        '{limit_estimation_table}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'limit_vs_value' FROM new_question;


-- ============================================================
-- 1.9-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.9-P2', 'Both', 'Both_Limits', '1.9', '1.9', 'MCQ', FALSE,
        2, 180, '{limit_estimation_graph,discontinuity_types}', '{open_vs_closed_point}', 'text',
        $txt$Use the graph provided. Which statement is true?$txt$,
        $txt$Use the graph provided. Which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 1} f(x)=5$ and $f(1)=5$", "type": "text", "explanation": "This confuses the function value with the limit value."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 1} f(x)=2$ and $f(1)=5$", "type": "text", "explanation": "Correct: limit is 2 (hole), but function value is 5 (filled dot)."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 1} f(x)=5$ and $f(1)=2$", "type": "text", "explanation": "This swaps the limit and function value."},
          {"id": "D", "label": "D", "value": "The limit does not exist at $x=1$", "type": "text", "explanation": "The left and right approaches match, so the limit exists."}
        ]$txt$,
        'B',
        $txt$From the graph, the curve approaches 2 as $x\to 1$, but the filled point shows $f(1)=5$.$txt$,
        '{limit_estimation_graph}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'open_vs_closed_point' FROM new_question;


-- ============================================================
-- 1.9-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.9-P3', 'Both', 'Both_Limits', '1.9', '1.9', 'MCQ', FALSE,
        3, 240, '{algebraic_simplification,discontinuity_types}', '{factor_cancel_mistake}', 'text',
        $txt$Let $f(x)=\frac{x^2-1}{x-1}$ for $x\ne 1$. What is $\lim_{x\to 1} f(x)$?$txt$,
        $txt$Let $f(x)=\frac{x^2-1}{x-1}$ for $x\ne 1$. What is $\lim_{x\to 1} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "0 comes from incorrectly substituting into the unsimplified $0/0$ form."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "1 is a common arithmetic mistake after simplification."},
          {"id": "C", "label": "C", "value": "2", "type": "text", "explanation": "Correct: simplified function approaches 2."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The limit exists after cancellation."}
        ]$txt$,
        'C',
        $txt$Factor $x^2-1=(x-1)(x+1)$, cancel $(x-1)$, and get $f(x)=x+1$ for $x\ne 1$. Then the limit is $1+1=2$.$txt$,
        '{algebraic_simplification}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'algebraic_simplification', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'factor_cancel_mistake' FROM new_question;


-- ============================================================
-- 1.9-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.9-P4', 'Both', 'Both_Limits', '1.9', '1.9', 'MCQ', FALSE,
        2, 180, '{ivt_application,continuity_concept}', '{ivt_missing_continuity}', 'text',
        $txt$A function $f$ is continuous on the interval $[0,2]$. If $f(0)=-1$ and $f(2)=3$, which statement must be true?$txt$,
        $txt$A function $f$ is continuous on the interval $[0,2]$. If $f(0)=-1$ and $f(2)=3$, which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(x)=1$ for all $x$ in $[0,2]$", "type": "text", "explanation": "Continuity does not imply the function is constant."},
          {"id": "B", "label": "B", "value": "There exists a number $c$ in $(0,2)$ such that $f(c)=0$", "type": "text", "explanation": "Correct: IVT guarantees a root because 0 lies between -1 and 3."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 1} f(x)$ does not exist", "type": "text", "explanation": "Continuity implies the limit exists at interior points."},
          {"id": "D", "label": "D", "value": "$f(1)=0$", "type": "text", "explanation": "IVT guarantees some $c$ in $(0,2)$, not necessarily $x=1$."}
        ]$txt$,
        'B',
        $txt$Because $f$ is continuous and changes sign from -1 to 3, the Intermediate Value Theorem guarantees at least one value $c$ where $f(c)=0$.$txt$,
        '{ivt_application}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ivt_application', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'ivt_missing_continuity' FROM new_question;


-- ============================================================
-- 1.9-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.9-P5', 'Both', 'Both_Limits', '1.9', '1.9', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_estimation_graph}', '{asymptote_confusion}', 'text',
        $txt$Use the graph provided. Which statement is correct?$txt$,
        $txt$Use the graph provided. Which statement is correct?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 2^-} f(x)=\\infty$ and $\\lim_{x\\to 2^+} f(x)=\\infty$", "type": "text", "explanation": "The left side goes downward, not upward."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 2^-} f(x)=-\\infty$ and $\\lim_{x\\to 2^+} f(x)=\\infty$", "type": "text", "explanation": "Correct: left-hand limit is $-\\infty$ and right-hand limit is $\\infty$."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 2^-} f(x)=0$ and $\\lim_{x\\to 2^+} f(x)=0$", "type": "text", "explanation": "The graph does not approach 0 near $x=2$."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 2} f(x)$ exists and equals 1", "type": "text", "explanation": "With opposite infinite behaviors, the two-sided limit does not exist."}
        ]$txt$,
        'B',
        $txt$From the graph, the function decreases without bound as $x\to 2^-$ and increases without bound as $x\to 2^+$, so the one-sided infinite limits have opposite signs.$txt$,
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
