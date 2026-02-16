-- Unit 9.7 (Defining Polar Coordinates and Differentiating in Polar Form) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.7',
  section_id = '9.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_POLAR_DYDX', 'SK_CHAIN_RULE'],
  error_tags = ARRAY['E_POLAR_DYDX_SIGN', 'E_ALGEBRA_SIGN'],
  prompt = 'Let $r(\theta)=2\cos\theta$. At $\theta=\frac{\pi}{3}$, what is $\frac{dy}{dx}$ for the polar curve?',
  latex = 'Let $r(\theta)=2\cos\theta$. At $\theta=\frac{\pi}{3}$, find $\frac{dy}{dx}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\sqrt{3}$','explanation','This can occur from swapping $\frac{dx}{d\theta}$ and $\frac{dy}{d\theta}$ and then simplifying incorrectly.'),
    jsonb_build_object('id','B','text','$-\dfrac{1}{\sqrt{3}}$','explanation','This typically comes from dropping a negative sign in $\frac{dx}{d\theta}$ or $\frac{dy}{d\theta}$.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{\sqrt{3}}$','explanation','Correct. Compute $\frac{dy}{d\theta}$ and $\frac{dx}{d\theta}$, then divide.'),
    jsonb_build_object('id','D','text','$\sqrt{3}$','explanation','This often results from missing the negative sign in $\frac{dx}{d\theta}=r''\cos\theta-r\sin\theta$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use $x=r\cos\theta$ and $y=r\sin\theta$. With $r=2\cos\theta$ and $r''=-2\sin\theta$,
$$\frac{dx}{d\theta}=r''\cos\theta-r\sin\theta=-4\sin\theta\cos\theta,$$
$$\frac{dy}{d\theta}=r''\sin\theta+r\cos\theta=2(\cos^2\theta-\sin^2\theta).$$
At $\theta=\pi/3$, $\frac{dy}{d\theta}=-1$ and $\frac{dx}{d\theta}=-\sqrt{3}$, so
$$\frac{dy}{dx}=\frac{-1}{-\sqrt{3}}=\frac{1}{\sqrt{3}}.$$',
  recommendation_reasons = ARRAY['Reinforces $\frac{dy}{dx}=\frac{dy/d\theta}{dx/d\theta}$ for polar curves.', 'Targets sign errors in $r''$ and in $dx/d\theta$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $dy/dx$ from polar $r(\theta)$ at a specific angle; careful with signs in $dx/d\theta$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_DYDX',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.7',
  section_id = '9.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_POLAR_TANGENT_TESTS', 'SK_POLAR_DYDX'],
  error_tags = ARRAY['E_FORGET_TANGENT_TEST', 'E_CHECK_WRONG_DERIVATIVE'],
  prompt = 'For the polar curve $r(\theta)=1+2\sin\theta$, which value of $\theta$ gives a horizontal tangent line (in $0\le \theta<2\pi$)?',
  latex = 'For $r(\theta)=1+2\sin\theta$, find a $\theta$ in $[0,2\pi)$ where the tangent is horizontal.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\theta=0$','explanation','At $\theta=0$, $\frac{dy}{d\theta}\ne 0$, so the tangent is not horizontal.'),
    jsonb_build_object('id','B','text','$\theta=\frac{\pi}{2}$','explanation','Correct. Here $\frac{dy}{d\theta}=0$ and $\frac{dx}{d\theta}=-3\ne 0$.'),
    jsonb_build_object('id','C','text','$\theta=\pi$','explanation','At $\theta=\pi$, $\frac{dy}{d\theta}\ne 0$, so the tangent is not horizontal.'),
    jsonb_build_object('id','D','text','$\theta=\frac{3\pi}{2}$','explanation','This choice is a common trap: you must check both $\frac{dy}{d\theta}=0$ and $\frac{dx}{d\theta}\ne 0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A horizontal tangent occurs when $\frac{dy}{d\theta}=0$ and $\frac{dx}{d\theta}\ne 0$.

With $x=r\cos\theta$, $y=r\sin\theta$, $r=1+2\sin\theta$, $r''=2\cos\theta$:
$$\frac{dy}{d\theta}=r''\sin\theta+r\cos\theta=\cos\theta(1+4\sin\theta).$$
At $\theta=\pi/2$, $\cos\theta=0$, so $\frac{dy}{d\theta}=0$.
Also
$$\frac{dx}{d\theta}=r''\cos\theta-r\sin\theta=2\cos^2\theta-(1+2\sin\theta)\sin\theta,$$
so at $\theta=\pi/2$ it equals $-3\ne 0$.',
  recommendation_reasons = ARRAY['Builds the correct tangent-test habit in polar form (check $dy/d\theta$ and $dx/d\theta$).', 'Targets the error of not verifying the nonzero condition.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: horizontal tangent test in polar; verify $dy/d\theta=0$ and $dx/d\theta\ne 0$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_POLAR_TANGENT_TESTS',
  supporting_skill_ids = ARRAY['SK_POLAR_DYDX'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.7',
  section_id = '9.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_POLAR_EQUIVALENT_COORDS'],
  error_tags = ARRAY['E_NEGATIVE_R', 'E_ANGLE_EQUIVALENCE'],
  prompt = 'The point has polar coordinates $(r,\theta)=(-3,\tfrac{\pi}{4})$. Which of the following is an equivalent polar representation with $r>0$ and $0\le \theta<2\pi$?',
  latex = 'Given $(r,\theta)=(-3,\tfrac{\pi}{4})$, choose an equivalent representation with $r>0$ and $0\le\theta<2\pi$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(3,\tfrac{5\pi}{4})$','explanation','Correct. Use $(-r,\theta)\equiv(r,\theta+\pi)$.'),
    jsonb_build_object('id','B','text','$(3,\tfrac{\pi}{4})$','explanation','This keeps the same angle, which does not represent the same point when $r$ changes sign.'),
    jsonb_build_object('id','C','text','$(3,\tfrac{7\pi}{4})$','explanation','This uses an incorrect angle shift; it does not add $\pi$.'),
    jsonb_build_object('id','D','text','$(3,\tfrac{3\pi}{4})$','explanation','This places the point in the wrong quadrant.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'In polar coordinates, $(r,\theta)$ and $(-r,\theta+\pi)$ represent the same point. Therefore
$$(-3,\pi/4)\equiv(3,\pi/4+\pi)=(3,5\pi/4).$$',
  recommendation_reasons = ARRAY['High-frequency conceptual skill: equivalent polar representations.', 'Targets the negative-$r$ misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: handling negative $r$ by shifting $\theta$ by $\pi$.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_POLAR_EQUIVALENT_COORDS',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.7',
  section_id = '9.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_POLAR_DYDX', 'SK_PRODUCT_RULE'],
  error_tags = ARRAY['E_POLAR_DYDX_FORMULA', 'E_PRODUCT_RULE_SIGN'],
  prompt = 'Let $r(\theta)=\theta^2$. Which expression equals $\dfrac{dy}{dx}$ in terms of $\theta$ for the polar curve?',
  latex = 'If $r(\theta)=\theta^2$, find $\frac{dy}{dx}$ for the polar curve in terms of $\theta$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{2\theta\sin\theta+\theta^2\cos\theta}{2\theta\cos\theta+\theta^2\sin\theta}$','explanation','This uses the wrong sign in $dx/d\theta$ (it should be $r''\cos\theta-r\sin\theta$).'),
    jsonb_build_object('id','B','text','$\dfrac{2\theta\cos\theta-\theta^2\sin\theta}{2\theta\sin\theta+\theta^2\cos\theta}$','explanation','This is the reciprocal of $dy/dx$ (it swaps numerator and denominator).'),
    jsonb_build_object('id','C','text','$\dfrac{2\theta\sin\theta+\theta^2\cos\theta}{2\theta\cos\theta-\theta^2\sin\theta}$','explanation','Correct. Compute $dy/d\theta$ and $dx/d\theta$ from $x=r\cos\theta$, $y=r\sin\theta$, then divide.'),
    jsonb_build_object('id','D','text','$\dfrac{2\theta\sin\theta-\theta^2\cos\theta}{2\theta\cos\theta-\theta^2\sin\theta}$','explanation','This has a product-rule sign error in $dy/d\theta$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'With $x=r\cos\theta$ and $y=r\sin\theta$, and $r=\theta^2$, $r''=2\theta$:
$$\frac{dx}{d\theta}=2\theta\cos\theta-\theta^2\sin\theta,$$
$$\frac{dy}{d\theta}=2\theta\sin\theta+\theta^2\cos\theta.$$ 
Therefore
$$\frac{dy}{dx}=\frac{2\theta\sin\theta+\theta^2\cos\theta}{2\theta\cos\theta-\theta^2\sin\theta}.$$',
  recommendation_reasons = ARRAY['Checks fluency with the standard polar differentiation pipeline.', 'Targets the common sign mistake in $dx/d\theta$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: symbolic $dy/dx$ formula in polar; product rule and sign discipline.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_POLAR_DYDX',
  supporting_skill_ids = ARRAY['SK_PRODUCT_RULE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.7',
  section_id = '9.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_POLAR_GRAPH_MATCH', 'SK_POLAR_SYMMETRY'],
  error_tags = ARRAY['E_SIN_COS_CONFUSION', 'E_SIGN_REFLECTION'],
  prompt = 'The image shows a polar graph. Which equation matches the graph?',
  latex = 'Choose the polar equation that matches the provided graph.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$r=1+\cos\theta$','explanation','Correct. The graph is symmetric about the polar axis and has a cusp at the origin.'),
    jsonb_build_object('id','B','text','$r=1+\sin\theta$','explanation','This would be symmetric about the vertical axis, not the polar axis.'),
    jsonb_build_object('id','C','text','$r=1-\cos\theta$','explanation','This reflects the curve across the $y$-axis.'),
    jsonb_build_object('id','D','text','$r=2\cos\theta$','explanation','This is a circle, not a cardioid with a cusp.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The graph is symmetric about the polar axis and has a cusp at the origin, characteristic of a cardioid of the form $r=1+\cos\theta$.',
  recommendation_reasons = ARRAY['Connects symmetry and cusp location to equation recognition.', 'Targets common confusion between $\sin$ and $\cos$ forms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based recognition of polar curves; focus on symmetry and cusp location.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_POLAR_GRAPH_MATCH',
  supporting_skill_ids = ARRAY['SK_POLAR_SYMMETRY'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.7-P5';


-- Unit 9.8 (Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.8',
  section_id = '9.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_POLAR_AREA_SINGLE'],
  error_tags = ARRAY['E_MISSING_HALF_FACTOR', 'E_BOUNDS_INCOMPLETE_TRACE'],
  prompt = 'Find the area enclosed by the polar curve $r=2\sin\theta$.',
  latex = 'Find the area enclosed by $r=2\sin\theta$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\pi$','explanation','Correct. $A=\frac12\int_0^{\pi}(2\sin\theta)^2\,d\theta=\pi$.'),
    jsonb_build_object('id','B','text','$2\pi$','explanation','This comes from forgetting the $\tfrac12$ in the polar area formula.'),
    jsonb_build_object('id','C','text','$\frac{\pi}{2}$','explanation','This often results from using $[0,\pi/2]$ instead of the full tracing interval.'),
    jsonb_build_object('id','D','text','$4$','explanation','This confuses area with an average radius or uses a non-area formula.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use polar area:
$$A=\frac12\int_{0}^{\pi}4\sin^2\theta\,d\theta=2\int_0^{\pi}\sin^2\theta\,d\theta=2\cdot\frac{\pi}{2}=\pi.$$',
  recommendation_reasons = ARRAY['Foundational polar area computation with correct bounds and $\tfrac12$ factor.', 'Reinforces recognizing $r=2\sin\theta$ as a circle.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: correct polar area setup and bounds for a full enclosed region.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_POLAR_AREA_SINGLE',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.8-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.8',
  section_id = '9.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_POLAR_AREA_SINGLE', 'SK_TRIG_IDENTITY_HALF_ANGLE'],
  error_tags = ARRAY['E_WRONG_PETAL_BOUNDS', 'E_MISSING_HALF_FACTOR'],
  prompt = 'Find the area of one petal of the rose $r=2\cos(3\theta)$.',
  latex = 'Find the area of one petal of $r=2\cos(3\theta)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{2\pi}{3}$','explanation','This results from incorrect bounds and missing the $\tfrac12$ factor.'),
    jsonb_build_object('id','B','text','$\frac{\pi}{3}$','explanation','This can occur if you double-count the interval that traces one petal.'),
    jsonb_build_object('id','C','text','$\frac{\pi}{6}$','explanation','Correct. Use $A=\frac12\int r^2\,d\theta$ on one-petal bounds.'),
    jsonb_build_object('id','D','text','$\frac{\pi}{12}$','explanation','This often comes from dropping a factor of 2 when simplifying $r^2=4\cos^2(3\theta)$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'One petal around $\theta=0$ is traced when $\cos(3\theta)\ge 0$ between consecutive zeros: $\theta\in[-\pi/6,\pi/6]$.

$$A=\frac12\int_{-\pi/6}^{\pi/6}(2\cos(3\theta))^2\,d\theta=2\int_{-\pi/6}^{\pi/6}\cos^2(3\theta)\,d\theta.$$ 
Using $\cos^2u=\frac{1+\cos(2u)}{2}$ gives $A=\frac{\pi}{6}$.',
  recommendation_reasons = ARRAY['Classic AP BC polar-area-with-rose-bounds skill.', 'Targets bounds and missing-$\tfrac12$ errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify a single-petal interval from zeros of $r$, then compute area.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_POLAR_AREA_SINGLE',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITY_HALF_ANGLE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.8-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.8',
  section_id = '9.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_POLAR_AREA_SINGLE', 'SK_BOUNDS_TRACE_ONCE'],
  error_tags = ARRAY['E_NOT_SQUARING_R', 'E_MISSING_HALF_FACTOR'],
  prompt = 'Which integral gives the area enclosed by the cardioid $r=1+\cos\theta$?',
  latex = 'Choose the correct integral for the area enclosed by $r=1+\cos\theta$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \int_{0}^{2\pi}(1+\cos\theta)\,d\theta$','explanation','This integrates $r$, not $r^2$; it is not an area formula.'),
    jsonb_build_object('id','B','text','$\displaystyle \frac12\int_{0}^{2\pi}(1+\cos\theta)^2\,d\theta$','explanation','Correct. Polar area uses $\tfrac12\int r^2\,d\theta$ over an interval tracing the region once.'),
    jsonb_build_object('id','C','text','$\displaystyle \frac12\int_{0}^{\pi}(1+\cos\theta)^2\,d\theta$','explanation','This gives half the area unless doubled.'),
    jsonb_build_object('id','D','text','$\displaystyle \int_{0}^{2\pi}(1+\cos\theta)^2\,d\theta$','explanation','This misses the required $\tfrac12$ factor.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Polar area is
$$A=\frac12\int_a^b r^2\,d\theta.$$ 
The curve $r=1+\cos\theta$ is traced once on $[0,2\pi]$, so
$$A=\frac12\int_0^{2\pi}(1+\cos\theta)^2\,d\theta.$$',
  recommendation_reasons = ARRAY['Checks correct setup before computation.', 'Targets missing-square and missing-$\tfrac12$ errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Setup-only: identify correct polar area integral and bounds for a standard cardioid.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_AREA_SINGLE',
  supporting_skill_ids = ARRAY['SK_BOUNDS_TRACE_ONCE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.8-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.8',
  section_id = '9.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN', 'SK_SOLVE_INTERSECTIONS'],
  error_tags = ARRAY['E_INNER_OUTER_SWAP', 'E_WRONG_INTERSECTION_BOUNDS'],
  prompt = 'Let $R$ be the region inside $r=2\cos\theta$ and outside $r=1$. What is the area of $R$?',
  latex = 'Find the area inside $r=2\cos\theta$ and outside $r=1$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{\pi}{3}-\frac{\sqrt{3}}{4}$','explanation','Correct. Use intersection angles $\theta=\pm\pi/3$ and $\frac12\int (r_{out}^2-r_{in}^2)\,d\theta$.'),
    jsonb_build_object('id','B','text','$\frac{\pi}{3}+\frac{\sqrt{3}}{4}$','explanation','This typically comes from a sign error when evaluating the sine term.'),
    jsonb_build_object('id','C','text','$\frac{2\pi}{3}-\frac{\sqrt{3}}{2}$','explanation','This is the correct answer multiplied by 2 (often from forgetting the $\tfrac12$ factor).'),
    jsonb_build_object('id','D','text','$\frac{\sqrt{3}}{4}$','explanation','This drops the constant part of the integral.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Intersections satisfy $2\cos\theta=1$, so $\theta=\pm\pi/3$.

$$A=\frac12\int_{-\pi/3}^{\pi/3}\left((2\cos\theta)^2-1\right)d\theta=\frac12\int_{-\pi/3}^{\pi/3}(4\cos^2\theta-1)d\theta.$$ 
Using $\cos^2\theta=\frac{1+\cos2\theta}{2}$ yields
$$A=\frac{\pi}{3}-\frac{\sqrt{3}}{4}.$$',
  recommendation_reasons = ARRAY['AP-style polar area between curves.', 'Requires correct intersection bounds and outer-minus-inner setup.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Area between polar curves with symmetric bounds; requires correct outer/inner identification.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN',
  supporting_skill_ids = ARRAY['SK_SOLVE_INTERSECTIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.8-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.8',
  section_id = '9.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN', 'SK_BOUNDS_FROM_GRAPH'],
  error_tags = ARRAY['E_NOT_SQUARING_R', 'E_INNER_OUTER_SWAP'],
  prompt = 'The shaded region in the image is inside $r=2\cos\theta$ and outside $r=1$. Which integral represents the shaded area?',
  latex = 'Choose the integral that represents the shaded region (inside $r=2\cos\theta$, outside $r=1$).',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \frac12\int_{0}^{\pi/3}\left(1-(2\cos\theta)^2\right)d\theta$','explanation','This swaps outer/inner radii and uses only half the symmetric interval.'),
    jsonb_build_object('id','B','text','$\displaystyle \frac12\int_{-\pi/3}^{\pi/3}\left((2\cos\theta)^2-1\right)d\theta$','explanation','Correct. Use outer-minus-inner with bounds from $2\cos\theta=1$.'),
    jsonb_build_object('id','C','text','$\displaystyle \frac12\int_{-\pi/3}^{\pi/3}\left((2\cos\theta)-1\right)d\theta$','explanation','Area requires squared radii; integrating $r$ is incorrect.'),
    jsonb_build_object('id','D','text','$\displaystyle \int_{-\pi/3}^{\pi/3}\left((2\cos\theta)^2-1\right)d\theta$','explanation','This misses the required $\tfrac12$ factor.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For polar area between curves,
$$A=\frac12\int_a^b\left(r_{out}^2-r_{in}^2\right)d\theta.$$ 
Here $r_{out}=2\cos\theta$ and $r_{in}=1$, with intersections at $\theta=\pm\pi/3$. Thus the correct setup is
$$\frac12\int_{-\pi/3}^{\pi/3}\left((2\cos\theta)^2-1\right)d\theta.$$',
  recommendation_reasons = ARRAY['Checks interpretation of a shaded region in polar coordinates.', 'Targets missing-square and inner/outer swap errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based setup verification for area between polar curves.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN',
  supporting_skill_ids = ARRAY['SK_BOUNDS_FROM_GRAPH'],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.8-P5';

COMMIT;
