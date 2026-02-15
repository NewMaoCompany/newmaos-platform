-- Insert Script for Chapter 1.13 Questions (Removing Discontinuities)
-- Unit: Both_Limits / 1.13

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.13-P1', '1.13-P2', '1.13-P3', '1.13-P4', '1.13-P5');

-- ============================================================
-- 1.13-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.13-P1', 'Both', 'Both_Limits', '1.13', '1.13', 'MCQ', FALSE,
        3, 240, '{algebraic_simplification,continuity_concept}', '{factor_cancel_mistake}', 'text',
        $txt$For what value of $k$ is the function $f(x)=\begin{cases} \frac{x^2-4}{x-2}, & x\ne 2 \\ k, & x=2 \end{cases}$ continuous at $x=2$?$txt$,
        $txt$For what value of $k$ is the function $f(x)=\begin{cases} \frac{x^2-4}{x-2}, & x\ne 2 \\ k, & x=2 \end{cases}$ continuous at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$k=0$", "type": "text", "explanation": "0 does not match the limit value 4."},
          {"id": "B", "label": "B", "value": "$k=2$", "type": "text", "explanation": "2 is a common mistake from confusing $x$ with $x+2$."},
          {"id": "C", "label": "C", "value": "$k=4$", "type": "text", "explanation": "Correct: the limit is 4, so $f(2)$ must be 4."},
          {"id": "D", "label": "D", "value": "$k$ can be any real number", "type": "text", "explanation": "Continuity forces a single value of $k$."}
        ]$txt$,
        'C',
        $txt$To remove the discontinuity, set $k=\lim_{x\to 2} \frac{x^2-4}{x-2}$. Since $x^2-4=(x-2)(x+2)$, the limit is $\lim_{x\to 2} (x+2)=4$.$txt$,
        '{algebraic_simplification}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'algebraic_simplification', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'factor_cancel_mistake' FROM new_question;


-- ============================================================
-- 1.13-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.13-P2', 'Both', 'Both_Limits', '1.13', '1.13', 'MCQ', FALSE,
        2, 210, '{discontinuity_types,limit_estimation_graph}', '{open_vs_closed_point}', 'text',
        $txt$Use the graph provided. What value should be assigned to $f(2)$ to make $f$ continuous at $x=2$?$txt$,
        $txt$Use the graph provided. What value should be assigned to $f(2)$ to make $f$ continuous at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$0$", "type": "text", "explanation": "0 is not the limiting value shown by the hole."},
          {"id": "B", "label": "B", "value": "$2$", "type": "text", "explanation": "Correct: set $f(2)$ equal to the limit value 2."},
          {"id": "C", "label": "C", "value": "$4$", "type": "text", "explanation": "4 is not the y-value approached near $x=2$."},
          {"id": "D", "label": "D", "value": "No value will make it continuous", "type": "text", "explanation": "A removable discontinuity can be fixed by defining the function at the hole."}
        ]$txt$,
        'B',
        $txt$The graph has a hole at $(2,2)$, meaning $\lim_{x\to 2} f(x)=2$. Assigning $f(2)=2$ removes the removable discontinuity.$txt$,
        '{discontinuity_types}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3.5 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'discontinuity_types', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'limit_estimation_graph', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'open_vs_closed_point' FROM new_question;


-- ============================================================
-- 1.13-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.13-P3', 'Both', 'Both_Limits', '1.13', '1.13', 'MCQ', FALSE,
        4, 300, '{continuity_concept,limit_concept}', '{continuity_three_conditions_miss}', 'text',
        $txt$Suppose $\lim_{x\to 3} f(x)=7$, but $f(3)$ is not defined. Which statement is true?$txt$,
        $txt$Suppose $\lim_{x\to 3} f(x)=7$, but $f(3)$ is not defined. Which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Defining $f(3)=7$ makes $f$ continuous at $x=3$", "type": "text", "explanation": "Correct: continuity requires $f(3)=\\lim_{x\\to 3} f(x)=7$."},
          {"id": "B", "label": "B", "value": "Defining $f(3)=0$ makes $f$ continuous at $x=3$", "type": "text", "explanation": "0 would not match the limit value 7."},
          {"id": "C", "label": "C", "value": "No definition of $f(3)$ can make $f$ continuous at $x=3$", "type": "text", "explanation": "A removable discontinuity can be fixed by defining the point correctly."},
          {"id": "D", "label": "D", "value": "The limit must not exist since $f(3)$ is undefined", "type": "text", "explanation": "A limit can exist even if the function is not defined at the point."}
        ]$txt$,
        'A',
        $txt$If the limit exists and equals 7, continuity at $x=3$ can be achieved by defining the function value to match the limit: set $f(3)=7$.$txt$,
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
SELECT id, 'continuity_three_conditions_miss' FROM new_question;


-- ============================================================
-- 1.13-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.13-P4', 'Both', 'Both_Limits', '1.13', '1.13', 'MCQ', FALSE,
        4, 330, '{algebraic_simplification,continuity_concept}', '{quotient_law_denominator_zero}', 'text',
        $txt$For what value of $k$ is $f(x)=\frac{x^2-1}{x-1}$ for $x\ne 1$ and $f(1)=k$ an extension of $f$ that is continuous at $x=1$?$txt$,
        $txt$For what value of $k$ is $f(x)=\frac{x^2-1}{x-1}$ for $x\ne 1$ and $f(1)=k$ an extension of $f$ that is continuous at $x=1$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$k=0$", "type": "text", "explanation": "0 does not match the limit value 2."},
          {"id": "B", "label": "B", "value": "$k=1$", "type": "text", "explanation": "1 is not the limit value after simplification."},
          {"id": "C", "label": "C", "value": "$k=2$", "type": "text", "explanation": "Correct: set $f(1)$ equal to the limit 2."},
          {"id": "D", "label": "D", "value": "$k=3$", "type": "text", "explanation": "3 would not match the limit."}
        ]$txt$,
        'C',
        $txt$Canceling gives $\frac{x^2-1}{x-1}=x+1$ for $x\ne 1$, so $\lim_{x\to 1} f(x)=2$. Setting $k=2$ makes the extension continuous.$txt$,
        '{algebraic_simplification}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5.5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'algebraic_simplification', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'quotient_law_denominator_zero' FROM new_question;


-- ============================================================
-- 1.13-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.13-P5', 'Both', 'Both_Limits', '1.13', '1.13', 'MCQ', FALSE,
        5, 360, '{continuity_concept,limit_laws}', '{continuity_three_conditions_miss}', 'text',
        $txt$For what value of $a$ is the function $f(x)=\begin{cases} a\sin x, & x<0 \\ x^2+a, & x\ge 0 \end{cases}$ continuous at $x=0$?$txt$,
        $txt$For what value of $a$ is the function $f(x)=\begin{cases} a\sin x, & x<0 \\ x^2+a, & x\ge 0 \end{cases}$ continuous at $x=0$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$a=0$", "type": "text", "explanation": "Correct: both sides match only when $a=0$."},
          {"id": "B", "label": "B", "value": "$a=1$", "type": "text", "explanation": "If $a=1$, left limit is 0 but right side gives 1."},
          {"id": "C", "label": "C", "value": "$a=-1$", "type": "text", "explanation": "If $a=-1$, left limit is 0 but right side gives -1."},
          {"id": "D", "label": "D", "value": "No value of $a$ works", "type": "text", "explanation": "There is a value that works: $a=0$."}
        ]$txt$,
        'A',
        $txt$Continuity at $0$ requires $\lim_{x\to 0^-} a\sin x=\lim_{x\to 0^+} (x^2+a)=f(0)$. The left limit is $a\cdot 0=0$. The right limit and $f(0)$ equal $a$. So we need $a=0$.$txt$,
        '{continuity_concept}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_laws', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'continuity_three_conditions_miss' FROM new_question;
