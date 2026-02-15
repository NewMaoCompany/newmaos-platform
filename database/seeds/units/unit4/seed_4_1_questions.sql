-- Insert Script for Chapter 4.1 Questions (Interpreting the Meaning of the Derivative in Context)
-- Unit: ABBC_Applications / 4.1

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.1-P1', 'U4.1-P2', 'U4.1-P3', 'U4.1-P4', 'U4.1-P5');

-- ============================================================
-- U4.1-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.1-P1', 'Both', 'ABBC_Applications', '4.1', '4.1', 'MCQ', FALSE,
        2, 90, '{derivative_meaning_context,units_analysis}', '{units_missing_or_wrong}', 'text',
        $txt$Let $P(t)$ be the population of a town, measured in thousands of people, where $t$ is measured in years. If $P''(6)=1.8$, which statement is the best interpretation?$txt$,
        $txt$Let $P(t)$ be the population of a town, measured in thousands of people, where $t$ is measured in years. If $P''(6)=1.8$, which statement is the best interpretation?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "At $t=6$ years, the town has a population of $1.8$ thousand people.", "type": "text", "explanation": "This confuses the value $P(6)$ with the derivative $P'(6)$."},
          {"id": "B", "label": "B", "value": "At $t=6$ years, the population is increasing at $1.8$ thousand people per year.", "type": "text", "explanation": "Correct: derivative gives an instantaneous rate, and the units are thousand people per year."},
          {"id": "C", "label": "C", "value": "From $t=0$ to $t=6$ years, the average population increase is $1.8$ thousand people.", "type": "text", "explanation": "This describes an average rate over an interval, not an instantaneous rate at $t=6$."},
          {"id": "D", "label": "D", "value": "At $t=6$ years, the population will be $1.8$ times its current size next year.", "type": "text", "explanation": "A derivative does not imply a multiplicative growth factor like “times its size.”"}
        ]$txt$,
        'B',
        $txt$$P''(6)=1.8$ means the instantaneous rate of change of population at $t=6$ is $1.8$ thousand people per year.$txt$,
        '{derivative_meaning_context}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_meaning_context', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'units_analysis', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'units_missing_or_wrong' FROM new_question;


-- ============================================================
-- U4.1-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.1-P2', 'Both', 'ABBC_Applications', '4.1', '4.1', 'MCQ', FALSE,
        3, 120, '{average_vs_instant_context,derivative_meaning_context}', '{avg_vs_instant_confusion_context}', 'text',
        $txt$A car’s position $s(t)$ is measured in miles, where $t$ is measured in hours. If $s''(2)=45$, which statement is correct?$txt$,
        $txt$A car’s position $s(t)$ is measured in miles, where $t$ is measured in hours. If $s''(2)=45$, which statement is correct?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "At $t=2$ hours, the car has traveled $45$ miles.", "type": "text", "explanation": "This incorrectly treats the derivative as a distance traveled."},
          {"id": "B", "label": "B", "value": "At $t=2$ hours, the car’s instantaneous velocity is $45$ miles per hour.", "type": "text", "explanation": "Correct: $s'(2)$ is instantaneous velocity with units miles per hour."},
          {"id": "C", "label": "C", "value": "From $t=0$ to $t=2$ hours, the car’s average speed is $45$ miles per hour.", "type": "text", "explanation": "This describes an average rate, not an instantaneous rate at a single time."},
          {"id": "D", "label": "D", "value": "At $t=2$ hours, the car’s acceleration is $45$ miles per hour per hour.", "type": "text", "explanation": "Acceleration would be $s''(2)$, not $s'(2)$."}
        ]$txt$,
        'B',
        $txt$Since $s(t)$ is position (miles) and $t$ is time (hours), $s''(2)$ represents instantaneous velocity in miles per hour at $t=2$.$txt$,
        '{average_vs_instant_context}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'average_vs_instant_context', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_meaning_context', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'avg_vs_instant_confusion_context' FROM new_question;


-- ============================================================
-- U4.1-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.1-P3', 'Both', 'ABBC_Applications', '4.1', '4.1', 'MCQ', FALSE,
        3, 135, '{derivative_meaning_context,units_analysis}', '{unit_conversion_error}', 'text',
        $txt$The height of water in a tank is $h(t)$ feet, where $t$ is measured in minutes. Suppose $h''(5)=-0.6$. Which statement best describes the situation at $t=5$?$txt$,
        $txt$The height of water in a tank is $h(t)$ feet, where $t$ is measured in minutes. Suppose $h''(5)=-0.6$. Which statement best describes the situation at $t=5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "At $t=5$, the water height is $-0.6$ feet.", "type": "text", "explanation": "This confuses $h(5)$ (height) with $h'(5)$ (rate)."},
          {"id": "B", "label": "B", "value": "At $t=5$, the water height is decreasing at $0.6$ feet per minute.", "type": "text", "explanation": "Correct: $h'(5)=-0.6$ means decreasing at $0.6$ feet per minute."},
          {"id": "C", "label": "C", "value": "From $t=0$ to $t=5$, the water height decreases by $0.6$ feet total.", "type": "text", "explanation": "This misinterprets a rate at a single instant as a total change over an interval."},
          {"id": "D", "label": "D", "value": "At $t=5$, the water height is decreasing at $0.6$ feet per second.", "type": "text", "explanation": "Time is in minutes, so the rate is not per second."}
        ]$txt$,
        'B',
        $txt$A negative derivative means the quantity is decreasing. The units of $h''(t)$ are feet per minute.$txt$,
        '{derivative_meaning_context}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_meaning_context', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'units_analysis', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'unit_conversion_error' FROM new_question;


-- ============================================================
-- U4.1-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.1-P4', 'Both', 'ABBC_Applications', '4.1', '4.1', 'MCQ', FALSE,
        4, 180, '{interpret_graph_context,derivative_meaning_context}', '{graph_rate_misinterpretation}', 'text',
        $txt$The graph shows the temperature $T(t)$ of a chemical solution (in $°C$) as a function of time $t$ (in hours). Which value best represents $T''(4)$?$txt$,
        $txt$The graph shows the temperature $T(t)$ of a chemical solution (in $°C$) as a function of time $t$ (in hours). Which value best represents $T''(4)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-0.2$", "type": "text", "explanation": "This slope is too small in magnitude compared to the tangent line shown."},
          {"id": "B", "label": "B", "value": "$-0.8$", "type": "text", "explanation": "Correct: the tangent line decreases about $0.8$ °C per hour at $t=4$."},
          {"id": "C", "label": "C", "value": "$2.6$", "type": "text", "explanation": "This would indicate increasing temperature, but the tangent line is decreasing."},
          {"id": "D", "label": "D", "value": "$8.0$", "type": "text", "explanation": "This is far too steep compared to the tangent line shown."}
        ]$txt$,
        'B',
        $txt$$T''(4)$ is the slope of the tangent line at $t=4$. From the shown tangent, the slope is approximately $-0.8$ °C per hour.$txt$,
        '{interpret_graph_context}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Graph required: Temperature vs time with tangent at t=4.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'interpret_graph_context', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_meaning_context', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'graph_rate_misinterpretation' FROM new_question;


-- ============================================================
-- U4.1-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.1-P5', 'Both', 'ABBC_Applications', '4.1', '4.1', 'MCQ', FALSE,
        4, 180, '{interpret_table_context,average_vs_instant_context}', '{table_rate_estimate_wrong}', 'text',
        $txt$The table gives the volume $V(t)$ of water (in liters) remaining in a tank $t$ minutes after draining begins. Which value is the best estimate of $V''(6)$?$txt$,
        $txt$The table gives the volume $V(t)$ of water (in liters) remaining in a tank $t$ minutes after draining begins. Which value is the best estimate of $V''(6)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-9.5$", "type": "text", "explanation": "This is too steep for the local change shown (it would imply losing ~19 L in 2 minutes)."},
          {"id": "B", "label": "B", "value": "$-5.0$", "type": "text", "explanation": "Correct best estimate is about $-4.75$ L/min, so $-5.0$ is the closest choice."},
          {"id": "C", "label": "C", "value": "$5.0$", "type": "text", "explanation": "Positive would mean volume is increasing, which contradicts the table."},
          {"id": "D", "label": "D", "value": "$9.5$", "type": "text", "explanation": "Positive and too large; the tank is draining, not filling."}
        ]$txt$,
        'A',
        $txt$Estimate the instantaneous rate at $t=6$ using a symmetric difference: $V''(6) \approx (V(8)-V(4)) / (8-4) = (78-97)/4 = -4.75$. The closest option is $-5.0$ if using that, but the table trend from $4\to 6$ and $6\to 8$ averages to about $-4.75$. Among given choices, $-5.0$ is closer; however if using a slightly steeper estimate from the local drop (97 to 87 to 78), the best approximate rate near $t=6$ is about $-4.5$ to $-5.0$.$txt$,
        '{interpret_table_context}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Table required: V(t) at t=0,2,4,6,8.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'interpret_table_context', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'average_vs_instant_context', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_rate_estimate_wrong' FROM new_question;
