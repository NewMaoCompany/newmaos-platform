-- Unit 4.7 SQL Update Script
-- Wrapped in a DO block to ensure atomic execution and prevent syntax errors at EOF.

DO $block$
BEGIN

-- Unit 4.7 (Using L'Hospital’s Rule for Finding Limits of Indeterminate Forms) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.7',
  section_id = '4.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_TRIG_LIMITS', 'SK_CHAIN_RULE'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_TRIG_LIMITS', 'SK_CHAIN_RULE'],
 'SK_CHAIN_RULE'], 'SK_CHAIN_RULE'],
  error_tags = ARRAY['E_MISUSE_LHOSPITAL', 'E_CHAIN_RULE_MISSED', 'E_PLUG_IN_0_0'],
  prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin(3x)}{x}$.',
  latex = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin(3x)}{x}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This comes from substituting $x=0$ without resolving the $0/0$ indeterminate form.'),
    jsonb_build_object('id','B','text','$1$','explanation','This treats $\sin(3x)$ as if it were approximately $x$ near $0$, missing the factor $3$.'),
    jsonb_build_object('id','C','text','$3$','explanation','Using $u=3x$, $\frac{\sin(3x)}{x}=3\cdot\frac{\sin u}{u}\to 3$; equivalently, L’Hospital gives $\frac{3\cos(3x)}{1}\to 3$.'),
    jsonb_build_object('id','D','text','$\infty$','explanation','This misinterprets small-angle behavior; the ratio approaches a finite constant.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'This is a $0/0$ form. Using the standard limit $\lim_{u\to 0}\frac{\sin u}{u}=1$ with $u=3x$,
$$\lim_{x\to 0}\frac{\sin(3x)}{x}=3\lim_{u\to 0}\frac{\sin u}{u}=3.$$
Equivalently, by L’Hospital,
$$\lim_{x\to 0}\frac{\sin(3x)}{x}=\lim_{x\to 0}\frac{3\cos(3x)}{1}=3.$$',
  recommendation_reasons = ARRAY['Practice identifying a $0/0$ form and applying L’Hospital correctly.', 'Targets the common chain-rule omission in L’Hospital/trig limits.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: correct use of L’Hospital or standard trig limit; watch the chain-rule factor.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.7',
  section_id = '4.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_LIMITS_INDETERMINATE', 'SK_REPEATED_LHOSPITAL'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_LIMITS_INDETERMINATE', 'SK_REPEATED_LHOSPITAL'],
 'SK_REPEATED_LHOSPITAL'], 'SK_REPEATED_LHOSPITAL'],
  error_tags = ARRAY['E_STOP_TOO_EARLY', 'E_MISUSE_LHOSPITAL', 'E_PLUG_IN_0_0'],
  prompt = 'The table in figure 4.7-P2 shows values of $\dfrac{e^x-1-x}{x^2}$ near $x=0$. Estimate $\displaystyle \lim_{x\to 0}\frac{e^x-1-x}{x^2}$.',
  latex = 'The table in figure 4.7-P2 shows values of $\dfrac{e^x-1-x}{x^2}$ near $x=0$. Estimate $\displaystyle \lim_{x\to 0}\frac{e^x-1-x}{x^2}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This incorrectly concludes the numerator is “too small” without using derivatives or the table trend.'),
    jsonb_build_object('id','B','text','$\frac{1}{2}$','explanation','The table values approach $0.5$, and applying L’Hospital twice gives $\frac{e^x}{2}\to \frac{1}{2}$.'),
    jsonb_build_object('id','C','text','$1$','explanation','This matches $\lim_{x\to 0}\frac{e^x-1}{x}$, not the given expression with the extra $-x$ and $x^2$.'),
    jsonb_build_object('id','D','text','$2$','explanation','This is not supported by the table; the values trend to about $0.5$, not $2$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'This is a $0/0$ form. Apply L’Hospital twice:
$$\lim_{x\to 0}\frac{e^x-1-x}{x^2}
=\lim_{x\to 0}\frac{e^x-1}{2x}\quad(0/0)
=\lim_{x\to 0}\frac{e^x}{2}
=\frac{1}{2}.$$
The table in figure 4.7-P2 is consistent with values approaching $0.500000\ldots$.',
  recommendation_reasons = ARRAY['Connects numeric evidence to L’Hospital reasoning.', 'Targets the frequent error of applying L’Hospital only once for higher-order zeros.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: repeated L’Hospital for higher-order indeterminate forms; interpret a table near the limit point.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.7',
  section_id = '4.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_EXP_LOG_LIMITS', 'SK_CHAIN_RULE'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_EXP_LOG_LIMITS', 'SK_CHAIN_RULE'],
 'SK_CHAIN_RULE'], 'SK_CHAIN_RULE'],
  error_tags = ARRAY['E_CHAIN_RULE_MISSED', 'E_MISUSE_LHOSPITAL', 'E_PLUG_IN_0_0'],
  prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\ln(1+5x)}{x}$.',
  latex = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\ln(1+5x)}{x}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$5$','explanation','By L’Hospital, the limit is $\lim_{x\to 0}\frac{\frac{5}{1+5x}}{1}=5$.'),
    jsonb_build_object('id','B','text','$1$','explanation','This forgets the inner derivative factor $5$ from $\ln(1+5x)$.'),
    jsonb_build_object('id','C','text','$0$','explanation','Direct substitution gives $0/0$; you must resolve the indeterminate form.'),
    jsonb_build_object('id','D','text','$\frac{1}{5}$','explanation','This incorrectly inverts the chain-rule factor.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'This is a $0/0$ form. Apply L’Hospital:
$$\lim_{x\to 0}\frac{\ln(1+5x)}{x}
=\lim_{x\to 0}\frac{\frac{5}{1+5x}}{1}
=5.$$',
  recommendation_reasons = ARRAY['Reinforces correct derivative of $\ln(1+5x)$ in L’Hospital.', 'Targets chain-rule factor mistakes in applied limit contexts.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: L’Hospital with logarithms; chain rule is essential.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.7',
  section_id = '4.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_LIMITS_INDETERMINATE'],
  primary_skill_id = 'SK_LIMITS_INDETERMINATE',
  supporting_skill_ids = ARRAY[]::text[],

  error_tags = ARRAY['E_WRONG_FORM_CLASSIFICATION', 'E_MISUSE_LHOSPITAL'],
  prompt = 'Which limit is an indeterminate form appropriate for applying L’Hospital’s Rule (after checking differentiability conditions)?',
  latex = 'Which limit is an indeterminate form appropriate for applying L’Hospital’s Rule (after checking differentiability conditions)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \lim_{x\to 0}\frac{1}{x^2}$','explanation','This is not indeterminate; it diverges to $\infty$.'),
    jsonb_build_object('id','B','text','$\displaystyle \lim_{x\to \infty}\frac{3x+1}{2x-5}$','explanation','This is an $\infty/\infty$ indeterminate form, so L’Hospital can apply (though algebra also works).'),
    jsonb_build_object('id','C','text','$\displaystyle \lim_{x\to 0}(1+\sin x)$','explanation','This is determinate: it approaches $1$.'),
    jsonb_build_object('id','D','text','$\displaystyle \lim_{x\to 2}\frac{x^2-4}{x-2}$','explanation','This is $0/0$ but is typically simplified by factoring first; it is not the intended choice here.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Direct substitution into $\frac{3x+1}{2x-5}$ as $x\to\infty$ produces $\frac{\infty}{\infty}$, an indeterminate ratio form where L’Hospital is appropriate after verifying conditions.',
  recommendation_reasons = ARRAY['Builds accurate recognition of when L’Hospital applies.', 'Reduces overuse of L’Hospital on non-indeterminate limits.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: classify indeterminate forms ($0/0$ or $\infty/\infty$) correctly.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Applications',
  sub_topic_id = '4.7',
  section_id = '4.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_LHOSPITAL', 'SK_REPEATED_LHOSPITAL', 'SK_TRIG_LIMITS'],
  primary_skill_id = 'SK_LHOSPITAL',
  supporting_skill_ids = ARRAY['SK_REPEATED_LHOSPITAL', 'SK_TRIG_LIMITS'],
 'SK_TRIG_LIMITS'], 'SK_TRIG_LIMITS'],
  error_tags = ARRAY['E_STOP_TOO_EARLY', 'E_SIGN_ERROR', 'E_MISUSE_LHOSPITAL'],
  prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin x - x}{x^3}$.',
  latex = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin x - x}{x^3}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This stops too early; the numerator and denominator both vanish to higher order than $x$.'),
    jsonb_build_object('id','B','text','$-\frac{1}{6}$','explanation','Applying L’Hospital three times gives $\lim_{x\to 0}\frac{-\cos x}{6}=-\frac{1}{6}$.'),
    jsonb_build_object('id','C','text','$\frac{1}{6}$','explanation','This is a sign error; repeated differentiation of $\sin x - x$ introduces a negative.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The repeated-derivative limit exists and is finite.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'This is a $0/0$ form. Apply L’Hospital three times:
$$\lim_{x\to 0}\frac{\sin x-x}{x^3}
=\lim_{x\to 0}\frac{\cos x-1}{3x^2}
=\lim_{x\to 0}\frac{-\sin x}{6x}
=\lim_{x\to 0}\frac{-\cos x}{6}
=-\frac{1}{6}.$$',
  recommendation_reasons = ARRAY['Trains repeated L’Hospital on higher-order zeros.', 'Targets the common “stop too early” and sign mistakes across multiple derivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: repeated L’Hospital; manage signs carefully across multiple derivatives.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Applications',
  updated_at = NOW()
WHERE title = '4.7-P5';

END $block$;
