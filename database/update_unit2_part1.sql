
-- Unit 2.1 (Defining Average and Instantaneous Rates of Change at a Point) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  section_id = '2.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_AVG_ROC', 'SK_SLOPE_2PTS', 'SK_FUNC_EVAL'],
  primary_skill_id = 'SK_AVG_ROC',
  supporting_skill_ids = ARRAY['SK_SLOPE_2PTS', 'SK_FUNC_EVAL'],
  error_tags = ARRAY['E_SWAP_X_IN_SLOPE', 'E_AVG_VS_INST'],
  prompt = 'Let $f$ be a function with $f(1)=3$ and $f(5)=-1$. What is the average rate of change of $f$ on the interval $[1,5]$?',
  latex = 'Let $f$ be a function with $f(1)=3$ and $f(5)=-1$. What is the average rate of change of $f$ on the interval $[1,5]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This would come from using $f(1)-f(5)$ in the numerator but not matching the denominator sign correctly.'),
    jsonb_build_object('id','B','text','$-1$','explanation','This is $\\dfrac{-1-3}{4}=-1$.'),
    jsonb_build_object('id','C','text','$-4$','explanation','This incorrectly uses $f(5)-f(1)$ but forgets to divide by $5-1$.'),
    jsonb_build_object('id','D','text','$4$','explanation','This incorrectly uses $f(1)-f(5)=4$ without dividing by the interval length.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Average rate of change on $[1,5]$ is
$$\\frac{f(5)-f(1)}{5-1}=\\frac{-1-3}{4}=\\frac{-4}{4}=-1.$$',
  recommendation_reasons = ARRAY['Builds correct setup for slope over an interval.', 'Targets common sign and order mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute average rate of change as a secant slope on an interval.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  section_id = '2.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INST_ROC', 'SK_LIMIT_INTUITION'],
  primary_skill_id = 'SK_INST_ROC',
  supporting_skill_ids = ARRAY['SK_LIMIT_INTUITION'],
  error_tags = ARRAY['E_AVG_VS_INST', 'E_PLUG_H_EQUALS_0'],
  prompt = 'A car’s position (in meters) is given by $s(t)$. Which expression best represents the instantaneous velocity at $t=4$ (in m/s)?',
  latex = 'A car’s position (in meters) is given by $s(t)$. Which expression best represents the instantaneous velocity at $t=4$ (in m/s)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{s(5)-s(3)}{2}$','explanation','This is an average velocity on $[3,5]$, not instantaneous at $t=4$.'),
    jsonb_build_object('id','B','text','$\\dfrac{s(4)-s(0)}{4}$','explanation','This is an average velocity on $[0,4]$.'),
    jsonb_build_object('id','C','text','$\\lim_{h\\to 0}\\dfrac{s(4+h)-s(4)}{h}$','explanation','This is the limit definition of instantaneous velocity at $t=4$.'),
    jsonb_build_object('id','D','text','$\\dfrac{s(4+0)-s(4)}{0}$','explanation','Substituting $h=0$ creates division by zero; you must take a limit.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Instantaneous velocity is the derivative $s''(4)$, defined by
$$s''(4)=\\lim_{h\\to 0}\\frac{s(4+h)-s(4)}{h}.$$',
  recommendation_reasons = ARRAY['Reinforces correct definition structure for instantaneous rate.', 'Directly addresses the common $h=0$ misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify instantaneous rate of change as a limit of average rates.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  section_id = '2.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_AVG_ROC', 'SK_INEQUALITY_REASONING'],
  primary_skill_id = 'SK_AVG_ROC',
  supporting_skill_ids = ARRAY['SK_INEQUALITY_REASONING'],
  error_tags = ARRAY['E_AVG_VS_INST', 'E_SIGN_IN_DIFF_QUOTIENT'],
  prompt = 'Suppose $f$ is differentiable on $[2,6]$ and you know that $-3\\le f''(x)\\le 1$ for all $x$ in $(2,6)$. Which statement must be true about the average rate of change of $f$ on $[2,6]$?',
  latex = 'Suppose $f$ is differentiable on $[2,6]$ and you know that $-3\\le f''(x)\\le 1$ for all $x$ in $(2,6)$. Which statement must be true about the average rate of change of $f$ on $[2,6]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The average rate of change on $[2,6]$ is exactly $-1$.','explanation','The derivative bounds do not force a single exact average slope.'),
    jsonb_build_object('id','B','text','The average rate of change on $[2,6]$ is less than $-3$.','explanation','It cannot be less than the minimum possible slope bound.'),
    jsonb_build_object('id','C','text','The average rate of change on $[2,6]$ is between $-3$ and $1$, inclusive.','explanation','The average slope must lie within the derivative bounds.'),
    jsonb_build_object('id','D','text','The average rate of change on $[2,6]$ is greater than $1$.','explanation','It cannot exceed the maximum possible slope bound.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Since $f$ is differentiable and $-3\\le f''(x)\\le 1$ on $(2,6)$, the average rate of change
$$\\frac{f(6)-f(2)}{6-2}$$
must lie in the interval $[-3,1]$.',
  recommendation_reasons = ARRAY['Connects derivative-as-slope to global change over an interval.', 'Builds inequality reasoning common in AP questions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: average slope (secant) must be consistent with slope bounds.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  section_id = '2.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_SLOPE_2PTS', 'SK_AVG_ROC'],
  primary_skill_id = 'SK_SLOPE_2PTS',
  supporting_skill_ids = ARRAY['SK_AVG_ROC'],
  error_tags = ARRAY['E_SWAP_X_IN_SLOPE'],
  prompt = 'The function $g$ is linear and passes through $(2,7)$ and $(6,1)$. What is the average rate of change of $g$ on $[2,6]$?',
  latex = 'The function $g$ is linear and passes through $(2,7)$ and $(6,1)$. What is the average rate of change of $g$ on $[2,6]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{3}{2}$','explanation','This comes from using $\\dfrac{7-1}{6-2}$ but forgetting the sign.'),
    jsonb_build_object('id','B','text','$-\\dfrac{3}{2}$','explanation','This is $\\dfrac{1-7}{6-2}=-\\dfrac{6}{4}=-\\dfrac{3}{2}$.'),
    jsonb_build_object('id','C','text','$-3$','explanation','This incorrectly divides by $2$ instead of $4$.'),
    jsonb_build_object('id','D','text','$3$','explanation','This ignores the negative change in $y$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Average rate of change on $[2,6]$ is the secant slope:
$$\\frac{g(6)-g(2)}{6-2}=\\frac{1-7}{4}=-\\frac{3}{2}.$$',
  recommendation_reasons = ARRAY['Fast check of slope computation.', 'Reinforces sign awareness.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: for linear functions, average rate of change equals constant slope.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.1',
  section_id = '2.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INST_ROC', 'SK_SYMBOL_INTERPRET'],
  primary_skill_id = 'SK_INST_ROC',
  supporting_skill_ids = ARRAY['SK_SYMBOL_INTERPRET'],
  error_tags = ARRAY['E_AVG_VS_INST'],
  prompt = 'For a differentiable function $f$, which statement is always true?',
  latex = 'For a differentiable function $f$, which statement is always true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The instantaneous rate of change at $x=a$ equals the average rate of change on every interval $[a,a+h]$.','explanation','This would only hold for special functions (for example, linear), not always.'),
    jsonb_build_object('id','B','text','The average rate of change on $[a,a+h]$ equals $f''(a+h)$ for all small $h$.','explanation','Average slope over an interval does not always equal the derivative at the right endpoint.'),
    jsonb_build_object('id','C','text','If the limit $\\lim_{h\\to 0}\\dfrac{f(a+h)-f(a)}{h}$ exists, it equals $f''(a)$.','explanation','This is precisely the definition of the derivative.'),
    jsonb_build_object('id','D','text','If $f$ is differentiable at $a$, then $\\dfrac{f(a+h)-f(a)}{h}=f''(a)$ for $h\\ne 0$.','explanation','Differentiability gives a limit, not equality for each nonzero $h$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'By definition, the derivative at $x=a$ is
$$f''(a)=\\lim_{h\\to 0}\\frac{f(a+h)-f(a)}{h}$$
provided the limit exists.',
  recommendation_reasons = ARRAY['Checks conceptual clarity between average and instantaneous rate.', 'Matches common AP wording patterns.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derivative is a limit statement; do not confuse with secant slopes for nonzero $h$.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.1-P5';



-- Unit 2.2 (Defining the Derivative of a Function and Using Derivative Notation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  section_id = '2.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DERIV_NOTATION', 'SK_SYMBOL_INTERPRET'],
  primary_skill_id = 'SK_DERIV_NOTATION',
  supporting_skill_ids = ARRAY['SK_SYMBOL_INTERPRET'],
  error_tags = ARRAY['E_MISREAD_DERIV_NOTATION'],
  prompt = 'If $y=f(x)$, which notation correctly represents the derivative of $f$ with respect to $x$ evaluated at $x=3$?',
  latex = 'If $y=f(x)$, which notation correctly represents the derivative of $f$ with respect to $x$ evaluated at $x=3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f''(3)$','explanation','This is the standard notation for the derivative evaluated at $x=3$.'),
    jsonb_build_object('id','B','text','$f(3)''$','explanation','This is not standard; the prime applies to the function, not to the value written this way.'),
    jsonb_build_object('id','C','text','$\\dfrac{dy}{dx}=3$','explanation','This sets the derivative equal to 3 without any information; it is not an evaluation notation.'),
    jsonb_build_object('id','D','text','$\\dfrac{df}{d3}$','explanation','The denominator should be $dx$, not a number.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The derivative of $f$ evaluated at $x=3$ is written $f''(3)$. An equivalent form is $\\left.\\dfrac{dy}{dx}\\right|_{x=3}$ when $y=f(x)$.',
  recommendation_reasons = ARRAY['Locks in correct derivative-evaluation notation used throughout AP.', 'Targets common symbol-reading mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: correct reading/writing of derivative notation at a point.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  section_id = '2.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LIMIT_DEF_DERIV', 'SK_DIFF_QUOTIENT', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_LIMIT_DEF_DERIV',
  supporting_skill_ids = ARRAY['SK_DIFF_QUOTIENT', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_PLUG_H_EQUALS_0', 'E_CANCEL_INCORRECTLY'],
  prompt = 'Use the limit definition to find $f''(2)$ for $f(x)=x^2-4x$.',
  latex = 'Use the limit definition to find $f''(2)$ for $f(x)=x^2-4x$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This is the correct result: the tangent slope at $x=2$ is zero.'),
    jsonb_build_object('id','B','text','$-4$','explanation','This can come from plugging $h=0$ too early or mishandling terms.'),
    jsonb_build_object('id','C','text','$4$','explanation','This often results from a sign error when expanding $f(2+h)$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Polynomials are differentiable everywhere, so the derivative exists at $x=2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute using the limit definition:
$$f(2)=2^2-4\\cdot 2=4-8=-4,$$
$$f(2+h)=(2+h)^2-4(2+h)=4+4h+h^2-8-4h=h^2-4.$$
So
$$\\frac{f(2+h)-f(2)}{h}=\\frac{(h^2-4)-(-4)}{h}=\\frac{h^2}{h}=h,$$
and
$$f''(2)=\\lim_{h\\to 0}h=0.$$',
  recommendation_reasons = ARRAY['Core skill: execute the limit definition cleanly.', 'Practices safe cancellation only after factoring.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: limit definition at a point with algebraic simplification.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  section_id = '2.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_LIMIT_DEF_DERIV', 'SK_ALGEBRA_SIMPLIFY', 'SK_DIFF_QUOTIENT'],
  primary_skill_id = 'SK_LIMIT_DEF_DERIV',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY', 'SK_DIFF_QUOTIENT'],
  error_tags = ARRAY['E_CANCEL_INCORRECTLY', 'E_SIGN_IN_DIFF_QUOTIENT'],
  prompt = 'Let $f(x)=\\sqrt{x}$. Which expression is equal to $f''(a)$ for $a>0$ using the limit definition, after simplifying to remove radicals from the denominator?',
  latex = 'Let $f(x)=\\sqrt{x}$. Which expression is equal to $f''(a)$ for $a>0$ using the limit definition, after simplifying to remove radicals from the denominator?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\lim_{h\\to 0}\\dfrac{\\sqrt{a+h}+\\sqrt{a}}{h}$','explanation','This is not equivalent; rationalization requires multiplying numerator and denominator, not replacing terms.'),
    jsonb_build_object('id','B','text','$\\lim_{h\\to 0}\\dfrac{1}{\\sqrt{a+h}-\\sqrt{a}}$','explanation','This inverts the expression incorrectly.'),
    jsonb_build_object('id','C','text','$\\lim_{h\\to 0}\\dfrac{1}{\\sqrt{a+h}+\\sqrt{a}}$','explanation','After rationalizing, the expression becomes $\\dfrac{1}{\\sqrt{a+h}+\\sqrt{a}}$.'),
    jsonb_build_object('id','D','text','$\\lim_{h\\to 0}\\dfrac{\\sqrt{a+h}-\\sqrt{a}}{\\sqrt{a+h}+\\sqrt{a}}$','explanation','This omits the necessary $h$ factor cancellation step and is not equal to the derivative expression.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Start with
$$f''(a)=\\lim_{h\\to 0}\\frac{\\sqrt{a+h}-\\sqrt{a}}{h}.$$
Multiply by the conjugate:
$$\\frac{\\sqrt{a+h}-\\sqrt{a}}{h}\\cdot\\frac{\\sqrt{a+h}+\\sqrt{a}}{\\sqrt{a+h}+\\sqrt{a}}
=\\frac{(a+h)-a}{h(\\sqrt{a+h}+\\sqrt{a})}
=\\frac{1}{\\sqrt{a+h}+\\sqrt{a}}.$$
Thus
$$f''(a)=\\lim_{h\\to 0}\\frac{1}{\\sqrt{a+h}+\\sqrt{a}}.$$',
  recommendation_reasons = ARRAY['High-frequency AP manipulation with radicals and limits.', 'Targets conjugate technique and careful cancellation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rationalize within the limit definition to eliminate radicals.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  section_id = '2.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_SYMBOL_INTERPRET'],
  primary_skill_id = 'SK_SYMBOL_INTERPRET',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_MISREAD_DERIV_NOTATION'],
  prompt = 'If $f''(5)=-2$, which statement is correct?',
  latex = 'If $f''(5)=-2$, which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The tangent line to $y=f(x)$ at $x=5$ has slope $-2$.','explanation','This is exactly what $f''(5)=-2$ means.'),
    jsonb_build_object('id','B','text','$f(5)=-2$.','explanation','The derivative value is not the same as the function value.'),
    jsonb_build_object('id','C','text','The secant line from $x=0$ to $x=5$ has slope $-2$.','explanation','A derivative at a point does not determine an average slope over a larger interval.'),
    jsonb_build_object('id','D','text','The function is decreasing for all $x$.','explanation','$f''(5)<0$ only guarantees decreasing behavior near $x=5$, not everywhere.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'By definition, $f''(5)$ is the slope of the tangent line to $y=f(x)$ at $x=5$. Therefore $f''(5)=-2$ means that tangent slope is $-2$.',
  recommendation_reasons = ARRAY['Quick check on the meaning of $f''(a)$.', 'Eliminates common notation misreads.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret $f''(a)$ as a tangent slope (local behavior).',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.2',
  section_id = '2.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_DIFF_QUOTIENT', 'SK_ALGEBRA_SIMPLIFY', 'SK_DERIV_NOTATION'],
  primary_skill_id = 'SK_DIFF_QUOTIENT',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY', 'SK_DERIV_NOTATION'],
  error_tags = ARRAY['E_SIGN_IN_DIFF_QUOTIENT', 'E_CANCEL_INCORRECTLY'],
  prompt = 'For $f(x)=\\dfrac{1}{x}$, evaluate the simplified expression
$$\\frac{f(a+h)-f(a)}{h}$$
for $a\\ne 0$ and $h\\ne 0$, $a+h\\ne 0$.',
  latex = 'For $f(x)=\\dfrac{1}{x}$, evaluate the simplified expression
$$\\frac{f(a+h)-f(a)}{h}$$
for $a\\ne 0$ and $h\\ne 0$, $a+h\\ne 0$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{a(a+h)}$','explanation','This misses the negative sign from $\\frac{1}{a+h}-\\frac{1}{a}$.'),
    jsonb_build_object('id','B','text','$-\\dfrac{1}{a(a+h)}$','explanation','Correct: simplifying yields $-\\dfrac{1}{a(a+h)}$.'),
    jsonb_build_object('id','C','text','$-\\dfrac{h}{a(a+h)}$','explanation','An extra $h$ remains; it should cancel during simplification.'),
    jsonb_build_object('id','D','text','$\\dfrac{a+h-a}{h}$','explanation','This incorrectly treats $f(x)=1/x$ like a linear function.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute the difference quotient:
$$\\frac{f(a+h)-f(a)}{h}=\\frac{\\frac{1}{a+h}-\\frac{1}{a}}{h}
=\\frac{\\frac{a-(a+h)}{a(a+h)}}{h}
=\\frac{\\frac{-h}{a(a+h)}}{h}
=-\\frac{1}{a(a+h)}.$$',
  recommendation_reasons = ARRAY['Prepares for taking the $h\\to 0$ limit for $f''(a)$ later.', 'Trains careful algebra and sign control in difference quotients.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: simplify a rational difference quotient and control signs/cancellation.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.2-P5';

-- Unit 2.3 (Estimating Derivatives of a Function at a Point) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.3',
  section_id = '2.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DERIV_ESTIMATE_NUMERICAL', 'SK_GRAPH_INTERPRETATION'],
  primary_skill_id = 'SK_DERIV_ESTIMATE_NUMERICAL',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION'],
  error_tags = ARRAY['E_SECANT_VS_TANGENT', 'E_SIGN_ERROR'],
  prompt = 'Use the graph (see image) to best estimate ''(2)$. The point (2,f(2))$ is marked on the curve.',
  latex = 'Use the graph (see image) to best estimate ''(2)$. The point (2,f(2))$ is marked on the curve.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','About .2$','explanation','Near =2$, the curve is increasing with a moderate slope a little above $; the best estimate is about .2$.'),
    jsonb_build_object('id','B','text','About /bin/zsh.2$','explanation','This is far too small; the tangent at =2$ is noticeably steeper than /bin/zsh.2$.'),
    jsonb_build_object('id','C','text','About 569Xils1.2$','explanation','The function is increasing at =2$, so the derivative should be positive, not negative.'),
    jsonb_build_object('id','D','text','About .6$','explanation','This overestimates the steepness; the tangent is not that steep at =2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The derivative at a point is the slope of the tangent line. From the graph near =2$, the rise over run over a small interval (e.g., from =1.5$ to =2.5$) suggests an average slope close to .2$.',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Correct: the tangent slope is a little above $.'),
    jsonb_build_object('id','B','text','Too small; the graph rises more than /bin/zsh.2$ per $ unit of $ near $.'),
    jsonb_build_object('id','C','text','Wrong sign; increasing means positive slope.'),
    jsonb_build_object('id','D','text','Too steep for the visible tangent at =2$.')
  ),
  recommendation_reasons = ARRAY['Reinforces that ''(a)$ is the slope of the tangent at =a$.','Builds skill in visual slope estimation (AP-style).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required. Focus: estimating a tangent slope from a graph.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.3',
  section_id = '2.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DERIV_ESTIMATE_NUMERICAL', 'SK_AVG_RATE_CHANGE'],
  primary_skill_id = 'SK_DERIV_ESTIMATE_NUMERICAL',
  supporting_skill_ids = ARRAY['SK_AVG_RATE_CHANGE'],
  error_tags = ARRAY['E_SECANT_VS_TANGENT', 'E_UNITS_MISINTERPRET'],
  prompt = 'A function $ satisfies (3)=10$, (3.1)=10.4$, and (2.9)=9.7$. Using a symmetric difference quotient, estimate ''(3)$.',
  latex = 'A function $ satisfies (3)=10$, (3.1)=10.4$, and (2.9)=9.7$. Using a symmetric difference quotient, estimate ''(3)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','.0$','explanation','This would correspond to a symmetric change of /bin/zsh.6$ over /bin/zsh.2$, but the actual symmetric change is .4-9.7=0.7$.'),
    jsonb_build_object('id','B','text','.5$','explanation','Correct: /(3.1-2.9)=0.7/0.2=3.5$.'),
    jsonb_build_object('id','C','text','.0$','explanation','This mistakenly divides by /bin/zsh.1$ instead of the full symmetric width /bin/zsh.2$.'),
    jsonb_build_object('id','D','text','/bin/zsh.35$','explanation','This mistakenly divides by $ again after already using the full symmetric interval.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use the symmetric difference quotient: 19967f''(3)\approx \frac{f(3+h)-f(3-h)}{2h}.19967 Here =0.1$, so 19967f''(3)\approx \frac{f(3.1)-f(2.9)}{0.2}=\frac{10.4-9.7}{0.2}=\frac{0.7}{0.2}=3.5.19967',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Uses /bin/zsh.6$ instead of the correct symmetric change /bin/zsh.7$.'),
    jsonb_build_object('id','B','text','Correct symmetric quotient: /bin/zsh.7/0.2=3.5$.'),
    jsonb_build_object('id','C','text','Divides by /bin/zsh.1$ rather than /bin/zsh.2$.'),
    jsonb_build_object('id','D','text','Extra factor of $ error.' )
  ),
  recommendation_reasons = ARRAY['Targets AP skill: estimating derivatives from tabular data.','Emphasizes symmetric difference setup and denominator.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: symmetric difference quotient from table values.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.3',
  section_id = '2.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DERIV_ESTIMATE_NUMERICAL', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_DERIV_ESTIMATE_NUMERICAL',
  supporting_skill_ids = ARRAY['SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_SECANT_VS_TANGENT', 'E_SIGN_ERROR'],
  prompt = 'Let (x)=\sqrt{x}$. Which expression best estimates ''(9)$ using =0.01127',
  latex = 'Let (x)=\sqrt{x}$. Which expression best estimates ''(9)$ using =0.01127',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{\sqrt{9.01}-\sqrt{9}}{0.01}$','explanation','Correct forward-difference quotient with =0.01$.'),
    jsonb_build_object('id','B','text','$\dfrac{\sqrt{9}-\sqrt{8.99}}{0.01}$','explanation','This is a backward difference, not the stated forward form.'),
    jsonb_build_object('id','C','text','$\dfrac{\sqrt{9.01}-\sqrt{8.99}}{0.01}$','explanation','If using symmetric points, you must divide by /bin/zsh.02$, not /bin/zsh.01$.'),
    jsonb_build_object('id','D','text','$\dfrac{\sqrt{9.01}-\sqrt{9}}{9.01-9}$','explanation','This is equivalent to option A since .01-9=0.01$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'A standard estimate uses 19967g''(a)\approx \frac{g(a+h)-g(a)}{h}.19967 With =9$ and =0.01$, the correct setup is 19967\frac{\sqrt{9.01}-\sqrt{9}}{0.01}.19967',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Correct forward difference at =9$.'),
    jsonb_build_object('id','B','text','Backward difference uses -h$.'),
    jsonb_build_object('id','C','text','Symmetric numerator requires h$ in the denominator.'),
    jsonb_build_object('id','D','text','Same as A; .01-9=0.01$.')
  ),
  recommendation_reasons = ARRAY['Checks precise setup of a difference quotient.','Builds fluency with forward vs backward vs symmetric forms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: choosing the correct difference quotient form.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.3',
  section_id = '2.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_DERIV_ESTIMATE_NUMERICAL', 'SK_GRAPH_INTERPRETATION'],
  primary_skill_id = 'SK_DERIV_ESTIMATE_NUMERICAL',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION'],
  error_tags = ARRAY['E_SECANT_VS_TANGENT', 'E_SIGN_ERROR'],
  prompt = 'A graph (see image) shows =f(x)$ and a symmetric secant line through the points at =1.0$ and =2.0$. Which value is the best estimate of ''(1.5)$ using this symmetric secant?',
  latex = 'A graph (see image) shows =f(x)$ and a symmetric secant line through the points at =1.0$ and =2.0$. Which value is the best estimate of ''(1.5)$ using this symmetric secant?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The slope of the secant from =1.0$ to =1.5$ only','explanation','This is one-sided, not symmetric about =1.5$.'),
    jsonb_build_object('id','B','text','$\dfrac{f(2.0)-f(1.0)}{2.0-1.0}$','explanation','Correct: this is the symmetric secant slope and estimates the tangent slope at the midpoint.'),
    jsonb_build_object('id','C','text','$\dfrac{f(2.0)-f(1.5)}{2.0-1.5}$','explanation','Uses only the right half-interval, not symmetric.'),
    jsonb_build_object('id','D','text','$\dfrac{f(1.5)-f(1.0)}{2.0-1.0}$','explanation','Mismatches a half-interval numerator with a full-interval denominator.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A symmetric secant about =a$ uses points -h$ and +h$: 19967f''(a)\approx \frac{f(a+h)-f(a-h)}{2h}.19967 Here =1.5$ and the points are .0$ and .0$, so 19967f''(1.5)\approx \frac{f(2.0)-f(1.0)}{1.0}.19967',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Not symmetric; uses only one side of =1.5$.'),
    jsonb_build_object('id','B','text','Correct midpoint estimate: symmetric secant slope.'),
    jsonb_build_object('id','C','text','Right-side secant only.'),
    jsonb_build_object('id','D','text','Denominator should match the chosen numerator interval.' )
  ),
  recommendation_reasons = ARRAY['Connects symmetric secant slope to estimating the derivative at the midpoint.','Targets common setup errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required. Focus: symmetric secant as midpoint derivative estimate.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.3',
  section_id = '2.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DERIV_ESTIMATE_NUMERICAL', 'SK_AVG_RATE_CHANGE'],
  primary_skill_id = 'SK_DERIV_ESTIMATE_NUMERICAL',
  supporting_skill_ids = ARRAY['SK_AVG_RATE_CHANGE'],
  error_tags = ARRAY['E_UNITS_MISINTERPRET', 'E_SIGN_ERROR'],
  prompt = 'The position of a particle is (t)$ (meters). A table gives (4)=18.2$, (4.05)=18.7$, and (3.95)=17.6$. Estimate the instantaneous velocity ''(4)$ (m/s) using a symmetric difference quotient.',
  latex = 'The position of a particle is (t)$ (meters). A table gives (4)=18.2$, (4.05)=18.7$, and (3.95)=17.6$. Estimate the instantaneous velocity ''(4)$ (m/s) using a symmetric difference quotient.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','.0$','explanation','This uses an incorrect symmetric change; .7-17.6=1.1$.'),
    jsonb_build_object('id','B','text','$','explanation','Numerically correct, but you must justify using the full width /bin/zsh.10$ in the denominator.'),
    jsonb_build_object('id','C','text','$','explanation','Correct: $\dfrac{18.7-17.6}{0.10}=11$ m/s using a symmetric difference quotient.'),
    jsonb_build_object('id','D','text','$','explanation','This divides by /bin/zsh.05$ instead of /bin/zsh.10$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use 19967s''(4)\approx \frac{s(4+0.05)-s(4-0.05)}{2(0.05)}=\frac{s(4.05)-s(3.95)}{0.10}.19967 Then 19967\frac{18.7-17.6}{0.10}=11\text{ m/s}.19967',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Wrong numerator (should use .7-17.6$).'),
    jsonb_build_object('id','B','text','Value can be right, but denominator must be /bin/zsh.10$ from h$.'),
    jsonb_build_object('id','C','text','Correct symmetric computation and units.'),
    jsonb_build_object('id','D','text','Uses $ instead of h$.' )
  ),
  recommendation_reasons = ARRAY['Reinforces derivative as instantaneous rate with correct units.','Targets symmetric difference computation accuracy.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: instantaneous rate (units) from symmetric data.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.3-P5';




-- Unit 2.4 (Connecting Differentiability and Continuity) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.4',
  section_id = '2.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DIFF_CONTINUITY', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_DIFF_CONTINUITY',
  supporting_skill_ids = ARRAY['SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_ASSUME_DIFF_FROM_CONT', 'E_ENDPOINT_DERIVATIVE'],
  prompt = 'Which statement is always true for a function $ at =a127

I. If $ is differentiable at $, then $ is continuous at $.

II. If $ is continuous at $, then $ is differentiable at $.',
  latex = 'Which statement is always true for a function $ at =a127

I. If $ is differentiable at $, then $ is continuous at $.

II. If $ is continuous at $, then $ is differentiable at $.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','I only','explanation','Differentiability implies continuity, but continuity alone does not guarantee differentiability (corners/cusps).'),
    jsonb_build_object('id','B','text','II only','explanation','Continuity does not imply differentiability, so II is not always true.'),
    jsonb_build_object('id','C','text','Both I and II','explanation','II fails for functions like $|x|$ at /bin/zsh$.'),
    jsonb_build_object('id','D','text','Neither I nor II','explanation','I is true, so this cannot be correct.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiability at $ forces $\lim_{x\to a}f(x)=f(a)$, so $ must be continuous at $. But continuity can occur without differentiability (e.g., corners).',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Correct implication: differentiable $\Rightarrow$ continuous.'),
    jsonb_build_object('id','B','text','Continuity alone does not ensure a derivative.'),
    jsonb_build_object('id','C','text','II is false at corners/cusps.'),
    jsonb_build_object('id','D','text','I is true, so not neither.' )
  ),
  recommendation_reasons = ARRAY['High-frequency AP concept: differentiability vs continuity.','Targets the misconception that continuity implies differentiability.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: correct implication direction (diff ⇒ cont).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.4',
  section_id = '2.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DIFF_CONTINUITY', 'SK_GRAPH_INTERPRETATION'],
  primary_skill_id = 'SK_DIFF_CONTINUITY',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION'],
  error_tags = ARRAY['E_ASSUME_DIFF_FROM_CONT', 'E_SECANT_VS_TANGENT'],
  prompt = 'Let (x)=|x-2|$. Which best describes $ at =2127',
  latex = 'Let (x)=|x-2|$. Which best describes $ at =2127',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Discontinuous at =2$','explanation','Absolute value is continuous everywhere; there is no break at =2$.'),
    jsonb_build_object('id','B','text','Continuous and differentiable at =2$','explanation','There is a sharp corner at =2$, so the derivative does not exist there.'),
    jsonb_build_object('id','C','text','Continuous but not differentiable at =2$','explanation','Left slope is 569Xils1$ and right slope is 0$, so the derivative does not exist at $, but the function is continuous.'),
    jsonb_build_object('id','D','text','Differentiable but not continuous at =2$','explanation','Differentiability implies continuity, so this cannot happen.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The graph of $|x-2|$ has a corner at =2$. The function is continuous, but the one-sided derivatives differ (569Xils1$ vs $), so the derivative does not exist at $.',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','No jump/hole: absolute value is continuous.'),
    jsonb_build_object('id','B','text','Corner means not differentiable.'),
    jsonb_build_object('id','C','text','Correct: continuous, but left/right slopes differ.'),
    jsonb_build_object('id','D','text','Impossible: differentiable implies continuous.' )
  ),
  recommendation_reasons = ARRAY['Canonical AP example: a corner gives continuity without differentiability.','Reinforces checking one-sided derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: corner at an absolute value vertex.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.4',
  section_id = '2.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_DIFF_CONTINUITY', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_DIFF_CONTINUITY',
  supporting_skill_ids = ARRAY['SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_ASSUME_DIFF_FROM_CONT', 'E_SIGN_ERROR'],
  prompt = 'Define
19967f(x)=\begin{cases}
\dfrac{x^2-1}{x-1}, & x\ne 1\
3, & x=1
\end{cases}19967
Which statement is true about $ at =1127',
  latex = 'Define
19967f(x)=\begin{cases}
\dfrac{x^2-1}{x-1}, & x\ne 1\
3, & x=1
\end{cases}19967
Which statement is true about $ at =1127',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Not continuous at =1$, but differentiable at =1$','explanation','A function cannot be differentiable at a point where it is not continuous.'),
    jsonb_build_object('id','B','text','Continuous at =1$, but not differentiable at =1$','explanation','If it were continuous here, it would simplify to a line near $ and be differentiable.'),
    jsonb_build_object('id','C','text','Continuous and differentiable at =1$','explanation','Continuity would require matching the limit, but (1)$ does not match.'),
    jsonb_build_object('id','D','text','Not continuous and not differentiable at =1$','explanation','For \ne 1$, (x)=x+1$ so the limit is $, but (1)=3$; not continuous implies not differentiable.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'For \ne 1$, 19967\frac{x^2-1}{x-1}=x+1,19967 so 19967\lim_{x\to 1}f(x)=2.19967 Since (1)=3\ne 2$, $ is not continuous at $, and therefore not differentiable at $.',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Differentiability cannot hold without continuity.'),
    jsonb_build_object('id','B','text','If continuous here, it would be a line and differentiable.'),
    jsonb_build_object('id','C','text','Continuity fails because (1)\ne 2$.'),
    jsonb_build_object('id','D','text','Correct: (1)$ does not equal the limit.' )
  ),
  recommendation_reasons = ARRAY['Tests removable-discontinuity logic and its consequence for differentiability.','Reinforces diff ⇒ cont.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: mismatch between (1)$ and the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.4',
  section_id = '2.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DIFF_CONTINUITY', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_DIFF_CONTINUITY',
  supporting_skill_ids = ARRAY['SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_ASSUME_DIFF_FROM_CONT', 'E_ENDPOINT_DERIVATIVE'],
  prompt = 'Let
19967h(x)=\begin{cases}
x\sin\left(\frac{1}{x}\right), & x\ne 0\
0, & x=0
\end{cases}19967
Which statement is true about $ at =0127',
  latex = 'Let
19967h(x)=\begin{cases}
x\sin\left(\frac{1}{x}\right), & x\ne 0\
0, & x=0
\end{cases}19967
Which statement is true about $ at =0127',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Not continuous at /bin/zsh$','explanation','Because $|x\sin(1/x)|\le |x|$, the limit as \to 0$ is /bin/zsh$, so it is continuous.'),
    jsonb_build_object('id','B','text','Continuous at /bin/zsh$ but not differentiable at /bin/zsh$','explanation','Correct: continuity holds by squeeze, but ''(0)=\lim_{t\to 0}\sin(1/t)$ does not exist.'),
    jsonb_build_object('id','C','text','Differentiable at /bin/zsh$ but not continuous at /bin/zsh$','explanation','Differentiability implies continuity, so this cannot happen.'),
    jsonb_build_object('id','D','text','Continuous and differentiable at /bin/zsh$','explanation','Differentiability fails because the derivative limit oscillates and does not converge.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Continuity: $|x\sin(1/x)|\le |x|\to 0$, so $\lim_{x\to 0}h(x)=0=h(0)$. Differentiability: 19967h''(0)=\lim_{t\to 0}\sin(1/t),19967 which does not exist. Hence continuous but not differentiable at /bin/zsh$.',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Continuity actually holds by squeeze.'),
    jsonb_build_object('id','B','text','Correct: derivative limit oscillates and fails to exist.'),
    jsonb_build_object('id','C','text','Cannot be differentiable without continuity.'),
    jsonb_build_object('id','D','text','Derivative limit does not converge.' )
  ),
  recommendation_reasons = ARRAY['Tests a classic oscillation example: continuous but not differentiable.','Reinforces derivative definition as a limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image. Focus: squeeze theorem vs derivative-limit oscillation.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.4',
  section_id = '2.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_DIFF_CONTINUITY', 'SK_GRAPH_INTERPRETATION'],
  primary_skill_id = 'SK_DIFF_CONTINUITY',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION'],
  error_tags = ARRAY['E_ASSUME_DIFF_FROM_CONT', 'E_SECANT_VS_TANGENT'],
  prompt = 'A function $ has the graph shown (see image), with (0)=1$. Which statement is true about $ at =0127',
  latex = 'A function $ has the graph shown (see image), with (0)=1$. Which statement is true about $ at =0127',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$ is differentiable at /bin/zsh$','explanation','The graph has a corner at =0$, so it is not differentiable.'),
    jsonb_build_object('id','B','text','$ is continuous but not differentiable at /bin/zsh$','explanation','Both pieces meet at $ (continuous), but the left and right slopes differ (not differentiable).'),
    jsonb_build_object('id','C','text','$ is not continuous at /bin/zsh$ but is differentiable at /bin/zsh$','explanation','Differentiability implies continuity, so this cannot happen.'),
    jsonb_build_object('id','D','text','$ is neither continuous nor differentiable at /bin/zsh$','explanation','The pieces meet at $, so $ is continuous at /bin/zsh$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'From the graph, the two pieces meet at $, so $\lim_{x\to 0}F(x)=F(0)$ and $ is continuous. The one-sided slopes at /bin/zsh$ do not match, so $ is not differentiable at /bin/zsh$.',
  micro_explanations = jsonb_build_array(
    jsonb_build_object('id','A','text','Corner implies derivative does not exist.'),
    jsonb_build_object('id','B','text','Correct: continuous meeting point, but different one-sided slopes.'),
    jsonb_build_object('id','C','text','Impossible because differentiable implies continuous.'),
    jsonb_build_object('id','D','text','Continuity holds at $.' )
  ),
  recommendation_reasons = ARRAY['Graph-based differentiability test at a point.','Targets the misconception that a connected graph is automatically differentiable.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required. Focus: continuity vs differentiability at a corner.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.4-P5';

