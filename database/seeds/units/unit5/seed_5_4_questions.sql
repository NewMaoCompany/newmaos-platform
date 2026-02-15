-- Insert Script for 5.4 (First Derivative Test)
-- Unit: ABBC_Analytical

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U5.4-P1', 'U5.4-P2', 'U5.4-P3', 'U5.4-P4', 'U5.4-P5'
);

-- ============================================================
-- U5.4-P1
-- ============================================================
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

-- ============================================================
-- U5.4-P2
-- ============================================================
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

-- ============================================================
-- U5.4-P3
-- ============================================================
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

-- ============================================================
-- U5.4-P4
-- ============================================================
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

-- ============================================================
-- U5.4-P5
-- ============================================================
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
