-- Consolidated Insert Script for Unit 5.11 and 5.12
-- Topic: ABBC_Analytical

BEGIN;

-- ============================================================
-- 1. METADATA (Skills & Error Tags)
-- ============================================================

-- Ensure prerequisites column exists
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'skills' AND column_name = 'prerequisites') THEN
        ALTER TABLE public.skills ADD COLUMN prerequisites text[];
    END IF;
END $$;

-- Insert Skills for 5.11 and 5.12
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('implicit_relation_behavior', 'Analyzing Behavior of Implicit Relations (Tangents/Slopes)', 'ABBC_Analytical', '{"optimization_solve_and_check"}'),
('horizontal_vertical_tangent_implicit', 'Finding Horizontal/Vertical Tangents in Implicit Curves', 'ABBC_Analytical', '{"implicit_relation_behavior"}')
-- Note: optimization_modeling and optimization_solve_and_check should be in 5.9/5.10 script, but we can ensure them if needed.
-- But since they were in the previous script, we assume they are there or user runs them in order.
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;

-- Insert Error Tags for 5.11 and 5.12
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('implicit_tangent_condition_error', 'Confusing Conditions for Horizontal vs Vertical Tangents', 'Differentiation', 3, 'ABBC_Analytical'),
('implicit_extra_solutions_not_checked', 'Failing to Verify Potential Tangent Points on Curve', 'Differentiation', 3, 'ABBC_Analytical')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;


-- ============================================================
-- 2. QUESTIONS (5.11 - Optimization Practice)
-- ============================================================

DELETE FROM public.questions WHERE title IN (
    'U5.11-P1', 'U5.11-P2', 'U5.11-P3', 'U5.11-P4', 'U5.11-P5'
);

-- U5.11-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.11-P1', 'Both', 'ABBC_Analytical', '5.11', '5.11', 'MCQ', FALSE,
        2, 120, '{optimization_modeling}', '{optimization_constraint_missing}', 'text',
        $txt$A 12 in by 18 in rectangle of cardboard is used to make an open-top box by cutting out congruent squares of side length $x$ from each corner and folding up the sides. Which expression gives the volume $V(x)$ of the box?$txt$,
        $txt$A 12 in by 18 in rectangle of cardboard is used to make an open-top box by cutting out congruent squares of side length $x$ from each corner and folding up the sides. Which expression gives the volume $V(x)$ of the box?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$V(x) = x(12 - 2x)(18 - 2x)$", "type": "text", "explanation": "Correct: height is $x$ and both dimensions reduce by $2x$."},
          {"id": "B", "label": "B", "value": "$V(x) = (12 - x)(18 - x)$", "type": "text", "explanation": "Incorrect: missing the height factor and subtracts $x$ instead of $2x$ per dimension."},
          {"id": "C", "label": "C", "value": "$V(x) = (12 - 2x)(18 - 2x)$", "type": "text", "explanation": "Incorrect: this is base area only; it ignores the height $x$."},
          {"id": "D", "label": "D", "value": "$V(x) = x(12 - x)(18 - x)$", "type": "text", "explanation": "Incorrect: subtracts $x$ only once per dimension; should be $2x$."}
        ]$txt$,
        'A',
        $txt$Height becomes $x$. Each base dimension loses $2x$, so the base is $(12-2x)$ by $(18-2x)$. Volume equals height times base area.$txt$,
        '{optimization_modeling}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Classic box problem setup.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_modeling', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_constraint_missing' FROM new_question;

-- U5.11-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.11-P2', 'Both', 'ABBC_Analytical', '5.11', '5.11', 'MCQ', FALSE,
        2, 120, '{optimization_solve_and_check}', '{optimization_domain_missing}', 'text',
        $txt$In the open-top box setup (12 in by 18 in, cut out squares of side $x$), which interval gives the full physically meaningful domain for $x$?$txt$,
        $txt$In the open-top box setup (12 in by 18 in, cut out squares of side $x$), which interval gives the full physically meaningful domain for $x$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$0 < x < 6$", "type": "text", "explanation": "Correct: $x$ must be positive and less than 6."},
          {"id": "B", "label": "B", "value": "$0 < x < 9$", "type": "text", "explanation": "Incorrect: allows $x$ up to 9, which makes $12-2x$ negative."},
          {"id": "C", "label": "C", "value": "$0 < x < 12$", "type": "text", "explanation": "Incorrect: allows values that break both dimensions."},
          {"id": "D", "label": "D", "value": "$0 < x < 18$", "type": "text", "explanation": "Incorrect: not meaningful for the geometry."}
        ]$txt$,
        'A',
        $txt$Both base dimensions must stay positive: $12-2x > 0$ and $18-2x > 0$. The stricter restriction is $x < 6$, and $x$ must be positive.$txt$,
        '{optimization_solve_and_check}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Domain check for box.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_solve_and_check', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'optimization_modeling', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_domain_missing' FROM new_question;

-- U5.11-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.11-P3', 'Both', 'ABBC_Analytical', '5.11', '5.11', 'MCQ', TRUE,
        3, 150, '{optimization_solve_and_check}', '{wrong_method_choice_unit5}', 'image',
        $txt$A rectangular region is fenced on three sides using 30 units of fencing, with the fourth side along a wall (no fence needed). Let $x$ be the length of each side perpendicular to the wall. Use the provided graph of area $A(x)$ to determine which $x$ gives the maximum area.$txt$,
        $txt$A rectangular region is fenced on three sides using 30 units of fencing, with the fourth side along a wall (no fence needed). Let $x$ be the length of each side perpendicular to the wall. Use the provided graph of area $A(x)$ to determine which $x$ gives the maximum area.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x = 5$", "type": "text", "explanation": "Incorrect: left of the peak; area is still increasing."},
          {"id": "B", "label": "B", "value": "$x = 7.5$", "type": "text", "explanation": "Correct: this is the x-value at the peak."},
          {"id": "C", "label": "C", "value": "$x = 10$", "type": "text", "explanation": "Incorrect: right of the peak; area is decreasing."},
          {"id": "D", "label": "D", "value": "$x = 15$", "type": "text", "explanation": "Incorrect: endpoint where area is 0."}
        ]$txt$,
        'B',
        $txt$The graph of $A(x)$ has a single peak. The x-value at the peak is 7.5, which gives the maximum area.$txt$,
        '{optimization_solve_and_check}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Use image: U5_5.11-P3_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_solve_and_check', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit5', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit5' FROM new_question;

-- U5.11-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.11-P4', 'Both', 'ABBC_Analytical', '5.11', '5.11', 'MCQ', TRUE,
        3, 180, '{candidates_test_absolute}', '{candidates_test_missing_endpoints}', 'image',
        $txt$A candidates table is provided for the fencing-against-a-wall area problem, listing $A(x)$ at several key x-values including endpoints. Which choice correctly identifies the maximizing $x$ and the maximum area shown in the table?$txt$,
        $txt$A candidates table is provided for the fencing-against-a-wall area problem, listing $A(x)$ at several key x-values including endpoints. Which choice correctly identifies the maximizing $x$ and the maximum area shown in the table?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x = 0$, maximum area = 0", "type": "text", "explanation": "Incorrect: endpoint is included, but it is not the maximum here."},
          {"id": "B", "label": "B", "value": "$x = 7.5$, maximum area = 112.5", "type": "text", "explanation": "Correct: this is the greatest $A(x)$ in the table."},
          {"id": "C", "label": "C", "value": "$x = 10$, maximum area = 100", "type": "text", "explanation": "Incorrect: $A(10)$ is smaller than the maximum listed."},
          {"id": "D", "label": "D", "value": "$x = 15$, maximum area = 225", "type": "text", "explanation": "Incorrect: at $x = 15$ the area is 0, not 225."}
        ]$txt$,
        'B',
        $txt$To apply the candidates test, compare all listed $A(x)$ values including endpoints. The largest value in the table is 112.5 at $x = 7.5$.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Use image: U5_5.11-P4_table.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'candidates_test_absolute', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'optimization_solve_and_check', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'candidates_test_missing_endpoints' FROM new_question;

-- U5.11-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.11-P5', 'Both', 'ABBC_Analytical', '5.11', '5.11', 'MCQ', FALSE,
        4, 210, '{optimization_modeling}', '{optimization_constraint_missing}', 'image',
        $txt$A closed cylinder has radius $r$ and height $h$. Its volume is fixed at 1000 cubic centimeters. Which expression gives the surface area $S$ as a function of $r$ only?$txt$,
        $txt$A closed cylinder has radius $r$ and height $h$. Its volume is fixed at 1000 cubic centimeters. Which expression gives the surface area $S$ as a function of $r$ only?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$S(r) = 2\\pi r^2 + \\frac{2000}{r}$", "type": "text", "explanation": "Correct: after substitution, the $\\pi$ cancels in the lateral-area term."},
          {"id": "B", "label": "B", "value": "$S(r) = 2\\pi r^2 + \\frac{2000\\pi}{r}$", "type": "text", "explanation": "Incorrect: keeps an extra $\\pi$ that should cancel."},
          {"id": "C", "label": "C", "value": "$S(r) = \\pi r^2 + \\frac{1000}{r}$", "type": "text", "explanation": "Incorrect: missing one base and has incorrect constants."},
          {"id": "D", "label": "D", "value": "$S(r) = 2\\pi r^2 + \\frac{1000\\pi}{r}$", "type": "text", "explanation": "Incorrect: wrong constant and also leaves $\\pi$ where it cancels."}
        ]$txt$,
        'A',
        $txt$Surface area for a closed cylinder is $2\\pi r^2 + 2\\pi r h$. The volume constraint gives $h = \\frac{1000}{\\pi r^2}$. Substituting cancels $\\pi$ in the lateral term, leaving $2\\pi r^2 + \\frac{2000}{r}$.$txt$,
        '{optimization_modeling}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, 'Use image: U5_5.11-P5_diagram.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_modeling', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'optimization_solve_and_check', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_constraint_missing' FROM new_question;

-- ============================================================
-- 3. QUESTIONS (5.12 - Implicit Relations)
-- ============================================================

DELETE FROM public.questions WHERE title IN (
    'U5.12-P1', 'U5.12-P2', 'U5.12-P3', 'U5.12-P4', 'U5.12-P5'
);

-- U5.12-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.12-P1', 'Both', 'ABBC_Analytical', '5.12', '5.12', 'MCQ', FALSE,
        3, 150, '{implicit_relation_behavior}', '{wrong_method_choice_unit5}', 'text',
        $txt$For the implicit relation $x^2 + x y + y^2 = 7$, which expression correctly gives $\frac{dy}{dx}$?$txt$,
        $txt$For the implicit relation $x^2 + x y + y^2 = 7$, which expression correctly gives $\frac{dy}{dx}$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Correct: matches the result after collecting dy/dx terms."},
          {"id": "B", "label": "B", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{2x + y}$", "type": "text", "explanation": "Incorrect: would force $\\frac{dy}{dx} = -1$ always, which is not true."},
          {"id": "C", "label": "C", "value": "$\\frac{dy}{dx} = \\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Incorrect: sign error."},
          {"id": "D", "label": "D", "value": "$\\frac{dy}{dx} = -\\frac{2x + 1}{1 + 2y}$", "type": "text", "explanation": "Incorrect: treats $y$ like a constant and breaks the product structure."}
        ]$txt$,
        'A',
        $txt$Differentiate implicitly: $2x + (x \\frac{dy}{dx} + y) + 2y \\frac{dy}{dx} = 0$. Collect dy/dx terms: $(x + 2y)\\frac{dy}{dx} = -(2x + y)$.$txt$,
        '{implicit_relation_behavior}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Implicit differentiation check.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_relation_behavior', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit5' FROM new_question;

-- U5.12-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.12-P2', 'Both', 'ABBC_Analytical', '5.12', '5.12', 'MCQ', FALSE,
        2, 120, '{horizontal_vertical_tangent_implicit}', '{implicit_tangent_condition_error}', 'image',
        $txt$The provided graph shows the implicit curve $x^2 + y^2 = 9$ with the points $(3,0)$ and $(-3,0)$ marked. Which statement is true about the tangent line at $(3,0)$?$txt$,
        $txt$The provided graph shows the implicit curve $x^2 + y^2 = 9$ with the points $(3,0)$ and $(-3,0)$ marked. Which statement is true about the tangent line at $(3,0)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The tangent is horizontal.", "type": "text", "explanation": "Incorrect: top and bottom points have horizontal tangents, not the rightmost point."},
          {"id": "B", "label": "B", "value": "The tangent is vertical.", "type": "text", "explanation": "Correct: rightmost point gives a vertical tangent."},
          {"id": "C", "label": "C", "value": "The tangent has slope 1.", "type": "text", "explanation": "Incorrect: a 45-degree slope is not consistent with the geometry."},
          {"id": "D", "label": "D", "value": "The tangent does not exist.", "type": "text", "explanation": "Incorrect: the curve is smooth there, so a tangent exists."}
        ]$txt$,
        'B',
        $txt$At the rightmost point of a circle, the tangent line is vertical.$txt$,
        '{horizontal_vertical_tangent_implicit}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Use image: U5_5.12-P2_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'horizontal_vertical_tangent_implicit', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'implicit_relation_behavior', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_tangent_condition_error' FROM new_question;

-- U5.12-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.12-P3', 'Both', 'ABBC_Analytical', '5.12', '5.12', 'MCQ', FALSE,
        3, 150, '{implicit_relation_behavior}', '{implicit_extra_solutions_not_checked}', 'text',
        $txt$For the implicit relation $x^2 + x y + y^2 = 7$, what is the slope of the tangent line at the point $(2,1)$?$txt$,
        $txt$For the implicit relation $x^2 + x y + y^2 = 7$, what is the slope of the tangent line at the point $(2,1)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-\\frac{5}{4}$", "type": "text", "explanation": "Correct: correct substitution gives -5/4."},
          {"id": "B", "label": "B", "value": "$-\\frac{4}{5}$", "type": "text", "explanation": "Incorrect: reciprocal error."},
          {"id": "C", "label": "C", "value": "$\\frac{5}{4}$", "type": "text", "explanation": "Incorrect: sign error."},
          {"id": "D", "label": "D", "value": "$\\frac{4}{5}$", "type": "text", "explanation": "Incorrect: sign and reciprocal are both wrong."}
        ]$txt$,
        'A',
        $txt$Using $\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$, substitute $(2,1)$: $\\frac{dy}{dx} = -\\frac{4+1}{2+2} = -\\frac{5}{4}$.$txt$,
        '{implicit_relation_behavior}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Numeric evaluation check.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_relation_behavior', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_extra_solutions_not_checked' FROM new_question;

-- U5.12-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.12-P4', 'Both', 'ABBC_Analytical', '5.12', '5.12', 'MCQ', FALSE,
        3, 150, '{implicit_relation_behavior}', '{implicit_tangent_condition_error}', 'image',
        $txt$The provided graph shows the implicit relation $x^2 - y^2 = 4$ with the point $(\\sqrt{5}, 1)$ marked. Which statement is true about the slope of the tangent line at that point?$txt$,
        $txt$The provided graph shows the implicit relation $x^2 - y^2 = 4$ with the point $(\\sqrt{5}, 1)$ marked. Which statement is true about the slope of the tangent line at that point?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The slope is positive.", "type": "text", "explanation": "Correct: $\\sqrt{5}$ is positive."},
          {"id": "B", "label": "B", "value": "The slope is negative.", "type": "text", "explanation": "Incorrect: sign mistake."},
          {"id": "C", "label": "C", "value": "The slope is 0 (horizontal tangent).", "type": "text", "explanation": "Incorrect: would require $x = 0$ at that point."},
          {"id": "D", "label": "D", "value": "The slope is undefined (vertical tangent).", "type": "text", "explanation": "Incorrect: would require $y = 0$ at that point."}
        ]$txt$,
        'A',
        $txt$Implicit differentiation gives $\\frac{dy}{dx} = \\frac{x}{y}$. At $(\\sqrt{5},1)$, the slope equals $\\sqrt{5}$, which is positive.$txt$,
        '{implicit_relation_behavior}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Use image: U5_5.12-P4_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_relation_behavior', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'horizontal_vertical_tangent_implicit', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_tangent_condition_error' FROM new_question;

-- U5.12-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.12-P5', 'Both', 'ABBC_Analytical', '5.12', '5.12', 'MCQ', TRUE,
        2, 120, '{implicit_relation_behavior}', '{implicit_tangent_condition_error}', 'image',
        $txt$A table is provided showing approximate $\\frac{dy}{dx}$ values for the implicit relation $x^2 + x y + y^2 = 7$ at several points. Which point has the greatest (most positive) slope among those listed?$txt$,
        $txt$A table is provided showing approximate $\\frac{dy}{dx}$ values for the implicit relation $x^2 + x y + y^2 = 7$ at several points. Which point has the greatest (most positive) slope among those listed?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(2,1)$", "type": "text", "explanation": "Incorrect: table shows this slope is negative."},
          {"id": "B", "label": "B", "value": "$(1,2)$", "type": "text", "explanation": "Incorrect: table shows this slope is negative."},
          {"id": "C", "label": "C", "value": "$(2,-1)$", "type": "text", "explanation": "Correct: table shows this is the greatest positive slope."},
          {"id": "D", "label": "D", "value": "$(-1,2)$", "type": "text", "explanation": "Incorrect: table shows this is not the greatest positive slope."}
        ]$txt$,
        'C',
        $txt$Compare the $\\frac{dy}{dx}$ values shown in the table. The largest positive value corresponds to $(2,-1)$.$txt$,
        '{implicit_relation_behavior}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Use image: U5_5.12-P5_table.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'implicit_relation_behavior', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'implicit_tangent_condition_error' FROM new_question;

COMMIT;
