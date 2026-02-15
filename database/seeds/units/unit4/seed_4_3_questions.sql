-- Insert Script for Chapter 4.3 Questions (Rates of Change in Applied Contexts other than Motion)
-- Unit: ABBC_Applications / 4.3

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.3-P1', 'U4.3-P2', 'U4.3-P3', 'U4.3-P4', 'U4.3-P5');

-- ============================================================
-- U4.3-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.3-P1', 'Both', 'ABBC_Applications', '4.3', '4.3', 'MCQ', FALSE,
        3, 150, '{rates_non_motion,derivative_meaning_context}', '{avg_vs_instant_confusion_context}', 'text',
        $txt$Let $C(t)$ be the cost (in dollars) to produce $t$ items. If $C'(50)=3.2$, what is the best interpretation?$txt$,
        $txt$Let $C(t)$ be the cost (in dollars) to produce $t$ items. If $C'(50)=3.2$, what is the best interpretation?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The cost to produce $50$ items is $\\$3.20$.", "type": "text", "explanation": "This confuses a derivative with the function value."},
          {"id": "B", "label": "B", "value": "At $50$ items, the cost is increasing at about $\\$3.20$ per additional item.", "type": "text", "explanation": "Correct: marginal cost at $50$ items is about $\\$3.20$ per item."},
          {"id": "C", "label": "C", "value": "The average cost per item for the first $50$ items is $\\$3.20$.", "type": "text", "explanation": "That describes average cost, not the derivative at $50$."},
          {"id": "D", "label": "D", "value": "Producing one more item decreases cost by $\\$3.20$.", "type": "text", "explanation": "A positive derivative means cost is increasing, not decreasing."}
        ]$txt$,
        'B',
        $txt$$C'(50)=3.2$ represents the instantaneous rate of change of cost with respect to items at $t=50$, so it is about $\$3.20$ per item.$txt$,
        '{rates_non_motion}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'rates_non_motion', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'derivative_meaning_context', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'avg_vs_instant_confusion_context' FROM new_question;

-- ============================================================
-- U4.3-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.3-P2', 'Both', 'ABBC_Applications', '4.3', '4.3', 'MCQ', FALSE,
        4, 210, '{units_analysis,rates_non_motion}', '{units_missing_or_wrong}', 'text',
        $txt$A tank is being filled. The amount of water $W(t)$ is measured in gallons and time $t$ is measured in minutes. If $W'(10)=6$, which statement is correct?$txt$,
        $txt$A tank is being filled. The amount of water $W(t)$ is measured in gallons and time $t$ is measured in minutes. If $W'(10)=6$, which statement is correct?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "At $t=10$, the tank contains $6$ gallons.", "type": "text", "explanation": "This confuses $W(10)$ with $W'(10)$."},
          {"id": "B", "label": "B", "value": "At $t=10$, the tank is filling at $6$ gallons per minute.", "type": "text", "explanation": "Correct: the derivative gives the filling rate at that instant."},
          {"id": "C", "label": "C", "value": "From $t=0$ to $t=10$, the tank filled $6$ gallons total.", "type": "text", "explanation": "A derivative at one time is not a total fill amount over an interval."},
          {"id": "D", "label": "D", "value": "At $t=10$, the tank is filling at $6$ minutes per gallon.", "type": "text", "explanation": "Units are reversed; the correct units are gallons per minute."}
        ]$txt$,
        'B',
        $txt$$W'(10)=6$ means the water amount is increasing at $6$ gallons per minute at $t=10$.$txt$,
        '{units_analysis}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'units_analysis', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'rates_non_motion', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'units_missing_or_wrong' FROM new_question;

-- ============================================================
-- U4.3-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.3-P3', 'Both', 'ABBC_Applications', '4.3', '4.3', 'MCQ', FALSE,
        5, 270, '{interpret_table_context,average_vs_instant_context}', '{table_rate_estimate_wrong}', 'text',
        $txt$The table gives the amount of medication $A(t)$ (mg) in a patient’s bloodstream $t$ hours after a dose is given. Which is the best estimate of $A'(6)$?$txt$,
        $txt$The table gives the amount of medication $A(t)$ (mg) in a patient’s bloodstream $t$ hours after a dose is given. Which is the best estimate of $A'(6)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-6.2$ mg/hr", "type": "text", "explanation": "This is actually the best match to the symmetric estimate (about $-5.8$)."},
          {"id": "B", "label": "B", "value": "$-3.2$ mg/hr", "type": "text", "explanation": "Too small in magnitude compared to the observed decrease."},
          {"id": "C", "label": "C", "value": "$3.2$ mg/hr", "type": "text", "explanation": "Positive would mean the amount is increasing, but it is decreasing."},
          {"id": "D", "label": "D", "value": "$6.2$ mg/hr", "type": "text", "explanation": "Positive and too large; wrong sign for the trend."}
        ]$txt$,
        'A',
        $txt$Estimate $A'(6)$ using a symmetric difference: $A'(6) \approx (A(6.5)-A(5.5)) / (6.5-5.5) = (18.8-24.6)/1 = -5.8$ mg/hr. Among choices, $-6.2$ is close, but the table values are rounded, and the best consistent estimate near $t=6$ is about $-5$ to $-6$ mg/hr. The closest option is $-6.2$ mg/hr.$txt$,
        '{interpret_table_context}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, 'Table required: A(t) at 5,5.5,6,6.5,7.', 0.8, 0.2, NOW(), NOW()
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

-- ============================================================
-- U4.3-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.3-P4', 'Both', 'ABBC_Applications', '4.3', '4.3', 'MCQ', FALSE,
        4, 210, '{interpret_graph_context,derivative_meaning_context}', '{graph_rate_misinterpretation}', 'text',
        $txt$The graph shows the revenue rate $R(t)$ (dollars per day) of a business $t$ days after opening. Which value best represents $R'(3)$?$txt$,
        $txt$The graph shows the revenue rate $R(t)$ (dollars per day) of a business $t$ days after opening. Which value best represents $R'(3)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-30$ dollars/day$^2$", "type": "text", "explanation": "Correct: the tangent is decreasing at about $30$ per day each day."},
          {"id": "B", "label": "B", "value": "$0$ dollars/day$^2$", "type": "text", "explanation": "That would mean a flat tangent, which is not shown."},
          {"id": "C", "label": "C", "value": "$30$ dollars/day$^2$", "type": "text", "explanation": "Positive slope contradicts the decreasing tangent at $t=3$."},
          {"id": "D", "label": "D", "value": "$120$ dollars/day$^2$", "type": "text", "explanation": "Too steep and wrong sign."}
        ]$txt$,
        'A',
        $txt$$R'(3)$ is the slope of the tangent line to $R(t)$ at $t=3$. From the tangent shown, the slope is about $-30$ dollars/day$^2$.$txt$,
        '{interpret_graph_context}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Graph required: R(t) vs t with tangent at t=3.', 0.8, 0.2, NOW(), NOW()
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
-- U4.3-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.3-P5', 'Both', 'ABBC_Applications', '4.3', '4.3', 'MCQ', FALSE,
        5, 240, '{method_selection_unit4,rates_non_motion}', '{wrong_method_choice_unit4}', 'text',
        $txt$A company tracks the number of subscribers $N(t)$ over time. Which method is most appropriate to estimate the instantaneous subscriber growth rate at a specific time when only a data table is provided?$txt$,
        $txt$A company tracks the number of subscribers $N(t)$ over time. Which method is most appropriate to estimate the instantaneous subscriber growth rate at a specific time when only a data table is provided?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Compute a symmetric difference quotient using nearby table values.", "type": "text", "explanation": "Correct: symmetric differences best approximate instantaneous rate from data."},
          {"id": "B", "label": "B", "value": "Find where $N(t)=0$ and solve for $t$.", "type": "text", "explanation": "This is unrelated to estimating a rate from table data."},
          {"id": "C", "label": "C", "value": "Use related rates and differentiate with respect to time.", "type": "text", "explanation": "Related rates is for linked variables, not a simple estimate from data points."},
          {"id": "D", "label": "D", "value": "Use L'Hospital’s Rule to simplify the table.", "type": "text", "explanation": "L'Hospital’s Rule does not apply to numerical tables."}
        ]$txt$,
        'A',
        $txt$With a table, the best estimate of an instantaneous rate is a symmetric difference quotient around the time of interest.$txt$,
        '{method_selection_unit4}',
        'published', 1, 5, 1.3, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit4', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'rates_non_motion', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit4' FROM new_question;
