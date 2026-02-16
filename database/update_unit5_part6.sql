-- Unit 5 Part 6 Update Script (5.11 - 5.12)
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 5.11 (Solving Optimization Problems) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.11',
  section_id = '5.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_OPT_MODELING', 'SK_ALGEBRA_SOLVING'],
  primary_skill_id = 'SK_OPT_MODELING',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SOLVING'],

  error_tags = ARRAY['E_SET_DERIV_ZERO_ONLY', 'E_DOMAIN_RESTRICTION'],
  prompt = 'A rectangle has perimeter $40$ units. What is the maximum possible area (in square units)?',
  latex = 'A rectangle has perimeter $40$ units. What is the maximum possible area (in square units)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','80','explanation','This corresponds to a non-square rectangle, which cannot maximize area for fixed perimeter.'),
    jsonb_build_object('id','B','text','100','explanation','For fixed perimeter, the area is maximized by a square: side $10$, area $10\\cdot 10=100$.'),
    jsonb_build_object('id','C','text','120','explanation','This exceeds the square’s area and is not attainable with perimeter $40$.'),
    jsonb_build_object('id','D','text','160','explanation','This is not attainable with perimeter $40$; it incorrectly treats perimeter as a product.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let sides be $x$ and $y$. Then $2x+2y=40\\Rightarrow y=20-x$. Area
$$A(x)=x(20-x)=20x-x^2$$
is a downward-opening parabola with vertex at $x=10$, so
$$A_{\\max}=10\\cdot 10=100.$$',
  recommendation_reasons = ARRAY['Builds optimization modeling from a simple constraint.', 'Reinforces finding a maximum via vertex/critical point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Classic single-variable optimization with a linear constraint.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.11-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.11',
  section_id = '5.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_OPT_MODELING', 'SK_OPT_DERIVATIVE_CRITICAL', 'SK_ALGEBRA_SOLVING'],
  primary_skill_id = 'SK_OPT_MODELING',
  supporting_skill_ids = ARRAY['SK_OPT_DERIVATIVE_CRITICAL', 'SK_ALGEBRA_SOLVING'],
 'SK_ALGEBRA_SOLVING'], 'SK_ALGEBRA_SOLVING'],
  error_tags = ARRAY['E_SET_DERIV_ZERO_ONLY', 'E_ALGEBRA_SIGN'],
  prompt = 'A closed cylinder must have volume $32\\pi$ cubic units. What radius $r$ minimizes the surface area?',
  latex = 'A closed cylinder must have volume $32\\pi$ cubic units. What radius $r$ minimizes the surface area?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','1','explanation','This radius does not satisfy the minimizing condition from the derivative.'),
    jsonb_build_object('id','B','text','2\\sqrt{2}','explanation','This comes from an algebra slip when solving the critical-point equation.'),
    jsonb_build_object('id','C','text','4','explanation','This is too large; it increases lateral area for the fixed volume.'),
    jsonb_build_object('id','D','text','2','explanation','Using $V=\\pi r^2 h=32\\pi$ and minimizing $S=2\\pi r^2+2\\pi rh$ gives $r=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'From $\\pi r^2h=32\\pi$, we get $h=\\dfrac{32}{r^2}$. Surface area
$$S(r)=2\\pi r^2+2\\pi r\\left(\\frac{32}{r^2}\\right)=2\\pi r^2+\\frac{64\\pi}{r}.$$
Differentiate:
$$S''(r)=4\\pi r-\\frac{64\\pi}{r^2}=0\\Rightarrow 4r^3=64\\Rightarrow r=2.$$',
  recommendation_reasons = ARRAY['Models optimization with geometric formulas and a constraint substitution.', 'Emphasizes correct derivative algebra with rational expressions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Closed-cylinder surface area minimization with fixed volume.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.11-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.11',
  section_id = '5.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_OPT_MODELING', 'SK_OPT_DERIVATIVE_CRITICAL', 'SK_DOMAIN_CONSTRAINTS'],
  primary_skill_id = 'SK_OPT_MODELING',
  supporting_skill_ids = ARRAY['SK_OPT_DERIVATIVE_CRITICAL', 'SK_DOMAIN_CONSTRAINTS'],
 'SK_DOMAIN_CONSTRAINTS'], 'SK_DOMAIN_CONSTRAINTS'],
  error_tags = ARRAY['E_DOMAIN_RESTRICTION', 'E_ALGEBRA_SIGN'],
  prompt = 'A $10\\times 16$ rectangle of cardboard is used to make an open-top box by cutting out squares of side $x$ from each corner and folding up the sides. (See image.) What value of $x$ maximizes the volume?',
  latex = 'A $10\\times 16$ rectangle of cardboard is used to make an open-top box by cutting out squares of side $x$ from each corner and folding up the sides. (See image.) What value of $x$ maximizes the volume?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','2','explanation','Volume $V(x)=x(10-2x)(16-2x)$ has a domain-valid critical point at $x=2$, giving the maximum.'),
    jsonb_build_object('id','B','text','4','explanation','This is feasible, but it does not maximize $V(x)$.'),
    jsonb_build_object('id','C','text','5','explanation','At $x=5$, $10-2x=0$, so the volume is $0$.'),
    jsonb_build_object('id','D','text','8','explanation','This is outside the domain since $10-2x$ would be negative.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Volume is
$$V(x)=x(10-2x)(16-2x),\\quad 0<x<5.$$
Expanding:
$$V(x)=4x^3-52x^2+160x,$$
so
$$V''(x)=12x^2-104x+160=0\\Rightarrow 3x^2-26x+40=0.$$
Thus $x=2$ or $x=\\frac{20}{3}$, and only $x=2$ lies in $(0,5)$. Since endpoints give volume $0$, $x=2$ maximizes the volume.',
  recommendation_reasons = ARRAY['Reinforces domain reasoning in optimization.', 'Connects geometry setup to derivative-based maximization.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Open-top box optimization; enforce $0<x<5$. Image file: 5.11-P3.png',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.11-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.11',
  section_id = '5.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_OPT_MODELING', 'SK_ALGEBRA_SOLVING'],
  primary_skill_id = 'SK_OPT_MODELING',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SOLVING'],

  error_tags = ARRAY['E_SET_DERIV_ZERO_ONLY', 'E_FORGET_ENDPOINTS'],
  prompt = 'A farmer has $200$ meters of fencing to enclose a rectangular area along a straight river. No fencing is needed along the river. What is the maximum possible area?',
  latex = 'A farmer has $200$ meters of fencing to enclose a rectangular area along a straight river. No fencing is needed along the river. What is the maximum possible area?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','2,500','explanation','This results from splitting the fencing equally among all three sides incorrectly.'),
    jsonb_build_object('id','B','text','4,000','explanation','This corresponds to $w=40$, $L=120$, which is not optimal.'),
    jsonb_build_object('id','C','text','5,000','explanation','Constraint $2w+L=200$ gives max at $w=50$, $L=100$, so area $=5000$.'),
    jsonb_build_object('id','D','text','10,000','explanation','This would require more than $200$ meters of fencing.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let width be $w$ and length be $L$. Fencing covers three sides:
$$2w+L=200\\Rightarrow L=200-2w.$$
Area
$$A(w)=w(200-2w)=200w-2w^2.$$
Then
$$A''(w)=200-4w=0\\Rightarrow w=50,$$
so $L=100$ and the maximum area is $50\\cdot 100=5000$.',
  recommendation_reasons = ARRAY['Trains quick setup of a word optimization problem.', 'Highlights interpreting which sides are fenced.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'River fencing optimization (three sides).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.11-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.11',
  section_id = '5.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_OPT_MODELING', 'SK_OPT_DERIVATIVE_CRITICAL', 'SK_CONTEXT_INTERPRETATION'],
  primary_skill_id = 'SK_OPT_MODELING',
  supporting_skill_ids = ARRAY['SK_OPT_DERIVATIVE_CRITICAL', 'SK_CONTEXT_INTERPRETATION'],
 'SK_CONTEXT_INTERPRETATION'], 'SK_CONTEXT_INTERPRETATION'],
  error_tags = ARRAY['E_DOMAIN_RESTRICTION', 'E_ALGEBRA_SIGN'],
  prompt = 'A company sells a product for $p$ dollars per unit and the weekly demand is $q(p)=600-20p$ for $0\\le p\\le 30$. Revenue is $R(p)=p\\,q(p)$. What price $p$ maximizes revenue?',
  latex = 'A company sells a product for $p$ dollars per unit and the weekly demand is $q(p)=600-20p$ for $0\\le p\\le 30$. Revenue is $R(p)=p\\,q(p)$. What price $p$ maximizes revenue?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','10','explanation','This is not the vertex/critical point of the revenue parabola.'),
    jsonb_build_object('id','B','text','15','explanation','Revenue $R(p)=600p-20p^2$ is maximized at $p=15$.'),
    jsonb_build_object('id','C','text','20','explanation','This yields lower revenue than at the vertex $p=15$.'),
    jsonb_build_object('id','D','text','30','explanation','At $p=30$, demand is $0$, so revenue is $0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Revenue is
$$R(p)=p(600-20p)=600p-20p^2,$$
a downward-opening parabola on $[0,30]$. The maximum occurs at the vertex:
$$p=-\\frac{b}{2a}=-\\frac{600}{2(-20)}=15.$$',
  recommendation_reasons = ARRAY['Connects optimization to a linear demand model.', 'Checks domain/endpoints where demand can be zero.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Quadratic revenue optimization with domain constraint.',
  weight_primary = 0.55,
  weight_supporting = 0.45,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.11-P5';



-- Unit 5.12 (Exploring Behaviors of Implicit Relations) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.12',
  section_id = '5.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_IMPLICIT_DIFFERENTIATION', 'SK_ALGEBRA_SOLVING'],
  primary_skill_id = 'SK_IMPLICIT_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SOLVING'],

  error_tags = ARRAY['E_MISS_YPRIME', 'E_ALGEBRA_SIGN'],
  prompt = 'For the curve $x^2+xy+y^2=7$, what is $\\dfrac{dy}{dx}$ at the point $(2,1)$?',
  latex = 'For the curve $x^2+xy+y^2=7$, what is $\\dfrac{dy}{dx}$ at the point $(2,1)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\dfrac{5}{4}$','explanation','This is correct after implicit differentiation and substitution.'),
    jsonb_build_object('id','B','text','$-\\dfrac{4}{5}$','explanation','This inverts the solved fraction for $y''$.'),
    jsonb_build_object('id','C','text','$\\dfrac{5}{4}$','explanation','Sign error: the slope here is negative after substitution.'),
    jsonb_build_object('id','D','text','$-\\dfrac{4}{3}$','explanation','This results from dropping an $x$ or $y$ term when differentiating $xy$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$2x+(x y''+y)+2y y''=0\\Rightarrow 2x+y+x y''+2y y''=0.$$
So
$$(x+2y)y''=-(2x+y)\\Rightarrow y''=-\\frac{2x+y}{x+2y}.$$
At $(2,1)$:
$$y''=-\\frac{4+1}{2+2}=-\\frac{5}{4}.$$',
  recommendation_reasons = ARRAY['Targets precise implicit differentiation mechanics.', 'Addresses the common missing-$y''$ error on the product $xy$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Implicit derivative at a point with product term $xy$.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.12-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.12',
  section_id = '5.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_TANGENT_HORIZONTAL_VERTICAL', 'SK_IMPLICIT_DIFFERENTIATION'],
  primary_skill_id = 'SK_TANGENT_HORIZONTAL_VERTICAL',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION'],

  error_tags = ARRAY['E_VERT_HORIZ_SWAP', 'E_MISS_YPRIME'],
  prompt = 'Consider the curve $x^2+y^2=4y$. At which points on the curve does it have horizontal tangents?',
  latex = 'Consider the curve $x^2+y^2=4y$. At which points on the curve does it have horizontal tangents?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(0,0)$ and $(0,4)$','explanation','Correct: $y''=-\\dfrac{2x}{2y-4}$ is $0$ when $x=0$ (with $y\\ne 2$), giving $(0,0)$ and $(0,4)$.'),
    jsonb_build_object('id','B','text','$(2,2)$ and $(-2,2)$','explanation','These correspond to $y=2$, where the tangent is vertical, not horizontal.'),
    jsonb_build_object('id','C','text','$(0,2)$ only','explanation','$(0,2)$ is not on the curve.'),
    jsonb_build_object('id','D','text','$(2,0)$ and $(-2,0)$','explanation','These points are not on the curve.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$2x+2y y''=4y''\\Rightarrow y''=-\\frac{2x}{2y-4}.$$
Horizontal tangents require $y''=0\\Rightarrow x=0$ with $2y-4\\ne 0$. Plugging $x=0$ into the curve:
$$y^2=4y\\Rightarrow y=0\\text{ or }4,$$
so the points are $(0,0)$ and $(0,4)$.',
  recommendation_reasons = ARRAY['Sharpens the distinction between horizontal vs vertical tangency.', 'Builds the habit of checking denominator conditions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Circle written implicitly; classify tangency via $y''$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.12-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.12',
  section_id = '5.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_TANGENT_HORIZONTAL_VERTICAL', 'SK_IMPLICIT_DIFFERENTIATION'],
  primary_skill_id = 'SK_TANGENT_HORIZONTAL_VERTICAL',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION'],

  error_tags = ARRAY['E_VERT_HORIZ_SWAP', 'E_ALGEBRA_SIGN'],
  prompt = 'For the curve $x^2+y^2=4y$, at which points does it have vertical tangents?',
  latex = 'For the curve $x^2+y^2=4y$, at which points does it have vertical tangents?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(2,2)$ and $(-2,2)$','explanation','Correct: denominator $2y-4=0$ gives $y=2$, and the curve then gives $x=\\pm 2$.'),
    jsonb_build_object('id','B','text','$(0,0)$ and $(0,4)$','explanation','These are horizontal tangent points for this curve.'),
    jsonb_build_object('id','C','text','$(0,2)$ only','explanation','$(0,2)$ is not on the curve.'),
    jsonb_build_object('id','D','text','All points with $y=2$','explanation','You must also satisfy the curve equation; only $x=\\pm 2$ work.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Using
$$y''=-\\frac{2x}{2y-4},$$
vertical tangents occur when $2y-4=0$ and $2x\\ne 0$. Thus $y=2$ and $x\\ne 0$. On the curve:
$$x^2+4=8\\Rightarrow x=\\pm 2,$$
so the points are $(2,2)$ and $(-2,2)$.',
  recommendation_reasons = ARRAY['Pairs with the horizontal-tangent skill to prevent swapping criteria.', 'Reinforces checking both the derivative condition and the curve equation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Vertical tangents on an implicit circle using denominator condition.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.12-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.12',
  section_id = '5.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_IMPLICIT_SECOND_DERIV', 'SK_IMPLICIT_DIFFERENTIATION'],
  primary_skill_id = 'SK_IMPLICIT_SECOND_DERIV',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION'],

  error_tags = ARRAY['E_MISS_YPRIME', 'E_SECOND_DERIV_ERROR'],
  prompt = 'On the circle $x^2+y^2=1$ with $y>0$, what is $\\dfrac{d^2y}{dx^2}$ at the point $\\left(\\dfrac{\\sqrt{2}}{2},\\dfrac{\\sqrt{2}}{2}\\right)$?',
  latex = 'On the circle $x^2+y^2=1$ with $y>0$, what is $\\dfrac{d^2y}{dx^2}$ at the point $\\left(\\dfrac{\\sqrt{2}}{2},\\dfrac{\\sqrt{2}}{2}\\right)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\sqrt{2}$','explanation','This misses the cube on $y$ when simplifying $y''''=-1/y^3$.'),
    jsonb_build_object('id','B','text','$-2$','explanation','This uses $y''''=-1/y^2$ instead of the correct $-1/y^3$.'),
    jsonb_build_object('id','C','text','$-2\\sqrt{2}$','explanation','Correct: from $y''=-x/y$, differentiating gives $y''''=-1/y^3$, then substitute $y=\\sqrt{2}/2$.'),
    jsonb_build_object('id','D','text','$2\\sqrt{2}$','explanation','Sign error: the upper semicircle is concave down here.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'From $x^2+y^2=1$:
$$2x+2y y''=0\\Rightarrow y''=-\\frac{x}{y}.$$
Differentiate:
$$y''''=-\\frac{y-xy''}{y^2}.$$
Substitute $y''=-x/y$:
$$y''''=-\\frac{y+x^2/y}{y^2}=-\\frac{(y^2+x^2)/y}{y^2}=-\\frac{1}{y^3}.$$
At $y=\\sqrt{2}/2$:
$$y''''=-\\frac{1}{(\\sqrt{2}/2)^3}=-2\\sqrt{2}.$$',
  recommendation_reasons = ARRAY['High-frequency AP skill: second derivative from an implicit relation.', 'Forces careful chain rule management.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Implicit second derivative simplified using $x^2+y^2=1$.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.12-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = '5.12',
  section_id = '5.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_TANGENT_HORIZONTAL_VERTICAL', 'SK_IMPLICIT_DIFFERENTIATION'],
  primary_skill_id = 'SK_TANGENT_HORIZONTAL_VERTICAL',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION'],

  error_tags = ARRAY['E_VERT_HORIZ_SWAP', 'E_DOMAIN_RESTRICTION'],
  prompt = 'The graph shows the curve $x^2+y^2=4y$ with labeled points A, B, C, and D. At which labeled point is the tangent line vertical? (See image.)',
  latex = 'The graph shows the curve $x^2+y^2=4y$ with labeled points A, B, C, and D. At which labeled point is the tangent line vertical? (See image.)',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','A','explanation','At point A, $y=2$ and $x\\ne 0$, so $y''=-\\dfrac{2x}{2y-4}$ is undefined (vertical tangent).'),
    jsonb_build_object('id','B','text','B','explanation','At point B $(0,0)$, the tangent is horizontal because $x=0$ gives $y''=0$.'),
    jsonb_build_object('id','C','text','C','explanation','At point C $(0,4)$, the tangent is horizontal because $x=0$ gives $y''=0$.'),
    jsonb_build_object('id','D','text','D','explanation','At point D, neither numerator nor denominator forces a vertical tangent.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For $x^2+y^2=4y$,
$$y''=-\\frac{2x}{2y-4}.$$
A vertical tangent occurs when $2y-4=0$ and $x\\ne 0$, i.e., at points with $y=2$ on the curve. The labeled point with $y=2$ and $x\\ne 0$ is A.',
  recommendation_reasons = ARRAY['Links algebraic criteria for vertical tangency to a visual graph.', 'Reduces vertical/horizontal tangent confusion in implicit contexts.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based identification of vertical tangency on an implicit circle. Image file: 5.12-P5.png',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.12-P5';

END $block$;
