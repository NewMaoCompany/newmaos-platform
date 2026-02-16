-- Unit 9.9 (Finding the Area of the Region Bounded by Two Polar Curves) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.9',
  section_id = '9.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN_CURVES', 'SK_TRIG_INTEGRATION', 'SK_LIMITS_THETA'],
  error_tags = ARRAY['E_WRONG_INTERSECTION', 'E_INTEGRAND_WRONG_R_SQUARED', 'E_LIMITS_THETA'],
  prompt = 'Find the area of the region that lies inside $r=2+\cos\theta$ and outside $r=2$.',
  latex = 'Find the area of the region that lies inside $r=2+\cos\theta$ and outside $r=2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4+\dfrac{\pi}{2}$','explanation','This comes from forgetting the factor $\tfrac12$ in the polar area formula.'),
    jsonb_build_object('id','B','text','$4+\dfrac{\pi}{4}$','explanation','Correct: $\frac12\int_{-\pi/2}^{\pi/2}\big((2+\cos\theta)^2-2^2\big)\,d\theta=4+\frac{\pi}{4}$.'),
    jsonb_build_object('id','C','text','$2+\dfrac{\pi}{4}$','explanation','This typically results from dropping the $4\cos\theta$ term when expanding $(2+\cos\theta)^2$.'),
    jsonb_build_object('id','D','text','$\dfrac{\pi}{4}$','explanation','This ignores the contribution from the $4\cos\theta$ term and the constant part of the integral.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Intersection occurs when $2+\cos\theta=2\Rightarrow \cos\theta=0$, so $\theta\in[-\frac{\pi}{2},\frac{\pi}{2}]$ bounds the region where $2+\cos\theta\ge 2$. Area is
$$A=\frac12\int_{-\pi/2}^{\pi/2}\Big((2+\cos\theta)^2-2^2\Big)\,d\theta
=\frac12\int_{-\pi/2}^{\pi/2}\big(4\cos\theta+\cos^2\theta\big)\,d\theta
=\frac12\Big(8+\frac{\pi}{2}\Big)=4+\frac{\pi}{4}.$$',
  recommendation_reasons = ARRAY['Reinforces area-between-curves setup $\tfrac12\int(R^2-r^2)\,d\theta$.','Targets correct intersection angles and the required $\tfrac12$ factor.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key steps: solve intersections first, then integrate $\tfrac12\big(R^2-r^2\big)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN_CURVES',
  supporting_skill_ids = ARRAY['SK_TRIG_INTEGRATION', 'SK_LIMITS_THETA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.9-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.9',
  section_id = '9.9',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN_CURVES', 'SK_FIND_INTERSECTION_POLAR', 'SK_TRIG_INTEGRATION'],
  error_tags = ARRAY['E_WRONG_INTERSECTION', 'E_OUTER_INNER_SWAP', 'E_INTEGRAND_WRONG_R_SQUARED'],
  prompt = 'Find the area of the region that lies inside $r=3\sin\theta$ and outside $r=1$.',
  latex = 'Find the area of the region that lies inside $r=3\sin\theta$ and outside $r=1$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{7\pi}{4}+\sqrt{2}$','explanation','This incorrectly assumes the bounds are $0$ to $\pi$ and ignores the actual intersection angles.'),
    jsonb_build_object('id','B','text','$\dfrac{7}{4}\big(\pi-2\arcsin(\tfrac{1}{3})\big)-\sqrt{2}$','explanation','Sign error: the contribution from the sine term should be $+\sqrt{2}$, not negative.'),
    jsonb_build_object('id','C','text','$\dfrac{7}{4}\big(\pi-2\arcsin(\tfrac{1}{3})\big)+\sqrt{2}$','explanation','Correct: use $\theta\in[\alpha,\pi-\alpha]$ where $\alpha=\arcsin(\tfrac13)$.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{2}\big(\pi-2\arcsin(\tfrac{1}{3})\big)$','explanation','This ignores squaring the radii and omits the $9\sin^2\theta$ contribution.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Intersections satisfy $3\sin\theta=1\Rightarrow \sin\theta=\tfrac{1}{3}$. Let $\alpha=\arcsin(\tfrac{1}{3})$, so the region occurs for $\theta\in[\alpha,\pi-\alpha]$. Area:
$$A=\frac12\int_{\alpha}^{\pi-\alpha}\big((3\sin\theta)^2-1^2\big)\,d\theta
=\frac12\int_{\alpha}^{\pi-\alpha}(9\sin^2\theta-1)\,d\theta.$$
Since $9\sin^2\theta-1=\frac{7}{2}-\frac{9}{2}\cos 2\theta$, the integral equals
$$\frac12\left[\frac{7}{2}(\pi-2\alpha)+\frac{9}{2}\sin 2\alpha\right]=\frac{7}{4}(\pi-2\alpha)+\frac{9}{4}\sin 2\alpha.$$
With $\sin\alpha=\tfrac13$ and $\cos\alpha=\tfrac{2\sqrt2}{3}$, we get $\sin 2\alpha=2\sin\alpha\cos\alpha=\tfrac{4\sqrt2}{9}$, so $\frac{9}{4}\sin 2\alpha=\sqrt2$. Thus
$$A=\frac{7}{4}\Big(\pi-2\arcsin\big(\tfrac13\big)\Big)+\sqrt2.$$',
  recommendation_reasons = ARRAY['Trains intersection-finding and correct bounds for two polar curves.','Builds comfort with exact-form results involving inverse trig.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Find intersections first; outer curve is $3\sin\theta$ on $[\alpha,\pi-\alpha]$.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN_CURVES',
  supporting_skill_ids = ARRAY['SK_FIND_INTERSECTION_POLAR', 'SK_TRIG_INTEGRATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.9-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.9',
  section_id = '9.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN_CURVES', 'SK_INTEGRAL_SETUP', 'SK_LIMITS_THETA'],
  error_tags = ARRAY['E_INTEGRAND_WRONG_R_SQUARED', 'E_MISSING_HALF_FACTOR', 'E_LIMITS_THETA'],
  prompt = 'Which integral gives the area of the region inside $r=1+\sin\theta$ and outside $r=1$, for $0\le \theta\le \pi$?',
  latex = 'Which integral gives the area of the region inside $r=1+\sin\theta$ and outside $r=1$, for $0\le \theta\le \pi$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac12\int_{0}^{\pi}\left((1+\sin\theta)^2-1^2\right)\,d\theta$','explanation','Correct: area between curves is $\tfrac12\int(R^2-r^2)\,d\theta$ on $[0,\pi]$.'),
    jsonb_build_object('id','B','text','$\int_{0}^{\pi}\left((1+\sin\theta)-1\right)\,d\theta$','explanation','Uses radii instead of squared radii; polar area requires $r^2$.'),
    jsonb_build_object('id','C','text','$\dfrac12\int_{0}^{\pi}\left((1+\sin\theta)-1\right)\,d\theta$','explanation','Still missing the squares; $\tfrac12$ alone does not fix it.'),
    jsonb_build_object('id','D','text','$\dfrac12\int_{0}^{\pi}\left(1^2-(1+\sin\theta)^2\right)\,d\theta$','explanation','Reverses outer and inner, producing a negative value.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For area between polar curves on $[a,b]$, use
$$A=\frac12\int_a^b\big(R(\theta)^2-r(\theta)^2\big)\,d\theta,$$
where $R$ is the outer radius. Here $R(\theta)=1+\sin\theta$ and $r(\theta)=1$ on $0\le\theta\le\pi$.',
  recommendation_reasons = ARRAY['Targets the most common setup error: forgetting the square.','Reinforces outer-minus-inner with the $\tfrac12$ factor.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Memorize: polar area uses $\tfrac12\int r^2\,d\theta$; between curves use $\tfrac12\int(R^2-r^2)\,d\theta$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN_CURVES',
  supporting_skill_ids = ARRAY['SK_INTEGRAL_SETUP', 'SK_LIMITS_THETA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.9-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.9',
  section_id = '9.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN_CURVES', 'SK_FIND_INTERSECTION_POLAR', 'SK_TRIG_INTEGRATION'],
  error_tags = ARRAY['E_WRONG_INTERSECTION', 'E_OUTER_INNER_SWAP', 'E_MISSING_HALF_FACTOR'],
  prompt = 'Find the area of the region that lies inside $r=4\cos\theta$ and outside $r=2$.',
  latex = 'Find the area of the region that lies inside $r=4\cos\theta$ and outside $r=2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{4\pi}{3}+2\sqrt{3}$','explanation','Correct: integrate $\tfrac12\big((4\cos\theta)^2-2^2\big)$ from $-\pi/3$ to $\pi/3$.'),
    jsonb_build_object('id','B','text','$\dfrac{8\pi}{3}+4\sqrt{3}$','explanation','This is double the correct answer (forgot the $\tfrac12$ factor).'),
    jsonb_build_object('id','C','text','$\dfrac{4\pi}{3}-2\sqrt{3}$','explanation','Sign error when integrating the $\cos 2\theta$ term.'),
    jsonb_build_object('id','D','text','$\dfrac{2\pi}{3}+2\sqrt{3}$','explanation','This typically comes from halving the interval length incorrectly or using $0$ to $\pi/3$ without symmetry correctly.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Intersect when $4\cos\theta=2\Rightarrow \cos\theta=\tfrac12$, so $\theta=\pm\tfrac{\pi}{3}$. Area:
$$A=\frac12\int_{-\pi/3}^{\pi/3}\left((4\cos\theta)^2-2^2\right)d\theta
=\frac12\int_{-\pi/3}^{\pi/3}(16\cos^2\theta-4)\,d\theta.$$
Use $\cos^2\theta=\frac{1+\cos 2\theta}{2}$:
$$16\cos^2\theta-4=8(1+\cos2\theta)-4=4+8\cos2\theta.$$
Thus
$$A=\frac12\left[4\cdot\frac{2\pi}{3}+4\big(\sin2\theta\big)\Big|_{-\pi/3}^{\pi/3}\right]
=\frac12\left(\frac{8\pi}{3}+4\sqrt3\right)=\frac{4\pi}{3}+2\sqrt3.$$',
  recommendation_reasons = ARRAY['Reinforces solving intersections and using symmetry/bounds correctly.','Targets the frequent missing-$\\tfrac12$ error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Outer curve is $r=4\cos\theta$ where it exceeds 2; bounds come from $\cos\theta=1/2$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN_CURVES',
  supporting_skill_ids = ARRAY['SK_FIND_INTERSECTION_POLAR', 'SK_TRIG_INTEGRATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.9-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Motion',
  sub_topic_id = '9.9',
  section_id = '9.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_POLAR_AREA_BETWEEN_CURVES'],
  error_tags = ARRAY['E_INTEGRAND_WRONG_R_SQUARED', 'E_MISSING_HALF_FACTOR', 'E_OUTER_INNER_SWAP'],
  prompt = 'If a region is bounded between the outer polar curve $r=R(\theta)$ and the inner polar curve $r=r(\theta)$ for $\alpha\le\theta\le\beta$, which formula gives its area?',
  latex = 'If a region is bounded between the outer polar curve $r=R(\theta)$ and the inner polar curve $r=r(\theta)$ for $\alpha\le\theta\le\beta$, which formula gives its area?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle\int_{\alpha}^{\beta}\big(R(\theta)-r(\theta)\big)\,d\theta$','explanation','Polar area is not based on radius difference; it depends on squared radii.'),
    jsonb_build_object('id','B','text','$\displaystyle\frac12\int_{\alpha}^{\beta}\big(r(\theta)^2-R(\theta)^2\big)\,d\\theta$','explanation','This reverses outer and inner, giving a negative area.'),
    jsonb_build_object('id','C','text','$\displaystyle\int_{\alpha}^{\beta}R(\theta)^2\,d\theta$','explanation','Missing the $\tfrac12$ factor and the subtraction of the inner curve.'),
    jsonb_build_object('id','D','text','$\displaystyle\frac12\int_{\alpha}^{\beta}\big(R(\theta)^2-r(\theta)^2\big)\,d\theta$','explanation','Correct: subtract squared radii and include the $\tfrac12$ factor.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Polar area uses $A=\frac12\int r^2\,d\theta$. For the region between two curves, subtract the inner area from the outer area on the same $\theta$-interval:
$$A=\frac12\int_{\alpha}^{\beta}\big(R(\theta)^2-r(\theta)^2\big)\,d\theta.$$',
  recommendation_reasons = ARRAY['Locks in the standard formula used repeatedly in Unit 9 polar area questions.','Prevents systematic errors: missing square, missing $\tfrac12$, or outer/inner reversal.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Formula checkpoint item for fast accuracy on polar area problems.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_POLAR_AREA_BETWEEN_CURVES',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Motion',
  updated_at = NOW()
WHERE title = '9.9-P5';

COMMIT;
