-- Unit 3 — Unit Test (Questions 1–20)

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_CHAIN_RULE','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_CHAIN_RULE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],

  error_tags = ARRAY['E_FORGET_INNER_DERIVATIVE','E_ALGEBRA_SIMPLIFICATION'],
  prompt = 'Let $f(x)=(3x-2)^7$. What is $f''(x)$?',
  latex = 'Let $f(x)=(3x-2)^7$. What is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$21(3x-2)^6$','explanation','This is correct. Apply the chain rule: $7(3x-2)^6\\cdot 3=21(3x-2)^6$.'),
    jsonb_build_object('id','B','text','$7(3x-2)^6$','explanation','This omits the inner derivative $\\frac{d}{dx}(3x-2)=3$.'),
    jsonb_build_object('id','C','text','$63(3x-2)^6$','explanation','This multiplies by the inner derivative twice.'),
    jsonb_build_object('id','D','text','$21(3x-2)^7$','explanation','This incorrectly keeps the exponent $7$ after differentiating.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use the chain rule:
$$f''(x)=7(3x-2)^6\\cdot 3=21(3x-2)^6.$$',
  recommendation_reasons = ARRAY['Builds chain rule fluency on power composites.','Targets the common mistake of forgetting the inner derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: chain rule with linear inner function.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_CHAIN_RULE','SK_PRODUCT_RULE','SK_TRIG_DERIVATIVES'],
  primary_skill_id = 'SK_CHAIN_RULE',
  supporting_skill_ids = ARRAY['SK_PRODUCT_RULE', 'SK_TRIG_DERIVATIVES'],
 'SK_TRIG_DERIVATIVES'],'SK_TRIG_DERIVATIVES'],
  error_tags = ARRAY['E_FORGET_INNER_DERIVATIVE','E_WRONG_RULE_SELECTION'],
  prompt = 'Find $\\frac{d}{dx}\\left[x^2\\sin(5x)\\right]$.',
  latex = 'Find $\\frac{d}{dx}\\left[x^2\\sin(5x)\\right]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2x\\sin(5x)+x^2\\cos(5x)$','explanation','This misses the chain factor $5$ when differentiating $\\sin(5x)$.'),
    jsonb_build_object('id','B','text','$2x\\sin(5x)+5x^2\\cos(5x)$','explanation','This is correct: product rule plus chain rule on $\\sin(5x)$.'),
    jsonb_build_object('id','C','text','$2x\\cos(5x)+5x^2\\sin(5x)$','explanation','This differentiates $\\sin$ incorrectly and swaps sine/cosine roles.'),
    jsonb_build_object('id','D','text','$x^2\\cos(5x)$','explanation','This ignores the derivative of $x^2$ (product rule not applied).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use product rule:
$$(x^2)''\\sin(5x)+x^2(\\sin(5x))''=2x\\sin(5x)+x^2\\big(\\cos(5x)\\cdot 5\\big)=2x\\sin(5x)+5x^2\\cos(5x).$$',
  recommendation_reasons = ARRAY['Reinforces combining product and chain rules.','Targets the frequent omission of the chain factor on trig composites.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with composite trig factor.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_IMPLICIT_DIFFERENTIATION','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_IMPLICIT_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],

  error_tags = ARRAY['E_IMPLICIT_DIFF_ERROR','E_SIGN_ERROR'],
  prompt = 'Given $x^2+y^2=25$, find $\\frac{dy}{dx}$ in terms of $x$ and $y$.',
  latex = 'Given $x^2+y^2=25$, find $\\frac{dy}{dx}$ in terms of $x$ and $y$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\frac{x}{y}$','explanation','This is correct: $2x+2y\\frac{dy}{dx}=0\\Rightarrow \\frac{dy}{dx}=-\\frac{x}{y}$.'),
    jsonb_build_object('id','B','text','$-\\frac{y}{x}$','explanation','This inverts the ratio when solving for $\\frac{dy}{dx}$.'),
    jsonb_build_object('id','C','text','$\\frac{x}{y}$','explanation','This drops the negative sign when isolating $\\frac{dy}{dx}$.'),
    jsonb_build_object('id','D','text','$-\\frac{2x}{y}$','explanation','This mishandles the common factor $2$ when solving.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate implicitly:
$$2x+2y\\frac{dy}{dx}=0\\Rightarrow \\frac{dy}{dx}=-\\frac{x}{y}.$$',
  recommendation_reasons = ARRAY['Builds the standard implicit-differentiation pattern on a circle.','Targets sign and solving-for-derivative errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: implicit differentiation and careful algebra.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INVERSE_FUNCTION_DERIVATIVE','SK_CHAIN_RULE'],
  primary_skill_id = 'SK_INVERSE_FUNCTION_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE'],

  error_tags = ARRAY['E_INVERSE_DERIVATIVE_MISUSE','E_SIGN_ERROR'],
  prompt = 'If $f(2)=7$ and $f''(2)=-4$, what is $(f^{-1})''(7)$?',
  latex = 'If $f(2)=7$ and $f''(2)=-4$, what is $(f^{-1})''(7)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-4$','explanation','This is $f''(2)$, not the derivative of the inverse at $7$.'),
    jsonb_build_object('id','B','text','$\\frac{1}{4}$','explanation','This takes a reciprocal but loses the negative sign.'),
    jsonb_build_object('id','C','text','$-\\frac{1}{4}$','explanation','This is correct: $(f^{-1})''(7)=\\frac{1}{f''(2)}$ because $f(2)=7$.'),
    jsonb_build_object('id','D','text','$\\frac{1}{7}$','explanation','This uses the output value $7$ instead of the derivative value.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use $(f^{-1})''(f(a))=\\frac{1}{f''(a)}$. Since $f(2)=7$,
$$(f^{-1})''(7)=\\frac{1}{f''(2)}=\\frac{1}{-4}=-\\frac{1}{4}.$$',
  recommendation_reasons = ARRAY['Reinforces the inverse-derivative reciprocal relationship at matching inputs.','Targets common sign and input-matching mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: inverse derivative at a point.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_INVERSE_FUNCTION_DERIVATIVE','SK_TANGENT_SLOPE_INTERPRETATION'],
  primary_skill_id = 'SK_INVERSE_FUNCTION_DERIVATIVE',
  supporting_skill_ids = ARRAY['SK_TANGENT_SLOPE_INTERPRETATION'],

  error_tags = ARRAY['E_INVERSE_DERIVATIVE_MISUSE','E_SIGN_ERROR'],
  prompt = 'Use the graph of $y=f(x)$ and its tangent line at $(1,2)$ (see image). What is $(f^{-1})''(2)$?',
  latex = 'Use the graph of $y=f(x)$ and its tangent line at $(1,2)$ (see image). What is $(f^{-1})''(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2$','explanation','This is the slope of $f$ at $x=1$, not the slope of the inverse.'),
    jsonb_build_object('id','B','text','$2$','explanation','This ignores the reciprocal relationship.'),
    jsonb_build_object('id','C','text','$-\\frac{1}{2}$','explanation','This is correct: $(f^{-1})''(2)=\\frac{1}{f''(1)}$ and the tangent slope shown is $f''(1)=-2$.'),
    jsonb_build_object('id','D','text','$\\frac{1}{2}$','explanation','This takes the reciprocal but ignores the negative slope.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'From the tangent line in the image, $f''(1)=-2$ and $f(1)=2$. Therefore,
$$(f^{-1})''(2)=\\frac{1}{f''(1)}=\\frac{1}{-2}=-\\frac{1}{2}.$$',
  recommendation_reasons = ARRAY['Connects graph-based tangent slope to inverse derivative.','Targets reciprocal-and-sign errors common on AP items.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: tangent slope at (1,2) is -2; use inverse derivative reciprocal.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIVATIVES','SK_CHAIN_RULE'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIVATIVES',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE'],

  error_tags = ARRAY['E_INVERSE_TRIG_FORMULA_CONFUSION','E_FORGET_INNER_DERIVATIVE'],
  prompt = 'Find $\\frac{d}{dx}\\left[\\arctan(3x)\\right]$.',
  latex = 'Find $\\frac{d}{dx}\\left[\\arctan(3x)\\right]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{1+9x^2}$','explanation','This omits the inner derivative factor $3$.'),
    jsonb_build_object('id','B','text','$\\frac{3}{1+9x^2}$','explanation','This is correct: $\\frac{d}{dx}\\arctan(u)=\\frac{u''}{1+u^2}$ with $u=3x$.'),
    jsonb_build_object('id','C','text','$\\frac{3}{\\sqrt{1-9x^2}}$','explanation','This uses the $\\arcsin$ derivative form instead of $\\arctan$.'),
    jsonb_build_object('id','D','text','$\\frac{1}{\\sqrt{1+9x^2}}$','explanation','This is not the derivative formula for $\\arctan$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $u=3x$. Then
$$\\frac{d}{dx}\\arctan(u)=\\frac{u''}{1+u^2}=\\frac{3}{1+9x^2}.$$',
  recommendation_reasons = ARRAY['Builds correct inverse-trig formula selection.','Reinforces chain rule on a linear inner function.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: arctan derivative with chain rule.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q6';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_IMPLICIT_DIFFERENTIATION','SK_INVERSE_TRIG_DERIVATIVES','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_IMPLICIT_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_INVERSE_TRIG_DERIVATIVES', 'SK_ALGEBRA_SIMPLIFY'],
 'SK_ALGEBRA_SIMPLIFY'],'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_IMPLICIT_DIFF_ERROR','E_ALGEBRA_SIMPLIFICATION'],
  prompt = 'If $\\arcsin(y)=x^2-1$, find $\\frac{dy}{dx}$ in terms of $x$ and $y$.',
  latex = 'If $\\arcsin(y)=x^2-1$, find $\\frac{dy}{dx}$ in terms of $x$ and $y$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{2x}{\\sqrt{1-y^2}}$','explanation','This inverts the correct relationship; $\\frac{d}{dx}\\arcsin(y)=\\frac{1}{\\sqrt{1-y^2}}\\frac{dy}{dx}$.'),
    jsonb_build_object('id','B','text','$2x\\sqrt{1-y^2}$','explanation','This is correct: $\\frac{1}{\\sqrt{1-y^2}}\\frac{dy}{dx}=2x\\Rightarrow \\frac{dy}{dx}=2x\\sqrt{1-y^2}$.'),
    jsonb_build_object('id','C','text','$\\frac{2x\\sqrt{1-y^2}}{y}$','explanation','This introduces an extra factor of $y$ that does not appear when solving.'),
    jsonb_build_object('id','D','text','$\\frac{2}{\\sqrt{1-y^2}}$','explanation','This differentiates $x^2-1$ incorrectly and omits the factor $x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate implicitly:
$$\\frac{1}{\\sqrt{1-y^2}}\\frac{dy}{dx}=2x\\Rightarrow \\frac{dy}{dx}=2x\\sqrt{1-y^2}.$$',
  recommendation_reasons = ARRAY['High-value implicit differentiation through inverse trig.','Targets solving-for-derivative and algebra isolation mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: implicit differentiation with inverse trig outer function.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q7';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_PROCEDURE_SELECTION','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_PROCEDURE_SELECTION',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],

  error_tags = ARRAY['E_WRONG_RULE_SELECTION','E_ALGEBRA_SIMPLIFICATION'],
  prompt = 'Which approach is most efficient to differentiate $h(x)=\\frac{(x^2-1)(x^2+1)}{x^2}$?',
  latex = 'Which approach is most efficient to differentiate $h(x)=\\frac{(x^2-1)(x^2+1)}{x^2}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Use the quotient rule directly on the given form.','explanation','This works, but it is not the most efficient because the expression simplifies first.'),
    jsonb_build_object('id','B','text','Use the product rule on $(x^2-1)(x^2+1)$, then divide by $x^2$.','explanation','This still leads to extra algebra compared with simplifying first.'),
    jsonb_build_object('id','C','text','Algebraically simplify $h(x)$ first, then differentiate.','explanation','This is correct: $(x^2-1)(x^2+1)=x^4-1$, so $h(x)=x^2-x^{-2}$ is easy to differentiate.'),
    jsonb_build_object('id','D','text','Use logarithmic differentiation because there is a product and quotient.','explanation','This is unnecessary for a rational expression that simplifies cleanly.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Simplify first:
$$(x^2-1)(x^2+1)=x^4-1,\\quad h(x)=\\frac{x^4-1}{x^2}=x^2-x^{-2}.$$
Then differentiate term-by-term.',
  recommendation_reasons = ARRAY['Builds strategic choice of simplification before applying rules.','Targets unnecessary use of quotient/product rules.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: choose an efficient differentiation strategy.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q8';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_CHAIN_RULE','SK_EXP_LOG_DERIVATIVES'],
  primary_skill_id = 'SK_CHAIN_RULE',
  supporting_skill_ids = ARRAY['SK_EXP_LOG_DERIVATIVES'],

  error_tags = ARRAY['E_FORGET_INNER_DERIVATIVE','E_OUTER_FUNCTION_IGNORED'],
  prompt = 'Find $\\frac{d}{dx}\\left[e^{\\sin x}\\right]$.',
  latex = 'Find $\\frac{d}{dx}\\left[e^{\\sin x}\\right]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$e^{\\sin x}\\sin x$','explanation','This multiplies by the inner function instead of the inner derivative.'),
    jsonb_build_object('id','B','text','$e^{\\sin x}\\cos x$','explanation','This is correct: $\\frac{d}{dx}e^{u}=e^{u}u''$ with $u=\\sin x$.'),
    jsonb_build_object('id','C','text','$e^{\\cos x}$','explanation','This incorrectly replaces the exponent with its derivative.'),
    jsonb_build_object('id','D','text','$\\cos x$','explanation','This differentiates only the exponent and ignores the outer exponential.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $u=\\sin x$. Then
$$\\frac{d}{dx}e^{u}=e^{u}u''=e^{\\sin x}\\cos x.$$',
  recommendation_reasons = ARRAY['Checks chain rule on exponentials with a trig inner function.','Targets the common mistake of differentiating only the exponent.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: chain rule with $e^{u}$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q9';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_IMPLICIT_DIFFERENTIATION','SK_TANGENT_SLOPE_INTERPRETATION'],
  primary_skill_id = 'SK_IMPLICIT_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_TANGENT_SLOPE_INTERPRETATION'],

  error_tags = ARRAY['E_IMPLICIT_DIFF_ERROR','E_PLUG_IN_TOO_EARLY'],
  prompt = 'If $x\\cos y=y^2$ and $(0,0)$ lies on the curve, what is the slope of the tangent line at $(0,0)$?',
  latex = 'If $x\\cos y=y^2$ and $(0,0)$ lies on the curve, what is the slope of the tangent line at $(0,0)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This value is not supported because the slope cannot be found as a finite number at the origin.'),
    jsonb_build_object('id','B','text','$1$','explanation','This confuses $\\cos(0)=1$ with the slope.'),
    jsonb_build_object('id','C','text','$-1$','explanation','There is no justification for a finite negative slope at $(0,0)$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','This is correct: implicit differentiation leads to a contradiction at $(0,0)$, so no finite tangent slope exists there.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Differentiate implicitly:
$$\\frac{d}{dx}(x\\cos y)=\\cos y-x\\sin y\\frac{dy}{dx},\\quad \\frac{d}{dx}(y^2)=2y\\frac{dy}{dx}.$$
So
$$\\cos y-x\\sin y\\frac{dy}{dx}=2y\\frac{dy}{dx}.$$
At $(0,0)$ this becomes $1=0$, impossible for any finite $\\frac{dy}{dx}$. Therefore, a finite tangent slope at $(0,0)$ does not exist.',
  recommendation_reasons = ARRAY['Distinguishes valid point-substitution from situations where the slope is undefined.','Targets the common “plug in too early” error in implicit differentiation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: recognize when an implicit curve does not have a finite tangent slope at a point.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q10';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_HIGHER_ORDER_DERIVATIVES','SK_CHAIN_RULE','SK_TRIG_DERIVATIVES'],
  primary_skill_id = 'SK_HIGHER_ORDER_DERIVATIVES',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE', 'SK_TRIG_DERIVATIVES'],
 'SK_TRIG_DERIVATIVES'],'SK_TRIG_DERIVATIVES'],
  error_tags = ARRAY['E_HIGHER_ORDER_DERIVATIVE_ERROR','E_FORGET_INNER_DERIVATIVE'],
  prompt = 'Let $f(x)=\\cos(2x)$. What is $f''''(x)$?',
  latex = 'Let $f(x)=\\cos(2x)$. What is $f''''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-4\\cos(2x)$','explanation','This is correct: $f''(x)=-2\\sin(2x)$ and $f''''(x)=-4\\cos(2x)$.'),
    jsonb_build_object('id','B','text','$4\\cos(2x)$','explanation','This has a sign error.'),
    jsonb_build_object('id','C','text','$-2\\cos(2x)$','explanation','This misses one factor of $2$ from the chain rule.'),
    jsonb_build_object('id','D','text','$-4\\sin(2x)$','explanation','This uses the wrong trig derivative at the second step.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'First derivative: $f''(x)=-2\\sin(2x)$. Second derivative:
$$f''''(x)=-2\\cos(2x)\\cdot 2=-4\\cos(2x).$$',
  recommendation_reasons = ARRAY['Checks second-derivative mechanics with repeated chain rule.','Targets coefficient and sign errors that compound in higher-order derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: higher-order derivatives with trig composites.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q11';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_PROCEDURE_SELECTION','SK_LOG_DIFFERENTIATION'],
  primary_skill_id = 'SK_PROCEDURE_SELECTION',
  supporting_skill_ids = ARRAY['SK_LOG_DIFFERENTIATION'],

  error_tags = ARRAY['E_WRONG_RULE_SELECTION','E_POWER_RULE_OVERGENERALIZE'],
  prompt = 'Which method is most appropriate to differentiate $y=x^x$ for $x>0$?',
  latex = 'Which method is most appropriate to differentiate $y=x^x$ for $x>0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Power rule','explanation','Not applicable because the exponent is not constant.'),
    jsonb_build_object('id','B','text','Logarithmic differentiation','explanation','This is correct: take $\\ln$ to rewrite as $\\ln y=x\\ln x$.'),
    jsonb_build_object('id','C','text','Quotient rule','explanation','There is no quotient structure in $x^x$.'),
    jsonb_build_object('id','D','text','Derivative of an inverse function','explanation','This is not an inverse-function situation.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Logarithmic differentiation is appropriate because both the base and exponent vary:
$$\\ln y=x\\ln x.$$',
  recommendation_reasons = ARRAY['Builds correct strategy selection before computation.','Prevents misapplication of the power rule to $x^x$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: choosing log differentiation for variable base and exponent.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q12';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_LOG_DIFFERENTIATION','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_LOG_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],

  error_tags = ARRAY['E_MISS_PLUS_ONE_IN_LOG_DIFF','E_FORGET_MULTIPLY_BACK_BY_Y'],
  prompt = 'For $x>0$, if $y=x^x$, what is $\\frac{dy}{dx}$?',
  latex = 'For $x>0$, if $y=x^x$, what is $\\frac{dy}{dx}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x^{x-1}$','explanation','This treats the exponent as constant, which is not valid here.'),
    jsonb_build_object('id','B','text','$x^x(\\ln x+1)$','explanation','This is correct: $\\frac{1}{y}\\frac{dy}{dx}=\\ln x+1$.'),
    jsonb_build_object('id','C','text','$x^x\\ln x$','explanation','This misses the $+1$ from differentiating $x\\ln x$.'),
    jsonb_build_object('id','D','text','$\\ln x+1$','explanation','This forgets to multiply by $y=x^x$ after differentiating $\\ln y$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Take logs: $\\ln y=x\\ln x$. Differentiate:
$$\\frac{1}{y}\\frac{dy}{dx}=\\ln x+1\\Rightarrow \\frac{dy}{dx}=x^x(\\ln x+1).$$',
  recommendation_reasons = ARRAY['High-frequency AP item: executing log differentiation.','Targets missing $+1$ and forgetting to multiply back by $y$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: correct execution of log differentiation.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q13';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_IMPLICIT_DIFFERENTIATION','SK_PRODUCT_RULE','SK_TRIG_DERIVATIVES'],
  primary_skill_id = 'SK_IMPLICIT_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_PRODUCT_RULE', 'SK_TRIG_DERIVATIVES'],
 'SK_TRIG_DERIVATIVES'],'SK_TRIG_DERIVATIVES'],
  error_tags = ARRAY['E_IMPLICIT_DIFF_ERROR','E_SIGN_ERROR'],
  prompt = 'Find $\\frac{dy}{dx}$ if $x^2y+\\sin y=3$.',
  latex = 'Find $\\frac{dy}{dx}$ if $x^2y+\\sin y=3$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\frac{2xy}{x^2+\\cos y}$','explanation','This is correct after differentiating and solving for $\\frac{dy}{dx}$.'),
    jsonb_build_object('id','B','text','$\\frac{2xy}{x^2+\\cos y}$','explanation','This has a sign error when moving $2xy$ to the other side.'),
    jsonb_build_object('id','C','text','$-\\frac{2x}{x^2+\\cos y}$','explanation','This drops the factor $y$ from differentiating $x^2y$.'),
    jsonb_build_object('id','D','text','$-\\frac{2xy}{x^2-\\cos y}$','explanation','This mis-differentiates $\\sin y$; it produces $\\cos y\\frac{dy}{dx}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$(x^2y)''=2xy+x^2\\frac{dy}{dx},\\quad (\\sin y)''=\\cos y\\frac{dy}{dx}.$$
So
$$2xy+(x^2+\\cos y)\\frac{dy}{dx}=0\\Rightarrow \\frac{dy}{dx}=-\\frac{2xy}{x^2+\\cos y}.$$',
  recommendation_reasons = ARRAY['Combines implicit differentiation with product and chain rules.','Targets sign and missing-factor mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: implicit differentiation with mixed algebraic and trig terms.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q14';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIVATIVES'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIVATIVES',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_INVERSE_TRIG_FORMULA_CONFUSION','E_SIGN_ERROR'],
  prompt = 'Find $\\frac{d}{dx}\\left[\\arccos x\\right]$.',
  latex = 'Find $\\frac{d}{dx}\\left[\\arccos x\\right]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{\\sqrt{1-x^2}}$','explanation','This is the derivative of $\\arcsin x$, not $\\arccos x$.'),
    jsonb_build_object('id','B','text','$-\\frac{1}{\\sqrt{1-x^2}}$','explanation','This is correct: $\\frac{d}{dx}(\\arccos x)=-\\frac{1}{\\sqrt{1-x^2}}$.'),
    jsonb_build_object('id','C','text','$\\frac{1}{1+x^2}$','explanation','This is the derivative of $\\arctan x$.'),
    jsonb_build_object('id','D','text','$-\\frac{1}{1+x^2}$','explanation','This is not a correct inverse-trig derivative formula here.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Recall the standard derivative:
$$\\frac{d}{dx}(\\arccos x)=-\\frac{1}{\\sqrt{1-x^2}}.$$',
  recommendation_reasons = ARRAY['Reinforces the sign in $\\arccos$ derivative.','Targets the common $\\arcsin$ vs $\\arccos$ confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: inverse trig derivative formulas.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q15';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 155,
  skill_tags = ARRAY['SK_CHAIN_RULE','SK_INVERSE_TRIG_DERIVATIVES'],
  primary_skill_id = 'SK_CHAIN_RULE',
  supporting_skill_ids = ARRAY['SK_INVERSE_TRIG_DERIVATIVES'],

  error_tags = ARRAY['E_FORGET_INNER_DERIVATIVE','E_WRONG_SUBSTITUTION_IN_DENOMINATOR'],
  prompt = 'Find $\\frac{d}{dx}\\left[\\arcsin(x^3)\\right]$.',
  latex = 'Find $\\frac{d}{dx}\\left[\\arcsin(x^3)\\right]$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{\\sqrt{1-x^6}}$','explanation','This forgets the inner derivative of $x^3$.'),
    jsonb_build_object('id','B','text','$\\frac{3x^2}{\\sqrt{1-x^6}}$','explanation','This is correct: $\\frac{u''}{\\sqrt{1-u^2}}$ with $u=x^3$.'),
    jsonb_build_object('id','C','text','$\\frac{3x^2}{\\sqrt{1-x^2}}$','explanation','This uses $1-x^2$ instead of $1-(x^3)^2$.'),
    jsonb_build_object('id','D','text','$-\\frac{3x^2}{\\sqrt{1-x^6}}$','explanation','This incorrectly introduces a negative sign.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $u=x^3$. Then $u''=3x^2$ and
$$\\frac{d}{dx}\\arcsin(u)=\\frac{u''}{\\sqrt{1-u^2}}=\\frac{3x^2}{\\sqrt{1-x^6}}.$$',
  recommendation_reasons = ARRAY['Builds composite inverse-trig differentiation accuracy.','Targets denominator substitution errors and missing chain factors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: arcsin derivative with nonlinear inner function.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q16';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_IMPLICIT_DIFFERENTIATION','SK_TANGENT_SLOPE_INTERPRETATION','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_IMPLICIT_DIFFERENTIATION',
  supporting_skill_ids = ARRAY['SK_TANGENT_SLOPE_INTERPRETATION', 'SK_ALGEBRA_SIMPLIFY'],
 'SK_ALGEBRA_SIMPLIFY'],'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_IMPLICIT_DIFF_ERROR','E_ARITHMETIC_SUBSTITUTION_ERROR'],
  prompt = 'The curve is $x^2+xy+y^2=7$ with the point $(2,1)$ marked (see image). What is the slope of the tangent line at $(2,1)$?',
  latex = 'The curve is $x^2+xy+y^2=7$ with the point $(2,1)$ marked (see image). What is the slope of the tangent line at $(2,1)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\frac{5}{4}$','explanation','This is correct after implicit differentiation and substitution.'),
    jsonb_build_object('id','B','text','$-\\frac{4}{5}$','explanation','This is a reciprocal error when solving for $\\frac{dy}{dx}$.'),
    jsonb_build_object('id','C','text','$\\frac{5}{4}$','explanation','This has a sign error; the slope is negative at $(2,1)$.'),
    jsonb_build_object('id','D','text','$-\\frac{3}{4}$','explanation','This comes from an arithmetic error when substituting $(2,1)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$2x+\\frac{d}{dx}(xy)+2y\\frac{dy}{dx}=0,\\quad \\frac{d}{dx}(xy)=y+x\\frac{dy}{dx}.$$
So
$$(2x+y)+(x+2y)\\frac{dy}{dx}=0.$$
At $(2,1)$:
$$5+4\\frac{dy}{dx}=0\\Rightarrow \\frac{dy}{dx}=-\\frac{5}{4}.$$',
  recommendation_reasons = ARRAY['AP-staple: tangent slope via implicit differentiation at a point.','Targets reciprocal and substitution arithmetic errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: curve and marked point (2,1).',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q17';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_PROCEDURE_SELECTION','SK_CHAIN_RULE','SK_QUOTIENT_RULE'],
  primary_skill_id = 'SK_PROCEDURE_SELECTION',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE', 'SK_QUOTIENT_RULE'],
 'SK_QUOTIENT_RULE'],'SK_QUOTIENT_RULE'],
  error_tags = ARRAY['E_WRONG_RULE_SELECTION','E_INNER_DERIVATIVE_MISSING_IN_LOG'],
  prompt = 'To differentiate $p(x)=\\frac{\\ln(1+x^2)}{x}$, which set of rules is necessary in a straightforward approach?',
  latex = 'To differentiate $p(x)=\\frac{\\ln(1+x^2)}{x}$, which set of rules is necessary in a straightforward approach?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Only the power rule','explanation','Not sufficient; there is a quotient and a composite logarithm.'),
    jsonb_build_object('id','B','text','Quotient rule and chain rule','explanation','This is correct: quotient rule for division by $x$, chain rule for $\\ln(1+x^2)$.'),
    jsonb_build_object('id','C','text','Product rule only','explanation','Even if rewritten as $x^{-1}\\ln(1+x^2)$, you still need chain rule for the log.'),
    jsonb_build_object('id','D','text','Implicit differentiation','explanation','Unnecessary; $p(x)$ is explicitly defined.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A direct method treats $p(x)$ as a quotient and differentiates the numerator using chain rule for $\\ln(1+x^2)$.',
  recommendation_reasons = ARRAY['Builds rule-selection skill on composite quotients.','Targets missing chain rule when differentiating logarithms of inner functions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify needed rules before differentiating.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q18';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_HIGHER_ORDER_DERIVATIVES'],
  primary_skill_id = 'SK_HIGHER_ORDER_DERIVATIVES',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_HIGHER_ORDER_DERIVATIVE_ERROR','E_STOPPED_TOO_EARLY'],
  prompt = 'If $y=x^3$, what is $\\frac{d^2y}{dx^2}$?',
  latex = 'If $y=x^3$, what is $\\frac{d^2y}{dx^2}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3x^2$','explanation','This is $\\frac{dy}{dx}$, not $\\frac{d^2y}{dx^2}$.'),
    jsonb_build_object('id','B','text','$6x$','explanation','This is correct: $\\frac{d^2y}{dx^2}=6x$.'),
    jsonb_build_object('id','C','text','$6x^2$','explanation','This differentiates $3x^2$ incorrectly.'),
    jsonb_build_object('id','D','text','$6$','explanation','This differentiates one extra time.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate twice:
$$\\frac{dy}{dx}=3x^2,\\quad \\frac{d^2y}{dx^2}=6x.$$',
  recommendation_reasons = ARRAY['Baseline check of second-derivative computation.','Targets the common mistake of stopping after the first derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute a second derivative accurately.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q19';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_HIGHER_ORDER_DERIVATIVES','SK_IMPLICIT_DIFFERENTIATION','SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_HIGHER_ORDER_DERIVATIVES',
  supporting_skill_ids = ARRAY['SK_IMPLICIT_DIFFERENTIATION', 'SK_ALGEBRA_SIMPLIFY'],
 'SK_ALGEBRA_SIMPLIFY'],'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_HIGHER_ORDER_DERIVATIVE_ERROR','E_DEPENDENT_VARIABLE_CHAIN_MISSED'],
  prompt = 'Given $y^2=x$, find $\\frac{d^2y}{dx^2}$ in terms of $y$.',
  latex = 'Given $y^2=x$, find $\\frac{d^2y}{dx^2}$ in terms of $y$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\frac{1}{2y^3}$','explanation','This has the correct sign but the coefficient is incorrect.'),
    jsonb_build_object('id','B','text','$\\frac{1}{4y^3}$','explanation','This has the wrong sign.'),
    jsonb_build_object('id','C','text','$-\\frac{1}{4y^3}$','explanation','This is correct: differentiate $\\frac{dy}{dx}=\\frac{1}{2y}$ using chain rule with $y=y(x)$.'),
    jsonb_build_object('id','D','text','$-\\frac{1}{4y^2}$','explanation','This treats $y$ as a constant when differentiating $\\frac{1}{2y}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate $y^2=x$:
$$2y\\frac{dy}{dx}=1\\Rightarrow \\frac{dy}{dx}=\\frac{1}{2y}.$$
Differentiate again:
$$\\frac{d^2y}{dx^2}=\\frac{d}{dx}\\left(\\frac{1}{2}y^{-1}\\right)=\\frac{1}{2}(-1)y^{-2}\\frac{dy}{dx}=-\\frac{1}{2y^2}\\cdot\\frac{1}{2y}=-\\frac{1}{4y^3}.$$',
  recommendation_reasons = ARRAY['AP-level: second derivative from an implicit relationship.','Targets the mistake of treating $y$ as constant when differentiating again.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: second derivative via implicit differentiation and chain rule.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.0-UT-Q20';
