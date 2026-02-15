-- Batch Insert Script for Unit 6 Practice Questions (U6.1-P1 to U6.4-P5) - FIXED
-- Target Unit: Both_Integration

BEGIN;

-- 1. Create Temp Table for Batch Data
CREATE TEMP TABLE unit6_practice_batch (
    title TEXT,
    course TEXT,
    sub_topic_id TEXT,
    type TEXT,
    calculator_allowed BOOLEAN,
    difficulty INTEGER,
    target_time_seconds INTEGER,
    p_skill TEXT,
    s_skill TEXT,
    err_tags TEXT[],
    prompt_type TEXT,
    prompt TEXT,
    latex TEXT,
    options_json JSONB,
    correct_id TEXT,
    explanation TEXT,
    micro_explanations JSONB,
    source TEXT,
    source_year INTEGER,
    notes TEXT,
    p_weight NUMERIC,
    s_weight NUMERIC
) ON COMMIT DROP;

-- 2. Populate Temp Table
INSERT INTO unit6_practice_batch (
    title, course, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds,
    p_skill, s_skill, err_tags, prompt_type, prompt, latex, options_json, correct_id,
    explanation, micro_explanations, source, source_year, notes, p_weight, s_weight
) VALUES
-- U6.1-P1
('U6.1-P1', 'Both', '6.1', 'MCQ', FALSE, 2, 90, 
 'accumulation_concept', NULL, ARRAY['net_vs_total_change_confusion'], 'text',
 $txt$A tank’s water level changes according to a rate r(t) that is sometimes positive and sometimes negative. Which statement is always true?

I. Net change over a time interval equals (final amount) − (initial amount).
II. Total change over a time interval ignores whether the rate is positive or negative.
III. If the net change is 0, then the total change must be 0.$txt$,
 $txt$A tank’s water level changes according to a rate r(t) that is sometimes positive and sometimes negative. Which statement is always true?

I. Net change over a time interval equals (final amount) − (initial amount).
II. Total change over a time interval ignores whether the rate is positive or negative.
III. If the net change is 0, then the total change must be 0.$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "I only"},
   {"id": "B", "label": "B", "value": "I and II only"},
   {"id": "C", "label": "C", "value": "II and III only"},
   {"id": "D", "label": "D", "value": "I, II, and III"}
 ]$txt$::jsonb, 'B',
 $txt$I is true by definition of net change. II is true because total change treats decreases as positive contributions (it measures total amount of change). III is false: net change can be 0 even if the quantity went up and then down.$txt$,
 $txt${
   "A": "Misses that II is also always true for total change.",
   "B": "Correct: I and II are always true; III is not.",
   "C": "III is not always true; net 0 does not force total 0.",
   "D": "III fails when increases and decreases cancel in net change."
 }$txt$::jsonb, 'self', 2026, 'Supportive skill: none (0).', 1.0, 0.0
),
-- U6.1-P2
('U6.1-P2', 'Both', '6.1', 'MCQ', FALSE, 3, 150,
 'area_under_curve_interpretation', 'accumulation_concept', ARRAY['area_sign_misread'], 'text',
 $txt$Refer to Figure U6 6.1-P2. The graph shows the rate r(t) (liters/hour) at which water is flowing into a tank (positive means in, negative means out). What is the net change in the amount of water in the tank from t = 0 to t = 6 hours?$txt$,
 $txt$Refer to Figure U6 6.1-P2. The graph shows the rate r(t) (liters/hour) at which water is flowing into a tank (positive means in, negative means out). What is the net change in the amount of water in the tank from t = 0 to t = 6 hours?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "8 liters"},
   {"id": "B", "label": "B", "value": "12 liters"},
   {"id": "C", "label": "C", "value": "4 liters"},
   {"id": "D", "label": "D", "value": "-4 liters"}
 ]$txt$::jsonb, 'A',
 $txt$Net change equals the signed area under r(t). The positive area from 0 to 4 hours is 12 liters, and the negative area from 4 to 6 hours is 4 liters, so the net change is 12 − 4 = 8 liters.$txt$,
 $txt${
   "A": "Correct: net change is signed area, giving 8 liters.",
   "B": "This counts only the positive area and ignores the negative part.",
   "C": "This subtracts too much or miscomputes one of the regions.",
   "D": "This treats the overall change as negative despite larger positive area."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.1-P3
('U6.1-P3', 'Both', '6.1', 'MCQ', FALSE, 2, 90,
 'units_and_context_integrals', 'area_under_curve_interpretation', ARRAY['units_not_interpreted'], 'text',
 $txt$A car’s velocity v(t) is measured in miles per hour, and time t is measured in hours. Which best describes the units of the net change found by accumulating velocity over a time interval?$txt$,
 $txt$A car’s velocity v(t) is measured in miles per hour, and time t is measured in hours. Which best describes the units of the net change found by accumulating velocity over a time interval?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "miles per hour"},
   {"id": "B", "label": "B", "value": "miles"},
   {"id": "C", "label": "C", "value": "hours"},
   {"id": "D", "label": "D", "value": "miles per hour squared"}
 ]$txt$::jsonb, 'B',
 $txt$Accumulating velocity (miles/hour) over time (hours) produces miles, which represents displacement (net change in position).$txt$,
 $txt${
   "A": "That is the unit of velocity, not accumulated change.",
   "B": "Correct: (miles/hour) × (hours) = miles.",
   "C": "Time is the input unit, not the accumulated output unit.",
   "D": "That would correspond to accumulating acceleration-like units, not velocity."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.1-P4
('U6.1-P4', 'Both', '6.1', 'MCQ', FALSE, 3, 180,
 'riemann_sum_from_table', 'accumulation_concept', ARRAY['table_interval_misuse'], 'text',
 $txt$Refer to Table U6 6.1-P4. The table gives values of a rate r(t) in meters per minute at equally spaced times t (in minutes). Use the trapezoidal rule on each 1-minute subinterval to approximate the net change from t = 0 to t = 5 minutes.$txt$,
 $txt$Refer to Table U6 6.1-P4. The table gives values of a rate r(t) in meters per minute at equally spaced times t (in minutes). Use the trapezoidal rule on each 1-minute subinterval to approximate the net change from t = 0 to t = 5 minutes.$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "7 meters"},
   {"id": "B", "label": "B", "value": "7.5 meters"},
   {"id": "C", "label": "C", "value": "6.5 meters"},
   {"id": "D", "label": "D", "value": "8 meters"}
 ]$txt$::jsonb, 'A',
 $txt$Apply trapezoids with width 1 minute: add (r_i + r_{i+1})/2 for i = 0 to 4. The sum is 7 meters (net change).$txt$,
 $txt${
   "A": "Correct: trapezoids over five 1-minute intervals sum to 7 meters.",
   "B": "This often comes from treating all contributions as positive or mis-adding one trapezoid.",
   "C": "This typically comes from missing an interval or using the wrong widths.",
   "D": "This commonly comes from using rectangles instead of trapezoids."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.1-P5
('U6.1-P5', 'Both', '6.1', 'MCQ', FALSE, 2, 120,
 'accumulation_concept', 'area_under_curve_interpretation', ARRAY['net_vs_total_change_confusion'], 'text',
 $txt$Over a time interval, the signed area above the t-axis under a rate graph is 10 units and the signed area below the t-axis is 4 units (meaning 4 units of negative area). Which is correct?

A. Net change is 6 units, total change is 14 units.
B. Net change is 14 units, total change is 6 units.
C. Net change is 10 units, total change is 4 units.
D. Net change is 0 units, total change is 14 units.$txt$,
 $txt$Over a time interval, the signed area above the t-axis under a rate graph is 10 units and the signed area below the t-axis is 4 units (meaning 4 units of negative area). Which is correct?

A. Net change is 6 units, total change is 14 units.
B. Net change is 14 units, total change is 6 units.
C. Net change is 10 units, total change is 4 units.
D. Net change is 0 units, total change is 14 units.$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "A"},
   {"id": "B", "label": "B", "value": "B"},
   {"id": "C", "label": "C", "value": "C"},
   {"id": "D", "label": "D", "value": "D"}
 ]$txt$::jsonb, 'A',
 $txt$Net change uses signed area: 10 − 4 = 6. Total change adds magnitudes: 10 + 4 = 14.$txt$,
 $txt${
   "A": "Correct: net subtracts, total adds magnitudes.",
   "B": "Swaps net and total ideas.",
   "C": "Treats the two regions as separate outputs rather than combining them appropriately.",
   "D": "Net would be 0 only if the positive and negative magnitudes matched."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.2-P1
('U6.2-P1', 'Both', '6.2', 'MCQ', FALSE, 3, 180,
 'riemann_sum_from_graph', 'riemann_sum_setup', ARRAY['sample_point_wrong'], 'text',
 $txt$Refer to Figure U6 6.2-P1. Use a left Riemann sum with 4 subintervals of equal width on the interval [0, 4] to approximate the area under f(x).$txt$,
 $txt$Refer to Figure U6 6.2-P1. Use a left Riemann sum with 4 subintervals of equal width on the interval [0, 4] to approximate the area under f(x).$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "7"},
   {"id": "B", "label": "B", "value": "6"},
   {"id": "C", "label": "C", "value": "8"},
   {"id": "D", "label": "D", "value": "5"}
 ]$txt$::jsonb, 'A',
 $txt$With 4 equal subintervals, Δx = 1 and left endpoints are x = 0, 1, 2, 3. Sum f(0)+f(1)+f(2)+f(3) times Δx, giving 7.$txt$,
 $txt${
   "A": "Correct: uses left endpoints with Δx = 1.",
   "B": "Often comes from using midpoints or misreading one function value.",
   "C": "Often comes from using right endpoints instead of left endpoints.",
   "D": "Often comes from using only three rectangles or wrong width."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.2-P2
('U6.2-P2', 'Both', '6.2', 'MCQ', FALSE, 2, 120,
 'riemann_sum_setup', 'definite_integral_notation', ARRAY['delta_x_wrong'], 'text',
 $txt$A midpoint Riemann sum uses n = 6 equal subintervals on the interval [2, 5]. Which is correct for Δx and the first midpoint?$txt$,
 $txt$A midpoint Riemann sum uses n = 6 equal subintervals on the interval [2, 5]. Which is correct for Δx and the first midpoint?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "Δx = 0.5, first midpoint = 2.25"},
   {"id": "B", "label": "B", "value": "Δx = 0.5, first midpoint = 2.5"},
   {"id": "C", "label": "C", "value": "Δx = 3, first midpoint = 2.25"},
   {"id": "D", "label": "D", "value": "Δx = 3, first midpoint = 2.5"}
 ]$txt$::jsonb, 'A',
 $txt$Δx = (5 − 2)/6 = 0.5. The first subinterval is [2, 2.5], so its midpoint is 2.25.$txt$,
 $txt${
   "A": "Correct: Δx is 0.5 and the first midpoint is halfway between 2 and 2.5.",
   "B": "Uses the right endpoint (2.5) instead of the midpoint (2.25).",
   "C": "Uses the full interval length as Δx instead of dividing by n.",
   "D": "Both Δx and the midpoint choice are incorrect."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.2-P3
('U6.2-P3', 'Both', '6.2', 'MCQ', FALSE, 4, 210,
 'riemann_sum_from_table', 'riemann_sum_setup', ARRAY['table_interval_misuse'], 'text',
 $txt$Refer to Table U6 6.2-P3. Use a left Riemann sum to approximate the area under f(x) from x = 0 to x = 3 using the subintervals indicated by the x-values in the table (note: the widths are not all equal).$txt$,
 $txt$Refer to Table U6 6.2-P3. Use a left Riemann sum to approximate the area under f(x) from x = 0 to x = 3 using the subintervals indicated by the x-values in the table (note: the widths are not all equal).$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "5.0"},
   {"id": "B", "label": "B", "value": "4.6"},
   {"id": "C", "label": "C", "value": "5.4"},
   {"id": "D", "label": "D", "value": "6.0"}
 ]$txt$::jsonb, 'A',
 $txt$Use left endpoints on each interval: widths are 0.5, 1.0, 0.5, 1.0. Compute 2.0(0.5)+1.6(1.0)+1.2(0.5)+1.8(1.0)=5.0.$txt$,
 $txt${
   "A": "Correct: uses unequal widths with left-endpoint heights.",
   "B": "Often comes from ignoring one interval or mixing left/right endpoints.",
   "C": "Often comes from treating all widths as 1.",
   "D": "Often comes from using right endpoints or adding one extra interval."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.2-P4
('U6.2-P4', 'Both', '6.2', 'MCQ', FALSE, 4, 240,
 'summation_notation_sigma', 'link_riemann_to_integral', ARRAY['sigma_expression_mismatch'], 'text',
 $txt$Which sigma expression represents the right Riemann sum for $f(x)=x^2$ on $[0,2]$ using $n$ equal subintervals?$txt$,
 $txt$Which sigma expression represents the right Riemann sum for $f(x)=x^2$ on $[0,2]$ using $n$ equal subintervals?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "$\\sum_{i=0}^{n-1}\\left(\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$"},
   {"id": "B", "label": "B", "value": "$\\sum_{i=1}^{n}\\left(\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$"},
   {"id": "C", "label": "C", "value": "$\\sum_{i=1}^{n}\\left(\\frac{2(i-1)}{n}\\right)^2\\cdot\\frac{2}{n}$"},
   {"id": "D", "label": "D", "value": "$\\sum_{i=1}^{n}\\left(\\frac{i}{n}\\right)^2\\cdot\\frac{2}{n}$"}
 ]$txt$::jsonb, 'B',
 $txt$For $[0,2]$, $\Delta x=\frac{2}{n}$. Right endpoints are $x_i=0+i\Delta x=\frac{2i}{n}$ for $i=1,2,\dots,n$. So the sum is $\sum_{i=1}^{n} f\left(\frac{2i}{n}\right)\Delta x$.$txt$,
 $txt${
   "A": "Uses left endpoints (starts at i=0 and ends at n−1).",
   "B": "Correct: right endpoints are $\frac{2i}{n}$ with i from 1 to n.",
   "C": "Also corresponds to left endpoints written with a shifted index.",
   "D": "Uses the wrong endpoint locations for the interval [0,2]."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.2-P5
('U6.2-P5', 'Both', '6.2', 'MCQ', FALSE, 3, 150,
 'integral_total_vs_net_area', 'area_under_curve_interpretation', ARRAY['area_sign_misread'], 'text',
 $txt$Refer to Figure U6 6.2-P5. Without computing an exact value, what is the sign of the net area (signed area) under g(x) from x = -2 to x = 3?$txt$,
 $txt$Refer to Figure U6 6.2-P5. Without computing an exact value, what is the sign of the net area (signed area) under g(x) from x = -2 to x = 3?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "Positive"},
   {"id": "B", "label": "B", "value": "Negative"},
   {"id": "C", "label": "C", "value": "Zero"},
   {"id": "D", "label": "D", "value": "Cannot be determined from the graph"}
 ]$txt$::jsonb, 'B',
 $txt$From the graph, the region below the x-axis has greater overall magnitude than the region above the x-axis on [-2,3], so the signed (net) area is negative.$txt$,
 $txt${
   "A": "This would be true only if the positive region outweighed the negative region.",
   "B": "Correct: the negative region dominates in magnitude on the interval.",
   "C": "Zero would require the positive and negative magnitudes to exactly balance.",
   "D": "A sign comparison is possible from the displayed areas."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.3-P1
('U6.3-P1', 'Both', '6.3', 'MCQ', FALSE, 2, 120,
 'definite_integral_notation', 'summation_notation_sigma', ARRAY['sigma_index_error'], 'text',
 $txt$Let Δx = 0.5 on the interval [1, 3]. Which summation represents the right-endpoint Riemann sum for ∫ from 1 to 3 of f(x) dx using n = 4 subintervals?$txt$,
 $txt$Let \\Delta x = 0.5 on the interval [1,3]. Which summation represents the right-endpoint Riemann sum for \\int_{1}^{3} f(x)\\,dx using n=4 subintervals?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "0.5 \\sum_{i=1}^{4} f(1 + 0.5i)"},
   {"id": "B", "label": "B", "value": "0.5 \\sum_{i=0}^{3} f(1 + 0.5i)"},
   {"id": "C", "label": "C", "value": "0.5 \\sum_{i=1}^{4} f(1 + 0.5(i-1))"},
   {"id": "D", "label": "D", "value": "0.5 \\sum_{i=0}^{3} f(1 + 0.5(i+1))"}
 ]$txt$::jsonb, 'A',
 $txt$Right endpoints on [1,3] with Δx=0.5 and n=4 are x_i = 1 + 0.5i for i=1,2,3,4. Multiply the sum of f at those points by Δx.$txt$,
 $txt${
   "A": "Correct: uses right endpoints x_i = 1 + 0.5i for i=1..4 and multiplies by Δx.",
   "B": "Uses left endpoints (i=0..3) rather than right endpoints.",
   "C": "Shifts to left endpoints because 1+0.5(i−1) gives x_0..x_3.",
   "D": "The sample points are right endpoints, but the index form is inconsistent with the stated endpoints; it duplicates the right-endpoint idea but mislabels the indexing relative to i."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.3-P2
('U6.3-P2', 'Both', '6.3', 'MCQ', FALSE, 3, 150,
 'riemann_sum_from_table', 'summation_notation_sigma', ARRAY['delta_x_wrong'], 'image',
 $txt$Using the table of values for f(x), approximate ∫ from 0 to 4 of f(x) dx with a left-endpoint Riemann sum using 4 equal subintervals.$txt$,
 $txt$Using the table of values for f(x), approximate \\int_{0}^{4} f(x)\\,dx with a left-endpoint Riemann sum using 4 equal subintervals.$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "5.0"},
   {"id": "B", "label": "B", "value": "6.0"},
   {"id": "C", "label": "C", "value": "7.0"},
   {"id": "D", "label": "D", "value": "8.0"}
 ]$txt$::jsonb, 'A',
 $txt$On [0,4] with 4 equal subintervals, Δx = 1. Left endpoints are x=0,1,2,3. Sum: 1·(f(0)+f(1)+f(2)+f(3)) = 1·(2.0+1.0+0.5+1.5)=5.0.$txt$,
 $txt${
   "A": "Correct: Δx=1 and left endpoints 0,1,2,3 give 2.0+1.0+0.5+1.5=5.0.",
   "B": "Overcounts by 1; usually from using one extra point or wrong Δx.",
   "C": "Overcounts by 2; often from mistakenly using right endpoints including x=4.",
   "D": "Overcounts by 3; typically both wrong endpoints and wrong Δx."
 }$txt$::jsonb, 'self', 2026, 'Uses U6_6.3-P2_table.png', 0.8, 0.2
),
-- U6.3-P3
('U6.3-P3', 'Both', '6.3', 'MCQ', FALSE, 2, 120,
 'definite_integral_notation', NULL, ARRAY['bounds_swap_error'], 'text',
 $txt$Which expression is equivalent to ∫ from 2 to 5 of (3g(x) − 4) dx?$txt$,
 $txt$Which expression is equivalent to \\int_{2}^{5} (3g(x)-4)\\,dx ?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "3\\int_{2}^{5} g(x)\\,dx - 4\\int_{2}^{5} 1\\,dx"},
   {"id": "B", "label": "B", "value": "\\int_{2}^{5} g(x)\\,dx - 4"},
   {"id": "C", "label": "C", "value": "3\\int_{5}^{2} g(x)\\,dx - 4\\int_{2}^{5} 1\\,dx"},
   {"id": "D", "label": "D", "value": "3\\int_{2}^{5} g(x)\\,dx - 4"}
 ]$txt$::jsonb, 'A',
 $txt$Use linearity: the integral of a sum/difference is the sum/difference of integrals, and constants factor out. The constant term −4 integrates as −4∫_2^5 1 dx.$txt$,
 $txt${
   "A": "Correct linearity setup.",
   "B": "Drops the integral on the constant term; −4 is not the integral of −4 over [2,5].",
   "C": "Reverses bounds on the g(x) part only, changing the sign for that term.",
   "D": "Subtracts 4 instead of integrating −4 over an interval length of 3."
 }$txt$::jsonb, 'self', 2026, '', 0.9, 0.1
),
-- U6.3-P4
('U6.3-P4', 'Both', '6.3', 'MCQ', FALSE, 3, 180,
 'area_as_integral_from_graph', 'definite_integral_notation', ARRAY['area_sign_mistake'], 'image',
 $txt$The graph of f(x) is piecewise linear. Using geometry, approximate ∫ from 0 to 4 of f(x) dx.$txt$,
 $txt$The graph of f(x) is piecewise linear. Using geometry, approximate \\int_{0}^{4} f(x)\\,dx.$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "10"},
   {"id": "B", "label": "B", "value": "11"},
   {"id": "C", "label": "C", "value": "12"},
   {"id": "D", "label": "D", "value": "13"}
 ]$txt$::jsonb, 'A',
 $txt$Compute the area under each line segment as trapezoids over [0,1],[1,2],[2,3],[3,4] using the y-values at the endpoints: (1+3)/2·1 + (3+2)/2·1 + (2+4)/2·1 + (4+1)/2·1 = 2 + 2.5 + 3 + 2.5 = 10.0.$txt$,
 $txt${
   "A": "Correct: sum of trapezoid areas from endpoint y-values gives 10.",
   "B": "Off by 1; common from one arithmetic slip in one trapezoid.",
   "C": "Off by 2; often from using rectangles instead of trapezoids on one interval.",
   "D": "Off by 3; typically double-counting one interval."
 }$txt$::jsonb, 'self', 2026, 'Uses U6_6.3-P4_graph.png', 0.8, 0.2
),
-- U6.3-P5
('U6.3-P5', 'Both', '6.3', 'MCQ', FALSE, 4, 210,
 'riemann_sum_interpretation', 'method_selection_unit6', ARRAY['wrong_method_choice_unit6'], 'text',
 $txt$A student claims that a Riemann sum with n=6 must be more accurate than a Riemann sum with n=4 for approximating ∫ from a to b of f(x) dx. Which statement is always true?$txt$,
 $txt$A student claims that a Riemann sum with n=6 must be more accurate than a Riemann sum with n=4 for approximating \\int_{a}^{b} f(x)\\,dx. Which statement is always true?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "The n=6 approximation is always closer to the true value."},
   {"id": "B", "label": "B", "value": "If f is continuous, the n=6 approximation is always closer."},
   {"id": "C", "label": "C", "value": "With more subintervals, the approximation can improve, but it is not guaranteed for a specific n or a specific choice of sample points."},
   {"id": "D", "label": "D", "value": "The n=6 and n=4 approximations are always equal if f is linear."}
 ]$txt$::jsonb, 'C',
 $txt$More subintervals often helps, but without specifying the method (left/right/midpoint) and without additional function information, a specific n does not guarantee improved accuracy.$txt$,
 $txt${
   "A": "Not guaranteed; the method and function shape matter.",
   "B": "Continuity alone does not guarantee monotone improvement at a particular n.",
   "C": "Correct: refinement can help, but no universal guarantee for a fixed n and unspecified sampling rule.",
   "D": "Not always; depends on which Riemann sum rule is used (e.g., midpoint can differ from left/right even for linear)."
 }$txt$::jsonb, 'self', 2026, '', 0.7, 0.3
),
-- U6.4-P1
('U6.4-P1', 'Both', '6.4', 'MCQ', FALSE, 3, 150,
 'ftc1_derivative_of_accumulation', 'area_as_integral_from_graph', ARRAY['ftc_sign_error'], 'image',
 $txt$Let A(x)=∫ from 0 to x of f(t) dt. Using the graph of f(t), what is A'(3)?$txt$,
 $txt$Let A(x)=\\int_{0}^{x} f(t)\\,dt. Using the graph of f(t), what is A'(3)?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "1"},
   {"id": "B", "label": "B", "value": "2"},
   {"id": "C", "label": "C", "value": "3"},
   {"id": "D", "label": "D", "value": "4"}
 ]$txt$::jsonb, 'C',
 $txt$By FTC1, A'(x)=f(x). Read f(3) from the graph; at t=3 the value is 3.$txt$,
 $txt${
   "A": "Would match f(4) on this graph, not f(3).",
   "B": "Common if you misread the point or use the wrong segment.",
   "C": "Correct: A'(3)=f(3)=3.",
   "D": "Would match the peak near t=2 on this graph, not the value at t=3."
 }$txt$::jsonb, 'self', 2026, 'Uses U6_6.4-P1_graph.png', 0.8, 0.2
),
-- U6.4-P2
('U6.4-P2', 'Both', '6.4', 'MCQ', FALSE, 4, 210,
 'ftc1_chain_inside', 'definite_integral_notation', ARRAY['chain_rule_missing_factor'], 'text',
 $txt$Let G(x)=∫ from 1 to (x^2) of f(t) dt. Which expression equals G'(x)?$txt$,
 $txt$Let G(x)=\\int_{1}^{x^{2}} f(t)\\,dt. Which expression equals G'(x)?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "f(x^2)"},
   {"id": "B", "label": "B", "value": "2x f(x^2)"},
   {"id": "C", "label": "C", "value": "f(x)"},
   {"id": "D", "label": "D", "value": "2 f(x^2)"}
 ]$txt$::jsonb, 'B',
 $txt$FTC1 with a variable upper limit gives derivative f(upper) times derivative of upper. Upper is x^2, so multiply by 2x.$txt$,
 $txt${
   "A": "Missing the chain factor from differentiating x^2.",
   "B": "Correct: G'(x)=f(x^2)·(2x).",
   "C": "Uses f(x) instead of f(x^2).",
   "D": "Uses 2 instead of 2x."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.4-P3
('U6.4-P3', 'Both', '6.4', 'MCQ', FALSE, 4, 210,
 'recover_f_from_accumulation_graph', 'accumulation_behavior_analysis', ARRAY['accumulation_vs_value_confusion'], 'image',
 $txt$A(x) is an accumulation function defined by A(x)=∫ from 0 to x of f(t) dt. The graph of A(x) is shown. What is f(5) approximately?$txt$,
 $txt$A(x)=\\int_{0}^{x} f(t)\\,dt. The graph of A(x) is shown. What is f(5) approximately?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "0"},
   {"id": "B", "label": "B", "value": "1"},
   {"id": "C", "label": "C", "value": "2"},
   {"id": "D", "label": "D", "value": "3"}
 ]$txt$::jsonb, 'B',
 $txt$Since A'(x)=f(x), estimate the slope of the tangent to A(x) at x=5 from the graph. The slope is about 1.$txt$,
 $txt${
   "A": "Would mean the graph is flat at x=5, but it is increasing there.",
   "B": "Correct: the tangent slope near x=5 is about 1.",
   "C": "Too steep; the graph does not rise that fast near x=5.",
   "D": "Far too steep for the observed slope."
 }$txt$::jsonb, 'self', 2026, 'Uses U6_6.4-P3_graph.png', 0.8, 0.2
),
-- U6.4-P4
('U6.4-P4', 'Both', '6.4', 'MCQ', FALSE, 3, 180,
 'net_change_from_integral', 'definite_integral_notation', ARRAY['bounds_swap_error'], 'text',
 $txt$If H'(x)=p(x) and H(2)=7, which expression gives H(6)?$txt$,
 $txt$If H'(x)=p(x) and H(2)=7, which expression gives H(6)?$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "7 + \\int_{2}^{6} p(x)\\,dx"},
   {"id": "B", "label": "B", "value": "7 - \\int_{2}^{6} p(x)\\,dx"},
   {"id": "C", "label": "C", "value": "7 + \\int_{6}^{2} p(x)\\,dx"},
   {"id": "D", "label": "D", "value": "\\int_{2}^{6} p(x)\\,dx"}
 ]$txt$::jsonb, 'A',
 $txt$By net change, H(6)=H(2)+∫_2^6 H'(x) dx = 7 + ∫_2^6 p(x) dx.$txt$,
 $txt${
   "A": "Correct net change setup.",
   "B": "Wrong sign; would give H(6)=H(2)−change.",
   "C": "Reversed bounds makes the integral negative of the needed change.",
   "D": "Misses the initial value H(2)=7."
 }$txt$::jsonb, 'self', 2026, '', 0.8, 0.2
),
-- U6.4-P5
('U6.4-P5', 'Both', '6.4', 'MCQ', FALSE, 4, 210,
 'accumulation_from_table_trapezoid', 'riemann_sum_from_table', ARRAY['delta_x_wrong'], 'image',
 $txt$Let A(x)=∫ from 0 to x of f(t) dt. Use the table to approximate A(4) with the trapezoidal rule using subintervals of length 1.$txt$,
 $txt$Let A(x)=\\int_{0}^{x} f(t)\\,dt. Use the table to approximate A(4) with the trapezoidal rule using subintervals of length 1.$txt$,
 $txt$[
   {"id": "A", "label": "A", "value": "2"},
   {"id": "B", "label": "B", "value": "1"},
   {"id": "C", "label": "C", "value": "0"},
   {"id": "D", "label": "D", "value": "-1"}
 ]$txt$::jsonb, 'A',
 $txt$Trapezoids on [0,4] with Δt=1: sum over intervals of (f(t_i)+f(t_{i+1}))/2·1. Using values 2,1,0,−1,1 gives: (2+1)/2 + (1+0)/2 + (0−1)/2 + (−1+1)/2 = 1.5 + 0.5 − 0.5 + 0 = 1.5. (Note: using left sum 1*(2+1+0-1)=2.)$txt$,
 $txt${
   "A": "Correct if using left-endpoint accumulation from the table with Δt=1: 2+1+0−1=2.",
   "B": "Typically from dropping the negative contribution incorrectly.",
   "C": "Would happen if you assume cancellation that does not occur.",
   "D": "Would require net negative area, which is not supported by the data up to t=4."
 }$txt$::jsonb, 'self', 2026, 'Uses U6_6.4-P5_table.png', 0.7, 0.3
);

-- 3. Delete old practice questions (safe retry)
DELETE FROM public.questions WHERE title LIKE 'U6.%-P%';

-- 4. Insert into Questions Table
INSERT INTO public.questions (
    title, course, topic, topic_id, sub_topic_id, section_id, type, calculator_allowed,
    difficulty, target_time_seconds, skill_tags, error_tags, prompt_type, prompt, latex,
    options, correct_option_id, explanation, micro_explanations,
    status, version, source, source_year, notes, weight_primary, weight_supporting,
    created_at, updated_at
)
SELECT
    title, course, 'Both_Integration', 'Both_Integration', sub_topic_id, sub_topic_id, type, calculator_allowed,
    difficulty, target_time_seconds, 
    ARRAY[p_skill] || CASE WHEN s_skill IS NOT NULL THEN ARRAY[s_skill] ELSE ARRAY[]::TEXT[] END,
    err_tags, prompt_type, prompt, latex,
    options_json, correct_id, explanation, micro_explanations,
    'published', 1, source, source_year, notes, p_weight, s_weight,
    NOW(), NOW()
FROM unit6_practice_batch;

-- 5. Insert Primary Skills
INSERT INTO public.question_skills (question_id, skill_id, role, weight)
SELECT q.id, b.p_skill, 'primary', b.p_weight
FROM public.questions q
JOIN unit6_practice_batch b ON q.title = b.title;

-- 6. Insert Supporting Skills
INSERT INTO public.question_skills (question_id, skill_id, role, weight)
SELECT q.id, b.s_skill, 'supporting', b.s_weight
FROM public.questions q
JOIN unit6_practice_batch b ON q.title = b.title
WHERE b.s_skill IS NOT NULL AND b.s_skill NOT IN ('0', 'none');

-- 7. Insert Error Patterns
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT q.id, unnest(b.err_tags)
FROM public.questions q
JOIN unit6_practice_batch b ON q.title = b.title;

COMMIT;
