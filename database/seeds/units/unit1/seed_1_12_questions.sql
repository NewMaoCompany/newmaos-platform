-- Insert Script for Chapter 1.12 Questions (Defining Continuity on an Interval)
-- Unit: Both_Limits / 1.12

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.12-P1', '1.12-P2', '1.12-P3', '1.12-P4', '1.12-P5');

-- ============================================================
-- 1.12-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.12-P1', 'Both', 'Both_Limits', '1.12', '1.12', 'MCQ', FALSE,
        2, 210, '{continuity_concept,discontinuity_types}', '{endpoint_domain_issue}', 'text',
        $txt$Use the graph provided. Is $f$ continuous on the interval $[-2,2]$?$txt$,
        $txt$Use the graph provided. Is $f$ continuous on the interval $[-2,2]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Yes, it is continuous on $[-2,2]$ ", "type": "text", "explanation": "Continuity on a closed interval requires the function to be defined at both endpoints."},
          {"id": "B", "label": "B", "value": "No, because $f$ is not defined at $x=-2$", "type": "text", "explanation": "The graph shows a filled point at $x=-2$, so it is defined there."},
          {"id": "C", "label": "C", "value": "No, because $f$ is not defined at $x=2$", "type": "text", "explanation": "Correct: the open circle at $x=2$ means $f(2)$ is not defined."},
          {"id": "D", "label": "D", "value": "No, because there is a jump at $x=0$", "type": "text", "explanation": "There is no jump at $x=0$ in the graph."}
        ]$txt$,
        'C',
        $txt$The left endpoint at $x=-2$ is included and defined, but the right endpoint at $x=2$ is shown as an open circle, meaning $f(2)$ is not defined. Therefore $f$ is not continuous on $[-2,2]$.$txt$,
        '{continuity_concept}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3.5 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'endpoint_domain_issue' FROM new_question;


-- ============================================================
-- 1.12-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.12-P2', 'Both', 'Both_Limits', '1.12', '1.12', 'MCQ', FALSE,
        3, 240, '{continuity_concept,discontinuity_types}', '{interval_continuity_confusion}', 'text',
        $txt$Which statement is true about continuity on an interval?$txt$,
        $txt$Which statement is true about continuity on an interval?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "A function can be continuous on $[a,b]$ even if $f(a)$ is undefined.", "type": "text", "explanation": "On $[a,b]$, the endpoint $a$ is included, so $f(a)$ must be defined."},
          {"id": "B", "label": "B", "value": "A function is continuous on $[a,b]$ only if it is continuous at every point in $(a,b)$ and defined at $a$ and $b$.", "type": "text", "explanation": "Correct: that is the standard interval continuity requirement."},
          {"id": "C", "label": "C", "value": "If $\\lim_{x\\to c} f(x)$ exists for some $c$, then $f$ is continuous on the entire interval.", "type": "text", "explanation": "One limit existing at one point does not guarantee continuity everywhere."},
          {"id": "D", "label": "D", "value": "Continuity on $[a,b]$ requires $f$ to be differentiable on $[a,b]$.", "type": "text", "explanation": "Differentiability is stronger than continuity and is not required."}
        ]$txt$,
        'B',
        $txt$Continuity on a closed interval requires continuity at all interior points and that the function is defined at both endpoints.$txt$,
        '{continuity_concept}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'interval_continuity_confusion' FROM new_question;


-- ============================================================
-- 1.12-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.12-P3', 'Both', 'Both_Limits', '1.12', '1.12', 'MCQ', FALSE,
        3, 240, '{ivt_application,continuity_concept}', '{ivt_missing_continuity}', 'text',
        $txt$A function $f$ is continuous on $[-1,3]$. If $f(-1)=4$ and $f(3)=-2$, which statement must be true?$txt$,
        $txt$A function $f$ is continuous on $[-1,3]$. If $f(-1)=4$ and $f(3)=-2$, which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "There exists a number $c$ in $(-1,3)$ such that $f(c)=0$", "type": "text", "explanation": "Correct: IVT guarantees a root because the outputs cross 0."},
          {"id": "B", "label": "B", "value": "$f(1)=0$", "type": "text", "explanation": "IVT guarantees some $c$, not necessarily $x=1$."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 0} f(x)$ does not exist", "type": "text", "explanation": "Continuity implies the limit exists at interior points."},
          {"id": "D", "label": "D", "value": "$f(x)$ is decreasing on $[-1,3]$", "type": "text", "explanation": "IVT does not imply monotonicity."}
        ]$txt$,
        'A',
        $txt$Because $f$ is continuous and 0 lies between 4 and -2, the Intermediate Value Theorem guarantees at least one $c$ where $f(c)=0$.$txt$,
        '{ivt_application}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ivt_application', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'ivt_missing_continuity' FROM new_question;


-- ============================================================
-- 1.12-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.12-P4', 'Both', 'Both_Limits', '1.12', '1.12', 'MCQ', FALSE,
        3, 270, '{continuity_concept,limit_estimation_graph}', '{endpoint_domain_issue}', 'text',
        $txt$Use the graph provided. Is $f$ continuous on the interval $[0,3]$?$txt$,
        $txt$Use the graph provided. Is $f$ continuous on the interval $[0,3]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Yes, it is continuous on $[0,3]$ ", "type": "text", "explanation": "Continuity on $[0,3]$ requires $f(0)$ to be defined."},
          {"id": "B", "label": "B", "value": "No, because $\\lim_{x\\to 0} f(x)$ does not exist", "type": "text", "explanation": "Right-hand limit may exist, but the main issue is $f(0)$ is undefined."},
          {"id": "C", "label": "C", "value": "No, because $f(0)$ is not defined", "type": "text", "explanation": "Correct: the open circle at $x=0$ means $f(0)$ does not exist."},
          {"id": "D", "label": "D", "value": "No, because $f(3)$ is not defined", "type": "text", "explanation": "The graph shows the curve exists at $x=3$."}
        ]$txt$,
        'C',
        $txt$The interval includes the endpoint $x=0$, but the graph shows an open circle at $x=0$, so $f(0)$ is not defined. Therefore $f$ is not continuous on $[0,3]$.$txt$,
        '{continuity_concept}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4.5 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_graph', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'endpoint_domain_issue' FROM new_question;


-- ============================================================
-- 1.12-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.12-P5', 'Both', 'Both_Limits', '1.12', '1.12', 'MCQ', FALSE,
        4, 300, '{continuity_concept,limit_concept}', '{interval_continuity_confusion}', 'text',
        $txt$A function $f$ is continuous on $(0,5)$ but is not defined at $x=0$ and $x=5$. Which interval is guaranteed to have $f$ continuous on it?$txt$,
        $txt$A function $f$ is continuous on $(0,5)$ but is not defined at $x=0$ and $x=5$. Which interval is guaranteed to have $f$ continuous on it?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$[0,5]$ ", "type": "text", "explanation": "This includes both endpoints, which are not defined."},
          {"id": "B", "label": "B", "value": "$(0,5)$ ", "type": "text", "explanation": "Correct: $(0,5)$ avoids the undefined endpoints."},
          {"id": "C", "label": "C", "value": "$[0,5)$ ", "type": "text", "explanation": "This includes $x=0$, which is undefined."},
          {"id": "D", "label": "D", "value": "$(0,5]$ ", "type": "text", "explanation": "This includes $x=5$, which is undefined."}
        ]$txt$,
        'B',
        $txt$Continuity is guaranteed on the open interval $(0,5)$ because it does not include the endpoints where the function is undefined.$txt$,
        '{continuity_concept}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'interval_continuity_confusion' FROM new_question;
