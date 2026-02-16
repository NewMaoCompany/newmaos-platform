-- Unit 10.5 (Harmonic Series and p-Series) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.5',
  section_id = '10.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_P_SERIES_TEST'],
  error_tags = ARRAY['E_P_SERIES_THRESHOLD', 'E_TERM_TEST_MISUSE'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{n^{3/2}}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{n^{3/2}}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges','explanation','This is a $p$-series with $p=\tfrac{3}{2}>1$, so it converges.'),
    jsonb_build_object('id','B','text','Diverges because $\lim_{n\to\infty}\frac{1}{n^{3/2}}=0$','explanation','A zero term limit is necessary but not sufficient for convergence.'),
    jsonb_build_object('id','C','text','Diverges','explanation','A $p$-series diverges only when $p\le 1$.'),
    jsonb_build_object('id','D','text','Inconclusive by the $p$-series test','explanation','The $p$-series test applies directly here.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'A $p$-series $\sum \frac{1}{n^p}$ converges if and only if $p>1$. Here $p=\frac{3}{2}>1$, so the series converges.',
  recommendation_reasons = ARRAY['Reinforces the threshold $p=1$ for $p$-series.', 'Targets the common confusion between $a_n\to 0$ and convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'p-series direct identification; emphasize $p>1$ criterion.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_P_SERIES_TEST',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.5-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.5',
  section_id = '10.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_HARMONIC_SERIES', 'SK_INDEX_SHIFT'],
  error_tags = ARRAY['E_HARMONIC_RECOGNITION', 'E_INDEX_SHIFT_ERROR', 'E_TERM_TEST_MISUSE'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=2}^{\infty}\frac{1}{n-1}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=2}^{\infty}\frac{1}{n-1}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by the $p$-series test with $p=1$','explanation','A $p$-series with $p=1$ is the harmonic series and diverges.'),
    jsonb_build_object('id','B','text','Diverges','explanation','Let $k=n-1$. Then $\sum_{n=2}^{\infty}\frac{1}{n-1}=\sum_{k=1}^{\infty}\frac{1}{k}$, the harmonic series, which diverges.'),
    jsonb_build_object('id','C','text','Converges by telescoping','explanation','There is no cancellation structure; it is not telescoping.'),
    jsonb_build_object('id','D','text','Converges because terms decrease to $0$','explanation','Decreasing to $0$ is not sufficient for convergence.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Reindex with $k=n-1$:
$$\sum_{n=2}^{\infty}\frac{1}{n-1}=\sum_{k=1}^{\infty}\frac{1}{k}$$
which is the harmonic series, and it diverges.',
  recommendation_reasons = ARRAY['Checks recognition of harmonic series under an index shift.', 'Targets the misconception that $a_n\to 0$ implies convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Harmonic series recognition via reindexing.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_HARMONIC_SERIES',
  supporting_skill_ids = ARRAY['SK_INDEX_SHIFT'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.5-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.5',
  section_id = '10.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_P_SERIES_TEST', 'SK_EXPONENT_RULES'],
  error_tags = ARRAY['E_P_SERIES_THRESHOLD', 'E_ALGEBRA_EXPONENT_ERROR'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{5}{\sqrt[3]{n^2}}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{5}{\sqrt[3]{n^2}}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges because the constant factor $5$ makes it smaller','explanation','A constant factor does not change convergence or divergence.'),
    jsonb_build_object('id','B','text','Diverges','explanation','Rewrite $\frac{5}{\sqrt[3]{n^2}}=\frac{5}{n^{2/3}}$. This is a $p$-series with $p=\tfrac{2}{3}\le 1$, so it diverges.'),
    jsonb_build_object('id','C','text','Converges by the $p$-series test with $p=\tfrac{2}{3}$','explanation','A $p$-series converges only when $p>1$.'),
    jsonb_build_object('id','D','text','Inconclusive because radicals prevent the $p$-series test','explanation','Rewrite radicals as exponents; the $p$-series test applies.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $\sqrt[3]{n^2}=n^{2/3}$, the series is $\sum 5n^{-2/3}$, a $p$-series with $p=\frac{2}{3}\le 1$. Therefore, the series diverges.',
  recommendation_reasons = ARRAY['Reinforces converting radicals to exponents.', 'Targets the mistake that constants affect convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Radical-to-exponent rewrite; then apply $p$-series threshold.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_P_SERIES_TEST',
  supporting_skill_ids = ARRAY['SK_EXPONENT_RULES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.5-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.5',
  section_id = '10.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_HARMONIC_SERIES'],
  error_tags = ARRAY['E_HARMONIC_RECOGNITION', 'E_P_SERIES_THRESHOLD'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{n}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges','explanation','The harmonic series is a standard divergent series.'),
    jsonb_build_object('id','B','text','Converges by the integral test','explanation','The integral test would show divergence, not convergence.'),
    jsonb_build_object('id','C','text','Diverges','explanation','This is the harmonic series, which diverges.'),
    jsonb_build_object('id','D','text','Inconclusive because $p=1$ is borderline','explanation','The borderline case is resolved: $p=1$ diverges.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The series $\sum_{n=1}^{\infty}\frac{1}{n}$ is the harmonic series, and it diverges.',
  recommendation_reasons = ARRAY['Ensures baseline recognition of the harmonic series.', 'Reinforces that the $p=1$ case diverges.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Core fact: harmonic series diverges.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_HARMONIC_SERIES',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.5-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.5',
  section_id = '10.5',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_INTEGRAL_TEST', 'SK_LOG_PROPERTIES'],
  error_tags = ARRAY['E_TERM_TEST_MISUSE', 'E_INTEGRAL_ANTIDERIVATIVE_ERROR'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=3}^{\infty}\frac{1}{n\ln(n)}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=3}^{\infty}\frac{1}{n\ln(n)}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges because $\ln(n)$ grows without bound','explanation','Unbounded $\ln(n)$ is not enough here; this series still diverges.'),
    jsonb_build_object('id','B','text','Converges by comparison to $\sum \frac{1}{n^2}$','explanation','$\frac{1}{n\ln n}$ is much larger than $\frac{1}{n^2}$ for large $n$; this does not prove convergence.'),
    jsonb_build_object('id','C','text','Inconclusive by standard tests','explanation','The integral test applies directly to this positive, decreasing function for $n\ge 3$.'),
    jsonb_build_object('id','D','text','Diverges','explanation','By the integral test, $\int_3^{\infty}\frac{1}{x\ln x}\,dx=\left[\ln(\ln x)\right]_3^{\infty}=\infty$, so the series diverges.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use the integral test with $f(x)=\frac{1}{x\ln x}$ for $x\ge 3$:
$$\int_3^{\infty}\frac{1}{x\ln x}\,dx=\lim_{b\to\infty}\left(\ln(\ln b)-\ln(\ln 3)\right)=\infty.$$
Therefore, the series diverges.',
  recommendation_reasons = ARRAY['Builds intuition for the classic divergent series $\sum \frac{1}{n\ln n}$.', 'Strengthens integral-test execution and log antiderivatives.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Classic divergence via integral test; antiderivative is $\ln(\ln x)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_LOG_PROPERTIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.5-P5';



-- Unit 10.6 (Comparison Tests for Convergence) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.6',
  section_id = '10.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_DIRECT_COMPARISON', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_WRONG_COMPARISON_DIRECTION', 'E_WRONG_BENCHMARK'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{n^2+4n}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{n^2+4n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges by comparison to $\sum \frac{1}{n}$','explanation','Since $\frac{1}{n^2+4n}\le \frac{1}{n}$, this does not prove divergence.'),
    jsonb_build_object('id','B','text','Converges','explanation','Because $n^2+4n\ge n^2$, we have $\frac{1}{n^2+4n}\le \frac{1}{n^2}$. Since $\sum \frac{1}{n^2}$ converges, the given series converges by comparison.'),
    jsonb_build_object('id','C','text','Inconclusive because it is not a $p$-series','explanation','You can compare to a $p$-series even if the given series is not exactly a $p$-series.'),
    jsonb_build_object('id','D','text','Diverges because terms are comparable to $\frac{1}{n}$','explanation','The terms behave like $\frac{1}{n^2}$ for large $n$, not like $\frac{1}{n}$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $n\ge 1$, $n^2+4n\ge n^2$, so
$$0<\frac{1}{n^2+4n}\le \frac{1}{n^2}.$$
Since $\sum \frac{1}{n^2}$ converges, the given series converges by the direct comparison test.',
  recommendation_reasons = ARRAY['Trains choosing a correct benchmark $p$-series.', 'Highlights correct direction in direct comparison.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Direct comparison using denominator bound $n^2+4n\ge n^2$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_DIRECT_COMPARISON',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.6-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.6',
  section_id = '10.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DIRECT_COMPARISON', 'SK_ASYMPTOTIC_BEHAVIOR'],
  error_tags = ARRAY['E_WRONG_BENCHMARK', 'E_TERM_TEST_MISUSE', 'E_ALGEBRA_EXPONENT_ERROR'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{n+1}{n^2}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{n+1}{n^2}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by comparison to $\sum \frac{1}{n^2}$','explanation','Since $\frac{n+1}{n^2}=\frac{1}{n}+\frac{1}{n^2}$, the $\frac{1}{n}$ term prevents convergence.'),
    jsonb_build_object('id','B','text','Diverges','explanation','Rewrite $\frac{n+1}{n^2}=\frac{1}{n}+\frac{1}{n^2}$. The harmonic part diverges, so the whole series diverges.'),
    jsonb_build_object('id','C','text','Converges because $\frac{n+1}{n^2}\to 0$','explanation','A term limit of $0$ does not guarantee convergence.'),
    jsonb_build_object('id','D','text','Inconclusive because it is a sum of two series','explanation','If one component diverges, the sum diverges.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Decompose:
$$\frac{n+1}{n^2}=\frac{1}{n}+\frac{1}{n^2}.$$
Then
$$\sum\left(\frac{1}{n}+\frac{1}{n^2}\right)=\sum\frac{1}{n}+\sum\frac{1}{n^2}.$$
The harmonic series diverges, so the given series diverges.',
  recommendation_reasons = ARRAY['Checks rewriting into recognizable benchmark series.', 'Targets the common wrong comparison to $\sum \frac{1}{n^2}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Rewrite to reveal harmonic component; divergence follows.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_DIRECT_COMPARISON',
  supporting_skill_ids = ARRAY['SK_ASYMPTOTIC_BEHAVIOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.6-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.6',
  section_id = '10.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_LIMIT_COMPARISON', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_LIMIT_COMPARISON_SETUP', 'E_WRONG_BENCHMARK'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{3n^2+1}{n^4+5}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{3n^2+1}{n^4+5}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Inconclusive by limit comparison because degrees differ','explanation','Different degrees is exactly when limit comparison to a power of $n$ is useful.'),
    jsonb_build_object('id','B','text','Diverges by comparison to $\sum \frac{1}{n}$','explanation','The terms behave like $\frac{3}{n^2}$ for large $n$, not like $\frac{1}{n}$.'),
    jsonb_build_object('id','C','text','Converges','explanation','Limit-compare to $\sum \frac{1}{n^2}$; the ratio tends to $3$, so both converge/diverge together. Since $\sum \frac{1}{n^2}$ converges, the given series converges.'),
    jsonb_build_object('id','D','text','Diverges because the numerator is quadratic','explanation','A quartic denominator dominates, making the terms behave like $\frac{1}{n^2}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{3n^2+1}{n^4+5}$ and $b_n=\frac{1}{n^2}$. Then
$$\lim_{n\to\infty}\frac{a_n}{b_n}=\lim_{n\to\infty}\frac{(3n^2+1)n^2}{n^4+5}=\lim_{n\to\infty}\frac{3n^4+n^2}{n^4+5}=3.$$
Since this limit is a positive finite number and $\sum \frac{1}{n^2}$ converges, the given series converges by limit comparison.',
  recommendation_reasons = ARRAY['Practices choosing $b_n$ from leading-term behavior.', 'Targets common setup errors in limit comparison.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Limit comparison with $1/n^2$ using leading powers.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_LIMIT_COMPARISON',
  supporting_skill_ids = ARRAY['SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.6-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.6',
  section_id = '10.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_P_SERIES_TEST'],
  error_tags = ARRAY['E_P_SERIES_THRESHOLD', 'E_TERM_TEST_MISUSE'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{\sqrt{n}}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=1}^{\infty}\frac{1}{\sqrt{n}}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by comparison to $\sum \frac{1}{n}$','explanation','This is not a valid convergence proof; comparing to a divergent series cannot prove convergence.'),
    jsonb_build_object('id','B','text','Converges because $\frac{1}{\sqrt{n}}\to 0$','explanation','A term limit of $0$ is necessary but not sufficient.'),
    jsonb_build_object('id','C','text','Converges because it is smaller than $1$','explanation','Bounded terms do not guarantee a series converges.'),
    jsonb_build_object('id','D','text','Diverges','explanation','This is a $p$-series $\sum n^{-1/2}$ with $p=\tfrac{1}{2}\le 1$, so it diverges.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Rewrite as a $p$-series:
$$\sum_{n=1}^{\infty}\frac{1}{\sqrt{n}}=\sum_{n=1}^{\infty}n^{-1/2}.$$
Since $p=\frac{1}{2}\le 1$, the series diverges.',
  recommendation_reasons = ARRAY['Builds benchmark intuition for slow-decay power terms.', 'Reinforces the $p$-series divergence condition $p\le 1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Quick benchmark: $p=1/2$ diverges.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
    primary_skill_id = 'SK_P_SERIES_TEST',
  supporting_skill_ids = ARRAY[]::text[],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.6-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.6',
  section_id = '10.6',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_LIMIT_COMPARISON', 'SK_ASYMPTOTIC_BEHAVIOR'],
  error_tags = ARRAY['E_LIMIT_COMPARISON_SETUP', 'E_WRONG_BENCHMARK', 'E_ALGEBRA_SIMPLIFY_ERROR'],
  prompt = 'Determine whether the series converges or diverges:
$$\sum_{n=2}^{\infty}\frac{1}{n-\sqrt{n}}$$',
  latex = 'Determine whether the series converges or diverges:
$$\sum_{n=2}^{\infty}\frac{1}{n-\sqrt{n}}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges','explanation','Compare to $\sum \frac{1}{n}$: $\lim_{n\to\infty}\frac{\frac{1}{n-\sqrt{n}}}{\frac{1}{n}}=\lim_{n\to\infty}\frac{n}{n-\sqrt{n}}=1$, so it diverges by limit comparison.'),
    jsonb_build_object('id','B','text','Converges by comparison to $\sum \frac{1}{n^2}$','explanation','The terms are much larger than $\frac{1}{n^2}$; this does not prove convergence.'),
    jsonb_build_object('id','C','text','Converges because $n-\sqrt{n}\to\infty$','explanation','Denominator growth alone does not guarantee convergence.'),
    jsonb_build_object('id','D','text','Inconclusive because of the subtraction in the denominator','explanation','Subtraction does not prevent limit comparison or asymptotic analysis.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{1}{n-\sqrt{n}}$ and $b_n=\frac{1}{n}$. Then
$$\lim_{n\to\infty}\frac{a_n}{b_n}=\lim_{n\to\infty}\frac{n}{n-\sqrt{n}}=\lim_{n\to\infty}\frac{1}{1-\frac{1}{\sqrt{n}}}=1.$$
Since the limit is positive and finite and $\sum \frac{1}{n}$ diverges, the given series diverges by limit comparison.',
  recommendation_reasons = ARRAY['Tests correct setup of limit comparison with algebraic manipulation.', 'Targets the mistake of choosing an overly fast-decaying benchmark.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Limit comparison with $1/n$; key step is $\frac{n}{n-\sqrt n}\to 1$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_LIMIT_COMPARISON',
  supporting_skill_ids = ARRAY['SK_ASYMPTOTIC_BEHAVIOR'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.6-P5';

COMMIT;
