-- Consolidated Insert Script for Unit 5.9 and 5.10
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

-- Insert Skills for 5.9 and 5.10
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('optimization_modeling', 'Modeling Optimization Problems (Objective & Constraints)', 'ABBC_Analytical', '{"candidates_test_absolute"}'),
('optimization_solve_and_check', 'Solving Optimization Problems and Verifying Domain/Candidates', 'ABBC_Analytical', '{"optimization_modeling"}')
-- Note: Other skills like connect_f_fprime_fdoubleprime should already be in from 5.7/5.8 script.
-- But we can include them here safely to be idempotent if user skipped previous scripts.
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;

-- Insert Error Tags for 5.9 and 5.10
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('optimization_variable_not_defined', 'Failing to Clearly Define Optimization Variables/Units', 'Optimization', 3, 'ABBC_Analytical'),
('optimization_constraint_missing', 'Missing or Incorrect Constraint Equation', 'Optimization', 4, 'ABBC_Analytical'),
('optimization_domain_missing', 'Ignoring Feasible Domain in Optimization', 'Optimization', 4, 'ABBC_Analytical')
-- Existing tags like graph_derivative_shape_misread, absolute_extrema_compare_error are used too.
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;


-- ============================================================
-- 2. QUESTIONS (5.9 - Connecting Graphs)
-- ============================================================

DELETE FROM public.questions WHERE title IN (
    'U5.9-P1', 'U5.9-P2', 'U5.9-P3', 'U5.9-P4', 'U5.9-P5'
);

-- U5.9-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.9-P1', 'Both', 'ABBC_Analytical', '5.9', '5.9', 'MCQ', FALSE,
        3, 180, '{connect_f_fprime_fdoubleprime}', '{graph_derivative_shape_misread}', 'image',
        $txt$Refer to the provided graph of $f$ for U5.9-P1 (marked at $x=1$). At $x=1$, which combination of signs is most consistent with the graph?$txt$,
        $txt$Refer to the provided graph of $f$ for U5.9-P1 (marked at $x=1$). At $x=1$, which combination of signs is most consistent with the graph?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f'(1)>0$ and $f''(1)>0$", "type": "text", "explanation": "Correct: rising and concave up at $x=1$ implies $f'(1)>0$ and $f''(1)>0$."},
          {"id": "B", "label": "B", "value": "$f'(1)>0$ and $f''(1)<0$", "type": "text", "explanation": "Incorrect: concave down would mean slopes decreasing at $x=1$."},
          {"id": "C", "label": "C", "value": "$f'(1)<0$ and $f''(1)>0$", "type": "text", "explanation": "Incorrect: the graph is not decreasing at $x=1$."},
          {"id": "D", "label": "D", "value": "$f'(1)<0$ and $f''(1)<0$", "type": "text", "explanation": "Incorrect: the graph is not decreasing at $x=1$."}
        ]$txt$,
        'A',
        $txt$At $x=1$ the graph is rising (positive slope) and bending upward (slopes increasing), so $f'(1)>0$ and $f''(1)>0$.$txt$,
        '{connect_f_fprime_fdoubleprime}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Graph file: U5_5.9-P1_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'connect_f_fprime_fdoubleprime', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'concavity_from_second_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'graph_derivative_shape_misread' FROM new_question;

-- U5.9-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.9-P2', 'Both', 'ABBC_Analytical', '5.9', '5.9', 'MCQ', FALSE,
        4, 240, '{sketch_function_from_derivative}', '{graph_derivative_shape_misread}', 'image',
        $txt$Refer to the provided graph of $f'$ for U5.9-P2. How many local extrema does $f$ have on $(-3,4)$?$txt$,
        $txt$Refer to the provided graph of $f'$ for U5.9-P2. How many local extrema does $f$ have on $(-3,4)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "Incorrect: there is more than one sign change in $f'$."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Incorrect: there are three sign changes in $f'$."},
          {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "Correct: three sign-change zeros in $f'$ imply three local extrema of $f$."},
          {"id": "D", "label": "D", "value": "4", "type": "text", "explanation": "Incorrect: the graph shows three, not four, sign-change crossings."}
        ]$txt$,
        'C',
        $txt$Local extrema of $f$ occur where $f'$ changes sign. From the graph, $f'$ crosses the x-axis with sign change three times, so $f$ has 3 local extrema on $(-3,4)$.$txt$,
        '{sketch_function_from_derivative}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Graph file: U5_5.9-P2_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'sketch_function_from_derivative', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'increasing_decreasing_from_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'graph_derivative_shape_misread' FROM new_question;

-- U5.9-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.9-P3', 'Both', 'ABBC_Analytical', '5.9', '5.9', 'MCQ', FALSE,
        3, 210, '{inflection_points}', '{inflection_without_sign_change}', 'image',
        $txt$Refer to the provided graph of $f''$ for U5.9-P3. How many inflection points does $f$ have on $(-4,4)$?$txt$,
        $txt$Refer to the provided graph of $f''$ for U5.9-P3. How many inflection points does $f$ have on $(-4,4)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "Incorrect: there is more than one sign change in $f''$."},
          {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Incorrect: there are three sign changes in $f''$."},
          {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "Correct: three sign-change zeros in $f''$ give three inflection points."},
          {"id": "D", "label": "D", "value": "4", "type": "text", "explanation": "Incorrect: the graph shows three sign-change crossings, not four."}
        ]$txt$,
        'C',
        $txt$Inflection points occur where concavity changes, i.e., where $f''$ changes sign. The graph of $f''$ crosses the x-axis with sign change three times, so $f$ has 3 inflection points on $(-4,4)$.$txt$,
        '{inflection_points}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph file: U5_5.9-P3_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'inflection_points', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'concavity_from_second_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'inflection_without_sign_change' FROM new_question;

-- U5.9-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.9-P4', 'Both', 'ABBC_Analytical', '5.9', '5.9', 'MCQ', FALSE,
        4, 240, '{connect_f_fprime_fdoubleprime}', '{sketch_missing_key_features}', 'image',
        $txt$Refer to the provided sign chart table for U5.9-P4. Which statement is true?$txt$,
        $txt$Refer to the provided sign chart table for U5.9-P4. Which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=-1$.", "type": "text", "explanation": "Incorrect: $f'$ does not change sign at $x=-1$ in the chart, so no local extremum there."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=2$.", "type": "text", "explanation": "Incorrect: at $x=2$, $f'$ changes from + to -, indicating a local maximum, not a minimum."},
          {"id": "C", "label": "C", "value": "$f$ has an inflection point at $x=2$.", "type": "text", "explanation": "Correct: $f''$ changes sign at $x=2$, so $f$ has an inflection point at $x=2$."},
          {"id": "D", "label": "D", "value": "$f$ is increasing on $(2,4)$.", "type": "text", "explanation": "Incorrect: on $(2,4)$ the chart shows $f'(x)<0$, so $f$ is decreasing there."}
        ]$txt$,
        'C',
        $txt$From the sign chart: $f''$ changes sign at $x=2$, so concavity changes there, giving an inflection point at $x=2$. Also $f'$ stays positive across $x=-1$ and changes from positive to negative at $x=2$, so $x=2$ is a local maximum, not a local minimum.$txt$,
        '{connect_f_fprime_fdoubleprime}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Table file: U5_5.9-P4_table.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'connect_f_fprime_fdoubleprime', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'sketch_function_from_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sketch_missing_key_features' FROM new_question;

-- U5.9-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.9-P5', 'Both', 'ABBC_Analytical', '5.9', '5.9', 'MCQ', FALSE,
        3, 180, '{connect_f_fprime_fdoubleprime}', '{concavity_sign_error}', 'text',
        $txt$Which statement is always true on an interval where $f$ is concave down?$txt$,
        $txt$Which statement is always true on an interval where $f$ is concave down?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f'$ is increasing on the interval.", "type": "text", "explanation": "Incorrect: increasing $f'$ corresponds to concave up, not concave down."},
          {"id": "B", "label": "B", "value": "$f'$ is decreasing on the interval.", "type": "text", "explanation": "Correct: concave down implies decreasing slopes, so $f'$ decreases."},
          {"id": "C", "label": "C", "value": "$f$ is increasing on the interval.", "type": "text", "explanation": "Incorrect: concavity does not determine whether $f$ is increasing or decreasing."},
          {"id": "D", "label": "D", "value": "$f$ has a local maximum somewhere in the interval.", "type": "text", "explanation": "Incorrect: concavity alone does not guarantee a local maximum exists."}
        ]$txt$,
        'B',
        $txt$Concave down means slopes are decreasing as $x$ increases, so $f'$ is decreasing on that interval.$txt$,
        '{connect_f_fprime_fdoubleprime}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Pure concept check: concave down ↔ f'' decreasing.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'connect_f_fprime_fdoubleprime', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'concavity_sign_error' FROM new_question;

-- ============================================================
-- 3. QUESTIONS (5.10 - Optimization)
-- ============================================================

DELETE FROM public.questions WHERE title IN (
    'U5.10-P1', 'U5.10-P2', 'U5.10-P3', 'U5.10-P4', 'U5.10-P5'
);

-- U5.10-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.10-P1', 'Both', 'ABBC_Analytical', '5.10', '5.10', 'MCQ', FALSE,
        2, 150, '{optimization_modeling}', '{optimization_variable_not_defined}', 'text',
        $txt$In an optimization setup, which choice is the best example of correctly defining the decision variable?$txt$,
        $txt$In an optimization setup, which choice is the best example of correctly defining the decision variable?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Let $x$ be the maximum value.", "type": "text", "explanation": "Incorrect: the maximum value is the objective result, not the decision variable."},
          {"id": "B", "label": "B", "value": "Let $x$ be the quantity you can choose or control (with units), such as a length or time.", "type": "text", "explanation": "Correct: the decision variable is what you can choose/control (with meaning and units)."},
          {"id": "C", "label": "C", "value": "Let $x$ be the final answer.", "type": "text", "explanation": "Incorrect: the final answer is not the variable definition."},
          {"id": "D", "label": "D", "value": "Let $x$ be the derivative.", "type": "text", "explanation": "Incorrect: the derivative is a tool, not the variable to define."}
        ]$txt$,
        'B',
        $txt$Optimization begins by defining a controllable variable with clear meaning and units. The objective value is then written as a function of that variable.$txt$,
        '{optimization_modeling}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Common early fail: variable not clearly defined.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_modeling', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit5', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_variable_not_defined' FROM new_question;

-- U5.10-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.10-P2', 'Both', 'ABBC_Analytical', '5.10', '5.10', 'MCQ', FALSE,
        3, 210, '{optimization_modeling}', '{optimization_constraint_missing}', 'text',
        $txt$A rectangle has perimeter $20$. Let $x$ be one side length. Which equation correctly expresses the other side length $y$ in terms of $x$?$txt$,
        $txt$A rectangle has perimeter $20$. Let $x$ be one side length. Which equation correctly expresses the other side length $y$ in terms of $x$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$y=20-x$", "type": "text", "explanation": "Incorrect: would correspond to $x+y=20$, not perimeter 20."},
          {"id": "B", "label": "B", "value": "$y=10-x$", "type": "text", "explanation": "Correct: $2x+2y=20$ implies $y=10-x$."},
          {"id": "C", "label": "C", "value": "$y=20-2x$", "type": "text", "explanation": "Incorrect: would correspond to $2x+y=20$."},
          {"id": "D", "label": "D", "value": "$y=10-2x$", "type": "text", "explanation": "Incorrect: would correspond to $2x+y=10$."}
        ]$txt$,
        'B',
        $txt$Perimeter 20 means $2x+2y=20$, so $x+y=10$ and $y=10-x$.$txt$,
        '{optimization_modeling}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Constraint equation is the core modeling step.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_modeling', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'candidates_test_absolute', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_constraint_missing' FROM new_question;

-- U5.10-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.10-P3', 'Both', 'ABBC_Analytical', '5.10', '5.10', 'MCQ', FALSE,
        3, 240, '{optimization_modeling}', '{optimization_domain_missing}', 'image',
        $txt$Refer to the provided rectangle diagram for U5.10-P3. A rectangle has perimeter 20. If $x$ and $y$ are side lengths, which interval correctly describes the feasible domain of $x$?$txt$,
        $txt$Refer to the provided rectangle diagram for U5.10-P3. A rectangle has perimeter 20. If $x$ and $y$ are side lengths, which interval correctly describes the feasible domain of $x$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$0<x<10$", "type": "text", "explanation": "Correct: $x$ must keep $y=10-x$ positive, so $0<x<10$."},
          {"id": "B", "label": "B", "value": "$0<x<20$", "type": "text", "explanation": "Incorrect: $x$ cannot exceed 10 or $y$ becomes nonpositive."},
          {"id": "C", "label": "C", "value": "$-10<x<10$", "type": "text", "explanation": "Incorrect: side lengths cannot be negative."},
          {"id": "D", "label": "D", "value": "$x>0$ only", "type": "text", "explanation": "Incorrect: $x>0$ alone is not enough; need $y>0$ too."}
        ]$txt$,
        'A',
        $txt$With $2x+2y=20$, we have $y=10-x$. For a non-degenerate rectangle, both $x>0$ and $y>0$, so $0<x<10$.$txt$,
        '{optimization_modeling}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Diagram file: U5_5.10-P3_diagram.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_modeling', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'optimization_solve_and_check', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_domain_missing' FROM new_question;

-- U5.10-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.10-P4', 'Both', 'ABBC_Analytical', '5.10', '5.10', 'MCQ', FALSE,
        3, 210, '{optimization_solve_and_check}', '{absolute_extrema_compare_error}', 'image',
        $txt$Refer to the provided data table for U5.10-P4 showing several values of $x$ and the corresponding objective value $A(x)$. Based on the table, which $x$ gives the largest $A(x)$ among the listed choices?$txt$,
        $txt$Refer to the provided data table for U5.10-P4 showing several values of $x$ and the corresponding objective value $A(x)$. Based on the table, which $x$ gives the largest $A(x)$ among the listed choices?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=4$", "type": "text", "explanation": "Incorrect: $A(4)$ is smaller than $A(6)$ in the table."},
          {"id": "B", "label": "B", "value": "$x=6$", "type": "text", "explanation": "Correct: $A(6)$ is the maximum value shown."},
          {"id": "C", "label": "C", "value": "$x=8$", "type": "text", "explanation": "Incorrect: $A(8)$ is smaller than $A(6)$ in the table."},
          {"id": "D", "label": "D", "value": "$x=10$", "type": "text", "explanation": "Incorrect: $A(10)$ is smaller than $A(6)$ in the table."}
        ]$txt$,
        'B',
        $txt$The table shows $A(6)=72$, which is larger than the other listed objective values, so $x=6$ gives the largest $A(x)$ among the provided candidates.$txt$,
        '{optimization_solve_and_check}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Table file: U5_5.10-P4_table.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_solve_and_check', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'candidates_test_absolute', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'absolute_extrema_compare_error' FROM new_question;

-- U5.10-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.10-P5', 'Both', 'ABBC_Analytical', '5.10', '5.10', 'MCQ', FALSE,
        4, 270, '{optimization_solve_and_check}', '{optimization_domain_missing}', 'image',
        $txt$Refer to the provided graph of the objective function $A(x)$ for U5.10-P5. On the feasible interval $0<x<12$, at approximately what x-value does $A(x)$ attain its maximum?$txt$,
        $txt$Refer to the provided graph of the objective function $A(x)$ for U5.10-P5. On the feasible interval $0<x<12$, at approximately what x-value does $A(x)$ attain its maximum?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x\\approx2$", "type": "text", "explanation": "Incorrect: the graph is still rising at $x\\approx2$."},
          {"id": "B", "label": "B", "value": "$x\\approx4$", "type": "text", "explanation": "Incorrect: the peak occurs later than $x\\approx4$."},
          {"id": "C", "label": "C", "value": "$x\\approx6$", "type": "text", "explanation": "Correct: the highest point is near $x\\approx6$."},
          {"id": "D", "label": "D", "value": "$x\\approx10$", "type": "text", "explanation": "Incorrect: the graph is lower by $x\\approx10$."}
        ]$txt$,
        'C',
        $txt$From the graph, $A(x)$ reaches its peak near $x=6$ (the vertex of the curve). This is the maximum on the feasible interval shown.$txt$,
        '{optimization_solve_and_check}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Graph file: U5_5.10-P5_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'optimization_solve_and_check', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'candidates_test_absolute', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'optimization_domain_missing' FROM new_question;

COMMIT;
