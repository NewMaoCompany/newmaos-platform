-- Unit 5 Unit Test Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- ===============================
-- Unit 5: Analytical Applications
-- Unit Test (20 MCQ)
-- ===============================

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_MVT','SK_AVG_ROC'],
  primary_skill_id = 'SK_MVT',
  supporting_skill_ids = ARRAY['SK_AVG_ROC'],

  error_tags = ARRAY['E_MVT_HYPOTHESES','E_AVG_VS_INST'],
  prompt = 'IMAGE: unit_test-P1.png

The secant line between $x=0.8$ and $x=3.8$ has slope $2$. Assume $f$ is continuous on $[0.8,3.8]$ and differentiable on $(0.8,3.8)$. Which statement must be true?',
  latex = 'IMAGE: unit_test-P1.png

The secant line between $x=0.8$ and $x=3.8$ has slope $2$. Assume $f$ is continuous on $[0.8,3.8]$ and differentiable on $(0.8,3.8)$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c$ with $f''(c)=2$','explanation','Mean Value Theorem guarantees equality with the average rate of change.'),
    jsonb_build_object('id','B','text','There exists $c$ with $f''(c)>2$','explanation','Not guaranteed by MVT.'),
    jsonb_build_object('id','C','text','There exists $c$ with $f''(c)<2$','explanation','Not required by MVT.'),
    jsonb_build_object('id','D','text','Both B and C must occur','explanation','Neither inequality is forced.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'By the Mean Value Theorem, there exists $c$ such that
$$f''(c)=\frac{f(3.8)-f(0.8)}{3.8-0.8}=2.$$',
  recommendation_reasons = ARRAY['Applies Mean Value Theorem directly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'MVT guarantees equality, not inequality.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_EVT'],
  primary_skill_id = 'SK_EVT',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_EVT_MISUSE'],
  prompt = 'Let $f(x)=\sqrt{4-x^2}$ on $[-2,2]$. Which statement is true?',
  latex = 'Let $f(x)=\sqrt{4-x^2}$ on $[-2,2]$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has both an absolute maximum and minimum','explanation','EVT applies on closed intervals.'),
    jsonb_build_object('id','B','text','$f$ has no absolute minimum','explanation','False: minimum is $0$.'),
    jsonb_build_object('id','C','text','$f$ has no absolute maximum','explanation','False: maximum is $2$.'),
    jsonb_build_object('id','D','text','EVT does not apply','explanation','Differentiability is not required.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Since $f$ is continuous on a closed interval, EVT guarantees absolute extrema.',
  recommendation_reasons = ARRAY['Tests EVT conditions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'EVT depends on continuity.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ABS_EXTREMA_CANDIDATES'],
  primary_skill_id = 'SK_ABS_EXTREMA_CANDIDATES',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_ENDPOINTS_IGNORED'],
  prompt = 'A function is continuous on $[1,5]$. Where can absolute extrema occur?',
  latex = 'A function is continuous on $[1,5]$. Where can absolute extrema occur?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Only where $f''(x)=0$','explanation','Endpoints must be included.'),
    jsonb_build_object('id','B','text','Only at endpoints','explanation','Interior critical points must be checked.'),
    jsonb_build_object('id','C','text','At endpoints and critical points','explanation','Correct candidates test.'),
    jsonb_build_object('id','D','text','Only where $f''$ is undefined','explanation','Incomplete.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Absolute extrema occur at endpoints and interior critical points.',
  recommendation_reasons = ARRAY['Reinforces candidates test.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Include endpoints.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q3';
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_SIGN_CHART','SK_INCREASING_DECREASING'],
  primary_skill_id = 'SK_SIGN_CHART',
  supporting_skill_ids = ARRAY['SK_INCREASING_DECREASING'],

  error_tags = ARRAY['E_SIGN_CHART','E_GRAPH_MISMATCH'],
  prompt = 'Let $f''(x)=\dfrac{(x-2)(x+1)}{(x-1)^2}$. On which set of intervals is $f$ increasing?',
  latex = 'Let $f''(x)=\dfrac{(x-2)(x+1)}{(x-1)^2}$. On which set of intervals is $f$ increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-1,1)\cup(1,2)$','explanation','On $(-1,2)$ the numerator $(x-2)(x+1)$ is negative, so $f''(x)<0$ for $x\\ne 1$.'),
    jsonb_build_object('id','B','text','$(-\\infty,-1)\\cup(-1,1)$','explanation','$(-1,1)$ gives $(x-2)(x+1)<0$, so $f$ is decreasing there (excluding $x=1$).'),
    jsonb_build_object('id','C','text','$(-\\infty,-1)\\cup(2,\\infty)$','explanation','Since $(x-1)^2>0$ for $x\\ne1$, the sign of $f''$ is the sign of $(x-2)(x+1)$, which is positive on $(-\\infty,-1)$ and $(2,\\infty)$.'),
    jsonb_build_object('id','D','text','$(1,2)$ only','explanation','On $(1,2)$, $(x-2)(x+1)<0$, so $f$ is decreasing, not increasing.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $(x-1)^2>0$ for $x\\ne 1$, the sign of $f''(x)$ matches the sign of $(x-2)(x+1)$. That product is positive on $(-\\infty,-1)$ and $(2,\\infty)$, so $f$ is increasing on
$$(-\\infty,-1)\\cup(2,\\infty).$$',
  recommendation_reasons = ARRAY['Builds a correct sign chart for a rational derivative.', 'Avoids the common mistake of treating a squared denominator as changing sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Monotonicity from the sign of $f''(x)$; note $(x-1)^2$ is always positive for $x\\ne1$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST'],
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_SIGN_CHART','E_LOCAL_VS_GLOBAL'],
  prompt = 'Suppose $f$ is differentiable and $f''(x)$ changes sign from positive to negative at $x=5$. What can be concluded?',
  latex = 'Suppose $f$ is differentiable and $f''(x)$ changes sign from positive to negative at $x=5$. What can be concluded?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum at $x=5$.','explanation','If $f''$ changes from $+$ to $-$, then $f$ increases then decreases, so there is a local maximum.'),
    jsonb_build_object('id','B','text','$f$ has a local minimum at $x=5$.','explanation','A local minimum requires a sign change from $-$ to $+$.'),
    jsonb_build_object('id','C','text','$f$ has an inflection point at $x=5$.','explanation','Inflection points require concavity change, not a sign change of $f''$.'),
    jsonb_build_object('id','D','text','No conclusion can be drawn without knowing $f''''(5)$.','explanation','The first derivative test is sufficient when the sign change is known.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'When $f''(x)$ changes from positive to negative at $x=5$, $f$ changes from increasing to decreasing at $x=5$. Therefore, $f$ has a local maximum at $x=5$.',
  recommendation_reasons = ARRAY['Fast recognition of the first derivative test pattern.', 'Targets confusion between local extrema and inflection points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Local max occurs when $f''$ changes from $+$ to $-$.',
  weight_primary = 0.95,
  weight_supporting = 0.05,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ABS_EXTREMA_CANDIDATES','SK_ALGEBRA'],
  primary_skill_id = 'SK_ABS_EXTREMA_CANDIDATES',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],

  error_tags = ARRAY['E_ENDPOINTS_IGNORED','E_ARITHMETIC'],
  prompt = 'Let $f(x)=x\\sqrt{9-x^2}$ on $[0,3]$. What is the maximum value of $f$ on $[0,3]$?',
  latex = 'Let $f(x)=x\\sqrt{9-x^2}$ on $[0,3]$. What is the maximum value of $f$ on $[0,3]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3\\sqrt{3}$','explanation','This results from evaluating at the wrong $x$ or simplifying incorrectly.'),
    jsonb_build_object('id','B','text','$6$','explanation','This is not the value at the maximizing input.'),
    jsonb_build_object('id','C','text','$\\dfrac{9}{2}$','explanation','Correct: check endpoints and the interior critical point to get $\\dfrac{9}{2}$.'),
    jsonb_build_object('id','D','text','$9$','explanation','This is not attainable by $x\\sqrt{9-x^2}$ on $[0,3]$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$f''(x)=\\sqrt{9-x^2}-\\frac{x^2}{\\sqrt{9-x^2}}=\\frac{9-2x^2}{\\sqrt{9-x^2}}.$$
Set $9-2x^2=0\\Rightarrow x=\\frac{3}{\\sqrt{2}}$ (in $[0,3]$). Candidates:
$$f(0)=0,\\quad f(3)=0,$$
$$f\\!\\left(\\frac{3}{\\sqrt{2}}\\right)=\\frac{3}{\\sqrt{2}}\\cdot\\sqrt{9-\\frac{9}{2}}=\\frac{3}{\\sqrt{2}}\\cdot\\frac{3}{\\sqrt{2}}=\\frac{9}{2}.$$
So the maximum value is $\\dfrac{9}{2}$.',
  recommendation_reasons = ARRAY['Uses candidates test on a closed interval.', 'Targets the common mistake of skipping endpoints or mishandling radicals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Maximize on a closed interval: check endpoints and interior critical points.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q6';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_INCREASING_DECREASING','SK_INTERPRET_GRAPH'],
  primary_skill_id = 'SK_INCREASING_DECREASING',
  supporting_skill_ids = ARRAY['SK_INTERPRET_GRAPH'],

  error_tags = ARRAY['E_GRAPH_MISMATCH','E_SIGN_CHART'],
  prompt = 'IMAGE: unit_test-P7.png

The graph shown is $f''(x)$. On which interval is $f$ decreasing?',
  latex = 'IMAGE: unit_test-P7.png

The graph shown is $f''(x)$. On which interval is $f$ decreasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\\infty,-1)$','explanation','There the graph is above the $x$-axis, so $f''(x)>0$ and $f$ is increasing.'),
    jsonb_build_object('id','B','text','$(-1,2)$','explanation','Between $-1$ and $2$, the graph is below the $x$-axis, so $f''(x)<0$ and $f$ is decreasing.'),
    jsonb_build_object('id','C','text','$(2,\\infty)$','explanation','There the graph is above the $x$-axis, so $f$ is increasing.'),
    jsonb_build_object('id','D','text','None; $f$ is increasing for all $x$.','explanation','False: the derivative graph is negative on $(-1,2)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$f$ is decreasing where $f''(x)<0$. From the graph, $f''(x)$ is negative on $(-1,2)$, so $f$ is decreasing on $(-1,2)$.',
  recommendation_reasons = ARRAY['Reads monotonicity from the sign of a derivative graph.', 'Targets reversing above/below-axis interpretation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Decreasing where the derivative graph lies below the $x$-axis.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q7';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONCAVITY','SK_ALGEBRA'],
  primary_skill_id = 'SK_CONCAVITY',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],

  error_tags = ARRAY['E_CONCAVITY_SIGN','E_SIGN_CHART'],
  prompt = 'Let $f(x)=x^3-6x^2+9x+1$. On which interval is $f$ concave up?',
  latex = 'Let $f(x)=x^3-6x^2+9x+1$. On which interval is $f$ concave up?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\\infty,2)$','explanation','For $x<2$, $f''''(x)=6(x-2)<0$, so $f$ is concave down.'),
    jsonb_build_object('id','B','text','$(2,\\infty)$','explanation','Since $f''''(x)=6(x-2)>0$ for $x>2$, $f$ is concave up on $(2,\\infty)$.'),
    jsonb_build_object('id','C','text','$(-\\infty,0)$','explanation','Concavity changes where $f''''(x)=0$, which occurs at $x=2$, not $0$.'),
    jsonb_build_object('id','D','text','$(0,2)$','explanation','On $(0,2)$, $f''''(x)<0$, so $f$ is concave down.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute
$$f''''(x)=6x-12=6(x-2).$$
$f$ is concave up where $f''''(x)>0$, i.e. where $x>2$.',
  recommendation_reasons = ARRAY['Practices concavity from the second derivative.', 'Targets the sign mistake when solving $f''''(x)>0$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concave up where $f''''(x)>0$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q8';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST'],
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_CONCAVITY_SIGN','E_LOCAL_VS_GLOBAL'],
  prompt = 'Suppose $f''(2)=0$ and $f''''(2)<0$. Which conclusion is justified?',
  latex = 'Suppose $f''(2)=0$ and $f''''(2)<0$. Which conclusion is justified?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local minimum at $x=2$.','explanation','A local minimum via the second derivative test requires $f''''(2)>0$.'),
    jsonb_build_object('id','B','text','$f$ has an inflection point at $x=2$.','explanation','An inflection point requires concavity to change sign, not just $f''''(2)<0$.'),
    jsonb_build_object('id','C','text','No conclusion can be drawn.','explanation','Here a conclusion can be drawn because $f''''(2)\\ne 0$.'),
    jsonb_build_object('id','D','text','$f$ has a local maximum at $x=2$.','explanation','At a critical point, $f''''(2)<0$ means concave down, so it is a local maximum.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Second derivative test: if $f''(c)=0$ and $f''''(c)<0$, then $f$ has a local maximum at $c$. With $c=2$, $f$ has a local maximum at $x=2$.',
  recommendation_reasons = ARRAY['Directly applies the second derivative test.', 'Targets confusion between concavity and inflection points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Second derivative test at a critical point ($f''''(c)\\ne 0$).',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q9';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_CONCAVITY','SK_INTERPRET_GRAPH'],
  primary_skill_id = 'SK_CONCAVITY',
  supporting_skill_ids = ARRAY['SK_INTERPRET_GRAPH'],

  error_tags = ARRAY['E_CONCAVITY_SIGN','E_GRAPH_MISMATCH'],
  prompt = 'IMAGE: unit_test-P10.png

The graph shown is $f''''(x)$. On which interval is $f$ concave down?',
  latex = 'IMAGE: unit_test-P10.png

The graph shown is $f''''(x)$. On which interval is $f$ concave down?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(1,3)$','explanation','On $(1,3)$, the graph is below the $x$-axis, so $f''''(x)<0$ and $f$ is concave down.'),
    jsonb_build_object('id','B','text','$(-\\infty,1)$','explanation','There $f''''(x)>0$, so $f$ is concave up.'),
    jsonb_build_object('id','C','text','$(3,\\infty)$','explanation','There $f''''(x)>0$, so $f$ is concave up.'),
    jsonb_build_object('id','D','text','All real $x$','explanation','$f''''(x)$ changes sign, so concavity cannot be down for all $x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$f$ is concave down where $f''''(x)<0$. From the graph, $f''''(x)$ is negative on $(1,3)$, so $f$ is concave down on $(1,3)$.',
  recommendation_reasons = ARRAY['Reads concavity directly from a second-derivative graph.', 'Targets the common sign-interpretation error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concave down where the $f''''$ graph lies below the $x$-axis.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q10';
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ABS_EXTREMA_CANDIDATES','SK_ALGEBRA'],
  primary_skill_id = 'SK_ABS_EXTREMA_CANDIDATES',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],

  error_tags = ARRAY['E_ENDPOINTS_IGNORED','E_ARITHMETIC'],
  prompt = 'A differentiable function satisfies $f''(x)=3(x-1)(x-4)$ for all $x$, and $f(0)=2$. What is the absolute minimum value of $f$ on $[0,5]$?',
  latex = 'A differentiable function satisfies $f''(x)=3(x-1)(x-4)$ for all $x$, and $f(0)=2$. What is the absolute minimum value of $f$ on $[0,5]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','2','explanation','This is $f(0)$, but you must also check interior critical points and the other endpoint.'),
    jsonb_build_object('id','B','text','$-\\dfrac{1}{2}$','explanation','This equals $f(5)$, but it is not the smallest candidate value.'),
    jsonb_build_object('id','C','text','$\\dfrac{15}{2}$','explanation','This equals $f(1)$, but it is not a minimum.'),
    jsonb_build_object('id','D','text','$-6$','explanation','Correct: reconstruct $f$ and evaluate at candidates $x=0,1,4,5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Integrate:
$$f''(x)=3(x-1)(x-4)=3x^2-15x+12,$$
so
$$f(x)=\\int(3x^2-15x+12)\\,dx=x^3-\\frac{15}{2}x^2+12x+C.$$
Given $f(0)=2$, $C=2$. Candidates for absolute extrema on $[0,5]$ are $x=0,1,4,5$.
$$f(0)=2,$$
$$f(1)=1-\\frac{15}{2}+12+2=\\frac{15}{2},$$
$$f(4)=64-120+48+2=-6,$$
$$f(5)=125-\\frac{375}{2}+60+2=-\\frac{1}{2}.$$
Thus the absolute minimum value is $-6$.',
  recommendation_reasons = ARRAY['Uses candidates test on a closed interval.', 'Targets arithmetic slips when evaluating multiple candidates.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Evaluate endpoints and interior critical points for absolute extrema.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q11';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_GRAPH_SKETCH','SK_INCREASING_DECREASING','SK_CONCAVITY'],
  primary_skill_id = 'SK_GRAPH_SKETCH',
  supporting_skill_ids = ARRAY['SK_INCREASING_DECREASING', 'SK_CONCAVITY'],
 'SK_CONCAVITY'], 'SK_CONCAVITY'],
  error_tags = ARRAY['E_SIGN_CHART','E_CONCAVITY_SIGN'],
  prompt = 'A twice-differentiable function $f$ satisfies:
(i) $f''(x)>0$ for $x<0$,
(ii) $f''(x)<0$ for $0<x<2$,
(iii) $f''(x)>0$ for $x>2$.
Which statement must be true?',
  latex = 'A twice-differentiable function $f$ satisfies:
(i) $f''(x)>0$ for $x<0$,
(ii) $f''(x)<0$ for $0<x<2$,
(iii) $f''(x)>0$ for $x>2$.
Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ is increasing on $(0,2)$.','explanation','$f''(x)<0$ on $(0,2)$ means $f$ is decreasing there.'),
    jsonb_build_object('id','B','text','$f$ is decreasing on $(2,\\infty)$.','explanation','$f''(x)>0$ on $(2,\\infty)$ means $f$ is increasing there.'),
    jsonb_build_object('id','C','text','$f$ has a local minimum at $x=0$.','explanation','A local minimum would require $f''$ to change from $-$ to $+$ at $0$, but it changes from $+$ to $-$ here.'),
    jsonb_build_object('id','D','text','$f$ has a local maximum at $x=0$ and a local minimum at $x=2$.','explanation','Sign of $f''$ gives increasing to decreasing at $0$ (local max) and decreasing to increasing at $2$ (local min).')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $f''(x)>0$ for $x<0$ and $f''(x)<0$ for $0<x<2$, $f$ changes from increasing to decreasing at $x=0$, so $f$ has a local maximum at $x=0$. Also, $f''(x)<0$ for $0<x<2$ and $f''(x)>0$ for $x>2$, $f$ changes from decreasing to increasing at $x=2$, giving a local minimum at $x=2$.',
  recommendation_reasons = ARRAY['Synthesizes sign information into local-extrema conclusions.', 'Targets confusion between $f''$ sign and concavity vs monotonicity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Local max: $f''$ changes $+\\to-$; local min: $-\\to+$.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q12';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_GRAPH_MATCH','SK_CRITICAL_POINTS'],
  primary_skill_id = 'SK_GRAPH_MATCH',
  supporting_skill_ids = ARRAY['SK_CRITICAL_POINTS'],

  error_tags = ARRAY['E_GRAPH_MISMATCH','E_SIGN_CHART'],
  prompt = 'A differentiable function $f$ has exactly two critical points, at $x=-1$ and $x=2$. Also, $f''$ changes sign from positive to negative at $x=-1$ and from negative to positive at $x=2$. Which statement must be true?',
  latex = 'A differentiable function $f$ has exactly two critical points, at $x=-1$ and $x=2$. Also, $f''$ changes sign from positive to negative at $x=-1$ and from negative to positive at $x=2$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local minimum at both $x=-1$ and $x=2$.','explanation','At $x=-1$, $f''$ changes $+\\to-$, indicating a local maximum.'),
    jsonb_build_object('id','B','text','$f$ has a local maximum at $x=-1$ and a local minimum at $x=2$.','explanation','Correct by the first derivative test using the sign changes provided.'),
    jsonb_build_object('id','C','text','$f$ is increasing for all $x>2$.','explanation','The sign change at $x=2$ only gives local behavior near $2$, not global behavior for all $x>2$.'),
    jsonb_build_object('id','D','text','$f$ has an inflection point at $x=-1$.','explanation','Inflection points are about concavity change, not an increasing/decreasing sign change.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'If $f''$ changes from positive to negative at $x=-1$, then $f$ changes from increasing to decreasing at $x=-1$, so $f$ has a local maximum there. If $f''$ changes from negative to positive at $x=2$, then $f$ changes from decreasing to increasing at $x=2$, so $f$ has a local minimum there.',
  recommendation_reasons = ARRAY['Interprets derivative sign changes into local extrema.', 'Targets mixing up extrema vs inflection logic.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use sign changes to classify local extrema.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q13';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_OPT_MODEL','SK_ALGEBRA'],
  primary_skill_id = 'SK_OPT_MODEL',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],

  error_tags = ARRAY['E_OPT_CONSTRAINT','E_ARITHMETIC'],
  prompt = 'A rectangle has perimeter $40$. If its length is $x$, what is its area $A(x)$ as a function of $x$?',
  latex = 'A rectangle has perimeter $40$. If its length is $x$, what is its area $A(x)$ as a function of $x$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$A(x)=x(20-x)$','explanation','From $2x+2w=40$, $w=20-x$, so $A=xw=x(20-x)$.'),
    jsonb_build_object('id','B','text','$A(x)=x(40-x)$','explanation','This forgets the factor of $2$ in the perimeter equation.'),
    jsonb_build_object('id','C','text','$A(x)=\\dfrac{40}{x}$','explanation','This confuses perimeter with area.'),
    jsonb_build_object('id','D','text','$A(x)=20x$','explanation','Width is not constant; it depends on $x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Perimeter $2x+2w=40$ gives $w=20-x$. Therefore,
$$A(x)=x(20-x).$$',
  recommendation_reasons = ARRAY['Translates a constraint into an objective function.', 'Targets missing the factor of 2 in perimeter.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Optimization setup from perimeter constraint.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q14';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_OPT_SOLVE','SK_OPT_MODEL','SK_ALGEBRA'],
  primary_skill_id = 'SK_OPT_SOLVE',
  supporting_skill_ids = ARRAY['SK_OPT_MODEL', 'SK_ALGEBRA'],
 'SK_ALGEBRA'], 'SK_ALGEBRA'],
  error_tags = ARRAY['E_OPT_CONSTRAINT','E_ARITHMETIC'],
  prompt = 'Find the maximum area of a rectangle inscribed under $y=9-x^2$ above the $x$-axis, with sides parallel to the axes.',
  latex = 'Find the maximum area of a rectangle inscribed under $y=9-x^2$ above the $x$-axis, with sides parallel to the axes.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$9$','explanation','This ignores that both width and height depend on $x$.'),
    jsonb_build_object('id','B','text','$12$','explanation','Not the maximum value from optimizing $A(x)$.'),
    jsonb_build_object('id','C','text','$12\\sqrt{3}$','explanation','Correct: maximize $A(x)=2x(9-x^2)$ at $x=\\sqrt{3}$.'),
    jsonb_build_object('id','D','text','$18$','explanation','This commonly comes from forgetting the factor $2$ in the width.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Using symmetry, corners are $(\\pm x,9-x^2)$ for $0\\le x\\le 3$. Then width $=2x$ and height $=9-x^2$:
$$A(x)=2x(9-x^2)=18x-2x^3.$$
Differentiate:
$$A''(x)=18-6x^2=0\\Rightarrow x=\\sqrt{3}.$$
Then
$$A(\\sqrt{3})=2\\sqrt{3}(9-3)=12\\sqrt{3}.$$',
  recommendation_reasons = ARRAY['Classic AP optimization with symmetry.', 'Targets missing the factor of 2 in width.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Maximize an area function derived from geometry.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q15';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_IMPLICIT_DIFF','SK_BEHAVIOR_IMPLICIT'],
  primary_skill_id = 'SK_IMPLICIT_DIFF',
  supporting_skill_ids = ARRAY['SK_BEHAVIOR_IMPLICIT'],

  error_tags = ARRAY['E_IMPLICIT_UNDEFINED','E_SIGN_CHART'],
  prompt = 'Consider the relation $x^2+y^2=4$. At which point(s) on the curve is $\\dfrac{dy}{dx}$ undefined?',
  latex = 'Consider the relation $x^2+y^2=4$. At which point(s) on the curve is $\\dfrac{dy}{dx}$ undefined?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(0,2)$ and $(0,-2)$','explanation','At these points $y\\ne0$, so $y''=-x/y$ is defined.'),
    jsonb_build_object('id','B','text','$(2,0)$ only','explanation','$(-2,0)$ also has $y=0$.'),
    jsonb_build_object('id','C','text','$(2,0)$ and $(-2,0)$','explanation','Correct: $y''=-x/y$ is undefined where $y=0$, which happens at $(\\pm2,0)$.'),
    jsonb_build_object('id','D','text','Nowhere','explanation','Vertical tangents occur at $(\\pm2,0)$, so the slope is undefined there.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate implicitly:
$$2x+2y\\,y''=0\\Rightarrow y''=-\\frac{x}{y}.$$
The slope is undefined when $y=0$. On $x^2+y^2=4$, $y=0$ occurs at $(2,0)$ and $(-2,0)$.',
  recommendation_reasons = ARRAY['Connects implicit differentiation to vertical tangents.', 'Targets dividing by $y$ without checking where $y=0$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Undefined derivative corresponds to vertical tangent for implicit curves.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q16';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_GRAPH_CONNECT','SK_CONCAVITY'],
  primary_skill_id = 'SK_GRAPH_CONNECT',
  supporting_skill_ids = ARRAY['SK_CONCAVITY'],

  error_tags = ARRAY['E_CONCAVITY_SIGN','E_GRAPH_MISMATCH'],
  prompt = 'Suppose $f$ is twice differentiable on $(a,b)$. If $f''(x)$ is increasing on $(a,b)$, what must be true about $f$ on $(a,b)$?',
  latex = 'Suppose $f$ is twice differentiable on $(a,b)$. If $f''(x)$ is increasing on $(a,b)$, what must be true about $f$ on $(a,b)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ is increasing on $(a,b)$.','explanation','Not necessarily; $f''$ can be increasing while still negative.'),
    jsonb_build_object('id','B','text','$f$ is concave up on $(a,b)$.','explanation','If $f''$ is increasing, then $f$ is concave up on $(a,b)$.'),
    jsonb_build_object('id','C','text','$f$ is concave down on $(a,b)$.','explanation','Opposite of what increasing $f''$ implies.'),
    jsonb_build_object('id','D','text','$f$ must be linear on $(a,b)$.','explanation','Linear would require $f''$ to be constant (typically $0$), not increasing.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A function is concave up on an interval when its derivative is increasing. Since $f''(x)$ is increasing on $(a,b)$, $f$ is concave up on $(a,b)$.',
  recommendation_reasons = ARRAY['Connects “increasing derivative” to concavity.', 'Targets confusing “increasing derivative” with “increasing function.”'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concavity is controlled by whether the first derivative is increasing.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q17';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_IMPLICIT_DIFF','SK_ALGEBRA'],
  primary_skill_id = 'SK_IMPLICIT_DIFF',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],

  error_tags = ARRAY['E_ARITHMETIC','E_IMPLICIT_UNDEFINED'],
  prompt = 'Let $y$ be defined implicitly by $x^2+xy+y^2=3$. At the point $(1,1)$, what is the value of $\\dfrac{dy}{dx}$?',
  latex = 'Let $y$ be defined implicitly by $x^2+xy+y^2=3$. At the point $(1,1)$, what is the value of $\\dfrac{dy}{dx}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','0','explanation','This usually comes from differentiating $xy$ incorrectly.'),
    jsonb_build_object('id','B','text','1','explanation','Sign error: the correct slope is negative.'),
    jsonb_build_object('id','C','text','Undefined','explanation','At $(1,1)$, the denominator $x+2y=3\\ne0$, so it is defined.'),
    jsonb_build_object('id','D','text','-1','explanation','Correct: implicit differentiation gives $y''=-(2x+y)/(x+2y)$, so at $(1,1)$ it equals $-1$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$2x+(x\\,y''+y)+2y\\,y''=0\\Rightarrow y''(x+2y)=-(2x+y).$$
Thus
$$y''=-\\frac{2x+y}{x+2y}.$$
At $(1,1)$:
$$y''=-\\frac{2(1)+1}{1+2(1)}=-\\frac{3}{3}=-1.$$',
  recommendation_reasons = ARRAY['AP-style implicit differentiation at a point.', 'Targets product-rule mistakes on $xy$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Be careful: $\\dfrac{d}{dx}(xy)=x\\,y''+y$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q18';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST','SK_SIGN_CHART'],
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_SIGN_CHART'],

  error_tags = ARRAY['E_SIGN_CHART','E_LOCAL_VS_GLOBAL'],
  prompt = 'The derivative of a function is $f''(x)=\\dfrac{x}{x^2+1}$. Which statement is true?',
  latex = 'The derivative of a function is $f''(x)=\\dfrac{x}{x^2+1}$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum at $x=0$.','explanation','Since $f''$ changes from negative to positive, $x=0$ is a local minimum, not a maximum.'),
    jsonb_build_object('id','B','text','$f$ has no local extrema.','explanation','There is a sign change at $x=0$, so a local extremum exists.'),
    jsonb_build_object('id','C','text','$f$ has a local minimum at $x=0$.','explanation','Because $x^2+1>0$, the sign of $f''$ matches $x$, giving decreasing then increasing.'),
    jsonb_build_object('id','D','text','$f$ has local maxima at $x=\\pm1$.','explanation','$f''(\\pm1)\\ne0$, so these are not critical points.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Since $x^2+1>0$ for all $x$, the sign of $f''(x)$ is the sign of $x$. Thus $f''(x)<0$ for $x<0$ and $f''(x)>0$ for $x>0$, so $f$ decreases then increases, giving a local minimum at $x=0$.',
  recommendation_reasons = ARRAY['Uses sign analysis with a denominator that never changes sign.', 'Targets stopping at “$f''(0)=0$” without checking sign change.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Check sign change to classify the critical point.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q19';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_OPT_SOLVE','SK_ALGEBRA'],
  primary_skill_id = 'SK_OPT_SOLVE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],

  error_tags = ARRAY['E_OPT_CONSTRAINT','E_ARITHMETIC'],
  prompt = 'A company estimates profit (in thousands of dollars) from producing $x$ units is $P(x)=-0.5x^2+8x-10$ for $0\\le x\\le 20$. How many units should be produced to maximize profit?',
  latex = 'A company estimates profit (in thousands of dollars) from producing $x$ units is $P(x)=-0.5x^2+8x-10$ for $0\\le x\\le 20$. How many units should be produced to maximize profit?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','4','explanation','Not the vertex of the parabola.'),
    jsonb_build_object('id','B','text','10','explanation','Not the vertex.'),
    jsonb_build_object('id','C','text','20','explanation','Endpoint, but a concave-down parabola is maximized at its vertex inside the interval.'),
    jsonb_build_object('id','D','text','8','explanation','Correct: maximum occurs at the vertex $x=-\\dfrac{b}{2a}=8$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $P(x)$ is a downward-opening parabola, its maximum occurs at the vertex:
$$x=-\\frac{b}{2a}=-\\frac{8}{2(-0.5)}=8.$$
So the company should produce $8$ units.',
  recommendation_reasons = ARRAY['Optimization via quadratic vertex method.', 'Targets checking only endpoints without analyzing the parabola.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Maximize a quadratic by locating its vertex.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q20';

END $block$;
