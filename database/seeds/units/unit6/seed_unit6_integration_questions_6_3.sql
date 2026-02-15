-- Insert Script for 6.3 (Riemann Sums, Summation Notation, and Definite Integral Notation)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.3-P1', 'U6.3-P2', 'U6.3-P3', 'U6.3-P4', 'U6.3-P5'
);

-- ============================================================
-- U6.3-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.3-P1', 'Both', 'ABBC_Integration', '6.3', '6.3', 'MCQ', FALSE,
        2, 120, '{definite_integral_notation,summation_notation_sigma}', '{sigma_index_error}', 'text',
        $txt$Let Δx = 0.5 on the interval [1, 3]. Which summation represents the right-endpoint Riemann sum for ∫ from 1 to 3 of f(x) dx using n = 4 subintervals?$txt$,
        $txt$Let \Delta x = 0.5 on the interval [1,3]. Which summation represents the right-endpoint Riemann sum for \int_{1}^{3} f(x)\,dx using n=4 subintervals?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "0.5 \\sum_{i=1}^{4} f(1 + 0.5i)", "type": "text", "explanation": "Correct: uses right endpoints x_i = 1 + 0.5i for i=1..4 and multiplies by Δx."},
          {"id": "B", "label": "B", "value": "0.5 \\sum_{i=0}^{3} f(1 + 0.5i)", "type": "text", "explanation": "Uses left endpoints (i=0..3) rather than right endpoints."},
          {"id": "C", "label": "C", "value": "0.5 \\sum_{i=1}^{4} f(1 + 0.5(i-1))", "type": "text", "explanation": "Shifts to left endpoints because 1+0.5(i−1) gives x_0..x_3."},
          {"id": "D", "label": "D", "value": "0.5 \\sum_{i=0}^{3} f(1 + 0.5(i+1))", "type": "text", "explanation": "The sample points are right endpoints, but the index form is inconsistent with the stated endpoints; it duplicates the right-endpoint idea but mislabels the indexing relative to i."}
        ]$txt$,
        'A',
        $txt$Right endpoints on [1,3] with Δx=0.5 and n=4 are x_i = 1 + 0.5i for i=1,2,3,4. Multiply the sum of f at those points by Δx.$txt$,
        '{definite_integral_notation}',
        'published', 1, 2, 1.1, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'definite_integral_notation', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'summation_notation_sigma', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sigma_index_error' FROM new_question;

-- ============================================================
-- U6.3-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.3-P2', 'Both', 'ABBC_Integration', '6.3', '6.3', 'MCQ', FALSE,
        3, 150, '{riemann_sum_from_table,summation_notation_sigma}', '{delta_x_wrong}', 'text',
        $txt$Using the table of values for f(x), approximate ∫ from 0 to 4 of f(x) dx with a left-endpoint Riemann sum using 4 equal subintervals.$txt$,
        $txt$Using the table of values for f(x), approximate \int_{0}^{4} f(x)\,dx with a left-endpoint Riemann sum using 4 equal subintervals.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "5.0", "type": "text", "explanation": "Correct: Δx=1 and left endpoints 0,1,2,3 give 2.0+1.0+0.5+1.5=5.0."},
          {"id": "B", "label": "B", "value": "6.0", "type": "text", "explanation": "Overcounts by 1; usually from using one extra point or wrong Δx."},
          {"id": "C", "label": "C", "value": "7.0", "type": "text", "explanation": "Overcounts by 2; often from mistakenly using right endpoints including x=4."},
          {"id": "D", "label": "D", "value": "8.0", "type": "text", "explanation": "Overcounts by 3; typically both wrong endpoints and wrong Δx."}
        ]$txt$,
        'A',
        $txt$On [0,4] with 4 equal subintervals, Δx = 1. Left endpoints are x=0,1,2,3. Sum: 1·(f(0)+f(1)+f(2)+f(3)) = 1·(2.0+1.0+0.5+1.5)=5.0.$txt$,
        '{riemann_sum_from_table}',
        'published', 1, 3, 1.2, 'NewMaoS', 2026, 'Table required (U6_6.3-P2_table.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'riemann_sum_from_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'summation_notation_sigma', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'delta_x_wrong' FROM new_question;

-- ============================================================
-- U6.3-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.3-P3', 'Both', 'ABBC_Integration', '6.3', '6.3', 'MCQ', FALSE,
        2, 120, '{definite_integral_notation}', '{bounds_swap_error}', 'text',
        $txt$Which expression is equivalent to ∫ from 2 to 5 of (3g(x) − 4) dx?$txt$,
        $txt$Which expression is equivalent to \int_{2}^{5} (3g(x)-4)\,dx ?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "3\\int_{2}^{5} g(x)\\,dx - 4\\int_{2}^{5} 1\\,dx", "type": "text", "explanation": "Correct linearity setup."},
          {"id": "B", "label": "B", "value": "\\int_{2}^{5} g(x)\\,dx - 4", "type": "text", "explanation": "Drops the integral on the constant term; −4 is not the integral of −4 over [2,5]."},
          {"id": "C", "label": "C", "value": "3\\int_{5}^{2} g(x)\\,dx - 4\\int_{2}^{5} 1\\,dx", "type": "text", "explanation": "Reverses bounds on the g(x) part only, changing the sign for that term."},
          {"id": "D", "label": "D", "value": "3\\int_{2}^{5} g(x)\\,dx - 4", "type": "text", "explanation": "Subtracts 4 instead of integrating −4 over an interval length of 3."}
        ]$txt$,
        'A',
        $txt$Use linearity: the integral of a sum/difference is the sum/difference of integrals, and constants factor out. The constant term −4 integrates as −4∫_2^5 1 dx.$txt$,
        '{definite_integral_notation}',
        'published', 1, 2, 1.1, 'NewMaoS', 2026, '', 0.9, 0.1, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'definite_integral_notation', 'primary', 0.9 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'bounds_swap_error' FROM new_question;

-- ============================================================
-- U6.3-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.3-P4', 'Both', 'ABBC_Integration', '6.3', '6.3', 'MCQ', FALSE,
        3, 180, '{area_as_integral_from_graph,definite_integral_notation}', '{area_sign_mistake}', 'text',
        $txt$The graph of f(x) is piecewise linear. Using geometry, approximate ∫ from 0 to 4 of f(x) dx.$txt$,
        $txt$The graph of f(x) is piecewise linear. Using geometry, approximate \int_{0}^{4} f(x)\,dx.$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "10", "type": "text", "explanation": "Correct: sum of trapezoid areas from endpoint y-values gives 10."},
          {"id": "B", "label": "B", "value": "11", "type": "text", "explanation": "Off by 1; common from one arithmetic slip in one trapezoid."},
          {"id": "C", "label": "C", "value": "12", "type": "text", "explanation": "Off by 2; often from using rectangles instead of trapezoids on one interval."},
          {"id": "D", "label": "D", "value": "13", "type": "text", "explanation": "Off by 3; typically double-counting one interval."}
        ]$txt$,
        'A',
        $txt$Compute the area under each line segment as trapezoids over [0,1],[1,2],[2,3],[3,4] using the y-values at the endpoints: (1+3)/2·1 + (3+2)/2·1 + (2+4)/2·1 + (4+1)/2·1 = 2 + 2.5 + 3 + 2.5 = 10.0.$txt$,
        '{area_as_integral_from_graph}',
        'published', 1, 3, 1.25, 'NewMaoS', 2026, 'Graph required (U6_6.3-P4_graph.png).', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'area_as_integral_from_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'definite_integral_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'area_sign_mistake' FROM new_question;

-- ============================================================
-- U6.3-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.3-P5', 'Both', 'ABBC_Integration', '6.3', '6.3', 'MCQ', FALSE,
        3, 150, '{riemann_sum_interpretation,method_selection_unit6}', '{wrong_method_choice_unit6}', 'text',
        $txt$A student claims that a Riemann sum with n=6 must be more accurate than a Riemann sum with n=4 for approximating ∫ from a to b of f(x) dx. Which statement is always true?$txt$,
        $txt$A student claims that a Riemann sum with n=6 must be more accurate than a Riemann sum with n=4 for approximating \int_{a}^{b} f(x)\,dx. Which statement is always true?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "The n=6 approximation is always closer to the true value.", "type": "text", "explanation": "Not guaranteed; the method and function shape matter."},
          {"id": "B", "label": "B", "value": "If f is continuous, the n=6 approximation is always closer.", "type": "text", "explanation": "Continuity alone does not guarantee monotone improvement at a particular n."},
          {"id": "C", "label": "C", "value": "With more subintervals, the approximation can improve, but it is not guaranteed for a specific n or a specific choice of sample points.", "type": "text", "explanation": "Correct: refinement can help, but no universal guarantee for a fixed n and unspecified sampling rule."},
          {"id": "D", "label": "D", "value": "The n=6 and n=4 approximations are always equal if f is linear.", "type": "text", "explanation": "Not always; depends on which Riemann sum rule is used."}
        ]$txt$,
        'C',
        $txt$More subintervals often helps, but without specifying the method (left/right/midpoint) and without additional function information, a specific n does not guarantee improved accuracy.$txt$,
        '{riemann_sum_interpretation}',
        'published', 1, 4, 1.35, 'NewMaoS', 2026, '', 0.7, 0.3, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'riemann_sum_interpretation', 'primary', 0.7 FROM new_question
    UNION ALL
    SELECT id, 'method_selection_unit6', 'supporting', 0.3 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'wrong_method_choice_unit6' FROM new_question;
