-- Insert Script for Chapter 1.1 Questions (Updated 1.1-P5 Table Style)
-- Unit: Both_Limits / 1.1

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.1-P1', '1.1-P2', '1.1-P3', '1.1-P4', '1.1-P5');

-- ============================================================
-- 1.1-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.1-P1', 'Both', 'Both_Limits', '1.1', '1.1', 'MCQ', FALSE,
        1, 120, '{avg_vs_instant_rate,limit_concept}', '{average_vs_instant}', 'text',
        $txt$A particle moves along a line with position given by $s(t)=t^2+1$ (meters), where $t$ is measured in seconds. What is the average rate of change of $s(t)$ on the interval $2\le t\le 5$?$txt$,
        $txt$A particle moves along a line with position given by $s(t)=t^2+1$ (meters), where $t$ is measured in seconds. What is the average rate of change of $s(t)$ on the interval $2\le t\le 5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "3", "type": "text", "explanation": "This comes from using an incorrect change in time or a subtraction mistake."},
          {"id": "B", "label": "B", "value": "7", "type": "text", "explanation": "Correct: $\\frac{s(5)-s(2)}{5-2}=\\frac{26-5}{3}=7$."},
          {"id": "C", "label": "C", "value": "21", "type": "text", "explanation": "This is the change in position $s(5)-s(2)$, not the average rate."},
          {"id": "D", "label": "D", "value": "9", "type": "text", "explanation": "This commonly results from mixing up average rate with another slope value."}
        ]$txt$,
        'B',
        $txt$Average rate of change on $[2,5]$ is $\frac{s(5)-s(2)}{5-2}=\frac{(26)-(5)}{3}=7$.$txt$,
        '{avg_vs_instant_rate}',
        'published', 1, 1, 0.9, 'NewMaoS', 2026, 'Target time: 2 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'avg_vs_instant_rate', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'limit_concept', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'average_vs_instant' FROM new_question;


-- ============================================================
-- 1.1-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.1-P2', 'Both', 'Both_Limits', '1.1', '1.1', 'MCQ', FALSE,
        2, 180, '{avg_vs_instant_rate,method_selection}', '{difference_quotient_wrong_limit}', 'text',
        $txt$For a differentiable function $f$, which limit expression represents the instantaneous rate of change of $f$ at $x=3$?$txt$,
        $txt$For a differentiable function $f$, which limit expression represents the instantaneous rate of change of $f$ at $x=3$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{h\\to 0}\\frac{f(3+h)-f(3)}{h}$", "type": "text", "explanation": "Correct: this is the limit definition of $f'(3)$."},
          {"id": "B", "label": "B", "value": "$\\lim_{h\\to 0}\\frac{f(3)-f(3+h)}{h}$", "type": "text", "explanation": "This reverses the subtraction and gives $-f'(3)$."},
          {"id": "C", "label": "C", "value": "$\\lim_{h\\to 3}\\frac{f(h)-f(3)}{h-3}$", "type": "text", "explanation": "This uses the wrong limit variable approach; it should be $h\\to 0$, not $h\\to 3$."},
          {"id": "D", "label": "D", "value": "$\\frac{f(3)-f(0)}{3-0}$", "type": "text", "explanation": "This is the average rate of change on $[0,3]$, not instantaneous."}
        ]$txt$,
        'A',
        $txt$The instantaneous rate of change at $x=3$ is the derivative $f'(3)$, which is defined by $\lim_{h\to 0}\frac{f(3+h)-f(3)}{h}$.$txt$,
        '{avg_vs_instant_rate}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'avg_vs_instant_rate', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'method_selection', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'difference_quotient_wrong_limit' FROM new_question;


-- ============================================================
-- 1.1-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.1-P3', 'Both', 'Both_Limits', '1.1', '1.1', 'MCQ', FALSE,
        3, 240, '{derivative_definition,conjugate_rationalization}', '{conjugate_setup_error}', 'text',
        $txt$Let $f(x)=\sqrt{x+4}$. Using the limit definition, what is $f'(0)$?$txt$,
        $txt$Let $f(x)=\sqrt{x+4}$. Using the limit definition, what is $f'(0)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{1}{2}$", "type": "text", "explanation": "This commonly occurs if a factor of 2 is missed after simplifying."},
          {"id": "B", "label": "B", "value": "$\\frac{1}{4}$", "type": "text", "explanation": "Correct: after rationalizing, the limit becomes $\\frac{1}{\\sqrt{4}+2}=\\frac{1}{4}$."},
          {"id": "C", "label": "C", "value": "2", "type": "text", "explanation": "This confuses the function value $f(0)=2$ with the derivative."},
          {"id": "D", "label": "D", "value": "4", "type": "text", "explanation": "This often comes from inverting the final result or dropping the denominator."}
        ]$txt$,
        'B',
        $txt$By definition, $f'(0)=\lim_{h\to 0}\frac{\sqrt{h+4}-2}{h}$. Multiply by the conjugate to get $\frac{1}{\sqrt{h+4}+2}$. Then $f'(0)=\frac{1}{4}$.$txt$,
        '{derivative_definition}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_definition', 'primary', 0.9 FROM new_question
    UNION ALL
    SELECT id, 'conjugate_rationalization', 'supporting', 0.1 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'conjugate_setup_error' FROM new_question;


-- ============================================================
-- 1.1-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.1-P4', 'Both', 'Both_Limits', '1.1', '1.1', 'MCQ', FALSE,
        2, 180, '{derivative_definition,discontinuity_types}', '{two_sided_requires_match}', 'text',
        $txt$Let $g(x)=|x-2|$. Which statement is true about the instantaneous rate of change of $g$ at $x=2$?$txt$,
        $txt$Let $g(x)=|x-2|$. Which statement is true about the instantaneous rate of change of $g$ at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$g'(2)=-1$", "type": "text", "explanation": "This is the left-hand derivative only, not the two-sided derivative."},
          {"id": "B", "label": "B", "value": "$g'(2)=0$", "type": "text", "explanation": "A corner is not differentiable; the slope is not forced to be 0."},
          {"id": "C", "label": "C", "value": "$g'(2)=1$", "type": "text", "explanation": "This is the right-hand derivative only, not the two-sided derivative."},
          {"id": "D", "label": "D", "value": "$g'(2)$ does not exist", "type": "text", "explanation": "Correct: left slope $-1$ and right slope $1$ do not match, so the derivative does not exist."}
        ]$txt$,
        'D',
        $txt$For $g(x)=|x-2|$, the slope from the left of $x=2$ is $-1$ and the slope from the right is $1$. Since the one-sided derivatives do not match, $g'(2)$ does not exist.$txt$,
        '{derivative_definition}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_definition', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'discontinuity_types', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'two_sided_requires_match' FROM new_question;


-- ============================================================
-- 1.1-P5 (Updated format to match user screenshot: Grid Table)
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.1-P5', 'Both', 'Both_Limits', '1.1', '1.1', 'MCQ', FALSE,
        3, 240, '{limit_estimation_table,avg_vs_instant_rate}', '{table_trend_misread}', 'text',
        $txt$A function $f$ is defined by the table below. Based on the table, what is the best estimate of $f'(2.0)$?

\[
\begin{array}{|c|c|c|c|}
\hline
 t & 1.9 & 2.0 & 2.1 \\
\hline
 f(t) & 6.86 & 8.00 & 9.26 \\
\hline
\end{array}
\]$txt$,
        $txt$A function $f$ is defined by the table below. Based on the table, what is the best estimate of $f'(2.0)$?

\[
\begin{array}{|c|c|c|c|}
\hline
 t & 1.9 & 2.0 & 2.1 \\
\hline
 f(t) & 6.86 & 8.00 & 9.26 \\
\hline
\end{array}
\]$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "11.4", "type": "text", "explanation": "This is the backward difference: $\\frac{f(2.0)-f(1.9)}{0.1}=11.4$."},
          {"id": "B", "label": "B", "value": "12.0", "type": "text", "explanation": "Correct: symmetric estimate $\\frac{f(2.1)-f(1.9)}{0.2}=12.0$ best matches $f'(2.0)$."},
          {"id": "C", "label": "C", "value": "12.6", "type": "text", "explanation": "This is the forward difference: $\\frac{f(2.1)-f(2.0)}{0.1}=12.6$."},
          {"id": "D", "label": "D", "value": "2.4", "type": "text", "explanation": "This is $f(2.1)-f(1.9)=2.4$, but it forgets to divide by the time interval $0.2$."}
        ]$txt$,
        'B',
        $txt$Use a symmetric difference around $t=2.0$: $\frac{f(2.1)-f(1.9)}{2.1-1.9}=\frac{9.26-6.86}{0.2}=\frac{2.40}{0.2}=12.0$.$txt$,
        '{limit_estimation_table}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Target time: 6 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'avg_vs_instant_rate', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_trend_misread' FROM new_question;
