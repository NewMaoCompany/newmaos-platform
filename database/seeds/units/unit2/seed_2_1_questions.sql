-- Insert Script for Unit 2.1 Questions (Derivatives / Rates of Change)
-- Unit: ABBC_Derivatives / 2.1

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.1-P1', 'U2.1-P2', 'U2.1-P3', 'U2.1-P4', 'U2.1-P5');

-- ============================================================
-- U2.1-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.1-P1', 'Both', 'ABBC_Derivatives', '2.1', '2.1', 'MCQ', FALSE,
        2, 90, '{slope_avg_rate}', '{average_rate_wrong_interval}', 'text',
        $txt$A particle’s position is given by $s(t) = t^2 + 1$, where $s$ is measured in meters and $t$ is measured in seconds. What is the average rate of change of $s$ over the interval $2 \le t \le 5$?$txt$,
        $txt$A particle’s position is given by $s(t)=t^2+1$, where $s$ is measured in meters and $t$ is measured in seconds. What is the average rate of change of $s$ over the interval $2\le t\le 5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "7", "type": "text", "explanation": "Correct. The slope of the secant line from t=2 to t=5 is 7."},
          {"id": "B", "label": "B", "value": "9", "type": "text", "explanation": "This would come from mixing up values or using the wrong interval endpoints."},
          {"id": "C", "label": "C", "value": "14", "type": "text", "explanation": "This is too large and does not match the secant slope on 2 ≤ t ≤ 5."},
          {"id": "D", "label": "D", "value": "21", "type": "text", "explanation": "This is the numerator s(5)−s(2)=21, but it is not divided by the time length."}
        ]$txt$,
        'A',
        $txt$Average rate of change over $2 \le t \le 5$ is $\frac{s(5) - s(2)}{5 - 2}$. We have $s(5)=26$ and $s(2)=5$, so the average rate is $\frac{26-5}{3} = \frac{21}{3} = 7$.$txt$,
        '{slope_avg_rate}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'slope_avg_rate', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'average_rate_wrong_interval' FROM new_question;

-- ============================================================
-- U2.1-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.1-P2', 'Both', 'ABBC_Derivatives', '2.1', '2.1', 'MCQ', FALSE,
        3, 120, '{slope_instant_rate,slope_avg_rate}', '{secant_vs_tangent_confusion}', 'image',
        $txt$The graph of $s(t)$ is shown. The secant line from $t=1$ to $t=3$ and the tangent line at $t=2$ are also shown. Which value best represents the instantaneous rate of change of $s$ at $t=2$?$txt$,
        $txt$The graph of $s(t)$ is shown. The secant line from $t=1$ to $t=3$ and the tangent line at $t=2$ are also shown. Which value best represents the instantaneous rate of change of $s$ at $t=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "2", "type": "text", "explanation": "This is too small for the slope of the tangent line at t=2 on the given graph."},
          {"id": "B", "label": "B", "value": "4", "type": "text", "explanation": "Correct. The instantaneous rate is the tangent slope at t=2, which is 4."},
          {"id": "C", "label": "C", "value": "6", "type": "text", "explanation": "This is closer to the secant slope from t=1 to t=3 on some curves, not the tangent slope here."},
          {"id": "D", "label": "D", "value": "8", "type": "text", "explanation": "This overestimates the steepness of the tangent line at t=2."}
        ]$txt$,
        'B',
        $txt$Instantaneous rate of change at $t=2$ is the slope of the tangent line shown at $t=2$. From the graph, the tangent line rises 4 units for each 1 unit increase in $t$ near $t=2$, so the slope is 4.$txt$,
        '{slope_instant_rate}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Use file U2_1769403109_2.1-P2_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'slope_instant_rate', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'slope_avg_rate', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'secant_vs_tangent_confusion' FROM new_question;

-- ============================================================
-- U2.1-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.1-P3', 'Both', 'ABBC_Derivatives', '2.1', '2.1', 'MCQ', FALSE,
        3, 120, '{interpret_derivative_context,slope_instant_rate}', '{secant_vs_tangent_confusion}', 'text',
        $txt$At time $t=4$ seconds, the instantaneous rate of change of the position $s(t)$ is $12$ meters per second. Which statement best describes what this means?$txt$,
        $txt$At time $t=4$ seconds, the instantaneous rate of change of the position $s(t)$ is $12$ meters per second. Which statement best describes what this means?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The particle’s position is 12 meters at t=4.", "type": "text", "explanation": "This confuses a rate with a function value (position)."},
          {"id": "B", "label": "B", "value": "The particle’s average velocity from t=0 to t=4 is 12.", "type": "text", "explanation": "This confuses instantaneous velocity with an average over an interval."},
          {"id": "C", "label": "C", "value": "The particle’s velocity at exactly t=4 is 12.", "type": "text", "explanation": "Correct. Instantaneous rate of change of position is velocity at that moment."},
          {"id": "D", "label": "D", "value": "The particle will travel exactly 12 meters during the next second.", "type": "text", "explanation": "A rate does not guarantee the exact distance in the next second because velocity can change."}
        ]$txt$,
        'C',
        $txt$Instantaneous rate of change of position at $t=4$ is the velocity at that exact moment. It does not directly give the position, a full-interval average, or an exact distance traveled over the next second.$txt$,
        '{interpret_derivative_context}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'interpret_derivative_context', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'slope_instant_rate', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'secant_vs_tangent_confusion' FROM new_question;

-- ============================================================
-- U2.1-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.1-P4', 'Both', 'ABBC_Derivatives', '2.1', '2.1', 'MCQ', FALSE,
        4, 150, '{difference_quotient,slope_avg_rate}', '{difference_quotient_setup_error}', 'text',
        $txt$Let $f(x) = x^2 - 3x$. Which expression represents the average rate of change of $f$ on the interval $[a, a+h]$?$txt$,
        $txt$Let $f(x)=x^2-3x$. Which expression represents the average rate of change of $f$ on the interval $[a, a+h]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(a+h) - f(a)$", "type": "text", "explanation": "This is only the change in output, not divided by the change in input."},
          {"id": "B", "label": "B", "value": "$\\frac{f(a+h) - f(a)}{h}$", "type": "text", "explanation": "Correct. Divide the change in f by the change in x, which is h."},
          {"id": "C", "label": "C", "value": "$\\frac{f(a) - f(a+h)}{h}$", "type": "text", "explanation": "This reverses the subtraction order and would give the negative of the correct slope."},
          {"id": "D", "label": "D", "value": "$\\frac{f(a)}{h}$", "type": "text", "explanation": "This does not represent a difference quotient."}
        ]$txt$,
        'B',
        $txt$Average rate of change on $[a, a+h]$ is the slope of the secant line: $\frac{f(a+h) - f(a)}{(a+h) - a} = \frac{f(a+h) - f(a)}{h}$.$txt$,
        '{difference_quotient}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'difference_quotient', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'slope_avg_rate', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'difference_quotient_setup_error' FROM new_question;

-- ============================================================
-- U2.1-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.1-P5', 'Both', 'ABBC_Derivatives', '2.1', '2.1', 'MCQ', FALSE,
        4, 180, '{derivative_from_table,difference_quotient}', '{table_derivative_estimate_error}', 'image',
        $txt$The table gives values of $s(t)$. Use the table to estimate the instantaneous rate of change of $s$ at $t=4$.$txt$,
        $txt$The table gives values of $s(t)$. Use the table to estimate the instantaneous rate of change of $s$ at $t=4$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "4", "type": "text", "explanation": "This is too small compared to the slope suggested by the nearby table values."},
          {"id": "B", "label": "B", "value": "6", "type": "text", "explanation": "This underestimates the slope; the data near 4 shows a steeper change."},
          {"id": "C", "label": "C", "value": "8", "type": "text", "explanation": "Correct. A symmetric estimate near t=4 gives a slope close to 8."},
          {"id": "D", "label": "D", "value": "10", "type": "text", "explanation": "This overestimates the slope compared to the nearby table trend."}
        ]$txt$,
        'C',
        $txt$To estimate the instantaneous rate at $t=4$, use a symmetric secant slope with points close to 4. From the table, compare values near 3.99 and 4.01 (or 3.9 and 4.1). The estimated slope is about 8, so the best choice is 8.$txt$,
        '{derivative_from_table}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Use file U2_1769403109_2.1-P5_table.png', 0.8, 0.2, NOW(), NOW()
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
