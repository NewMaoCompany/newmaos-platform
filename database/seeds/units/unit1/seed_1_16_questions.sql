-- Insert Script for Chapter 1.16 Questions (Intermediate Value Theorem (IVT))
-- Unit: Both_Limits / 1.16

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.16-P1', '1.16-P2', '1.16-P3', '1.16-P4', '1.16-P5');

-- ============================================================
-- 1.16-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.16-P1', 'Both', 'Both_Limits', '1.16', '1.16', 'MCQ', FALSE,
        2, 210, '{ivt_application,continuity_concept}', '{ivt_missing_continuity}', 'text',
        $txt$A function $f$ is continuous on $[1,5]$. If $f(1)=-3$ and $f(5)=2$, which statement must be true?$txt$,
        $txt$A function $f$ is continuous on $[1,5]$. If $f(1)=-3$ and $f(5)=2$, which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "There exists a number $c$ in $(1,5)$ such that $f(c)=0$", "type": "text", "explanation": "Correct: IVT guarantees a solution to $f(c)=0$."},
          {"id": "B", "label": "B", "value": "$f(3)=0$", "type": "text", "explanation": "IVT does not guarantee the root occurs at $x=3$ specifically."},
          {"id": "C", "label": "C", "value": "$f$ is increasing on $[1,5]$", "type": "text", "explanation": "IVT does not imply monotonicity."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 2} f(x)$ does not exist", "type": "text", "explanation": "Continuity implies the limit exists at interior points."}
        ]$txt$,
        'A',
        $txt$Because $f$ is continuous and changes sign from negative to positive, IVT guarantees at least one root in $(1,5)$.$txt$,
        '{ivt_application}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3.5 minutes.', 0.8, 0.2, NOW(), NOW()
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
-- 1.16-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.16-P2', 'Both', 'Both_Limits', '1.16', '1.16', 'MCQ', FALSE,
        3, 240, '{ivt_application,limit_concept}', '{ivt_missing_continuity}', 'text',
        $txt$A function $f$ satisfies $f(0)=2$ and $f(4)=-6$. Which additional condition is needed to guarantee there exists $c$ in $(0,4)$ such that $f(c)=0$?$txt$,
        $txt$A function $f$ satisfies $f(0)=2$ and $f(4)=-6$. Which additional condition is needed to guarantee there exists $c$ in $(0,4)$ such that $f(c)=0$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ is continuous on $[0,4]$", "type": "text", "explanation": "Correct: continuity on the interval is the required IVT condition."},
          {"id": "B", "label": "B", "value": "$f$ is differentiable on $[0,4]$", "type": "text", "explanation": "Differentiability is not required for IVT."},
          {"id": "C", "label": "C", "value": "$f(2)=0$", "type": "text", "explanation": "This is stronger than needed; IVT only guarantees existence, not the location."},
          {"id": "D", "label": "D", "value": "$f$ is a polynomial", "type": "text", "explanation": "Polynomials are continuous, but continuity itself is the needed condition."}
        ]$txt$,
        'A',
        $txt$IVT requires continuity on the closed interval. If $f$ is continuous on $[0,4]$ and changes sign, then $f(c)=0$ for some $c$ in $(0,4)$.$txt$,
        '{ivt_application}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ivt_application', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'ivt_missing_continuity' FROM new_question;


-- ============================================================
-- 1.16-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.16-P3', 'Both', 'Both_Limits', '1.16', '1.16', 'MCQ', FALSE,
        4, 300, '{ivt_application,continuity_concept}', '{ivt_missing_continuity}', 'text',
        $txt$Let $f$ be continuous on $[-2,1]$ with $f(-2)=5$ and $f(1)=5$. Which statement must be true?$txt$,
        $txt$Let $f$ be continuous on $[-2,1]$ with $f(-2)=5$ and $f(1)=5$. Which statement must be true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "There exists $c$ in $(-2,1)$ such that $f(c)=0$", "type": "text", "explanation": "No sign change is given, so a root is not guaranteed."},
          {"id": "B", "label": "B", "value": "There exists $c$ in $(-2,1)$ such that $f(c)=5$", "type": "text", "explanation": "Correct: $f(c)=5$ must occur (at least at the endpoints and possibly inside)."},
          {"id": "C", "label": "C", "value": "$f(x)=5$ for all $x$ in $[-2,1]$", "type": "text", "explanation": "Equal endpoint values do not force the function to be constant."},
          {"id": "D", "label": "D", "value": "There exists exactly one $c$ such that $f(c)=5$", "type": "text", "explanation": "IVT does not guarantee uniqueness."}
        ]$txt$,
        'B',
        $txt$Since $f(-2)=f(1)=5$ and $f$ is continuous, IVT guarantees $f$ takes all intermediate values between 5 and 5, which includes 5. This is also true for many interior points.$txt$,
        '{ivt_application}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ivt_application', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'ivt_missing_continuity' FROM new_question;


-- ============================================================
-- 1.16-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.16-P4', 'Both', 'Both_Limits', '1.16', '1.16', 'MCQ', FALSE,
        4, 300, '{ivt_application,discontinuity_types}', '{ivt_missing_continuity}', 'text',
        $txt$Which situation does NOT allow you to conclude that there exists $c$ in $(a,b)$ such that $f(c)=0$?$txt$,
        $txt$Which situation does NOT allow you to conclude that there exists $c$ in $(a,b)$ such that $f(c)=0$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ is continuous on $[a,b]$, $f(a)<0$, and $f(b)>0$", "type": "text", "explanation": "Continuity + sign change guarantees a root by IVT."},
          {"id": "B", "label": "B", "value": "$f$ is continuous on $[a,b]$, $f(a)>0$, and $f(b)<0$", "type": "text", "explanation": "Same reasoning: sign change guarantees a root by IVT."},
          {"id": "C", "label": "C", "value": "$f$ is NOT continuous on $[a,b]$, but $f(a)<0$ and $f(b)>0$", "type": "text", "explanation": "Correct: without continuity, IVT cannot be applied."},
          {"id": "D", "label": "D", "value": "$f$ is continuous on $[a,b]$ and $f(a)=0$", "type": "text", "explanation": "If $f(a)=0$, then a root exists at the endpoint (though not necessarily inside)."}
        ]$txt$,
        'C',
        $txt$IVT requires continuity. A sign change alone is not enough if the function is not continuous on the interval.$txt$,
        '{ivt_application}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ivt_application', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'ivt_missing_continuity' FROM new_question;


-- ============================================================
-- 1.16-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.16-P5', 'Both', 'Both_Limits', '1.16', '1.16', 'MCQ', FALSE,
        5, 360, '{ivt_application,continuity_concept}', '{ivt_missing_continuity}', 'text',
        $txt$Let $f(x)=x^3-6x+1$. Which statement is true?$txt$,
        $txt$Let $f(x)=x^3-6x+1$. Which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f$ has exactly one real root", "type": "text", "explanation": "IVT can guarantee existence, not uniqueness."},
          {"id": "B", "label": "B", "value": "There is at least one real root in $(0,1)$", "type": "text", "explanation": "Correct: sign change from $f(0)=1$ to $f(1)=-4$ guarantees a root in $(0,1)$."},
          {"id": "C", "label": "C", "value": "There is at least one real root in $(1,2)$", "type": "text", "explanation": "Check $f(1)=-4$ and $f(2)=-3$ (no sign change), so IVT does not guarantee a root there."},
          {"id": "D", "label": "D", "value": "$f$ has no real roots", "type": "text", "explanation": "There is at least one root by IVT."}
        ]$txt$,
        'B',
        $txt$Because $f$ is a polynomial, it is continuous. Compute $f(0)=1$ and $f(1)=-4$. Since the values change sign on $[0,1]$, IVT guarantees a root in $(0,1)$.$txt$,
        '{ivt_application}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ivt_application', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'ivt_missing_continuity' FROM new_question;
