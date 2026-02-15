-- Consolidated Insert Script for Unit 5.3 and 5.4
-- Includes Skills/Metadata to ensure Foreign Key constraints are met.
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

-- Insert Skills (Idempotent)
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('mvt_conditions', 'Mean Value Theorem Conditions (Continuity & Differentiability)', 'ABBC_Analytical', '{}'),
('mvt_application', 'Applying Mean Value Theorem (Finding c)', 'ABBC_Analytical', '{"mvt_conditions"}'),
('avg_vs_instant_rate_link', 'Linking Average and Instantaneous Rates (MVT Context)', 'ABBC_Analytical', '{"mvt_application"}'),
('evt_application', 'Extreme Value Theorem Application (Existence of Extrema)', 'ABBC_Analytical', '{}'),
('candidates_test_absolute', 'Candidates Test for Absolute Extrema (Endpoints & Critical Points)', 'ABBC_Analytical', '{"evt_application"}'),
('global_vs_local_extrema', 'Distinguishing Global vs Local Extrema', 'ABBC_Analytical', '{"candidates_test_absolute"}'),
('critical_points_find', 'Finding Critical Points (Derivative is 0 or Undefined)', 'ABBC_Analytical', '{}'),
('method_selection_unit5', 'Strategy Selection for Unit 5 (MVT vs EVT vs IVT)', 'ABBC_Analytical', '{}'),
('increasing_decreasing_from_derivative', 'Determining Increasing/Decreasing Intervals from f''', 'ABBC_Analytical', '{"critical_points_find"}'),
('first_derivative_test', 'First Derivative Test for Local Extrema', 'ABBC_Analytical', '{"increasing_decreasing_from_derivative"}')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;

-- Insert Error Tags (Idempotent)
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('mvt_conditions_missed', 'Missing Conditions for MVT (Continuity/Differentiability)', 'MVT', 3, 'ABBC_Analytical'),
('mvt_conclusion_misread', 'Misinterpreting MVT Conclusion (f''(c) vs Average Rate)', 'MVT', 3, 'ABBC_Analytical'),
('evt_requires_closed_interval_missed', 'Applying EVT to Open Interval (Missing Closed Interval Condition)', 'EVT', 4, 'ABBC_Analytical'),
('candidates_test_missing_endpoints', 'Forgetting to Check Endpoints in Candidates Test', 'Optimization', 4, 'ABBC_Analytical'),
('global_vs_local_confusion', 'Confusing Local Max/Min with Absolute Max/Min', 'Optimization', 3, 'ABBC_Analytical'),
('absolute_extrema_compare_error', 'Error Comparing Values for Absolute Extrema', 'Optimization', 2, 'ABBC_Analytical'),
('sign_chart_interval_error', 'Misinterpreting Sign Chart Intervals', 'Analysis', 3, 'ABBC_Analytical'),
('critical_points_incomplete', 'Missing Critical Points (e.g. Undefined F'')', 'Analysis', 4, 'ABBC_Analytical'),
('increasing_decreasing_sign_flipped', 'Confusing f''>0 with f''<0 (Inc vs Dec)', 'Analysis', 3, 'ABBC_Analytical'),
('wrong_method_choice_unit5', 'Choosing Wrong Method (Local vs Global Tools)', 'Strategy', 3, 'ABBC_Analytical'),
('first_derivative_test_misapplied', 'Misapplying First Derivative Test (Sign Change)', 'Analysis', 4, 'ABBC_Analytical')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;


-- ============================================================
-- 2. QUESTIONS (5.3 - Increasing/Decreasing)
-- ============================================================

-- Clean up
DELETE FROM public.questions WHERE title IN (
    'U5.3-P1', 'U5.3-P2', 'U5.3-P3', 'U5.3-P4', 'U5.3-P5'
);

-- U5.3-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.3-P1', 'Both', 'ABBC_Analytical', '5.3', '5.3', 'MCQ', FALSE,
        2, 120, '{increasing_decreasing_from_derivative}', '{sign_chart_interval_error}', 'text',
        $txt$Let $f$ be differentiable on $(-3,3)$ with $f'(x)=(x-1)(x+2)$. On which interval(s) is $f$ increasing?$txt$,
        $txt$Let $f$ be differentiable on $(-3,3)$ with $f'(x)=(x-1)(x+2)$. On which interval(s) is $f$ increasing?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(-3,-2)$ and $(1,3)$", "type": "text", "explanation": "Correct: $f'(x)$ is positive on $(-3,-2)$ and $(1,3)$."},
          {"id": "B", "label": "B", "value": "$(-2,1)$ only", "type": "text", "explanation": "Incorrect: on $(-2,1)$, $(x-1)(x+2)$ is negative, so $f$ is decreasing."},
          {"id": "C", "label": "C", "value": "$(-3,1)$ only", "type": "text", "explanation": "Incorrect: $f$ is decreasing on $(-2,1)$, so it cannot be increasing on all of $(-3,1)$."},
          {"id": "D", "label": "D", "value": "$(-3,-2)$ and $(-2,1)$", "type": "text", "explanation": "Incorrect: $(-2,1)$ is decreasing, not increasing."}
        ]$txt$,
        'A',
        $txt$f is increasing where $f'(x)>0$. The critical numbers are $x=-2$ and $x=1$. Testing intervals shows $f'(x)>0$ on $(-3,-2)$ and $(1,3)$, and $f'(x)<0$ on $(-2,1)$.$txt$,
        '{increasing_decreasing_from_derivative}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Requires splitting intervals at critical points (f''=0).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'increasing_decreasing_from_derivative', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sign_chart_interval_error' FROM new_question;

-- U5.3-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.3-P2', 'Both', 'ABBC_Analytical', '5.3', '5.3', 'MCQ', FALSE,
        3, 150, '{increasing_decreasing_from_derivative}', '{critical_points_incomplete}', 'text',
        $txt$Let $f$ be differentiable on $(-5,5)$ except possibly at $x=-2$ and $x=2$, and suppose

$f'(x)=\frac{x-2}{x^2-4}$.

On which interval(s) is $f$ increasing?$txt$,
        $txt$Let $f$ be differentiable on $(-5,5)$ except possibly at $x=-2$ and $x=2$, and suppose

$f'(x)=\frac{x-2}{x^2-4}$.

On which interval(s) is $f$ increasing?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(-5,-2)$ only", "type": "text", "explanation": "Incorrect: for $x<-2$, $1/(x+2)$ is negative, so $f$ is decreasing there."},
          {"id": "B", "label": "B", "value": "$(-2,2)$ and $(2,5)$", "type": "text", "explanation": "Correct: $f'(x)>0$ for $x>-2$, but you must split at $x=2$ because $f$ may not be differentiable there."},
          {"id": "C", "label": "C", "value": "$(-5,-2)$ and $(-2,2)$", "type": "text", "explanation": "Incorrect: $(-5,-2)$ is decreasing, not increasing."},
          {"id": "D", "label": "D", "value": "$(-5,2)$ and $(2,5)$", "type": "text", "explanation": "Incorrect: you must exclude $x=-2$ and $x=2$, so you cannot combine across them."}
        ]$txt$,
        'B',
        $txt$Factor $x^2-4=(x-2)(x+2)$. For $x\neq\pm 2$, $f'(x)=\frac{x-2}{(x-2)(x+2)}=\frac{1}{x+2}$. This is positive when $x>-2$ and negative when $x<-2$. Because $x=2$ is excluded, the increasing region splits into $(-2,2)$ and $(2,5)$.$txt$,
        '{increasing_decreasing_from_derivative}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Common trap: missing where f'' is undefined; must split intervals.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'increasing_decreasing_from_derivative', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'critical_points_incomplete' FROM new_question;

-- U5.3-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.3-P3', 'Both', 'ABBC_Analytical', '5.3', '5.3', 'MCQ', FALSE,
        2, 90, '{increasing_decreasing_from_derivative}', '{increasing_decreasing_sign_flipped}', 'text',
        $txt$Refer to the provided sign chart for $f'(x)$.

On which interval is $f$ decreasing?$txt$,
        $txt$Refer to the provided sign chart for $f'(x)$.

On which interval is $f$ decreasing?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(-\\infty, -1)$", "type": "text", "explanation": "Incorrect: the sign chart shows $f'(x)$ is positive there."},
          {"id": "B", "label": "B", "value": "$(-1, 2)$", "type": "text", "explanation": "Correct: $f'(x)$ is negative on $(-1,2)$."},
          {"id": "C", "label": "C", "value": "$(2, \\infty)$", "type": "text", "explanation": "Incorrect: the sign chart shows $f'(x)$ is positive there."},
          {"id": "D", "label": "D", "value": "$f$ is never decreasing", "type": "text", "explanation": "Incorrect: the chart clearly shows a negative interval."}
        ]$txt$,
        'B',
        $txt$A function decreases where its derivative is negative. The sign chart shows $f'(x)$ is negative on $(-1,2)$, so $f$ is decreasing on that interval.$txt$,
        '{increasing_decreasing_from_derivative}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Table file: U5_5.3-P3_table.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'increasing_decreasing_from_derivative', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'increasing_decreasing_sign_flipped' FROM new_question;

-- U5.3-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.3-P4', 'Both', 'ABBC_Analytical', '5.3', '5.3', 'MCQ', FALSE,
        3, 150, '{increasing_decreasing_from_derivative}', '{sign_chart_interval_error}', 'text',
        $txt$Refer to the provided graph of $f'(x)$ on the interval $[-4,4]$.

On which interval(s) is $f$ increasing?$txt$,
        $txt$Refer to the provided graph of $f'(x)$ on the interval $[-4,4]$.

On which interval(s) is $f$ increasing?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(-4,-1)$ and $(2,4)$", "type": "text", "explanation": "Correct: $f'(x)$ is above the x-axis on those two intervals."},
          {"id": "B", "label": "B", "value": "$(-1,2)$ only", "type": "text", "explanation": "Incorrect: on $(-1,2)$ the graph is below the x-axis, so $f$ is decreasing."},
          {"id": "C", "label": "C", "value": "$(-4,2)$ only", "type": "text", "explanation": "Incorrect: $f'(x)$ changes sign at $x=-1$ and $x=2$, so $f$ cannot be increasing on all of $(-4,2)$."},
          {"id": "D", "label": "D", "value": "$(-4,-1)$ only", "type": "text", "explanation": "Incorrect: $f$ is also increasing on $(2,4)$."}
        ]$txt$,
        'A',
        $txt$f is increasing where $f'(x)>0$, meaning the graph of $f'(x)$ lies above the x-axis. From the graph, $f'(x)>0$ on $(-4,-1)$ and $(2,4)$.$txt$,
        '{increasing_decreasing_from_derivative}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph file: U5_5.3-P4_graph.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'increasing_decreasing_from_derivative', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sign_chart_interval_error' FROM new_question;

-- U5.3-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.3-P5', 'Both', 'ABBC_Analytical', '5.3', '5.3', 'MCQ', FALSE,
        2, 120, '{increasing_decreasing_from_derivative,method_selection_unit5}', '{wrong_method_choice_unit5}', 'text',
        $txt$A differentiable function $f$ satisfies $f'(x)<0$ for $x<0$ and $f'(x)>0$ for $x>0$. Which statement must be true?$txt$,
        $txt$A differentiable function $f$ satisfies $f'(x)<0$ for $x<0$ and $f'(x)>0$ for $x>0$. Which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has an absolute minimum at $x=0$.", "type": "text", "explanation": "Incorrect: the sign change guarantees a local minimum, not necessarily an absolute minimum."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=0$.", "type": "text", "explanation": "Correct: decreasing then increasing implies a local minimum at $0$."},
          {"id": "C", "label": "C", "value": "$f$ has a local maximum at $x=0$.", "type": "text", "explanation": "Incorrect: a local maximum would require increasing then decreasing (positive to negative)."},
          {"id": "D", "label": "D", "value": "$f$ is decreasing for all $x$.", "type": "text", "explanation": "Incorrect: $f'(x)>0$ for $x>0$ means $f$ is increasing on $(0,\\infty)$."}
        ]$txt$,
        'B',
        $txt$Since $f'(x)$ changes from negative to positive at $x=0$, $f$ changes from decreasing to increasing there. That guarantees a local minimum at $x=0$ by the first-derivative sign behavior.$txt$,
        '{increasing_decreasing_from_derivative}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Supportive skill helps with choosing the right conclusion (local vs absolute).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'increasing_decreasing_from_derivative', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit5', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit5' FROM new_question;

-- ============================================================
-- 3. QUESTIONS (5.4 - First Derivative Test)
-- ============================================================

-- Clean up
DELETE FROM public.questions WHERE title IN (
    'U5.4-P1', 'U5.4-P2', 'U5.4-P3', 'U5.4-P4', 'U5.4-P5'
);

-- U5.4-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.4-P1', 'Both', 'ABBC_Analytical', '5.4', '5.4', 'MCQ', FALSE,
        1, 60, '{first_derivative_test}', '{first_derivative_test_misapplied}', 'text',
        $txt$Suppose $f$ is differentiable and $f'(x)$ changes sign from positive to negative at $x=2$. What does the First Derivative Test imply about $f$ at $x=2$?$txt$,
        $txt$Suppose $f$ is differentiable and $f'(x)$ changes sign from positive to negative at $x=2$. What does the First Derivative Test imply about $f$ at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=2$.", "type": "text", "explanation": "Correct: increasing then decreasing implies a local maximum."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=2$.", "type": "text", "explanation": "Incorrect: a local minimum needs negative to positive."},
          {"id": "C", "label": "C", "value": "$f$ has an inflection point at $x=2$.", "type": "text", "explanation": "Incorrect: inflection depends on concavity change, not $f'$ sign change alone."},
          {"id": "D", "label": "D", "value": "$f$ has no local extrema at $x=2$.", "type": "text", "explanation": "Incorrect: a sign change in $f'$ indicates a local extremum."}
        ]$txt$,
        'A',
        $txt$If $f'(x)$ changes from positive to negative, $f$ changes from increasing to decreasing, which means $f$ has a local maximum at that point.$txt$,
        '{first_derivative_test}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'first_derivative_test', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'first_derivative_test_misapplied' FROM new_question;

-- U5.4-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.4-P2', 'Both', 'ABBC_Analytical', '5.4', '5.4', 'MCQ', FALSE,
        3, 150, '{first_derivative_test,critical_points_find}', '{critical_points_incomplete}', 'text',
        $txt$Let $f(x)=x^3-3x^2+2$. Which statement about local extrema is correct?$txt$,
        $txt$Let $f(x)=x^3-3x^2+2$. Which statement about local extrema is correct?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Local max at $x=0$ and local min at $x=2$.", "type": "text", "explanation": "Correct: $f'$ changes + to - at $0$ (max) and - to + at $2$ (min)."},
          {"id": "B", "label": "B", "value": "Local min at $x=0$ and local max at $x=2$.", "type": "text", "explanation": "Incorrect: it reverses the sign-change conclusions."},
          {"id": "C", "label": "C", "value": "Local maxima at both $x=0$ and $x=2$.", "type": "text", "explanation": "Incorrect: a max needs + to -; at $x=2$ it is - to + (min)."},
          {"id": "D", "label": "D", "value": "No local extrema occur.", "type": "text", "explanation": "Incorrect: sign changes at both critical points indicate local extrema."}
        ]$txt$,
        'A',
        $txt$f'(x)=3x^2-6x=3x(x-2). The sign of $f'$ is positive on $(-\\infty,0)$, negative on $(0,2)$, and positive on $(2,\\infty)$. So $f$ has a local maximum at $x=0$ and a local minimum at $x=2$.$txt$,
        '{first_derivative_test}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Requires finding critical points then applying sign test.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'first_derivative_test', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'critical_points_incomplete' FROM new_question;

-- U5.4-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.4-P3', 'Both', 'ABBC_Analytical', '5.4', '5.4', 'MCQ', FALSE,
        4, 180, '{first_derivative_test,critical_points_find}', '{first_derivative_test_misapplied}', 'text',
        $txt$Suppose $f$ is differentiable and $f'(x)=(x+1)^2(x-3)$. Which statement is true?$txt$,
        $txt$Suppose $f$ is differentiable and $f'(x)=(x+1)^2(x-3)$. Which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=-1$ and a local minimum at $x=3$.", "type": "text", "explanation": "Incorrect: $x=-1$ does not cause a sign change in $f'$."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=-1$ and a local maximum at $x=3$.", "type": "text", "explanation": "Incorrect: $x=3$ is a local minimum, not a maximum."},
          {"id": "C", "label": "C", "value": "$f$ has a local minimum at $x=3$, and $x=-1$ is not a local extremum.", "type": "text", "explanation": "Correct: only $x=3$ has a sign change (- to +), so it is a local minimum; $x=-1$ is not an extremum."},
          {"id": "D", "label": "D", "value": "$f$ has local extrema at both $x=-1$ and $x=3$, but their types cannot be determined.", "type": "text", "explanation": "Incorrect: the first derivative test does determine the type when there is a sign change."}
        ]$txt$,
        'C',
        $txt$Critical points are $x=-1$ and $x=3$. Since $(x+1)^2\\ge 0$, the sign of $f'(x)$ is determined by $(x-3)$ except that $f'(x)=0$ at $x=-1$. For $x<3$, $f'(x)<0$; for $x>3$, $f'(x)>0$. There is no sign change at $x=-1$, so no local extremum there. At $x=3$, $f'$ changes from negative to positive, giving a local minimum.$txt$,
        '{first_derivative_test}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Multiplicity trap: critical point may not be extremum without sign change.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'first_derivative_test', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'first_derivative_test_misapplied' FROM new_question;

-- U5.4-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.4-P4', 'Both', 'ABBC_Analytical', '5.4', '5.4', 'MCQ', FALSE,
        3, 150, '{first_derivative_test}', '{first_derivative_test_misapplied}', 'text',
        $txt$Refer to the provided graph of $f'(x)$.

At which x-value does $f$ have a local maximum?$txt$,
        $txt$Refer to the provided graph of $f'(x)$.

At which x-value does $f$ have a local maximum?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=-2$", "type": "text", "explanation": "Incorrect: at $x=-2$, $f'(x)$ changes from negative to positive (local minimum)."},
          {"id": "B", "label": "B", "value": "$x=1$", "type": "text", "explanation": "Correct: at $x=1$, $f'(x)$ changes from positive to negative (local maximum)."},
          {"id": "C", "label": "C", "value": "$x=4$", "type": "text", "explanation": "Incorrect: at $x=4$, $f'(x)$ changes from negative to positive (local minimum)."},
          {"id": "D", "label": "D", "value": "None of these", "type": "text", "explanation": "Incorrect: $x=1$ is a local maximum based on the sign change."}
        ]$txt$,
        'B',
        $txt$A local maximum occurs where $f'(x)$ changes from positive to negative. From the graph, $f'(x)$ crosses the x-axis from above to below at $x=1$, indicating a local maximum there.$txt$,
        '{first_derivative_test}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph file: U5_5.4-P4_graph.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'first_derivative_test', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'first_derivative_test_misapplied' FROM new_question;

-- U5.4-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.4-P5', 'Both', 'ABBC_Analytical', '5.4', '5.4', 'MCQ', FALSE,
        2, 120, '{first_derivative_test,increasing_decreasing_from_derivative}', '{first_derivative_test_misapplied}', 'text',
        $txt$A differentiable function $f$ has $f'(x)>0$ on $(-5,-1)$, $f'(x)<0$ on $(-1,2)$, and $f'(x)<0$ on $(2,5)$. Which statement is true?$txt$,
        $txt$A differentiable function $f$ has $f'(x)>0$ on $(-5,-1)$, $f'(x)<0$ on $(-1,2)$, and $f'(x)<0$ on $(2,5)$. Which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=-1$, and no local extremum at $x=2$.", "type": "text", "explanation": "Correct: + to - at -1 gives a local max; no sign change at 2 gives no extremum."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=-1$, and a local maximum at $x=2$.", "type": "text", "explanation": "Incorrect: -1 is a local max, not a local min; and there is no sign change at 2."},
          {"id": "C", "label": "C", "value": "$f$ has local minima at both $x=-1$ and $x=2$.", "type": "text", "explanation": "Incorrect: -1 is not a minimum, and 2 is not an extremum."},
          {"id": "D", "label": "D", "value": "$f$ has a local maximum at $x=2$.", "type": "text", "explanation": "Incorrect: a maximum requires + to -; at 2 the sign is negative on both sides."}
        ]$txt$,
        'A',
        $txt$At $x=-1$, $f'$ changes from positive to negative, so $f$ has a local maximum there. At $x=2$, $f'$ is negative on both sides, so there is no sign change and thus no local extremum at $x=2$.$txt$,
        '{first_derivative_test}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Good for reinforcing: critical point without sign change is not an extremum.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'first_derivative_test', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'increasing_decreasing_from_derivative', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'first_derivative_test_misapplied' FROM new_question;

COMMIT;
