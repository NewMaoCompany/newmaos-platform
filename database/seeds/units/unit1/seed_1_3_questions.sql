-- Insert Script for Chapter 1.3 Questions (Estimating Limit Values from Graphs)
-- Unit: Both_Limits / 1.3

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.3-P1', '1.3-P2', '1.3-P3', '1.3-P4', '1.3-P5');

-- ============================================================
-- 1.3-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.3-P1', 'Both', 'Both_Limits', '1.3', '1.3', 'MCQ', FALSE,
        2, 180, '{limit_estimation_graph,discontinuity_types}', '{open_vs_closed_point}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to 1} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to 1} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "2", "type": "text", "explanation": "Correct: the y-values approach 2 from both sides."},
          {"id": "B", "label": "B", "value": "4", "type": "text", "explanation": "This is the function value shown at $x=1$, not the limit."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "This confuses the x-value being approached with the limit value."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The left-hand and right-hand approaches match, so the limit exists."}
        ]$txt$,
        'A',
        $txt$From the graph, the curve approaches $y=2$ as $x\to 1$ from both sides, so the limit is 2.$txt$,
        '{limit_estimation_graph}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Target time: 2 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_graph', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'open_vs_closed_point' FROM new_question;


-- ============================================================
-- 1.3-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.3-P2', 'Both', 'Both_Limits', '1.3', '1.3', 'MCQ', FALSE,
        2, 180, '{limit_estimation_graph,discontinuity_types}', '{graph_jump_confusion}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to 0} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to 0} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "This is the left-hand limit only."},
          {"id": "B", "label": "B", "value": "3", "type": "text", "explanation": "This is the right-hand limit only."},
          {"id": "C", "label": "C", "value": "2", "type": "text", "explanation": "A two-sided limit is not found by averaging unequal one-sided limits."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Correct: one-sided limits differ, so the limit is DNE."}
        ]$txt$,
        'D',
        $txt$From the graph, $\lim_{x\to 0^-} f(x)=1$ and $\lim_{x\to 0^+} f(x)=3$. Since they are not equal, the two-sided limit does not exist.$txt$,
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
SELECT id, 'graph_jump_confusion' FROM new_question;


-- ============================================================
-- 1.3-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.3-P3', 'Both', 'Both_Limits', '1.3', '1.3', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_estimation_graph}', '{infinite_limit_meaning}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to 2^-} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to 2^-} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-\\infty$", "type": "text", "explanation": "Correct: the graph falls downward without bound as $x\\to 2^-$."},
          {"id": "B", "label": "B", "value": "$\\infty$", "type": "text", "explanation": "This has the wrong sign; the left side goes downward, not upward."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "1 is the horizontal asymptote value, not the behavior near $x=2$."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The limit is infinite, but it still has a well-defined behavior ($-\\infty$)."}
        ]$txt$,
        'A',
        $txt$As $x$ approaches 2 from the left, the graph decreases without bound. Therefore, the limit is $-\\infty$.$txt$,
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
SELECT id, 'infinite_limit_meaning' FROM new_question;


-- ============================================================
-- 1.3-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.3-P4', 'Both', 'Both_Limits', '1.3', '1.3', 'MCQ', FALSE,
        2, 180, '{limit_estimation_graph,limit_concept}', '{endpoint_domain_issue}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to -1^+} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to -1^+} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "Correct: the curve approaches the endpoint value $y=0$ from the right."},
          {"id": "B", "label": "B", "value": "$-1$", "type": "text", "explanation": "This confuses the x-value approached ($-1$) with the y-value."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "This is not consistent with the y-values shown near $x=-1$."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "A one-sided limit can exist at an endpoint; here it approaches 0."}
        ]$txt$,
        'A',
        $txt$From the graph, as $x$ approaches $-1$ from the right, the y-values approach 0. Therefore, the limit is 0.$txt$,
        '{limit_estimation_graph}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'endpoint_domain_issue' FROM new_question;


-- ============================================================
-- 1.3-P5 (Updated format to match user screenshot style: Grid Table)
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.3-P5', 'Both', 'Both_Limits', '1.3', '1.3', 'MCQ', FALSE,
        2, 180, '{limit_estimation_table,limit_concept}', '{table_trend_misread}', 'text',
        $txt$A function $f$ is shown in the table. What is the best estimate of $\lim_{x\to 5} f(x)$?

\[
\begin{array}{|c|c|c|c|c|}
\hline
 x & 4.9 & 4.99 & 5.01 & 5.1 \\
\hline
 f(x) & -2.10 & -2.01 & -1.99 & -1.90 \\
\hline
\end{array}
\]$txt$,
        $txt$A function $f$ is shown in the table. What is the best estimate of $\lim_{x\to 5} f(x)$?

\[
\begin{array}{|c|c|c|c|c|}
\hline
 x & 4.9 & 4.99 & 5.01 & 5.1 \\
\hline
 f(x) & -2.10 & -2.01 & -1.99 & -1.90 \\
\hline
\end{array}
\]$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-2$", "type": "text", "explanation": "Correct: nearby values from both sides are very close to $-2$."},
          {"id": "B", "label": "B", "value": "$-1.9$", "type": "text", "explanation": "This is a nearby value, but not the limit approached from both sides."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "0 is not supported by any of the table values."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The table indicates both sides approach the same value, so the limit exists."}
        ]$txt$,
        'A',
        $txt$Values of $f(x)$ near $x=5$ approach $-2$ from both sides, so the best estimate is $-2$.$txt$,
        '{limit_estimation_table}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_trend_misread' FROM new_question;
