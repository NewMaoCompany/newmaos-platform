-- Unit 6.13 (Evaluating Improper Integrals) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.13',
  section_id = '6.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_IMPROPER_CONVERGENCE', 'SK_U_SUB'],

  primary_skill_id = 'SK_IMPROPER_CONVERGENCE',

  supporting_skill_ids = ARRAY['SK_U_SUB'],
  error_tags = ARRAY['E_IMPROPER_LIMIT_SETUP', 'E_CONFUSE_CONVERGE_VALUE', 'E_BOUND_SWAP_U_SUB'],
  prompt = 'Evaluate the improper integral and determine whether it converges:
$$\int_{e}^{\infty}\frac{1}{x(\ln x)^2}\,dx$$',
  latex = 'Evaluate the improper integral and determine whether it converges:
$$\int_{e}^{\infty}\frac{1}{x(\ln x)^2}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges and equals $1$','explanation','Let $u=\ln x$, so $du=\frac{1}{x}dx$. Then the integral becomes $\int_{1}^{\infty}u^{-2}\,du=\left[-\frac{1}{u}\right]_{1}^{\infty}=1$.'),
    jsonb_build_object('id','B','text','Converges and equals $0$','explanation','A convergent improper integral need not equal $0$. Here the antiderivative approaches a positive finite value.'),
    jsonb_build_object('id','C','text','Diverges because it behaves like $\frac{1}{x}$','explanation','The extra factor $(\ln x)^{-2}$ makes the integrand smaller than $\frac{1}{x}$ for large $x$; that comparison does not force divergence.'),
    jsonb_build_object('id','D','text','Diverges because $\ln x=0$ occurs in the integrand','explanation','On $[e,\infty)$, $\ln x\ge 1$, so there is no singularity in the interval of integration.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use $u=\ln x$, $du=\frac{1}{x}dx$. When $x=e$, $u=1$; when $x\to\infty$, $u\to\infty$:
$$\int_{e}^{\infty}\frac{1}{x(\ln x)^2}dx=\int_{1}^{\infty}\frac{1}{u^2}du=\left[-\frac{1}{u}\right]_{1}^{\infty}=1.$$
Therefore the integral converges and equals $1$.',
  recommendation_reasons = ARRAY['Reinforces correct improper-integral setup at infinity.', 'Practices a high-yield substitution that removes the $1/x$ factor.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: improper integral at infinity with $u=\ln x$ substitution.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.13-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.13',
  section_id = '6.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_IMPROPER_FINITE_ENDPOINT', 'SK_POWER_ANTIDERIV'],

  primary_skill_id = 'SK_IMPROPER_FINITE_ENDPOINT',

  supporting_skill_ids = ARRAY['SK_POWER_ANTIDERIV'],
  error_tags = ARRAY['E_IMPROPER_LIMIT_SETUP', 'E_EXPONENT_ERROR', 'E_DROPPED_LIMIT'],
  prompt = 'Evaluate the improper integral:
$$\int_{0}^{2}\frac{1}{\sqrt{x}}\,dx$$',
  latex = 'Evaluate the improper integral:
$$\int_{0}^{2}\frac{1}{\sqrt{x}}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\sqrt{2}$','explanation','This misses the factor of $2$ from $\int x^{-1/2}dx=2x^{1/2}$.'),
    jsonb_build_object('id','B','text','$1$','explanation','No correct limit evaluation yields $1$.'),
    jsonb_build_object('id','C','text','$2\sqrt{2}$','explanation','Write as $\lim_{a\to 0^+}\int_a^2 x^{-1/2}dx$ and evaluate $2\sqrt{x}$ at the bounds.'),
    jsonb_build_object('id','D','text','Diverges','explanation','Although the integrand is unbounded at $0$, this particular integral converges.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Write as a limit:
$$\int_{0}^{2}x^{-1/2}dx=\lim_{a\to 0^+}\int_{a}^{2}x^{-1/2}dx=\lim_{a\to 0^+}\left[2\sqrt{x}\right]_{a}^{2}=2\sqrt{2}. $$',
  recommendation_reasons = ARRAY['Builds fluency with improper integrals at finite endpoints.', 'Targets the common mistake that unbounded implies divergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: improper endpoint at $x=0$; evaluate via limit.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.13-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.13',
  section_id = '6.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_IMPROPER_CONVERGENCE_TESTS', 'SK_INTEGRATION_BY_PARTS'],

  primary_skill_id = 'SK_IMPROPER_CONVERGENCE_TESTS',

  supporting_skill_ids = ARRAY['SK_INTEGRATION_BY_PARTS'],
  error_tags = ARRAY['E_P_TEST_MISUSE', 'E_CONFUSE_LOG_GROWTH', 'E_IBP_SETUP'],
  prompt = 'For what values of $p$ does the improper integral converge?
$$\int_{2}^{\infty}\frac{\ln x}{x^{p}}\,dx$$',
  latex = 'For what values of $p$ does the improper integral converge?
$$\int_{2}^{\infty}\frac{\ln x}{x^{p}}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges for $p>0$','explanation','$p>0$ is not sufficient; at $p=1$ the integral diverges because it behaves like $\int \frac{\ln x}{x}dx$.'),
    jsonb_build_object('id','B','text','Converges for $p>1$','explanation','Integration by parts shows the threshold is exactly $p>1$.'),
    jsonb_build_object('id','C','text','Converges for $p\ge 1$','explanation','At $p=1$, $\int_{2}^{\infty}\frac{\ln x}{x}dx=\left.\frac12(\ln x)^2\right|_{2}^{\infty}$ diverges.'),
    jsonb_build_object('id','D','text','Diverges for all $p$','explanation','For large $p$, the power in the denominator dominates $\ln x$ and the integral converges.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use integration by parts. Let $u=\ln x$ and $dv=x^{-p}dx$ ($p\ne 1$). Then $du=\frac{1}{x}dx$ and $v=\frac{x^{1-p}}{1-p}$.
$$\int_{2}^{\infty}\frac{\ln x}{x^p}dx=\left.\frac{\ln x\,x^{1-p}}{1-p}\right|_{2}^{\infty}-\frac{1}{1-p}\int_{2}^{\infty}x^{-p}dx.$$
The term $\ln x\,x^{1-p}\to 0$ as $x\to\infty$ exactly when $p>1$, and $\int_{2}^{\infty}x^{-p}dx$ converges exactly when $p>1$. Thus the integral converges iff $p>1$.',
  recommendation_reasons = ARRAY['Connects growth rates to convergence of improper integrals.', 'Practices selecting integration by parts as a convergence tool.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: exact convergence threshold via integration by parts.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.13-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.13',
  section_id = '6.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_IMPROPER_FINITE_ENDPOINT', 'SK_U_SUB'],

  primary_skill_id = 'SK_IMPROPER_FINITE_ENDPOINT',

  supporting_skill_ids = ARRAY['SK_U_SUB'],
  error_tags = ARRAY['E_MISSING_IMPROPER_POINT', 'E_IMPROPER_LIMIT_SETUP', 'E_SIGN_ERROR'],
  prompt = 'Determine whether the improper integral converges or diverges:
$$\int_{0}^{1}\frac{1}{x(\ln x)^2}\,dx$$',
  latex = 'Determine whether the improper integral converges or diverges:
$$\int_{0}^{1}\frac{1}{x(\ln x)^2}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges because $\frac{1}{(\ln x)^2}\to 0$ as $x\to 0^+$','explanation','The integrand also has a singularity as $x\to 1^-$ because $\ln x\to 0$, which must be checked.'),
    jsonb_build_object('id','B','text','Converges because it is smaller than $\frac{1}{x}$ near $0$','explanation','Even if it were smaller near $0$, divergence can still occur near $x=1$.'),
    jsonb_build_object('id','C','text','Converges and equals $1$','explanation','No finite value exists because the integrand is non-integrable near $x=1$.'),
    jsonb_build_object('id','D','text','Diverges','explanation','Near $x=1$, an antiderivative is $-\frac{1}{\ln x}$, which blows up as $x\to 1^-$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'The integral is improper at both endpoints. It diverges due to behavior near $x=1$.
Let $u=\ln x$, so $du=\frac{1}{x}dx$. As $x\to 1^-$, $u\to 0^-$ and
$$\int \frac{1}{x(\ln x)^2}dx=\int u^{-2}du=-\frac{1}{u}+C=-\frac{1}{\ln x}+C.$$
As $x\to 1^-$, $\ln x\to 0^-$ so $-\frac{1}{\ln x}\to +\infty$, hence the improper integral diverges.',
  recommendation_reasons = ARRAY['Trains checking all improper points in an interval.', 'Targets the common mistake of only analyzing one endpoint.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: divergence driven by the singularity at $x=1$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.13-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.13',
  section_id = '6.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_IMPROPER_EVAL', 'SK_SUBSTITUTION_SPECIAL'],

  primary_skill_id = 'SK_IMPROPER_EVAL',

  supporting_skill_ids = ARRAY['SK_SUBSTITUTION_SPECIAL'],
  error_tags = ARRAY['E_SUBSTITUTION_ERROR', 'E_IMPROPER_LIMIT_SETUP', 'E_SPECIAL_INTEGRAL_MISUSE'],
  prompt = 'Evaluate the improper integral:
$$\int_{0}^{\infty}\frac{e^{-x}}{\sqrt{x}}\,dx$$',
  latex = 'Evaluate the improper integral:
$$\int_{0}^{\infty}\frac{e^{-x}}{\sqrt{x}}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','This would match $\int_0^{\infty}e^{-x}dx$, but the factor $x^{-1/2}$ changes the value.'),
    jsonb_build_object('id','B','text','$\sqrt{\pi}$','explanation','Let $x=t^2$ to get $2\int_0^{\infty}e^{-t^2}dt=\sqrt{\pi}$.'),
    jsonb_build_object('id','C','text','$\pi$','explanation','This is off by a square root; the result is $\sqrt{\pi}$.'),
    jsonb_build_object('id','D','text','Diverges','explanation','Near $0$, $x^{-1/2}$ is integrable, and as $x\to\infty$ the exponential decay ensures convergence.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $x=t^2$ with $t\ge 0$. Then $dx=2t\,dt$ and $\sqrt{x}=t$:
$$\int_{0}^{\infty}\frac{e^{-x}}{\sqrt{x}}dx=\int_{0}^{\infty}\frac{e^{-t^2}}{t}(2t\,dt)=2\int_{0}^{\infty}e^{-t^2}dt.$$
Using $\int_{0}^{\infty}e^{-t^2}dt=\frac{\sqrt{\pi}}{2}$, the value is $\sqrt{\pi}$.',
  recommendation_reasons = ARRAY['Connects improper integrals to a standard Gaussian integral.', 'Practices $x=t^2$ substitution and careful endpoint handling.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: substitution to a Gaussian-type integral; value $\sqrt{\pi}$.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.13-P5';



-- Unit 6.14 (Selecting Techniques for Antidifferentiation) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.14',
  section_id = '6.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_TECHNIQUE_SELECT', 'SK_LONG_DIVISION_RATIONAL'],

  primary_skill_id = 'SK_TECHNIQUE_SELECT',

  supporting_skill_ids = ARRAY['SK_LONG_DIVISION_RATIONAL'],
  error_tags = ARRAY['E_WRONG_TECHNIQUE', 'E_LONG_DIVISION_ERROR', 'E_LOG_COEFF_ERROR'],
  prompt = 'Find an antiderivative:
$$\int \frac{x^2+1}{x-1}\,dx$$',
  latex = 'Find an antiderivative:
$$\int \frac{x^2+1}{x-1}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{x^2}{2}+\ln|x-1|+C$','explanation','After division, the polynomial part is $x+1$, not $x$.'),
    jsonb_build_object('id','B','text','$\frac{x^2}{2}+x+\ln|x-1|+C$','explanation','Long division gives $\frac{x^2+1}{x-1}=x+1+\frac{2}{x-1}$, so the log coefficient must be $2$.'),
    jsonb_build_object('id','C','text','$\frac{x^2}{2}+x+2\ln|x-1|+C$','explanation','This matches the correct result once the division $\frac{x^2+1}{x-1}=x+1+\frac{2}{x-1}$ is used.'),
    jsonb_build_object('id','D','text','$\frac{x^2}{2}+x+2\ln|x-1|+C$','explanation','Long division: $\frac{x^2+1}{x-1}=x+1+\frac{2}{x-1}$. Integrate term-by-term to get $\frac{x^2}{2}+x+2\ln|x-1|+C$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use long division:
$$x^2+1=(x-1)(x+1)+2 \quad\Rightarrow\quad \frac{x^2+1}{x-1}=x+1+\frac{2}{x-1}.$$
Then
$$\int\left(x+1+\frac{2}{x-1}\right)dx=\frac{x^2}{2}+x+2\ln|x-1|+C.$$',
  recommendation_reasons = ARRAY['Strengthens choosing algebraic manipulation before integrating a rational function.', 'Targets common long-division and log-coefficient mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: technique selection—long division first.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.14-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.14',
  section_id = '6.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_TECHNIQUE_SELECT', 'SK_U_SUB'],

  primary_skill_id = 'SK_TECHNIQUE_SELECT',

  supporting_skill_ids = ARRAY['SK_U_SUB'],
  error_tags = ARRAY['E_WRONG_TECHNIQUE', 'E_MISSING_DU_FACTOR', 'E_LOG_VS_ARCTAN'],
  prompt = 'Find an antiderivative:
$$\int \frac{x}{x^2+9}\,dx$$',
  latex = 'Find an antiderivative:
$$\int \frac{x}{x^2+9}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac12\ln(x^2+9)+C$','explanation','Let $u=x^2+9$ so $du=2x\,dx$. Then the integral is $\frac12\int \frac{1}{u}du$.'),
    jsonb_build_object('id','B','text','$\ln(x^2+9)+C$','explanation','This misses the factor $\frac12$ from matching $du=2x\,dx$.'),
    jsonb_build_object('id','C','text','$\arctan\left(\frac{x}{3}\right)+C$','explanation','This would come from $\int \frac{1}{x^2+9}dx$, not when $x$ is in the numerator.'),
    jsonb_build_object('id','D','text','$\frac{x^2}{x^2+9}+C$','explanation','Differentiate to check; it does not simplify to $\frac{x}{x^2+9}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $u=x^2+9$, so $du=2x\,dx$ and $x\,dx=\frac12 du$:
$$\int \frac{x}{x^2+9}dx=\frac12\int \frac{1}{u}du=\frac12\ln|u|+C=\frac12\ln(x^2+9)+C.$$',
  recommendation_reasons = ARRAY['Quick recognition of the $f^{\prime}(x)/f(x)$ pattern.', 'Builds correct scaling in $u$-substitution.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: technique selection—$u$-sub for $f^{\prime}(x)/f(x)$.',
  weight_primary = 0.50,
  weight_supporting = 0.50,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.14-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.14',
  section_id = '6.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_TECHNIQUE_SELECT', 'SK_INTEGRATION_BY_PARTS'],

  primary_skill_id = 'SK_TECHNIQUE_SELECT',

  supporting_skill_ids = ARRAY['SK_INTEGRATION_BY_PARTS'],
  error_tags = ARRAY['E_WRONG_TECHNIQUE', 'E_IBP_SETUP', 'E_SIGN_ERROR'],
  prompt = 'Find an antiderivative:
$$\int x e^{x}\,dx$$',
  latex = 'Find an antiderivative:
$$\int x e^{x}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$xe^{x}+C$','explanation','Differentiate: $\frac{d}{dx}(xe^x)=e^x+xe^x$, which is not $xe^x$.'),
    jsonb_build_object('id','B','text','$e^{x}(x-1)+C$','explanation','Integration by parts with $u=x$, $dv=e^x dx$ gives $xe^x-\int e^x dx=e^x(x-1)+C$.'),
    jsonb_build_object('id','C','text','$e^{x}(x+1)+C$','explanation','Sign error in the subtraction step of integration by parts.'),
    jsonb_build_object('id','D','text','$\frac{x^2}{2}e^{x}+C$','explanation','Differentiate to check; it does not simplify to $xe^x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Integration by parts: let $u=x$ ($du=dx$) and $dv=e^x dx$ ($v=e^x$).
$$\int x e^x dx = x e^x - \int e^x dx = x e^x - e^x + C = e^x(x-1)+C.$$',
  recommendation_reasons = ARRAY['Reinforces when to choose integration by parts.', 'Targets the frequent sign mistake in $uv-\int v\,du$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: technique selection—polynomial times exponential suggests by parts.',
  weight_primary = 0.55,
  weight_supporting = 0.45,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.14-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.14',
  section_id = '6.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_TECHNIQUE_SELECT', 'SK_COMPLETE_SQUARE', 'SK_INV_TRIG_ANTIDERIV'],

  primary_skill_id = 'SK_TECHNIQUE_SELECT',

  supporting_skill_ids = ARRAY['SK_COMPLETE_SQUARE', 'SK_INV_TRIG_ANTIDERIV'],
  error_tags = ARRAY['E_COMPLETE_SQUARE', 'E_ARCTAN_FORM', 'E_SCALE_FACTOR'],
  prompt = 'Find an antiderivative:
$$\int \frac{1}{x^2-4x+13}\,dx$$',
  latex = 'Find an antiderivative:
$$\int \frac{1}{x^2-4x+13}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\ln|x^2-4x+13|+C$','explanation','This would require the numerator to match the derivative of the denominator, which it does not.'),
    jsonb_build_object('id','B','text','$\arctan(x-2)+C$','explanation','After completing the square, the denominator is $(x-2)^2+9$, which requires a scale factor inside arctan.'),
    jsonb_build_object('id','C','text','$\frac{1}{3}\arctan\left(\frac{x-2}{3}\right)+C$','explanation','Complete the square to $(x-2)^2+3^2$ and use $\int \frac{1}{u^2+a^2}du=\frac{1}{a}\arctan(u/a)+C$.'),
    jsonb_build_object('id','D','text','$\frac{1}{9}\arctan\left(\frac{x-2}{3}\right)+C$','explanation','This applies the factor $\frac{1}{3}$ twice. The correct coefficient is $\frac{1}{3}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Complete the square:
$$x^2-4x+13=(x-2)^2+9=(x-2)^2+3^2.$$
Let $u=x-2$ ($du=dx$):
$$\int \frac{1}{u^2+3^2}du=\frac{1}{3}\arctan\left(\frac{u}{3}\right)+C=\frac{1}{3}\arctan\left(\frac{x-2}{3}\right)+C.$$',
  recommendation_reasons = ARRAY['Builds the habit of completing the square to access inverse-trig antiderivatives.', 'Targets missing scale-factor errors in arctan forms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: technique selection—irreducible quadratic leads to arctan after completing square.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.14-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = '6.14',
  section_id = '6.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_TECHNIQUE_SELECT', 'SK_FPRIME_OVER_F'],

  primary_skill_id = 'SK_TECHNIQUE_SELECT',

  supporting_skill_ids = ARRAY['SK_FPRIME_OVER_F'],
  error_tags = ARRAY['E_WRONG_TECHNIQUE', 'E_MISSING_DU_FACTOR', 'E_OVERUSE_PARTIAL_FRACTIONS'],
  prompt = 'Find an antiderivative:
$$\int \frac{2x+3}{x^2+3x-4}\,dx$$',
  latex = 'Find an antiderivative:
$$\int \frac{2x+3}{x^2+3x-4}\,dx$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\ln|x^2+3x-4|+C$','explanation','Since $\frac{d}{dx}(x^2+3x-4)=2x+3$, this is exactly an $f^{\prime}(x)/f(x)$ form.'),
    jsonb_build_object('id','B','text','$\frac{1}{2}\ln|x^2+3x-4|+C$','explanation','There is no extra factor of $\frac12$ because the numerator already matches $f^{\prime}(x)$.'),
    jsonb_build_object('id','C','text','$\ln|x-1|+\ln|x+4|+C$','explanation','This is an unnecessary partial-fractions approach and would require coefficients; it is not equivalent as stated.'),
    jsonb_build_object('id','D','text','$\arctan\left(\frac{2x+3}{\sqrt{7}}\right)+C$','explanation','Arctan forms arise from $u^2+a^2$ in the denominator; here the denominator factors and the numerator matches its derivative.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Recognize the pattern $\int \frac{f^{\prime}(x)}{f(x)}dx=\ln|f(x)|+C$. Let $f(x)=x^2+3x-4$, so $f^{\prime}(x)=2x+3$.
$$\int \frac{2x+3}{x^2+3x-4}dx=\ln|x^2+3x-4|+C.$$',
  recommendation_reasons = ARRAY['Trains fast technique selection: check for $f^{\prime}(x)$ in the numerator first.', 'Prevents overusing partial fractions when $f^{\prime}(x)/f(x)$ applies.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: technique selection—$f^{\prime}(x)/f(x)$ recognition beats partial fractions.',
  weight_primary = 0.55,
  weight_supporting = 0.45,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.14-P5';
