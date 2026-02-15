-- Insert Script for Unit 2.4 Questions (Differentiability vs Continuity)
-- Unit: ABBC_Derivatives / 2.4

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.4-P1', 'U2.4-P2', 'U2.4-P3', 'U2.4-P4', 'U2.4-P5');

-- ============================================================
-- U2.4-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.4-P1', 'Both', 'ABBC_Derivatives', '2.4', '2.4', 'MCQ', FALSE,
        3, 120, '{nondifferentiable_features}', '{corner_cusp_not_recognized}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.4-P1_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=0$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.4-P1_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=0$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "f is continuous at x=0 and differentiable at x=0", "type": "text", "explanation": "A sharp corner prevents differentiability at that point."},
          {"id": "B", "label": "B", "value": "f is continuous at x=0 but not differentiable at x=0", "type": "text", "explanation": "Correct. Continuous at the corner, but not differentiable."},
          {"id": "C", "label": "C", "value": "f is not continuous at x=0 but is differentiable at x=0", "type": "text", "explanation": "A function cannot be differentiable at a point where it is not continuous."},
          {"id": "D", "label": "D", "value": "f is neither continuous nor differentiable at x=0", "type": "text", "explanation": "The function is continuous at x=0; only differentiability fails."}
        ]$txt$,
        'B',
        $txt$The graph has a sharp corner at $x=0$, so the function is continuous there but not differentiable (the left and right slopes do not match).$txt$,
        '{nondifferentiable_features}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Use file U2_1769404469_2.4-P1_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'nondifferentiable_features', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'diff_vs_continuity', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'corner_cusp_not_recognized' FROM new_question;

-- ============================================================
-- U2.4-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.4-P2', 'Both', 'ABBC_Derivatives', '2.4', '2.4', 'MCQ', FALSE,
        4, 150, '{diff_vs_continuity}', '{diff_implies_continuity_missed}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.4-P2_graph.png)

The graph of $y=f(x)$ is shown. Is $f$ differentiable at $x=1$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.4-P2_graph.png)

The graph of $y=f(x)$ is shown. Is $f$ differentiable at $x=1$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Yes, because the function has a defined value at x=1", "type": "text", "explanation": "Having a defined value does not guarantee continuity or differentiability."},
          {"id": "B", "label": "B", "value": "Yes, because both sides approach finite values", "type": "text", "explanation": "Even if each side approaches a finite value, they must match for continuity."},
          {"id": "C", "label": "C", "value": "No, because the function is not continuous at x=1", "type": "text", "explanation": "Correct. Not continuous at x=1, so not differentiable."},
          {"id": "D", "label": "D", "value": "No, because the tangent slope at x=1 is zero", "type": "text", "explanation": "The graph does not show a zero tangent slope; the issue is discontinuity."}
        ]$txt$,
        'C',
        $txt$Differentiability implies continuity. The graph shows a discontinuity at $x=1$, so the function cannot be differentiable at $x=1$.$txt$,
        '{diff_vs_continuity}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Use file U2_1769404469_2.4-P2_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'diff_vs_continuity', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'differentiability_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'diff_implies_continuity_missed' FROM new_question;

-- ============================================================
-- U2.4-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.4-P3', 'Both', 'ABBC_Derivatives', '2.4', '2.4', 'MCQ', FALSE,
        4, 150, '{nondifferentiable_features}', '{vertical_tangent_not_recognized}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.4-P3_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=1$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.4-P3_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=1$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "f is differentiable at x=1 because the graph is unbroken there", "type": "text", "explanation": "Continuity does not guarantee differentiability."},
          {"id": "B", "label": "B", "value": "f is continuous at x=1 but not differentiable at x=1", "type": "text", "explanation": "Correct. Vertical tangent means not differentiable, but the graph is continuous."},
          {"id": "C", "label": "C", "value": "f is not continuous at x=1 but is differentiable at x=1", "type": "text", "explanation": "Differentiability cannot happen without continuity."},
          {"id": "D", "label": "D", "value": "f is neither continuous nor differentiable at x=1", "type": "text", "explanation": "The graph is continuous at x=1, so this is too strong."}
        ]$txt$,
        'B',
        $txt$The graph is continuous at $x=1$, but it has a vertical tangent there (slope is not finite). Therefore $f$ is not differentiable at $x=1$.$txt$,
        '{nondifferentiable_features}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Use file U2_1769404469_2.4-P3_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'nondifferentiable_features', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'differentiability_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'vertical_tangent_not_recognized' FROM new_question;

-- ============================================================
-- U2.4-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.4-P4', 'Both', 'ABBC_Derivatives', '2.4', '2.4', 'MCQ', FALSE,
        5, 180, '{diff_vs_continuity}', '{continuous_implies_diff_wrong}', 'image',
        $txt$![Graph](/assets/U2_1769404469_2.4-P4_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=2$?$txt$,
        $txt$![Graph](/assets/U2_1769404469_2.4-P4_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "f is continuous at x=2 because the function has a value there", "type": "text", "explanation": "Continuity requires matching the limit, not just having a defined value."},
          {"id": "B", "label": "B", "value": "The limit of f(x) as x approaches 2 exists, but f is not continuous at x=2", "type": "text", "explanation": "Correct. The limit exists, but f(2) does not equal that limit."},
          {"id": "C", "label": "C", "value": "f is differentiable at x=2 because the graph is a straight line nearby", "type": "text", "explanation": "Even if the nearby graph is linear, the discontinuity prevents differentiability."},
          {"id": "D", "label": "D", "value": "f is not continuous at x=2 because the function goes to infinity", "type": "text", "explanation": "The graph does not show infinite behavior; it shows a removable discontinuity."}
        ]$txt$,
        'B',
        $txt$The graph shows a hole at $x=2$ (the two-sided limit exists), but the function value at $x=2$ is placed at a different height. Therefore the limit exists, but $f$ is not continuous at $x=2$.$txt$,
        '{diff_vs_continuity}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, 'Use file U2_1769404469_2.4-P4_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'diff_vs_continuity', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'nondifferentiable_features', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'continuous_implies_diff_wrong' FROM new_question;

-- ============================================================
-- U2.4-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.4-P5', 'Both', 'ABBC_Derivatives', '2.4', '2.4', 'MCQ', FALSE,
        3, 120, '{diff_vs_continuity}', '{diff_implies_continuity_missed}', 'text',
        $txt$Which statement must be true if a function $f$ is differentiable at $x=a$?$txt$,
        $txt$Which statement must be true if a function $f$ is differentiable at $x=a$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "f is continuous at x=a", "type": "text", "explanation": "Correct. Differentiable at x=a implies continuous at x=a."},
          {"id": "B", "label": "B", "value": "f is increasing on an interval containing x=a", "type": "text", "explanation": "A function can be differentiable and still be decreasing or change direction."},
          {"id": "C", "label": "C", "value": "f(a)=0", "type": "text", "explanation": "Differentiability does not force the function value to be 0."},
          {"id": "D", "label": "D", "value": "f has a maximum at x=a", "type": "text", "explanation": "A differentiable point does not have to be a maximum."}
        ]$txt$,
        'A',
        $txt$Differentiability at a point implies continuity at that point. The other choices are not guaranteed by differentiability.$txt$,
        '{diff_vs_continuity}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'diff_vs_continuity', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'differentiability_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'diff_implies_continuity_missed' FROM new_question;
