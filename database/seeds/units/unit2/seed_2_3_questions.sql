-- Insert Script for Unit 2.3 Questions (Estimating Derivatives)
-- Unit: ABBC_Derivatives / 2.3

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.3-P1', 'U2.3-P2', 'U2.3-P3', 'U2.3-P4', 'U2.3-P5');

-- ============================================================
-- U2.3-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.3-P1', 'Both', 'ABBC_Derivatives', '2.3', '2.3', 'MCQ', FALSE,
        3, 120, '{derivative_from_graph}', '{slope_from_graph_misread}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.3-P1_graph.png)

The graph of $y=f(x)$ is shown, along with the tangent line at $x=2$. What is the best estimate of $f'(2)$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.3-P1_graph.png)

The graph of $y=f(x)$ is shown, along with the tangent line at $x=2$. What is the best estimate of $f'(2)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "This underestimates the steepness of the tangent line."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Correct. f'(2) matches the tangent slope, about 2."},
          {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "This is steeper than the tangent line shown."},
          {"id": "D", "label": "D", "value": "4", "type": "text", "explanation": "This is much steeper than the tangent line shown."}
        ]$txt$,
        'B',
        $txt$The derivative $f'(2)$ is the slope of the tangent line at $x=2$. From the graph, the tangent line rises about 2 units for every 1 unit to the right, so the best estimate is 2.$txt$,
        '{derivative_from_graph}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Use file U2_1769404469_2.3-P1_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_from_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'slope_from_graph_misread' FROM new_question;

-- ============================================================
-- U2.3-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.3-P2', 'Both', 'ABBC_Derivatives', '2.3', '2.3', 'MCQ', FALSE,
        4, 180, '{derivative_from_table}', '{table_derivative_estimate_error}', 'image',
        $txt$![Table](/assets/U2_1769404469_2.3-P2_table.png)

The table gives values of $f(x)$. Use the table to estimate $f'(3)$.$txt$,
        $txt$![Table](/assets/U2_1769404469_2.3-P2_table.png)

The table gives values of $f(x)$. Use the table to estimate $f'(3)$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "-2", "type": "text", "explanation": "This is too negative compared with the near-symmetric table values."},
          {"id": "B", "label": "B", "value": "-0.5", "type": "text", "explanation": "This is still too negative; the values suggest almost no change near x=3."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "Correct. The table suggests the slope near x=3 is approximately 0."},
          {"id": "D", "label": "D", "value": "2", "type": "text", "explanation": "This is too positive compared with the table trend."}
        ]$txt$,
        'C',
        $txt$To estimate $f'(3)$, use a symmetric slope with points close to 3, such as $x=2.99$ and $x=3.01$. The function values are nearly equal on both sides, giving a slope close to 0, so $f'(3) \approx 0$.$txt$,
        '{derivative_from_table}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Use file U2_1769404469_2.3-P2_table.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_from_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'difference_quotient', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_derivative_estimate_error' FROM new_question;

-- ============================================================
-- U2.3-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.3-P3', 'Both', 'ABBC_Derivatives', '2.3', '2.3', 'MCQ', FALSE,
        2, 90, '{derivative_from_graph}', '{slope_from_graph_misread}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.3-P3_graph.png)

The graph of $y=g(x)$ is shown, along with the tangent line at $x=1$. What is $g'(1)$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.3-P3_graph.png)

The graph of $y=g(x)$ is shown, along with the tangent line at $x=1$. What is $g'(1)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "-2", "type": "text", "explanation": "The tangent is not decreasing at x=1; it is flat."},
          {"id": "B", "label": "B", "value": "-1", "type": "text", "explanation": "The tangent is not decreasing; it is horizontal."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "Correct. The slope of a horizontal tangent line is 0."},
          {"id": "D", "label": "D", "value": "2", "type": "text", "explanation": "A positive slope would tilt upward, but the tangent is flat."}
        ]$txt$,
        'C',
        $txt$The tangent line drawn at $x=1$ is horizontal. A horizontal tangent has slope 0, so $g'(1)=0$.$txt$,
        '{derivative_from_graph}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Use file U2_1769404469_2.3-P3_graph.png', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_from_graph', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'slope_from_graph_misread' FROM new_question;

-- ============================================================
-- U2.3-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.3-P4', 'Both', 'ABBC_Derivatives', '2.3', '2.3', 'MCQ', FALSE,
        4, 150, '{derivative_from_graph}', '{tangent_line_point_confusion}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.3-P4_graph.png)

The graph of $y=h(x)$ is shown, along with the tangent line at $x=0$. What is the best estimate of $h'(0)$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.3-P4_graph.png)

The graph of $y=h(x)$ is shown, along with the tangent line at $x=0$. What is the best estimate of $h'(0)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0", "type": "text", "explanation": "The tangent line is not horizontal; it has a small positive slope."},
          {"id": "B", "label": "B", "value": "0.3", "type": "text", "explanation": "Correct. The tangent line shows a small positive slope, about 0.3."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "This is too steep for the tangent line shown."},
          {"id": "D", "label": "D", "value": "3", "type": "text", "explanation": "This is far too steep for the tangent line shown."}
        ]$txt$,
        'B',
        $txt$The derivative $h''(0)$ is the slope of the tangent line drawn at $x=0$. The tangent line rises a small amount compared to its run, giving a slope close to 0.3.$txt$,
        '{derivative_from_graph}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Use file U2_1769404469_2.3-P4_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_from_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_derivatives', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'tangent_line_point_confusion' FROM new_question;

-- ============================================================
-- U2.3-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.3-P5', 'Both', 'ABBC_Derivatives', '2.3', '2.3', 'MCQ', FALSE,
        5, 210, '{derivative_from_graph}', '{slope_from_graph_misread}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.3-P5_graph.png)

The graph of $y=p(x)$ is shown, along with the tangent line at $x=4$. What is the best estimate of $p'(4)$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.3-P5_graph.png)

The graph of $y=p(x)$ is shown, along with the tangent line at $x=4$. What is the best estimate of $p'(4)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "-1.2", "type": "text", "explanation": "This is too steep downward compared to the tangent line shown."},
          {"id": "B", "label": "B", "value": "-0.3", "type": "text", "explanation": "Correct. The tangent line shows a small negative slope, about -0.3."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "The tangent is not horizontal; it is decreasing."},
          {"id": "D", "label": "D", "value": "0.3", "type": "text", "explanation": "The tangent is decreasing, so the slope cannot be positive."}
        ]$txt$,
        'B',
        $txt$p''(4) is the slope of the tangent line at $x=4$. The tangent line is slightly decreasing (negative) and not steep, so the best estimate is about -0.3.$txt$,
        '{derivative_from_graph}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, 'Use file U2_1769404469_2.3-P5_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_from_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'slope_from_graph_misread' FROM new_question;
