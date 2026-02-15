-- Insert Script for 5.3 (Increasing/Decreasing Intervals)
-- Unit: ABBC_Analytical

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U5.3-P1', 'U5.3-P2', 'U5.3-P3', 'U5.3-P4', 'U5.3-P5'
);

-- ============================================================
-- U5.3-P1
-- ============================================================
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

-- ============================================================
-- U5.3-P2
-- ============================================================
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

-- ============================================================
-- U5.3-P3
-- ============================================================
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

-- ============================================================
-- U5.3-P4
-- ============================================================
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

-- ============================================================
-- U5.3-P5
-- ============================================================
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
