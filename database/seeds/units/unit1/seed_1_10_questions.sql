-- Insert Script for Chapter 1.10 Questions (Exploring Types of Discontinuities)
-- Unit: Both_Limits / 1.10

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.10-P1', '1.10-P2', '1.10-P3', '1.10-P4', '1.10-P5');

-- ============================================================
-- 1.10-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.10-P1', 'Both', 'Both_Limits', '1.10', '1.10', 'MCQ', FALSE,
        2, 210, '{discontinuity_types,limit_estimation_graph}', '{open_vs_closed_point}', 'text',
        $txt$Use the graph provided. What type of discontinuity does $f$ have at $x=1$?$txt$,
        $txt$Use the graph provided. What type of discontinuity does $f$ have at $x=1$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Removable discontinuity", "type": "text", "explanation": "Correct: the limit exists but $f(1)$ does not match the limiting value."},
          {"id": "B", "label": "B", "value": "Jump discontinuity", "type": "text", "explanation": "A jump would require different left and right limits, which is not the case here."},
          {"id": "C", "label": "C", "value": "Infinite discontinuity", "type": "text", "explanation": "An infinite discontinuity would involve a vertical asymptote, which is not shown."},
          {"id": "D", "label": "D", "value": "No discontinuity (continuous)", "type": "text", "explanation": "The function is not continuous because the filled point does not match the hole."}
        ]$txt$,
        'A',
        $txt$The left- and right-hand limits agree at $x=1$ (there is a hole), but the function value at $x=1$ is defined at a different $y$-value. That is a removable discontinuity.$txt$,
        '{discontinuity_types}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3.5 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'discontinuity_types', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_graph', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'open_vs_closed_point' FROM new_question;


-- ============================================================
-- 1.10-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.10-P2', 'Both', 'Both_Limits', '1.10', '1.10', 'MCQ', FALSE,
        2, 180, '{limit_estimation_graph,limit_concept}', '{graph_jump_confusion}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to 0} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to 0} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "1 is the left-hand limit only, not the two-sided limit."},
          {"id": "B", "label": "B", "value": "3", "type": "text", "explanation": "3 is the right-hand limit only, not the two-sided limit."},
          {"id": "C", "label": "C", "value": "2", "type": "text", "explanation": "2 is not approached from either side in the graph."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "Correct: left and right limits do not match, so the limit does not exist."}
        ]$txt$,
        'D',
        $txt$From the graph, $\lim_{x\to 0^-} f(x)=1$ and $\lim_{x\to 0^+} f(x)=3$. Since these one-sided limits are not equal, the two-sided limit does not exist.$txt$,
        '{limit_estimation_graph}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'graph_jump_confusion' FROM new_question;


-- ============================================================
-- 1.10-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.10-P3', 'Both', 'Both_Limits', '1.10', '1.10', 'MCQ', FALSE,
        3, 240, '{infinite_limits_asymptotes,limit_estimation_graph}', '{infinite_limit_meaning}', 'text',
        $txt$Use the graph provided. What is $\lim_{x\to 2} f(x)$?$txt$,
        $txt$Use the graph provided. What is $\lim_{x\to 2} f(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\infty$", "type": "text", "explanation": "Correct: both sides rise upward without bound as $x$ approaches 2."},
          {"id": "B", "label": "B", "value": "$-\\infty$", "type": "text", "explanation": "The graph does not decrease without bound; it increases."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "The graph does not approach 0 near $x=2$."},
          {"id": "D", "label": "D", "value": "DNE", "type": "text", "explanation": "The limit is an infinite limit ($\\infty$), which is a valid limit statement here."}
        ]$txt$,
        'A',
        $txt$The graph shows a vertical asymptote at $x=2$ and the function increases without bound on both sides as $x\to 2$. Therefore $\lim_{x\to 2} f(x)=\infty$.$txt$,
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
-- 1.10-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.10-P4', 'Both', 'Both_Limits', '1.10', '1.10', 'MCQ', FALSE,
        3, 240, '{discontinuity_types,limit_concept}', '{two_sided_requires_match}', 'text',
        $txt$For the function $g(x)=\frac{|x|}{x}$, what is true about $\lim_{x\to 0} g(x)$?$txt$,
        $txt$For the function $g(x)=\frac{|x|}{x}$, what is true about $\lim_{x\to 0} g(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The limit equals 1", "type": "text", "explanation": "That is the right-hand limit only."},
          {"id": "B", "label": "B", "value": "The limit equals -1", "type": "text", "explanation": "That is the left-hand limit only."},
          {"id": "C", "label": "C", "value": "The limit equals 0", "type": "text", "explanation": "The function does not approach 0 from either side."},
          {"id": "D", "label": "D", "value": "The limit does not exist", "type": "text", "explanation": "Correct: left and right limits do not match."}
        ]$txt$,
        'D',
        $txt$As $x\to 0^+$, $g(x)=1$. As $x\to 0^-$, $g(x)=-1$. Since the one-sided limits are different, the two-sided limit does not exist.$txt$,
        '{discontinuity_types}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'discontinuity_types', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'two_sided_requires_match' FROM new_question;


-- ============================================================
-- 1.10-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.10-P5', 'Both', 'Both_Limits', '1.10', '1.10', 'MCQ', FALSE,
        4, 300, '{continuity_concept,algebraic_simplification}', '{continuity_three_conditions_miss}', 'text',
        $txt$For what value of $k$ is the function $f(x)=\begin{cases} \frac{x^2-1}{x-1}, & x\ne 1 \\ k, & x=1 \end{cases}$ continuous at $x=1$?$txt$,
        $txt$For what value of $k$ is the function $f(x)=\begin{cases} \frac{x^2-1}{x-1}, & x\ne 1 \\ k, & x=1 \end{cases}$ continuous at $x=1$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$k=0$", "type": "text", "explanation": "0 would not match the limiting value 2."},
          {"id": "B", "label": "B", "value": "$k=1$", "type": "text", "explanation": "1 would not match the limiting value 2."},
          {"id": "C", "label": "C", "value": "$k=2$", "type": "text", "explanation": "Correct: the limit is 2, so $f(1)$ must be 2."},
          {"id": "D", "label": "D", "value": "$k$ can be any real number", "type": "text", "explanation": "Continuity forces a single value of $k$."}
        ]$txt$,
        'C',
        $txt$For continuity at $x=1$, we need $\lim_{x\to 1} \frac{x^2-1}{x-1}=f(1)=k$. Since $\frac{x^2-1}{x-1}=x+1$ for $x\ne 1$, the limit is $2$, so $k=2$.$txt$,
        '{continuity_concept}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'continuity_three_conditions_miss' FROM new_question;
