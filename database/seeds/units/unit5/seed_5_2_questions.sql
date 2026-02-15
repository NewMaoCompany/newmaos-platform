-- Insert Script for 5.2 (Extreme Value Theorem)
-- Unit: ABBC_Analytical

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U5.2-P1', 'U5.2-P2', 'U5.2-P3', 'U5.2-P4', 'U5.2-P5'
);

-- ============================================================
-- U5.2-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.2-P1', 'Both', 'ABBC_Analytical', '5.2', '5.2', 'MCQ', FALSE,
        1, 60, '{evt_application}', '{evt_requires_closed_interval_missed}', 'text',
        $txt$Which theorem guarantees that a continuous function on a closed interval $[a,b]$ attains both an absolute maximum and an absolute minimum on $[a,b]$?$txt$,
        $txt$Which theorem guarantees that a continuous function on a closed interval $[a,b]$ attains both an absolute maximum and an absolute minimum on $[a,b]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Mean Value Theorem", "type": "text", "explanation": "Incorrect: MVT guarantees a point where derivative matches average slope."},
          {"id": "B", "label": "B", "value": "Extreme Value Theorem", "type": "text", "explanation": "Correct: EVT guarantees existence of absolute extrema on a closed interval."},
          {"id": "C", "label": "C", "value": "Intermediate Value Theorem", "type": "text", "explanation": "Incorrect: IVT guarantees intermediate values, not extrema."},
          {"id": "D", "label": "D", "value": "Rolle’s Theorem", "type": "text", "explanation": "Incorrect: Rolle’s Theorem is a special case of MVT with equal endpoints."}
        ]$txt$,
        'B',
        $txt$The Extreme Value Theorem states that if a function is continuous on a closed interval, then it attains an absolute maximum and an absolute minimum on that interval.$txt$,
        '{evt_application}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'evt_application', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'evt_requires_closed_interval_missed' FROM new_question;

-- ============================================================
-- U5.2-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.2-P2', 'Both', 'ABBC_Analytical', '5.2', '5.2', 'MCQ', FALSE,
        2, 90, '{evt_application,method_selection_unit5}', '{evt_requires_closed_interval_missed}', 'text',
        $txt$A function $f$ is continuous on the open interval $(0,4)$. Which statement is guaranteed by the Extreme Value Theorem?$txt$,
        $txt$A function $f$ is continuous on the open interval $(0,4)$. Which statement is guaranteed by the Extreme Value Theorem?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ attains an absolute maximum on $(0,4)$.", "type": "text", "explanation": "Incorrect: a maximum may fail to occur if it would be at an endpoint not included."},
          {"id": "B", "label": "B", "value": "$f$ attains an absolute minimum on $(0,4)$.", "type": "text", "explanation": "Incorrect: same issue as for a maximum on an open interval."},
          {"id": "C", "label": "C", "value": "$f$ attains both an absolute maximum and absolute minimum on $(0,4)$.", "type": "text", "explanation": "Incorrect: EVT’s conclusion needs the closed-interval hypothesis."},
          {"id": "D", "label": "D", "value": "No absolute extrema are guaranteed by EVT from this information alone.", "type": "text", "explanation": "Correct: EVT cannot be applied without a closed interval."}
        ]$txt$,
        'D',
        $txt$EVT requires a closed interval $[a,b]$. Continuity on an open interval $(0,4)$ does not guarantee that absolute extrema are attained.$txt$,
        '{evt_application}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Emphasizes hypothesis: closed interval is required.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'evt_application', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit5', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'evt_requires_closed_interval_missed' FROM new_question;

-- ============================================================
-- U5.2-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.2-P3', 'Both', 'ABBC_Analytical', '5.2', '5.2', 'MCQ', FALSE,
        3, 150, '{candidates_test_absolute,critical_points_find}', '{candidates_test_missing_endpoints}', 'text',
        $txt$Let $f(x)=x^3-3x$ on the interval $[-2,2]$. At which x-value(s) does $f$ attain an absolute maximum on $[-2,2]$?$txt$,
        $txt$Let $f(x)=x^3-3x$ on the interval $[-2,2]$. At which x-value(s) does $f$ attain an absolute maximum on $[-2,2]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x=-2$ only", "type": "text", "explanation": "Incorrect: $f(-2)=-2$ is not the maximum."},
          {"id": "B", "label": "B", "value": "$x=2$ only", "type": "text", "explanation": "Incorrect: $x=2$ is a max point, but not the only one."},
          {"id": "C", "label": "C", "value": "$x=-1$ only", "type": "text", "explanation": "Incorrect: $x=-1$ is a max point, but not the only one."},
          {"id": "D", "label": "D", "value": "$x=-1$ and $x=2$", "type": "text", "explanation": "Correct: both $x=-1$ and $x=2$ give the maximum value."}
        ]$txt$,
        'D',
        $txt$Candidates are endpoints and critical points. $f''(x)=3x^2-3=3(x^2-1)$, so critical points are $x=\pm 1$. Evaluate: $f(-2)=-2$, $f(2)=2$, $f(-1)=2$, $f(1)=-2$. The maximum value $2$ occurs at $x=-1$ and $x=2$.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Forces endpoints + critical points check (Candidates Test).', 0.8, 0.2, NOW(), NOW()
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

-- ============================================================
-- U5.2-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.2-P4', 'Both', 'ABBC_Analytical', '5.2', '5.2', 'MCQ', FALSE,
        2, 90, '{global_vs_local_extrema}', '{global_vs_local_confusion}', 'text',
        $txt$Refer to the provided graph of $f$ on the interval $[0,4]$. The points A, B, C, and D are labeled on the graph.

Which labeled point corresponds to the absolute minimum value of $f$ on $[0,4]$?$txt$,
        $txt$Refer to the provided graph of $f$ on the interval $[0,4]$. The points A, B, C, and D are labeled on the graph.

Which labeled point corresponds to the absolute minimum value of $f$ on $[0,4]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Point A", "type": "text", "explanation": "Incorrect: A is an endpoint but not the lowest value shown."},
          {"id": "B", "label": "B", "value": "Point B", "type": "text", "explanation": "Incorrect: B is near a local high, not a minimum."},
          {"id": "C", "label": "C", "value": "Point C", "type": "text", "explanation": "Correct: C is the lowest point (absolute minimum) on $[0,4]$."},
          {"id": "D", "label": "D", "value": "Point D", "type": "text", "explanation": "Incorrect: D is an endpoint but higher than C."}
        ]$txt$,
        'C',
        $txt$The absolute minimum is the lowest y-value on the entire interval $[0,4]$. From the graph, point C is the lowest among the labeled points and the curve on the interval.$txt$,
        '{global_vs_local_extrema}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Graph file: U5_5.2-P4_graph.png. Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'global_vs_local_extrema', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'global_vs_local_confusion' FROM new_question;

-- ============================================================
-- U5.2-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.2-P5', 'Both', 'ABBC_Analytical', '5.2', '5.2', 'MCQ', FALSE,
        2, 120, '{candidates_test_absolute,critical_points_find}', '{absolute_extrema_compare_error}', 'text',
        $txt$A continuous function $f$ on $[0,5]$ has the following candidate points for absolute extrema and their function values (see the provided table).

What is the absolute maximum value of $f$ on $[0,5]$?$txt$,
        $txt$A continuous function $f$ on $[0,5]$ has the following candidate points for absolute extrema and their function values (see the provided table).

What is the absolute maximum value of $f$ on $[0,5]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "4", "type": "text", "explanation": "Incorrect: 4 is not the largest value shown."},
          {"id": "B", "label": "B", "value": "5", "type": "text", "explanation": "Correct: 5 is the largest candidate value."},
          {"id": "C", "label": "C", "value": "2", "type": "text", "explanation": "Incorrect: 2 is smaller than 5."},
          {"id": "D", "label": "D", "value": "1", "type": "text", "explanation": "Incorrect: 1 is smaller than 5."}
        ]$txt$,
        'B',
        $txt$The absolute maximum is the largest value among the candidate values listed. From the table, the largest $f(x)$ value is $5$.$txt$,
        '{candidates_test_absolute}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Table file: U5_5.2-P5_table.png.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'candidates_test_absolute', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'critical_points_find', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'absolute_extrema_compare_error' FROM new_question;
