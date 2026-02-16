-- Unit 5 Part 5 Update Script (5.9 - 5.10)
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 5.9 (Connecting a Function, Its First Derivative, and Its Second Derivative) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.9',
  section_id = '5.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONNECT_F_FPRIME_F2PRIME', 'SK_GRAPH_ANALYSIS', 'SK_FIRST_DERIVATIVE_SIGN'],
  primary_skill_id = 'SK_CONNECT_F_FPRIME_F2PRIME',
  supporting_skill_ids = ARRAY['SK_GRAPH_ANALYSIS', 'SK_FIRST_DERIVATIVE_SIGN'],
 'SK_FIRST_DERIVATIVE_SIGN'], 'SK_FIRST_DERIVATIVE_SIGN'],
  error_tags = ARRAY['ERR_SIGN_CHANGE_MISREAD', 'ERR_CONFUSE_F_AND_FPRIME'],
  prompt = 'The graph of $f''(x)$ is shown. At which $x$-value does $f$ have a local maximum?',
  latex = 'The graph of $f''(x)$ is shown. At which $x$-value does $f$ have a local maximum?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=\dfrac{5}{3}$ only','explanation','At $x=\tfrac{5}{3}$, $f''(x)$ changes from negative to positive, indicating a local minimum of $f$.'),
    jsonb_build_object('id','B','text','$x=-1$ only','explanation','At $x=-1$, $f''(x)$ changes from positive to negative, so $f$ has a local maximum there.'),
    jsonb_build_object('id','C','text','Both $x=-1$ and $x=\dfrac{5}{3}$','explanation','Only $x=-1$ gives a $+\to-$ sign change. The other critical point gives $-\to+$.'),
    jsonb_build_object('id','D','text','Neither $x=-1$ nor $x=\dfrac{5}{3}$','explanation','A local maximum does occur at $x=-1$ because of the $+\to-$ sign change in $f''(x)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A local maximum of $f$ occurs where $f''(x)=0$ and the sign of $f''(x)$ changes from positive to negative. From the graph, $f''(x)=0$ at $x=-1,\,\tfrac{5}{3},\,4$. Near $x=-1$, $f''(x)$ goes from $+$ to $-$, so $f$ has a local maximum at $x=-1$. Near $x=\tfrac{5}{3}$, $f''(x)$ goes from $-$ to $+$ (local minimum). The point $x=4$ is an endpoint of the shown interval and does not create a local maximum by itself.',
  recommendation_reasons = ARRAY['Targets reading sign changes on a derivative graph to classify extrema.', 'Reinforces the distinction between zeros of $f''$ and actual maxima/minima.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify local extrema of $f$ from sign changes in $f''(x)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.9-P1';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.9',
  section_id = '5.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_CONNECT_F_FPRIME_F2PRIME', 'SK_SECOND_DERIVATIVE_CONCAVITY'],
  primary_skill_id = 'SK_CONNECT_F_FPRIME_F2PRIME',
  supporting_skill_ids = ARRAY['SK_SECOND_DERIVATIVE_CONCAVITY'],

  error_tags = ARRAY['ERR_INFLECTION_VS_EXTREMA', 'ERR_CONFUSE_F_AND_FPRIME'],
  prompt = 'Suppose $f$ is twice differentiable and $f''''(2)=0$ with $f''''(x)>0$ for $x<2$ and $f''''(x)<0$ for $x>2$. Which statement must be true about $f''(x)$ at $x=2$?',
  latex = 'Suppose $f$ is twice differentiable and $f''''(2)=0$ with $f''''(x)>0$ for $x<2$ and $f''''(x)<0$ for $x>2$. Which statement must be true about $f''(x)$ at $x=2$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum at $x=2$','explanation','Concavity information alone does not guarantee an extremum of $f$; that would require information about $f''(2)$ and a sign change in $f''.'),
    jsonb_build_object('id','B','text','$f''(2)=0$','explanation','$f''''(2)=0$ does not force $f''(2)=0$.'),
    jsonb_build_object('id','C','text','$f''(x)$ has a local minimum at $x=2$','explanation','For $f''(x)$ to have a local minimum, $f''''$ would need to change from negative to positive, not positive to negative.'),
    jsonb_build_object('id','D','text','$f''(x)$ has a local maximum at $x=2$','explanation','Since $f''''(x)$ changes from positive to negative at $x=2$, $f''(x)$ changes from increasing to decreasing, so $f''(x)$ has a local maximum at $x=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Because $f''''(x)=(f''(x))''$, the sign of $f''''$ tells whether $f''$ is increasing or decreasing. With $f''''(x)>0$ for $x<2$, $f''$ is increasing to the left of $2$. With $f''''(x)<0$ for $x>2$, $f''$ is decreasing to the right of $2$. Therefore $f''(x)$ has a local maximum at $x=2$.',
  recommendation_reasons = ARRAY['Directly tests the relationship between $f''$ and $f''''$.', 'Addresses the common confusion between inflection points of $f$ and extrema of $f''.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret $f''''$ as the derivative of $f''''(x)$ to classify behavior of $f''(x)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.9-P2';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.9',
  section_id = '5.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_CONNECT_F_FPRIME_F2PRIME', 'SK_GRAPH_ANALYSIS'],
  primary_skill_id = 'SK_CONNECT_F_FPRIME_F2PRIME',
  supporting_skill_ids = ARRAY['SK_GRAPH_ANALYSIS'],

  error_tags = ARRAY['ERR_CONFUSE_F_AND_FPRIME', 'ERR_GRAPH_INTERPRETATION'],
  prompt = 'Three graphs (I, II, III) are shown. One is $f$, one is $f''$, and one is $f''''$ for the same function $f$. Which matching is consistent?',
  latex = 'Three graphs (I, II, III) are shown. One is $f$, one is $f''$, and one is $f''''$ for the same function $f$. Which matching is consistent?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','I is $f$, II is $f''$, III is $f''''$','explanation','Graph I has even-degree end behavior and multiple turning points; II is cubic-like; III is quadratic-like, consistent with successive derivatives.'),
    jsonb_build_object('id','B','text','I is $f''$, II is $f$, III is $f''''$','explanation','If II were $f$, then I would be $f''$, but the degree/end behavior relationships do not match.'),
    jsonb_build_object('id','C','text','I is $f''''$, II is $f''$, III is $f$','explanation','This reverses the typical degree/shape progression among derivatives.'),
    jsonb_build_object('id','D','text','I is $f$, II is $f''''$, III is $f''$','explanation','This ordering mismatches the expected derivative relationships among the shapes.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Graph I has even-degree end behavior (both ends up) and multiple turning points, consistent with a quartic-like $f$. Graph II has odd-degree end behavior and an S-shape, consistent with a cubic-like $f''$. Graph III is U-shaped, consistent with a quadratic-like $f''''$.',
  recommendation_reasons = ARRAY['Builds fluency connecting global graph features across $f$, $f''$, and $f''''$.', 'High-frequency AP skill: matching derivative graphs using shape and end behavior.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: match $f$, $f''$, $f''''$ by qualitative graph features (end behavior, turning points).',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.9-P3';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.9',
  section_id = '5.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONNECT_F_FPRIME_F2PRIME', 'SK_FIRST_DERIVATIVE_SIGN', 'SK_SECOND_DERIVATIVE_CONCAVITY'],
  primary_skill_id = 'SK_CONNECT_F_FPRIME_F2PRIME',
  supporting_skill_ids = ARRAY['SK_FIRST_DERIVATIVE_SIGN', 'SK_SECOND_DERIVATIVE_CONCAVITY'],
 'SK_SECOND_DERIVATIVE_CONCAVITY'], 'SK_SECOND_DERIVATIVE_CONCAVITY'],
  error_tags = ARRAY['ERR_INFLECTION_VS_EXTREMA', 'ERR_SIGN_CHANGE_MISREAD'],
  prompt = 'A function $f$ is differentiable on $(-\infty,\infty)$. Suppose $f''(x)=0$ at $x=1$ and $x=4$. Also, $f''''(x)>0$ for $x<2$ and $f''''(x)<0$ for $x>2$. Which statement is best supported by this information?',
  latex = 'A function $f$ is differentiable on $(-\infty,\infty)$. Suppose $f''(x)=0$ at $x=1$ and $x=4$. Also, $f''''(x)>0$ for $x<2$ and $f''''(x)<0$ for $x>2$. Which statement is best supported by this information?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum at $x=1$','explanation','A local maximum at $x=1$ would require a $+\to-$ sign change in $f''$ at $1$, which is not determined from concavity alone.'),
    jsonb_build_object('id','B','text','$f$ has inflection points at both $x=1$ and $x=4$','explanation','Inflection points occur where concavity changes; the concavity change is indicated at $x=2$, not at $1$ or $4$.'),
    jsonb_build_object('id','C','text','$f''(x)$ has a local maximum at $x=2$','explanation','Since $f''''$ changes from positive to negative at $x=2$, $f''$ changes from increasing to decreasing, giving a local maximum of $f''$ at $x=2$.'),
    jsonb_build_object('id','D','text','$f$ must have a local minimum at $x=4$','explanation','A local minimum at $x=4$ would require $f''$ to change from negative to positive there, which is not guaranteed.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'With $f''''(x)>0$ for $x<2$, $f''$ is increasing on $(-\infty,2)$. With $f''''(x)<0$ for $x>2$, $f''$ is decreasing on $(2,\infty)$. Therefore $f''(x)$ has a local maximum at $x=2$. The information does not determine whether $f$ has local extrema at $x=1$ or $x=4$.',
  recommendation_reasons = ARRAY['Checks precise interpretation of concavity information.', 'Reinforces separating conclusions about $f$ vs conclusions about $f''''.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use sign information to infer increasing/decreasing of a related derivative function.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.9-P4';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.9',
  section_id = '5.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_CONNECT_F_FPRIME_F2PRIME', 'SK_SECOND_DERIVATIVE_CONCAVITY'],
  primary_skill_id = 'SK_CONNECT_F_FPRIME_F2PRIME',
  supporting_skill_ids = ARRAY['SK_SECOND_DERIVATIVE_CONCAVITY'],

  error_tags = ARRAY['ERR_INFLECTION_VS_EXTREMA', 'ERR_SIGN_CHANGE_MISREAD'],
  prompt = 'Which statement is always true for a twice differentiable function $f$?',
  latex = 'Which statement is always true for a twice differentiable function $f$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','If $f''''(a)=0$, then $f$ has an inflection point at $x=a$','explanation','$f''''(a)=0$ is not sufficient; concavity must change sign.'),
    jsonb_build_object('id','B','text','If $f''''(x)>0$ on an interval, then $f''(x)$ is increasing on that interval','explanation','Because $f''''=(f'')'' , a positive derivative means $f''$ increases.'),
    jsonb_build_object('id','C','text','If $f''(a)=0$, then $f$ has a local extremum at $x=a$','explanation','$f''(a)=0$ is not sufficient; need a sign change or additional information.'),
    jsonb_build_object('id','D','text','If $f''''(x)<0$ on an interval, then $f(x)$ is decreasing on that interval','explanation','$f''''<0$ indicates concave down for $f''$, not necessarily decreasing of $f$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $f''''(x)$ is the derivative of $f''(x)$, if $f''''(x)>0$ on an interval then $f''(x)$ is increasing on that interval.',
  recommendation_reasons = ARRAY['Quick check of foundational relationships among derivatives.', 'Targets common necessary/sufficient-condition traps.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: connect sign of a derivative to monotonicity of the next-lower derivative.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.9-P5';

-- Unit 5.10 (Introduction to Optimization Problems) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.10',
  section_id = '5.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_OPTIMIZATION_MODELING', 'SK_ALGEBRA_MODELING'],
  primary_skill_id = 'SK_OPTIMIZATION_MODELING',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_MODELING'],

  error_tags = ARRAY['ERR_SETUP_OBJECTIVE_WRONG', 'ERR_DOMAIN_CONSTRAINT_IGNORED'],
  prompt = 'A rectangle has perimeter $100$. If one side length is $x$, which function $A(x)$ should be maximized to find the maximum area of the rectangle?',
  latex = 'A rectangle has perimeter $100$. If one side length is $x$, which function $A(x)$ should be maximized to find the maximum area of the rectangle?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$A(x)=x(100-x)$','explanation','This uses $y=100-x$, which would come from $x+y=100$, not from the perimeter equation.'),
    jsonb_build_object('id','B','text','$A(x)=2x(50-x)$','explanation','This doubles the area formula; the area is $xy$, not $2xy$.'),
    jsonb_build_object('id','C','text','$A(x)=x+(50-x)$','explanation','This is a sum of side lengths, not area.'),
    jsonb_build_object('id','D','text','$A(x)=x(50-x)$','explanation','From $2x+2y=100$, $y=50-x$, so $A=xy=x(50-x)$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Perimeter gives $2x+2y=100$, so $y=50-x$. The area is $A=xy$, hence $A(x)=x(50-x)$ (domain $0<x<50$).',
  recommendation_reasons = ARRAY['Focuses on correct objective/constraint setup before any calculus step.', 'Targets the frequent perimeter-vs-sum mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: write objective function from a constraint (perimeter).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.10-P1';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.10',
  section_id = '5.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_OPTIMIZATION_MODELING', 'SK_ALGEBRA_MODELING'],
  primary_skill_id = 'SK_OPTIMIZATION_MODELING',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_MODELING'],

  error_tags = ARRAY['ERR_SETUP_OBJECTIVE_WRONG', 'ERR_ALGEBRA_SIMPLIFY_ERROR'],
  prompt = 'An open-top box is made by cutting out squares of side length $x$ from each corner of a square sheet of side length $s$ and folding up the sides. Which expression gives the volume $V(x)$ of the box?',
  latex = 'An open-top box is made by cutting out squares of side length $x$ from each corner of a square sheet of side length $s$ and folding up the sides. Which expression gives the volume $V(x)$ of the box?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$V(x)=x(s-2x)^2$','explanation','Height is $x$ and the base is a square with side $s-2x$, so volume is $x(s-2x)^2$.'),
    jsonb_build_object('id','B','text','$V(x)=(s-x)^2x$','explanation','Each side loses $2x$, not $x$, because two corners are removed along each dimension.'),
    jsonb_build_object('id','C','text','$V(x)=x^2(s-2x)$','explanation','This treats the base as $x\times x$ instead of $(s-2x)\times(s-2x)$.'),
    jsonb_build_object('id','D','text','$V(x)=(s-2x)^3$','explanation','This would be a cube with side $s-2x$; the height is $x$, not $s-2x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Cutting out squares of side $x$ makes the box height $x$. Each dimension of the base loses $x$ on both ends, so the base side length is $s-2x$. Base area is $(s-2x)^2$, so $V(x)=x(s-2x)^2$.',
  recommendation_reasons = ARRAY['Classic optimization modeling setup used frequently on AP exams.', 'Targets the common $s-x$ vs $s-2x$ mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: model volume from geometric dimensions before optimizing.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.10-P2';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.10',
  section_id = '5.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_OPTIMIZATION_MODELING', 'SK_ALGEBRA_MODELING'],
  primary_skill_id = 'SK_OPTIMIZATION_MODELING',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_MODELING'],

  error_tags = ARRAY['ERR_SETUP_OBJECTIVE_WRONG', 'ERR_DOMAIN_CONSTRAINT_IGNORED'],
  prompt = 'A farmer has $200$ meters of fencing to enclose a rectangular region adjacent to a straight river, so no fencing is needed along the river side. Let $x$ be the length of each side perpendicular to the river. Which area function $A(x)$ should be maximized?',
  latex = 'A farmer has $200$ meters of fencing to enclose a rectangular region adjacent to a straight river, so no fencing is needed along the river side. Let $x$ be the length of each side perpendicular to the river. Which area function $A(x)$ should be maximized?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$A(x)=2x(200-2x)$','explanation','This doubles the true area $xy$.'),
    jsonb_build_object('id','B','text','$A(x)=x(200-x)$','explanation','This uses $y=200-x$, but the constraint is $2x+y=200$.'),
    jsonb_build_object('id','C','text','$A(x)=x(200-2x)$','explanation','With $2x+y=200$, $y=200-2x$ and $A=xy=x(200-2x)$.'),
    jsonb_build_object('id','D','text','$A(x)=(200-2x)^2$','explanation','This incorrectly treats the region as a square with side $200-2x$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Only three sides are fenced: $2x+y=200$, so $y=200-2x$. Area is $A=xy=x(200-2x)$ with domain $0<x<100$.',
  recommendation_reasons = ARRAY['Reinforces how physical constraints translate into equations.', 'Targets miscounting the number of fenced sides.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: translate a real constraint into a single-variable area function.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.10-P3';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.10',
  section_id = '5.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_OPTIMIZATION_MODELING', 'SK_ALGEBRA_MODELING'],
  primary_skill_id = 'SK_OPTIMIZATION_MODELING',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_MODELING'],

  error_tags = ARRAY['ERR_SETUP_OBJECTIVE_WRONG', 'ERR_ALGEBRA_SIMPLIFY_ERROR'],
  prompt = 'A closed right circular cylinder must have volume $500\pi\text{ cm}^3$. Let $r$ be the radius and $h$ the height. Which single-variable surface area function $S(r)$ should be minimized?',
  latex = 'A closed right circular cylinder must have volume $500\pi\text{ cm}^3$. Let $r$ be the radius and $h$ the height. Which single-variable surface area function $S(r)$ should be minimized?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$S(r)=2\pi r^2+\dfrac{1000\pi}{r}$','explanation','Substitute $h=\frac{500}{r^2}$ into $S=2\pi r^2+2\pi rh$ to get $2\pi r^2+\frac{1000\pi}{r}$.'),
    jsonb_build_object('id','B','text','$S(r)=2\pi r^2+\dfrac{500\pi}{r^2}$','explanation','This incorrectly replaces $2\pi rh$ with a term in $1/r^2$.'),
    jsonb_build_object('id','C','text','$S(r)=\pi r^2+\dfrac{1000\pi}{r}$','explanation','A closed cylinder has two bases, so the base term should be $2\pi r^2$.'),
    jsonb_build_object('id','D','text','$S(r)=2\pi r^2+\dfrac{500\pi}{r}$','explanation','The lateral term becomes $\frac{1000\pi}{r}$, not $\frac{500\pi}{r}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Volume constraint: $\pi r^2h=500\pi$ so $h=\frac{500}{r^2}$. Closed-cylinder surface area is $S=2\pi r^2+2\pi rh$. Substitute to get $S(r)=2\pi r^2+\frac{1000\pi}{r}$.',
  recommendation_reasons = ARRAY['High-discrimination modeling: translating constraint into a one-variable objective.', 'Targets frequent mistakes with cylinder surface area components.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: build a one-variable surface area function using a volume constraint.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.10-P4';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.10',
  section_id = '5.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_OPTIMIZATION_MODELING'],
  primary_skill_id = 'SK_OPTIMIZATION_MODELING',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['ERR_SETUP_OBJECTIVE_WRONG'],
  prompt = 'Two positive numbers have sum $10$. If one number is $x$, which function $P(x)$ represents their product (to be maximized)?',
  latex = 'Two positive numbers have sum $10$. If one number is $x$, which function $P(x)$ represents their product (to be maximized)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$P(x)=x(10-x)$','explanation','The other number is $10-x$, so product is $x(10-x)$.'),
    jsonb_build_object('id','B','text','$P(x)=10x-x$','explanation','This simplifies to $9x$ and is not a product of the two numbers.'),
    jsonb_build_object('id','C','text','$P(x)=x+(10-x)$','explanation','That equals $10$ and represents the sum, not the product.'),
    jsonb_build_object('id','D','text','$P(x)=\dfrac{x}{10-x}$','explanation','This is a ratio, not a product.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'If the two positive numbers sum to $10$ and one is $x$, the other is $10-x$. Their product is $P(x)=x(10-x)$ with domain $0<x<10$.',
  recommendation_reasons = ARRAY['Reinforces the first step of optimization: defining variables and writing the objective.', 'Targets the common sum-vs-product confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: write a product objective from a sum constraint.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.10-P5';

END $block$;
