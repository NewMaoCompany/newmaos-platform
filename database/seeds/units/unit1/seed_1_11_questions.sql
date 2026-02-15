-- Insert Script for Chapter 1.11 Questions (Defining Continuity at a Point)
-- Unit: Both_Limits / 1.11

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('1.11-P1', '1.11-P2', '1.11-P3', '1.11-P4', '1.11-P5');

-- ============================================================
-- 1.11-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.11-P1', 'Both', 'Both_Limits', '1.11', '1.11', 'MCQ', FALSE,
        2, 210, '{continuity_concept,limit_notation}', '{continuity_three_conditions_miss}', 'text',
        $txt$Which set of conditions is sufficient to guarantee that $f$ is continuous at $x=a$?$txt$,
        $txt$Which set of conditions is sufficient to guarantee that $f$ is continuous at $x=a$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(a)$ exists, $\\lim_{x\\to a} f(x)$ exists, and $\\lim_{x\\to a} f(x)=f(a)$", "type": "text", "explanation": "Correct: this is exactly the 3-part definition of continuity at $x=a$."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to a} f(x)$ exists and equals 0", "type": "text", "explanation": "A limit can exist without implying continuity, and it does not need to be 0."},
          {"id": "C", "label": "C", "value": "$f(a)$ exists and $f(a)=0$", "type": "text", "explanation": "Having a function value alone does not guarantee the limit exists or matches it."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to a^-} f(x)$ exists", "type": "text", "explanation": "A one-sided limit alone is not enough for continuity."}
        ]$txt$,
        'A',
        $txt$Continuity at a point requires (1) the function value exists, (2) the limit exists, and (3) the limit equals the function value.$txt$,
        '{continuity_concept}',
        'published', 1, 2, 1.0, 'NewMaoS', 2026, 'Target time: 3.5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'limit_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'continuity_three_conditions_miss' FROM new_question;


-- ============================================================
-- 1.11-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.11-P2', 'Both', 'Both_Limits', '1.11', '1.11', 'MCQ', FALSE,
        3, 240, '{limit_estimation_graph,continuity_concept}', '{limit_vs_value}', 'text',
        $txt$Use the graph provided. Which statement is true at $x=1$?$txt$,
        $txt$Use the graph provided. Which statement is true at $x=1$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{x\\to 1} f(x)=0$ and $f(1)=0$", "type": "text", "explanation": "The graph approaches 1 at $x=1$, not 0."},
          {"id": "B", "label": "B", "value": "$\\lim_{x\\to 1} f(x)=1$ and $f(1)=0$", "type": "text", "explanation": "Correct: the limit is 1 but the function value is 0."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 1} f(x)=0$ and $f(1)=1$", "type": "text", "explanation": "This swaps the limit and function value."},
          {"id": "D", "label": "D", "value": "$\\lim_{x\\to 1} f(x)$ does not exist", "type": "text", "explanation": "The left and right approaches match, so the limit exists."}
        ]$txt$,
        'B',
        $txt$The curve approaches the hole at $(1,1)$ so $\lim_{x\to 1} f(x)=1$, but the filled point shows $f(1)=0$.$txt$,
        '{limit_estimation_graph}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'limit_estimation_graph', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'continuity_concept', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'limit_vs_value' FROM new_question;


-- ============================================================
-- 1.11-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.11-P3', 'Both', 'Both_Limits', '1.11', '1.11', 'MCQ', FALSE,
        3, 240, '{continuity_concept,algebraic_simplification}', '{continuity_three_conditions_miss}', 'text',
        $txt$Is the function $h(x)=\frac{x^2-4}{x-2}$ continuous at $x=2$??$txt$,
        $txt$Is the function $h(x)=\frac{x^2-4}{x-2}$ continuous at $x=2$??$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Yes, it is continuous because the limit exists.", "type": "text", "explanation": "A limit existing is not enough; the function value must exist and match the limit."},
          {"id": "B", "label": "B", "value": "Yes, it is continuous because $h(2)=0$.", "type": "text", "explanation": "$h(2)$ is undefined, so it cannot be 0."},
          {"id": "C", "label": "C", "value": "No, it is not continuous because $h(2)$ is undefined.", "type": "text", "explanation": "Correct: continuity fails because $h(2)$ does not exist."},
          {"id": "D", "label": "D", "value": "No, it is not continuous because the limit does not exist.", "type": "text", "explanation": "The limit actually exists after canceling."}
        ]$txt$,
        'C',
        $txt$Even though $\lim_{x\to 2} \frac{x^2-4}{x-2}$ exists (it equals 4 after simplification), the function value $h(2)$ does not exist. Therefore $h$ is not continuous at $x=2$.$txt$,
        '{continuity_concept}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Target time: 4 minutes.', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'continuity_three_conditions_miss' FROM new_question;


-- ============================================================
-- 1.11-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.11-P4', 'Both', 'Both_Limits', '1.11', '1.11', 'MCQ', FALSE,
        4, 300, '{continuity_concept,limit_concept}', '{continuity_three_conditions_miss}', 'text',
        $txt$A function $f$ satisfies $\lim_{x\to 5} f(x)=12$ and $f(5)$ exists. Which condition is still needed to conclude $f$ is continuous at $x=5$?$txt$,
        $txt$A function $f$ satisfies $\lim_{x\to 5} f(x)=12$ and $f(5)$ exists. Which condition is still needed to conclude $f$ is continuous at $x=5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(5)=12$", "type": "text", "explanation": "Correct: the missing condition is that the function value matches the limit."},
          {"id": "B", "label": "B", "value": "$f(5)\\ne 12$", "type": "text", "explanation": "That would imply discontinuity, not continuity."},
          {"id": "C", "label": "C", "value": "$\\lim_{x\\to 5} f(x)$ does not exist", "type": "text", "explanation": "The limit is already given to exist and equal 12."},
          {"id": "D", "label": "D", "value": "$f$ must be a polynomial", "type": "text", "explanation": "Continuity does not require being a polynomial."}
        ]$txt$,
        'A',
        $txt$Continuity requires the function value equals the limit value. Since the limit is 12, we must have $f(5)=12$.$txt$,
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
-- 1.11-P5 (FIXED PER USER FEEDBACK)
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        '1.11-P5', 'Both', 'Both_Limits', '1.11', '1.11', 'MCQ', FALSE,
        4, 300, '{continuity_concept,algebraic_simplification}', '{continuity_three_conditions_miss}', 'text',
        $txt$For what value of $a$ is $f(x)=\begin{cases} ax+3, & x<2 \\ x^2+a, & x\ge 2 \end{cases}$ continuous at $x=2$?$txt$,
        $txt$For what value of $a$ is $f(x)=\begin{cases} ax+3, & x<2 \\ x^2+a, & x\ge 2 \end{cases}$ continuous at $x=2$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$a=1$", "type": "text", "explanation": "Correct: $2a+3=4+a \\Rightarrow a=1$, making both sides equal to 5."},
          {"id": "B", "label": "B", "value": "$a=\\frac{1}{2}$", "type": "text", "explanation": "This does not satisfy the continuity equation $2a+3=4+a$."},
          {"id": "C", "label": "C", "value": "$a=\\frac{7}{2}$", "type": "text", "explanation": "This is an incorrect calculation result."},
          {"id": "D", "label": "D", "value": "$a=7$", "type": "text", "explanation": "This does not satisfy the continuity equation."}
        ]$txt$,
        'A',
        $txt$Continuity at $x=2$ requires the left-hand limit to equal the right-hand value: $2a+3=2^2+a$. Solving $2a+3=4+a$ gives $a=1$.$txt$,
        '{continuity_concept}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Target time: 5 minutes.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'continuity_concept', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'algebraic_simplification', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'continuity_three_conditions_miss' FROM new_question;
