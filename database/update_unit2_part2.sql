
-- Unit 2.5 (Applying the Power Rule) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.5',
  section_id = '2.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_POWER_RULE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_POWER_EXPONENT', 'E_SIGN_DISTRIBUTION'],
  prompt = 'Differentiate the function $f(x)=7x^4-3x^2+5$.',
  latex = 'Differentiate the function $f(x)=7x^4-3x^2+5$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f''(x)=28x^3-6x$','explanation','Apply the power rule to each term: $(7x^4)''=28x^3$, $(-3x^2)''=-6x$, and $(5)''=0.'),
    jsonb_build_object('id','B','text','$f''(x)=28x^3-6x+5$','explanation','Incorrect: constants differentiate to $0$, not $5$.'),
    jsonb_build_object('id','C','text','$f''(x)=7\\cdot4x^4-3\\cdot2x^2$','explanation','Incorrect: the exponent must decrease by $1$; this leaves exponents unchanged.'),
    jsonb_build_object('id','D','text','$f''(x)=28x^3-3x$','explanation','Incorrect: $(x^2)''=2x$, so $(-3x^2)''=-6x$, not $-3x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Using linearity and the power rule, $$f''(x)= (7x^4)''-(3x^2)''+(5)''=28x^3-6x+0=28x^3-6x.$$',
  recommendation_reasons = ARRAY['Checks correct exponent reduction in the power rule.', 'Reinforces that constants vanish under differentiation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply the power rule term-by-term and handle constants correctly.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.5',
  section_id = '2.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_POWER_RULE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_POWER_EXPONENT', 'E_SIMPLIFY_FIRST'],
  prompt = 'Let $g(x)=\\dfrac{5}{x^3}-2\\sqrt{x}$. What is $g''(x)$?',
  latex = 'Let $g(x)=\\dfrac{5}{x^3}-2\\sqrt{x}$. What is $g''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$g''(x)=\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$','explanation','Incorrect: differentiating $x^{-3}$ introduces a negative factor, so the first term should be negative.'),
    jsonb_build_object('id','B','text','$g''(x)=-\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$','explanation','Rewrite as $5x^{-3}-2x^{1/2}$. Then $g''(x)=5(-3)x^{-4}-2\\cdot\\frac12 x^{-1/2}=-15x^{-4}-x^{-1/2}=-\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$.'),
    jsonb_build_object('id','C','text','$g''(x)=-\\dfrac{15}{x^2}-\\dfrac{1}{\\sqrt{x}}$','explanation','Incorrect: $x^{-3}$ becomes $x^{-4}$ after differentiation, not $x^{-2}$.'),
    jsonb_build_object('id','D','text','$g''(x)=-\\dfrac{15}{x^4}+\\dfrac{1}{\\sqrt{x}}$','explanation','Incorrect: $\\dfrac{d}{dx}(-2\\sqrt{x})$ is negative, so the second term should be $-\\dfrac{1}{\\sqrt{x}}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Convert to exponents: $$g(x)=5x^{-3}-2x^{1/2}.$$ Differentiate: $$g''(x)=-15x^{-4}-x^{-1/2}=-\\frac{15}{x^4}-\\frac{1}{\\sqrt{x}}.$$',
  recommendation_reasons = ARRAY['Targets negative and fractional exponents.', 'Common AP error: exponent decreases incorrectly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rewrite radicals/fractions as powers, then apply the power rule cleanly.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.5',
  section_id = '2.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY', 'SK_EVAL_AT_POINT'],
  primary_skill_id = 'SK_POWER_RULE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY', 'SK_EVAL_AT_POINT'],
  error_tags = ARRAY['E_POWER_EXPONENT', 'E_EVAL_AT_POINT', 'E_SIMPLIFY_FIRST'],
  prompt = 'A function is defined by $h(x)=x^2(3x^3-4x+1)$. Using only the power rule and algebra (no product rule), find $h''(1)$.',
  latex = 'A function is defined by $h(x)=x^2(3x^3-4x+1)$. Using only the power rule and algebra (no product rule), find $h''(1)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$11$','explanation','Incorrect: this often comes from an expansion or evaluation mistake.'),
    jsonb_build_object('id','B','text','$6$','explanation','Incorrect: this typically results from dropping a term after expanding.'),
    jsonb_build_object('id','C','text','$7$','explanation','Incorrect: expanding gives $h(x)=3x^5-4x^3+x^2$ and differentiating gives $h''(1)=5$, not $7$.'),
    jsonb_build_object('id','D','text','$5$','explanation','Expand: $h(x)=3x^5-4x^3+x^2$. Then $h''(x)=15x^4-12x^2+2x$, so $h''(1)=15-12+2=5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Because the instruction forbids the product rule, expand first: $$h(x)=x^2(3x^3-4x+1)=3x^5-4x^3+x^2.$$ Then $$h''(x)=15x^4-12x^2+2x,$$ so $$h''(1)=15-12+2=5.$$',
  recommendation_reasons = ARRAY['Assesses flexibility: power rule + algebra instead of product rule.', 'Highlights careful evaluation after differentiating.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: expand first, then use power rule and evaluate accurately.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.5',
  section_id = '2.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_POWER_RULE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_FRACTIONAL_EXPONENT', 'E_POWER_EXPONENT'],
  prompt = 'Differentiate $p(x)=x^{1/3}$.',
  latex = 'Differentiate $p(x)=x^{1/3}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$p''(x)=\\dfrac{1}{3}x^{1/3}$','explanation','Incorrect: the exponent must decrease by $1$.'),
    jsonb_build_object('id','B','text','$p''(x)=\\dfrac{1}{3}x^{-2/3}$','explanation','Correct: $\\dfrac{d}{dx}x^{1/3}=\\dfrac{1}{3}x^{1/3-1}=\\dfrac{1}{3}x^{-2/3}$.'),
    jsonb_build_object('id','C','text','$p''(x)=3x^{-2/3}$','explanation','Incorrect: multiply by $1/3$, not $3$.'),
    jsonb_build_object('id','D','text','$p''(x)=\\dfrac{1}{x^{2/3}}$','explanation','Incorrect: missing the factor $\\dfrac{1}{3}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use the power rule: $$p''(x)=\\frac{1}{3}x^{-2/3}.$$',
  recommendation_reasons = ARRAY['Quick check of fractional exponent handling.', 'Common mistake: forgetting the coefficient $\\frac{1}{3}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply the power rule with a fractional exponent.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.5',
  section_id = '2.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_POWER_RULE',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_POWER_EXPONENT', 'E_SIGN_DISTRIBUTION'],
  prompt = 'If $f(x)=\\dfrac{2x^5-3x^2}{x}$ for $x\\ne 0$, what is $f''(x)$?',
  latex = 'If $f(x)=\\dfrac{2x^5-3x^2}{x}$ for $x\\ne 0$, what is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f''(x)=10x^3-6$','explanation','Incorrect: simplifying gives $f(x)=2x^4-3x$, so $f''(x)=8x^3-3$, not this.'),
    jsonb_build_object('id','B','text','$f''(x)=8x^3-3$','explanation','Correct: simplify first: $f(x)=2x^4-3x$. Differentiate: $f''(x)=8x^3-3$.'),
    jsonb_build_object('id','C','text','$f''(x)=8x^3-\\dfrac{3}{x^2}$','explanation','Incorrect: after dividing by $x$, the second term becomes $-3x$, not $-3/x$.'),
    jsonb_build_object('id','D','text','$f''(x)=\\dfrac{10x^4-6x}{x}$','explanation','Incorrect: differentiating the numerator and dividing by $x$ is not valid unless you use the quotient rule.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Simplify: $$f(x)=\\frac{2x^5}{x}-\\frac{3x^2}{x}=2x^4-3x.$$ Then $$f''(x)=8x^3-3.$$',
  recommendation_reasons = ARRAY['Reinforces simplifying before differentiating.', 'Avoids a common invalid shortcut with fractions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: simplify algebraically, then apply the power rule.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.5-P5';



-- Unit 2.6 (Derivative Rules: Constant, Sum, Difference) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.6',
  section_id = '2.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_DERIV_LINEARITY', 'SK_POWER_RULE'],
  primary_skill_id = 'SK_DERIV_LINEARITY',
  supporting_skill_ids = ARRAY['SK_POWER_RULE'],
  error_tags = ARRAY['E_LINEARITY_DISTRIBUTE', 'E_CONST_MULTIPLE'],
  prompt = 'If $f''(x)=4x-1$ and $g''(x)=3x^2$, what is $\\dfrac{d}{dx}\\,[2f(x)-5g(x)]$?',
  latex = 'If $f''(x)=4x-1$ and $g''(x)=3x^2$, what is $\\dfrac{d}{dx}\\,[2f(x)-5g(x)]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2(4x-1)-5(3x^2)=8x-2-15x^2$','explanation','Correct: use linearity: $(af+bg)''=af''+bg''$.'),
    jsonb_build_object('id','B','text','$2(4x-1)-5(3x)=8x-2-15x$','explanation','Incorrect: $g''(x)$ is $3x^2$, not $3x$.'),
    jsonb_build_object('id','C','text','$(2f(x)-5g(x))''=2f(x)-5g(x)$','explanation','Incorrect: you must differentiate; the expression does not stay the same.'),
    jsonb_build_object('id','D','text','$2(4x)-5(3x^2)=8x-15x^2$','explanation','Incorrect: dropped the $-1$ term from $f''(x)=4x-1$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Linearity gives $$\\frac{d}{dx}[2f(x)-5g(x)]=2f''(x)-5g''(x)=2(4x-1)-5(3x^2)=8x-2-15x^2.$$',
  recommendation_reasons = ARRAY['Direct test of constant multiple and difference rules.', 'Targets common mistake: dropping constant terms in a derivative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply linearity directly using given derivative information.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.6',
  section_id = '2.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 55,
  skill_tags = ARRAY['SK_CONST_RULE', 'SK_DERIV_LINEARITY'],
  primary_skill_id = 'SK_CONST_RULE',
  supporting_skill_ids = ARRAY['SK_DERIV_LINEARITY'],
  error_tags = ARRAY['E_CONST_NOT_ZERO', 'E_LINEARITY_DISTRIBUTE'],
  prompt = 'Let $F(x)=9-\\pi x+\\sqrt{2}$. What is $F''(x)$?',
  latex = 'Let $F(x)=9-\\pi x+\\sqrt{2}$. What is $F''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$F''(x)=-\\pi$','explanation','Correct: constants differentiate to $0$, and $( -\\pi x)''=-\\pi$.'),
    jsonb_build_object('id','B','text','$F''(x)=9-\\pi+\\sqrt{2}$','explanation','Incorrect: you did not differentiate the constants.'),
    jsonb_build_object('id','C','text','$F''(x)=-\\pi x$','explanation','Incorrect: derivative of $-\\pi x$ is the constant $-\\pi$.'),
    jsonb_build_object('id','D','text','$F''(x)=\\pi$','explanation','Incorrect: sign error; derivative of $-\\pi x$ is $-\\pi$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use the constant rule and linearity: $$F''(x)=(9)''-(\\pi x)''+(\\sqrt2)''=0-\\pi+0=-\\pi.$$',
  recommendation_reasons = ARRAY['High-frequency AP skill: constants vanish.', 'Targets sign mistakes with negative linear terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: constants differentiate to $0$; derivative of $ax$ is $a$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.6',
  section_id = '2.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_DERIV_LINEARITY', 'SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_DERIV_LINEARITY',
  supporting_skill_ids = ARRAY['SK_POWER_RULE', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_LINEARITY_DISTRIBUTE', 'E_POWER_EXPONENT'],
  prompt = 'If $f(x)=3x^4-2x^3+x$ and $g(x)=x^4+5$, what is $(f-g)''(x)$?',
  latex = 'If $f(x)=3x^4-2x^3+x$ and $g(x)=x^4+5$, what is $(f-g)''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2x^3-6x^2+1$','explanation','Incorrect: missing factors from the power rule on $x^4$ terms.'),
    jsonb_build_object('id','B','text','$12x^3-6x^2+1$','explanation','Incorrect: this is $f''(x)$ only; you must subtract $g''(x)$.'),
    jsonb_build_object('id','C','text','$8x^3-6x^2+1$','explanation','Correct: $(f-g)''=f''-g''$. Here $f''(x)=12x^3-6x^2+1$, $g''(x)=4x^3$, so $12x^3-6x^2+1-4x^3=8x^3-6x^2+1$.'),
    jsonb_build_object('id','D','text','$16x^3-6x^2+1$','explanation','Incorrect: added $g''(x)$ instead of subtracting.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Compute derivatives: $$f''(x)=12x^3-6x^2+1,\\quad g''(x)=4x^3.$$ Then $$(f-g)''(x)=f''(x)-g''(x)=8x^3-6x^2+1.$$',
  recommendation_reasons = ARRAY['Targets a common error: subtracting functions but not subtracting derivatives.', 'Combines linearity with power rule fluency.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply $(f-g)''=f''-g''$ and keep signs consistent.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.6',
  section_id = '2.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DERIV_LINEARITY', 'SK_EVAL_AT_POINT', 'SK_POWER_RULE'],
  primary_skill_id = 'SK_DERIV_LINEARITY',
  supporting_skill_ids = ARRAY['SK_EVAL_AT_POINT', 'SK_POWER_RULE'],
  error_tags = ARRAY['E_LINEARITY_DISTRIBUTE', 'E_EVAL_AT_POINT'],
  prompt = 'Suppose $f''(2)=3$ and $g''(2)=-2$. Let $H(x)=5f(x)+\\dfrac{1}{2}g(x)$. What is $H''(2)$?',
  latex = 'Suppose $f''(2)=3$ and $g''(2)=-2$. Let $H(x)=5f(x)+\\dfrac{1}{2}g(x)$. What is $H''(2)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{2}$','explanation','Incorrect: this ignores the constants multiplying $f''(2)$ and $g''(2)$.'),
    jsonb_build_object('id','B','text','$13$','explanation','Incorrect: arithmetic or sign error after applying linearity.'),
    jsonb_build_object('id','C','text','$15$','explanation','Incorrect: this is $5f''(2)$ only; it omits the $\\frac12 g''(2)$ term.'),
    jsonb_build_object('id','D','text','$14$','explanation','Correct: $H''(2)=5f''(2)+\\frac12 g''(2)=5\\cdot3+\\frac12(-2)=15-1=14$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Differentiate using linearity: $$H''(x)=5f''(x)+\\frac12 g''(x).$$ Evaluate at $x=2$: $$H''(2)=5\\cdot 3+\\frac12(-2)=15-1=14.$$',
  recommendation_reasons = ARRAY['Distinguishes function values from derivative values.', 'High-frequency AP format with tabulated/quoted derivative data.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use linearity to combine derivatives, then evaluate at a point.',
  weight_primary = 0.55,
  weight_supporting = 0.45,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.6',
  section_id = '2.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_DERIV_LINEARITY', 'SK_ALGEBRA_SIMPLIFY'],
  primary_skill_id = 'SK_DERIV_LINEARITY',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_LINEARITY_DISTRIBUTE', 'E_SIGN_DISTRIBUTION'],
  prompt = 'Let $y=(x^4-6x+9)-(2x^4+3x)$. What is $\\dfrac{dy}{dx}$?',
  latex = 'Let $y=(x^4-6x+9)-(2x^4+3x)$. What is $\\dfrac{dy}{dx}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{dy}{dx}=-x^3-9$','explanation','Incorrect: derivative of $x^4$ is $4x^3$, not $x^3$.'),
    jsonb_build_object('id','B','text','$\\dfrac{dy}{dx}=4x^3-6-(8x^3+3)$','explanation','Incorrect: you must distribute the minus sign to the entire second parenthesis or simplify first; also check signs after subtraction.'),
    jsonb_build_object('id','C','text','$\\dfrac{dy}{dx}=4x^3-9$','explanation','Incorrect: after simplification the $x^4$ terms combine to $-x^4$, so the cubic term should be negative.'),
    jsonb_build_object('id','D','text','$\\dfrac{dy}{dx}=-4x^3-9$','explanation','Correct: simplify to $y=-x^4-9x+9$, then differentiate to get $y''=-4x^3-9$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Combine like terms: $$y=(x^4-6x+9)-(2x^4+3x)=-x^4-9x+9.$$ Then $$\\frac{dy}{dx}=(-x^4)''+(-9x)''+(9)''=-4x^3-9.$$',
  recommendation_reasons = ARRAY['Focuses on correct distribution of subtraction across parentheses.', 'Common AP error: sign mistakes when combining terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: distribute subtraction, simplify, then differentiate using linearity.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.6-P5';


-- Unit 2.7 (Derivatives of cos x, sin x, e^x, and ln x) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.7',
  section_id = '2.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_DERIV_BASIC_TRANSC', 'SK_ALG_EXP_LOG'],
  primary_skill_id = 'SK_DERIV_BASIC_TRANSC',
  supporting_skill_ids = ARRAY['SK_ALG_EXP_LOG'],
  error_tags = ARRAY['E_LN_DERIV_1_OVER_X', 'E_ALG_SIMPLIFY'],
  prompt = 'Let $f(x)=3\\sin x-2\\cos x+e^x-\\ln x$ for $x>0$. What is $f''(x)$?',
  latex = 'Let $f(x)=3\\sin x-2\\cos x+e^x-\\ln x$ for $x>0$. What is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3\\cos x+2\\sin x+e^x-\\dfrac{1}{x}$','explanation','Correct: $(\\sin x)''=\\cos x$, $(\\cos x)''=-\\sin x$, $(e^x)''=e^x$, $(\\ln x)''=1/x$.'),
    jsonb_build_object('id','B','text','$3\\cos x-2\\sin x+e^x-\\dfrac{1}{x}$','explanation','Sign error: derivative of $-2\\cos x$ is $+2\\sin x$, not $-2\\sin x$.'),
    jsonb_build_object('id','C','text','$3\\cos x+2\\sin x+e^x-\\ln x$','explanation','Did not differentiate $\\ln x$; it becomes $1/x$, not $\\ln x$.'),
    jsonb_build_object('id','D','text','$3\\sin x-2\\cos x+e^x-\\dfrac{1}{x}$','explanation','Did not differentiate the trig terms; $\\sin x$ and $\\cos x$ change.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate term-by-term:
$$f''(x)=3\\cos x-2(-\\sin x)+e^x-\\dfrac{1}{x}=3\\cos x+2\\sin x+e^x-\\dfrac{1}{x}.$$',
  recommendation_reasons = ARRAY['Reinforces core derivatives of $\\sin x,\\cos x,e^x,\\ln x$.', 'Targets common sign and $\\ln x$ derivative mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: basic derivatives of $\\sin x,\\cos x,e^x,\\ln x$ with signs and constants.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.7',
  section_id = '2.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_DERIV_BASIC_TRANSC', 'SK_TRIG_IDENT'],
  primary_skill_id = 'SK_DERIV_BASIC_TRANSC',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENT'],
  error_tags = ARRAY['E_TRIG_SIGN', 'E_ALG_SIMPLIFY'],
  prompt = 'For $g(x)=\\dfrac{\\sin x}{\\cos x}$ (where defined), what is $g''(x)$ written in simplest form?',
  latex = 'For $g(x)=\\dfrac{\\sin x}{\\cos x}$ (where defined), what is $g''(x)$ written in simplest form?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{\\cos^2 x}$','explanation','Correct: $g(x)=\\tan x$, so $g''(x)=\\sec^2 x=1/\\cos^2 x$.'),
    jsonb_build_object('id','B','text','$\\dfrac{\\cos^2 x-\\sin^2 x}{\\cos^2 x}$','explanation','This simplifies to $1$, not the derivative of $\\tan x$.'),
    jsonb_build_object('id','C','text','$\\dfrac{\\cos x}{\\sin x}$','explanation','This is $\\cot x$, not the derivative.'),
    jsonb_build_object('id','D','text','$\\dfrac{\\cos x+\\sin x}{\\cos^2 x}$','explanation','Incorrect differentiation; suggests a broken quotient/product setup.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Recognize $\\dfrac{\\sin x}{\\cos x}=\\tan x$. Then
$$g''(x)=\\frac{d}{dx}(\\tan x)=\\sec^2 x=\\frac{1}{\\cos^2 x}.$$',
  recommendation_reasons = ARRAY['Checks fluency with trig rewriting to simplify differentiation.', 'Prevents identity confusion when simplifying.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: recognize $\\tan x$ and use $(\\tan x)''=\\sec^2 x$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.7',
  section_id = '2.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_DERIV_BASIC_TRANSC'],
  primary_skill_id = 'SK_DERIV_BASIC_TRANSC',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_EXP_DERIV_EX', 'E_CONST_RULE'],
  prompt = 'If $h(x)=5e^x$, what is $h''(x)$?',
  latex = 'If $h(x)=5e^x$, what is $h''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$e^x$','explanation','Dropped the constant 5; constants remain as factors.'),
    jsonb_build_object('id','B','text','$5e^x$','explanation','Correct: constant multiple rule and $(e^x)''=e^x$.'),
    jsonb_build_object('id','C','text','$5xe^{x-1}$','explanation','Incorrect rule application; no product/power rule is needed here.'),
    jsonb_build_object('id','D','text','$5x e^x$','explanation','Incorrectly treated derivative of $e^x$ as $xe^x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use the constant multiple rule:
$$h''(x)=5\\cdot (e^x)''=5e^x.$$',
  recommendation_reasons = ARRAY['Fast accuracy check on the exponential derivative.', 'Catches dropping constants and misremembering $(e^x)''$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: constant multiple with exponential derivative.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.7',
  section_id = '2.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_DERIV_BASIC_TRANSC', 'SK_ALG_SIMPLIFY'],
  primary_skill_id = 'SK_DERIV_BASIC_TRANSC',
  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_LN_DERIV_1_OVER_X', 'E_ALG_SIMPLIFY'],
  prompt = 'Let $p(x)=\\ln(x^2)$ for $x>0$. Which expression equals $p''(x)$?',
  latex = 'Let $p(x)=\\ln(x^2)$ for $x>0$. Which expression equals $p''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{x^2}$','explanation','Incorrect: derivative of $\\ln u$ is not $1/u^2$.'),
    jsonb_build_object('id','B','text','$\\dfrac{2}{x}$','explanation','Correct: for $x>0$, $\\ln(x^2)=2\\ln x$, so $p''(x)=2\\cdot 1/x=2/x$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{x}$','explanation','Missed the factor 2 from $\\ln(x^2)=2\\ln x$ (valid for $x>0$).'),
    jsonb_build_object('id','D','text','$2x$','explanation','Confused with derivative of $x^2$ instead of $\\ln(x^2)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because $x>0$, $\\ln(x^2)=2\\ln x$. Then
$$p''(x)=2\\cdot \\frac{1}{x}=\\frac{2}{x}.$$',
  recommendation_reasons = ARRAY['Builds fluency with log properties to simplify before differentiating.', 'Targets the common $\\ln$-derivative misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use $\\ln(x^2)=2\\ln x$ (for $x>0$) and differentiate.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.7',
  section_id = '2.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_DERIV_BASIC_TRANSC', 'SK_UNITS_INTERPRET'],
  primary_skill_id = 'SK_DERIV_BASIC_TRANSC',
  supporting_skill_ids = ARRAY['SK_UNITS_INTERPRET'],
  error_tags = ARRAY['E_TRIG_SIGN', 'E_CONST_RULE'],
  prompt = 'A particle''s position is $s(t)=4\\cos t+3\\sin t$ (meters). What is its velocity $v(t)=s''(t)$?',
  latex = 'A particle''s position is $s(t)=4\\cos t+3\\sin t$ (meters). What is its velocity $v(t)=s''(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4\\sin t+3\\cos t$','explanation','Sign error: $(\\cos t)''=-\\sin t$, so $4\\cos t$ differentiates to $-4\\sin t$.'),
    jsonb_build_object('id','B','text','$-4\\sin t+3\\cos t$','explanation','Correct: $s''(t)=4(-\\sin t)+3(\\cos t)=-4\\sin t+3\\cos t$.'),
    jsonb_build_object('id','C','text','$-4\\cos t+3\\sin t$','explanation','Incorrect: differentiated $\\cos t$ to $-\\cos t$ and $\\sin t$ to $\\sin t$.'),
    jsonb_build_object('id','D','text','$4\\cos t+3\\sin t$','explanation','No differentiation performed.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$(\\cos t)''=-\\sin t,\\quad (\\sin t)''=\\cos t.$$
Thus
$$v(t)=s''(t)=-4\\sin t+3\\cos t.$$',
  recommendation_reasons = ARRAY['Connects trig derivatives to velocity interpretation.', 'Targets the common trig sign error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret derivative as velocity; apply trig derivatives with signs.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.7-P5';



-- Unit 2.8 (The Product Rule) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.8',
  section_id = '2.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_PRODUCT_RULE', 'SK_DERIV_BASIC_TRANSC'],
  primary_skill_id = 'SK_PRODUCT_RULE',
  supporting_skill_ids = ARRAY['SK_DERIV_BASIC_TRANSC'],
  error_tags = ARRAY['E_PRODUCT_RULE_MISSING_TERM', 'E_DISTRIBUTE_DERIV_WRONG'],
  prompt = 'Let $f(x)=(x^2+1)\\sin x$. What is $f''(x)$?',
  latex = 'Let $f(x)=(x^2+1)\\sin x$. What is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(2x)\\sin x+(x^2+1)\\cos x$','explanation','Correct: product rule with $(x^2+1)''=2x$ and $(\\sin x)''=\\cos x$.'),
    jsonb_build_object('id','B','text','$(2x)\\cos x+(x^2+1)\\sin x$','explanation','Swapped derivatives; the undifferentiated partner factor is incorrect.'),
    jsonb_build_object('id','C','text','$(x^2+1)\\cos x$','explanation','Missing the $(x^2+1)''\\sin x$ term from the product rule.'),
    jsonb_build_object('id','D','text','$(2x)\\sin x$','explanation','Missing the $(x^2+1)\\cos x$ term from the product rule.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use product rule $(uv)''=u''v+uv''$. Let $u=x^2+1$ and $v=\\sin x$:
$$f''(x)=2x\\sin x+(x^2+1)\\cos x.$$',
  recommendation_reasons = ARRAY['Core product-rule structure with polynomial times trig.', 'Targets the common mistake of dropping a term.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with a polynomial factor and trig factor.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.8-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.8',
  section_id = '2.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_PRODUCT_RULE', 'SK_ALG_EXP_LOG'],
  primary_skill_id = 'SK_PRODUCT_RULE',
  supporting_skill_ids = ARRAY['SK_ALG_EXP_LOG'],
  error_tags = ARRAY['E_PRODUCT_RULE_MISSING_TERM', 'E_EXP_DERIV_EX'],
  prompt = 'Let $g(x)=x e^x$. What is $g''(x)$?',
  latex = 'Let $g(x)=x e^x$. What is $g''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$e^x$','explanation','Missing one product-rule term; $xe^x$ produces two terms.'),
    jsonb_build_object('id','B','text','$x e^x$','explanation','Only one factor was effectively differentiated; product rule is required.'),
    jsonb_build_object('id','C','text','$e^x+x e^x$','explanation','Correct: $(x)''e^x+x(e^x)''=1\\cdot e^x+x\\cdot e^x=e^x+x e^x$.'),
    jsonb_build_object('id','D','text','$e^{x-1}+x e^x$','explanation','Incorrect: derivative of $e^x$ is $e^x$, not $e^{x-1}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Apply product rule with $u=x$ and $v=e^x$:
$$g''(x)=u''v+uv''=1\\cdot e^x+x\\cdot e^x=e^x+x e^x.$$',
  recommendation_reasons = ARRAY['Classic product-rule staple involving $e^x$.', 'Targets the frequent error of writing only one term.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with $x$ and $e^x$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.8-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.8',
  section_id = '2.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_PRODUCT_RULE', 'SK_ALG_SIMPLIFY'],
  primary_skill_id = 'SK_PRODUCT_RULE',
  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_DISTRIBUTE_DERIV_WRONG', 'E_ALG_SIMPLIFY'],
  prompt = 'Let $h(x)=(\\ln x)(\\cos x)$ for $x>0$. What is $h''(x)$?',
  latex = 'Let $h(x)=(\\ln x)(\\cos x)$ for $x>0$. What is $h''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{x}\\cos x+(\\ln x)(-\\sin x)$','explanation','Correct: product rule with $(\\ln x)''=1/x$ and $(\\cos x)''=-\\sin x$.'),
    jsonb_build_object('id','B','text','$\\dfrac{1}{x}-\\sin x$','explanation','Incorrect: differentiated each factor but did not multiply by the other factor.'),
    jsonb_build_object('id','C','text','$\\dfrac{\\cos x}{x}-\\dfrac{\\sin x}{x}$','explanation','Second term is wrong; it should be $-(\\ln x)\\sin x$, not $-(\\sin x)/x$.'),
    jsonb_build_object('id','D','text','$\\dfrac{1}{x}\\cos x+(\\ln x)\\sin x$','explanation','Sign error: $(\\cos x)''=-\\sin x$, so the second term must be negative.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=\\ln x$ and $v=\\cos x$. Then
$$h''(x)=u''v+uv''=\\frac{1}{x}\\cos x+(\\ln x)(-\\sin x).$$',
  recommendation_reasons = ARRAY['Forces correct product-rule structure (each term keeps the partner factor).', 'Targets the common “differentiate both then add” mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with $\\ln x$ and trig; keep partner factors.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.8-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.8',
  section_id = '2.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_PRODUCT_RULE', 'SK_TRIG_IDENT'],
  primary_skill_id = 'SK_PRODUCT_RULE',
  supporting_skill_ids = ARRAY['SK_TRIG_IDENT'],
  error_tags = ARRAY['E_PRODUCT_RULE_MISSING_TERM', 'E_TRIG_SIGN'],
  prompt = 'Let $q(x)=\\sin x\\cos x$. What is $q''(x)$?',
  latex = 'Let $q(x)=\\sin x\\cos x$. What is $q''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\cos x\\cos x+\\sin x(-\\sin x)$','explanation','Correct: product rule gives $\\cos^2 x-\\sin^2 x$.'),
    jsonb_build_object('id','B','text','$\\cos x-\\sin x$','explanation','Incorrect: forgot to multiply by the other factor (not product rule).'),
    jsonb_build_object('id','C','text','$\\sin^2 x+\\cos^2 x$','explanation','Sign error: the second term should be $-\\sin^2 x$, not $+\\sin^2 x$.'),
    jsonb_build_object('id','D','text','$2\\sin x\\cos x$','explanation','This equals $\\sin(2x)$, not the derivative of $\\sin x\\cos x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use product rule:
$$(\\sin x\\cos x)''=(\\cos x)\\cos x+\\sin x(-\\sin x)=\\cos^2 x-\\sin^2 x.$$',
  recommendation_reasons = ARRAY['Tests clean execution of product rule with two trig functions.', 'Targets sign errors from $(\\cos x)''=-\\sin x$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with $\\sin x$ and $\\cos x$; simplify to squares.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.8-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '2.8',
  section_id = '2.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_PRODUCT_RULE', 'SK_DERIV_BASIC_TRANSC', 'SK_ALG_SIMPLIFY'],
  primary_skill_id = 'SK_PRODUCT_RULE',
  supporting_skill_ids = ARRAY['SK_DERIV_BASIC_TRANSC', 'SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_PRODUCT_RULE_MISSING_TERM', 'E_DISTRIBUTE_DERIV_WRONG', 'E_ALG_SIMPLIFY'],
  prompt = 'Let $r(x)=(x^2\\ln x)(\\sin x)$ for $x>0$. Using only the product rule and basic derivatives, which expression equals $r''(x)$?',
  latex = 'Let $r(x)=(x^2\\ln x)(\\sin x)$ for $x>0$. Using only the product rule and basic derivatives, which expression equals $r''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(2x\\ln x+ x)\\sin x + x^2\\ln x\\cos x$','explanation','Correct: $(x^2\\ln x)''=2x\\ln x+x$ (product rule), then product rule with $\\sin x$.'),
    jsonb_build_object('id','B','text','$(2x\\ln x)\\sin x + x^2\\ln x\\cos x$','explanation','Missing the $+x$ term from differentiating $x^2\\ln x$.'),
    jsonb_build_object('id','C','text','$(2x\\ln x+x)\\cos x + x^2\\ln x\\sin x$','explanation','Swapped $\\sin x$ and $\\cos x$ placements; terms must keep the undifferentiated partner.'),
    jsonb_build_object('id','D','text','$2x\\ln x\\sin x + x^2\\cos x$','explanation','Dropped $\\ln x$ in the second term and missed the $+x\\sin x$ contribution.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=x^2\\ln x$ and $v=\\sin x$. Then $r''(x)=u''v+uv''$.
First,
$$(x^2\\ln x)''=(x^2)''\\ln x+x^2(\\ln x)''=2x\\ln x+x^2\\cdot \\frac{1}{x}=2x\\ln x+x.$$
Thus,
$$r''(x)=(2x\\ln x+x)\\sin x+x^2\\ln x\\cos x.$$',
  recommendation_reasons = ARRAY['High-representation AP-style layered product rule without needing chain rule.', 'Targets missing-term errors and incorrect distribution of derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: layered product rule; correctly differentiate $x^2\\ln x$ then multiply with trig factor.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.8-P5';
