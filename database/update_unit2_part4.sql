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
  prompt = 'Let $f(x)=3\sin x-2\cos x+e^x-\ln x$ for $x>0$. What is $f''(x)$?',
  latex = 'Let $f(x)=3\sin x-2\cos x+e^x-\ln x$ for $x>0$. What is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3\cos x+2\sin x+e^x-\dfrac{1}{x}$','explanation','Correct: $(\sin x)''=\cos x$, $(\cos x)''=-\sin x$, $(e^x)''=e^x$, $(\ln x)''=1/x$.'),
    jsonb_build_object('id','B','text','$3\cos x-2\sin x+e^x-\dfrac{1}{x}$','explanation','Sign error: derivative of $-2\cos x$ is $+2\sin x$, not $-2\sin x$.'),
    jsonb_build_object('id','C','text','$3\cos x+2\sin x+e^x-\ln x$','explanation','Did not differentiate $\ln x$; it becomes $1/x$, not $\ln x$.'),
    jsonb_build_object('id','D','text','$3\sin x-2\cos x+e^x-\dfrac{1}{x}$','explanation','Did not differentiate the trig terms; $\sin x$ and $\cos x$ change.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Differentiate term-by-term:
$$f''(x)=3\cos x-2(-\sin x)+e^x-\dfrac{1}{x}=3\cos x+2\sin x+e^x-\dfrac{1}{x}.$$',
  recommendation_reasons = ARRAY['Reinforces core derivatives of $\sin x,\cos x,e^x,\ln x$.', 'Targets common sign and $\ln x$ derivative mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: basic derivatives of $\sin x,\cos x,e^x,\ln x$ with signs and constants.',
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
  prompt = 'For $g(x)=\dfrac{\sin x}{\cos x}$ (where defined), what is $g''(x)$ written in simplest form?',
  latex = 'For $g(x)=\dfrac{\sin x}{\cos x}$ (where defined), what is $g''(x)$ written in simplest form?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{\cos^2 x}$','explanation','Correct: $g(x)=\tan x$, so $g''(x)=\sec^2 x=1/\cos^2 x$.'),
    jsonb_build_object('id','B','text','$\dfrac{\cos^2 x-\sin^2 x}{\cos^2 x}$','explanation','This simplifies to $1$, not the derivative of $\tan x$.'),
    jsonb_build_object('id','C','text','$\dfrac{\cos x}{\sin x}$','explanation','This is $\cot x$, not the derivative.'),
    jsonb_build_object('id','D','text','$\dfrac{\cos x+\sin x}{\cos^2 x}$','explanation','Incorrect differentiation; suggests a broken quotient/product setup.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Recognize $\dfrac{\sin x}{\cos x}=\tan x$. Then
$$g''(x)=\frac{d}{dx}(\tan x)=\sec^2 x=\frac{1}{\cos^2 x}.$$',
  recommendation_reasons = ARRAY['Checks fluency with trig rewriting to simplify differentiation.', 'Prevents identity confusion when simplifying.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: recognize $\tan x$ and use $(\tan x)''=\sec^2 x$.',
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
$$h''(x)=5\cdot (e^x)''=5e^x.$$',
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
  prompt = 'Let $p(x)=\ln(x^2)$ for $x>0$. Which expression equals $p''(x)$?',
  latex = 'Let $p(x)=\ln(x^2)$ for $x>0$. Which expression equals $p''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{x^2}$','explanation','Incorrect: derivative of $\ln u$ is not $1/u^2$.'),
    jsonb_build_object('id','B','text','$\dfrac{2}{x}$','explanation','Correct: for $x>0$, $\ln(x^2)=2\ln x$, so $p''(x)=2\cdot 1/x=2/x$.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{x}$','explanation','Missed the factor 2 from $\ln(x^2)=2\ln x$ (valid for $x>0$).'),
    jsonb_build_object('id','D','text','$2x$','explanation','Confused with derivative of $x^2$ instead of $\ln(x^2)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because $x>0$, $\ln(x^2)=2\ln x$. Then
$$p''(x)=2\cdot \frac{1}{x}=\frac{2}{x}.$$',
  recommendation_reasons = ARRAY['Builds fluency with log properties to simplify before differentiating.', 'Targets the common $\ln$-derivative misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use $\ln(x^2)=2\ln x$ (for $x>0$) and differentiate.',
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
  prompt = 'A particle''s position is $s(t)=4\cos t+3\sin t$ (meters). What is its velocity $v(t)=s''(t)$?',
  latex = 'A particle''s position is $s(t)=4\cos t+3\sin t$ (meters). What is its velocity $v(t)=s''(t)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4\sin t+3\cos t$','explanation','Sign error: $(\cos t)''=-\sin t$, so $4\cos t$ differentiates to $-4\sin t$.'),
    jsonb_build_object('id','B','text','$-4\sin t+3\cos t$','explanation','Correct: $s''(t)=4(-\sin t)+3(\cos t)=-4\sin t+3\cos t$.'),
    jsonb_build_object('id','C','text','$-4\cos t+3\sin t$','explanation','Incorrect: differentiated $\cos t$ to $-\cos t$ and $\sin t$ to $\sin t$.'),
    jsonb_build_object('id','D','text','$4\cos t+3\sin t$','explanation','No differentiation performed.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$(\cos t)''=-\sin t,\quad (\sin t)''=\cos t.$$
Thus
$$v(t)=s''(t)=-4\sin t+3\cos t.$$',
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
  prompt = 'Let $f(x)=(x^2+1)\sin x$. What is $f''(x)$?',
  latex = 'Let $f(x)=(x^2+1)\sin x$. What is $f''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(2x)\sin x+(x^2+1)\cos x$','explanation','Correct: product rule with $(x^2+1)''=2x$ and $(\sin x)''=\cos x$.'),
    jsonb_build_object('id','B','text','$(2x)\cos x+(x^2+1)\sin x$','explanation','Swapped derivatives; the undifferentiated partner factor is incorrect.'),
    jsonb_build_object('id','C','text','$(x^2+1)\cos x$','explanation','Missing the $(x^2+1)''\sin x$ term from the product rule.'),
    jsonb_build_object('id','D','text','$(2x)\sin x$','explanation','Missing the $(x^2+1)\cos x$ term from the product rule.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use product rule $(uv)''=u''v+uv''$. Let $u=x^2+1$ and $v=\sin x$:
$$f''(x)=2x\sin x+(x^2+1)\cos x.$$',
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
    jsonb_build_object('id','C','text','$e^x+x e^x$','explanation','Correct: $(x)''e^x+x(e^x)''=1\cdot e^x+x\cdot e^x=e^x+x e^x$.'),
    jsonb_build_object('id','D','text','$e^{x-1}+x e^x$','explanation','Incorrect: derivative of $e^x$ is $e^x$, not $e^{x-1}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Apply product rule with $u=x$ and $v=e^x$:
$$g''(x)=u''v+uv''=1\cdot e^x+x\cdot e^x=e^x+x e^x.$$',
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
  prompt = 'Let $h(x)=(\ln x)(\cos x)$ for $x>0$. What is $h''(x)$?',
  latex = 'Let $h(x)=(\ln x)(\cos x)$ for $x>0$. What is $h''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{x}\cos x+(\ln x)(-\sin x)$','explanation','Correct: product rule with $(\ln x)''=1/x$ and $(\cos x)''=-\sin x$.'),
    jsonb_build_object('id','B','text','$\dfrac{1}{x}-\sin x$','explanation','Incorrect: differentiated each factor but did not multiply by the other factor.'),
    jsonb_build_object('id','C','text','$\dfrac{\cos x}{x}-\dfrac{\sin x}{x}$','explanation','Second term is wrong; it should be $-(\ln x)\sin x$, not $-(\sin x)/x$.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{x}\cos x+(\ln x)\sin x$','explanation','Sign error: $(\cos x)''=-\sin x$, so the second term must be negative.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=\ln x$ and $v=\cos x$. Then
$$h''(x)=u''v+uv''=\frac{1}{x}\cos x+(\ln x)(-\sin x).$$',
  recommendation_reasons = ARRAY['Forces correct product-rule structure (each term keeps the partner factor).', 'Targets the common “differentiate both then add” mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with $\ln x$ and trig; keep partner factors.',
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
  prompt = 'Let $q(x)=\sin x\cos x$. What is $q''(x)$?',
  latex = 'Let $q(x)=\sin x\cos x$. What is $q''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\cos x\cos x+\sin x(-\sin x)$','explanation','Correct: product rule gives $\cos^2 x-\sin^2 x$.'),
    jsonb_build_object('id','B','text','$\cos x-\sin x$','explanation','Incorrect: forgot to multiply by the other factor (not product rule).'),
    jsonb_build_object('id','C','text','$\sin^2 x+\cos^2 x$','explanation','Sign error: the second term should be $-\sin^2 x$, not $+\sin^2 x$.'),
    jsonb_build_object('id','D','text','$2\sin x\cos x$','explanation','This equals $\sin(2x)$, not the derivative of $\sin x\cos x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use product rule:
$$(\sin x\cos x)''=(\cos x)\cos x+\sin x(-\sin x)=\cos^2 x-\sin^2 x.$$',
  recommendation_reasons = ARRAY['Tests clean execution of product rule with two trig functions.', 'Targets sign errors from $(\cos x)''=-\sin x$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: product rule with $\sin x$ and $\cos x$; simplify to squares.',
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
 'SK_ALG_SIMPLIFY'],error_tags = ARRAY['E_PRODUCT_RULE_MISSING_TERM', 'E_DISTRIBUTE_DERIV_WRONG', 'E_ALG_SIMPLIFY'],
  prompt = 'Let $r(x)=(x^2\ln x)(\sin x)$ for $x>0$. Using only the product rule and basic derivatives, which expression equals $r''(x)$?',
  latex = 'Let $r(x)=(x^2\ln x)(\sin x)$ for $x>0$. Using only the product rule and basic derivatives, which expression equals $r''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(2x\ln x+ x)\sin x + x^2\ln x\cos x$','explanation','Correct: $(x^2\ln x)''=2x\ln x+x$ (product rule), then product rule with $\sin x$.'),
    jsonb_build_object('id','B','text','$(2x\ln x)\sin x + x^2\ln x\cos x$','explanation','Missing the $+x$ term from differentiating $x^2\ln x$.'),
    jsonb_build_object('id','C','text','$(2x\ln x+x)\cos x + x^2\ln x\sin x$','explanation','Swapped $\sin x$ and $\cos x$ placements; terms must keep the undifferentiated partner.'),
    jsonb_build_object('id','D','text','$2x\ln x\sin x + x^2\cos x$','explanation','Dropped $\ln x$ in the second term and missed the $+x\sin x$ contribution.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=x^2\ln x$ and $v=\sin x$. Then $r''(x)=u''v+uv''$.
First,
$$(x^2\ln x)''=(x^2)''\ln x+x^2(\ln x)''=2x\ln x+x^2\cdot \frac{1}{x}=2x\ln x+x.$$
Thus,
$$r''(x)=(2x\ln x+x)\sin x+x^2\ln x\cos x.$$',
  recommendation_reasons = ARRAY['High-representation AP-style layered product rule without needing chain rule.', 'Targets missing-term errors and incorrect distribution of derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: layered product rule; correctly differentiate $x^2\ln x$ then multiply with trig factor.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '2.8-P5';
