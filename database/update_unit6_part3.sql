-- Unit 6.9 (Integrating Using Substitution) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.9',
  section_id = '6.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_U_SUBSTITUTION', 'SK_CHAIN_RULE_RECOGNITION'],

  primary_skill_id = 'SK_U_SUBSTITUTION',

  supporting_skill_ids = ARRAY['SK_CHAIN_RULE_RECOGNITION'],
  error_tags = ARRAY['ER_FORGET_DX', 'ER_U_NOT_UPDATED'],
  prompt = 'Evaluate the indefinite integral:
$$\int 2x\cos(x^2)\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int 2x\cos(x^2)\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\sin(x^2)+C$$','explanation','Let $u=x^2$, $du=2x\,dx$, so the integral is $\int \cos u\,du=\sin u + C$.'),
    jsonb_build_object('id','B','text','$$\cos(x^2)+C$$','explanation','This is the derivative pattern for $\sin(x^2)$, not for $\cos(x^2)$.'),
    jsonb_build_object('id','C','text','$$2\sin(x^2)+C$$','explanation','No extra factor of $2$ remains after $du=2x\,dx$.'),
    jsonb_build_object('id','D','text','$$\tfrac12\sin(x^2)+C$$','explanation','A $\tfrac12$ would appear only if the integrand were $x\cos(x^2)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use substitution $u=x^2$. Then $du=2x\,dx$ and
$$\int 2x\cos(x^2)\,dx=\int \cos u\,du=\sin u + C=\sin(x^2)+C.$$',
  recommendation_reasons = ARRAY['Practice matching an inner function with its derivative factor.', 'Reinforce the $u$-sub workflow and back-substitution.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.9: Basic $u$-sub with reverse chain rule.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.9-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.9',
  section_id = '6.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_U_SUBSTITUTION', 'SK_DEFINITE_INTEGRAL_LIMITS', 'SK_ALGEBRA_SIMPLIFICATION'],

  primary_skill_id = 'SK_U_SUBSTITUTION',

  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_LIMITS', 'SK_ALGEBRA_SIMPLIFICATION'],
  error_tags = ARRAY['ER_LIMITS_NOT_CHANGED', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the definite integral:
$$\int_{0}^{2} \frac{x}{1+x^2}\,dx$$',
  latex = 'Evaluate the definite integral:
$$\int_{0}^{2} \frac{x}{1+x^2}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\ln(5)$$','explanation','This misses the factor $\tfrac12$ from $du=2x\,dx$.'),
    jsonb_build_object('id','B','text','$$\ln(\tfrac{5}{1})$$','explanation','Same issue as A; also not simplifying the required coefficient.'),
    jsonb_build_object('id','C','text','$$\tfrac12\ln(1)$$','explanation','$\ln(1)=0$; this would incorrectly treat the upper limit as $1$.'),
    jsonb_build_object('id','D','text','$$\tfrac12\ln(5)$$','explanation','Let $u=1+x^2$, then $du=2x\,dx$, giving $\tfrac12\int_{1}^{5} \frac{1}{u}\,du=\tfrac12\ln 5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Let $u=1+x^2$, so $du=2x\,dx$ and $x\,dx=\tfrac12 du$. Change limits: when $x=0$, $u=1$; when $x=2$, $u=5$.
$$\int_{0}^{2}\frac{x}{1+x^2}\,dx=\tfrac12\int_{1}^{5}\frac{1}{u}\,du=\tfrac12[\ln u]_{1}^{5}=\tfrac12\ln 5.$$',
  recommendation_reasons = ARRAY['Train changing bounds instead of back-substituting.', 'Reinforce logarithm antiderivatives in $u$-sub settings.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.9: Definite integral with substitution and updated limits.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.9-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.9',
  section_id = '6.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_U_SUBSTITUTION', 'SK_TRIG_IDENTITY_REWRITE'],

  primary_skill_id = 'SK_U_SUBSTITUTION',

  supporting_skill_ids = ARRAY['SK_TRIG_IDENTITY_REWRITE'],
  error_tags = ARRAY['ER_ALGEBRA_SIGN', 'ER_U_NOT_UPDATED'],
  prompt = 'Evaluate the indefinite integral:
$$\int \frac{\sin x}{1+\cos x}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int \frac{\sin x}{1+\cos x}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\ln|1+\cos x|+C$$','explanation','Derivative of $1+\cos x$ is $-\sin x$, so this has the wrong sign.'),
    jsonb_build_object('id','B','text','$$-\ln|1+\cos x|+C$$','explanation','Let $u=1+\cos x$, then $du=-\sin x\,dx$, giving $-\int \frac{1}{u}\,du=-\ln|u|+C$.'),
    jsonb_build_object('id','C','text','$$\tan x + C$$','explanation','This would correspond to $\int \sec^2 x\,dx$, not this ratio.'),
    jsonb_build_object('id','D','text','$$\ln|\sin x|+C$$','explanation','No direct $\frac{f''(x)}{f(x)}$ structure with $\sin x$ in the denominator.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $u=1+\cos x$, so $du=-\sin x\,dx$. Then
$$\int \frac{\sin x}{1+\cos x}\,dx=-\int \frac{1}{u}\,du=-\ln|u|+C=-\ln|1+\cos x|+C.$$',
  recommendation_reasons = ARRAY['Emphasize sign tracking when $du$ introduces a negative.', 'Recognize $\frac{f''(x)}{f(x)}$ structures quickly.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.9: Trig-based substitution leading to a logarithm.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.9-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.9',
  section_id = '6.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_U_SUBSTITUTION', 'SK_ALGEBRA_SIMPLIFICATION'],

  primary_skill_id = 'SK_U_SUBSTITUTION',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFICATION'],
  error_tags = ARRAY['ER_FORGET_DX', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the indefinite integral:
$$\int \frac{3x^2}{\sqrt{1+x^3}}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int \frac{3x^2}{\sqrt{1+x^3}}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\sqrt{1+x^3}+C$$','explanation','Differentiate: $\frac{d}{dx}\sqrt{1+x^3}=\frac{3x^2}{2\sqrt{1+x^3}}$, which is half the integrand.'),
    jsonb_build_object('id','B','text','$$\ln|1+x^3|+C$$','explanation','A logarithm would require $(1+x^3)$, not $\sqrt{1+x^3}$, in the denominator.'),
    jsonb_build_object('id','C','text','$$2\sqrt{1+x^3}+C$$','explanation','Let $u=1+x^3$, $du=3x^2\,dx$, so $\int u^{-1/2}du=2u^{1/2}+C$.'),
    jsonb_build_object('id','D','text','$$\frac{2}{\sqrt{1+x^3}}+C$$','explanation','That would correspond to integrating $u^{-3/2}$, not $u^{-1/2}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $u=1+x^3$, so $du=3x^2\,dx$.
$$\int \frac{3x^2}{\sqrt{1+x^3}}\,dx=\int u^{-1/2}\,du=2u^{1/2}+C=2\sqrt{1+x^3}+C.$$',
  recommendation_reasons = ARRAY['Strengthen recognition of $u$ leading to power-rule antiderivatives.', 'Reduce factor mistakes when differentiating square roots.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.9: Substitution with radical; power rule in $u$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.9-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.9',
  section_id = '6.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_U_SUBSTITUTION', 'SK_CHAIN_RULE_RECOGNITION'],

  primary_skill_id = 'SK_U_SUBSTITUTION',

  supporting_skill_ids = ARRAY['SK_CHAIN_RULE_RECOGNITION'],
  error_tags = ARRAY['ER_U_NOT_UPDATED', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the indefinite integral:
$$\int e^{4x-7}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int e^{4x-7}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\tfrac14 e^{4x-7}+C$$','explanation','Let $u=4x-7$, then $du=4\,dx$ so $dx=\tfrac14 du$, giving $\tfrac14 e^u + C$.'),
    jsonb_build_object('id','B','text','$$4e^{4x-7}+C$$','explanation','This incorrectly multiplies by $4$ instead of dividing by $4$.'),
    jsonb_build_object('id','C','text','$$e^{4x-7}+C$$','explanation','Missing the required factor $\tfrac14$ from the chain rule.'),
    jsonb_build_object('id','D','text','$$\ln|4x-7|+C$$','explanation','Logarithms arise from $\int \frac{1}{u}\,du$, not from $\int e^u\,du$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=4x-7$. Then $du=4\,dx$ so $dx=\tfrac14 du$.
$$\int e^{4x-7}\,dx=\tfrac14\int e^u\,du=\tfrac14 e^u + C=\tfrac14 e^{4x-7}+C.$$',
  recommendation_reasons = ARRAY['Build speed on basic $u$-sub with linear inner functions.', 'Prevent chain-rule coefficient errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.9: Basic substitution / reverse chain rule.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.9-P5';



-- Unit 6.10 (Integrating Functions Using Long Division and Completing the Square) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.10',
  section_id = '6.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LONG_DIVISION_POLYNOMIALS', 'SK_INTEGRATE_RATIONAL_FUNCTIONS', 'SK_ALGEBRA_SIMPLIFICATION'],

  primary_skill_id = 'SK_LONG_DIVISION_POLYNOMIALS',

  supporting_skill_ids = ARRAY['SK_INTEGRATE_RATIONAL_FUNCTIONS', 'SK_ALGEBRA_SIMPLIFICATION'],
  error_tags = ARRAY['ER_INCORRECT_LONG_DIV', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the indefinite integral:
$$\int \frac{x^2+1}{x-1}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int \frac{x^2+1}{x-1}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\tfrac12x^2+x+\ln|x-1|+C$$','explanation','This corresponds to quotient $x+1$ and remainder $1$, but the actual remainder is $2$.'),
    jsonb_build_object('id','B','text','$$\tfrac12x^2+x-2\ln|x-1|+C$$','explanation','The log coefficient would be $+2$, not $-2$.'),
    jsonb_build_object('id','C','text','$$x^2+\ln|x-1|+C$$','explanation','This ignores the linear term from division and has the wrong polynomial antiderivative.'),
    jsonb_build_object('id','D','text','$$\tfrac12x^2+x+2\ln|x-1|+C$$','explanation','Divide: $\frac{x^2+1}{x-1}=x+1+\frac{2}{x-1}$, then integrate termwise.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Perform long division:
$$x^2+1=(x-1)(x+1)+2 \Rightarrow \frac{x^2+1}{x-1}=x+1+\frac{2}{x-1}.$$
Then
$$\int \frac{x^2+1}{x-1}\,dx=\int (x+1)\,dx+\int \frac{2}{x-1}\,dx=\tfrac12x^2+x+2\ln|x-1|+C.$$',
  recommendation_reasons = ARRAY['Practice rewriting improper rational functions before integrating.', 'Reduce long-division remainder mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.10: Long division to integrate an improper rational function.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.10-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.10',
  section_id = '6.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_COMPLETE_THE_SQUARE', 'SK_INVERSE_TRIG_ANTIDERIVATIVES', 'SK_ALGEBRA_SIMPLIFICATION'],

  primary_skill_id = 'SK_COMPLETE_THE_SQUARE',

  supporting_skill_ids = ARRAY['SK_INVERSE_TRIG_ANTIDERIVATIVES', 'SK_ALGEBRA_SIMPLIFICATION'],
  error_tags = ARRAY['ER_COMPLETE_SQUARE_ERROR', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the indefinite integral:
$$\int \frac{1}{x^2+4x+13}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int \frac{1}{x^2+4x+13}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\ln|x^2+4x+13|+C$$','explanation','A log form would require the derivative of the quadratic in the numerator.'),
    jsonb_build_object('id','B','text','$$\frac{1}{3}\arctan\!\left(\frac{x+2}{3}\right)+C$$','explanation','Complete the square: $(x+2)^2+9$. With $u=\frac{x+2}{3}$, $dx=3du$, giving $\frac{1}{3}\arctan u + C$.'),
    jsonb_build_object('id','C','text','$$\arctan(x+2)+C$$','explanation','Missing the scaling from $(x+2)^2+9$.'),
    jsonb_build_object('id','D','text','$$\frac{1}{9}\arctan\!\left(\frac{x+2}{3}\right)+C$$','explanation','Coefficient is too small; only one factor of $\frac13$ should remain.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Complete the square:
$$x^2+4x+13=(x+2)^2+9.$$
Then
$$\int \frac{1}{(x+2)^2+9}\,dx.$$
Let $u=\frac{x+2}{3}$, so $x+2=3u$ and $dx=3du$:
$$\int \frac{1}{9u^2+9}\,3du=\frac{1}{3}\int \frac{1}{u^2+1}\,du=\frac{1}{3}\arctan(u)+C=\frac{1}{3}\arctan\!\left(\frac{x+2}{3}\right)+C.$$',
  recommendation_reasons = ARRAY['Reinforce completing the square as a gateway to arctan.', 'Practice scaling to match $\int \frac{1}{u^2+1}du$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.10: Completing the square to use an inverse trig antiderivative.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.10-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.10',
  section_id = '6.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_LONG_DIVISION_POLYNOMIALS', 'SK_DEFINITE_INTEGRAL_EVALUATION'],

  primary_skill_id = 'SK_LONG_DIVISION_POLYNOMIALS',

  supporting_skill_ids = ARRAY['SK_DEFINITE_INTEGRAL_EVALUATION'],
  error_tags = ARRAY['ER_INCORRECT_LONG_DIV', 'ER_ARITHMETIC_ERROR'],
  prompt = 'Evaluate the definite integral:
$$\int_{0}^{1} \frac{x^2}{x+1}\,dx$$',
  latex = 'Evaluate the definite integral:
$$\int_{0}^{1} \frac{x^2}{x+1}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\ln 2-\tfrac12$$','explanation','Divide: $\frac{x^2}{x+1}=x-1+\frac{1}{x+1}$. Then evaluate $\left[\tfrac12x^2-x+\ln(x+1)\right]_0^1=\ln 2-\tfrac12$.'),
    jsonb_build_object('id','B','text','$$\tfrac12-\ln 2$$','explanation','This reverses the order of terms (wrong sign overall).'),
    jsonb_build_object('id','C','text','$$\ln 2+\tfrac12$$','explanation','The polynomial part contributes $-\tfrac12$, not $+\tfrac12$.'),
    jsonb_build_object('id','D','text','$$1-\ln 2$$','explanation','Incorrect polynomial evaluation after division.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Long division:
$$\frac{x^2}{x+1}=x-1+\frac{1}{x+1}.$$
Integrate:
$$\int_{0}^{1}\left(x-1+\frac{1}{x+1}\right)dx=\left[\tfrac12x^2-x+\ln(x+1)\right]_{0}^{1}.$$
Evaluate: at $1$ gives $\tfrac12-1+\ln 2=\ln 2-\tfrac12$; at $0$ gives $0$. So the value is $\ln 2-\tfrac12$.',
  recommendation_reasons = ARRAY['Use division first; then evaluate carefully with exact logs.', 'Double-check endpoint arithmetic with simple fractions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.10: Definite integral after long division; careful endpoint evaluation.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.10-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.10',
  section_id = '6.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_INTEGRATE_RATIONAL_FUNCTIONS', 'SK_CHAIN_RULE_RECOGNITION', 'SK_ALGEBRA_SIMPLIFICATION'],

  primary_skill_id = 'SK_INTEGRATE_RATIONAL_FUNCTIONS',

  supporting_skill_ids = ARRAY['SK_CHAIN_RULE_RECOGNITION', 'SK_ALGEBRA_SIMPLIFICATION'],
  error_tags = ARRAY['ER_U_NOT_UPDATED', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the indefinite integral:
$$\int \frac{2x+4}{x^2+4x+5}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int \frac{2x+4}{x^2+4x+5}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\arctan(x+2)+C$$','explanation','This would match $\int \frac{1}{(x+2)^2+1}dx$, but the numerator here is the derivative of the denominator.'),
    jsonb_build_object('id','B','text','$$\ln|x^2+4x+5|+C$$','explanation','Since $\frac{d}{dx}(x^2+4x+5)=2x+4$, the integral is $\ln|x^2+4x+5|+C$.'),
    jsonb_build_object('id','C','text','$$\tfrac12\ln|x^2+4x+5|+C$$','explanation','No $\tfrac12$ factor is needed because the numerator matches the derivative exactly.'),
    jsonb_build_object('id','D','text','$$\ln|x+2|+C$$','explanation','The denominator is not $x+2$; it is a quadratic.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Recognize a direct log-derivative form: if $f(x)=x^2+4x+5$, then $f''(x)=2x+4$.
$$\int \frac{2x+4}{x^2+4x+5}\,dx=\int \frac{f''(x)}{f(x)}\,dx=\ln|f(x)|+C=\ln|x^2+4x+5|+C.$$',
  recommendation_reasons = ARRAY['Differentiate the denominator quickly to spot $\frac{f''}{f}$.', 'Avoid forcing completing-the-square when not needed.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.10: Efficient technique choice (log-derivative) within rational integration.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.10-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.10',
  section_id = '6.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_LONG_DIVISION_POLYNOMIALS', 'SK_INTEGRATE_RATIONAL_FUNCTIONS'],

  primary_skill_id = 'SK_LONG_DIVISION_POLYNOMIALS',

  supporting_skill_ids = ARRAY['SK_INTEGRATE_RATIONAL_FUNCTIONS'],
  error_tags = ARRAY['ER_INCORRECT_LONG_DIV', 'ER_ALGEBRA_SIGN'],
  prompt = 'Evaluate the indefinite integral:
$$\int \frac{2x^2-3x+4}{x}\,dx$$',
  latex = 'Evaluate the indefinite integral:
$$\int \frac{2x^2-3x+4}{x}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$x^2-3x+4\ln|x|+C$$','explanation','Rewrite as $2x-3+\frac{4}{x}$; integrate to get $x^2-3x+4\ln|x|+C$.'),
    jsonb_build_object('id','B','text','$$x^2-3x+\ln|x|+C$$','explanation','The coefficient on $\ln|x|$ should be $4$, not $1$.'),
    jsonb_build_object('id','C','text','$$2x^2-\tfrac32x+4\ln|x|+C$$','explanation','This incorrectly integrates $2x$ as $2x^2$ instead of $x^2$.'),
    jsonb_build_object('id','D','text','$$x^2-3x+\frac{4}{x}+C$$','explanation','Fails to integrate $\frac{4}{x}$ into a logarithm.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Simplify first:
$$\frac{2x^2-3x+4}{x}=2x-3+\frac{4}{x}.$$
Integrate termwise:
$$\int (2x-3+\tfrac{4}{x})dx=x^2-3x+4\ln|x|+C.$$',
  recommendation_reasons = ARRAY['Practice algebraic simplification before integrating.', 'Reinforce $\int \frac{1}{x}dx=\ln|x|+C$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Chapter 6.10: Simplify by dividing each term by $x$; integrate polynomial + log.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.10-P5';


-- Unit 6.11 (BC ONLY) Using Integration by Parts — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.11',
  section_id = '6.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INT_BY_PARTS', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_INT_BY_PARTS',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_CHOOSE_U_DV', 'E_SIGN'],
  prompt = 'Compute the indefinite integral $$\int x e^{x}\,dx.$$',
  latex  = 'Compute the indefinite integral $$\int x e^{x}\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$xe^{x}+e^{x}+C$','explanation','This has the wrong sign on the remaining $\int e^x\,dx$ term after integration by parts.'),
    jsonb_build_object('id','B','text','$xe^{x}-e^{x}+C$','explanation','Using integration by parts with $u=x$, $dv=e^x\,dx$ gives $\int x e^x dx=xe^x-\int e^x dx=xe^x-e^x+C$.'),
    jsonb_build_object('id','C','text','$e^{x}+C$','explanation','Missing the product term from integration by parts; derivative would be $e^x$, not $x e^x$.'),
    jsonb_build_object('id','D','text','$x e^{x^2}+C$','explanation','Incorrect exponent; $\frac{d}{dx}(e^{x^2})=2x e^{x^2}$, not $e^x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $u=x$ so $du=dx$, and let $dv=e^x dx$ so $v=e^x$. Then
$$\int x e^x dx = x e^x-\int 1\cdot e^x dx = x e^x-e^x+C.$$',
  recommendation_reasons = ARRAY['Core integration by parts pattern $\int x e^x$.', 'Targets sign control when subtracting $\int v\,du$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Integration by parts with exponential; check the subtraction step carefully.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.11-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.11',
  section_id = '6.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_INT_BY_PARTS'],

  primary_skill_id = 'SK_INT_BY_PARTS',

  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_MISSING_TERM', 'E_SIGN'],
  prompt = 'Compute the indefinite integral $$\int \ln(x)\,dx\quad (x>0).$$',
  latex  = 'Compute the indefinite integral $$\int \ln(x)\,dx\quad (x>0).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{(\ln x)^2}{2}+C$','explanation','Differentiating gives $\frac{\ln x}{x}$, not $\ln x$.'),
    jsonb_build_object('id','B','text','$x\ln x + C$','explanation','Differentiate: $\frac{d}{dx}(x\ln x)=\ln x+1$, which is too large by $1$.'),
    jsonb_build_object('id','C','text','$\ln x - x + C$','explanation','This drops the factor of $x$ that comes from $v$ when $dv=dx$.'),
    jsonb_build_object('id','D','text','$x\ln x - x + C$','explanation','IBP with $u=\ln x$, $dv=dx$ gives $x\ln x-\int 1\,dx=x\ln x-x+C$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use integration by parts: $u=\ln x$ so $du=\frac{1}{x}dx$, and $dv=dx$ so $v=x$. Then
$$\int \ln x\,dx = x\ln x-\int x\cdot \frac{1}{x}dx = x\ln x-\int 1\,dx = x\ln x-x+C.$$',
  recommendation_reasons = ARRAY['Classic IBP setup with $u=\ln x$.', 'Targets the common missing $-x$ error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Assume $x>0$ so $\ln x$ is defined without absolute values in the prompt.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.11-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.11',
  section_id = '6.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_INT_BY_PARTS', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_INT_BY_PARTS',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_ALGEBRA', 'E_SIGN', 'E_CHOOSE_U_DV'],
  prompt = 'Compute $$\int x\arctan(x)\,dx.$$',
  latex  = 'Compute $$\int x\arctan(x)\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\dfrac{x^2}{2}\arctan(x)-\dfrac{1}{2}x+\dfrac{1}{2}\arctan(x)+C$$','explanation','IBP: $u=\arctan x$, $dv=x\,dx$ gives $\frac{x^2}{2}\arctan x-\frac12\int \frac{x^2}{1+x^2}dx$, and $\frac{x^2}{1+x^2}=1-\frac{1}{1+x^2}$ leads to $x-\arctan x$.'),
    jsonb_build_object('id','B','text','$$\dfrac{x^2}{2}\arctan(x)-\dfrac{1}{2}\ln(1+x^2)+C$$','explanation','The remaining integral becomes $\int \frac{x^2}{1+x^2}dx$, not a pure $\ln(1+x^2)$ form.'),
    jsonb_build_object('id','C','text','$$\dfrac{x^2}{2}\arctan(x)-\dfrac{1}{2}\arctan(x)+C$$','explanation','This treats the leftover as $\int \frac{1}{1+x^2}dx$ instead of $\int \frac{x^2}{1+x^2}dx$.'),
    jsonb_build_object('id','D','text','$$\dfrac{x^2}{2}\arctan(x)+\dfrac{1}{2}x-\dfrac{1}{2}\arctan(x)+C$$','explanation','Sign error when distributing $-\frac12$ across $(x-\arctan x)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=\arctan x$ so $du=\frac{1}{1+x^2}dx$, and let $dv=x\,dx$ so $v=\frac{x^2}{2}$. Then
$$\int x\arctan x\,dx=\frac{x^2}{2}\arctan x-\frac12\int \frac{x^2}{1+x^2}dx.$$
Rewrite $\frac{x^2}{1+x^2}=1-\frac{1}{1+x^2}$, so
$$\int \frac{x^2}{1+x^2}dx=\int 1\,dx-\int \frac{1}{1+x^2}dx=x-\arctan x.$$
Therefore
$$\int x\arctan x\,dx=\frac{x^2}{2}\arctan x-\frac12(x-\arctan x)+C
=\frac{x^2}{2}\arctan x-\frac12x+\frac12\arctan x+C.$$',
  recommendation_reasons = ARRAY['Forces correct handling of $\int \frac{x^2}{1+x^2}dx$.', 'Targets the identity $\frac{x^2}{1+x^2}=1-\frac{1}{1+x^2}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'IBP with inverse trig; algebraic split is the key step.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.11-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.11',
  section_id = '6.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_INT_BY_PARTS', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_INT_BY_PARTS',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_ALGEBRA', 'E_SIGN'],
  prompt = 'Evaluate the definite integral $$\int_{0}^{1} x\ln(1+x)\,dx.$$',
  latex  = 'Evaluate the definite integral $$\int_{0}^{1} x\ln(1+x)\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{2}\ln 2$','explanation','This treats $\ln(1+x)$ as constant; it ignores integration by parts.'),
    jsonb_build_object('id','B','text','$\dfrac{1}{4}(2\ln 2-1)$','explanation','This can result from an incorrect decomposition of $\frac{x^2}{1+x}$ in the IBP remainder.'),
    jsonb_build_object('id','C','text','$\dfrac{1}{4}$','explanation','Correct. After IBP, the remainder is $\int_0^1 \frac{x^2}{1+x}dx$, and $\frac{x^2}{1+x}=x-1+\frac{1}{1+x}$.'),
    jsonb_build_object('id','D','text','$\dfrac{1}{4}(1-2\ln 2)$','explanation','Negative value is impossible because $x\ln(1+x)\ge 0$ on $[0,1]$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $u=\ln(1+x)$ so $du=\frac{1}{1+x}dx$, and $dv=x\,dx$ so $v=\frac{x^2}{2}$. Then
$$\int_0^1 x\ln(1+x)\,dx=\left.\frac{x^2}{2}\ln(1+x)\right|_0^1-\frac12\int_0^1 \frac{x^2}{1+x}dx.$$
Divide:
$$\frac{x^2}{1+x}=x-1+\frac{1}{1+x}.$$
So
$$\int_0^1 \frac{x^2}{1+x}dx=\int_0^1 (x-1)\,dx+\int_0^1 \frac{1}{1+x}dx=\left(\frac12-1\right)+\ln 2=-\frac12+\ln 2.$$
Therefore
$$\int_0^1 x\ln(1+x)\,dx=\frac12\ln 2-\frac12\left(-\frac12+\ln 2\right)=\frac14.$$',
  recommendation_reasons = ARRAY['Definite IBP with rational remainder.', 'Checks polynomial division and sign control.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key step: rewrite $\frac{x^2}{1+x}=x-1+\frac{1}{1+x}$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.11-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.11',
  section_id = '6.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_INT_BY_PARTS', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_INT_BY_PARTS',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_SIGN', 'E_DISTRIBUTE_NEGATIVE'],
  prompt = 'Compute $$\int x^2\cos(x)\,dx.$$',
  latex  = 'Compute $$\int x^2\cos(x)\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x^2\sin x-2x\cos x-2\sin x+C$','explanation','Sign error on the $2x\cos x$ term after distributing $-2$.'),
    jsonb_build_object('id','B','text','$x^2\sin x+2x\cos x-2\sin x+C$','explanation','Correct. Apply integration by parts twice: first with $u=x^2$, then with $u=x$ on the remaining $\int x\sin x\,dx$.'),
    jsonb_build_object('id','C','text','$x^2\sin x+2x\sin x-2\cos x+C$','explanation','Second IBP step is incorrect; derivative check fails.'),
    jsonb_build_object('id','D','text','$x^2\cos x+2x\sin x-2\cos x+C$','explanation','First IBP step should produce $x^2\sin x$, not $x^2\cos x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'First IBP: $u=x^2$, $dv=\cos x\,dx$ so $du=2x\,dx$, $v=\sin x$.
$$\int x^2\cos x\,dx=x^2\sin x-\int 2x\sin x\,dx.$$
Second IBP on $\int x\sin x\,dx$: let $u=x$, $dv=\sin x\,dx$ so $du=dx$, $v=-\cos x$.
$$\int x\sin x\,dx=-x\cos x+\int \cos x\,dx=-x\cos x+\sin x.$$
So
$$\int x^2\cos x\,dx=x^2\sin x-2(-x\cos x+\sin x)=x^2\sin x+2x\cos x-2\sin x+C.$$',
  recommendation_reasons = ARRAY['Repeated IBP is a BC staple.', 'Targets sign/distribution accuracy.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Repeated IBP with polynomial–trig product; watch the $-2$ distribution.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.11-P5';



-- Unit 6.12 (BC ONLY) Integrating Using Linear Partial Fractions — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.12',
  section_id = '6.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_PARTIAL_FRACTIONS_LINEAR', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_PARTIAL_FRACTIONS_LINEAR',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_PARTIAL_FRACTION_SETUP', 'E_SIGN'],
  prompt = 'Compute $$\int \frac{5}{x(x+2)}\,dx.$$',
  latex  = 'Compute $$\int \frac{5}{x(x+2)}\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\dfrac{5}{2}\left(\ln|x|-\ln|x+2|\right)+C$$','explanation','Correct. Since $\frac{5}{x(x+2)}=\frac{5/2}{x}-\frac{5/2}{x+2}$, integrate termwise.'),
    jsonb_build_object('id','B','text','$$\dfrac{5}{2}\left(\ln|x+2|-\ln|x|\right)+C$$','explanation','Sign is reversed; it corresponds to $\frac{5/2}{x+2}-\frac{5/2}{x}$.'),
    jsonb_build_object('id','C','text','$$\dfrac{5}{2}\ln|x|+\dfrac{5}{2}\ln|x+2|+C$$','explanation','This adds logs; decomposition requires a difference because the coefficients have opposite signs.'),
    jsonb_build_object('id','D','text','$$\dfrac{5}{x+2}+C$$','explanation','Differentiating gives $-\frac{5}{(x+2)^2}$, not $\frac{5}{x(x+2)}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Set
$$\frac{5}{x(x+2)}=\frac{A}{x}+\frac{B}{x+2}.$$
Then $5=A(x+2)+Bx=(A+B)x+2A$, so $A+B=0$ and $2A=5$. Thus $A=\frac52$, $B=-\frac52$.
Therefore
$$\int \frac{5}{x(x+2)}dx=\frac52\ln|x|-\frac52\ln|x+2|+C.$$',
  recommendation_reasons = ARRAY['Baseline linear-factor partial fractions.', 'Reinforces sign pattern in decomposition.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Two distinct linear factors; watch the opposite signs in $A,B$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.12-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.12',
  section_id = '6.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_PARTIAL_FRACTIONS_LINEAR', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_PARTIAL_FRACTIONS_LINEAR',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_PARTIAL_FRACTION_SETUP', 'E_ALGEBRA'],
  prompt = 'Compute $$\int \frac{3x+1}{(x-1)(x+2)}\,dx.$$',
  latex  = 'Compute $$\int \frac{3x+1}{(x-1)(x+2)}\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\ln|x-1|+\ln|x+2|+C$$','explanation','This assumes both coefficients are $1$ without solving for $A,B$.'),
    jsonb_build_object('id','B','text','$$\dfrac{4}{3}\ln|x-1|-\dfrac{5}{3}\ln|x+2|+C$$','explanation','This uses the correct magnitudes but the wrong sign for the second term.'),
    jsonb_build_object('id','C','text','$$\dfrac{4}{3}\ln|x-1|+\dfrac{5}{3}\ln|x+2|+C$$','explanation','Correct. Solving gives $A=\frac{4}{3}$, $B=\frac{5}{3}$.'),
    jsonb_build_object('id','D','text','$$\dfrac{5}{3}\ln|x-1|+\dfrac{4}{3}\ln|x+2|+C$$','explanation','Swaps the coefficients; check by recombining fractions.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Decompose
$$\frac{3x+1}{(x-1)(x+2)}=\frac{A}{x-1}+\frac{B}{x+2}.$$
Then
$$3x+1=A(x+2)+B(x-1)=(A+B)x+(2A-B).$$
So $A+B=3$ and $2A-B=1$. Solving gives $A=\frac{4}{3}$ and $B=\frac{5}{3}$.
Thus
$$\int \frac{3x+1}{(x-1)(x+2)}dx=\frac{4}{3}\ln|x-1|+\frac{5}{3}\ln|x+2|+C.$$',
  recommendation_reasons = ARRAY['Standard solve-for-$A,B$ partial fraction.', 'Targets linear-system accuracy under time pressure.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Solve $A,B$ from coefficient matching; then integrate to logs.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.12-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.12',
  section_id = '6.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_PARTIAL_FRACTIONS_LINEAR', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_PARTIAL_FRACTIONS_LINEAR',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_FACTOR_FIRST', 'E_SIGN', 'E_PARTIAL_FRACTION_SETUP'],
  prompt = 'Compute $$\int \frac{2x+5}{x^2+3x+2}\,dx.$$',
  latex  = 'Compute $$\int \frac{2x+5}{x^2+3x+2}\,dx.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$2\ln|x+1|+3\ln|x+2|+C$$','explanation','Coefficients are not correct after decomposition.'),
    jsonb_build_object('id','B','text','$$\ln|x+1|+\ln|x+2|+C$$','explanation','This corresponds to $\frac{1}{x+1}+\frac{1}{x+2}$, not the given rational function.'),
    jsonb_build_object('id','C','text','$$3\ln|x+1|+2\ln|x+2|+C$$','explanation','Coefficients are swapped; check by recombining.'),
    jsonb_build_object('id','D','text','$$3\ln|x+1|-\ln|x+2|+C$$','explanation','Correct. Factor $x^2+3x+2=(x+1)(x+2)$, then solve $A=3$, $B=-1$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Factor: $x^2+3x+2=(x+1)(x+2)$. Set
$$\frac{2x+5}{(x+1)(x+2)}=\frac{A}{x+1}+\frac{B}{x+2}.$$
Then
$$2x+5=A(x+2)+B(x+1)=(A+B)x+(2A+B).$$
So $A+B=2$ and $2A+B=5$, giving $A=3$, $B=-1$.
Thus
$$\int \left(\frac{3}{x+1}-\frac{1}{x+2}\right)dx=3\ln|x+1|-\ln|x+2|+C.$$',
  recommendation_reasons = ARRAY['Factor-then-decompose workflow.', 'Targets sign on the second term ($B<0$).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Requires factoring then solving for $A,B$; integrate to a difference of logs.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.12-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.12',
  section_id = '6.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_PARTIAL_FRACTIONS_LINEAR'],

  primary_skill_id = 'SK_PARTIAL_FRACTIONS_LINEAR',

  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_COVERUP_MISUSE', 'E_ALGEBRA'],
  prompt = 'Let $$\frac{x+4}{(x+1)(x+3)}=\frac{A}{x+1}+\frac{B}{x+3}.$$ What is the value of $A$?',
  latex  = 'Let $$\frac{x+4}{(x+1)(x+3)}=\frac{A}{x+1}+\frac{B}{x+3}.$$ What is the value of $A$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\dfrac{1}{2}$','explanation','This is an arithmetic slip solving $3=2A$.'),
    jsonb_build_object('id','B','text','$\dfrac{3}{2}$','explanation','Correct. From $x+4=A(x+3)+B(x+1)$, set $x=-1$ to get $3=2A$.'),
    jsonb_build_object('id','C','text','$\dfrac{5}{2}$','explanation','This can come from using a non-eliminating value (like $x=1$) and mis-solving.'),
    jsonb_build_object('id','D','text','$-\dfrac{3}{2}$','explanation','Sign error; $x=-1$ gives $3=2A$, so $A>0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'From
$$x+4=A(x+3)+B(x+1),$$
set $x=-1$ to eliminate $B$:
$$3=2A \Rightarrow A=\frac{3}{2}.$$',
  recommendation_reasons = ARRAY['Builds speed with coefficient extraction (cover-up idea).', 'Targets arithmetic slips in $3=2A$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use a root of a factor to eliminate one coefficient quickly.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.12-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.12',
  section_id = '6.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_PARTIAL_FRACTIONS_LINEAR', 'SK_ALGEBRA_SIMPLIFY'],

  primary_skill_id = 'SK_PARTIAL_FRACTIONS_LINEAR',

  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_SIGN', 'E_PARTIAL_FRACTION_SETUP'],
  prompt = 'Which is an antiderivative of $$\frac{1}{x^2-1}?$$',
  latex  = 'Which is an antiderivative of $$\frac{1}{x^2-1}?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\frac{1}{2}\ln\left|\frac{x-1}{x+1}\right|+C$$','explanation','Correct. Since $\frac{1}{x^2-1}=\frac12\left(\frac{1}{x-1}-\frac{1}{x+1}\right)$, integrate to a difference of logs.'),
    jsonb_build_object('id','B','text','$$\ln|x^2-1|+C$$','explanation','Derivative is $\frac{2x}{x^2-1}$, not $\frac{1}{x^2-1}$.'),
    jsonb_build_object('id','C','text','$$\arctan(x)+C$$','explanation','Derivative is $\frac{1}{1+x^2}$, which has the wrong denominator.'),
    jsonb_build_object('id','D','text','$$\frac{1}{2}\ln|x-1|+\frac{1}{2}\ln|x+1|+C$$','explanation','This corresponds to $\frac12\left(\frac{1}{x-1}+\frac{1}{x+1}\right)$, not the required difference.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Decompose:
$$\frac{1}{x^2-1}=\frac{1}{(x-1)(x+1)}=\frac{A}{x-1}+\frac{B}{x+1}.$$
Then $1=A(x+1)+B(x-1)=(A+B)x+(A-B)$, so $A+B=0$ and $A-B=1$ giving $A=\frac12$, $B=-\frac12$.
Thus
$$\int \frac{1}{x^2-1}dx=\frac12\ln|x-1|-\frac12\ln|x+1|+C=\frac12\ln\left|\frac{x-1}{x+1}\right|+C.$$',
  recommendation_reasons = ARRAY['High-frequency AP-style rational integral.', 'Tests correct sign pattern in partial fractions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Canonical $(x-1)(x+1)$ factorization; difference of logs is essential.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.12-P5';
