-- Unit 3.5 & 3.6 SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 3.5 (Selecting Procedures for Calculating Derivatives) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.5',
  section_id = '3.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_DERIV_RULE_SELECT','SK_CHAIN_RULE'],
  primary_skill_id = 'SK_DERIV_RULE_SELECT',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE'],

  error_tags = ARRAY['E_CHAIN_RULE_MISAPPLIED','E_RULE_SELECTION_WRONG'],
  prompt = 'For $h(x)=(3x^2-5)^7$, which procedure is most appropriate to find $h''(x)$?',
  latex = 'For $h(x)=(3x^2-5)^7$, which procedure is most appropriate to find $h''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Product rule','explanation','There is no product of two separate functions; it is a single composition.'),
    jsonb_build_object('id','B','text','Chain rule','explanation','Correct: $h(x)$ is a composition of an outer power function and an inner polynomial.'),
    jsonb_build_object('id','C','text','Quotient rule','explanation','There is no quotient present.'),
    jsonb_build_object('id','D','text','Implicit differentiation','explanation','The function is explicitly defined as $h(x)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $h(x)=(u(x))^7$ with $u(x)=3x^2-5$, use the chain rule: differentiate the outer function and multiply by $u''(x)$.',
  recommendation_reasons = ARRAY['Reinforces recognizing composition structures for the chain rule.','Builds rule-selection accuracy before computation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: selecting an efficient differentiation procedure (composition recognition).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.5',
  section_id = '3.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_DERIV_RULE_SELECT','SK_PRODUCT_RULE','SK_CHAIN_RULE'],
  primary_skill_id = 'SK_DERIV_RULE_SELECT',
  supporting_skill_ids = ARRAY['SK_PRODUCT_RULE', 'SK_CHAIN_RULE'],
 'SK_CHAIN_RULE'],'SK_CHAIN_RULE'],
  error_tags = ARRAY['E_RULE_SELECTION_WRONG','E_DISTRIBUTE_DERIV_OVER_PRODUCT'],
  prompt = 'To differentiate $p(x)=x^3\\sin(x^2)$ most efficiently, which set of rules must be used?',
  latex = 'To differentiate $p(x)=x^3\\sin(x^2)$ most efficiently, which set of rules must be used?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Product rule and chain rule','explanation','Correct: it is a product $x^3\\cdot\\sin(x^2)$, and $\\sin(x^2)$ requires the chain rule.'),
    jsonb_build_object('id','B','text','Quotient rule and chain rule','explanation','There is no quotient; it is a product.'),
    jsonb_build_object('id','C','text','Product rule only','explanation','You also need the chain rule for $\\sin(x^2)$.'),
    jsonb_build_object('id','D','text','Chain rule only','explanation','You must address the product of two functions.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because $p(x)$ is a product and one factor is a composition, apply the product rule, and within $\\sin(x^2)$ apply the chain rule.',
  recommendation_reasons = ARRAY['Builds correct rule selection before algebraic execution.','Targets the common mistake of ignoring product structure.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: choosing all required rules (product + chain).',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.5',
  section_id = '3.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_QUOTIENT_RULE','SK_DERIV_RULE_SELECT'],
  primary_skill_id = 'SK_QUOTIENT_RULE',
  supporting_skill_ids = ARRAY['SK_DERIV_RULE_SELECT'],

  error_tags = ARRAY['E_QUOTIENT_RULE_SIGN','E_RULE_SELECTION_WRONG'],
  prompt = 'Let $q(x)=\\dfrac{\\ln x}{x^2+1}$ for $x>0$. Which expression matches $q''(x)$?',
  latex = 'Let $q(x)=\\dfrac{\\ln x}{x^2+1}$ for $x>0$. Which expression matches $q''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{\\frac{1}{x}}{x^2+1}$','explanation','This differentiates only the numerator and ignores that the denominator is also changing.'),
    jsonb_build_object('id','B','text','$\\dfrac{\\ln x}{2x}$','explanation','This is not the derivative; it resembles an unrelated expression.'),
    jsonb_build_object('id','C','text','$\\dfrac{\\frac{1}{x}(x^2+1)-\\ln x\\,(2x)}{(x^2+1)^2}$','explanation','Correct: quotient rule $(u/v)''=(u''v-uv'')/v^2$ with $u=\\ln x$, $v=x^2+1$.'),
    jsonb_build_object('id','D','text','$\\dfrac{\\frac{1}{x}(x^2+1)+\\ln x\\,(2x)}{(x^2+1)^2}$','explanation','Sign error: the middle term should be $u''v-uv''$, not a sum.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use the quotient rule with $u=\\ln x$ and $v=x^2+1$. Then $u''=1/x$ and $v''=2x$, so\n$$q''(x)=\\frac{u''v-uv''}{v^2}=\\frac{\\frac{1}{x}(x^2+1)-\\ln x\\,(2x)}{(x^2+1)^2}.$$',
  recommendation_reasons = ARRAY['Targets common quotient-rule structure/sign mistakes.','Reinforces identifying numerator/denominator roles in the quotient rule.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: quotient rule structure and sign control.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.5',
  section_id = '3.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_IMPLICIT_DIFF','SK_DERIV_RULE_SELECT','SK_PRODUCT_RULE'],
  primary_skill_id = 'SK_IMPLICIT_DIFF',
  supporting_skill_ids = ARRAY['SK_DERIV_RULE_SELECT', 'SK_PRODUCT_RULE'],
 'SK_PRODUCT_RULE'],'SK_PRODUCT_RULE'],
  error_tags = ARRAY['E_FORGOT_DYDX','E_PRODUCT_RULE_MISAPPLIED'],
  prompt = 'The curve is defined implicitly by $x^2+xy+y^2=7$. What is $\\dfrac{dy}{dx}$?',
  latex = 'The curve is defined implicitly by $x^2+xy+y^2=7$. What is $\\dfrac{dy}{dx}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{-2x+y}{x+2y}$','explanation','Sign error from differentiating $xy$ (it becomes $x\\,y''+y$, not $x\\,y''-y$).'),
    jsonb_build_object('id','B','text','$\\dfrac{-2x-y}{1+2y}$','explanation','Missing the $x$ factor on the $y''$ term coming from $xy$.'),
    jsonb_build_object('id','C','text','$\\dfrac{-2x}{x+y}$','explanation','This omits the derivative of $y^2$ and mishandles the $xy$ term.'),
    jsonb_build_object('id','D','text','$\\dfrac{-2x-y}{x+2y}$','explanation','Correct: differentiate implicitly and solve for $y''$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Differentiate: $2x+(x\\,y''+y)+2y\\,y''=0$. Combine $y''$ terms: $(x+2y)y''=-(2x+y)$. Thus\n$$\\frac{dy}{dx}=\\frac{-2x-y}{x+2y}.$$',
  recommendation_reasons = ARRAY['Reinforces product rule inside implicit differentiation.','Targets the frequent omission of the $y''$ factor.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: implicit differentiation with a product term $xy$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.5',
  section_id = '3.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_INVERSE_DERIV','SK_DERIV_RULE_SELECT'],
  primary_skill_id = 'SK_INVERSE_DERIV',
  supporting_skill_ids = ARRAY['SK_DERIV_RULE_SELECT'],

  error_tags = ARRAY['E_INVERSE_RECIPROCAL','E_SIGN_ERROR'],
  prompt = 'A differentiable function $f$ satisfies $f(2)=5$ and $f''(2)=-3$. What is $(f^{-1})''(5)$?',
  latex = 'A differentiable function $f$ satisfies $f(2)=5$ and $f''(2)=-3$. What is $(f^{-1})''(5)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-3$','explanation','This is $f''(2)$, not the derivative of the inverse at $5$.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{3}$','explanation','The reciprocal magnitude is right, but the sign must match $1/f''(2)$, which is negative.'),
    jsonb_build_object('id','C','text','$-\\dfrac{1}{3}$','explanation','Correct: $(f^{-1})''(5)=\\dfrac{1}{f''(2)}=\\dfrac{1}{-3}$.'),
    jsonb_build_object('id','D','text','$\\dfrac{1}{-3+5}$','explanation','Incorrect use of given numbers; inverse derivative depends on $f''(2)$ once the matching input is identified.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use $(f^{-1})''(b)=\\dfrac{1}{f''(a)}$ where $f(a)=b$. Since $f(2)=5$,\n$$(f^{-1})''(5)=\\frac{1}{f''(2)}=\\frac{1}{-3}=-\\frac{1}{3}.$$',
  recommendation_reasons = ARRAY['Targets the high-frequency inverse-derivative reciprocal/sign mistake.','Reinforces matching $f(a)=b$ before using the reciprocal.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative of an inverse function at a point.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.5-P5';



-- Unit 3.6 (Calculating Higher-Order Derivatives) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.6',
  section_id = '3.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_HIGHER_ORDER','SK_CHAIN_RULE'],
  primary_skill_id = 'SK_HIGHER_ORDER',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE'],

  error_tags = ARRAY['E_SECOND_DERIV_ALGEBRA','E_CHAIN_RULE_MISAPPLIED'],
  prompt = 'Let $f(x)=\\sin(2x)$. What is $f''''(x)$?',
  latex = 'Let $f(x)=\\sin(2x)$. What is $f''''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-4\\cos(2x)$','explanation','This would come from differentiating $\\sin(2x)$ incorrectly or stopping early.'),
    jsonb_build_object('id','B','text','$-4\\sin(2x)$','explanation','Correct: $f''(x)=2\\cos(2x)$ and $f''''(x)=2\\cdot(-\\sin(2x))\\cdot 2=-4\\sin(2x)$.'),
    jsonb_build_object('id','C','text','$2\\cos(2x)$','explanation','That is $f''(x)$, not $f''''(x)$.'),
    jsonb_build_object('id','D','text','$4\\sin(2x)$','explanation','Sign error: the second derivative of $\\sin$ introduces a negative.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate twice using the chain rule each time. First derivative: $f''(x)=2\\cos(2x)$. Second derivative:\n$$f''''(x)=2\\cdot(-\\sin(2x))\\cdot 2=-4\\sin(2x).$$',
  recommendation_reasons = ARRAY['Practices repeated differentiation with chain-rule constants.','Targets the common missing-factor and sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: computing a second derivative with repeated chain rule factors.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.6',
  section_id = '3.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_KINEMATICS','SK_HIGHER_ORDER'],
  primary_skill_id = 'SK_KINEMATICS',
  supporting_skill_ids = ARRAY['SK_HIGHER_ORDER'],

  error_tags = ARRAY['E_VEL_ACC_MIXUP','E_SECOND_DERIV_ALGEBRA'],
  prompt = 'A particle’s position is $s(t)=t^3-6t^2+9t$ (meters), where $t$ is in seconds. What is the acceleration $a(2)$?',
  latex = 'A particle’s position is $s(t)=t^3-6t^2+9t$ (meters), where $t$ is in seconds. What is the acceleration $a(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Correct: $a(t)=s''''(t)=6t-12$, so $a(2)=12-12=0$.'),
    jsonb_build_object('id','B','text','$-6$','explanation','This is $a(1)$ for this function, not $a(2)$.'),
    jsonb_build_object('id','C','text','$6$','explanation','This often results from confusing $a(t)$ with $v(t)$ or missing the constant term.'),
    jsonb_build_object('id','D','text','$-3$','explanation','This comes from an incorrect derivative.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Velocity is $v(t)=s''''(t)=3t^2-12t+9$. Acceleration is $a(t)=v''''(t)=s''''(t)=6t-12$.\nThus\n$$a(2)=6\\cdot 2-12=0.$$',
  recommendation_reasons = ARRAY['Separates position/velocity/acceleration and emphasizes evaluating $s''''(t)$ correctly.','Targets the velocity-vs-acceleration mix-up.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: acceleration as a second derivative in a motion context.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.6',
  section_id = '3.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_HIGHER_ORDER','SK_PRODUCT_RULE','SK_CHAIN_RULE'],
  primary_skill_id = 'SK_HIGHER_ORDER',
  supporting_skill_ids = ARRAY['SK_PRODUCT_RULE', 'SK_CHAIN_RULE'],
 'SK_CHAIN_RULE'],'SK_CHAIN_RULE'],
  error_tags = ARRAY['E_SECOND_DERIV_ALGEBRA','E_PRODUCT_RULE_MISAPPLIED'],
  prompt = 'Let $g(x)=x^2e^{3x}$. What is $g''''(0)$?',
  latex = 'Let $g(x)=x^2e^{3x}$. What is $g''''(0)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','While $g(0)=0$, the second derivative at $0$ is not necessarily $0$.'),
    jsonb_build_object('id','B','text','$12$','explanation','This is too large; it typically comes from overcounting exponential factors.'),
    jsonb_build_object('id','C','text','$18$','explanation','Common error from repeatedly multiplying by $3$ without the product-rule structure.'),
    jsonb_build_object('id','D','text','$2$','explanation','Correct: careful differentiation yields $g''''(0)=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'First derivative:\n$$g''''(x)=2x e^{3x}+x^2\\cdot 3e^{3x}=e^{3x}(2x+3x^2).$$\nSecond derivative:\n$$g''''(x)=3e^{3x}(2x+3x^2)+e^{3x}(2+6x)=e^{3x}(2+12x+9x^2).$$\nThus\n$$g''''(0)=e^0\\cdot 2=2.$$',
  recommendation_reasons = ARRAY['Forces careful algebra when differentiating products twice.','Builds reliability on evaluating higher-order derivatives at a point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule + chain rule, then evaluate $g''''(0)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.6',
  section_id = '3.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_HIGHER_ORDER','SK_TABLE_ESTIMATE'],
  primary_skill_id = 'SK_HIGHER_ORDER',
  supporting_skill_ids = ARRAY['SK_TABLE_ESTIMATE'],

  error_tags = ARRAY['E_SYMM_DIFF_DENOM','E_ARITHMETIC_ERROR'],
  prompt = 'A function has values of $f''(x)$ shown below:\n\n$\\begin{array}{c|ccc}\n x & 1.9 & 2.0 & 2.1 \\\\\\hline\n f''(x) & 4.2 & 4.6 & 5.0\n\\end{array}$\n\nUsing a symmetric difference quotient, estimate $f''''(2)$.',
  latex = 'A function has values of $f''(x)$ shown below:\n\n$\\begin{array}{c|ccc}\n x & 1.9 & 2.0 & 2.1 \\\\\\hline\n f''(x) & 4.2 & 4.6 & 5.0\n\\end{array}$\n\nUsing a symmetric difference quotient, estimate $f''''(2)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','Not consistent with the symmetric quotient using points equidistant from $2$.'),
    jsonb_build_object('id','B','text','$8$','explanation','This would occur if you mistakenly divided by $0.1$ instead of $0.2$.'),
    jsonb_build_object('id','C','text','$4$','explanation','Correct: $\\dfrac{5.0-4.2}{2.1-1.9}=\\dfrac{0.8}{0.2}=4$.'),
    jsonb_build_object('id','D','text','$0.8$','explanation','This is the numerator change $5.0-4.2$ but you must divide by $0.2$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Estimate $f''''(2)$ by the symmetric difference on $f''$:\n$$f''''(2)\\approx \\frac{f''(2.1)-f''(1.9)}{2.1-1.9}=\\frac{5.0-4.2}{0.2}=\\frac{0.8}{0.2}=4.$$',
  recommendation_reasons = ARRAY['Connects $f''''$ to the rate of change of $f''$ using numerical data.','Targets the common denominator mistake in symmetric differences.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpreting $f''''(2)$ as the slope of $f''$ near $x=2$.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.6',
  section_id = '3.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONCAVITY_FROM_FPRIME','SK_HIGHER_ORDER'],
  primary_skill_id = 'SK_CONCAVITY_FROM_FPRIME',
  supporting_skill_ids = ARRAY['SK_HIGHER_ORDER'],

  error_tags = ARRAY['E_CONCAVITY_MISREAD','E_CONCAVITY_FROM_FPRIME_CONFUSION'],
  prompt = 'Use the graph of $f''(x)$ to determine where $f$ is concave down. (See image.)',
  latex = 'Use the graph of $f''(x)$ to determine where $f$ is concave down.\n\n[[image: 3.6-P5.png]]',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-2,1)$','explanation','Correct: $f$ is concave down where $f''(x)$ is decreasing (so $f''''(x)<0$). On the graph, $f''(x)$ is decreasing on $(-2,2)$, so $(-2,1)$ is fully contained there.'),
    jsonb_build_object('id','B','text','$(1,3)$','explanation','This interval crosses the point where $f''(x)$ changes from decreasing to increasing, so concavity is not consistent on the whole interval.'),
    jsonb_build_object('id','C','text','$(3,4)$','explanation','On this interval the graph of $f''(x)$ is increasing, so $f$ is concave up.'),
    jsonb_build_object('id','D','text','$(-2,4)$','explanation','The graph of $f''(x)$ is not decreasing over the entire domain shown.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$f$ is concave down where $f''''(x)<0$, i.e., where $f''(x)$ is decreasing. From the graph, $f''(x)$ decreases on $(-2,2)$ and increases on $(2,4)$. Among the choices, the interval fully contained in the decreasing region is $(-2,1)$.',
  recommendation_reasons = ARRAY['Strengthens concavity reasoning using $f''$ monotonicity (AP common skill).','Targets confusion between sign of $f''$ and increasing/decreasing of $f''$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required. Focus: concavity from the behavior (increasing/decreasing) of $f''(x)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.6-P5';

END $block$;
