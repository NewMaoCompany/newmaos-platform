-- Insert Script for 5.1 (Mean Value Theorem)
-- Unit: ABBC_Analytical

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U5.1-P1', 'U5.1-P2', 'U5.1-P3', 'U5.1-P4', 'U5.1-P5'
);

-- ============================================================
-- U5.1-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.1-P1', 'Both', 'ABBC_Analytical', '5.1', '5.1', 'MCQ', FALSE,
        2, 90, '{mvt_conditions}', '{mvt_conditions_missed}', 'text',
        $txt$Let $f(x)=\sqrt{x-1}$ on the interval $[1,5]$. Does the Mean Value Theorem apply on $[1,5]$?

Choose the best justification.$txt$,
        $txt$Let $f(x)=\sqrt{x-1}$ on the interval $[1,5]$. Does the Mean Value Theorem apply on $[1,5]$?

Choose the best justification.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Yes. $f$ is continuous on $[1,5]$ and differentiable on $(1,5)$.", "type": "text", "explanation": "Correct: continuity on $[1,5]$ and differentiability on $(1,5)$ are satisfied."},
          {"id": "B", "label": "B", "value": "No. $f$ is not differentiable at $x=1$.", "type": "text", "explanation": "Incorrect: differentiability at the endpoints is not required."},
          {"id": "C", "label": "C", "value": "No. $f$ is not continuous at $x=1$.", "type": "text", "explanation": "Incorrect: $f$ is continuous at $x=1$ ($\\sqrt{0}=0$)."},
          {"id": "D", "label": "D", "value": "Yes. $f$ is differentiable on $[1,5]$.", "type": "text", "explanation": "Incorrect: MVT does not require differentiability on the endpoints, and this statement is not the right criterion."}
        ]$txt$,
        'A',
        $txt$The Mean Value Theorem requires continuity on the closed interval and differentiability on the open interval. The square-root function is continuous for $x \ge 1$ and differentiable for $x > 1$, so the hypotheses hold on $[1,5]$.$txt$,
        '{mvt_conditions}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'mvt_conditions', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'mvt_conditions_missed' FROM new_question;

-- ============================================================
-- U5.1-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.1-P2', 'Both', 'ABBC_Analytical', '5.1', '5.1', 'MCQ', FALSE,
        2, 120, '{mvt_conditions,avg_vs_instant_rate_link}', '{mvt_conclusion_misread}', 'text',
        $txt$Let $f(x)=x^2-4x$ on $[1,3]$. Find a value $c$ in $(1,3)$ such that $f'(c)$ equals the average rate of change of $f$ on $[1,3]$.$txt$,
        $txt$Let $f(x)=x^2-4x$ on $[1,3]$. Find a value $c$ in $(1,3)$ such that $f'(c)$ equals the average rate of change of $f$ on $[1,3]$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$c=1$", "type": "text", "explanation": "Incorrect: $c$ must be in $(1,3)$ and satisfy $f'(c)=0$; $f'(1)=-2$."},
          {"id": "B", "label": "B", "value": "$c=3/2$", "type": "text", "explanation": "Incorrect: $f'(3/2)=3-4=-1$, not $0$."},
          {"id": "C", "label": "C", "value": "$c=2$", "type": "text", "explanation": "Correct: $f'(2)=0$ matches the average slope $0$."},
          {"id": "D", "label": "D", "value": "$c=5/2$", "type": "text", "explanation": "Incorrect: $f'(5/2)=5-4=1$, not $0$."}
        ]$txt$,
        'C',
        $txt$Compute the average rate of change: $\frac{f(3)-f(1)}{3-1}=\frac{(-3)-(-3)}{2}=0$. Since $f'(x)=2x-4$, solve $2c-4=0$ to get $c=2$.$txt$,
        '{mvt_conditions}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Supportive skill supports linking average slope to derivative.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'mvt_conditions', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'avg_vs_instant_rate_link', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'mvt_conclusion_misread' FROM new_question;

-- ============================================================
-- U5.1-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.1-P3', 'Both', 'ABBC_Analytical', '5.1', '5.1', 'MCQ', FALSE,
        3, 150, '{avg_vs_instant_rate_link,mvt_conditions}', '{mvt_conclusion_misread}', 'text',
        $txt$A particle’s position is $s(t)=t^3-6t^2+9t$ (meters) for $0 \le t \le 3$. At what time $t$ in $(0,3)$ is the instantaneous velocity equal to the average velocity on $[0,3]$?$txt$,
        $txt$A particle’s position is $s(t)=t^3-6t^2+9t$ (meters) for $0 \le t \le 3$. At what time $t$ in $(0,3)$ is the instantaneous velocity equal to the average velocity on $[0,3]$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$t=0$", "type": "text", "explanation": "Incorrect: the time must be in the open interval $(0,3)$."},
          {"id": "B", "label": "B", "value": "$t=1$", "type": "text", "explanation": "Correct: $v(1)=0$ matches the average velocity $0$."},
          {"id": "C", "label": "C", "value": "$t=2$", "type": "text", "explanation": "Incorrect: $v(2)=3(4)-24+9=-3$, not $0$."},
          {"id": "D", "label": "D", "value": "$t=3$", "type": "text", "explanation": "Incorrect: $3$ is not in $(0,3)$ for the MVT conclusion."}
        ]$txt$,
        'B',
        $txt$Average velocity is $\frac{s(3)-s(0)}{3-0}=\frac{0-0}{3}=0$. Instantaneous velocity is $v(t)=s'(t)=3t^2-12t+9=3(t-1)(t-3)$. Set $v(t)=0$ gives $t=1$ or $t=3$; only $t=1$ lies in $(0,3)$.$txt$,
        '{avg_vs_instant_rate_link}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Links average change in context to an instantaneous rate via MVT.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'avg_vs_instant_rate_link', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'mvt_conditions', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'mvt_conclusion_misread' FROM new_question;

-- ============================================================
-- U5.1-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.1-P4', 'Both', 'ABBC_Analytical', '5.1', '5.1', 'MCQ', FALSE,
        2, 90, '{mvt_conditions}', '{mvt_conclusion_misread}', 'text',
        $txt$Suppose a function $f$ is continuous on $[a,b]$ and differentiable on $(a,b)$. Which statement must be true?$txt$,
        $txt$Suppose a function $f$ is continuous on $[a,b]$ and differentiable on $(a,b)$. Which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "There exists $c$ in $(a,b)$ such that $f'(c) = \\frac{f(b)-f(a)}{b-a}$.", "type": "text", "explanation": "Correct: it matches the MVT conclusion."},
          {"id": "B", "label": "B", "value": "$f$ has an absolute maximum at some point in $(a,b)$.", "type": "text", "explanation": "Incorrect: an absolute maximum might occur at an endpoint."},
          {"id": "C", "label": "C", "value": "$f'$ is continuous on $(a,b)$.", "type": "text", "explanation": "Incorrect: differentiability does not imply $f'$ is continuous."},
          {"id": "D", "label": "D", "value": "$f(a)=f(b)$.", "type": "text", "explanation": "Incorrect: MVT does not require equal endpoint values (that is Rolle’s Theorem)."}
        ]$txt$,
        'A',
        $txt$This is exactly the conclusion of the Mean Value Theorem given the stated hypotheses.$txt$,
        '{mvt_conditions}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, 'Supportive skill = 0 (none needed).', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'mvt_conditions', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'mvt_conclusion_misread' FROM new_question;

-- ============================================================
-- U5.1-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U5.1-P5', 'Both', 'ABBC_Analytical', '5.1', '5.1', 'MCQ', FALSE,
        3, 120, '{mvt_conditions,method_selection_unit5}', '{mvt_conditions_missed}', 'text',
        $txt$Let $g(x)=|x|$ on the interval $[-1,2]$. Can the Mean Value Theorem be applied on $[-1,2]$?

Choose the best answer.$txt$,
        $txt$Let $g(x)=|x|$ on the interval $[-1,2]$. Can the Mean Value Theorem be applied on $[-1,2]$?

Choose the best answer.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Yes, because $g$ is continuous on $[-1,2]$.", "type": "text", "explanation": "Incorrect: continuity alone is not sufficient; differentiability on $(a,b)$ is also required."},
          {"id": "B", "label": "B", "value": "No, because $g$ is not differentiable at $x=0$, which lies in $(-1,2)$.", "type": "text", "explanation": "Correct: the cusp at $x=0$ breaks differentiability in the open interval."},
          {"id": "C", "label": "C", "value": "Yes, because $g$ is differentiable for all $x$ in $[-1,2]$.", "type": "text", "explanation": "Incorrect: $|x|$ is not differentiable at $x=0$."},
          {"id": "D", "label": "D", "value": "No, because MVT requires $f(a)=f(b)$.", "type": "text", "explanation": "Incorrect: $f(a)=f(b)$ is Rolle’s Theorem, not a requirement for MVT."}
        ]$txt$,
        'B',
        $txt$MVT requires differentiability on the entire open interval. The function $|x|$ is not differentiable at $x=0$, and $0$ is inside $(-1,2)$, so MVT does not apply.$txt$,
        '{mvt_conditions}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Supportive skill helps with choosing correct theorem/criteria.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'mvt_conditions', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit5', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'mvt_conditions_missed' FROM new_question;
