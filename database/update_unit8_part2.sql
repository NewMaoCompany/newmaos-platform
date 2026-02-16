-- Unit 8.3 (Using Accumulation Functions and Definite Integrals in Applied Contexts) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.3',
  section_id = '8.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_ACCUM_NET_CHANGE', 'SK_DEF_INT_EVAL'],
  error_tags = ARRAY['E_CONFUSE_NET_WITH_TOTAL', 'E_ARITHMETIC_INTEGRAL'],
  prompt = 'A particle moves along a line with velocity $v(t)=2t-1$ (meters per second) for $0\le t\le 3$. If its position at $t=0$ is $x(0)=5$, what is $x(3)$?',
  latex = 'A particle moves along a line with velocity $v(t)=2t-1$ (meters per second) for $0\le t\le 3$. If its position at $t=0$ is $x(0)=5$, what is $x(3)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5$','explanation','This ignores the net change from integrating the velocity.'),
    jsonb_build_object('id','B','text','$11$','explanation','Correct: $x(3)=x(0)+\int_0^3(2t-1)\,dt=5+6=11$.'),
    jsonb_build_object('id','C','text','$14$','explanation','This treats $\int_0^3(2t-1)\,dt$ as $9$ instead of $6$.'),
    jsonb_build_object('id','D','text','$-1$','explanation','This confuses velocity with position and ignores the initial position.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Net change in position is the integral of velocity:
$$\Delta x=\int_0^3(2t-1)\,dt=\left[t^2-t\right]_0^3=9-3=6.$$
Therefore $x(3)=x(0)+\Delta x=5+6=11$.',
  recommendation_reasons = ARRAY['Reinforces net change as an integral of a rate.', 'Targets common confusion between accumulated change and instantaneous rate.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: net change from a rate; add initial value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ACCUM_NET_CHANGE',
  supporting_skill_ids = ARRAY['SK_DEF_INT_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.3',
  section_id = '8.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ACCUM_NET_CHANGE', 'SK_PIECEWISE_INTEGRAL'],
  error_tags = ARRAY['E_REVERSE_BOUNDS', 'E_CONFUSE_NET_WITH_TOTAL', 'E_ARITHMETIC_INTEGRAL'],
  prompt = 'See image: 8.3-P2.png. A tank initially contains $10$ liters of water. The net flow rate (in liters per hour) is $r(t)$ as shown. What is the amount of water in the tank at $t=8$ hours?',
  latex = 'See image: 8.3-P2.png. A tank initially contains $10$ liters of water. The net flow rate (in liters per hour) is $r(t)$ as shown. What is the amount of water in the tank at $t=8$ hours?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$14$','explanation','This is the net change $\int_0^8 r(t)\,dt$, not the final amount.'),
    jsonb_build_object('id','B','text','$20$','explanation','This corresponds to an incorrect area sum for the step intervals.'),
    jsonb_build_object('id','C','text','$22$','explanation','This typically results from treating the negative section as positive.'),
    jsonb_build_object('id','D','text','$24$','explanation','Correct: final volume $=10+\int_0^8 r(t)\,dt=10+14=24$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Compute net change by signed areas under the step graph. From $0$ to $2$: $3\cdot2=6$. From $2$ to $4$: $3\cdot2=6$. From $4$ to $6$: $(-1)\cdot2=-2$. From $6$ to $8$: $2\cdot2=4$. Net change $=6+6-2+4=14$ liters. Final amount $=10+14=24$ liters.',
  recommendation_reasons = ARRAY['Builds accumulation from a rate graph using signed areas.', 'Targets sign and “add initial value” errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Piecewise-constant rate from a step graph; careful with signs.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_ACCUM_NET_CHANGE',
  supporting_skill_ids = ARRAY['SK_PIECEWISE_INTEGRAL'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.3',
  section_id = '8.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_ACCUM_FUNC_PROPERTIES', 'SK_SOLVE_EQUATION'],
  error_tags = ARRAY['E_REVERSE_BOUNDS', 'E_ARITHMETIC_INTEGRAL'],
  prompt = 'Let $A(x)=\int_1^x (t^2-4)\,dt$. For what value of $x\ne 1$ does $A(x)=0$?',
  latex = 'Let $A(x)=\int_1^x (t^2-4)\,dt$. For what value of $x\ne 1$ does $A(x)=0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\dfrac{-1+3\sqrt{5}}{2}$$','explanation','Correct: solving $x^3-12x+11=0$ gives this positive root besides $x=1$.'),
    jsonb_build_object('id','B','text','$$\dfrac{-1-3\sqrt{5}}{2}$$','explanation','This is the other quadratic root, which is negative.'),
    jsonb_build_object('id','C','text','$2$','explanation','This is an intersection guess; it does not satisfy $A(x)=0$.'),
    jsonb_build_object('id','D','text','$$\sqrt{11}$$','explanation','This comes from incorrectly setting the integrand to zero instead of the integral.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute
$$A(x)=\left[\frac{t^3}{3}-4t\right]_1^x=\left(\frac{x^3}{3}-4x\right)-\left(\frac{1}{3}-4\right)=\frac{x^3}{3}-4x+\frac{11}{3}.$$
Set $A(x)=0$ and multiply by $3$: $x^3-12x+11=0$. Since $x=1$ is a root, factor: $(x-1)(x^2+x-11)=0$. Thus $x=\dfrac{-1\pm\sqrt{45}}{2}=\dfrac{-1\pm3\sqrt5}{2}$. The non-1 positive solution is $\dfrac{-1+3\sqrt5}{2}$.',
  recommendation_reasons = ARRAY['Connects accumulation function values to definite integrals.', 'Targets the common mistake of setting the integrand equal to zero.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Solve for when accumulated net change returns to 0 relative to the lower limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ACCUM_FUNC_PROPERTIES',
  supporting_skill_ids = ARRAY['SK_SOLVE_EQUATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.3',
  section_id = '8.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_ACCUM_NET_CHANGE', 'SK_AVG_ROC'],
  error_tags = ARRAY['E_REVERSE_BOUNDS', 'E_CONFUSE_NET_WITH_TOTAL'],
  prompt = 'An accumulation function is defined by $s(t)=\int_0^t v(u)\,du$, where $v$ is a velocity function. If $s(2)=4$ and $s(5)=10$, what is the average value of $v(t)$ on $[2,5]$?',
  latex = 'An accumulation function is defined by $s(t)=\int_0^t v(u)\,du$, where $v$ is a velocity function. If $s(2)=4$ and $s(5)=10$, what is the average value of $v(t)$ on $[2,5]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$14$','explanation','This is $s(5)+s(2)$ (nonsensical here).'),
    jsonb_build_object('id','B','text','$6$','explanation','This is $s(5)-s(2)$ but not divided by the time interval length.'),
    jsonb_build_object('id','C','text','$2$','explanation','Correct: average $v=\dfrac{s(5)-s(2)}{5-2}=\dfrac{6}{3}=2$.'),
    jsonb_build_object('id','D','text','$$\dfrac{10}{5}$$','explanation','This incorrectly uses $s(5)/5$ instead of the secant slope on $[2,5]$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Since $s''(t)=v(t)$, the average value of $v$ on $[2,5]$ equals the average rate of change of $s$ on $[2,5]$:
$$\frac{s(5)-s(2)}{5-2}=\frac{10-4}{3}=2.$$',
  recommendation_reasons = ARRAY['Reinforces $s''(t)=v(t)$ and average value as a secant slope.', 'Common AP move: connect accumulation to derivative interpretation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Average velocity from accumulation values = secant slope.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_ACCUM_NET_CHANGE',
  supporting_skill_ids = ARRAY['SK_AVG_ROC'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.3',
  section_id = '8.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_INTERPRET_DEF_INT', 'SK_UNITS'],
  error_tags = ARRAY['E_DROP_UNITS', 'E_CONFUSE_NET_WITH_TOTAL'],
  prompt = 'Let $f(t)$ be the rate (in gallons per minute) at which water enters a pool at time $t$ minutes. Which statement best describes $\int_{20}^{50} f(t)\,dt$?',
  latex = 'Let $f(t)$ be the rate (in gallons per minute) at which water enters a pool at time $t$ minutes. Which statement best describes $\int_{20}^{50} f(t)\,dt$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The average rate at which water enters the pool between $t=20$ and $t=50$.','explanation','An average rate would require dividing by $50-20$.'),
    jsonb_build_object('id','B','text','The total amount of water (in gallons) that enters the pool from $t=20$ to $t=50$.','explanation','Correct: integrating a rate over time gives total accumulation with units of gallons.'),
    jsonb_build_object('id','C','text','The instantaneous amount of water in the pool at $t=50$.','explanation','An integral of an inflow rate does not by itself give total amount in the pool without an initial value.'),
    jsonb_build_object('id','D','text','The change in the rate $f(t)$ from $t=20$ to $t=50$.','explanation','Change in the rate would be $f(50)-f(20)$, not an integral.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because $f(t)$ is a rate in gallons per minute,
$$\int_{20}^{50} f(t)\,dt$$
accumulates gallons over that time interval. It represents the total volume of water that enters the pool from $t=20$ to $t=50$.',
  recommendation_reasons = ARRAY['Targets interpretation and units of definite integrals in context.', 'High-frequency AP error: confusing total accumulation with average rate.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Interpretation/units question (no computation).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_INTERPRET_DEF_INT',
  supporting_skill_ids = ARRAY['SK_UNITS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.3-P5';



-- Unit 8.4 (Finding the Area Between Curves Expressed as Functions of x) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.4',
  section_id = '8.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_AREA_BETWEEN_CURVES_DX', 'SK_FIND_INTERSECTIONS'],
  error_tags = ARRAY['E_WRONG_TOP_MINUS_BOTTOM', 'E_MISSED_INTERSECTION'],
  prompt = 'Find the area of the region enclosed by $y=x^2$ and $y=2x$.',
  latex = 'Find the area of the region enclosed by $y=x^2$ and $y=2x$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\dfrac{8}{3}$$','explanation','This is twice the correct value, often from using the wrong bounds length.'),
    jsonb_build_object('id','B','text','$4$','explanation','This usually comes from evaluating $\int_0^2 2x\,dx$ and ignoring subtraction.'),
    jsonb_build_object('id','C','text','$$\dfrac{2}{3}$$','explanation','This results from an arithmetic slip when evaluating the antiderivative.'),
    jsonb_build_object('id','D','text','$$\dfrac{4}{3}$$','explanation','Correct: integrate top minus bottom from $x=0$ to $x=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'First find intersections: $x^2=2x\Rightarrow x(x-2)=0$, so $x=0,2$. On $[0,2]$, $2x\ge x^2$. Area is
$$\int_0^2 (2x-x^2)\,dx=\left[x^2-\frac{x^3}{3}\right]_0^2=4-\frac{8}{3}=\frac{4}{3}.$$',
  recommendation_reasons = ARRAY['Core setup: intersections + top-minus-bottom with $dx$.', 'Targets the most common area-between-curves error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Standard parabola-line area; verify which function is on top.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AREA_BETWEEN_CURVES_DX',
  supporting_skill_ids = ARRAY['SK_FIND_INTERSECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.4',
  section_id = '8.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_AREA_BETWEEN_CURVES_DX', 'SK_PIECEWISE_SETUP'],
  error_tags = ARRAY['E_FORGOT_ABSOLUTE_VALUE', 'E_WRONG_TOP_MINUS_BOTTOM', 'E_MISSED_INTERSECTION'],
  prompt = 'Find the area of the region between $y=|x|$ and $y=2-x$ on $[-1,2]$.',
  latex = 'Find the area of the region between $y=|x|$ and $y=2-x$ on $[-1,2]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','Correct: split at $x=0$ (absolute value) and at $x=1$ (intersection).'),
    jsonb_build_object('id','B','text','$3$','explanation','This often comes from missing one sub-interval when splitting.'),
    jsonb_build_object('id','C','text','$$\dfrac{7}{2}$$','explanation','This usually results from mixing top-minus-bottom after the intersection.'),
    jsonb_build_object('id','D','text','$5$','explanation','This commonly comes from treating $|x|=x$ on the whole interval.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Split because $|x|$ changes form at $0$, and the curves intersect when $|x|=2-x$, which occurs at $x=1$.
On $[-1,0]$: $|x|=-x$ and top is $2-x$, difference $(2-x)-(-x)=2$.
On $[0,1]$: top is $2-x$, difference $(2-x)-x=2-2x$.
On $[1,2]$: top is $x$, difference $x-(2-x)=2x-2$.
Area
$$\int_{-1}^0 2\,dx+\int_0^1(2-2x)\,dx+\int_1^2(2x-2)\,dx=2+1+1=4.$$',
  recommendation_reasons = ARRAY['Forces correct handling of absolute value and changing top function.', 'Matches AP-style multi-interval area problems.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Must split at absolute-value breakpoint and at intersection.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_AREA_BETWEEN_CURVES_DX',
  supporting_skill_ids = ARRAY['SK_PIECEWISE_SETUP'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.4',
  section_id = '8.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_AREA_BETWEEN_CURVES_DX', 'SK_TRIG_INTERSECTIONS'],
  error_tags = ARRAY['E_FORGOT_ABSOLUTE_VALUE', 'E_MISSED_INTERSECTION', 'E_WRONG_TOP_MINUS_BOTTOM'],
  prompt = 'Which expression equals the area of the region between $y=\sin x$ and $y=\cos x$ on $\left[0,\frac{\pi}{2}\right]$?',
  latex = 'Which expression equals the area of the region between $y=\sin x$ and $y=\cos x$ on $\left[0,\frac{\pi}{2}\right]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\displaystyle \int_0^{\pi/2} (\cos x-\sin x)\,dx$$','explanation','This gives signed area; the difference changes sign at $x=\pi/4$.'),
    jsonb_build_object('id','B','text','$$\displaystyle \int_0^{\pi/2} (\sin x-\cos x)\,dx$$','explanation','Also signed area; negative on part of the interval.'),
    jsonb_build_object('id','C','text','$$\displaystyle \int_0^{\pi/4} (\cos x-\sin x)\,dx+\int_{\pi/4}^{\pi/2} (\sin x-\cos x)\,dx$$','explanation','Correct: split where the curves intersect so the integrands stay nonnegative.'),
    jsonb_build_object('id','D','text','$$\displaystyle \left|\int_0^{\pi/2} (\cos x-\sin x)\,dx\right|$$','explanation','Absolute value of a net signed area is not guaranteed to equal total area when sign changes.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Area requires integrating (top minus bottom) where the top curve can change. Solve $\sin x=\cos x\Rightarrow x=\pi/4$ in $[0,\pi/2]$. On $[0,\pi/4]$, $\cos x\ge\sin x$; on $[\pi/4,\pi/2]$, $\sin x\ge\cos x$. Thus the area is
$$\int_0^{\pi/4} (\cos x-\sin x)\,dx+\int_{\pi/4}^{\pi/2} (\sin x-\cos x)\,dx.$$',
  recommendation_reasons = ARRAY['Directly targets the split-or-absolute-value decision.', 'High-frequency AP trap for area between trig curves.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Identify intersection and keep integrand nonnegative for area.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AREA_BETWEEN_CURVES_DX',
  supporting_skill_ids = ARRAY['SK_TRIG_INTERSECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.4',
  section_id = '8.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_AREA_BETWEEN_CURVES_DX', 'SK_DEF_INT_EVAL'],
  error_tags = ARRAY['E_WRONG_TOP_MINUS_BOTTOM', 'E_MISSED_INTERSECTION', 'E_ARITHMETIC_INTEGRAL'],
  prompt = 'See image: 8.4-P4.png. The curves are $y=(x-1)^2$ and $y=3-x$. What is the area of the region enclosed by these two curves?',
  latex = 'See image: 8.4-P4.png. The curves are $y=(x-1)^2$ and $y=3-x$. What is the area of the region enclosed by these two curves?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\dfrac{9}{4}$$','explanation','This commonly comes from halving the correct area by mistake.'),
    jsonb_build_object('id','B','text','$$\dfrac{9}{2}$$','explanation','Correct: integrate $(3-x)-(x-1)^2$ from $x=-1$ to $x=2$.'),
    jsonb_build_object('id','C','text','$3$','explanation','This often comes from using incorrect intersection points.'),
    jsonb_build_object('id','D','text','$$\dfrac{27}{2}$$','explanation','This results from forgetting the negative contribution of the $-x^2$ term when integrating.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Find intersections: $(x-1)^2=3-x\Rightarrow x^2-2x+1=3-x\Rightarrow x^2-x-2=0\Rightarrow x=-1,2$. On $[-1,2]$, the line is above the parabola (e.g., at $x=0$, $3>1$). Area:
$$\int_{-1}^{2}\big((3-x)-(x-1)^2\big)\,dx=\int_{-1}^{2} (2+x-x^2)\,dx.$$
An antiderivative is $-\frac{x^3}{3}+\frac{x^2}{2}+2x$. Evaluate: at $2$ gives $\frac{10}{3}$; at $-1$ gives $-\frac{7}{6}$. Difference $=\frac{10}{3}+\frac{7}{6}=\frac{27}{6}=\frac{9}{2}$.',
  recommendation_reasons = ARRAY['Classic AP enclosed-area computation with intersection solving.', 'Targets errors in bounds and top-minus-bottom choice.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-supported: identify bounds from intersections; integrate line minus parabola.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_AREA_BETWEEN_CURVES_DX',
  supporting_skill_ids = ARRAY['SK_DEF_INT_EVAL'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = '8.4',
  section_id = '8.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_AREA_BETWEEN_CURVES_DX', 'SK_FIND_INTERSECTIONS'],
  error_tags = ARRAY['E_FORGOT_ABSOLUTE_VALUE', 'E_WRONG_TOP_MINUS_BOTTOM', 'E_MISSED_INTERSECTION'],
  prompt = 'See image: 8.4-P5.png. What is the area of the region enclosed by $y=\sqrt{x}$ and $y=\frac{x}{2}$?',
  latex = 'See image: 8.4-P5.png. What is the area of the region enclosed by $y=\sqrt{x}$ and $y=\frac{x}{2}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\dfrac{8}{3}$$','explanation','This is the integral of $\sqrt{x}$ alone over $[0,4]$, not the difference.'),
    jsonb_build_object('id','B','text','$$\dfrac{2}{3}$$','explanation','This results from using the wrong intersection $x$-value.'),
    jsonb_build_object('id','C','text','$4$','explanation','This is the integral of $\frac{x}{2}$ alone over $[0,4]$.'),
    jsonb_build_object('id','D','text','$$\dfrac{4}{3}$$','explanation','Correct: integrate $\sqrt{x}-\frac{x}{2}$ from $0$ to $4$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Solve intersections: $\sqrt{x}=\frac{x}{2}\Rightarrow 2\sqrt{x}=x\Rightarrow x=0$ or (for $x\ne0$) $2=\sqrt{x}\Rightarrow x=4$. On $[0,4]$, $\sqrt{x}\ge \frac{x}{2}$. Area:
$$\int_0^4\left(\sqrt{x}-\frac{x}{2}\right)dx=\left[\frac{2}{3}x^{3/2}-\frac{x^2}{4}\right]_0^4=\frac{16}{3}-4=\frac{4}{3}.$$',
  recommendation_reasons = ARRAY['Typical radical vs line enclosed-area problem with clean intersections.', 'Targets intersection-solving and correct integrand construction.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Intersections at $x=0$ and $x=4$; use $dx$ setup.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_AREA_BETWEEN_CURVES_DX',
  supporting_skill_ids = ARRAY['SK_FIND_INTERSECTIONS'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.4-P5';

COMMIT;
