-- PREVENT FK ERROR: ensure topic_id exists in public.topic_content
-- If your topic_content table uses a different primary key column name, change (id) accordingly.
INSERT INTO public.topic_content (id, title)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO NOTHING;

-- Unit 10.13 (Radius and Interval of Convergence of Power Series) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.13',
  section_id = '10.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_RADIUS_OF_CONVERGENCE', 'SK_RATIO_TEST'],
  error_tags = ARRAY['E_RATIO_TEST_SETUP', 'E_ALGEBRA_SOLVE_INEQUALITY'],
  prompt = 'Find the radius of convergence of the power series $$\sum_{n=1}^{\infty} \frac{(2x-1)^n}{n\,3^n}.$$',
  latex = 'Find the radius of convergence of the power series $$\sum_{n=1}^{\infty} \frac{(2x-1)^n}{n\,3^n}.$$',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$R=\frac{3}{2}$$','explanation','Correct. Ratio test gives $\left|\frac{2x-1}{3}\right|<1\Rightarrow |x-\tfrac12|<\tfrac32$.'),
jsonb_build_object('id','B','text','$$R=3$$','explanation','Misses the factor $2$ multiplying $x$ inside $(2x-1)$.'),
jsonb_build_object('id','C','text','$$R=\frac{1}{3}$$','explanation','Inverts the inequality from the ratio test.'),
jsonb_build_object('id','D','text','$$R=\frac{2}{3}$$','explanation','Treats $(2x-1)^n$ like $x^n$ without shifting/scaling.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{(2x-1)^n}{n3^n}$. Then $$\left|\frac{a_{n+1}}{a_n}\right|=\left|\frac{2x-1}{3}\right|\cdot\frac{n}{n+1}\to \left|\frac{2x-1}{3}\right|.$$ Convergence requires $\left|\frac{2x-1}{3}\right|<1\Rightarrow |2x-1|<3\Rightarrow |x-\tfrac12|<\tfrac32$, so $R=\tfrac32$.',
  recommendation_reasons = ARRAY['Reinforces identifying center and radius from a shifted/scaled power series.', 'Targets common ratio-test setup and inequality-solving errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use ratio test; interpret $|2x-1|<3$ as an interval centered at $1/2$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_RADIUS_OF_CONVERGENCE',
  supporting_skill_ids = ARRAY['SK_RATIO_TEST'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.13-P1';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.13',
  section_id = '10.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ENDPOINT_TESTING', 'SK_HARMONIC_P_SERIES'],
  error_tags = ARRAY['E_ENDPOINT_TEST_IGNORED', 'E_P_SERIES_MISCLASSIFY'],
  prompt = 'Consider the power series $$\sum_{n=1}^{\infty} \frac{(x+2)^n}{n}. $$ After finding the radius of convergence, determine which statement about the interval of convergence is true.',
  latex = 'Consider the power series $$\sum_{n=1}^{\infty} \frac{(x+2)^n}{n}. $$ After finding the radius of convergence, determine which statement about the interval of convergence is true.',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','It converges for all $x$.','explanation','Ratio test gives $|x+2|<1$, so it cannot converge for all $x$.'),
jsonb_build_object('id','B','text','It converges only at $x=-2$.','explanation','There is an open interval around $-2$ where it converges.'),
jsonb_build_object('id','C','text','Its interval of convergence is $(-3,-1)$.','explanation','Endpoint tests show one endpoint is included.'),
jsonb_build_object('id','D','text','Its interval of convergence is $[-3,-1)$.','explanation','Correct. At $x=-3$ it becomes $\sum \frac{(-1)^n}{n}$ (convergent), and at $x=-1$ it becomes $\sum \frac{1}{n}$ (divergent).')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Ratio test: for $a_n=\frac{(x+2)^n}{n}$, $$\left|\frac{a_{n+1}}{a_n}\right|=|x+2|\cdot\frac{n}{n+1}\to |x+2|.$$ Converges when $|x+2|<1\Rightarrow -3<x<-1$. Test endpoints: $x=-3$ gives $\sum \frac{(-1)^n}{n}$ (alternating harmonic, convergent). $x=-1$ gives $\sum \frac{1}{n}$ (harmonic, divergent). So IOC is $[-3,-1)$.',
  recommendation_reasons = ARRAY['Forces explicit endpoint testing after radius is found.', 'Reinforces recognizing alternating harmonic vs harmonic.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Standard trap: forgetting endpoint tests; classify harmonic vs alternating harmonic.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_ENDPOINT_TESTING',
  supporting_skill_ids = ARRAY['SK_HARMONIC_P_SERIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.13-P2';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.13',
  section_id = '10.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_POWER_SERIES_CENTER'],
  error_tags = ARRAY['E_CENTER_MISIDENTIFY'],
  prompt = 'A power series is written as $$\sum_{n=0}^{\infty} c_n\,(x-4)^n.$$ What is the center of the series?',
  latex = 'A power series is written as $$\sum_{n=0}^{\infty} c_n\,(x-4)^n.$$ What is the center of the series?',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$0$$','explanation','Center is $a$ in $(x-a)^n$, not automatically $0$.'),
jsonb_build_object('id','B','text','$$4$$','explanation','Correct. In $(x-4)^n$, the center is $a=4$.'),
jsonb_build_object('id','C','text','$$-4$$','explanation','Sign mistake: $x-4$ means $a=4$, not $-4$.'),
jsonb_build_object('id','D','text','Cannot be determined without $c_n$.','explanation','Center depends only on the shift $(x-4)$, not on coefficients.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A power series in standard form is $\sum c_n(x-a)^n$. The center is the value $a$ in the factor $(x-a)$, so here $a=4$.',
  recommendation_reasons = ARRAY['Quick check of the most basic ROC/IOC setup skill.', 'Eliminates a frequent sign/center confusion before harder tests.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Foundational recognition of center from $(x-a)^n$.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_POWER_SERIES_CENTER',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.13-P3';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.13',
  section_id = '10.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_INTERVAL_NOTATION'],
  error_tags = ARRAY['E_INTERVAL_NOTATION_MISMATCH'],
  prompt = 'See image (10.13-P4). Which interval notation matches the interval shown?',
  latex = 'See image (10.13-P4). Which interval notation matches the interval shown?',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$[-2,3]$$','explanation','Left endpoint is open in the image, so $-2$ is not included.'),
jsonb_build_object('id','B','text','$$(-2,3)$$','explanation','Right endpoint is closed in the image, so $3$ is included.'),
jsonb_build_object('id','C','text','$$(-2,3]$$','explanation','Correct. Open at $-2$ and closed at $3$ gives $(-2,3]$.'),
jsonb_build_object('id','D','text','$$[-2,3)$$','explanation','Endpoints inclusion is swapped compared to the image.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'An open circle means the endpoint is not included (parenthesis). A closed circle means included (bracket). The image shows open at $-2$ and closed at $3$, so the interval is $(-2,3]$.',
  recommendation_reasons = ARRAY['Prevents IOC notation mistakes when reporting final answers.', 'High-frequency formatting/interpretation skill for AP-style work.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.70,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Image-based interval reading; aligns with IOC reporting.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_INTERVAL_NOTATION',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.13-P4';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.13',
  section_id = '10.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_RADIUS_OF_CONVERGENCE', 'SK_RATIO_TEST', 'SK_ENDPOINT_TESTING'],
  error_tags = ARRAY['E_RATIO_TEST_SETUP', 'E_ENDPOINT_TEST_IGNORED', 'E_ALGEBRA_SOLVE_INEQUALITY'],
  prompt = 'Find the interval of convergence of $$\sum_{n=1}^{\infty} \frac{n(x-1)^n}{2^n}. $$',
  latex = 'Find the interval of convergence of $$\sum_{n=1}^{\infty} \frac{n(x-1)^n}{2^n}. $$',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$(-1,3)$$','explanation','This is the open interval from the ratio test, but endpoints must be checked (both diverge).'),
jsonb_build_object('id','B','text','$$[-1,3]$$','explanation','Both endpoints diverge because terms do not approach 0.'),
jsonb_build_object('id','C','text','$$(-1,3]$$','explanation','At $x=3$ the series is $\sum n$, which diverges.'),
jsonb_build_object('id','D','text','$$(-1,3)$$','explanation','Correct. Ratio test gives $|x-1|<2$ and both endpoints fail the term test.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{n(x-1)^n}{2^n}$. Then $$\left|\frac{a_{n+1}}{a_n}\right|=\left|\frac{x-1}{2}\right|\cdot\frac{n+1}{n}\to \left|\frac{x-1}{2}\right|.$$ Convergence requires $|x-1|<2\Rightarrow -1<x<3$. Endpoints: $x=3$ gives $\sum n$ (diverges). $x=-1$ gives $\sum n(-1)^n$; terms do not go to 0, so diverges. Thus IOC is $(-1,3)$.',
  recommendation_reasons = ARRAY['Mixes ratio test with a nontrivial $n$ factor and endpoint checks.', 'Targets the common mistake of assuming endpoints converge automatically.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key check: at endpoints the term $n$ prevents $a_n\to0$.',
  weight_primary = 0.50,
  weight_supporting = 0.50,
    primary_skill_id = 'SK_RADIUS_OF_CONVERGENCE',
  supporting_skill_ids = ARRAY['SK_RATIO_TEST', 'SK_ENDPOINT_TESTING'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.13-P5';


-- Unit 10.14 (Finding Taylor or Maclaurin Series for a Function) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.14',
  section_id = '10.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_MACLAURIN_SERIES', 'SK_SERIES_ALGEBRA'],
  error_tags = ARRAY['E_SERIES_COEFFICIENT_ERROR', 'E_MACLAURIN_VS_TAYLOR_CONFUSION'],
  prompt = 'Find the Maclaurin series for $$f(x)=\frac{1}{1+x^2}$$ up to and including the $x^6$ term.',
  latex = 'Find the Maclaurin series for $$f(x)=\frac{1}{1+x^2}$$ up to and including the $x^6$ term.',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$1+x^2+x^4+x^6$$','explanation','Uses $\frac{1}{1-r}=1+r+r^2+\cdots$ with $r=x^2$ but misses the needed sign for $r=-x^2$.'),
jsonb_build_object('id','B','text','$$1-x^2+x^4-x^6$$','explanation','Correct. With $r=-x^2$, the series alternates: $\sum (-x^2)^n$.'),
jsonb_build_object('id','C','text','$$1-2x^2+3x^4-4x^6$$','explanation','Incorrect coefficients; not the geometric expansion.'),
jsonb_build_object('id','D','text','$$1+x-x^2+x^3-x^4+x^5-x^6$$','explanation','Odd powers should not appear because $\frac{1}{1+x^2}$ is even.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Rewrite $$\frac{1}{1+x^2}=\frac{1}{1-(-x^2)}.$$ For $|x|<1$, $$\frac{1}{1-r}=\sum_{n=0}^{\infty} r^n$$ with $r=-x^2$. Thus $$\frac{1}{1+x^2}=1-x^2+x^4-x^6+\cdots.$$',
  recommendation_reasons = ARRAY['Builds fluency with rewriting into geometric-series form.', 'Targets sign and parity mistakes in Maclaurin expansions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Even-function check: only even powers should appear.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_MACLAURIN_SERIES',
  supporting_skill_ids = ARRAY['SK_SERIES_ALGEBRA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.14-P1';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.14',
  section_id = '10.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_TAYLOR_POLYNOMIAL', 'SK_DERIVATIVE_AT_POINT'],
  error_tags = ARRAY['E_FACTORIAL_DENOMINATOR_MISS', 'E_DERIVATIVE_EVAL_ERROR'],
  prompt = 'Let $f(x)=\ln x$. What is the third-degree Taylor polynomial for $f$ centered at $x=1$?',
  latex = 'Let $f(x)=\ln x$. What is the third-degree Taylor polynomial for $f$ centered at $x=1$?',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$T_3(x)=(x-1)-\frac{(x-1)^2}{2}+\frac{(x-1)^3}{3}$$','explanation','Correct. Using derivatives at 1 gives coefficients $1,-\tfrac12,\tfrac13$.'),
jsonb_build_object('id','B','text','$$T_3(x)=(x-1)+\frac{(x-1)^2}{2}+\frac{(x-1)^3}{6}$$','explanation','Wrong signs/coefficients for derivatives of $\ln x$.'),
jsonb_build_object('id','C','text','$$T_3(x)=\ln(1)+(x-1)-\frac{(x-1)^2}{2}+\frac{(x-1)^3}{6}$$','explanation','Cubic coefficient should be $1/3$ because $f''''''(1)=2$.'),
jsonb_build_object('id','D','text','$$T_3(x)=(x-1)-\frac{(x-1)^2}{2}-\frac{(x-1)^3}{3}$$','explanation','Cubic sign should be positive.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute derivatives: $f(1)=0$, $f''(1)=1$, $f''''(1)=-1$, $f''''''(1)=2$. Then $$T_3(x)=f(1)+f''(1)(x-1)+\frac{f''''(1)}{2!}(x-1)^2+\frac{f''''''(1)}{3!}(x-1)^3=(x-1)-\frac{(x-1)^2}{2}+\frac{(x-1)^3}{3}.$$',
  recommendation_reasons = ARRAY['Direct BC skill: build Taylor polynomial from derivatives at a center.', 'Targets factorial-denominator and derivative-sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Common pitfall: forgetting $f''''''(1)=2$ so cubic coefficient becomes $2/6=1/3$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_TAYLOR_POLYNOMIAL',
  supporting_skill_ids = ARRAY['SK_DERIVATIVE_AT_POINT'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.14-P2';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.14',
  section_id = '10.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_SERIES_SUBSTITUTION', 'SK_COEFFICIENT_EXTRACTION'],
  error_tags = ARRAY['E_SERIES_COEFFICIENT_ERROR'],
  prompt = 'Given $$e^x=\sum_{n=0}^{\\infty}\frac{x^n}{n!},$$ what is the coefficient of $x^5$ in the Maclaurin series for $e^{2x}$?',
  latex = 'Given $$e^x=\sum_{n=0}^{\\infty}\frac{x^n}{n!},$$ what is the coefficient of $x^5$ in the Maclaurin series for $e^{2x}$?',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$\frac{2^5}{5!}$$','explanation','Correct. Substitute $2x$ into the series: coefficient is $2^5/5!$.'),
jsonb_build_object('id','B','text','$$\frac{2}{5!}$$','explanation','Needs $2^5$, not $2$.'),
jsonb_build_object('id','C','text','$$\frac{5!}{2^5}$$','explanation','Inverts the coefficient.'),
jsonb_build_object('id','D','text','$$\frac{2^5}{5}$$','explanation','Denominator must be $5!$, not $5$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use substitution: $$e^{2x}=\sum_{n=0}^{\infty}\frac{(2x)^n}{n!}=\sum_{n=0}^{\infty}\frac{2^n}{n!}x^n.$$ Thus the coefficient of $x^5$ is $\frac{2^5}{5!}$.',
  recommendation_reasons = ARRAY['Fast accuracy check on series substitution.', 'Prevents missing powers when extracting a specific coefficient.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Coefficient extraction after substitution is a high-frequency step in BC series problems.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_SERIES_SUBSTITUTION',
  supporting_skill_ids = ARRAY['SK_COEFFICIENT_EXTRACTION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.14-P3';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.14',
  section_id = '10.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 190,
  skill_tags = ARRAY['SK_SERIES_COMPOSITION', 'SK_SERIES_ALGEBRA', 'SK_MACLAURIN_SERIES'],
  error_tags = ARRAY['E_SERIES_COEFFICIENT_ERROR', 'E_DISTRIBUTION_ERROR'],
  prompt = 'Use $$\sin x=\sum_{n=0}^{\infty}(-1)^n\frac{x^{2n+1}}{(2n+1)!}$$ to find the Maclaurin series for $$g(x)=x\sin(x^2)$$ up to and including the $x^9$ term.',
  latex = 'Use $$\sin x=\sum_{n=0}^{\infty}(-1)^n\frac{x^{2n+1}}{(2n+1)!}$$ to find the Maclaurin series for $$g(x)=x\sin(x^2)$$ up to and including the $x^9$ term.',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$x^3-\frac{x^7}{3!}+\frac{x^{11}}{5!}$$','explanation','Does not present the truncated series up to $x^9$; the last term exceeds $x^9$.'),
jsonb_build_object('id','B','text','$$x^3-\frac{x^7}{3!}$$','explanation','Correct truncated form up to $x^9$ (there is no $x^9$ term).'),
jsonb_build_object('id','C','text','$$x^3-\frac{x^7}{3!}+\frac{x^9}{5!}$$','explanation','Power tracking error: the next term after $x^7$ is $x^{11}$, not $x^9$.'),
jsonb_build_object('id','D','text','$$x^2-\frac{x^6}{3!}+\frac{x^{10}}{5!}$$','explanation','That is $\sin(x^2)$, not $x\sin(x^2)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Substitute $x^2$ into the sine series: $$\sin(x^2)=x^2-\frac{x^6}{3!}+\frac{x^{10}}{5!}-\cdots.$$ Multiply by $x$: $$x\sin(x^2)=x^3-\frac{x^7}{3!}+\frac{x^{11}}{5!}-\cdots.$$ Up to and including $x^9$, this is $$x^3-\frac{x^7}{3!}.$$',
  recommendation_reasons = ARRAY['Tests disciplined power tracking through substitution and multiplication.', 'Targets distribution/power mistakes common in composed-series problems.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key check: after substitution, powers jump; verify whether an $x^9$ term exists (it doesn’t).',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_SERIES_COMPOSITION',
  supporting_skill_ids = ARRAY['SK_SERIES_ALGEBRA', 'SK_MACLAURIN_SERIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.14-P4';

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.14',
  section_id = '10.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_TAYLOR_APPROXIMATION', 'SK_TAYLOR_POLYNOMIAL'],
  error_tags = ARRAY['E_PLUG_IN_CENTER_ERROR', 'E_ARITHMETIC_SIMPLIFICATION'],
  prompt = 'Use the second-degree Taylor polynomial for $e^x$ centered at $x=0$ to approximate $e^{0.1}$.',
  latex = 'Use the second-degree Taylor polynomial for $e^x$ centered at $x=0$ to approximate $e^{0.1}$.',
  options = jsonb_build_array(
jsonb_build_object('id','A','text','$$1+0.1+\frac{0.1^2}{2}=1.105$$','explanation','Correct. $T_2(x)=1+x+\frac{x^2}{2}$; substitute $x=0.1$.'),
jsonb_build_object('id','B','text','$$1+0.1+\frac{0.1^2}{6}=1.101666\ldots$$','explanation','Uses $3!$ (degree 3) instead of degree 2.'),
jsonb_build_object('id','C','text','$$1+0.1^2+\frac{0.1}{2}=1.06$$','explanation','Wrong coefficients and term placement.'),
jsonb_build_object('id','D','text','$$1+0.1+\frac{0.1^2}{2!}+\frac{0.1^3}{3!}=1.105166\ldots$$','explanation','Includes a cubic term; not second-degree.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The Maclaurin polynomial of degree 2 for $e^x$ is $$T_2(x)=1+x+\frac{x^2}{2}.$$ Plug in $x=0.1$: $$T_2(0.1)=1+0.1+\frac{0.01}{2}=1.105.$$',
  recommendation_reasons = ARRAY['Connects Taylor polynomials to numerical approximation (BC staple).', 'Targets common degree and substitution arithmetic mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Emphasize degree selection and clean arithmetic ($0.1^2=0.01$).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_TAYLOR_APPROXIMATION',
  supporting_skill_ids = ARRAY['SK_TAYLOR_POLYNOMIAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.14-P5';

-- Unit 10.15 (BC ONLY) Representing Functions as Power Series — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.15',
  section_id = '10.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_REP_FUNCTION_AS_POWER_SERIES', 'SK_INDEX_SHIFT_REWRITE'],
  error_tags = ARRAY['E_FORGET_INDEX_SHIFT', 'E_MISSING_FACTOR'],
  prompt = 'Suppose $$f(x)=\\sum_{n=0}^{\\infty} \\frac{x^n}{n+1}$$ for $|x|<1$. Which power series represents $x\\,f(x)$?',
  latex = 'Suppose $$f(x)=\\sum_{n=0}^{\\infty} \\frac{x^n}{n+1}$$ for $|x|<1$. Which power series represents $x\\,f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\sum_{n=0}^{\\infty}\\frac{x^{n}}{n+1}$$','explanation','This is just $f(x)$, not multiplied by $x$.'),
    jsonb_build_object('id','B','text','$$\\sum_{n=0}^{\\infty}\\frac{x^{n+1}}{n+1}$$','explanation','Multiplying by $x$ increases every power by 1: $x\\cdot x^n=x^{n+1}$.'),
    jsonb_build_object('id','C','text','$$\\sum_{n=1}^{\\infty}\\frac{x^{n}}{n+1}$$','explanation','Changing the starting index without correctly shifting the term changes the series.'),
    jsonb_build_object('id','D','text','$$\\sum_{n=0}^{\\infty}\\frac{x^{n+1}}{n+2}$$','explanation','This introduces an unnecessary change to the denominator; multiplying by $x$ does not change $(n+1)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute directly:
$$x f(x)=x\\sum_{n=0}^{\\infty}\\frac{x^n}{n+1}=\\sum_{n=0}^{\\infty}\\frac{x^{n+1}}{n+1}.$$',
  recommendation_reasons = ARRAY['Reinforces basic power-series operations (multiplying by $x$).', 'Targets the high-frequency mistake of incorrect re-indexing.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: represent a new function by multiplying a known power series.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_REP_FUNCTION_AS_POWER_SERIES',
  supporting_skill_ids = ARRAY['SK_INDEX_SHIFT_REWRITE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.15-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.15',
  section_id = '10.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_REP_FUNCTION_AS_POWER_SERIES', 'SK_GEOMETRIC_SERIES_SUBSTITUTION'],
  error_tags = ARRAY['E_SCALE_SUBSTITUTION_ERROR', 'E_DROP_N0_TERM'],
  prompt = 'Given $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty} x^n\\quad (|x|<1),$$ which series represents $$\\frac{1}{1-3x}?$$',
  latex = 'Given $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty} x^n\\quad (|x|<1),$$ which series represents $$\\frac{1}{1-3x}?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\sum_{n=0}^{\\infty} 3x^n$$','explanation','This equals $3\\sum x^n=\\frac{3}{1-x}$, not $\\frac{1}{1-3x}$.'),
    jsonb_build_object('id','B','text','$$\\sum_{n=0}^{\\infty} (3x)^n$$','explanation','Substitute $x\\mapsto 3x$ in the geometric series: $\\sum (3x)^n=\\frac{1}{1-3x}$ for $|3x|<1$.'),
    jsonb_build_object('id','C','text','$$\\sum_{n=0}^{\\infty} \\frac{x^n}{3^n}$$','explanation','This is $\\sum (x/3)^n=\\frac{1}{1-x/3}=\\frac{3}{3-x}$.'),
    jsonb_build_object('id','D','text','$$\\sum_{n=1}^{\\infty} (3x)^n$$','explanation','Missing the $n=0$ term; it would equal $\\frac{1}{1-3x}-1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use the known identity with input $3x$:
$$\\frac{1}{1-3x}=\\sum_{n=0}^{\\infty}(3x)^n,\\quad |3x|<1\\Rightarrow |x|<\\frac13.$$',
  recommendation_reasons = ARRAY['Builds fluency with substitution into a known series.', 'Highlights how the interval of convergence changes under scaling.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: substitution into geometric series and resulting convergence condition.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_REP_FUNCTION_AS_POWER_SERIES',
  supporting_skill_ids = ARRAY['SK_GEOMETRIC_SERIES_SUBSTITUTION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.15-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.15',
  section_id = '10.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_POWER_SERIES_DIFF_INT', 'SK_INDEX_SHIFT_REWRITE'],
  error_tags = ARRAY['E_TERM_BY_TERM_DIFF_ERROR', 'E_FORGET_INDEX_SHIFT'],
  prompt = 'For $|x|<1$, suppose $$\\ln(1+x)=\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^n}{n}.$$ Which series represents $$\\frac{1}{1+x}?$$',
  latex = 'For $|x|<1$, suppose $$\\ln(1+x)=\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^n}{n}.$$ Which series represents $$\\frac{1}{1+x}?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^{n-1}}{n}$$','explanation','Differentiating $x^n/n$ gives $x^{n-1}$ (no $1/n$ left), so this keeps an extra factor.'),
    jsonb_build_object('id','B','text','$$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^{n}}{n+1}$$','explanation','This resembles integrating, not differentiating.'),
    jsonb_build_object('id','C','text','$$\\sum_{n=1}^{\\infty}(-1)^{n-1}x^{n-1}$$','explanation','Differentiate term-by-term: $\\frac{d}{dx}\\left(\\frac{x^n}{n}\\right)=x^{n-1}$, preserving the alternating sign.'),
    jsonb_build_object('id','D','text','$$\\sum_{n=0}^{\\infty}(-1)^{n}x^{n+1}$$','explanation','This is an index/degree mismatch and does not equal $1/(1+x)$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate both sides for $|x|<1$:
$$\\frac{d}{dx}\\ln(1+x)=\\frac{1}{1+x}.$$
Also,
$$\\frac{d}{dx}\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^n}{n}=\\sum_{n=1}^{\\infty}(-1)^{n-1}x^{n-1}.$$',
  recommendation_reasons = ARRAY['Connects known series to new ones via differentiation.', 'Targets the common mistake of mishandling coefficients during term-by-term differentiation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: derive a rational-function series by differentiating a known logarithm series.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_POWER_SERIES_DIFF_INT',
  supporting_skill_ids = ARRAY['SK_INDEX_SHIFT_REWRITE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.15-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.15',
  section_id = '10.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_REP_FUNCTION_AS_POWER_SERIES', 'SK_ALGEBRA_REWRITE_FOR_SERIES'],
  error_tags = ARRAY['E_SIGN_FROM_NEG_SUB', 'E_SCALE_SUBSTITUTION_ERROR'],
  prompt = 'Using $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty}x^n\\ (|x|<1),$$ which series represents $$\\frac{x^2}{1+x^2}?$$',
  latex = 'Using $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty}x^n\\ (|x|<1),$$ which series represents $$\\frac{x^2}{1+x^2}?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\sum_{n=0}^{\\infty} x^{2n+2}$$','explanation','This equals $\\frac{x^2}{1-x^2}$, not $\\frac{x^2}{1+x^2}$.'),
    jsonb_build_object('id','B','text','$$\\sum_{n=0}^{\\infty} (-1)^n x^{2n+2}$$','explanation','Rewrite $\\frac{1}{1+x^2}=\\frac{1}{1-(-x^2)}=\\sum (-x^2)^n$, then multiply by $x^2$.'),
    jsonb_build_object('id','C','text','$$\\sum_{n=0}^{\\infty} (-1)^n x^{n+2}$$','explanation','The exponent must be even after substituting $x^2$; this mixes odd powers.'),
    jsonb_build_object('id','D','text','$$\\sum_{n=1}^{\\infty} (-1)^n x^{2n}$$','explanation','This misses the required factor of $x^2$ and the correct index alignment.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Start with
$$\\frac{1}{1+x^2}=\\frac{1}{1-(-x^2)}=\\sum_{n=0}^{\\infty}(-x^2)^n=\\sum_{n=0}^{\\infty}(-1)^n x^{2n},\\quad |x|<1.$$
Multiply by $x^2$:
$$\\frac{x^2}{1+x^2}=\\sum_{n=0}^{\\infty}(-1)^n x^{2n+2}.$$',
  recommendation_reasons = ARRAY['Combines algebraic rewriting with geometric series recognition.', 'Reinforces correct handling of alternating signs from $-x^2$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: represent a rational function using geometric-series substitution with $-x^2$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_REP_FUNCTION_AS_POWER_SERIES',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_REWRITE_FOR_SERIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.15-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.15',
  section_id = '10.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 210,
  skill_tags = ARRAY['SK_INTERVAL_OF_CONVERGENCE', 'SK_GEOMETRIC_SERIES_RECOGNITION'],
  error_tags = ARRAY['E_ENDPOINTS_NOT_CHECKED', 'E_SCALE_SUBSTITUTION_ERROR'],
  prompt = 'A function is defined by the power series $$g(x)=\\sum_{n=0}^{\\infty} \\frac{(x-2)^n}{3^n}.$$ For which set of $x$ does the series converge?',
  latex = 'A function is defined by the power series $$g(x)=\\sum_{n=0}^{\\infty} \\frac{(x-2)^n}{3^n}.$$ For which set of $x$ does the series converge?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$|x-2|<3$$','explanation','This gives the correct radius, but it does not explicitly rule out endpoints; for a geometric series, endpoints diverge.'),
    jsonb_build_object('id','B','text','$$|x-2|\\le 3$$','explanation','Includes endpoints, but when $|x-2|=3$ the ratio is $\\pm 1$, so the geometric series does not converge.'),
    jsonb_build_object('id','C','text','$$-1<x<5$$','explanation','This is equivalent to $|x-2|<3$, the correct convergence interval for a geometric series.'),
    jsonb_build_object('id','D','text','$$x>2$$','explanation','Convergence depends on distance from 2, not just being greater than 2.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Recognize a geometric series:
$$g(x)=\\sum_{n=0}^{\\infty}\\left(\\frac{x-2}{3}\\right)^n.$$
A geometric series converges when
$$\\left|\\frac{x-2}{3}\\right|<1\\ \\Rightarrow\\ |x-2|<3\\ \\Rightarrow\\ -1<x<5.$$
At $x=-1$ or $x=5$, the ratio is $-1$ or $1$, so it diverges.',
  recommendation_reasons = ARRAY['Assesses interval of convergence recognition from a shifted/scaled geometric series.', 'Targets the common endpoint mistake ($r=\\pm1$ does not converge for geometric series).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: determine convergence set for a shifted/scaled geometric series and check endpoints.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_INTERVAL_OF_CONVERGENCE',
  supporting_skill_ids = ARRAY['SK_GEOMETRIC_SERIES_RECOGNITION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.15-P5';

COMMIT;
