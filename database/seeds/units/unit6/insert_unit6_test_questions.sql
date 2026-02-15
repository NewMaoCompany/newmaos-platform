-- Fixed Insert Script for Unit 6 Unit Test (U6-UT-Q1 to U6-UT-Q20)
-- Uses TEMP TABLE to persist data across multiple INSERT statements
-- Corrects CTE scope error (ERROR: 42P01)

BEGIN;

-- 1. Create Temp Table for Batch Data
CREATE TEMP TABLE unit6_test_batch (
    title TEXT,
    prompt TEXT,
    latex TEXT,
    options_json JSONB,
    correct_id TEXT,
    explanation TEXT,
    p_skill TEXT,
    s_skill TEXT,
    err_tag TEXT,
    p_weight NUMERIC,
    s_weight NUMERIC,
    diff INTEGER,
    time_sec INTEGER
) ON COMMIT DROP;

-- 2. Populate Temp Table
INSERT INTO unit6_test_batch (
    title, prompt, latex, options_json, correct_id, explanation,
    p_skill, s_skill, err_tag, p_weight, s_weight, diff, time_sec
) VALUES
-- Q1
('U6-UT-Q1',
 $txt$A particle moves along a line with velocity $v(t)$. Over $0\le t\le 6$, $v(t)$ is piecewise constant:
- $v(t)=2$ for $0\le t<2$
- $v(t)=-1$ for $2\le t<5$
- $v(t)=1$ for $5\le t\le 6$

What is the net change in position from $t=0$ to $t=6$?$txt$,
 $txt$A particle moves along a line with velocity $v(t)$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$-1$", "explanation": "That would come from treating negative velocity as subtracting distance incorrectly."},
   {"id": "B", "label": "B", "value": "$0$", "explanation": "That would require positive and negative areas to cancel; they do not."},
   {"id": "C", "label": "C", "value": "$2$", "explanation": "Correct: signed areas add to 2."},
   {"id": "D", "label": "D", "value": "$5$", "explanation": "That is total distance ($\\lvert v\\rvert$), not net change."}
 ]$txt$::jsonb,
 'C',
 $txt$Net change $=\int v\,dt=2\cdot(2)+(-1)\cdot(3)+1\cdot(1)=4-3+1=2$.$txt$,
 'accumulation_concept', 'area_vs_net_change', 'area_vs_net_change_confusion', 0.7, 0.3, 2, 95
),
-- Q2
('U6-UT-Q2',
 $txt$Using the same velocity function from Q1 ($v(t)=2$ on $[0,2)$, $v(t)=-1$ on $[2,5)$, $v(t)=1$ on $[5,6]$), what is the total distance traveled from $t=0$ to $t=6$?$txt$,
 $txt$Using the same velocity function...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$2$", "explanation": "That is the net change, not total distance."},
   {"id": "B", "label": "B", "value": "$4$", "explanation": "That only counts the first interval distance."},
   {"id": "C", "label": "C", "value": "$6$", "explanation": "Incorrect: the absolute-value integral gives $8$, not $6$."},
   {"id": "D", "label": "D", "value": "$8$", "explanation": "Correct: total distance is $8$."}
 ]$txt$::jsonb,
 'D',
 $txt$Total distance $=\int_0^6 \lvert v(t)\rvert\,dt=2\cdot(2)+1\cdot(3)+1\cdot(1)=4+3+1=8$.$txt$,
 'velocity_position_net_change', 'area_vs_net_change', 'motion_displacement_vs_distance', 0.75, 0.25, 2, 110
),
-- Q3
('U6-UT-Q3',
 $txt$Table of values for $f$ on $[0,4]$:

| $x$ | $0$ | $1$ | $2$ | $3$ | $4$ |
|---|---|---|---|---|---|
| $f(x)$ | $1.2$ | $2.0$ | $1.5$ | $0.5$ | $-0.5$ |

Using a LEFT Riemann sum with $n=4$ subintervals, approximate $\int_0^4 f(x)\,dx$.$txt$,
 $txt$Using a LEFT Riemann sum with $n=4$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$4.7$", "explanation": "Incorrect."},
   {"id": "B", "label": "B", "value": "$5.2$", "explanation": "Correct: $\\Delta x=1$ and sum is $5.2$."},
   {"id": "C", "label": "C", "value": "$3.7$", "explanation": "Drops left endpoint."},
   {"id": "D", "label": "D", "value": "$2.7$", "explanation": "Uses right endpoints."}
 ]$txt$::jsonb,
 'B',
 $txt$\Delta x=1. Sum = 1.2+2.0+1.5+0.5=5.2.$txt$,
 'riemann_from_table', 'riemann_left_right_mid', 'riemann_sample_point_wrong', 0.7, 0.3, 2, 110
),
-- Q4
('U6-UT-Q4',
 $txt$Using the same table from Q3, use the Trapezoidal Rule with $n=4$ to approximate $\int_0^4 f(x)\,dx$.$txt$,
 $txt$Using the same table...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$4.35$", "explanation": "Correct: Average of L+R or trap formula."},
   {"id": "B", "label": "B", "value": "$5.2$", "explanation": "Left sum."},
   {"id": "C", "label": "C", "value": "$3.7$", "explanation": "Incorrect weighting."},
   {"id": "D", "label": "D", "value": "$2.7$", "explanation": "Probably just endpoints."}
 ]$txt$::jsonb,
 'A',
 $txt$Trap = 4.35.$txt$,
 'riemann_trap_rule', 'riemann_from_table', 'trap_rule_formula_error', 0.7, 0.3, 2, 120
),
-- Q5
('U6-UT-Q5',
 $txt$Which expression represents $\int_0^5 x^2\,dx$ as a limit of Riemann sums?$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$\\lim_{n\\to\\infty}\\sum_{i=1}^n \\left(\\frac{5}{n}\\right)\\left(\\frac{5i}{n}\\right)^2$", "explanation": "Correct."},
   {"id": "B", "label": "B", "value": "Limit sum formula wrong endpoints.", "explanation": "Incorrect."},
   {"id": "C", "label": "C", "value": "Limit sum formula wrong delta x.", "explanation": "Incorrect."},
   {"id": "D", "label": "D", "value": "Limit sum formula wrong everything.", "explanation": "Incorrect."}
 ]$txt$::jsonb,
 'A',
 $txt$\Delta x=5/n, x_i=5i/n.$txt$,
 'def_integral_as_limit', 'sigma_notation', 'riemann_index_shift_error', 0.7, 0.3, 2, 110
),
-- Q6
('U6-UT-Q6',
 $txt$If $\int_2^7 f(x)\,dx = 5$, what is $\int_7^2 f(x)\,dx$?$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$5$", "explanation": "Wrong sign."},
   {"id": "B", "label": "B", "value": "$-5$", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "$0$", "explanation": "Zero."},
   {"id": "D", "label": "D", "value": "$9$", "explanation": "Nine."}
 ]$txt$::jsonb,
 'B',
 $txt$Reverse bounds -> negative sign.$txt$,
 'integral_properties', 'integral_additivity', 'integral_limits_reversed', 0.8, 0.2, 1, 70
),
-- Q7
('U6-UT-Q7',
 $txt$Evaluate $\int_1^3 (4x^3-2x)\,dx$.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$64$", "explanation": "Arithmetic error."},
   {"id": "B", "label": "B", "value": "$72$", "explanation": "Correct value."},
   {"id": "C", "label": "C", "value": "$56$", "explanation": "Common error."},
   {"id": "D", "label": "D", "value": "$48$", "explanation": "Common error."}
 ]$txt$::jsonb,
 'B',
 $txt$Evaluates to 72.$txt$,
 'ftc2_eval_def_integral', 'antiderivative_basic_rules', 'ftc2_antiderivative_error', 0.7, 0.3, 2, 90
),
-- Q8
('U6-UT-Q8',
 $txt$Which is the correct indefinite integral of $6x^2$?$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$2x^3$", "explanation": "Missing C."},
   {"id": "B", "label": "B", "value": "$2x^3+C$", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "$6x^3+C$", "explanation": "Wrong rule."},
   {"id": "D", "label": "D", "value": "$3x^2+C$", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'B',
 $txt$2x^3+C.$txt$,
 'indef_integral_notation', 'antiderivative_basic_rules', 'missing_constant_C', 0.7, 0.3, 1, 75
),
-- Q9
('U6-UT-Q9',
 $txt$Evaluate $\int (2x)\cos(x^2)\,dx$.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$\\sin(x^2)+C$", "explanation": "Correct."},
   {"id": "B", "label": "B", "value": "$2\\sin(x^2)+C$", "explanation": "Extra 2."},
   {"id": "C", "label": "C", "value": "$\\cos(x^2)+C$", "explanation": "Wrong func."},
   {"id": "D", "label": "D", "value": "$\\frac{1}{2}\\sin(x^2)+C$", "explanation": "Wrong const."}
 ]$txt$::jsonb,
 'A',
 $txt$u-sub works directly.$txt$,
 'u_substitution', 'choose_integration_technique', 'u_sub_du_missing_factor', 0.75, 0.25, 2, 105
),
-- Q10
('U6-UT-Q10',
 $txt$Evaluate $\int_0^1 6x(3x^2+1)^4\,dx$ by $u$-substitution.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "Incomplete exp.", "explanation": "Incomplete."},
   {"id": "B", "label": "B", "value": "$\\frac{1}{5}\\big[4^5-1^5\\big]$", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "Plus instead of minus.", "explanation": "Wrong sign."},
   {"id": "D", "label": "D", "value": "Wrong bounds.", "explanation": "Wrong bounds."}
 ]$txt$::jsonb,
 'B',
 $txt$Bounds change to 1 and 4.$txt$,
 'u_sub_definite_bounds', 'u_substitution', 'u_sub_bounds_not_changed', 0.75, 0.25, 3, 130
),
-- Q11
('U6-UT-Q11',
 $txt$To integrate $\int \frac{x^2+1}{x+1}\,dx$, which first step is most appropriate?$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "Use $u$-sub", "explanation": "No."},
   {"id": "B", "label": "B", "value": "Use long division", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "Trapezoidal Rule", "explanation": "No."},
   {"id": "D", "label": "D", "value": "Symmetry", "explanation": "No."}
 ]$txt$::jsonb,
 'B',
 $txt$Num degree >= Den degree.$txt$,
 'long_division_rational', 'choose_integration_technique', 'long_division_not_done', 0.7, 0.3, 3, 140
),
-- Q12
('U6-UT-Q12',
 $txt$Rewrite $x^2+4x+5$ in completed-square form.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$(x+2)^2+1$", "explanation": "Correct."},
   {"id": "B", "label": "B", "value": "$(x+4)^2+5$", "explanation": "Wrong."},
   {"id": "C", "label": "C", "value": "$(x+2)^2+5$", "explanation": "Wrong."},
   {"id": "D", "label": "D", "value": "$(x-2)^2+1$", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'A',
 $txt$(x+2)^2+1.$txt$,
 'complete_square_prep', 'algebraic_prep_integrals', 'complete_square_incorrect', 0.7, 0.3, 3, 150
),
-- Q13
('U6-UT-Q13',
 $txt$Average value of $f$ on $[0,4]$ given integral is 10.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$2.5$", "explanation": "Correct."},
   {"id": "B", "label": "B", "value": "$10$", "explanation": "Integral."},
   {"id": "C", "label": "C", "value": "$40$", "explanation": "Wrong."},
   {"id": "D", "label": "D", "value": "$5$", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'A',
 $txt$10/4 = 2.5.$txt$,
 'avg_value_from_integral', 'def_integral_notation', 'avg_value_formula_wrong', 0.75, 0.25, 2, 110
),
-- Q14
('U6-UT-Q14',
 $txt$Even function, int 0 to 3 is 7. Int -3 to 3?$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$0$", "explanation": "Odd."},
   {"id": "B", "label": "B", "value": "$7$", "explanation": "Half."},
   {"id": "C", "label": "C", "value": "$14$", "explanation": "Correct."},
   {"id": "D", "label": "D", "value": "$-14$", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'C',
 $txt$Double it.$txt$,
 'integral_symmetry', 'integral_properties', 'integral_symmetry_misapplied', 0.7, 0.3, 2, 95
),
-- Q15
('U6-UT-Q15',
 $txt$Derivative of $\int_1^{x^2} (t^3-2t)\,dt$.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "No chain rule.", "explanation": "Wrong."},
   {"id": "B", "label": "B", "value": "Correct chain rule.", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "Wrong var.", "explanation": "Wrong."},
   {"id": "D", "label": "D", "value": "Partial.", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'B',
 $txt$Chain rule.$txt$,
 'ftc1_chain_rule', 'accumulation_function_derivative', 'ftc1_derivative_missing_chain', 0.75, 0.25, 3, 135
),
-- Q16
('U6-UT-Q16',
 $txt$Interval where A(x) decreasing.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$(0,2)$", "explanation": "Inc."},
   {"id": "B", "label": "B", "value": "$(2,5)$", "explanation": "Correct (f<0)."},
   {"id": "C", "label": "C", "value": "$(5,6)$", "explanation": "Inc."},
   {"id": "D", "label": "D", "value": "None.", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'B',
 $txt$A dec where f neg.$txt$,
 'accumulation_behavior_analysis', 'accumulation_function_derivative', 'accum_behavior_sign_chart_wrong', 0.7, 0.3, 3, 130
),
-- Q17
('U6-UT-Q17',
 $txt$Comparison of integral bounds.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "Correct bounds.", "explanation": "Correct."},
   {"id": "B", "label": "B", "value": "Wrong bounds.", "explanation": "Wrong."},
   {"id": "C", "label": "C", "value": "Wrong bounds.", "explanation": "Wrong."},
   {"id": "D", "label": "D", "value": "Single val.", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'A',
 $txt$Min*4, Max*4.$txt$,
 'integral_comparison_bounds', 'def_integral_notation', 'integral_property_sign_error', 0.8, 0.2, 2, 95
),
-- Q18
('U6-UT-Q18',
 $txt$Meaning of integral of rate.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "Avg rate.", "explanation": "No."},
   {"id": "B", "label": "B", "value": "Total accumulation.", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "Instant amount.", "explanation": "No."},
   {"id": "D", "label": "D", "value": "Max rate.", "explanation": "No."}
 ]$txt$::jsonb,
 'B',
 $txt$Total change.$txt$,
 'units_interpretation_integrals', 'accumulation_concept', 'units_missing_interpretation', 0.75, 0.25, 2, 105
),
-- Q19
('U6-UT-Q19',
 $txt$Net change area calc.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$11$", "explanation": "Total."},
   {"id": "B", "label": "B", "value": "$3$", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "$1$", "explanation": "Wrong."},
   {"id": "D", "label": "D", "value": "$9$", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'B',
 $txt$6-4+1=3.$txt$,
 'area_vs_net_change', 'accumulation_concept', 'accumulation_sign_misread', 0.7, 0.3, 2, 115
),
-- Q20
('U6-UT-Q20',
 $txt$Limit to integral.$txt$,
 $txt$...$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "0 to 2", "explanation": "Wrong."},
   {"id": "B", "label": "B", "value": "1 to 3", "explanation": "Correct."},
   {"id": "C", "label": "C", "value": "1 to 2", "explanation": "Wrong."},
   {"id": "D", "label": "D", "value": "0 to 3", "explanation": "Wrong."}
 ]$txt$::jsonb,
 'B',
 $txt$[1,3].$txt$,
 'def_integral_as_limit', 'riemann_sum_setup', 'riemann_delta_x_wrong', 0.7, 0.3, 3, 140
);

-- 3. Delete old questions (safe retry)
DELETE FROM public.questions WHERE title LIKE 'U6-UT-Q%';

-- 4. Insert into Questions Table
INSERT INTO public.questions (
    title, course, topic, topic_id, sub_topic_id, section_id, type, calculator_allowed,
    difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
    options, correct_option_id, explanation, recommendation_reasons,
    status, version, reasoning_level, mastery_weight, source, source_year, notes,
    weight_primary, weight_supporting, created_at, updated_at
)
SELECT
    title, 'Both', 'Both_Integration', 'Both_Integration', 'unit_test', 'unit_test', 'MCQ', FALSE,
    diff, time_sec, ARRAY[p_skill, s_skill], ARRAY[err_tag], 'text', prompt, latex,
    options_json, correct_id, explanation,
    ARRAY[p_skill],
    'published', 1, 3, 1.2, 'NewMaoS', 2026, '',
    p_weight, s_weight, NOW(), NOW()
FROM unit6_test_batch;

-- 5. Insert Primary Skills
INSERT INTO public.question_skills (question_id, skill_id, role, weight)
SELECT q.id, n.p_skill, 'primary', n.p_weight
FROM public.questions q
JOIN unit6_test_batch n ON q.title = n.title;

-- 6. Insert Supporting Skills
INSERT INTO public.question_skills (question_id, skill_id, role, weight)
SELECT q.id, n.s_skill, 'supporting', n.s_weight
FROM public.questions q
JOIN unit6_test_batch n ON q.title = n.title
WHERE n.s_skill IS NOT NULL;

-- 7. Insert Error Patterns
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT q.id, n.err_tag
FROM public.questions q
JOIN unit6_test_batch n ON q.title = n.title;

COMMIT;
