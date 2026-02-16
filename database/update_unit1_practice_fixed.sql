-- FIX EXPLANATION (why it failed previously):
-- The key/value pair was malformed in previous attempts (missed the quote after text).
-- This script corrects those JSON errors and updates Unit 1.1 - 1.4 practice questions.

-- Unit 1.1 (Introducing Calculus: Can Change Occur at an Instant?) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.1',
  section_id = '1.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_AVG_ROC', 'SK_SECANT_SLOPE', 'SK_FUNC_EVAL', 'SK_UNITS_INTERPRET'],
  primary_skill_id = 'SK_AVG_ROC',
  supporting_skill_ids = ARRAY['SK_SECANT_SLOPE', 'SK_FUNC_EVAL', 'SK_UNITS_INTERPRET'],
  error_tags = ARRAY['E_AVG_ROC_SETUP', 'E_SIGN_ERROR', 'E_UNITS_MISMATCH'],
  prompt = 'A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?',
  latex = 'A particle’s position is given by $s(t)=t^2+2t$ (meters), where $t$ is in seconds. What is the average velocity on the interval $[1,3]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4\\ \\text{m/s}$','explanation','This can result from using the correct difference-quotient form but evaluating $s(3)-s(1)$ incorrectly.'),
    jsonb_build_object('id','B','text','$6\\ \\text{m/s}$','explanation','Correct: $\\dfrac{s(3)-s(1)}{3-1}=\\dfrac{15-3}{2}=6$.'),
    jsonb_build_object('id','C','text','$8\\ \\text{m/s}$','explanation','This can happen if you compute $\\dfrac{s(3)}{3}$ or confuse an average rate with a point-based value.'),
    jsonb_build_object('id','D','text','$10\\ \\text{m/s}$','explanation','This can happen if you forget to divide by $3-1=2$ and use $s(3)-s(1)=12$ as the answer.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Average velocity on $[1,3]$ is the slope of the secant line:
$$\\frac{s(3)-s(1)}{3-1}=\\frac{(3^2+2\\cdot 3)-(1^2+2\\cdot 1)}{2}=\\frac{15-3}{2}=6.$$',
  recommendation_reasons = ARRAY['Reinforces average rate of change as a secant slope.', 'Targets correct interval setup and units.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute average velocity via difference quotient on an interval.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.1',
  section_id = '1.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LIMIT_DEF_DERIV', 'SK_DIFF_QUOTIENT', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_LIMIT_DEF_DERIV',
  supporting_skill_ids = ARRAY['SK_DIFF_QUOTIENT', 'SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_PLUG_H_0', 'E_LIMIT_VARIABLE_MISMATCH', 'E_SIGN_ERROR'],
  prompt = 'Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?',
  latex = 'Let $f(x)=3x^2-5x$. Which expression represents the slope of the tangent line to $y=f(x)$ at $x=2$ using the definition of derivative?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\lim_{h\\to 0}\\frac{f(2)-f(2-h)}{h}$$','explanation','This is not the standard increment form and can cause sign confusion unless carefully rewritten.'),
    jsonb_build_object('id','B','text','$$\\lim_{h\\to 0}\\frac{f(h)-f(2)}{h-2}$$','explanation','This misuses $h$ as an input rather than an increment around $2$.'),
    jsonb_build_object('id','C','text','$$\\lim_{x\\to 0}\\frac{f(2)-f(x)}{2-x}$$','explanation','This is not stated correctly for the tangent at $x=2$ because the limit should be as $x\\to 2$, not $x\\to 0$.'),
    jsonb_build_object('id','D','text','$$\\lim_{h\\to 0}\\frac{f(2+h)-f(2)}{h}$$','explanation','Correct: this is the limit definition of the derivative at $x=2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'By definition, the slope of the tangent line at $x=2$ is
$$\\lim_{h\\to 0}\\frac{f(2+h)-f(2)}{h}.$$',
  recommendation_reasons = ARRAY['Builds correct derivative-as-limit setup.', 'Targets common notation and variable-limit mismatches.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify the correct limit expression for instantaneous rate of change at a point.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.1',
  section_id = '1.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_RADICAL_RATIONALIZE', 'SK_DIFF_QUOTIENT', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_RADICAL_RATIONALIZE',
  supporting_skill_ids = ARRAY['SK_DIFF_QUOTIENT', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_RATIONALIZE_MISUSE', 'E_PLUG_H_0', 'E_ARITHMETIC_SLIP'],
  prompt = 'Compute the instantaneous rate of change of $g(x)=\\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\\lim_{h\\to 0}\\frac{\\sqrt{9+h}-3}{h}.$$',
  latex = 'Compute the instantaneous rate of change of $g(x)=\\sqrt{x}$ at $x=9$ using the limit definition $$g''(9)=\\lim_{h\\to 0}\\frac{\\sqrt{9+h}-3}{h}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{3}$','explanation','This can happen if you cancel incorrectly before rationalizing.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{18}$','explanation','This can happen if you mistakenly evaluate $\\sqrt{9+h}+3\\to 18$ instead of $\\to 6$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{6}$','explanation','Correct: rationalizing gives $\\dfrac{1}{\\sqrt{9+h}+3}\\to \\dfrac{1}{6}$.'),
    jsonb_build_object('id','D','text','$\\dfrac{1}{9}$','explanation','This can happen if you confuse $\\sqrt{9}=3$ and incorrectly square values during simplification.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Rationalize:
$$\\frac{\\sqrt{9+h}-3}{h}\\cdot\\frac{\\sqrt{9+h}+3}{\\sqrt{9+h}+3}
=\\frac{(9+h)-9}{h(\\sqrt{9+h}+3)}
=\\frac{1}{\\sqrt{9+h}+3}.$$
Then
$$\\lim_{h\\to 0}\\frac{1}{\\sqrt{9+h}+3}=\\frac{1}{3+3}=\\frac{1}{6}.$$',
  recommendation_reasons = ARRAY['Reinforces conjugate technique inside a limit.', 'Targets the “substitute $h=0$ too early” misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rationalize a radical difference quotient and take the limit safely.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.1',
  section_id = '1.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_AVG_ROC', 'SK_UNITS_INTERPRET'],
  primary_skill_id = 'SK_AVG_ROC',
  supporting_skill_ids = ARRAY['SK_UNITS_INTERPRET'],
  error_tags = ARRAY['E_AVG_VS_INST', 'E_AVG_ROC_SETUP', 'E_UNITS_MISMATCH'],
  prompt = 'A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?',
  latex = 'A car’s distance from home (in miles) after $t$ hours is $D(t)$. Which quantity best represents the average speed of the car from $t=2$ to $t=5$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\frac{D(5)-D(2)}{5-2}$$','explanation','Correct: change in distance divided by change in time (miles per hour).'),
    jsonb_build_object('id','B','text','$D(5)-D(2)$','explanation','This is total change in distance, not a rate per hour.'),
    jsonb_build_object('id','C','text','$$\\frac{D(5)}{5}$$','explanation','This averages from $0$ to $5$, not from $2$ to $5$.'),
    jsonb_build_object('id','D','text','$D''(2)$','explanation','This is an instantaneous rate at $t=2$, not an average over $[2,5]$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Average speed on $[2,5]$ is the average rate of change:
$$\\frac{D(5)-D(2)}{5-2}.$$',
  recommendation_reasons = ARRAY['Locks in the definition of average speed as a secant slope.', 'Separates average rate from instantaneous rate.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret average speed as a difference quotient with correct units.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.1',
  section_id = '1.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_DIFF_QUOTIENT', 'SK_ALGEBRA_SIMPLIFY', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_DIFF_QUOTIENT',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY', 'SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_EXPANSION_ERROR', 'E_CANCEL_INCORRECTLY', 'E_PLUG_H_0'],
  prompt = 'Let $p(x)=x^3$. Evaluate $$\\lim_{h\\to 0}\\frac{p(2+h)-p(2)}{h}.$$',
  latex = 'Let $p(x)=x^3$. Evaluate $$\\lim_{h\\to 0}\\frac{p(2+h)-p(2)}{h}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$6$','explanation','This can happen if you mishandle the expansion and lose terms after dividing by $h$.'),
    jsonb_build_object('id','B','text','$12$','explanation','Correct: $\\dfrac{(2+h)^3-8}{h}=12+6h+h^2\\to 12$.'),
    jsonb_build_object('id','C','text','$8$','explanation','This confuses $p(2)=8$ with the value of the limit.'),
    jsonb_build_object('id','D','text','$4$','explanation','This can happen from an expansion error such as treating $(2+h)^3$ as $8+4h$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute:
$$(2+h)^3=8+12h+6h^2+h^3.$$
So
$$\\frac{(2+h)^3-8}{h}=\\frac{12h+6h^2+h^3}{h}=12+6h+h^2.$$
Taking $h\\to 0$ gives $12$.',
  recommendation_reasons = ARRAY['Connects instantaneous rate to a limit of secant slopes.', 'Requires careful algebra and safe cancellation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: evaluate a difference-quotient limit by algebraic expansion.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.1-P5';




-- Unit 1.2 (Defining Limits and Using Limit Notation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.2',
  section_id = '1.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LIMIT_NOTATION', 'SK_LIMIT_CONCEPT'],
  primary_skill_id = 'SK_LIMIT_NOTATION',
  supporting_skill_ids = ARRAY['SK_LIMIT_CONCEPT'],
  error_tags = ARRAY['E_LIMIT_VALUE_VS_FUNCTION_VALUE', 'E_ASSUME_LIMIT_EXISTS'],
  prompt = 'Suppose $\\lim_{x\\to 4} f(x)=7$. Which statement must be true?',
  latex = 'Suppose $\\lim_{x\\to 4} f(x)=7$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f(4)=7$','explanation','Not required: the limit can exist even if $f(4)$ is different or undefined.'),
    jsonb_build_object('id','B','text','$f(x)=7$ for all $x$ near $4$','explanation','Not required: $f(x)$ can vary and still approach $7$ as $x\\to 4$.'),
    jsonb_build_object('id','C','text','For values of $x$ close to $4$ (but not necessarily equal to $4$), $f(x)$ can be made arbitrarily close to $7$.','explanation','Correct: this is the meaning of $\\lim_{x\\to 4} f(x)=7$.'),
    jsonb_build_object('id','D','text','$\\lim_{x\\to 7} f(x)=4$','explanation','Unrelated reversal; not implied by the given limit statement.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The statement $\\lim_{x\\to 4} f(x)=7$ means that for $x$ sufficiently close to $4$ (with $x\\ne 4$ allowed), the values $f(x)$ can be made as close to $7$ as desired.',
  recommendation_reasons = ARRAY['Builds correct conceptual interpretation of limit notation.', 'Targets confusion between limit value and function value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret limit notation without assuming $f(4)$ or local constancy.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.2',
  section_id = '1.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_ONE_SIDED_LIMIT', 'SK_LIMIT_EXISTENCE', 'SK_ABS_VALUE_SIGN'],
  primary_skill_id = 'SK_ONE_SIDED_LIMIT',
  supporting_skill_ids = ARRAY['SK_LIMIT_EXISTENCE', 'SK_ABS_VALUE_SIGN'],
  error_tags = ARRAY['E_LEFT_RIGHT_CONFUSION', 'E_ASSUME_LIMIT_EXISTS', 'E_PIECEWISE_BRANCH_MIXUP'],
  prompt = 'For $x\\ne 1$, define $$f(x)=\\frac{|x-1|}{x-1}.$$ Which statement is correct?',
  latex = 'For $x\\ne 1$, define $$f(x)=\\frac{|x-1|}{x-1}.$$ Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\lim_{x\\to 1^-} f(x)=-1\\ \\text{and}\\ \\lim_{x\\to 1^+} f(x)=1$$','explanation','Correct: for $x<1$, $f(x)=-1$; for $x>1$, $f(x)=1$.'),
    jsonb_build_object('id','B','text','$$\\lim_{x\\to 1} f(x)=1$$','explanation','The two-sided limit does not exist because the one-sided limits are different.'),
    jsonb_build_object('id','C','text','$$\\lim_{x\\to 1} f(x)=-1$$','explanation','Only the left-hand limit is $-1$; the right-hand limit is $1$.'),
    jsonb_build_object('id','D','text','$f(1)=0$','explanation','The function is not defined at $x=1$ because the definition specifies $x\\ne 1$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'If $x>1$, then $|x-1|=x-1$ so $f(x)=1$. If $x<1$, then $|x-1|=-(x-1)$ so $f(x)=-1$. Therefore
$$\\lim_{x\\to 1^-} f(x)=-1,\\qquad \\lim_{x\\to 1^+} f(x)=1,$$
so the two-sided limit does not exist.',
  recommendation_reasons = ARRAY['Reinforces one-sided limits via sign analysis.', 'Targets the misconception that a two-sided limit always exists.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: determine one-sided limits and conclude about existence of the two-sided limit.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.2',
  section_id = '1.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_LIMIT_NOTATION'],
  primary_skill_id = 'SK_LIMIT_LAWS',
  supporting_skill_ids = ARRAY['SK_LIMIT_NOTATION'],
  error_tags = ARRAY['E_SIGN_ERROR', 'E_ARITHMETIC_SLIP', 'E_LIMIT_VALUE_VS_FUNCTION_VALUE'],
  prompt = 'If $\\lim_{x\\to 2} (f(x)-3)=5$, what is $\\lim_{x\\to 2} f(x)$?',
  latex = 'If $\\lim_{x\\to 2} (f(x)-3)=5$, what is $\\lim_{x\\to 2} f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','This can happen if you subtract $3$ instead of adding it back.'),
    jsonb_build_object('id','B','text','$5$','explanation','This is the limit of $f(x)-3$, not the limit of $f(x)$.'),
    jsonb_build_object('id','C','text','$-8$','explanation','This can happen from sign confusion when moving $-3$ to the other side.'),
    jsonb_build_object('id','D','text','$8$','explanation','Correct: $\\lim f(x)=5+3=8$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use limit laws:
$$\\lim_{x\\to 2}(f(x)-3)=\\lim_{x\\to 2}f(x)-3=5,$$
so
$$\\lim_{x\\to 2}f(x)=8.$$',
  recommendation_reasons = ARRAY['Builds fluency with limit laws and algebraic rearrangement.', 'Targets common shift/sign mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: translate a limit statement involving a constant shift into the limit of the function.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.2',
  section_id = '1.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_LIMIT_NOTATION', 'SK_ONE_SIDED_LIMIT'],
  primary_skill_id = 'SK_LIMIT_NOTATION',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMIT'],
  error_tags = ARRAY['E_LEFT_RIGHT_CONFUSION'],
  prompt = 'Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?',
  latex = 'Which notation correctly describes “the left-hand limit of $f(x)$ as $x$ approaches $5$”?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\lim_{x\\to 5^+} f(x)$$','explanation','$5^+$ indicates approaching from the right, not from the left.'),
    jsonb_build_object('id','B','text','$$\\lim_{x\\to 5} f(5)$$','explanation','This misuses limit notation by treating $f(5)$ as varying with $x$.'),
    jsonb_build_object('id','C','text','$$\\lim_{f(x)\\to 5^-} x$$','explanation','This reverses input/output and is not standard one-sided limit notation.'),
    jsonb_build_object('id','D','text','$$\\lim_{x\\to 5^-} f(x)$$','explanation','Correct: $x\\to 5^-$ means values less than $5$ approaching $5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Approaching from the left uses $5^-$, so the left-hand limit is
$$\\lim_{x\\to 5^-} f(x).$$',
  recommendation_reasons = ARRAY['Locks in left vs right one-sided limit notation.', 'Prevents common symbol direction errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: recognize correct one-sided limit notation.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.2',
  section_id = '1.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LIMIT_EXISTENCE', 'SK_ONE_SIDED_LIMIT', 'SK_PIECEWISE_LIMIT'],
  primary_skill_id = 'SK_LIMIT_EXISTENCE',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMIT', 'SK_PIECEWISE_LIMIT'],
  error_tags = ARRAY['E_PIECEWISE_BRANCH_MIXUP', 'E_LEFT_RIGHT_CONFUSION', 'E_ASSUME_LIMIT_EXISTS'],
  prompt = 'Define $$f(x)=\\begin{cases}2x+1,& x<0\\\\ x^2,& x\\ge 0\\end{cases}$$ What is $\\lim_{x\\to 0} f(x)$?',
  latex = 'Define $$f(x)=\\begin{cases}2x+1,& x<0\\\\ x^2,& x\\ge 0\\end{cases}$$ What is $\\lim_{x\\to 0} f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This is the right-hand limit ($x\\to 0^+$), not the two-sided limit.'),
    jsonb_build_object('id','B','text','$1$','explanation','This is the left-hand limit ($x\\to 0^-$), not the two-sided limit.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','Correct: the one-sided limits are $1$ and $0$, so the two-sided limit does not exist.'),
    jsonb_build_object('id','D','text','$2$','explanation','This can happen if you mix branches or substitute incorrectly across the piecewise definition.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Compute one-sided limits:
$$\\lim_{x\\to 0^-} f(x)=\\lim_{x\\to 0^-}(2x+1)=1,$$
$$\\lim_{x\\to 0^+} f(x)=\\lim_{x\\to 0^+}(x^2)=0.$$
Since $1\\ne 0$, $\\lim_{x\\to 0} f(x)$ does not exist.',
  recommendation_reasons = ARRAY['Builds the rule: two-sided limit exists iff one-sided limits match.', 'Targets piecewise branch selection and left/right control.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compare one-sided limits of a piecewise function to determine existence of the two-sided limit.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.2-P5';


-- Unit 1.3 (Limits from Graphs: One-Sided, DNE, Infinite, Holes, Endpoints) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.3',
  section_id = '1.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_READ_LIMIT_FROM_GRAPH','SK_ONE_SIDED_LIMIT'],
  primary_skill_id = 'SK_READ_LIMIT_FROM_GRAPH',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMIT'],
  error_tags = ARRAY['ERR_MISREAD_OPEN_CLOSED_DOT','ERR_CONFUSE_LIMIT_WITH_VALUE','ERR_IGNORE_ONE_SIDED'],
  prompt = 'Use the graph to evaluate the limit.

Find $\\displaystyle \\lim_{x\\to 2^-} f(x)$.',
  latex = 'Find $\\displaystyle \\lim_{x\\to 2^-} f(x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','Approaching $x=2$ from the left follows the left linear branch, which approaches $y=3$ at the open circle.'),
    jsonb_build_object('id','B','text','$4$','explanation','$4$ is the function value shown by the filled point at $x=2$, not the left-hand limit.'),
    jsonb_build_object('id','C','text','The limit does not exist','explanation','A one-sided limit can exist even if the two-sided limit fails; from the left the values approach a single number.'),
    jsonb_build_object('id','D','text','$2$','explanation','$2$ confuses the $x$-value being approached with the $y$-value of the limit.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'As $x\\to 2^-$, the graph follows the left branch. The $y$-values approach $3$ (the open circle at $(2,3)$). Therefore, $\\lim_{x\\to 2^-} f(x)=3$.',
  recommendation_reasons = ARRAY['Targets one-sided limit reading from a graph.','Reinforces open vs closed circle meaning.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Prompt uses a graph. Common traps: using the filled point, ignoring one-sided notation.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.3',
  section_id = '1.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_READ_LIMIT_FROM_GRAPH','SK_LIMIT_DNE_FROM_GRAPH'],
  primary_skill_id = 'SK_READ_LIMIT_FROM_GRAPH',
  supporting_skill_ids = ARRAY['SK_LIMIT_DNE_FROM_GRAPH'],
  error_tags = ARRAY['ERR_ASSUME_TWO_SIDED_EXISTS','ERR_CONFUSE_LIMIT_WITH_VALUE','ERR_MISREAD_OPEN_CLOSED_DOT'],
  prompt = 'Use the graph to evaluate the limit.

Find $\\displaystyle \\lim_{x\\to 1} f(x)$.',
  latex = 'Find $\\displaystyle \\lim_{x\\to 1} f(x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','$1$ matches the right-hand approach (and the filled point), but the left-hand approach is different.'),
    jsonb_build_object('id','B','text','$3$','explanation','$3$ matches the left-hand approach (open circle), but the right-hand approach is different.'),
    jsonb_build_object('id','C','text','The limit does not exist','explanation','Left-hand and right-hand limits are different ($3$ from the left and $1$ from the right), so the two-sided limit does not exist.'),
    jsonb_build_object('id','D','text','$2$','explanation','$2$ is not approached from either side; it results from averaging or guessing.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'From the left, $f(x)$ approaches $3$ (open circle at $(1,3)$). From the right, $f(x)$ approaches $1$ (horizontal segment). Since $\\lim_{x\\to 1^-} f(x)\\neq \\lim_{x\\to 1^+} f(x)$, $\\lim_{x\\to 1} f(x)$ does not exist.',
  recommendation_reasons = ARRAY['Tests DNE via mismatch of one-sided limits.','Builds discipline: two-sided requires both sides match.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Prompt uses a graph. Emphasize comparing one-sided limits rather than using $f(1)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.3',
  section_id = '1.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_INFINITE_LIMIT_FROM_GRAPH','SK_ONE_SIDED_LIMIT'],
  primary_skill_id = 'SK_INFINITE_LIMIT_FROM_GRAPH',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMIT'],
  error_tags = ARRAY['ERR_SIGN_ERROR_INFINITY','ERR_IGNORE_ONE_SIDED','ERR_ASSUME_ASYMPTOTE_MEANS_DNE_ALWAYS'],
  prompt = 'Use the graph to evaluate the limit.

Find $\\displaystyle \\lim_{x\\to 0^+} f(x)$.',
  latex = 'Find $\\displaystyle \\lim_{x\\to 0^+} f(x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\infty$','explanation','The branch shown for $x>0$ rises upward as $x\\to 0^+$, not downward.'),
    jsonb_build_object('id','B','text','$\\infty$','explanation','As $x\\to 0^+$, the graph increases without bound, so the one-sided limit is $\\infty$.'),
    jsonb_build_object('id','C','text','$0$','explanation','The $x$-axis is not being approached; the $y$-values grow large.'),
    jsonb_build_object('id','D','text','The limit does not exist','explanation','An infinite limit is a valid limit description; here the behavior is unbounded in a single direction.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Near $x=0$ on the right, the graph shoots upward without bound. Therefore, $\\lim_{x\\to 0^+} f(x)=\\infty$.',
  recommendation_reasons = ARRAY['Reinforces interpreting vertical asymptote behavior.','Targets sign of infinity with one-sided approach.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Prompt uses a graph. Common error: writing DNE instead of $\\infty$ or choosing wrong sign.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.3',
  section_id = '1.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_READ_LIMIT_FROM_GRAPH','SK_LIMIT_EXISTS_GRAPHICALLY'],
  primary_skill_id = 'SK_READ_LIMIT_FROM_GRAPH',
  supporting_skill_ids = ARRAY['SK_LIMIT_EXISTS_GRAPHICALLY'],
  error_tags = ARRAY['ERR_CONFUSE_HOLE_WITH_DNE','ERR_CONFUSE_LIMIT_WITH_VALUE','ERR_MISREAD_OPEN_CLOSED_DOT'],
  prompt = 'Use the graph to evaluate the limit.

Find $\\displaystyle \\lim_{x\\to -1} f(x)$.',
  latex = 'Find $\\displaystyle \\lim_{x\\to -1} f(x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The limit does not exist','explanation','A hole does not prevent a limit from existing; the surrounding values can still approach one number.'),
    jsonb_build_object('id','B','text','$-1$','explanation','$-1$ is the $x$-value being approached, not the $y$-value of the limit.'),
    jsonb_build_object('id','C','text','$1$','explanation','Near $x=-1$, the graph lies on the horizontal line $y=1$ with a hole at $(-1,1)$, so the limit is $1$.'),
    jsonb_build_object('id','D','text','$0$','explanation','The graph is not approaching $y=0$ near $x=-1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Approaching $x=-1$ from either side, the graph stays at $y=1$. Even though there is a hole at $(-1,1)$, the approaching value is $1$, so $\\lim_{x\\to -1} f(x)=1$.',
  recommendation_reasons = ARRAY['Differentiates limit existence from function value.','Targets removable discontinuity interpretation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Prompt uses a graph. Common error: claiming DNE because of the hole.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.3',
  section_id = '1.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_ONE_SIDED_LIMIT','SK_READ_LIMIT_FROM_GRAPH'],
  primary_skill_id = 'SK_ONE_SIDED_LIMIT',
  supporting_skill_ids = ARRAY['SK_READ_LIMIT_FROM_GRAPH'],
  error_tags = ARRAY['ERR_ASSUME_TWO_SIDED_REQUIRED','ERR_IGNORE_DOMAIN_ENDPOINT','ERR_IGNORE_ONE_SIDED'],
  prompt = 'Use the graph to evaluate the limit.

Find $\\displaystyle \\lim_{x\\to 0^+} f(x)$.',
  latex = 'Find $\\displaystyle \\lim_{x\\to 0^+} f(x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','At $x=0$, the graph begins at $y=0$, not $1$.'),
    jsonb_build_object('id','B','text','$0$','explanation','As $x\\to 0^+$ along the curve, $y\\to 0$.'),
    jsonb_build_object('id','C','text','The limit does not exist','explanation','A right-hand limit can exist even if there is no left side shown.'),
    jsonb_build_object('id','D','text','$\\infty$','explanation','The curve does not blow up near $x=0$; it approaches $0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'The graph is defined for $x\\ge 0$ and approaches the point $(0,0)$ from the right. Therefore, $\\lim_{x\\to 0^+} f(x)=0$.',
  recommendation_reasons = ARRAY['Builds comfort with endpoint/right-hand limits.','Reinforces meaning of $0^+$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Prompt uses a graph. Common error: forcing a two-sided limit when only right side is relevant.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.3-P5';



-- Unit 1.4 (Limits from Tables: Finite, DNE, Infinite, Difference Quotient, Oscillation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.4',
  section_id = '1.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_ESTIMATE_LIMIT_FROM_TABLE'],
  primary_skill_id = 'SK_ESTIMATE_LIMIT_FROM_TABLE',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['ERR_USE_NEAREST_VALUE_ONLY','ERR_CONFUSE_LIMIT_WITH_VALUE','ERR_IGNORE_BOTH_SIDES_TABLE'],
  prompt = 'A function $f$ is defined near $x=3$. Use the table to estimate $\\displaystyle \\lim_{x\\to 3} f(x)$.

$$
\\begin{array}{c|cccccc}
x & 2.9 & 2.99 & 2.999 & 3.001 & 3.01 & 3.1\\\\ \\hline
f(x) & 5.7 & 5.97 & 5.997 & 6.003 & 6.03 & 6.3
\\end{array}
$$',
  latex = '$$\\begin{array}{c|cccccc}x & 2.9 & 2.99 & 2.999 & 3.001 & 3.01 & 3.1\\\\ \\hline f(x) & 5.7 & 5.97 & 5.997 & 6.003 & 6.03 & 6.3\\end{array}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5.997$','explanation','This is just one value from the left side; the limit should reflect values from both sides approaching the same number.'),
    jsonb_build_object('id','B','text','$6$','explanation','Values approach $6$ from both sides: $5.997$ (left) and $6.003$ (right) get closer to $6$ as $x$ nears $3$.'),
    jsonb_build_object('id','C','text','$6.003$','explanation','This is just one value from the right side; it is not the best estimate of the limiting value.'),
    jsonb_build_object('id','D','text','The limit does not exist','explanation','Both sides trend toward the same value, so the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'As $x$ approaches $3$ from the left, $f(x)$ moves from $5.97$ to $5.997$. From the right, it moves from $6.03$ to $6.003$. These values cluster around $6$, so $\\lim_{x\\to 3} f(x)\\approx 6$.',
  recommendation_reasons = ARRAY['Trains reading two-sided behavior from tables.','Counters the habit of picking one nearby entry.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image needed; table provided in KaTeX.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.4',
  section_id = '1.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_ESTIMATE_LIMIT_FROM_TABLE','SK_LIMIT_DNE_FROM_TABLE'],
  primary_skill_id = 'SK_ESTIMATE_LIMIT_FROM_TABLE',
  supporting_skill_ids = ARRAY['SK_LIMIT_DNE_FROM_TABLE'],
  error_tags = ARRAY['ERR_IGNORE_BOTH_SIDES_TABLE','ERR_AVERAGE_TWO_SIDES','ERR_ASSUME_TWO_SIDED_EXISTS'],
  prompt = 'Use the table to determine $\\displaystyle \\lim_{x\\to 2} f(x)$.

$$
\\begin{array}{c|cccccc}
x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\\\ \\hline
f(x) & -1.1 & -1.01 & -1.001 & 3.001 & 3.01 & 3.1
\\end{array}
$$',
  latex = '$$\\begin{array}{c|cccccc}x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\\\ \\hline f(x) & -1.1 & -1.01 & -1.001 & 3.001 & 3.01 & 3.1\\end{array}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This is an average of the one-sided behaviors, but limits are not found by averaging.'),
    jsonb_build_object('id','B','text','$-1$','explanation','This matches the left-hand trend, but the right-hand trend approaches a different value.'),
    jsonb_build_object('id','C','text','$3$','explanation','This matches the right-hand trend, but the left-hand trend approaches a different value.'),
    jsonb_build_object('id','D','text','The limit does not exist','explanation','Left-hand values approach $-1$ while right-hand values approach $3$, so the two-sided limit does not exist.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'From the left of $2$, $f(x)$ approaches $-1$ (e.g., $-1.001$). From the right of $2$, $f(x)$ approaches $3$ (e.g., $3.001$). Since the one-sided limits are unequal, $\\lim_{x\\to 2} f(x)$ does not exist.',
  recommendation_reasons = ARRAY['Directly tests DNE using left vs right trends in a table.','Targets the common averaging mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image needed; table provided in KaTeX.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.4',
  section_id = '1.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_INFINITE_LIMIT_FROM_TABLE','SK_LIMIT_NOTATION_INFINITE'],
  primary_skill_id = 'SK_INFINITE_LIMIT_FROM_TABLE',
  supporting_skill_ids = ARRAY['SK_LIMIT_NOTATION_INFINITE'],
  error_tags = ARRAY['ERR_WRITE_DNE_INSTEAD_OF_INFINITY','ERR_SIGN_ERROR_INFINITY','ERR_ASSUME_ALWAYS_FINITE'],
  prompt = 'Use the table to evaluate the limit.

$$
\\begin{array}{c|cccccc}
x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\\\ \\hline
f(x) & 10 & 100 & 1000 & 1000 & 100 & 10
\\end{array}
$$

Find $\\displaystyle \\lim_{x\\to 0} f(x)$.',
  latex = '$$\\begin{array}{c|cccccc}x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\\\ \\hline f(x) & 10 & 100 & 1000 & 1000 & 100 & 10\\end{array}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The values grow larger as $x$ gets closer to $0$, not smaller.'),
    jsonb_build_object('id','B','text','$-\\infty$','explanation','All listed function values are positive and increasing in magnitude near $0$, so the trend is not toward $-\\infty$.'),
    jsonb_build_object('id','C','text','$\\infty$','explanation','As $x$ approaches $0$ from both sides, $f(x)$ increases without bound, indicating an infinite limit of $\\infty$.'),
    jsonb_build_object('id','D','text','The limit does not exist','explanation','Here the function grows without bound in the same direction on both sides, so describing the limit as $\\infty$ is appropriate.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'When $x$ is closer to $0$ (e.g., $\\pm 0.001$), $f(x)$ is much larger (1000) than when $x$ is farther (e.g., $\\pm 0.1$ gives 10). The values increase without bound as $x\\to 0$, so $\\lim_{x\\to 0} f(x)=\\infty$.',
  recommendation_reasons = ARRAY['Reinforces recognizing infinite limits from numerical data.','Targets the DNE vs $\\infty$ misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image needed; table provided in KaTeX.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.4',
  section_id = '1.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_ESTIMATE_LIMIT_FROM_TABLE','SK_AVERAGE_RATE_LIMIT'],
  primary_skill_id = 'SK_ESTIMATE_LIMIT_FROM_TABLE',
  supporting_skill_ids = ARRAY['SK_AVERAGE_RATE_LIMIT'],
  error_tags = ARRAY['ERR_SUBSTITUTE_POINT_VALUE','ERR_MIX_UP_DIFFERENCE_QUOTIENT','ERR_USE_NEAREST_VALUE_ONLY'],
  prompt = 'A function $f$ is defined near $x=2$. Use the table to estimate
$$\\displaystyle \\lim_{x\\to 2}\\frac{f(x)-f(2)}{x-2}.$$

$$
\\begin{array}{c|cccccc}
x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\\\ \\hline
f(x) & 4.61 & 4.9601 & 4.996001 & 5.004001 & 5.0401 & 5.41
\\end{array}
$$

Assume $f(2)=5$.',
  latex = '$$\\lim_{x\\to 2}\\frac{f(x)-f(2)}{x-2}$$ with $f(2)=5$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The quotient is not near $0$; the changes in $f(x)$ relative to changes in $x$ suggest a slope near $4$.'),
    jsonb_build_object('id','B','text','$4$','explanation','Using nearby values: for $x=2.001$, $(5.004001-5)/0.001\\approx 4.001$; for $x=1.999$, $(4.996001-5)/(-0.001)\\approx 3.999$.'),
    jsonb_build_object('id','C','text','$5$','explanation','$5$ is $f(2)$, but the expression is about the rate of change (slope), not the function value.'),
    jsonb_build_object('id','D','text','The limit does not exist','explanation','Left and right quotients both approach about $4$, indicating the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute the difference quotient near $2$. From the right: $(5.004001-5)/0.001\\approx 4.001$. From the left: $(4.996001-5)/(-0.001)\\approx 3.999$. Both sides approach $4$, so the limit is approximately $4$.',
  recommendation_reasons = ARRAY['Connects tabular estimation with the key limit form for instantaneous rate of change.','Trains correct setup using $f(2)$ and $(x-2)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image needed; table provided in KaTeX. This stays within 1.4 by estimating a limit from a table.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.4',
  section_id = '1.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LIMIT_DNE_FROM_TABLE','SK_ESTIMATE_LIMIT_FROM_TABLE'],
  primary_skill_id = 'SK_LIMIT_DNE_FROM_TABLE',
  supporting_skill_ids = ARRAY['SK_ESTIMATE_LIMIT_FROM_TABLE'],
  error_tags = ARRAY['ERR_USE_NEAREST_VALUE_ONLY','ERR_ASSUME_PATTERN_CONTINUES_TO_LIMIT','ERR_IGNORE_OSCILLATION'],
  prompt = 'Use the table to determine $\\displaystyle \\lim_{x\\to 0} f(x)$.

$$
\\begin{array}{c|cccccc}
x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\\\ \\hline
f(x) & 1 & -1 & 1 & -1 & 1 & -1
\\end{array}
$$',
  latex = '$$\\begin{array}{c|cccccc}x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\\\ \\hline f(x) & 1 & -1 & 1 & -1 & 1 & -1\\end{array}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Averaging the two values is not justified; the function values do not trend toward $0$.'),
    jsonb_build_object('id','B','text','$1$','explanation','Values near $0$ are sometimes $1$ and sometimes $-1$; there is no single value approached.'),
    jsonb_build_object('id','C','text','$-1$','explanation','Values near $0$ are sometimes $-1$ and sometimes $1$; there is no single value approached.'),
    jsonb_build_object('id','D','text','The limit does not exist','explanation','The function values oscillate between $1$ and $-1$ near $0$, so they do not approach a single number.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'As $x$ gets closer to $0$, the outputs keep switching between $1$ and $-1$. Since the values do not settle on a single number, $\\lim_{x\\to 0} f(x)$ does not exist.',
  recommendation_reasons = ARRAY['Tests a high-frequency misconception: nearby values can alternate and still fail to have a limit.','Builds recognition of oscillation as a DNE pattern.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No image needed; table provided in KaTeX. Designed as a discrimination item (Level 5).',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.4-P5';

-- Unit 1.5 (Determining Limits Using Algebraic Properties of Limits) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_DIRECT_SUBSTITUTION'],
  primary_skill_id = 'SK_LIMIT_LAWS',
  supporting_skill_ids = ARRAY['SK_DIRECT_SUBSTITUTION'],
  error_tags = ARRAY['E_ARITHMETIC_SLIP', 'E_MISAPPLY_LIMIT_LAWS'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 3}\left(2x^2-5x+1\right).$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 3}\left(2x^2-5x+1\right).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','Direct substitution gives $2(3^2)-5(3)+1=18-15+1=4$.'),
    jsonb_build_object('id','B','text','$6$','explanation','This results from miscomputing $18-15+1$.'),
    jsonb_build_object('id','C','text','$-4$','explanation','This comes from sign errors when combining terms.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Polynomials are continuous everywhere, so the limit exists.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because polynomials are continuous, $$\lim_{x\to 3}(2x^2-5x+1)=2\cdot 3^2-5\cdot 3+1=4.$$',
  recommendation_reasons = ARRAY['Reinforces direct substitution for polynomial limits.', 'Targets common arithmetic and sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply limit laws and continuity of polynomials.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_GRAPH_LIMIT_READ'],
  primary_skill_id = 'SK_LIMIT_LAWS',
  supporting_skill_ids = ARRAY['SK_GRAPH_LIMIT_READ'],
  error_tags = ARRAY['E_READ_LIMIT_AS_VALUE', 'E_GRAPH_READ_ERROR'],
  prompt = 'Using the graph (see image 1.5-P2.png), evaluate $$\lim_{x\to 1}\left(3f(x)-2g(x)\right).$$',
  latex = 'Using the graph (see image 1.5-P2.png), evaluate $$\lim_{x\to 1}\left(3f(x)-2g(x)\right).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','This uses an incorrect limit value from the graph for either $f$ or $g$.'),
    jsonb_build_object('id','B','text','$8$','explanation','From the graph, $\lim f(x)=2$ and $\lim g(x)=-1$, so $3(2)-2(-1)=8$.'),
    jsonb_build_object('id','C','text','$-8$','explanation','This comes from a sign mistake when computing $-2g(x)$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Both $\lim_{x\to 1} f(x)$ and $\lim_{x\to 1} g(x)$ exist, so the limit exists by limit laws.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'From the graph, $$\lim_{x\to 1}f(x)=2,\quad \lim_{x\to 1}g(x)=-1.$$ By limit laws, $$\lim_{x\to 1}(3f(x)-2g(x))=3\cdot 2-2\cdot(-1)=8.$$',
  recommendation_reasons = ARRAY['Connects limit laws to graphical limit values.', 'Builds accuracy reading limits (not point values) from graphs.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: graph provides approaching values of $f$ and $g$ at $x=1$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_FUNCTION_COMPOSITION_LIMITS'],
  primary_skill_id = 'SK_LIMIT_LAWS',
  supporting_skill_ids = ARRAY['SK_FUNCTION_COMPOSITION_LIMITS'],
  error_tags = ARRAY['E_MISAPPLY_LIMIT_LAWS', 'E_POWER_RULE_MISUSE'],
  prompt = 'Suppose $$\lim_{x\to 2}f(x)=5\quad\text{and}\quad \lim_{x\to 2}g(x)=-3.$$ Evaluate $$\lim_{x\to 2}\frac{(f(x))^2}{g(x)+7}.$$',
  latex = 'Suppose $$\lim_{x\to 2}f(x)=5\quad\text{and}\quad \lim_{x\to 2}g(x)=-3.$$ Evaluate $$\lim_{x\to 2}\frac{(f(x))^2}{g(x)+7}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{10}{4}$','explanation','This incorrectly treats $(f(x))^2$ as $2f(x)$.'),
    jsonb_build_object('id','B','text','$\frac{25}{4}$','explanation','Compute $\frac{(5)^2}{-3+7}=\frac{25}{4}$.'),
    jsonb_build_object('id','C','text','$\frac{25}{-10}$','explanation','This mishandles the denominator limit $-3+7$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The denominator limit is $-3+7=4\neq 0$, so the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'By limit laws, $$\lim_{x\to 2}\frac{(f(x))^2}{g(x)+7}=\frac{(\lim f(x))^2}{\lim(g(x)+7)}=\frac{5^2}{-3+7}=\frac{25}{4}.$$',
  recommendation_reasons = ARRAY['Practices combining limits with powers and sums.', 'Targets the misconception squaring vs doubling.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: evaluate a composite limit using limit laws and a nonzero denominator check.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_LIMIT_EXISTENCE', 'SK_RATIONAL_LIMITS'],
  primary_skill_id = 'SK_LIMIT_EXISTENCE',
  supporting_skill_ids = ARRAY['SK_RATIONAL_LIMITS'],
  error_tags = ARRAY['E_DIVIDE_BY_ZERO_END', 'E_ASSUME_DNE_WHEN_EXISTS'],
  prompt = 'Evaluate (or state that it does not exist): $$\lim_{x\to 2}\frac{x+1}{x^2-4}.$$',
  latex = 'Evaluate (or state that it does not exist): $$\lim_{x\to 2}\frac{x+1}{x^2-4}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{3}{0}$','explanation','A limit cannot be left as division by zero; you must determine the behavior.'),
    jsonb_build_object('id','B','text','$\frac{3}{4}$','explanation','This incorrectly treats $x^2-4$ as $4$ at $x=2$.'),
    jsonb_build_object('id','C','text','Does not exist (unbounded)','explanation','Since the denominator approaches $0$ while the numerator approaches $3\neq 0$, the expression becomes unbounded.'),
    jsonb_build_object('id','D','text','$0$','explanation','This would require the numerator to approach $0$, which it does not.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Factor $x^2-4=(x-2)(x+2)$. As $x\to 2$, the numerator $x+1\to 3$ while the denominator $(x-2)(x+2)\to 0$. A nonzero number divided by something approaching $0$ becomes unbounded, so the two-sided limit does not exist.',
  recommendation_reasons = ARRAY['Builds habit of checking denominator behavior in quotient limits.', 'Distinguishes unbounded behavior from removable discontinuities.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: DNE due to infinite behavior when denominator limit is 0 and numerator limit is nonzero.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.5',
  section_id = '1.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_LIMIT_LAWS', 'SK_DIRECT_SUBSTITUTION'],
  primary_skill_id = 'SK_LIMIT_LAWS',
  supporting_skill_ids = ARRAY['SK_DIRECT_SUBSTITUTION'],
  error_tags = ARRAY['E_ARITHMETIC_SLIP', 'E_MISAPPLY_LIMIT_LAWS'],
  prompt = 'Evaluate the limit: $$\lim_{x\to -1}\frac{x^2+3x+2}{x+2}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to -1}\frac{x^2+3x+2}{x+2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This comes from an arithmetic slip in the numerator.'),
    jsonb_build_object('id','B','text','$-1$','explanation','This comes from sign errors in $1-3+2$.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','The denominator approaches $1\neq 0$, so the limit exists.'),
    jsonb_build_object('id','D','text','$0$','explanation','Direct substitution gives $\frac{1-3+2}{1}=0$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Because the denominator approaches $-1+2=1\neq 0$, substitute directly: $$\lim_{x\to -1}\frac{x^2+3x+2}{x+2}=\frac{(-1)^2+3(-1)+2}{-1+2}=\frac{0}{1}=0.$$',
  recommendation_reasons = ARRAY['Reinforces substitution when the denominator limit is nonzero.', 'Targets routine arithmetic accuracy in rational expressions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: direct substitution with a nonzero denominator at the limit point.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.5-P5';



-- Unit 1.6 (Determining Limits Using Algebraic Manipulation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_FACTOR_CANCEL'],
  primary_skill_id = 'SK_ALGEBRAIC_LIMITS',
  supporting_skill_ids = ARRAY['SK_FACTOR_CANCEL'],
  error_tags = ARRAY['E_FACTORING_ERROR', 'E_SUBSTITUTE_TOO_EARLY'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 2}\frac{x^2-4}{x-2}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 2}\frac{x^2-4}{x-2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','This comes from canceling incorrectly or simplifying to $x$ instead of $x+2$.'),
    jsonb_build_object('id','B','text','$4$','explanation','Factor $x^2-4=(x-2)(x+2)$, cancel, then substitute to get $4$.'),
    jsonb_build_object('id','C','text','$0$','explanation','This results from substituting first to get $0/0$ and stopping.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','After cancellation, the expression is continuous near $x=2$, so the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Factor: $$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2\ (x\neq 2).$$ Then $$\lim_{x\to 2}(x+2)=4.$$',
  recommendation_reasons = ARRAY['Core technique: factor and cancel to remove $0/0$.', 'Targets the common mistake of substituting before simplifying.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: resolve an indeterminate form by factoring and cancellation.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_RATIONALIZE_CONJUGATE'],
  primary_skill_id = 'SK_ALGEBRAIC_LIMITS',
  supporting_skill_ids = ARRAY['SK_RATIONALIZE_CONJUGATE'],
  error_tags = ARRAY['E_RATIONALIZE_ERROR', 'E_SUBSTITUTE_TOO_EARLY'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{2}$','explanation','Multiply by the conjugate to simplify to $\frac{1}{\sqrt{1+x}+1}$, then substitute $x=0$.'),
    jsonb_build_object('id','B','text','$1$','explanation','This ignores the conjugate simplification and overestimates the limit.'),
    jsonb_build_object('id','C','text','$0$','explanation','This comes from substituting to get $0/0$ and guessing.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','After rationalizing, the expression is continuous at $x=0$, so the limit exists.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Rationalize: $$\frac{\sqrt{1+x}-1}{x}\cdot\frac{\sqrt{1+x}+1}{\sqrt{1+x}+1}=\frac{(1+x)-1}{x(\sqrt{1+x}+1)}=\frac{1}{\sqrt{1+x}+1}.$$ Then $$\lim_{x\to 0}\frac{1}{\sqrt{1+x}+1}=\frac{1}{2}.$$',
  recommendation_reasons = ARRAY['Canonical conjugate technique used repeatedly in AP limits.', 'Builds precision with algebraic manipulation before substitution.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rationalize to remove radicals and resolve $0/0$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_RATIONALIZE_CONJUGATE'],
  primary_skill_id = 'SK_ALGEBRAIC_LIMITS',
  supporting_skill_ids = ARRAY['SK_RATIONALIZE_CONJUGATE'],
  error_tags = ARRAY['E_RATIONALIZE_ERROR', 'E_ALGEBRA_SLIP'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 3}\frac{x-3}{\sqrt{x}-\sqrt{3}}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 3}\frac{x-3}{\sqrt{x}-\sqrt{3}}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\sqrt{3}$','explanation','This misses the factor of $2\sqrt{3}$ after simplifying to $\sqrt{x}+\sqrt{3}$.'),
    jsonb_build_object('id','B','text','$2\sqrt{3}$','explanation','Multiply by the conjugate to cancel $x-3$, then substitute to get $2\sqrt{3}$.'),
    jsonb_build_object('id','C','text','$6$','explanation','This incorrectly replaces $\sqrt{3}$ with $3$ in the final step.'),
    jsonb_build_object('id','D','text','$\frac{1}{2\sqrt{3}}$','explanation','This is the reciprocal of the simplified expression.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Multiply by the conjugate: $$\frac{x-3}{\sqrt{x}-\sqrt{3}}\cdot\frac{\sqrt{x}+\sqrt{3}}{\sqrt{x}+\sqrt{3}}=\frac{(x-3)(\sqrt{x}+\sqrt{3})}{x-3}=\sqrt{x}+\sqrt{3}.$$ Then $$\lim_{x\to 3}(\sqrt{x}+\sqrt{3})=2\sqrt{3}.$$',
  recommendation_reasons = ARRAY['Rationalization with a difference of square roots in the denominator.', 'Checks symbolic precision with radicals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: conjugate cancels the factor created by a difference of squares.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMITS', 'SK_FACTOR_CANCEL'],
  primary_skill_id = 'SK_ALGEBRAIC_LIMITS',
  supporting_skill_ids = ARRAY['SK_FACTOR_CANCEL'],
  error_tags = ARRAY['E_FACTORING_ERROR', 'E_SUBSTITUTE_TOO_EARLY'],
  prompt = 'Evaluate the limit: $$\lim_{x\to 1}\frac{x^3-1}{x-1}.$$',
  latex = 'Evaluate the limit: $$\lim_{x\to 1}\frac{x^3-1}{x-1}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This comes from incorrect cancellation or substituting too early.'),
    jsonb_build_object('id','B','text','$2$','explanation','This results from factoring $x^3-1$ incorrectly.'),
    jsonb_build_object('id','C','text','$3$','explanation','Use $x^3-1=(x-1)(x^2+x+1)$, cancel, then substitute $x=1$ to get $3$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','This is a removable discontinuity, so the limit exists.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Difference of cubes: $$x^3-1=(x-1)(x^2+x+1).$$ Then $$\frac{x^3-1}{x-1}=x^2+x+1\ (x\neq 1),$$ so $$\lim_{x\to 1}\frac{x^3-1}{x-1}=1^2+1+1=3.$$',
  recommendation_reasons = ARRAY['Reinforces special factoring (difference of cubes).', 'Extends factor-cancel technique beyond quadratics.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: factor using $a^3-b^3$ and cancel to evaluate the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.6',
  section_id = '1.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_CONTINUITY_REMOVABLE', 'SK_GRAPH_LIMIT_READ'],
  primary_skill_id = 'SK_CONTINUITY_REMOVABLE',
  supporting_skill_ids = ARRAY['SK_GRAPH_LIMIT_READ'],
  error_tags = ARRAY['E_CONFUSE_LIMIT_WITH_VALUE', 'E_READ_LIMIT_AS_VALUE'],
  prompt = 'A function has the graph shown (see image 1.6-P5.png). What value should be defined at $x=3$ to make the function continuous at $x=3$?',
  latex = 'A function has the graph shown (see image 1.6-P5.png). What value should be defined at $x=3$ to make the function continuous at $x=3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','This confuses the input value with the output needed for continuity.'),
    jsonb_build_object('id','B','text','$6$','explanation','The hole is at $(3,6)$, so define $f(3)=6$ to match the limit.'),
    jsonb_build_object('id','C','text','$0$','explanation','This would not match the approaching value on the graph.'),
    jsonb_build_object('id','D','text','No value works','explanation','A removable discontinuity can be fixed by setting the point equal to the limit.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'To make $f$ continuous at $x=3$, define $f(3)$ to equal the two-sided limit. The graph shows a hole at $(3,6)$, so $$\lim_{x\to 3}f(x)=6$$ and the required definition is $f(3)=6$.',
  recommendation_reasons = ARRAY['Connects continuity to the definition $f(a)=\lim_{x\to a}f(x)$.', 'Targets confusion between limit value and function value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image required: identify the hole’s $y$-value and set $f(3)$ equal to the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.6-P5';
