-- Insert Script for Chapter 4.5 Questions (Solving Related Rates Problems)
-- Unit: ABBC_Applications / 4.5

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.5-P1', 'U4.5-P2', 'U4.5-P3', 'U4.5-P4', 'U4.5-P5');

-- ============================================================
-- U4.5-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.5-P1', 'Both', 'ABBC_Applications', '4.5', '4.5', 'MCQ', FALSE,
        3, 240, '{related_rates_solve_strategy,method_selection_unit4}', '{wrong_method_choice_unit4}', 'text',
        $txt$Which sequence is the most reliable plan for solving a related rates problem?$txt$,
        $txt$Which sequence is the most reliable plan for solving a related rates problem?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Plug numbers → differentiate → solve", "type": "text", "explanation": "Numbers should be substituted after differentiating."},
          {"id": "B", "label": "B", "value": "Draw diagram → write variable relationship → differentiate w.r.t. time → substitute values → solve", "type": "text", "explanation": "Correct: this is the standard related rates workflow."},
          {"id": "C", "label": "C", "value": "Differentiate first → write the relationship later", "type": "text", "explanation": "You must write the relationship before differentiating."},
          {"id": "D", "label": "D", "value": "Solve for the requested rate using only units", "type": "text", "explanation": "Units help but cannot replace the actual relationship."}
        ]$txt$,
        'B',
        $txt$The standard reliable approach is: define variables, write the relationship, differentiate with respect to time, then substitute values at the instant and solve.$txt$,
        '{related_rates_solve_strategy}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_solve_strategy', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit4', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit4' FROM new_question;

-- ============================================================
-- U4.5-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.5-P2', 'Both', 'ABBC_Applications', '4.5', '4.5', 'MCQ', FALSE,
        5, 300, '{related_rates_ladder,related_rates_units_signs}', '{sign_error_rate_direction}', 'text',
        $txt$A $10$-ft ladder leans against a wall. The bottom of the ladder slides away from the wall at $2$ ft/s. When the bottom is $6$ ft from the wall, how fast is the top sliding down the wall?$txt$,
        $txt$A $10$-ft ladder leans against a wall. The bottom of the ladder slides away from the wall at $2$ ft/s. When the bottom is $6$ ft from the wall, how fast is the top sliding down the wall?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$1.5$ ft/s upward", "type": "text", "explanation": "Wrong direction: the top slides down, not up."},
          {"id": "B", "label": "B", "value": "$1.5$ ft/s downward", "type": "text", "explanation": "Correct: magnitude is $1.5$ and direction is downward."},
          {"id": "C", "label": "C", "value": "$2.0$ ft/s downward", "type": "text", "explanation": "Too large; the rate is smaller when $y$ is relatively large."},
          {"id": "D", "label": "D", "value": "$3.0$ ft/s downward", "type": "text", "explanation": "Too large; inconsistent with the geometry at $x=6$."}
        ]$txt$,
        'B',
        $txt$At $x=6$ and ladder length $10$, the height is $y=8$ by the Pythagorean relationship. Differentiating gives a relationship between $dx/dt$ and $dy/dt$. The top must move downward, so $dy/dt$ is negative. The magnitude comes out $1.5$ ft/s.$txt$,
        '{related_rates_ladder}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Diagram required: ladder against wall with x and y labeled.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_ladder', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'related_rates_units_signs', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sign_error_rate_direction' FROM new_question;

-- ============================================================
-- U4.5-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.5-P3', 'Both', 'ABBC_Applications', '4.5', '4.5', 'MCQ', FALSE,
        3, 240, '{related_rates_geometry_sphere,related_rates_differentiate_time}', '{missing_differentiate_time}', 'text',
        $txt$A spherical snowball melts so that its radius decreases at $0.05$ cm/min. When the radius is $3$ cm, which statement best describes the sign of the volume’s rate of change?$txt$,
        $txt$A spherical snowball melts so that its radius decreases at $0.05$ cm/min. When the radius is $3$ cm, which statement best describes the sign of the volume’s rate of change?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The volume’s rate of change is positive.", "type": "text", "explanation": "If $r$ is decreasing, volume cannot be increasing."},
          {"id": "B", "label": "B", "value": "The volume’s rate of change is zero.", "type": "text", "explanation": "A nonzero $dr/dt$ implies a nonzero volume rate at that instant."},
          {"id": "C", "label": "C", "value": "The volume’s rate of change is negative.", "type": "text", "explanation": "Correct: decreasing radius implies decreasing volume."},
          {"id": "D", "label": "D", "value": "The sign cannot be determined from the information.", "type": "text", "explanation": "The sign is determined from the direction of radius change."}
        ]$txt$,
        'C',
        $txt$If the radius is decreasing, the volume must also be decreasing at that instant, so the volume’s rate of change is negative.$txt$,
        '{related_rates_geometry_sphere}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_geometry_sphere', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'related_rates_differentiate_time', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'missing_differentiate_time' FROM new_question;

-- ============================================================
-- U4.5-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.5-P4', 'Both', 'ABBC_Applications', '4.5', '4.5', 'MCQ', FALSE,
        5, 300, '{related_rates_geometry_cone,related_rates_units_signs}', '{unit_conversion_error}', 'text',
        $txt$Water is poured into a cone-shaped cup. The cup has height $12$ cm and radius $3$ cm. The water is poured in at a volume rate of $2$ cm$^3$/s. When the water depth is $4$ cm, how fast is the water depth increasing?$txt$,
        $txt$Water is poured into a cone-shaped cup. The cup has height $12$ cm and radius $3$ cm. The water is poured in at a volume rate of $2$ cm$^3$/s. When the water depth is $4$ cm, how fast is the water depth increasing?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$0.02$ cm/s", "type": "text", "explanation": "Too small; would imply the volume increases much more slowly than given."},
          {"id": "B", "label": "B", "value": "$0.10$ cm/s", "type": "text", "explanation": "Correct: consistent with similarity + the cone volume relationship at $h=4$."},
          {"id": "C", "label": "C", "value": "$0.20$ cm/s", "type": "text", "explanation": "Too large for a narrow cone at that depth."},
          {"id": "D", "label": "D", "value": "$0.40$ cm/s", "type": "text", "explanation": "Far too large; inconsistent with the geometry."}
        ]$txt$,
        'B',
        $txt$Use similarity to write the radius of the water surface in terms of the water depth, then substitute into the cone volume formula. Differentiate with respect to time, then plug in the depth and the given volume rate to solve for the depth rate.$txt$,
        '{related_rates_geometry_cone}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'This problem uses similarity and cone volume rates.', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_geometry_cone', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'related_rates_units_signs', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'unit_conversion_error' FROM new_question;

-- ============================================================
-- U4.5-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.5-P5', 'Both', 'ABBC_Applications', '4.5', '4.5', 'MCQ', FALSE,
        3, 240, '{related_rates_chain_rule,related_rates_differentiate_time}', '{missing_chain_rule_related_rates}', 'text',
        $txt$A circle expands so that its radius changes over time. When differentiating an area formula to relate the rate of change of area to the rate of change of radius, which rule is essential?$txt$,
        $txt$A circle expands so that its radius changes over time. When differentiating an area formula to relate the rate of change of area to the rate of change of radius, which rule is essential?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Chain rule", "type": "text", "explanation": "Correct: radius depends on time, so chain rule is needed."},
          {"id": "B", "label": "B", "value": "Product rule", "type": "text", "explanation": "Not required for a basic area relationship."},
          {"id": "C", "label": "C", "value": "Quotient rule", "type": "text", "explanation": "Not required for this setup."},
          {"id": "D", "label": "D", "value": "Squeeze theorem", "type": "text", "explanation": "Unrelated to differentiation and rates."}
        ]$txt$,
        'A',
        $txt$Because the radius is a function of time, differentiating area with respect to time requires the chain rule to connect the radius rate to the area rate.$txt$,
        '{related_rates_chain_rule}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_chain_rule', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'related_rates_differentiate_time', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'missing_chain_rule_related_rates' FROM new_question;
