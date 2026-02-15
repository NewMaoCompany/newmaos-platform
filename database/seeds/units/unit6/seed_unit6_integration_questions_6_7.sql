-- Insert Script for 6.7 (FTC Part 1 / Derivatives of Integrals)
-- Note: User labels this 6.7, but content is FTC Part 1 (Derivatives of Accumulation).
-- In CED, this is often 6.4, but we follow User mappings.
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.7-P1', 'U6.7-P2', 'U6.7-P3', 'U6.7-P4', 'U6.7-P5'
);

-- ============================================================
-- U6.7-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P1', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        3, 150, '{ftc1_accumulation_function}', '{accumulation_derivative_wrong_variable}', 'text',
        $txt$Let $F(x)=\int_1^x (t^2-4t)\,dt$. What is $F'(x)$?$txt$,
        $txt$Let $F(x)=\int_1^x (t^2-4t)\,dt$. What is $F'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$x^2-4x$", "type": "text", "explanation": "Correct: FTC1 gives the integrand evaluated at $x$."},
          {"id": "B", "label": "B", "value": "$2x-4$", "type": "text", "explanation": "That is the derivative of $x^2-4x$, not the result of FTC1 here."},
          {"id": "C", "label": "C", "value": "$x^2-4$", "type": "text", "explanation": "Drops the $x$ term incorrectly."},
          {"id": "D", "label": "D", "value": "$\\int_1^x (t^2-4t)\\,dt$", "type": "text", "explanation": "FTC1 differentiates the integral; it does not stay as an integral."}
        ]$txt$,
        'A',
        $txt$By FTC Part 1, if $F(x)=\int_a^x f(t)dt$, then $F'(x)=f(x)$. Here $f(t)=t^2-4t$, so $F'(x)=x^2-4x$.$txt$,
        '{ftc_part2_basic}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_accumulation_function', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_derivative_wrong_variable' FROM new_question;

-- ============================================================
-- U6.7-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P2', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        4, 180, '{ftc1_accumulation_function}', '{accumulation_derivative_wrong_variable}', 'text',
        $txt$The function $f$ is shown in the figure. Let $G(x)=\int_0^x f(t)\,dt$. What is $G'(2)$?$txt$,
        $txt$The function $f$ is shown. Let $G(x)=\int_0^x f(t)\,dt$. What is $G'(2)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(2)$", "type": "text", "explanation": "Correct: derivative of an accumulation function equals the integrand value."},
          {"id": "B", "label": "B", "value": "$-f(2)$", "type": "text", "explanation": "The negative would come from swapping bounds, which is not the case."},
          {"id": "C", "label": "C", "value": "$\\int_0^2 f(t)\\,dt$", "type": "text", "explanation": "That is $G(2)$, not $G'(2)$."},
          {"id": "D", "label": "D", "value": "Cannot be determined from the graph", "type": "text", "explanation": "It can be determined: $G'(2)$ is the y-value $f(2)$."}
        ]$txt$,
        'A',
        $txt$By FTC1, $G'(x)=f(x)$, so $G'(2)=f(2)$ (read the y-value of the graph at $x=2$).$txt$,
        '{ftc_part2_graph_read}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Graph required (U6_6.7-P2_graph.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_accumulation_function', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_derivative_wrong_variable' FROM new_question;

-- ============================================================
-- U6.7-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P3', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        4, 180, '{ftc1_chain_inside}', '{accumulation_chain_rule_missing}', 'text',
        $txt$Let $H(x)=\int_3^{x^2} \sqrt{1+t}\,dt$. What is $H'(x)$?$txt$,
        $txt$Let $H(x)=\int_3^{x^2} \sqrt{1+t}\,dt$. What is $H'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\sqrt{1+x^2}$", "type": "text", "explanation": "Missing the chain rule factor $u'(x)=2x$."},
          {"id": "B", "label": "B", "value": "$2x\\sqrt{1+x^2}$", "type": "text", "explanation": "Correct: evaluate at $t=x^2$ and multiply by $2x$."},
          {"id": "C", "label": "C", "value": "$\\frac{1}{2\\sqrt{1+x^2}}$", "type": "text", "explanation": "That is the derivative of $\\sqrt{1+x^2}$, not the result here."},
          {"id": "D", "label": "D", "value": "$2x\\sqrt{1+t}$", "type": "text", "explanation": "Leaves an extra variable $t$; the final answer must be in $x$."}
        ]$txt$,
        'B',
        $txt$FTC1 with chain rule: if $H(x)=\int_a^{u(x)} f(t)dt$, then $H'(x)=f(u(x))u'(x)$. Here $u(x)=x^2$, $u'(x)=2x$, and $f(t)=\sqrt{1+t}$, so $H'(x)=2x\sqrt{1+x^2}$.$txt$,
        '{ftc_part2_chain_rule}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_chain_inside', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_chain_rule_missing' FROM new_question;

-- ============================================================
-- U6.7-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P4', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        5, 210, '{ftc1_chain_inside}', '{accumulation_chain_rule_missing}', 'text',
        $txt$The function $g$ is shown in the figure. Let $J(x)=\int_1^{2x-1} g(t)\,dt$. Which expression equals $J'(x)$?$txt$,
        $txt$The function $g$ is shown. Let $J(x)=\int_1^{2x-1} g(t)\,dt$. Which expression equals $J'(x)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$g(2x-1)$", "type": "text", "explanation": "Missing the derivative of the upper limit $(2x-1)'=2$."},
          {"id": "B", "label": "B", "value": "$2g(2x-1)$", "type": "text", "explanation": "Correct: multiply by 2 from the chain rule."},
          {"id": "C", "label": "C", "value": "$(2x-1)g(x)$", "type": "text", "explanation": "Not a valid FTC1 form; introduces unrelated factors."},
          {"id": "D", "label": "D", "value": "$\\int_1^{2x-1} g(t)\\,dt$", "type": "text", "explanation": "That is $J(x)$, not the derivative."}
        ]$txt$,
        'B',
        $txt$FTC1 with chain rule: $J'(x)=g(2x-1)\cdot (2)$, so $J'(x)=2g(2x-1)$.$txt$,
        '{ftc_part2_chain_rule}',
        'published', 1, 5, 1.4, 'NewMaoS', 2026, 'Graph required (U6_6.7-P4_graph.png).', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'ftc1_chain_inside', 'primary', 0.7 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_chain_rule_missing' FROM new_question;

-- ============================================================
-- U6.7-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.7-P5', 'Both', 'ABBC_Integration', '6.7', '6.7', 'MCQ', FALSE,
        4, 180, '{accumulation_from_variable_limit}', '{accumulation_derivative_wrong_variable}', 'text',
        $txt$Use the table of values of $h$. Let $K(x)=\int_{x}^{4} h(t)\,dt$. What is $K'(2)$?$txt$,
        $txt$Use the table of values of $h$. Let $K(x)=\int_{x}^{4} h(t)\,dt$. What is $K'(2)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$-h(2)$", "type": "text", "explanation": "Correct: derivative is negative of the integrand at the lower limit; then substitute $h(2)=-1$."},
          {"id": "B", "label": "B", "value": "$h(2)$", "type": "text", "explanation": "Sign is wrong for a variable lower limit."},
          {"id": "C", "label": "C", "value": "$\\int_2^4 h(t)\\,dt$", "type": "text", "explanation": "That is $K(2)$, not $K'(2)$."},
          {"id": "D", "label": "D", "value": "$0$", "type": "text", "explanation": "Nothing indicates the slope must be zero."}
        ]$txt$,
        'A',
        $txt$If $K(x)=\int_x^4 h(t)dt$, then $K'(x)=-h(x)$ (variable lower limit). From the table, $h(2)=-1$, so $K'(2)=-(-1)=1$.$txt$,
        '{ftc_part2_lower_limit_sign}',
        'published', 1, 4, 1.3, 'NewMaoS', 2026, 'Table required (U6_6.7-P5_table.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'accumulation_from_variable_limit', 'primary', 0.8 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'accumulation_derivative_wrong_variable' FROM new_question;
