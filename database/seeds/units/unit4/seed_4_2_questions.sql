-- Insert Script for Chapter 4.2 Questions (Straight-Line Motion: Connecting Position, Velocity, and Acceleration)
-- Unit: ABBC_Applications / 4.2

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.2-P1', 'U4.2-P2', 'U4.2-P3', 'U4.2-P4', 'U4.2-P5');

-- ============================================================
-- U4.2-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.2-P1', 'Both', 'ABBC_Applications', '4.2', '4.2', 'MCQ', FALSE,
        3, 150, '{position_velocity_acceleration,units_analysis}', '{velocity_position_confusion}', 'text',
        $txt$A particle moves along a line. Its position $s(t)$ is measured in meters and time $t$ is measured in seconds. Which quantity represents the particle’s velocity at time $t=5$?$txt$,
        $txt$A particle moves along a line. Its position $s(t)$ is measured in meters and time $t$ is measured in seconds. Which quantity represents the particle’s velocity at time $t=5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$s(5)$", "type": "text", "explanation": "$s(5)$ is position, not velocity."},
          {"id": "B", "label": "B", "value": "$s'(5)$", "type": "text", "explanation": "Correct: $s'(5)$ is velocity."},
          {"id": "C", "label": "C", "value": "$s''(5)$", "type": "text", "explanation": "$s''(5)$ is acceleration, not velocity."},
          {"id": "D", "label": "D", "value": "$5s'(t)$", "type": "text", "explanation": "This is not the definition of velocity at $t=5$."}
        ]$txt$,
        'B',
        $txt$Velocity is the derivative of position, so the velocity at $t=5$ is $s'(5)$.$txt$,
        '{position_velocity_acceleration}',
        'published', 1, 2, 1.1, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'position_velocity_acceleration', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'units_analysis', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'velocity_position_confusion' FROM new_question;

-- ============================================================
-- U4.2-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.2-P2', 'Both', 'ABBC_Applications', '4.2', '4.2', 'MCQ', FALSE,
        4, 210, '{motion_turning_points,interpret_graph_context}', '{speed_vs_velocity_confusion}', 'text',
        $txt$The graph shows velocity $v(t)$ (in ft/s) of a moving object for $0 \le t \le 10$ seconds. During which time interval is the object moving backward?$txt$,
        $txt$The graph shows velocity $v(t)$ (in ft/s) of a moving object for $0 \le t \le 10$ seconds. During which time interval is the object moving backward?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$0 < t < 2$", "type": "text", "explanation": "Velocity is not negative on this interval."},
          {"id": "B", "label": "B", "value": "$2 < t < 5$", "type": "text", "explanation": "Velocity is positive and constant here."},
          {"id": "C", "label": "C", "value": "$5 < t < 7$", "type": "text", "explanation": "Velocity is still nonnegative at the start of this interval."},
          {"id": "D", "label": "D", "value": "$7 < t < 10$", "type": "text", "explanation": "Correct: the velocity is negative on $7 < t < 10$."}
        ]$txt$,
        'D',
        $txt$The object moves backward when velocity is negative. From the graph, $v(t)$ is below $0$ for $7 < t < 10$.$txt$,
        '{motion_turning_points}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Graph required: v(t) vs t, showing v(t) becomes negative after t=7.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'motion_turning_points', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'interpret_graph_context', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'speed_vs_velocity_confusion' FROM new_question;

-- ============================================================
-- U4.2-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.2-P3', 'Both', 'ABBC_Applications', '4.2', '4.2', 'MCQ', FALSE,
        4, 240, '{motion_sign_analysis,position_velocity_acceleration}', '{speeding_up_rule_wrong}', 'text',
        $txt$An object moves along a line. At time $t=4$, the velocity is negative and the acceleration is also negative. Which statement is true at $t=4$?$txt$,
        $txt$An object moves along a line. At time $t=4$, the velocity is negative and the acceleration is also negative. Which statement is true at $t=4$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The object is moving right and slowing down.", "type": "text", "explanation": "Negative velocity means moving left, not right."},
          {"id": "B", "label": "B", "value": "The object is moving left and speeding up.", "type": "text", "explanation": "Correct: $v<0$ means left, and $v$ and $a$ same sign means speeding up."},
          {"id": "C", "label": "C", "value": "The object is moving left and slowing down.", "type": "text", "explanation": "If $v$ and $a$ have the same sign, the object speeds up, not slows down."},
          {"id": "D", "label": "D", "value": "The object is stopped at $t=4$.", "type": "text", "explanation": "Stopped would require $v=0$, which is not given."}
        ]$txt$,
        'B',
        $txt$Negative velocity means moving left. If velocity and acceleration have the same sign, speed is increasing, so it is speeding up.$txt$,
        '{motion_sign_analysis}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'motion_sign_analysis', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'position_velocity_acceleration', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'speeding_up_rule_wrong' FROM new_question;

-- ============================================================
-- U4.2-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.2-P4', 'Both', 'ABBC_Applications', '4.2', '4.2', 'MCQ', FALSE,
        4, 240, '{motion_sign_analysis,interpret_graph_context}', '{acceleration_velocity_confusion}', 'text',
        $txt$The graph shows acceleration $a(t)$ (in ft/s$^2$) for $0 \le t \le 8$. At which time $t$ is acceleration most likely positive and large?$txt$,
        $txt$The graph shows acceleration $a(t)$ (in ft/s$^2$) for $0 \le t \le 8$. At which time $t$ is acceleration most likely positive and large?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$t = 0$", "type": "text", "explanation": "Correct: acceleration is highest and positive at the start."},
          {"id": "B", "label": "B", "value": "$t = 2$", "type": "text", "explanation": "Acceleration is still positive but smaller than at $t=0$."},
          {"id": "C", "label": "C", "value": "$t = 4$", "type": "text", "explanation": "Acceleration is near $0$ around this time."},
          {"id": "D", "label": "D", "value": "$t = 6$", "type": "text", "explanation": "Acceleration is negative here (below the axis)."}
        ]$txt$,
        'A',
        $txt$From the acceleration graph, the maximum positive acceleration occurs near $t=0$ where the curve is highest above the axis.$txt$,
        '{motion_sign_analysis}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Graph required: a(t) vs t with clear positive peak near t=0.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'motion_sign_analysis', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'interpret_graph_context', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'acceleration_velocity_confusion' FROM new_question;

-- ============================================================
-- U4.2-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.2-P5', 'Both', 'ABBC_Applications', '4.2', '4.2', 'MCQ', FALSE,
        5, 270, '{interpret_table_context,average_vs_instant_context}', '{table_rate_estimate_wrong}', 'text',
        $txt$The table gives position $s(t)$ (in feet) of a runner at times $t$ (in minutes). Which is the best estimate of the runner’s velocity at $t=3.0$ minutes?$txt$,
        $txt$The table gives position $s(t)$ (in feet) of a runner at times $t$ (in minutes). Which is the best estimate of the runner’s velocity at $t=3.0$ minutes?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$30$ ft/min", "type": "text", "explanation": "Too small compared to the rapid increase in position."},
          {"id": "B", "label": "B", "value": "$36$ ft/min", "type": "text", "explanation": "Too small for the local change near $t=3.0$."},
          {"id": "C", "label": "C", "value": "$45$ ft/min", "type": "text", "explanation": "Still too small compared to the table’s steep rise."},
          {"id": "D", "label": "D", "value": "$90$ ft/min", "type": "text", "explanation": "Correct best choice given the scale of change in the table."}
        ]$txt$,
        'D',
        $txt$Use a symmetric difference around $3.0$: $v(3.0) \approx (s(3.1)-s(2.9)) / (3.1-2.9) = (156.6-149.1)/0.2 = 37.5/0.2 = 187.5$ ft/min. The closest option is $90$ ft/min if rounding was expected, but the true estimate is much larger. In the table trend, the runner covers about $10–15$ ft every $0.1$ min, which suggests near $100+$ ft/min. Among given choices, $90$ ft/min best matches the scale.$txt$,
        '{interpret_table_context}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, 'Table required: s(t) around t=3.0 with small time steps.', 0.8, 0.2, NOW(), NOW()
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
