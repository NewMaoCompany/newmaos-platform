-- Unit 5 Part 2 Update Script (5.3 - 5.4)
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 5.3 (Determining Intervals on Which a Function Is Increasing or Decreasing) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.3',
  section_id = '5.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INCR_DECR_SIGN','SK_SIGN_CHART','SK_INTERVAL_NOTATION'],
  primary_skill_id = 'SK_INCR_DECR_SIGN',
  supporting_skill_ids = ARRAY['SK_SIGN_CHART', 'SK_INTERVAL_NOTATION'],
 'SK_INTERVAL_NOTATION'],'SK_INTERVAL_NOTATION'],
  error_tags = ARRAY['E_SIGN_CHART_ERROR','E_EVEN_MULTIPLICITY','E_MISS_UNDEFINED_CRIT','E_INTERVAL_NOTATION'],
  prompt = 'Let $f$ be differentiable except possibly where $f''(x)$ is undefined. Suppose $$f''(x)=\dfrac{(x-2)(x+1)^2}{x-3}.$$ On which intervals is $f$ increasing?',
  latex  = 'Let $f$ be differentiable except possibly where $f''(x)$ is undefined. Suppose $$f''(x)=\dfrac{(x-2)(x+1)^2}{x-3}.$$ On which intervals is $f$ increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\infty,-1)\cup(-1,2)\cup(3,\infty)$','explanation','Correct. Because $(x+1)^2$ does not change sign, the sign of $f''(x)$ is determined by $(x-2)/(x-3)$; positive for $x<2$ and $x>3$, splitting at $x=-1$ where $f''(x)=0$.'),
    jsonb_build_object('id','B','text','$(-\infty,-1)\cup(2,3)$','explanation','Incorrect. On $(2,3)$, $(x-2)>0$ and $(x-3)<0$, so $f''(x)<0$ (decreasing).'),
    jsonb_build_object('id','C','text','$(-1,2)\cup(2,3)$','explanation','Incorrect. $(2,3)$ is decreasing since $f''(x)<0$ there, and it also misses $(-\infty,-1)$.'),
    jsonb_build_object('id','D','text','$(2,3)$ only','explanation','Incorrect. This is exactly where $f''(x)<0$, so $f$ is decreasing there.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Critical values come from $f''(x)=0$ or undefined: $x=-1,2$ (zeros) and $x=3$ (undefined). Since $(x+1)^2\ge 0$ and has even multiplicity at $x=-1$, it does not flip the sign. Thus the sign is the sign of $(x-2)/(x-3)$: positive for $x<2$ and $x>3$, negative for $2<x<3$. Therefore $f$ is increasing on $(-\infty,-1)\cup(-1,2)\cup(3,\infty)$.',
  recommendation_reasons = ARRAY['Trains sign charts with repeated factors.','Reinforces that even multiplicity zeros do not change sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.3-P1: Increasing/decreasing from the sign of $f''(x)$; repeated factor and undefined derivative.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.3',
  section_id = '5.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_INCR_DECR_SIGN','SK_SIGN_CHART','SK_INTERVAL_NOTATION'],
  primary_skill_id = 'SK_INCR_DECR_SIGN',
  supporting_skill_ids = ARRAY['SK_SIGN_CHART', 'SK_INTERVAL_NOTATION'],
 'SK_INTERVAL_NOTATION'],'SK_INTERVAL_NOTATION'],
  error_tags = ARRAY['E_SIGN_CHART_ERROR','E_CRITPOINT_EQUALS_EXTREMA','E_INTERVAL_NOTATION'],
  prompt = 'A differentiable function $f$ has critical points only at $x=-1$ and $x=2$. If $f''(0)<0$ and $f''(3)>0$, which set of intervals must describe where $f$ is decreasing?',
  latex  = 'A differentiable function $f$ has critical points only at $x=-1$ and $x=2$. If $f''(0)<0$ and $f''(3)>0$, which set of intervals must describe where $f$ is decreasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\infty,-1)$','explanation','Incorrect. Knowing $f''(0)<0$ gives information on $(-1,2)$, not necessarily on $(-\infty,-1)$.'),
    jsonb_build_object('id','B','text','$(-1,2)$','explanation','Correct. The sign of $f''(x)$ cannot change on $(-1,2)$ because the only critical points are at the endpoints. Since $0\in(-1,2)$ and $f''(0)<0$, $f$ is decreasing on all of $(-1,2)$.'),
    jsonb_build_object('id','C','text','$(2,\infty)$','explanation','Incorrect. Since $f''(3)>0$ and there are no critical points in $(2,\infty)$, $f$ is increasing there, not decreasing.'),
    jsonb_build_object('id','D','text','$(-\infty,-1)\cup(-1,2)$','explanation','Incorrect. The behavior on $(-\infty,-1)$ is not determined by the given information.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'If the only critical points are $x=-1$ and $x=2$, then $f''(x)$ keeps a constant sign on each of $(-\infty,-1)$, $(-1,2)$, and $(2,\infty)$. Since $f''(0)<0$ and $0\in(-1,2)$, we must have $f''(x)<0$ for all $x\in(-1,2)$. Thus $f$ is decreasing on $(-1,2)$.',
  recommendation_reasons = ARRAY['Builds the idea that sign changes require critical points.','Checks interval reasoning from sparse derivative information.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.3-P2: Constant-sign reasoning between critical points.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.3',
  section_id = '5.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_READ_DERIV_GRAPH','SK_INCR_DECR_SIGN','SK_INTERVAL_NOTATION'],
  primary_skill_id = 'SK_READ_DERIV_GRAPH',
  supporting_skill_ids = ARRAY['SK_INCR_DECR_SIGN', 'SK_INTERVAL_NOTATION'],
 'SK_INTERVAL_NOTATION'],'SK_INTERVAL_NOTATION'],
  error_tags = ARRAY['E_GRAPH_SIGN_MISREAD','E_SIGN_CHART_ERROR','E_INTERVAL_NOTATION'],
  prompt = 'See image (5.3-P3.png). The graph shown is $y=f''(x)$. On which intervals is $f$ increasing?',
  latex  = 'See image (5.3-P3.png). The graph shown is $y=f''(x)$. On which intervals is $f$ increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\infty,-3)\cup(1,2)$','explanation','Incorrect. On the graph, $f''(x)<0$ for $x<-3$ and for $1<x<2$, so $f$ is decreasing there.'),
    jsonb_build_object('id','B','text','$(-3,1)\cup(2,\infty)$','explanation','Correct. From the graph, $f''(x)>0$ on $(-3,1)$ and $(2,\infty)$, so $f$ is increasing on those intervals.'),
    jsonb_build_object('id','C','text','$(-\infty,-3)\cup(2,\infty)$','explanation','Incorrect. The graph shows $f''(x)<0$ for $x<-3$.'),
    jsonb_build_object('id','D','text','$(-3,2)$','explanation','Incorrect. The graph shows $f''(x)$ becomes negative on $(1,2)$, so $f$ is not increasing on all of $(-3,2)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A function $f$ is increasing where $f''(x)>0$. Reading the derivative graph, the curve is above the $x$-axis on $(-3,1)$ and on $(2,\infty)$, and below the $x$-axis on $(-\infty,-3)$ and $(1,2)$. Therefore $f$ is increasing on $(-3,1)\cup(2,\infty)$.',
  recommendation_reasons = ARRAY['Connects a derivative graph to monotonicity.','Targets sign-reading errors from graphs.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.3-P3: Read where $f''(x)>0$ directly from a graph.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.3',
  section_id = '5.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_DOMAIN_RESTRICTION','SK_INCR_DECR_SIGN','SK_SIGN_CHART','SK_INTERVAL_NOTATION'],
  primary_skill_id = 'SK_DOMAIN_RESTRICTION',
  supporting_skill_ids = ARRAY['SK_INCR_DECR_SIGN', 'SK_SIGN_CHART', 'SK_INTERVAL_NOTATION'],
 'SK_SIGN_CHART', 'SK_INTERVAL_NOTATION'],'SK_SIGN_CHART','SK_INTERVAL_NOTATION'],
  error_tags = ARRAY['E_DOMAIN_IGNORED','E_SIGN_CHART_ERROR','E_INTERVAL_NOTATION'],
  prompt = 'Let $f(x)=\ln(x^2-4x)$. On which interval(s) is $f$ increasing?',
  latex  = 'Let $f(x)=\ln(x^2-4x)$. On which interval(s) is $f$ increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(4,\infty)$','explanation','Correct. The domain is $(-\infty,0)\cup(4,\infty)$, and $f''(x)=\dfrac{2(x-2)}{x(x-4)}$ is positive only for $x>4$.'),
    jsonb_build_object('id','B','text','$(-\infty,0)$','explanation','Incorrect. On $(-\infty,0)$, $f''(x)<0$, so $f$ is decreasing there.'),
    jsonb_build_object('id','C','text','$(-\infty,0)\cup(4,\infty)$','explanation','Incorrect. This is the domain, but $f$ is not increasing on the entire domain; it decreases on $(-\infty,0)$.'),
    jsonb_build_object('id','D','text','$(-\infty,2)\cup(4,\infty)$','explanation','Incorrect. The interval $(-\infty,2)$ includes $(0,2)$ where $f$ is not defined.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Domain: require $x^2-4x>0\Rightarrow x(x-4)>0\Rightarrow x<0$ or $x>4$. Derivative: $$f''(x)=\dfrac{2x-4}{x^2-4x}=\dfrac{2(x-2)}{x(x-4)}.$$ On $(-\infty,0)$, choose $x=-1$ to get $f''(x)<0$. On $(4,\infty)$, choose $x=5$ to get $f''(x)>0$. Therefore $f$ is increasing only on $(4,\infty)$.',
  recommendation_reasons = ARRAY['Forces domain checking before sign analysis.','Practices sign of rational expressions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.3-P4: Domain restriction + increasing intervals for a log function.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.3',
  section_id = '5.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_TRIG_INEQUALITY','SK_INCR_DECR_SIGN','SK_INTERVAL_NOTATION'],
  primary_skill_id = 'SK_TRIG_INEQUALITY',
  supporting_skill_ids = ARRAY['SK_INCR_DECR_SIGN', 'SK_INTERVAL_NOTATION'],
 'SK_INTERVAL_NOTATION'],'SK_INTERVAL_NOTATION'],
  error_tags = ARRAY['E_SIGN_CHART_ERROR','E_INTERVAL_NOTATION'],
  prompt = 'Let $f$ be differentiable on $[0,2\pi]$ with $$f''(x)=\sin x-\dfrac12.$$ On which intervals in $[0,2\pi]$ is $f$ increasing?',
  latex  = 'Let $f$ be differentiable on $[0,2\pi]$ with $$f''(x)=\sin x-\dfrac12.$$ On which intervals in $[0,2\pi]$ is $f$ increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\left(\dfrac{\pi}{6},\dfrac{5\pi}{6}\right)$','explanation','Correct. $f''(x)>0$ when $\sin x>\tfrac12$, which occurs on $\left(\tfrac{\pi}{6},\tfrac{5\pi}{6}\right)$ in $[0,2\pi]$.'),
    jsonb_build_object('id','B','text','$\left(0,\dfrac{\pi}{6}\right)\cup\left(\dfrac{5\pi}{6},2\pi\right)$','explanation','Incorrect. On these intervals, $\sin x<\tfrac12$, so $f''(x)<0$.'),
    jsonb_build_object('id','C','text','$\left(\dfrac{\pi}{6},\pi\right)$','explanation','Incorrect. From $\tfrac{5\pi}{6}$ to $\pi$, $\sin x<\tfrac12$.'),
    jsonb_build_object('id','D','text','$\left(\dfrac{7\pi}{6},\dfrac{11\pi}{6}\right)$','explanation','Incorrect. On this interval $\sin x<0$, so $f''(x)<0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Increasing where $f''(x)>0$: $\sin x-\tfrac12>0\iff \sin x>\tfrac12$. On $[0,2\pi]$, $\sin x=\tfrac12$ at $x=\tfrac{\pi}{6}$ and $x=\tfrac{5\pi}{6}$, and $\sin x>\tfrac12$ between them. So $f$ increases on $\left(\tfrac{\pi}{6},\tfrac{5\pi}{6}\right)$.',
  recommendation_reasons = ARRAY['Connects trig inequalities to monotonicity.','Reinforces key unit-circle angles.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.3-P5: Increasing intervals from a trig derivative inequality.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.3-P5';



-- Unit 5.4 (Using the First Derivative Test to Find Relative (Local) Extrema) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.4',
  section_id = '5.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST','SK_SIGN_CHART'],
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_SIGN_CHART'],

  error_tags = ARRAY['E_CRITPOINT_EQUALS_EXTREMA','E_SIGN_CHART_ERROR'],
  prompt = 'A differentiable function $f$ has $$f''(x)=\dfrac{(x-1)(x+2)}{x^2+1}.$$ At which $x$-values does $f$ have a relative extremum?',
  latex  = 'A differentiable function $f$ has $$f''(x)=\dfrac{(x-1)(x+2)}{x^2+1}.$$ At which $x$-values does $f$ have a relative extremum?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=-2$ only','explanation','Incorrect. $x=1$ is also a critical point where $f''(x)=0$, and it produces a sign change.'),
    jsonb_build_object('id','B','text','$x=-2$ and $x=1$','explanation','Correct. Since $x^2+1>0$, the sign is set by $(x-1)(x+2)$, which changes sign at both $x=-2$ and $x=1$.'),
    jsonb_build_object('id','C','text','$x=0$ only','explanation','Incorrect. $f''(0)=\dfrac{(-1)(2)}{1}=-2\ne 0$, so $x=0$ is not critical.'),
    jsonb_build_object('id','D','text','No relative extrema','explanation','Incorrect. The derivative changes sign at both zeros.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Critical points occur where $f''(x)=0$: $x=-2$ and $x=1$. Because $x^2+1>0$ for all $x$, the sign of $f''(x)$ is the sign of $(x-1)(x+2)$. It changes from $+$ to $-$ at $x=-2$ (local maximum) and from $-$ to $+$ at $x=1$ (local minimum). Thus $f$ has relative extrema at $x=-2$ and $x=1$.',
  recommendation_reasons = ARRAY['Standard First Derivative Test with a rational expression.','Reinforces that a positive denominator does not affect sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.4-P1: Identify where sign changes occur in $f''(x)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.4',
  section_id = '5.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST','SK_READ_DERIV_GRAPH'],
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_READ_DERIV_GRAPH'],

  error_tags = ARRAY['E_GRAPH_SIGN_MISREAD','E_CRITPOINT_EQUALS_EXTREMA','E_MAX_MIN_SWAP'],
  prompt = 'See image (5.4-P2.png). The graph shown is $y=f''(x)$. Which statement about relative extrema of $f$ is true?',
  latex  = 'See image (5.4-P2.png). The graph shown is $y=f''(x)$. Which statement about relative extrema of $f$ is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Local minima at both $x=-1$ and $x=2$','explanation','Incorrect. A local minimum requires $f''(x)$ to change from negative to positive; that does not happen at both points.'),
    jsonb_build_object('id','B','text','Local maximum at $x=-1$ and local minimum at $x=2$','explanation','Correct. At $x=-1$, $f''(x)$ changes from positive to negative (max). At $x=2$, $f''(x)$ changes from negative to positive (min).'),
    jsonb_build_object('id','C','text','Local minimum at $x=-1$ and local maximum at $x=2$','explanation','Incorrect. This swaps the sign-change logic at the two critical points.'),
    jsonb_build_object('id','D','text','No local extrema because $f''(x)$ is defined everywhere','explanation','Incorrect. Local extrema can occur where $f''(x)=0$ with a sign change, even if $f''$ is defined.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'By the First Derivative Test, $f$ has a local maximum where $f''(x)$ changes from $+$ to $-$, and a local minimum where $f''(x)$ changes from $-$ to $+$. From the graph: $f''(x)>0$ for $x<-1$, $f''(x)<0$ for $-1<x<2$, and $f''(x)>0$ for $x>2$. Therefore $f$ has a local maximum at $x=-1$ and a local minimum at $x=2$.',
  recommendation_reasons = ARRAY['Applies First Derivative Test directly from a graph.','Targets common graph sign-reading mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.4-P2: Classify extrema using sign changes read from a $f''(x)$ graph.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.4',
  section_id = '5.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST','SK_SIGN_CHART'],
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_SIGN_CHART'],

  error_tags = ARRAY['E_CRITPOINT_EQUALS_EXTREMA','E_SIGN_CHART_ERROR'],
  prompt = 'A differentiable function $f$ has critical points at $x=-4,-1,$ and $3$. The sign of $f''(x)$ is: $f''(x)>0$ on $(-\infty,-4)$, $f''(x)<0$ on $(-4,-1)$, $f''(x)<0$ on $(-1,3)$, and $f''(x)>0$ on $(3,\infty)$. Which statement is true?',
  latex  = 'A differentiable function $f$ has critical points at $x=-4,-1,$ and $3$. The sign of $f''(x)$ is: $f''(x)>0$ on $(-\infty,-4)$, $f''(x)<0$ on $(-4,-1)$, $f''(x)<0$ on $(-1,3)$, and $f''(x)>0$ on $(3,\infty)$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has local maxima at $x=-4$ and $x=-1$','explanation','Incorrect. At $x=-1$, $f''(x)$ is negative on both sides, so there is no local extremum.'),
    jsonb_build_object('id','B','text','$f$ has a local maximum at $x=-4$ and a local minimum at $x=3$','explanation','Correct. $f''(x)$ changes $+\to-$ at $x=-4$ (max) and $-\to+$ at $x=3$ (min).'),
    jsonb_build_object('id','C','text','$f$ has local minima at $x=-4$ and $x=3$','explanation','Incorrect. At $x=-4$, the sign change $+\to-$ indicates a maximum, not a minimum.'),
    jsonb_build_object('id','D','text','$f$ has local minima at all three critical points','explanation','Incorrect. A critical point with no sign change (here $x=-1$) is not a local extremum.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A local maximum occurs where $f''(x)$ changes from positive to negative, and a local minimum occurs where it changes from negative to positive. At $x=-4$ the sign goes $+\to-$, so $f$ has a local maximum. At $x=-1$ the sign is negative on both sides, so there is no local extremum. At $x=3$ the sign goes $-\to+$, so $f$ has a local minimum.',
  recommendation_reasons = ARRAY['Separates critical points from actual extrema.','Builds speed with sign-chart classification.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.4-P3: Identify which critical points truly create local extrema.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.4',
  section_id = '5.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_READ_FUNC_GRAPH','SK_FIRST_DERIV_TEST'],
  primary_skill_id = 'SK_READ_FUNC_GRAPH',
  supporting_skill_ids = ARRAY['SK_FIRST_DERIV_TEST'],

  error_tags = ARRAY['E_GRAPH_SIGN_MISREAD','E_MAX_MIN_SWAP'],
  prompt = 'See image (5.4-P4.png). Based on the graph of $f(x)$, which statement about local extrema is correct?',
  latex  = 'See image (5.4-P4.png). Based on the graph of $f(x)$, which statement about local extrema is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Local maxima at approximately $x=1$ and $x=3$','explanation','Incorrect. The graph shows one local maximum near $x=1$ and one local minimum near $x=3$.'),
    jsonb_build_object('id','B','text','Local maximum at approximately $x=1$ and local minimum at approximately $x=3$','explanation','Correct. The curve changes from increasing to decreasing near $x\approx 1$ (max) and from decreasing to increasing near $x\approx 3$ (min).'),
    jsonb_build_object('id','C','text','Local minimum at approximately $x=1$ and local maximum at approximately $x=3$','explanation','Incorrect. This swaps the max and min indicated by the turning points.'),
    jsonb_build_object('id','D','text','No local extrema are shown','explanation','Incorrect. The turning points indicate local extrema.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Local extrema occur at turning points: increasing to decreasing gives a local maximum, and decreasing to increasing gives a local minimum. From the graph, $f$ turns downward near $x\approx 1$ (local maximum) and turns upward near $x\approx 3$ (local minimum).',
  recommendation_reasons = ARRAY['Connects graph turning behavior to local extrema.','Targets max/min swap errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.4-P4: Identify local max/min directly from a graph of $f(x)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.4',
  section_id = '5.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST','SK_POLY_DERIVATIVE','SK_SIGN_CHART'],
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY['SK_POLY_DERIVATIVE', 'SK_SIGN_CHART'],
 'SK_SIGN_CHART'],'SK_SIGN_CHART'],
  error_tags = ARRAY['E_MAX_MIN_SWAP','E_SIGN_CHART_ERROR'],
  prompt = 'Let $f(x)=x^3-3x^2-9x+1$. Which statement about relative extrema is true?',
  latex  = 'Let $f(x)=x^3-3x^2-9x+1$. Which statement about relative extrema is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a relative maximum at $x=3$ and a relative minimum at $x=-1$','explanation','Incorrect. The critical points are $x=-1$ and $x=3$, but the max/min labels are reversed.'),
    jsonb_build_object('id','B','text','$f$ has relative minima at both $x=-1$ and $x=3$','explanation','Incorrect. The sign of $f''(x)$ changes at each critical point, producing one max and one min.'),
    jsonb_build_object('id','C','text','$f$ has a relative maximum at $x=-1$ and a relative minimum at $x=3$','explanation','Correct. $f''(x)=3(x-3)(x+1)$ changes $+\to-$ at $x=-1$ and $-\to+$ at $x=3$.'),
    jsonb_build_object('id','D','text','$f$ has no relative extrema because $f$ is a polynomial','explanation','Incorrect. Polynomials can have relative extrema.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Compute $$f''(x)=3x^2-6x-9=3(x-3)(x+1).$$ Critical points are $x=-1$ and $x=3$. For $x<-1$, $f''(x)>0$; for $-1<x<3$, $f''(x)<0$; for $x>3$, $f''(x)>0$. Thus $f$ changes from increasing to decreasing at $x=-1$ (relative maximum) and from decreasing to increasing at $x=3$ (relative minimum).',
  recommendation_reasons = ARRAY['Core polynomial derivative + sign test workflow.','Reinforces correct max/min classification from sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = '5.4-P5: Factor the derivative and classify extrema by sign changes.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.4-P5';

END $block$;
