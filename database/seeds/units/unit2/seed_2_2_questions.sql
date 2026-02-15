-- Insert Script for Unit 2.2 Questions (Defining Derivatives)
-- Unit: ABBC_Derivatives / 2.2

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN ('U2.2-P1', 'U2.2-P2', 'U2.2-P3', 'U2.2-P4', 'U2.2-P5');

-- ============================================================
-- U2.2-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.2-P1', 'Both', 'ABBC_Derivatives', '2.2', '2.2', 'MCQ', FALSE,
        3, 120, '{derivative_notation}', '{derivative_notation_misread}', 'text',
        $txt$If $f'(3) = -5$, which statement is true?$txt$,
        $txt$If $f'(3)=-5$, which statement is true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$f(3) = -5$", "type": "text", "explanation": "This confuses the derivative value with the function value."},
          {"id": "B", "label": "B", "value": "The slope of the tangent line to $y=f(x)$ at $x=3$ is -5", "type": "text", "explanation": "Correct. f'(3) is the tangent slope at x=3."},
          {"id": "C", "label": "C", "value": "The slope of the secant line from $x=0$ to $x=3$ is -5", "type": "text", "explanation": "A secant slope is an average rate of change over an interval, not at a point."},
          {"id": "D", "label": "D", "value": "$f(x)$ is decreasing for all $x < 3$", "type": "text", "explanation": "Knowing f'(3) alone does not determine behavior on an entire interval."}
        ]$txt$,
        'B',
        $txt$The value $f'(3)$ represents the instantaneous rate of change of $f$ at $x=3$, which is the slope of the tangent line to the graph at $x=3$.$txt$,
        '{derivative_notation}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, '', 1.0, 0.0, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_notation', 'primary', 1.0 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'derivative_notation_misread' FROM new_question;

-- ============================================================
-- U2.2-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.2-P2', 'Both', 'ABBC_Derivatives', '2.2', '2.2', 'MCQ', FALSE,
        4, 180, '{derivative_definition_limit,difference_quotient}', '{h_limit_handling_error}', 'text',
        $txt$Using the limit definition, find $f'(2)$ for $f(x) = x^2 - 4x$.$txt$,
        $txt$Using the limit definition, find $f'(2)$ for $f(x)=x^2-4x$.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "-4", "type": "text", "explanation": "This treats the derivative like a function value or uses substitution incorrectly."},
          {"id": "B", "label": "B", "value": "-2", "type": "text", "explanation": "This often comes from an algebra slip in expanding f(2+h)."},
          {"id": "C", "label": "C", "value": "0", "type": "text", "explanation": "Correct. The derivative at x=2 is 0."},
          {"id": "D", "label": "D", "value": "2", "type": "text", "explanation": "This typically results from sign errors in the difference quotient."}
        ]$txt$,
        'C',
        $txt$From the limit definition, compute $\frac{f(2+h)-f(2)}{h}$ and simplify before letting $h$ approach 0. The simplified result gives $f'(2)=0$.$txt$,
        '{derivative_definition_limit}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_definition_limit', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'difference_quotient', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'h_limit_handling_error' FROM new_question;

-- ============================================================
-- U2.2-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.2-P3', 'Both', 'ABBC_Derivatives', '2.2', '2.2', 'MCQ', FALSE,
        4, 150, '{difference_quotient,derivative_definition_limit}', '{cancel_h_mistake}', 'text',
        $txt$Let $f(x) = x^2$. Which expression is equal to the derivative $f'(a)$ using the definition of derivative?$txt$,
        $txt$Let $f(x)=x^2$. Which expression is equal to the derivative $f'(a)$ using the definition of derivative?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\lim_{h\\to 0} ( (a+h)^2 - a^2 )$", "type": "text", "explanation": "Missing division by h, so it is not a rate of change."},
          {"id": "B", "label": "B", "value": "$\\lim_{h\\to 0} \\frac{(a+h)^2 - a^2}{h}$", "type": "text", "explanation": "Correct. This matches the definition of derivative at a."},
          {"id": "C", "label": "C", "value": "$\\lim_{h\\to 0} \\frac{a^2 - (a+h)^2}{h}$", "type": "text", "explanation": "This reverses the subtraction order and changes the sign."},
          {"id": "D", "label": "D", "value": "$\\lim_{h\\to 0} \\frac{a^2}{h}$", "type": "text", "explanation": "This does not represent a difference quotient."}
        ]$txt$,
        'B',
        $txt$By definition, $f'(a)=\lim_{h\to 0} \frac{f(a+h)-f(a)}{h}$. Substituting $f(x)=x^2$ gives $\lim_{h\to 0} \frac{(a+h)^2-a^2}{h}$.$txt$,
        '{difference_quotient}',
        'published', 1, 4, 1.2, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'difference_quotient', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_definition_limit', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'cancel_h_mistake' FROM new_question;

-- ============================================================
-- U2.2-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.2-P4', 'Both', 'ABBC_Derivatives', '2.2', '2.2', 'MCQ', FALSE,
        3, 120, '{derivative_from_graph,derivative_notation}', '{slope_from_graph_misread}', 'image',
        $txt$![Graph](/assets/U2_1769403109_2.2-P4_graph.png)

The graph of $y=f(x)$ is shown, along with the tangent line at $x=1$. What is the value of $f'(1)$?$txt$,
        $txt$![Graph](/assets/U2_1769403109_2.2-P4_graph.png)

The graph of $y=f(x)$ is shown, along with the tangent line at $x=1$. What is the value of $f'(1)$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "-3", "type": "text", "explanation": "This is too steep compared to the tangent line shown."},
          {"id": "B", "label": "B", "value": "-2", "type": "text", "explanation": "Correct. f'(1) equals the tangent slope, which is -2."},
          {"id": "C", "label": "C", "value": "1", "type": "text", "explanation": "This has the wrong sign; the tangent line is decreasing."},
          {"id": "D", "label": "D", "value": "2", "type": "text", "explanation": "This has the wrong sign and magnitude for the tangent slope."}
        ]$txt$,
        'B',
        $txt$The derivative $f'(1)$ is the slope of the tangent line at $x=1$. From the graph, the tangent line decreases 2 units for each 1 unit increase in $x$, so the slope is $-2$.$txt$,
        '{derivative_from_graph}',
        'published', 1, 3, 1.1, 'NewMaoS', 2026, 'Use file U2_1769403109_2.2-P4_graph.png', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'derivative_from_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'slope_from_graph_misread' FROM new_question;

-- ============================================================
-- U2.2-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U2.2-P5', 'Both', 'ABBC_Derivatives', '2.2', '2.2', 'MCQ', FALSE,
        5, 210, '{method_selection_derivatives,derivative_definition_limit}', '{wrong_method_choice_derivative}', 'text',
        $txt$Which method is most efficient for finding the derivative of $f(x) = x^2 + 3x$ at $x=5$?$txt$,
        $txt$Which method is most efficient for finding the derivative of $f(x)=x^2+3x$ at $x=5$?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Use the limit definition of derivative every time.", "type": "text", "explanation": "The definition works, but it is not the most efficient for polynomials."},
          {"id": "B", "label": "B", "value": "Estimate the derivative from a graph.", "type": "text", "explanation": "Graph estimation is less precise and unnecessary for a polynomial."},
          {"id": "C", "label": "C", "value": "Use derivative rules for polynomials.", "type": "text", "explanation": "Correct. Polynomial derivative rules are the most efficient method."},
          {"id": "D", "label": "D", "value": "Use a table of values near $x=5$.", "type": "text", "explanation": "A table can approximate but is slower and less exact than rules."}
        ]$txt$,
        'C',
        $txt$Since $f(x)$ is a polynomial, derivative rules are the fastest and most reliable approach. The limit definition, table, or graph would work but are less efficient here.$txt$,
        '{method_selection_derivatives}',
        'published', 1, 5, 1.35, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'method_selection_derivatives', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'derivative_definition_limit', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_derivative' FROM new_question;
