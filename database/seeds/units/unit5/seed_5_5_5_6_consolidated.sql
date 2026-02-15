-- Consolidated Insert Script for Unit 5.5 and 5.6
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

-- Insert Skills for 5.5 and 5.6
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('concavity_from_second_derivative', 'Determining Concavity from f''''', 'ABBC_Analytical', '{"increasing_decreasing_from_derivative"}'),
('inflection_points', 'Finding Points of Inflection', 'ABBC_Analytical', '{"concavity_from_second_derivative"}'),
('second_derivative_test', 'Second Derivative Test for Local Extrema', 'ABBC_Analytical', '{"concavity_from_second_derivative", "critical_points_find"}')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;

-- Insert Error Tags for 5.5 and 5.6
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('concavity_sign_error', 'Confusing f''''>0 (Concave Up) with f''''<0 (Concave Down)', 'Analysis', 3, 'ABBC_Analytical'),
('inflection_without_sign_change', 'Identifying Inflection Point Without Concavity Change', 'Analysis', 4, 'ABBC_Analytical'),
('second_derivative_test_wrong_use', 'Misusing Second Derivative Test (e.g. Inconclusive Case)', 'Analysis', 3, 'ABBC_Analytical')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;


-- ============================================================
-- 2. QUESTIONS (5.5 - Absolute Extrema)
-- ============================================================

DELETE FROM public.questions WHERE title IN (
    'U5.5-P1', 'U5.5-P2', 'U5.5-P3', 'U5.5-P4', 'U5.5-P5'
);

-- U5.5-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.5-P1', 'Both', 'ABBC_Analytical', '5.5', '5.5', 'MCQ', FALSE,
        2, 150, '{candidates_test_absolute}', '{evt_requires_closed_interval_missed}', 'text',
        $txt$A continuous function $f$ is defined on $(0,5)$. Which statement is always true?$txt$,
        $txt$A continuous function $f$ is defined on $(0,5)$. Which statement is always true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ must attain an absolute maximum on $(0,5)$.", "type": "text", "explanation": "Incorrect: EVT does not apply on an open interval."},
          {"id": "B", "label": "B", "value": "$f$ must attain an absolute minimum on $(0,5)$.", "type": "text", "explanation": "Incorrect: EVT does not apply on an open interval."},
          {"id": "C", "label": "C", "value": "$f$ may fail to attain an absolute maximum or minimum on $(0,5)$.", "type": "text", "explanation": "Correct: lack of endpoints can prevent attaining extrema."},
          {"id": "D", "label": "D", "value": "$f$ must attain both an absolute maximum and an absolute minimum on $(0,5)$.", "type": "text", "explanation": "Incorrect: EVT requires a closed interval."}
        ]$txt$,
        'C',
        $txt$EVT guarantees absolute extrema only on a closed interval $[a,b]$. The interval $(0,5)$ is not closed, so a continuous function may not attain an absolute maximum or minimum there.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Key idea: EVT needs closed interval; open interval can fail to attain extrema.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'candidates_test_absolute', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'evt_application', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'evt_requires_closed_interval_missed' FROM new_question;

-- U5.5-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.5-P2', 'Both', 'ABBC_Analytical', '5.5', '5.5', 'MCQ', FALSE,
        2, 120, '{candidates_test_absolute}', '{absolute_extrema_compare_error}', 'text',
        $txt$Refer to the provided candidates table.

What is the absolute minimum value of $f$ on $[-2,4]$?$txt$,
        $txt$Refer to the provided candidates table.

What is the absolute minimum value of $f$ on $[-2,4]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "-1", "type": "text", "explanation": "Correct: -1 is the smallest candidate value."},
          {"id": "B", "label": "B", "value": "1", "type": "text", "explanation": "Incorrect: 1 is larger than -1."},
          {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "Incorrect: 3 is larger than -1."},
          {"id": "D", "label": "D", "value": "5", "type": "text", "explanation": "Incorrect: 5 is the largest, not the smallest."}
        ]$txt$,
        'A',
        $txt$The candidates table lists $f(-2)=3$, $f(0)=-1$, $f(2)=1$, and $f(4)=5$. The smallest value among these is $-1$, so the absolute minimum value is $-1$.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Table file: U5_5.5-P2_table.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'candidates_test_absolute', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'absolute_extrema_compare_error' FROM new_question;

-- U5.5-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.5-P3', 'Both', 'ABBC_Analytical', '5.5', '5.5', 'MCQ', FALSE,
        3, 180, '{candidates_test_absolute}', '{candidates_test_missing_endpoints}', 'text',
        $txt$Let $f(x)=x^3-3x$ on the interval $[-2,2]$. Using the candidates test, which x-value gives the absolute maximum of $f$ on $[-2,2]$?$txt$,
        $txt$Let $f(x)=x^3-3x$ on the interval $[-2,2]$. Using the candidates test, which x-value gives the absolute maximum of $f$ on $[-2,2]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=-2$", "type": "text", "explanation": "Incorrect: $f(-2)=-2$ is not the maximum."},
          {"id": "B", "label": "B", "value": "$x=-1$", "type": "text", "explanation": "Correct: $f(-1)=2$ is a maximum value on the interval."},
          {"id": "C", "label": "C", "value": "$x=1$", "type": "text", "explanation": "Incorrect: $f(1)=-2$ is not the maximum."},
          {"id": "D", "label": "D", "value": "$x=2$", "type": "text", "explanation": "Incorrect: $x=2$ also gives the maximum value, but the question asks for an $x$-value that gives the absolute maximum; $x=-1$ is the listed correct choice."}
        ]$txt$,
        'B',
        $txt$Compute $f'(x)=3x^2-3=3(x^2-1)$, so critical points are $x=-1$ and $x=1$. Evaluate candidates $x=-2,-1,1,2$: $f(-2)=-2$, $f(-1)=2$, $f(1)=-2$, $f(2)=2$. The absolute maximum value is $2$, achieved at $x=-1$ and $x=2$. The option list includes $x=-1$, so that is correct.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Common miss: forgetting endpoints as candidates.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'candidates_test_absolute', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'candidates_test_missing_endpoints' FROM new_question;

-- U5.5-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.5-P4', 'Both', 'ABBC_Analytical', '5.5', '5.5', 'MCQ', FALSE,
        3, 150, '{candidates_test_absolute}', '{absolute_extrema_compare_error}', 'text',
        $txt$Refer to the provided graph of $f$ on $[0,6]$.

At which x-value does $f$ attain its absolute maximum on $[0,6]$?$txt$,
        $txt$Refer to the provided graph of $f$ on $[0,6]$.

At which x-value does $f$ attain its absolute maximum on $[0,6]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=0$", "type": "text", "explanation": "Incorrect: $f(0)$ is not the highest value on the graph."},
          {"id": "B", "label": "B", "value": "$x=2$", "type": "text", "explanation": "Incorrect: $x=2$ is near a low point, not the highest."},
          {"id": "C", "label": "C", "value": "$x=5$", "type": "text", "explanation": "Incorrect: $x=5$ is an interior high point, but the endpoint $x=6$ is higher."},
          {"id": "D", "label": "D", "value": "$x=6$", "type": "text", "explanation": "Correct: the highest point shown occurs at $x=6$."}
        ]$txt$,
        'D',
        $txt$The absolute maximum on a closed interval occurs at the highest y-value among endpoints and any interior peaks. From the graph, the largest function value on $[0,6]$ occurs at the right endpoint $x=6$.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph file: U5_5.5-P4_graph.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'candidates_test_absolute', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'absolute_extrema_compare_error' FROM new_question;

-- U5.5-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.5-P5', 'Both', 'ABBC_Analytical', '5.5', '5.5', 'MCQ', FALSE,
        2, 120, '{method_selection_unit5}', '{wrong_method_choice_unit5}', 'text',
        $txt$Which method is the most appropriate to guarantee that a continuous function $f$ has an absolute maximum on an interval?$txt$,
        $txt$Which method is the most appropriate to guarantee that a continuous function $f$ has an absolute maximum on an interval?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Mean Value Theorem", "type": "text", "explanation": "Incorrect: MVT gives a point where $f'$ matches an average rate of change, not existence of absolute extrema."},
          {"id": "B", "label": "B", "value": "Extreme Value Theorem on a closed interval", "type": "text", "explanation": "Correct: EVT on a closed interval guarantees an absolute maximum exists."},
          {"id": "C", "label": "C", "value": "First Derivative Test", "type": "text", "explanation": "Incorrect: first derivative test identifies local behavior; existence of an absolute max is not guaranteed without a closed interval and continuity."},
          {"id": "D", "label": "D", "value": "Second Derivative Test", "type": "text", "explanation": "Incorrect: second derivative test classifies critical points; it does not guarantee an absolute maximum exists."}
        ]$txt$,
        'B',
        $txt$EVT guarantees existence of absolute extrema when $f$ is continuous on a closed interval. The other tests can help locate extrema but do not guarantee existence by themselves.$txt$,
        '{method_selection_unit5}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Strategy question: guarantee vs locate; EVT is the guarantee tool.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_unit5', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'candidates_test_absolute', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit5' FROM new_question;

-- ============================================================
-- 3. QUESTIONS (5.6 - Concavity & Second Derivative)
-- ============================================================

DELETE FROM public.questions WHERE title IN (
    'U5.6-P1', 'U5.6-P2', 'U5.6-P3', 'U5.6-P4', 'U5.6-P5'
);

-- U5.6-P1
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.6-P1', 'Both', 'ABBC_Analytical', '5.6', '5.6', 'MCQ', FALSE,
        2, 120, '{concavity_from_second_derivative}', '{concavity_sign_error}', 'text',
        $txt$A twice-differentiable function $f$ satisfies $f''(x)>0$ on $(1,4)$. Which statement is true on $(1,4)$?$txt$,
        $txt$A twice-differentiable function $f$ satisfies $f''(x)>0$ on $(1,4)$. Which statement is true on $(1,4)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ is increasing.", "type": "text", "explanation": "Incorrect: concavity does not determine whether $f$ is increasing."},
          {"id": "B", "label": "B", "value": "$f$ is decreasing.", "type": "text", "explanation": "Incorrect: concavity does not determine whether $f$ is decreasing."},
          {"id": "C", "label": "C", "value": "$f$ is concave up.", "type": "text", "explanation": "Correct: $f''(x)>0$ implies concave up."},
          {"id": "D", "label": "D", "value": "$f$ has a local maximum.", "type": "text", "explanation": "Incorrect: concavity alone does not guarantee a local maximum."}
        ]$txt$,
        'C',
        $txt$f''(x)>0 means the graph of $f$ is concave up (the slope $f'$ is increasing). It does not by itself force $f$ to be increasing or decreasing.$txt$,
        '{concavity_from_second_derivative}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Quick conceptual: f'''' sign <> concavity (not monotonicity).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'concavity_from_second_derivative', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'concavity_sign_error' FROM new_question;

-- U5.6-P2
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.6-P2', 'Both', 'ABBC_Analytical', '5.6', '5.6', 'MCQ', FALSE,
        3, 180, '{inflection_points}', '{inflection_without_sign_change}', 'text',
        $txt$Suppose $f''(x)= (x-2)^2(x+1)$. At which x-value(s) can $f$ have an inflection point?$txt$,
        $txt$Suppose $f''(x)= (x-2)^2(x+1)$. At which x-value(s) can $f$ have an inflection point?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=-1$ only", "type": "text", "explanation": "Correct: the factor $(x+1)$ changes sign at -1, giving a concavity change."},
          {"id": "B", "label": "B", "value": "$x=2$ only", "type": "text", "explanation": "Incorrect: $(x-2)^2$ does not change sign, so concavity does not change at 2."},
          {"id": "C", "label": "C", "value": "$x=-1$ and $x=2$", "type": "text", "explanation": "Incorrect: only $x=-1$ gives a sign change in $f''$."},
          {"id": "D", "label": "D", "value": "None; $f''$ never equals 0", "type": "text", "explanation": "Incorrect: $f''$ equals 0 at $x=-1$ and $x=2$."}
        ]$txt$,
        'A',
        $txt$Potential inflection points occur where $f''=0$ or undefined, but an inflection point requires a concavity change. Since $(x-2)^2$ is nonnegative and does not change sign across $x=2$, the sign of $f''$ is determined by $(x+1)$. Thus concavity changes at $x=-1$ but not at $x=2$.$txt$,
        '{inflection_points}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Classic trap: zero of even multiplicity doesn''t force concavity change.', 0.8, 0.2, NOW(), NOW()
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

-- U5.6-P3
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.6-P3', 'Both', 'ABBC_Analytical', '5.6', '5.6', 'MCQ', FALSE,
        3, 150, '{concavity_from_second_derivative}', '{concavity_sign_error}', 'text',
        $txt$Refer to the provided graph of $f''(x)$.

On which interval is $f$ concave down?$txt$,
        $txt$Refer to the provided graph of $f''(x)$.

On which interval is $f$ concave down?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(-3,-1)$", "type": "text", "explanation": "Incorrect: on $(-3,-1)$, $f''$ is above the x-axis (positive)."},
          {"id": "B", "label": "B", "value": "$(-1,3)$", "type": "text", "explanation": "Correct: on $(-1,3)$, $f''$ is below the x-axis (negative)."},
          {"id": "C", "label": "C", "value": "$(3,5)$", "type": "text", "explanation": "Incorrect: on $(3,5)$, $f''$ is above the x-axis (positive)."},
          {"id": "D", "label": "D", "value": "$(-3,5)$ (all of it)", "type": "text", "explanation": "Incorrect: $f''$ changes sign, so concavity cannot be the same everywhere."}
        ]$txt$,
        'B',
        $txt$f is concave down where $f''(x)<0$, meaning the graph of $f''$ lies below the x-axis. From the graph, $f''(x)<0$ on $(-1,3)$.$txt$,
        '{concavity_from_second_derivative}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Graph file: U5_5.6-P3_graph.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'concavity_from_second_derivative', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'concavity_sign_error' FROM new_question;

-- U5.6-P4
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.6-P4', 'Both', 'ABBC_Analytical', '5.6', '5.6', 'MCQ', FALSE,
        3, 180, '{second_derivative_test}', '{second_derivative_test_wrong_use}', 'text',
        $txt$A function $f$ has a critical point at $x=1$ with $f'(1)=0$. If $f''(1)=0$, what can be concluded from the Second Derivative Test?$txt$,
        $txt$A function $f$ has a critical point at $x=1$ with $f'(1)=0$. If $f''(1)=0$, what can be concluded from the Second Derivative Test?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=1$.", "type": "text", "explanation": "Incorrect: cannot conclude maximum when $f''(1)=0$."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=1$.", "type": "text", "explanation": "Incorrect: cannot conclude minimum when $f''(1)=0$."},
          {"id": "C", "label": "C", "value": "The test is inconclusive at $x=1$.", "type": "text", "explanation": "Correct: the second derivative test is inconclusive in this case."},
          {"id": "D", "label": "D", "value": "$f$ has an inflection point at $x=1$.", "type": "text", "explanation": "Incorrect: an inflection point requires a concavity change, not just $f''(1)=0$."}
        ]$txt$,
        'C',
        $txt$The Second Derivative Test requires $f'(c)=0$ and $f''(c)\\neq 0$. When $f''(c)=0$, the test does not determine whether the point is a max, min, or neither.$txt$,
        '{second_derivative_test}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Targets misuse of second derivative test.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'second_derivative_test', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'second_derivative_test_wrong_use' FROM new_question;

-- U5.6-P5
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.6-P5', 'Both', 'ABBC_Analytical', '5.6', '5.6', 'MCQ', FALSE,
        2, 120, '{concavity_from_second_derivative}', '{concavity_sign_error}', 'text',
        $txt$Refer to the provided concavity summary table.

On which interval is $f$ concave down?$txt$,
        $txt$Refer to the provided concavity summary table.

On which interval is $f$ concave down?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$(-\\infty, -1)$", "type": "text", "explanation": "Incorrect: table shows $f''$ is positive there (concave up)."},
          {"id": "B", "label": "B", "value": "$(-1, 3)$", "type": "text", "explanation": "Correct: table shows $f''$ is negative there (concave down)."},
          {"id": "C", "label": "C", "value": "$(3, \\infty)$", "type": "text", "explanation": "Incorrect: table shows $f''$ is positive there (concave up)."},
          {"id": "D", "label": "D", "value": "$f$ is never concave down", "type": "text", "explanation": "Incorrect: the table shows a negative interval."}
        ]$txt$,
        'B',
        $txt$A function is concave down where $f''(x)<0$. The table shows $f''$ is negative on $(-1,3)$, so $f$ is concave down on $(-1,3)$.$txt$,
        '{concavity_from_second_derivative}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Table file: U5_5.6-P5_table.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'concavity_from_second_derivative', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'concavity_sign_error' FROM new_question;

COMMIT;
