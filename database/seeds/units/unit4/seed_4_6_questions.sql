-- Insert Script for Chapter 4.6 Questions (Linearization)
-- Unit: ABBC_Applications / 4.6

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U4.6-P1', 'U4.6-P2', 'U4.6-P3', 'U4.6-P4', 'U4.6-P5');

-- ============================================================
-- U4.6-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.6-P1', 'Both', 'ABBC_Applications', '4.6', '4.6', 'MCQ', FALSE,
        3, 180, '{local_linearity_concept,derivative_meaning_context}', '{linearization_point_misuse}', 'text',
        $txt$Which statement best describes why linearization can approximate a function near a point?$txt$,
        $txt$Which statement best describes why linearization can approximate a function near a point?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "A function is always equal to its tangent line everywhere.", "type": "text", "explanation": "A tangent line matches only at the point of tangency, not everywhere."},
          {"id": "B", "label": "B", "value": "A function behaves nearly like a line when viewed very close to a point.", "type": "text", "explanation": "Correct: near the point, the curve resembles a line."},
          {"id": "C", "label": "C", "value": "A tangent line always intersects the function at two points.", "type": "text", "explanation": "Not guaranteed and not the reason linearization works."},
          {"id": "D", "label": "D", "value": "Linearization works best far away from the point of tangency.", "type": "text", "explanation": "Accuracy decreases as you move farther from the point."}
        ]$txt$,
        'B',
        $txt$Linearization uses the idea of local linearity: close to a point, the function looks nearly straight, so the tangent line provides a good approximation near that point.$txt$,
        '{local_linearity_concept}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'local_linearity_concept', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'derivative_meaning_context', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'linearization_point_misuse' FROM new_question;

-- ============================================================
-- U4.6-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.6-P2', 'Both', 'ABBC_Applications', '4.6', '4.6', 'MCQ', FALSE,
        4, 210, '{linearization_build_tangent,method_selection_unit4}', '{tangent_slope_wrong_value}', 'text',
        $txt$A function $f$ satisfies $f(5)=12$ and $f'(5)=3$. Which linear approximation $L(x)$ best estimates $f(x)$ near $x=5$?$txt$,
        $txt$A function $f$ satisfies $f(5)=12$ and $f'(5)=3$. Which linear approximation $L(x)$ best estimates $f(x)$ near $x=5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$L(x) = 12 + 3(x-5)$", "type": "text", "explanation": "Correct: value at $5$ plus slope times $(x-5)$."},
          {"id": "B", "label": "B", "value": "$L(x) = 3 + 12(x-5)$", "type": "text", "explanation": "Swaps the roles of function value and slope."},
          {"id": "C", "label": "C", "value": "$L(x) = 12 + 5(x-3)$", "type": "text", "explanation": "Uses the wrong anchor point and wrong slope reference."},
          {"id": "D", "label": "D", "value": "$L(x) = 12(x-5) + 3$", "type": "text", "explanation": "Mis-structures the tangent line form."}
        ]$txt$,
        'A',
        $txt$The linearization at $x=5$ uses the point value $f(5)=12$ and slope $f'(5)=3$, so $L(x)=12+3(x-5)$.$txt$,
        '{linearization_build_tangent}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearization_build_tangent', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit4', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'tangent_slope_wrong_value' FROM new_question;

-- ============================================================
-- U4.6-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.6-P3', 'Both', 'ABBC_Applications', '4.6', '4.6', 'MCQ', FALSE,
        4, 240, '{linearization_numeric_estimate,local_linearity_concept}', '{linearization_far_from_point}', 'text',
        $txt$Use a tangent-line approximation at $x=8$ to estimate the value of $\sqrt[3]{8.3}$.$txt$,
        $txt$Use a tangent-line approximation at $x=8$ to estimate the value of $\sqrt[3]{8.3}$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "About $2.025$", "type": "text", "explanation": "Correct: slightly above $2$ by a small amount."},
          {"id": "B", "label": "B", "value": "About $2.250$", "type": "text", "explanation": "Too large of an increase for such a small $x$-change."},
          {"id": "C", "label": "C", "value": "About $1.975$", "type": "text", "explanation": "Wrong direction: the cube root increases as $x$ increases."},
          {"id": "D", "label": "D", "value": "About $2.300$", "type": "text", "explanation": "Much too large for a local approximation near $8$."}
        ]$txt$,
        'A',
        $txt$At $x=8$, the cube root equals $2$. The tangent slope there is small and positive, so the estimate should be slightly above $2$. The best nearby estimate is about $2.025$.$txt$,
        '{linearization_numeric_estimate}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Graph included: curve and tangent line near x=8.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearization_numeric_estimate', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'local_linearity_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'linearization_far_from_point' FROM new_question;

-- ============================================================
-- U4.6-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.6-P4', 'Both', 'ABBC_Applications', '4.6', '4.6', 'MCQ', FALSE,
        5, 270, '{differential_error_estimate,units_analysis}', '{differential_sign_error}', 'text',
        $txt$A measurement changes from $x=10$ to $x=10.2$. If the linear approximation gives an estimated change of $+0.6$ in $f$, which statement is always true?$txt$,
        $txt$A measurement changes from $x=10$ to $x=10.2$. If the linear approximation gives an estimated change of $+0.6$ in $f$, which statement is always true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The exact change in $f$ must be exactly $+0.6$.", "type": "text", "explanation": "Linear estimates are not exact in general."},
          {"id": "B", "label": "B", "value": "The exact change in $f$ is guaranteed to be larger than $+0.6$.", "type": "text", "explanation": "No guaranteed direction of error without extra concavity information."},
          {"id": "C", "label": "C", "value": "The exact change in $f$ is guaranteed to be smaller than $+0.6$.", "type": "text", "explanation": "No guaranteed direction of error without extra concavity information."},
          {"id": "D", "label": "D", "value": "The linear estimate is an approximation and may differ from the exact change.", "type": "text", "explanation": "Correct: it is an approximation and may differ from the exact change."}
        ]$txt$,
        'D',
        $txt$A differential-based change is an approximation. It can be close when $x$ is near the expansion point, but it is not guaranteed to match exactly or be always above/below.$txt$,
        '{differential_error_estimate}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.85, 0.15, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'differential_error_estimate', 'primary', 0.85 FROM new_question
    UNION ALL
    SELECT id, 'units_analysis', 'supporting', 0.15 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'differential_sign_error' FROM new_question;

-- ============================================================
-- U4.6-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U4.6-P5', 'Both', 'ABBC_Applications', '4.6', '4.6', 'MCQ', FALSE,
        4, 240, '{linearization_interpret_table,linearization_numeric_estimate}', '{units_mismatch_linearization}', 'text',
        $txt$A table compares the true value of $\sqrt{x}$ with a linear approximation at $x=9$ for several nearby $x$-values. Which $x$-value should give the most accurate linear approximation?$txt$,
        $txt$A table compares the true value of $\sqrt{x}$ with a linear approximation at $x=9$ for several nearby $x$-values. Which $x$-value should give the most accurate linear approximation?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x = 8.8$", "type": "text", "explanation": "Farther from $9$ than $8.9$ and $9.0$, so typically less accurate."},
          {"id": "B", "label": "B", "value": "$x = 8.9$", "type": "text", "explanation": "Closer than $8.8$, but not as accurate as $x=9.0$."},
          {"id": "C", "label": "C", "value": "$x = 9.0$", "type": "text", "explanation": "Correct: the approximation is exact at $x=9$ by construction."},
          {"id": "D", "label": "D", "value": "$x = 9.2$", "type": "text", "explanation": "Farther from $9$, so typically less accurate."}
        ]$txt$,
        'C',
        $txt$A linear approximation built at $x=9$ is most accurate at the point of tangency, $x=9$, and typically becomes less accurate as $x$ moves farther away.$txt$,
        '{linearization_interpret_table}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Table included: true vs linear approx near x=9.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'linearization_interpret_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'linearization_numeric_estimate', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'units_mismatch_linearization' FROM new_question;
