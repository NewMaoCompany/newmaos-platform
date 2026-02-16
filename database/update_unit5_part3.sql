-- Unit 5 Part 3 Update Script (5.5 - 5.6)
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 5.5 (Using the Candidates Test to Find Absolute (Global) Extrema) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.5',
  section_id = '5.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_CRITICAL_POINTS', 'SK_FUNC_EVAL'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_CRITICAL_POINTS', 'SK_FUNC_EVAL'],
 'SK_FUNC_EVAL'], 'SK_FUNC_EVAL'],
  error_tags = ARRAY['E_MISSED_ENDPOINT', 'E_MISS_CRITICAL_POINT', 'E_ALGEBRA_ERROR'],
  prompt = 'Let $f(x)=x^3-3x^2-9x+1$ on the closed interval $[-1,4]$. Which statement about the absolute extrema of $f$ on $[-1,4]$ is correct?',
  latex = 'Let $f(x)=x^3-3x^2-9x+1$ on the closed interval $[-1,4]$. Which statement about the absolute extrema of $f$ on $[-1,4]$ is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Absolute maximum is $f(4)=-19$ and absolute minimum is $f(3)=-26$.','explanation','The absolute minimum at $x=3$ is correct, but $f(4)$ is not the absolute maximum; $f(-1)=6$ is larger.'),
    jsonb_build_object('id','B','text','Absolute maximum is $f(-1)=6$ and absolute minimum is $f(3)=-26$.','explanation','Correct. Candidates are endpoints and points where $f^{\\prime}(x)=0$. Compare $f(-1)$, $f(3)$, and $f(4)$.'),
    jsonb_build_object('id','C','text','Absolute maximum is $f(3)=-26$ and absolute minimum is $f(-1)=6$.','explanation','This reverses maximum and minimum.'),
    jsonb_build_object('id','D','text','The function has no absolute maximum on $[-1,4]$ because $f$ is not monotonic.','explanation','A continuous function on a closed interval must attain both an absolute maximum and minimum.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute $f^{\\prime}(x)=3x^2-6x-9=3(x-3)(x+1)$. Candidates on $[-1,4]$ are endpoints $x=-1,4$ and critical points $x=-1,3$. Evaluate: $f(-1)=6$, $f(3)=-26$, $f(4)=-19$. Thus absolute max is $6$ at $x=-1$ and absolute min is $-26$ at $x=3$.',
  recommendation_reasons = ARRAY['Practices the full candidates test workflow: endpoints + critical points + compare values.', 'Targets common misses on endpoints and unused critical points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Candidates Test for absolute extrema on a closed interval.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.5',
  section_id = '5.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_ABS_VALUE_PIECEWISE'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_ABS_VALUE_PIECEWISE'],

  error_tags = ARRAY['E_LOCAL_VS_GLOBAL', 'E_MISSED_ENDPOINT'],
  prompt = 'Let $f(x)=|x-2|+x$ on $[0,5]$. Which statement is true?',
  latex = 'Let $f(x)=|x-2|+x$ on $[0,5]$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The absolute minimum occurs only at $x=2$.','explanation','For $x\\le 2$, $f(x)=(2-x)+x=2$, so many $x$ values give the minimum.'),
    jsonb_build_object('id','B','text','The absolute maximum occurs at $x=2$ because $|x-2|$ is minimized there.','explanation','The maximum depends on the full expression. For $x\\ge 2$, $f(x)=2x-2$ increases, so the maximum is at $x=5$.'),
    jsonb_build_object('id','C','text','The absolute maximum occurs at $x=0$.','explanation','$f(0)=2$, but larger values occur (for example, $f(5)=8$).'),
    jsonb_build_object('id','D','text','The absolute minimum value is $2$, attained for every $x\\in[0,2]$, and the absolute maximum occurs at $x=5$.','explanation','Correct. On $[0,2]$, $f(x)=2$; on $[2,5]$, $f(x)=2x-2$ increases, so max at $x=5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Write $f(x)=\\begin{cases}2 & (0\\le x\\le 2)\\\\ 2x-2 & (2\\le x\\le 5)\\end{cases}$. Minimum value is $2$ on $[0,2]$. Since $2x-2$ increases for $x\\ge 2$, the absolute maximum is at $x=5$ with value $8$.',
  recommendation_reasons = ARRAY['Reinforces candidates testing when nondifferentiability occurs (absolute value corner).', 'Builds habit of comparing across pieces and endpoints.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Absolute value: include corner point and endpoints as candidates.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.5',
  section_id = '5.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_GRAPH_READ'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_GRAPH_READ'],

  error_tags = ARRAY['E_LOCAL_VS_GLOBAL', 'E_MISSED_ENDPOINT'],
  prompt = 'The graph of $f$ on $[0,4]$ is shown (see image: 5.5-P3.png). At approximately which $x$-value does $f$ attain its absolute maximum on $[0,4]$?',
  latex = 'The graph of $f$ on $[0,4]$ is shown. At approximately which $x$-value does $f$ attain its absolute maximum on $[0,4]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=0$','explanation','The value at $x=0$ is not the highest point on the graph.'),
    jsonb_build_object('id','B','text','$x\\approx 1.2$','explanation','There is a local feature near $x\\approx 1.2$, but the tallest peak occurs later.'),
    jsonb_build_object('id','C','text','$x\\approx 2.5$','explanation','Correct. The highest point on the graph occurs near $x\\approx 2.5$.'),
    jsonb_build_object('id','D','text','$x=4$','explanation','At $x=4$ the function is near its lowest value, not its maximum.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Absolute maximum on a closed interval occurs at the highest function value among endpoints and interior peaks/valleys. From the graph, the highest point is the interior peak near $x\\approx 2.5$.',
  recommendation_reasons = ARRAY['Builds visual candidates-test skill: absolute extrema are the highest/lowest values on the interval.', 'Targets confusion between local features and global extrema.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based absolute extrema: identify the highest point on the interval.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.5',
  section_id = '5.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_DOMAIN_CONTINUITY'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_DOMAIN_CONTINUITY'],

  error_tags = ARRAY['E_DOMAIN_IGNORED', 'E_LOCAL_VS_GLOBAL'],
  prompt = 'Let $g(x)=\\dfrac{x^2-4}{x-2}$ with domain restricted to $[0,4]$ (so $x=2$ is not in the domain). Which statement is correct?',
  latex = 'Let $g(x)=\\dfrac{x^2-4}{x-2}$ with domain restricted to $[0,4]$ (so $x=2$ is not in the domain). Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$g$ has no absolute maximum on its domain because it is not continuous on $[0,4]$.','explanation','Discontinuity removes the guarantee, but an absolute maximum can still exist.'),
    jsonb_build_object('id','B','text','$g$ has an absolute maximum value $4$ attained at $x=2$.','explanation','$x=2$ is not in the domain, so no value is attained there.'),
    jsonb_build_object('id','C','text','$g$ has an absolute minimum value $4$ attained at $x=2$.','explanation','$x=2$ is not in the domain, and $4$ is not the minimum value on the domain.'),
    jsonb_build_object('id','D','text','$g$ has an absolute maximum value $6$ attained at $x=4$ and an absolute minimum value $2$ attained at $x=0$.','explanation','Correct. For $x\\ne 2$, $g(x)=x+2$. On $[0,4]\\setminus\\{2\\}$, max is $6$ at $x=4$ and min is $2$ at $x=0$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Simplify: $g(x)=\\dfrac{(x-2)(x+2)}{x-2}=x+2$ for $x\\ne 2$. Even though $x=2$ is excluded, endpoint values exist: $g(0)=2$ and $g(4)=6$. Thus both absolute extrema exist on the given domain.',
  recommendation_reasons = ARRAY['Reinforces: domain matters in candidates testing.', 'Targets the common mistake of treating a hole as an attained value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Candidates test with restricted domain: check attainability, not just limits.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.5',
  section_id = '5.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_CANDIDATES_TEST', 'SK_TRIG_DERIV', 'SK_FUNC_EVAL'],
  primary_skill_id = 'SK_CANDIDATES_TEST',
  supporting_skill_ids = ARRAY['SK_TRIG_DERIV', 'SK_FUNC_EVAL'],
 'SK_FUNC_EVAL'], 'SK_FUNC_EVAL'],
  error_tags = ARRAY['E_MISSED_ENDPOINT', 'E_MISS_CRITICAL_POINT', 'E_ALGEBRA_ERROR'],
  prompt = 'Let $h(x)=\\sin x+\\dfrac{x}{4}$ on $[0,2\\pi]$. At which $x$ does $h$ attain its absolute maximum on $[0,2\\pi]$?',
  latex = 'Let $h(x)=\\sin x+\\dfrac{x}{4}$ on $[0,2\\pi]$. At which $x$ does $h$ attain its absolute maximum on $[0,2\\pi]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=\\pi$','explanation','This is not where $h^{\\prime}(x)=0$, and endpoint comparison beats it.'),
    jsonb_build_object('id','B','text','At the solution(s) to $\\cos x=-\\dfrac14$ in $[0,2\\pi]$ only','explanation','Those are candidates, but you must compare with endpoints; one endpoint is larger.'),
    jsonb_build_object('id','C','text','$x=0$','explanation','$h(0)=0$, which is not the maximum.'),
    jsonb_build_object('id','D','text','$x=2\\pi$','explanation','Correct. After checking critical points from $h^{\\prime}(x)=\\cos x+\\tfrac14$, the largest value occurs at the endpoint $2\\pi$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Compute $h^{\\prime}(x)=\\cos x+\\tfrac14$. Critical points satisfy $\\cos x=-\\tfrac14$ (two solutions in $[0,2\\pi]$). Compare $h$ at those points and at endpoints $0$ and $2\\pi$. The largest value occurs at $x=2\\pi$ (endpoint).',
  recommendation_reasons = ARRAY['Trains complete candidates list: endpoints + critical points for trig functions.', 'Targets the frequent mistake of stopping after $h^{\\prime}(x)=0$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Candidates test with trig derivative and endpoint comparison.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.5-P5';



-- Unit 5.6 (Determining Concavity of Functions over Their Domains) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.6',
  section_id = '5.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_CONCAVITY_FPP', 'SK_INFLECTION'],
  primary_skill_id = 'SK_CONCAVITY_FPP',
  supporting_skill_ids = ARRAY['SK_INFLECTION'],

  error_tags = ARRAY['E_SIGN_ERROR', 'E_INFLECTION_NO_SIGN_CHANGE'],
  prompt = 'A twice-differentiable function $f$ satisfies $f^{\\prime\\prime}(x)=6x-12$. Which statement is correct?',
  latex = 'A twice-differentiable function $f$ satisfies $f^{\\prime\\prime}(x)=6x-12$. Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ is concave up for $x<2$ and concave down for $x>2$, with an inflection point at $x=2$.','explanation','The sign is reversed: for $x<2$, $6x-12<0$ so concave down.'),
    jsonb_build_object('id','B','text','$f$ is concave down on $(-\\infty,2)$ and concave up on $(2,\\infty)$, with an inflection point at $x=2$.','explanation','Correct. $f^{\\prime\\prime}(x)$ changes from negative to positive at $x=2$.'),
    jsonb_build_object('id','C','text','$f$ is concave up for all $x$ because $f^{\\prime\\prime}$ is linear.','explanation','A linear second derivative can be negative on part of the real line.'),
    jsonb_build_object('id','D','text','$f$ has no inflection point because $f^{\\prime\\prime}(2)=0$.','explanation','Inflection requires a sign change in $f^{\\prime\\prime}$, not merely $f^{\\prime\\prime}(2)=0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Solve $6x-12=0\\Rightarrow x=2$. For $x<2$, $f^{\\prime\\prime}(x)<0$ so $f$ is concave down; for $x>2$, $f^{\\prime\\prime}(x)>0$ so $f$ is concave up. Because the sign changes, $x=2$ is an inflection point.',
  recommendation_reasons = ARRAY['Core concavity skill: sign of $f^{\\prime\\prime}$ determines concavity.', 'Inflection points require a sign change.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concavity from $f^{\\prime\\prime}$ and inflection via sign change.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.6',
  section_id = '5.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_CONCAVITY_FPP', 'SK_SIGN_CHART', 'SK_INFLECTION'],
  primary_skill_id = 'SK_CONCAVITY_FPP',
  supporting_skill_ids = ARRAY['SK_SIGN_CHART', 'SK_INFLECTION'],
 'SK_INFLECTION'], 'SK_INFLECTION'],
  error_tags = ARRAY['E_SIGN_ERROR', 'E_INFLECTION_NO_SIGN_CHANGE'],
  prompt = 'The sign chart for $f^{\\prime\\prime}(x)$ is shown (see image: 5.6-P2.png). On the interval $(-3,6)$, how many inflection points does $f$ have?',
  latex = 'The sign chart for $f^{\\prime\\prime}(x)$ is shown. On the interval $(-3,6)$, how many inflection points does $f$ have?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','3','explanation','Correct. $f^{\\prime\\prime}$ changes sign at each of $x=-1,2,5$ within $(-3,6)$.'),
    jsonb_build_object('id','B','text','2','explanation','This misses one of the sign changes shown on the chart.'),
    jsonb_build_object('id','C','text','1','explanation','There are multiple sign changes on the chart, not just one.'),
    jsonb_build_object('id','D','text','0','explanation','A sign change in $f^{\\prime\\prime}$ indicates an inflection point; the chart shows several.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Inflection points occur where $f^{\\prime\\prime}$ changes sign. From the chart, the sign changes at $x=-1$ (from $+$ to $-$), at $x=2$ (from $-$ to $+$), and at $x=5$ (from $+$ to $-$). All are inside $(-3,6)$, so there are 3 inflection points.',
  recommendation_reasons = ARRAY['Practices reading inflection points directly from a second-derivative sign chart.', 'Targets the common mistake of counting zeros without checking sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Inflection points are where $f^{\\prime\\prime}$ changes sign (within the given interval).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.6',
  section_id = '5.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONCAVITY_FPP', 'SK_DIFF_ALG'],
  primary_skill_id = 'SK_CONCAVITY_FPP',
  supporting_skill_ids = ARRAY['SK_DIFF_ALG'],

  error_tags = ARRAY['E_ALGEBRA_ERROR', 'E_SIGN_ERROR'],
  prompt = 'A function $f$ has first derivative $f^{\\prime}(x)=(x-1)^2(x+2)$. On which interval is $f$ concave down?',
  latex = 'A function $f$ has first derivative $f^{\\prime}(x)=(x-1)^2(x+2)$. On which interval is $f$ concave down?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','On $(-\\infty,-1)$ only','explanation','For $x<-1$, $f^{\\prime\\prime}(x)>0$, so $f$ is concave up there.'),
    jsonb_build_object('id','B','text','On $(1,\\infty)$ only','explanation','For $x>1$, $f^{\\prime\\prime}(x)>0$, so $f$ is concave up there.'),
    jsonb_build_object('id','C','text','On $(-1,1)$','explanation','Correct. Computing $f^{\\prime\\prime}(x)=3(x-1)(x+1)$ shows it is negative on $(-1,1)$.'),
    jsonb_build_object('id','D','text','On $(-\\infty,-1)\\cup(1,\\infty)$','explanation','That is where $f^{\\prime\\prime}(x)>0$, which corresponds to concave up, not concave down.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Expand $f^{\\prime}(x)=(x+2)(x-1)^2=x^3-3x+2$. Then $f^{\\prime\\prime}(x)=3x^2-3=3(x-1)(x+1)$. Thus $f^{\\prime\\prime}(x)<0$ on $(-1,1)$, so $f$ is concave down on $(-1,1)$.',
  recommendation_reasons = ARRAY['Connects $f^{\\prime}$ to $f^{\\prime\\prime}$ and concavity via accurate differentiation.', 'Targets common sign errors in concavity intervals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Compute $f^{\\prime\\prime}$ correctly; concavity from sign of $f^{\\prime\\prime}$.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.6',
  section_id = '5.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_CONCAVITY_FPP', 'SK_IMPLICIT_DIFF'],
  primary_skill_id = 'SK_CONCAVITY_FPP',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFF'],

  error_tags = ARRAY['E_SECOND_DERIV_ERROR', 'E_ALGEBRA_ERROR'],
  prompt = 'The curve is given implicitly by $x^2+y^2=25$ with $y>0$. At the point $(3,4)$, is the curve (viewed as $y$ as a function of $x$ locally) concave up or concave down?',
  latex = 'The curve is given implicitly by $x^2+y^2=25$ with $y>0$. At the point $(3,4)$, is the curve (viewed as $y$ as a function of $x$ locally) concave up or concave down?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Concave up, because $\\dfrac{dy}{dx}<0$ at $(3,4)$.','explanation','Concavity depends on $\\dfrac{d^2y}{dx^2}$, not the sign of $\\dfrac{dy}{dx}$.'),
    jsonb_build_object('id','B','text','Concave down, because $\\dfrac{d^2y}{dx^2}<0$ at $(3,4)$.','explanation','Correct. Differentiating twice yields $\\dfrac{d^2y}{dx^2}=-\\dfrac{25}{y^3}$, which is negative when $y=4$.'),
    jsonb_build_object('id','C','text','Concave up, because $\\dfrac{d^2y}{dx^2}>0$ at $(3,4)$.','explanation','The computed second derivative is negative at this point.'),
    jsonb_build_object('id','D','text','Neither concave up nor concave down, because the curve is not a function.','explanation','With $y>0$, the top semicircle is locally a function of $x$, so concavity is defined.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate: $2x+2y\\,y^{\\prime}=0\\Rightarrow y^{\\prime}=-\\dfrac{x}{y}$. Differentiate again:\n$$y^{\\prime\\prime}=\\frac{d}{dx}\\left(-\\frac{x}{y}\\right)=-\\frac{y-xy^{\\prime}}{y^2}=-\\frac{y-x\\left(-\\frac{x}{y}\\right)}{y^2}=-\\frac{y+\\frac{x^2}{y}}{y^2}=-\\frac{y^2+x^2}{y^3}=-\\frac{25}{y^3}.$$\nAt $(3,4)$, $y^{\\prime\\prime}=-\\dfrac{25}{64}<0$, so the curve is concave down there.',
  recommendation_reasons = ARRAY['High-frequency AP task: compute $y^{\\prime\\prime}$ from an implicit relation and decide concavity by sign.', 'Targets confusion between slope and concavity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Implicit concavity: compute and evaluate $y^{\\prime\\prime}$ carefully.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.6',
  section_id = '5.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_CONCAVITY_FROM_FP', 'SK_GRAPH_READ'],
  primary_skill_id = 'SK_CONCAVITY_FROM_FP',
  supporting_skill_ids = ARRAY['SK_GRAPH_READ'],

  error_tags = ARRAY['E_SLOPE_NOT_CONCAVITY', 'E_SIGN_ERROR'],
  prompt = 'The graph of $f^{\\prime}(x)$ is shown for $-2\\le x\\le 6$ (see image: 5.6-P5.png). On which interval is $f$ concave up?',
  latex = 'The graph of $f^{\\prime}(x)$ is shown for $-2\\le x\\le 6$. On which interval is $f$ concave up?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-2,\\tfrac{5}{2})$','explanation','On this interval, $f^{\\prime}(x)$ is decreasing, so $f^{\\prime\\prime}(x)<0$ and $f$ is concave down.'),
    jsonb_build_object('id','B','text','$(-2,1)\\cup(4,6)$','explanation','Concavity depends on whether $f^{\\prime}$ is increasing, not on where $f^{\\prime}$ is positive or negative.'),
    jsonb_build_object('id','C','text','$(1,4)$','explanation','Here $f^{\\prime}(x)$ is not increasing for the whole interval; it is still decreasing until the vertex.'),
    jsonb_build_object('id','D','text','$(\\tfrac{5}{2},6)$','explanation','Correct. $f$ is concave up where $f^{\\prime}(x)$ is increasing; the graph increases to the right of $x=\\tfrac{5}{2}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'A function is concave up where $f^{\\prime\\prime}>0$, equivalently where $f^{\\prime}$ is increasing. From the graph, $f^{\\prime}(x)$ has its minimum at $x=\\tfrac{5}{2}$ and increases for $x>\\tfrac{5}{2}$. Thus $f$ is concave up on $(\\tfrac{5}{2},6)$.',
  recommendation_reasons = ARRAY['Connects concavity to the behavior of $f^{\\prime}$ (increasing vs decreasing).', 'Targets the common mistake of using the sign of $f^{\\prime}$ instead of its monotonicity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concavity from $f^{\\prime}$: concave up where $f^{\\prime}$ increases.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.6-P5';

END $block$;
