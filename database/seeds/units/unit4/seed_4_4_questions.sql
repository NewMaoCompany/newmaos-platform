-- Insert Script for Chapter 4.4 Questions (Introduction to Related Rates)
-- Unit: ABBC_Applications / 4.4

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.4-P1', 'U4.4-P2', 'U4.4-P3', 'U4.4-P4', 'U4.4-P5');

-- ============================================================
-- U4.4-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.4-P1', 'Both', 'ABBC_Applications', '4.4', '4.4', 'MCQ', FALSE,
        3, 180, '{related_rates_identify_variables,units_analysis}', '{missing_related_variables}', 'text',
        $txt$A spherical balloon is being inflated. Which pair of quantities must be directly related by a geometric formula before differentiating with respect to time?$txt$,
        $txt$A spherical balloon is being inflated. Which pair of quantities must be directly related by a geometric formula before differentiating with respect to time?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The balloon’s radius and its volume", "type": "text", "explanation": "Correct: radius and volume are connected by a geometry formula."},
          {"id": "B", "label": "B", "value": "The balloon’s time and its radius", "type": "text", "explanation": "Time is not part of the geometric relationship."},
          {"id": "C", "label": "C", "value": "The balloon’s time and its volume", "type": "text", "explanation": "Time is not part of the geometric relationship."},
          {"id": "D", "label": "D", "value": "The balloon’s volume and its time rate of change", "type": "text", "explanation": "A rate is found after differentiating, not used as the starting relationship."}
        ]$txt$,
        'A',
        $txt$Related rates begins by writing a geometric relationship between quantities that change together (here, radius and volume). Time is not directly related by a geometry formula.$txt$,
        '{related_rates_identify_variables}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_identify_variables', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'units_analysis', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'missing_related_variables' FROM new_question;

-- ============================================================
-- U4.4-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.4-P2', 'Both', 'ABBC_Applications', '4.4', '4.4', 'MCQ', FALSE,
        3, 180, '{related_rates_differentiate_time,derivative_meaning_context}', '{differentiate_wrt_wrong_variable}', 'text',
        $txt$In a related rates setup, why do we differentiate a geometric equation with respect to time?$txt$,
        $txt$In a related rates setup, why do we differentiate a geometric equation with respect to time?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Because time is the only variable in geometry formulas.", "type": "text", "explanation": "Geometry formulas usually do not include time explicitly."},
          {"id": "B", "label": "B", "value": "Because it converts quantities into rates that are linked at the same instant.", "type": "text", "explanation": "Correct: differentiation connects the rates at a given time."},
          {"id": "C", "label": "C", "value": "Because it eliminates constants in the equation automatically.", "type": "text", "explanation": "Constants stay constants; this is not the main purpose."},
          {"id": "D", "label": "D", "value": "Because it allows you to plug in numbers before writing any equation.", "type": "text", "explanation": "You must write the relationship first before plugging values."}
        ]$txt$,
        'B',
        $txt$Differentiating with respect to time turns changing quantities into time-rates (like $dr/dt$, $dV/dt$) that can be related at the same instant.$txt$,
        '{related_rates_differentiate_time}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_differentiate_time', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'derivative_meaning_context', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'differentiate_wrt_wrong_variable' FROM new_question;

-- ============================================================
-- U4.4-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.4-P3', 'Both', 'ABBC_Applications', '4.4', '4.4', 'MCQ', FALSE,
        4, 210, '{related_rates_common_mistakes,method_selection_unit4}', '{plug_in_before_diff_error}', 'text',
        $txt$Which is the most common incorrect move in related rates problems?$txt$,
        $txt$Which is the most common incorrect move in related rates problems?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Writing a relationship between the changing variables", "type": "text", "explanation": "This is a correct first step."},
          {"id": "B", "label": "B", "value": "Differentiating the relationship with respect to time", "type": "text", "explanation": "This is required to get rates."},
          {"id": "C", "label": "C", "value": "Substituting given numerical values before differentiating", "type": "text", "explanation": "Correct: plugging in before differentiating is a classic mistake."},
          {"id": "D", "label": "D", "value": "Solving for the requested rate at the end", "type": "text", "explanation": "This is the correct final step."}
        ]$txt$,
        'C',
        $txt$You should keep variables until after differentiating. Plugging values too early often removes needed relationships and prevents correct differentiation.$txt$,
        '{related_rates_common_mistakes}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_common_mistakes', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit4', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'plug_in_before_diff_error' FROM new_question;

-- ============================================================
-- U4.4-P4 (LATEX FIX HERE)
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.4-P4', 'Both', 'ABBC_Applications', '4.4', '4.4', 'MCQ', FALSE,
        4, 240, '{related_rates_geometry_cone,related_rates_differentiate_time}', '{missing_geometry_relation}', 'text',
        $txt$Water is poured into a cone-shaped container. The cone has fixed height $5$ ft and fixed radius $2$ ft. The water level rises so that the water surface always forms a similar cone. Which relationship correctly connects the water radius $r$ and water height $h$?$txt$,
        $txt$Water is poured into a cone-shaped container. The cone has fixed height $5$ ft and fixed radius $2$ ft. The water level rises so that the water surface always forms a similar cone. Which relationship correctly connects the water radius $r$ and water height $h$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$r = h + 3$", "type": "text", "explanation": "Similarity creates a proportional ratio, not an additive shift."},
          {"id": "B", "label": "B", "value": "$\\frac{r}{h} = \\frac{2}{5}$", "type": "text", "explanation": "Correct: similarity gives $r/h = 2/5$."},
          {"id": "C", "label": "C", "value": "$r = \\frac{5h}{2}$", "type": "text", "explanation": "This reverses the correct proportional relationship."},
          {"id": "D", "label": "D", "value": "$r^2 + h^2 = 29$", "type": "text", "explanation": "This is a Pythagorean-type relationship, not from similarity."}
        ]$txt$,
        'B',
        $txt$By similar triangles, the ratio $r/h$ stays constant and equals the full cone’s radius-to-height ratio, $2/5$.$txt$,
        '{related_rates_geometry_cone}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Diagram required: cone cross-section with r and h labeled.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_geometry_cone', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'related_rates_differentiate_time', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'missing_geometry_relation' FROM new_question;

-- ============================================================
-- U4.4-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.4-P5', 'Both', 'ABBC_Applications', '4.4', '4.4', 'MCQ', FALSE,
        5, 270, '{related_rates_units_signs,units_analysis}', '{sign_error_rate_direction}', 'text',
        $txt$A puddle of oil forms a circular spill. The radius of the spill is increasing at $0.4$ m/min. Which statement about the area’s rate of change is always true?$txt$,
        $txt$A puddle of oil forms a circular spill. The radius of the spill is increasing at $0.4$ m/min. Which statement about the area’s rate of change is always true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The area is decreasing because the radius is increasing slowly.", "type": "text", "explanation": "If $r$ is increasing, area is increasing."},
          {"id": "B", "label": "B", "value": "The area is increasing, and its rate depends on the current radius.", "type": "text", "explanation": "Correct: $dA/dt$ changes with the current radius."},
          {"id": "C", "label": "C", "value": "The area increases at a constant rate of $0.4$ square meters per minute.", "type": "text", "explanation": "Units and dependence are incorrect; area rate is not equal to $dr/dt$."},
          {"id": "D", "label": "D", "value": "The area’s rate of change is negative when the radius is positive.", "type": "text", "explanation": "With increasing $r$, the area rate is not negative."}
        ]$txt$,
        'B',
        $txt$Area increases when radius increases. The area’s rate depends on the current radius, so it is not constant even if $dr/dt$ is constant.$txt$,
        '{related_rates_units_signs}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'related_rates_units_signs', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'units_analysis', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sign_error_rate_direction' FROM new_question;
