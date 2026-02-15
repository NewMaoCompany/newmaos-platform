-- Insert Script for 6.2 (Riemann Sums)
-- Unit: ABBC_Integration

-- 1. Clean up potential duplicates
DELETE FROM public.questions WHERE title IN (
    'U6.2-P1', 'U6.2-P2', 'U6.2-P3', 'U6.2-P4', 'U6.2-P5'
);

-- ============================================================
-- U6.2-P1
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.2-P1', 'Both', 'ABBC_Integration', '6.2', '6.2', 'MCQ', FALSE,
        3, 180, '{riemann_sum_from_graph,riemann_sum_setup}', '{sample_point_wrong}', 'text',
        $txt$Refer to Figure U6 6.2-P1. Use a left Riemann sum with 4 subintervals of equal width on the interval [0, 4] to approximate the area under f(x).$txt$,
        $txt$Refer to Figure U6 6.2-P1. Use a left Riemann sum with 4 subintervals of equal width on the interval [0, 4] to approximate the area under f(x).$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "7", "type": "text", "explanation": "Correct: uses left endpoints with Δx = 1."},
          {"id": "B", "label": "B", "value": "6", "type": "text", "explanation": "Often comes from using midpoints or misreading one function value."},
          {"id": "C", "label": "C", "value": "8", "type": "text", "explanation": "Often comes from using right endpoints instead of left endpoints."},
          {"id": "D", "label": "D", "value": "5", "type": "text", "explanation": "Often comes from using only three rectangles or wrong width."}
        ]$txt$,
        'A',
        $txt$With 4 equal subintervals, Δx = 1 and left endpoints are x = 0, 1, 2, 3. Sum f(0)+f(1)+f(2)+f(3) times Δx, giving 7.$txt$,
        '{riemann_sum_from_graph}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Graph required.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'riemann_sum_from_graph', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'riemann_sum_setup', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sample_point_wrong' FROM new_question;

-- ============================================================
-- U6.2-P2
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.2-P2', 'Both', 'ABBC_Integration', '6.2', '6.2', 'MCQ', FALSE,
        2, 120, '{riemann_sum_setup,definite_integral_notation}', '{delta_x_wrong}', 'text',
        $txt$A midpoint Riemann sum uses n = 6 equal subintervals on the interval [2, 5]. Which is correct for Δx and the first midpoint?$txt$,
        $txt$A midpoint Riemann sum uses n = 6 equal subintervals on the interval [2, 5]. Which is correct for Δx and the first midpoint?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Δx = 0.5, first midpoint = 2.25", "type": "text", "explanation": "Correct: Δx is 0.5 and the first midpoint is halfway between 2 and 2.5."},
          {"id": "B", "label": "B", "value": "Δx = 0.5, first midpoint = 2.5", "type": "text", "explanation": "Uses the right endpoint (2.5) instead of the midpoint (2.25)."},
          {"id": "C", "label": "C", "value": "Δx = 3, first midpoint = 2.25", "type": "text", "explanation": "Uses the full interval length as Δx instead of dividing by n."},
          {"id": "D", "label": "D", "value": "Δx = 3, first midpoint = 2.5", "type": "text", "explanation": "Both Δx and the midpoint choice are incorrect."}
        ]$txt$,
        'A',
        $txt$Δx = (5 − 2)/6 = 0.5. The first subinterval is [2, 2.5], so its midpoint is 2.25.$txt$,
        '{riemann_sum_setup}',
        'published', 1, 2, 1.05, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'riemann_sum_setup', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'definite_integral_notation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'delta_x_wrong' FROM new_question;

-- ============================================================
-- U6.2-P3
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.2-P3', 'Both', 'ABBC_Integration', '6.2', '6.2', 'MCQ', FALSE,
        4, 210, '{riemann_sum_from_table,riemann_sum_setup}', '{table_interval_misuse}', 'text',
        $txt$Refer to Table U6 6.2-P3. Use a left Riemann sum to approximate the area under f(x) from x = 0 to x = 3 using the subintervals indicated by the x-values in the table (note: the widths are not all equal).$txt$,
        $txt$Refer to Table U6 6.2-P3. Use a left Riemann sum to approximate the area under f(x) from x = 0 to x = 3 using the subintervals indicated by the x-values in the table (note: the widths are not all equal).$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "5.0", "type": "text", "explanation": "Correct: uses unequal widths with left-endpoint heights."},
          {"id": "B", "label": "B", "value": "4.6", "type": "text", "explanation": "Often comes from ignoring one interval or mixing left/right endpoints."},
          {"id": "C", "label": "C", "value": "5.4", "type": "text", "explanation": "Often comes from treating all widths as 1."},
          {"id": "D", "label": "D", "value": "6.0", "type": "text", "explanation": "Often comes from using right endpoints or adding one extra interval."}
        ]$txt$,
        'A',
        $txt$Use left endpoints on each interval: widths are 0.5, 1.0, 0.5, 1.0. Compute 2.0(0.5)+1.6(1.0)+1.2(0.5)+1.8(1.0)=5.0.$txt$,
        '{riemann_sum_from_table}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, 'Table required.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'riemann_sum_from_table', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'riemann_sum_setup', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'table_interval_misuse' FROM new_question;

-- ============================================================
-- U6.2-P4
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.2-P4', 'Both', 'ABBC_Integration', '6.2', '6.2', 'MCQ', FALSE,
        4, 240, '{summation_notation_sigma,link_riemann_to_integral}', '{sigma_expression_mismatch}', 'text',
        $txt$Which sigma expression represents the right Riemann sum for $f(x)=x^2$ on $[0,2]$ using $n$ equal subintervals?$txt$,
        $txt$Which sigma expression represents the right Riemann sum for $f(x)=x^2$ on $[0,2]$ using $n$ equal subintervals?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "$\\sum_{i=0}^{n-1}\\left(\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$", "type": "text", "explanation": "Uses left endpoints (starts at i=0 and ends at n−1)."},
          {"id": "B", "label": "B", "value": "$\\sum_{i=1}^{n}\\left(\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$", "type": "text", "explanation": "Correct: right endpoints are $\\frac{2i}{n}$ with i from 1 to n."},
          {"id": "C", "label": "C", "value": "$\\sum_{i=1}^{n}\\left(\\frac{2(i-1)}{n}\\right)^2\\cdot\\frac{2}{n}$", "type": "text", "explanation": "Also corresponds to left endpoints written with a shifted index."},
          {"id": "D", "label": "D", "value": "$\\sum_{i=1}^{n}\\left(\\frac{i}{n}\\right)^2\\cdot\\frac{2}{n}$", "type": "text", "explanation": "Uses the wrong endpoint locations for the interval [0,2]."}
        ]$txt$,
        'B',
        $txt$For $[0,2]$, $\\Delta x=\\frac{2}{n}$. Right endpoints are $x_i=0+i\\Delta x=\\frac{2i}{n}$ for $i=1,2,\\dots,n$. So the sum is $\\sum_{i=1}^{n} f\\left(\\frac{2i}{n}\\right)\\Delta x$.$txt$,
        '{summation_notation_sigma}',
        'published', 1, 4, 1.25, 'NewMaoS', 2026, '', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'summation_notation_sigma', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'link_riemann_to_integral', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'sigma_expression_mismatch' FROM new_question;

-- ============================================================
-- U6.2-P5
-- ============================================================
WITH new_question AS (
    INSERT INTO public.questions (
        title, course, topic, sub_topic_id, section_id, type, calculator_allowed,
        difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
        options, correct_option_id, explanation, recommendation_reasons,
        status, version, reasoning_level, mastery_weight, source, source_year, notes,
        weight_primary, weight_supporting, created_at, updated_at
    ) VALUES (
        'U6.2-P5', 'Both', 'ABBC_Integration', '6.2', '6.2', 'MCQ', FALSE,
        3, 150, '{integral_total_vs_net_area,area_under_curve_interpretation}', '{area_sign_misread}', 'text',
        $txt$Refer to Figure U6 6.2-P5. Without computing an exact value, what is the sign of the net area (signed area) under g(x) from x = -2 to x = 3?$txt$,
        $txt$Refer to Figure U6 6.2-P5. Without computing an exact value, what is the sign of the net area (signed area) under g(x) from x = -2 to x = 3?$txt$,
        $txt$[
          {"id": "A", "label": "A", "value": "Positive", "type": "text", "explanation": "This would be true only if the positive region outweighed the negative region."},
          {"id": "B", "label": "B", "value": "Negative", "type": "text", "explanation": "Correct: the negative region dominates in magnitude on the interval."},
          {"id": "C", "label": "C", "value": "Zero", "type": "text", "explanation": "Zero would require the positive and negative magnitudes to exactly balance."},
          {"id": "D", "label": "D", "value": "Cannot be determined from the graph", "type": "text", "explanation": "A sign comparison is possible from the displayed areas."}
        ]$txt$,
        'B',
        $txt$From the graph, the region below the x-axis has greater overall magnitude than the region above the x-axis on [-2,3], so the signed (net) area is negative.$txt$,
        '{integral_total_vs_net_area}',
        'published', 1, 3, 1.15, 'NewMaoS', 2026, 'Graph required.', 0.8, 0.2, NOW(), NOW()
    ) RETURNING id
),
insert_skills AS (
    INSERT INTO public.question_skills (question_id, skill_id, role, weight)
    SELECT id, 'integral_total_vs_net_area', 'primary', 0.8 FROM new_question
    UNION ALL
    SELECT id, 'area_under_curve_interpretation', 'supporting', 0.2 FROM new_question
)
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT id, 'area_sign_misread' FROM new_question;
