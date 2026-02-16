-- Unit 3.3 & 3.4 SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 3.3 (Differentiating Inverse Functions) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.3',
  section_id = '3.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_INVERSE_DERIV', 'SK_EVAL_AT_POINT'],
  primary_skill_id = 'SK_INVERSE_DERIV',
  supporting_skill_ids = ARRAY['SK_EVAL_AT_POINT'],

  error_tags = ARRAY['E_FORGET_RECIPROCAL', 'E_EVAL_WRONG_POINT'],
  prompt = 'A differentiable one-to-one function $f$ satisfies $f(1)=4$ and $f''(1)=-2$. What is $(f^{-1})''(4)$?',
  latex = 'A differentiable one-to-one function $f$ satisfies $f(1)=4$ and $f''(1)=-2$. What is $(f^{-1})''(4)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2$','explanation','This uses $f''(1)$ instead of the reciprocal relationship for the inverse derivative.'),
    jsonb_build_object('id','B','text','$-\\dfrac{1}{2}$','explanation','Correct: $f^{-1}(4)=1$, so $(f^{-1})''(4)=\\dfrac{1}{f''(1)}=\\dfrac{1}{-2}=-\\dfrac{1}{2}$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{2}$','explanation','This drops the negative sign from $f''(1)=-2$.'),
    jsonb_build_object('id','D','text','$-2$','explanation','This forgets to take the reciprocal.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use $(f^{-1})''(y)=\\dfrac{1}{f''(f^{-1}(y))}$. Since $f(1)=4$, $f^{-1}(4)=1$. Therefore\n$$ (f^{-1})''(4)=\\frac{1}{f''(1)}=\\frac{1}{-2}=-\\frac{1}{2}. $$',
  recommendation_reasons = ARRAY['Applies the inverse-derivative formula with correct point-matching.', 'Targets the frequent reciprocal vs. direct-slope mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key step: identify $f^{-1}(4)=1$ before using the reciprocal.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.3',
  section_id = '3.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_INVERSE_DERIV', 'SK_GRAPH_INTERPRETATION', 'SK_EVAL_AT_POINT'],
  primary_skill_id = 'SK_INVERSE_DERIV',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION', 'SK_EVAL_AT_POINT'],
 'SK_EVAL_AT_POINT'], 'SK_EVAL_AT_POINT'],
  error_tags = ARRAY['E_EVAL_WRONG_POINT', 'E_FORGET_RECIPROCAL'],
  prompt = 'The graph of a one-to-one function $y=f(x)$ and the line $y=x$ are shown in the figure labeled 3.3-P2. The point $(2,3)$ lies on $y=f(x)$ and $f''(2)=6$. What is $(f^{-1})''(3)$?',
  latex = 'The graph of a one-to-one function $y=f(x)$ and the line $y=x$ are shown in the figure labeled 3.3-P2. The point $(2,3)$ lies on $y=f(x)$ and $f''(2)=6$. What is $(f^{-1})''(3)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$6$','explanation','This uses $f''(2)$ instead of the reciprocal required for the inverse derivative.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{3}$','explanation','This incorrectly uses the output value $3$ as the input to $f''(\\cdot)$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{6}$','explanation','Correct: $f^{-1}(3)=2$, so $(f^{-1})''(3)=\\dfrac{1}{f''(2)}=\\dfrac{1}{6}$.'),
    jsonb_build_object('id','D','text','$\\dfrac{1}{2}$','explanation','This is not tied to the given slope value $6$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $f(2)=3$, we have $f^{-1}(3)=2$. Then\n$$ (f^{-1})''(3)=\\frac{1}{f''(f^{-1}(3))}=\\frac{1}{f''(2)}=\\frac{1}{6}. $$',
  recommendation_reasons = ARRAY['Connects point on $f$ to the matching point on $f^{-1}$.', 'Reinforces evaluating $f''$ at the correct input.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based: first read $f^{-1}(3)=2$, then take reciprocal.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.3',
  section_id = '3.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_INVERSE_DERIV', 'SK_SOLVE_FOR_INPUT', 'SK_ALGEBRAIC_SIMPLIFY'],
  primary_skill_id = 'SK_INVERSE_DERIV',
  supporting_skill_ids = ARRAY['SK_SOLVE_FOR_INPUT', 'SK_ALGEBRAIC_SIMPLIFY'],
 'SK_ALGEBRAIC_SIMPLIFY'], 'SK_ALGEBRAIC_SIMPLIFY'],
  error_tags = ARRAY['E_EVAL_WRONG_POINT', 'E_DROP_TERM', 'E_FORGET_RECIPROCAL'],
  prompt = 'Let $f(x)=x^3+x$ and let $g(x)=f^{-1}(x)$. What is $g''(0)$?',
  latex = 'Let $f(x)=x^3+x$ and let $g(x)=f^{-1}(x)$. What is $g''(0)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This incorrectly assumes $f''(0)=0$ implies the inverse derivative is $0$.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{3}$','explanation','This drops the $+1$ term from $f''(x)=3x^2+1$.'),
    jsonb_build_object('id','C','text','$3$','explanation','This uses $f''(0)$ instead of the reciprocal relationship.'),
    jsonb_build_object('id','D','text','$1$','explanation','Correct: $g(0)=0$ since $f(0)=0$, and $g''(0)=\\dfrac{1}{f''(0)}=\\dfrac{1}{1}=1$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'First solve $f(x)=0$: $x^3+x=x(x^2+1)=0\\Rightarrow x=0$, so $g(0)=0$. Next $f''(x)=3x^2+1$, so $f''(0)=1$. Therefore\n$$ g''(0)=\\frac{1}{f''(g(0))}=\\frac{1}{f''(0)}=1. $$',
  recommendation_reasons = ARRAY['Forces the two-step process: find $g(0)$, then evaluate $f''$ there.', 'Targets dropping terms in $f''(x)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Emphasize: do not plug $y=0$ directly into $f''$; find the matching $x$ first.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.3',
  section_id = '3.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INVERSE_DERIV', 'SK_LOG_EXP_INVERSES', 'SK_EVAL_AT_POINT'],
  primary_skill_id = 'SK_INVERSE_DERIV',
  supporting_skill_ids = ARRAY['SK_LOG_EXP_INVERSES', 'SK_EVAL_AT_POINT'],
 'SK_EVAL_AT_POINT'], 'SK_EVAL_AT_POINT'],
  error_tags = ARRAY['E_EVAL_WRONG_POINT', 'E_FORGET_RECIPROCAL', 'E_VALUE_VS_DERIV'],
  prompt = 'Let $f(x)=\\ln(x+2)$. What is $(f^{-1})''(0)$?',
  latex = 'Let $f(x)=\\ln(x+2)$. What is $(f^{-1})''(0)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','Correct: $f^{-1}(0)=-1$, $f''(-1)=1$, so $(f^{-1})''(0)=1/f''(-1)=1$.'),
    jsonb_build_object('id','B','text','$-1$','explanation','This confuses $f^{-1}(0)=-1$ with $(f^{-1})''(0)$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{2}$','explanation','This incorrectly evaluates $f''(0)=1/2$ instead of evaluating at $x=f^{-1}(0)=-1$.'),
    jsonb_build_object('id','D','text','$-\\dfrac{1}{2}$','explanation','This combines a wrong evaluation point with a sign error.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Find $f^{-1}(0)$ by solving $\\ln(x+2)=0\\Rightarrow x+2=1\\Rightarrow x=-1$. Then $f''(x)=\\dfrac{1}{x+2}$, so $f''(-1)=1$. Hence\n$$ (f^{-1})''(0)=\\frac{1}{f''(f^{-1}(0))}=\\frac{1}{f''(-1)}=1. $$',
  recommendation_reasons = ARRAY['Checks solving $f(x)=y$ before applying the inverse-derivative formula.', 'Targets the common value-vs-derivative confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key trap: $(f^{-1})(0)$ is a value, not the derivative.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.3',
  section_id = '3.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_INVERSE_DERIV', 'SK_RECIPROCAL_REASONING'],
  primary_skill_id = 'SK_INVERSE_DERIV',
  supporting_skill_ids = ARRAY['SK_RECIPROCAL_REASONING'],

  error_tags = ARRAY['E_FORGET_RECIPROCAL', 'E_EVAL_WRONG_POINT'],
  prompt = 'A differentiable one-to-one function $f$ satisfies $f(3)=1$ and $(f^{-1})''(1)=4$. What is $f''(3)$?',
  latex = 'A differentiable one-to-one function $f$ satisfies $f(3)=1$ and $(f^{-1})''(1)=4$. What is $f''(3)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','This forgets that inverse derivatives are reciprocals at matched points.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{4}$','explanation','Correct: $(f^{-1})''(1)=\\dfrac{1}{f''(3)}$, so $4=\\dfrac{1}{f''(3)}\\Rightarrow f''(3)=\\dfrac{1}{4}$.'),
    jsonb_build_object('id','C','text','$-\\dfrac{1}{4}$','explanation','No sign information is given; a negative value is not forced.'),
    jsonb_build_object('id','D','text','$\\dfrac{3}{4}$','explanation','This incorrectly mixes the input value $3$ into the reciprocal step.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $f(3)=1$, we know $f^{-1}(1)=3$. Then\n$$ (f^{-1})''(1)=\\frac{1}{f''(f^{-1}(1))}=\\frac{1}{f''(3)}. $$\nGiven $(f^{-1})''(1)=4$, solve $4=\\dfrac{1}{f''(3)}$ to get $f''(3)=\\dfrac{1}{4}$.',
  recommendation_reasons = ARRAY['Reinforces reversing the inverse-derivative formula to recover $f''(a)$.', 'Targets the common non-reciprocal mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Fast reciprocal reasoning; good for timing discipline.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.3-P5';


-- Unit 3.4 (Differentiating Inverse Trigonometric Functions) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.4',
  section_id = '3.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIV', 'SK_CHAIN_RULE', 'SK_ALGEBRAIC_SIMPLIFY'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIV',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE', 'SK_ALGEBRAIC_SIMPLIFY'],
 'SK_ALGEBRAIC_SIMPLIFY'], 'SK_ALGEBRAIC_SIMPLIFY'],
  error_tags = ARRAY['E_MISSING_CHAIN', 'E_SIGN_ERROR', 'E_RADICAL_FORM'],
  prompt = 'Find $\\dfrac{d}{dx}\\big(\\arccos(2x)\\big)$.',
  latex = 'Find $\\dfrac{d}{dx}\\big(\\arccos(2x)\\big)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{2}{\\sqrt{1-4x^2}}$','explanation','This misses the negative sign for $\\arccos(u)$.'),
    jsonb_build_object('id','B','text','$-\\dfrac{1}{\\sqrt{1-4x^2}}$','explanation','This includes the negative sign but misses the chain factor $2$.'),
    jsonb_build_object('id','C','text','$-\\dfrac{2}{\\sqrt{1-4x^2}}$','explanation','Correct: $u=2x$ gives $u''=2$, so derivative is $-2/\\sqrt{1-(2x)^2}$.'),
    jsonb_build_object('id','D','text','$-\\dfrac{2}{\\sqrt{4x^2-1}}$','explanation','This changes the expression under the radical and is not equivalent.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $u=2x$. Then\n$$\\frac{d}{dx}\\arccos(u)=-\\frac{u''}{\\sqrt{1-u^2}}=-\\frac{2}{\\sqrt{1-(2x)^2}}=-\\frac{2}{\\sqrt{1-4x^2}}.$$',
  recommendation_reasons = ARRAY['Standard inverse trig derivative combined with chain rule.', 'Targets sign and chain-factor errors common on AP.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Must know: $\\arccos$ derivative is negative.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.4',
  section_id = '3.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIV', 'SK_CHAIN_RULE', 'SK_ALGEBRAIC_SIMPLIFY'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIV',
  supporting_skill_ids = ARRAY['SK_CHAIN_RULE', 'SK_ALGEBRAIC_SIMPLIFY'],
 'SK_ALGEBRAIC_SIMPLIFY'], 'SK_ALGEBRAIC_SIMPLIFY'],
  error_tags = ARRAY['E_MISSING_CHAIN', 'E_ALGEBRA_SIMPLIFY'],
  prompt = 'Find $\\dfrac{d}{dx}\\left(\\arctan\\left(\\dfrac{1}{x}\\right)\\right)$ for $x\\ne 0$.',
  latex = 'Find $\\dfrac{d}{dx}\\left(\\arctan\\left(\\dfrac{1}{x}\\right)\\right)$ for $x\\ne 0$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\dfrac{1}{1+x^2}$','explanation','Correct: with $u=1/x$, $u''=-1/x^2$ and $\\dfrac{u''}{1+u^2}=\\dfrac{-1/x^2}{1+1/x^2}=-\\dfrac{1}{1+x^2}$.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{1+x^2}$','explanation','This drops the negative sign from $u''=-1/x^2$.'),
    jsonb_build_object('id','C','text','$-\\dfrac{1}{x^2}$','explanation','This differentiates only the inner function and ignores the outer $\\arctan$ factor.'),
    jsonb_build_object('id','D','text','$\\dfrac{1}{1+\\frac{1}{x^2}}$','explanation','This applies the outer rule but ignores multiplying by $u''=-1/x^2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=\\dfrac{1}{x}$. Then $u''=-\\dfrac{1}{x^2}$. Using $\\dfrac{d}{dx}\\arctan(u)=\\dfrac{u''}{1+u^2}$,\n$$\\frac{d}{dx}\\arctan\\left(\\frac{1}{x}\\right)=\\frac{-1/x^2}{1+1/x^2}=\\frac{-1/x^2}{(x^2+1)/x^2}=-\\frac{1}{x^2+1}.$$',
  recommendation_reasons = ARRAY['Combines inverse trig derivative with nontrivial algebra simplification.', 'Directly targets a common complex-fraction mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key step: simplify complex fractions correctly after applying chain rule.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.4',
  section_id = '3.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIV', 'SK_GRAPH_INTERPRETATION', 'SK_EVAL_AT_POINT'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIV',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION', 'SK_EVAL_AT_POINT'],
 'SK_EVAL_AT_POINT'], 'SK_EVAL_AT_POINT'],
  error_tags = ARRAY['E_EVAL_WRONG_POINT', 'E_VALUE_VS_DERIV'],
  prompt = 'The graph of $y=\\arctan(x)$ is shown in the figure labeled 3.4-P3, with the point $(1,\\arctan(1))$ marked. What is the slope of the tangent line at $x=1$?',
  latex = 'The graph of $y=\\arctan(x)$ is shown in the figure labeled 3.4-P3, with the point $(1,\\arctan(1))$ marked. What is the slope of the tangent line at $x=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This is the slope at $x=0$, not at $x=1$.'),
    jsonb_build_object('id','B','text','$2$','explanation','This is the reciprocal of the correct value.'),
    jsonb_build_object('id','C','text','$\\dfrac{\\pi}{4}$','explanation','This is $\\arctan(1)$, a function value, not the derivative.'),
    jsonb_build_object('id','D','text','$\\dfrac{1}{2}$','explanation','Correct: $\\dfrac{d}{dx}\\arctan(x)=\\dfrac{1}{1+x^2}$, so at $x=1$ the slope is $\\dfrac{1}{2}$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $\\dfrac{d}{dx}\\arctan(x)=\\dfrac{1}{1+x^2}$, evaluate at $x=1$:\n$$\\arctan''(1)=\\frac{1}{1+1^2}=\\frac{1}{2}.$$',
  recommendation_reasons = ARRAY['Separates function value from derivative at a point.', 'Builds quick evaluation fluency for $\\arctan''(x)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based: point label uses $\\pi/4$ but slope is $1/2$.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.4',
  section_id = '3.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIV', 'SK_ALGEBRAIC_SIMPLIFY'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIV',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFY'],

  error_tags = ARRAY['E_SIGN_ERROR', 'E_DROP_TERM'],
  prompt = 'For $-1<x<1$, what is $\\dfrac{d}{dx}\\big(\\arcsin(x)+\\arccos(x)\\big)$?',
  latex = 'For $-1<x<1$, what is $\\dfrac{d}{dx}\\big(\\arcsin(x)+\\arccos(x)\\big)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{2}{\\sqrt{1-x^2}}$','explanation','This ignores that the derivatives have opposite signs.'),
    jsonb_build_object('id','B','text','$0$','explanation','Correct: $\\dfrac{1}{\\sqrt{1-x^2}}-\\dfrac{1}{\\sqrt{1-x^2}}=0$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{\\sqrt{1-x^2}}$','explanation','This differentiates only $\\arcsin(x)$ and ignores the $\\arccos(x)$ term.'),
    jsonb_build_object('id','D','text','$-\\dfrac{2}{\\sqrt{1-x^2}}$','explanation','This treats both derivatives as negative.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate term-by-term:\n$$\\frac{d}{dx}\\arcsin(x)=\\frac{1}{\\sqrt{1-x^2}},\\qquad \\frac{d}{dx}\\arccos(x)=-\\frac{1}{\\sqrt{1-x^2}}.$$ \nSo the sum differentiates to $0$.',
  recommendation_reasons = ARRAY['Reinforces the opposite-sign relationship for $\\arcsin$ and $\\arccos$ derivatives.', 'Targets a high-frequency sign trap.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Classic cancellation; emphasize the negative on $\\arccos''(x)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Composite',
  sub_topic_id = '3.4',
  section_id = '3.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_INVERSE_TRIG_DERIV', 'SK_DOMAIN_RESTRICTIONS', 'SK_EVAL_AT_POINT'],
  primary_skill_id = 'SK_INVERSE_TRIG_DERIV',
  supporting_skill_ids = ARRAY['SK_DOMAIN_RESTRICTIONS', 'SK_EVAL_AT_POINT'],
 'SK_EVAL_AT_POINT'], 'SK_EVAL_AT_POINT'],
  error_tags = ARRAY['E_ABS_VALUE_MISSED', 'E_SIGN_ERROR', 'E_RADICAL_FORM'],
  prompt = 'Let $h(x)=\\operatorname{arccsc}(x)$ for $|x|>1$. What is $h''(2)$?',
  latex = 'Let $h(x)=\\operatorname{arccsc}(x)$ for $|x|>1$. What is $h''(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\dfrac{1}{2\\sqrt{3}}$','explanation','Correct: $h''(x)=-\\dfrac{1}{|x|\\sqrt{x^2-1}}$, so $h''(2)=-\\dfrac{1}{2\\sqrt{3}}$.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{2\\sqrt{3}}$','explanation','This misses the negative sign in the derivative formula.'),
    jsonb_build_object('id','C','text','$-\\dfrac{1}{\\sqrt{3}}$','explanation','This ignores the $|x|$ factor in the denominator.'),
    jsonb_build_object('id','D','text','$-\\dfrac{1}{2\\sqrt{5}}$','explanation','This uses $\\sqrt{x^2+1}$ instead of $\\sqrt{x^2-1}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use\n$$\\frac{d}{dx}\\operatorname{arccsc}(x)=-\\frac{1}{|x|\\sqrt{x^2-1}}.$$ \nAt $x=2$, $|2|=2$ and $\\sqrt{2^2-1}=\\sqrt{3}$, so\n$$h''(2)=-\\frac{1}{2\\sqrt{3}}.$$',
  recommendation_reasons = ARRAY['Tests advanced inverse trig derivative with absolute value.', 'Targets a common AP BC trap: forgetting $|x|$ in the denominator.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Emphasize absolute value and $x^2-1$ under the radical.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Composite',
  updated_at = NOW()
WHERE title = '3.4-P5';

END $block$;
