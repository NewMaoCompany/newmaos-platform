-- Unit 10.7 (Alternating Series Test for Convergence) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.7',
  section_id = '10.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SERIES_ALTERNATING_TEST', 'SERIES_TERMS_TO_ZERO'],
  error_tags = ARRAY['E_FORGET_TERMS_TO_ZERO', 'E_ASSUME_ALTERNATING_IMPLIES_CONVERGENT'],
  prompt = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} (-1)^{n-1}\,\frac{n}{n+1}$$',
  latex = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} (-1)^{n-1}\,\frac{n}{n+1}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by the Alternating Series Test','explanation','AST requires $\lim_{n\to\infty} \frac{n}{n+1}=0$, which is false.'),
    jsonb_build_object('id','B','text','Diverges because the terms do not approach $0$','explanation','Here $a_n=\frac{n}{n+1}\to 1\neq 0$, so the series diverges by the nth-term test.'),
    jsonb_build_object('id','C','text','Converges conditionally but not absolutely','explanation','Conditional convergence still requires $a_n\to 0$, which fails.'),
    jsonb_build_object('id','D','text','Converges absolutely','explanation','Absolute convergence would require $\sum \frac{n}{n+1}$ to converge, which it does not.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{n}{n+1}$. Since $\lim_{n\to\infty} a_n=1\neq 0$, the series cannot converge. By the nth-term test for divergence,
$$\sum_{n=1}^{\infty} (-1)^{n-1}\frac{n}{n+1}$$ diverges.',
  recommendation_reasons = ARRAY['Reinforces the non-negotiable condition $a_n\to 0$ for any infinite series to converge.', 'Targets a common trap: “alternating” does not automatically imply convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: AST prerequisite $a_n\to 0$; avoid confusing with alternating harmonic behavior.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['SERIES_TERMS_TO_ZERO'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.7',
  section_id = '10.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SERIES_ALTERNATING_TEST', 'INEQUALITIES_MONOTONICITY'],
  error_tags = ARRAY['E_ASSUME_DECREASING_WITHOUT_CHECK', 'E_MISREAD_MONOTONE_REQUIREMENT'],
  prompt = 'For which values of $k$ does the series converge by the Alternating Series Test?

$$\sum_{n=1}^{\infty} (-1)^n\,\frac{1}{n^k}$$',
  latex = 'For which values of $k$ does the series converge by the Alternating Series Test?

$$\sum_{n=1}^{\infty} (-1)^n\,\frac{1}{n^k}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','For all real $k$','explanation','If $k\le 0$, then $\frac{1}{n^k}$ does not go to $0$ (it grows or stays constant).'),
    jsonb_build_object('id','B','text','For $k>0$','explanation','If $k>0$, then $a_n=1/n^k\downarrow 0$, so AST applies.'),
    jsonb_build_object('id','C','text','For $k>1$ only','explanation','$k>1$ is needed for absolute convergence of $\sum 1/n^k$, but AST needs only $k>0$.'),
    jsonb_build_object('id','D','text','For $0<k\le 1$ only','explanation','AST also works when $k>1$; the series then converges absolutely as well.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Write $a_n=\frac{1}{n^k}$. For AST, we need $a_n$ decreasing eventually and $\lim_{n\to\infty} a_n=0$. If $k>0$, then $n^k\to\infty$, so $a_n\to 0$ and $a_n$ decreases for $n\ge1$. If $k\le 0$, then $a_n$ does not approach $0$, so the series diverges.',
  recommendation_reasons = ARRAY['Connects AST conditions to $p$-type terms without drifting into p-series absolute convergence.', 'Builds habit of separating “converges” vs “converges absolutely.”'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'AST parameter reasoning; emphasize $k>0$ not $k>1$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['INEQUALITIES_MONOTONICITY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.7',
  section_id = '10.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 170,
  skill_tags = ARRAY['SERIES_ALTERNATING_TEST', 'LOG_EXP_MANIPULATION'],
  error_tags = ARRAY['E_ASSUME_LOG_ALWAYS_DECREASING', 'E_FORGET_TERMS_TO_ZERO'],
  prompt = 'Determine whether the series converges or diverges.

$$\sum_{n=2}^{\infty} (-1)^n\,\frac{\ln n}{n}$$',
  latex = 'Determine whether the series converges or diverges.

$$\sum_{n=2}^{\infty} (-1)^n\,\frac{\ln n}{n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges because $\ln n$ increases','explanation','Even if $\ln n$ increases, the terms $\frac{\ln n}{n}$ can still decrease and approach $0$.'),
    jsonb_build_object('id','B','text','Converges absolutely','explanation','Absolute convergence would require $\sum \frac{\ln n}{n}$ to converge, which it does not.'),
    jsonb_build_object('id','C','text','Converges by the Alternating Series Test','explanation','Let $a_n=\frac{\ln n}{n}$. Then $a_n\to 0$ and is eventually decreasing, so AST applies.'),
    jsonb_build_object('id','D','text','Diverges by the nth-term test because $\frac{\ln n}{n}\not\to 0$','explanation','In fact $\frac{\ln n}{n}\to 0$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{\ln n}{n}$. First, $\lim_{n\to\infty}\frac{\ln n}{n}=0$. Next, $a_n$ is eventually decreasing: for $f(x)=\frac{\ln x}{x}$, $f^{\prime}(x)=\frac{1-\ln x}{x^2}<0$ for $x>e$. Therefore the alternating series converges by AST. It is not absolutely convergent because $\sum \frac{\ln n}{n}$ diverges.',
  recommendation_reasons = ARRAY['Tests verifying “eventually decreasing” using derivative reasoning (BC-appropriate).', 'Reinforces difference between conditional and absolute convergence without requiring the absolute test details.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'AST with $\ln n/n$; avoid claiming monotone from component monotonicity.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['LOG_EXP_MANIPULATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.7',
  section_id = '10.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SERIES_ALTERNATING_TEST', 'SEQUENCE_MONOTONICITY'],
  error_tags = ARRAY['E_ASSUME_DECREASING_WITHOUT_CHECK', 'E_MISREAD_MONOTONE_REQUIREMENT'],
  prompt = 'The terms of an alternating series are defined by

$$\sum_{n=1}^{\infty} (-1)^{n-1}a_n,\quad a_n>0.$$
Which set of conditions is sufficient to guarantee convergence of the series?',
  latex = 'The terms of an alternating series are defined by

$$\sum_{n=1}^{\infty} (-1)^{n-1}a_n,\quad a_n>0.$$
Which set of conditions is sufficient to guarantee convergence of the series?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$a_n$ is increasing and $\lim_{n\to\infty} a_n=0$','explanation','AST requires $a_n$ decreasing (eventually), not increasing.'),
    jsonb_build_object('id','B','text','$a_n$ is decreasing and $\sum a_n$ converges','explanation','If $\sum a_n$ converges then the alternating series converges, but this is stronger than needed.'),
    jsonb_build_object('id','C','text','$a_n$ is decreasing and $\lim_{n\to\infty} a_n=0$','explanation','These are exactly the Alternating Series Test conditions (eventually decreasing is enough).'),
    jsonb_build_object('id','D','text','$a_n$ is bounded and $\lim_{n\to\infty} a_n=0$','explanation','Bounded + tends to $0$ does not ensure convergence of an alternating series without monotonicity.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'By the Alternating Series Test, $\sum_{n=1}^{\infty}(-1)^{n-1}a_n$ converges if $a_n$ is eventually decreasing and $\lim_{n\to\infty} a_n=0$. Choice C states these sufficient conditions.',
  recommendation_reasons = ARRAY['Targets a frequent conceptual slip: confusing “bounded + limit 0” with AST requirements.', 'Cleanly assesses recall/understanding of AST hypotheses.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Definition-level AST condition check.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['SEQUENCE_MONOTONICITY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.7',
  section_id = '10.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 200,
  skill_tags = ARRAY['SERIES_ALTERNATING_TEST', 'SEQUENCE_MONOTONICITY', 'LIMIT_EVALUATION'],
  error_tags = ARRAY['E_ASSUME_DECREASING_WITHOUT_CHECK', 'E_FORGET_TERMS_TO_ZERO'],
  prompt = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} (-1)^{n-1}\,\frac{n+(-1)^n}{n^2}$$',
  latex = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} (-1)^{n-1}\,\frac{n+(-1)^n}{n^2}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by the Alternating Series Test','explanation','The positive-term sequence is $a_n=\frac{n+(-1)^n}{n^2}$, which is not monotone decreasing.'),
    jsonb_build_object('id','B','text','Diverges because $\frac{n+(-1)^n}{n^2}$ does not approach $0$','explanation','Actually $\frac{n+(-1)^n}{n^2}=\frac{1}{n}+\frac{(-1)^n}{n^2}\to 0$.'),
    jsonb_build_object('id','C','text','Converges because it can be written as the sum of two convergent series','explanation','Rewrite and use known convergence: one alternating harmonic and one absolutely convergent series.'),
    jsonb_build_object('id','D','text','Diverges because it behaves like an alternating harmonic series','explanation','Alternating harmonic actually converges, so this reasoning does not support divergence.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Expand the term:
$$(-1)^{n-1}\frac{n+(-1)^n}{n^2}=(-1)^{n-1}\left(\frac{1}{n}+\frac{(-1)^n}{n^2}\right)=\frac{(-1)^{n-1}}{n}-\frac{1}{n^2}.$$
Thus
$$\sum_{n=1}^{\infty}\left(\frac{(-1)^{n-1}}{n}-\frac{1}{n^2}\right)=\sum_{n=1}^{\infty}\frac{(-1)^{n-1}}{n}-\sum_{n=1}^{\infty}\frac{1}{n^2}.$$
The first series converges (alternating harmonic), and the second converges (p-series with $p=2$). Therefore the original series converges.',
  recommendation_reasons = ARRAY['Assesses flexibility: when AST hypotheses fail, use algebraic decomposition instead of forcing a test.', 'Highlights that “alternating” structure can hide a non-alternating component.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'AST may not apply; decomposition is the intended path.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['SEQUENCE_MONOTONICITY', 'LIMIT_EVALUATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.7-P5';



-- Unit 10.8 (Ratio Test for Convergence) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.8',
  section_id = '10.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 130,
  skill_tags = ARRAY['SERIES_RATIO_TEST', 'FACTORIAL_MANIPULATION'],
  error_tags = ARRAY['E_RATIO_ALGEBRA_SLIP', 'E_FORGET_RATIO_TEST_CRITERIA'],
  prompt = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} \frac{3^n}{n!}$$',
  latex = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} \frac{3^n}{n!}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by the Ratio Test','explanation','Compute $\lim\left|\frac{a_{n+1}}{a_n}\right|=\lim\frac{3}{n+1}=0<1$, so it converges.'),
    jsonb_build_object('id','B','text','Diverges by the Ratio Test','explanation','The ratio limit is $0$, not greater than $1$.'),
    jsonb_build_object('id','C','text','Ratio Test is inconclusive','explanation','Inconclusive occurs when the ratio limit equals $1$, not $0$.'),
    jsonb_build_object('id','D','text','Diverges because $3^n$ grows exponentially','explanation','Factorial growth dominates exponential growth in this context.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{3^n}{n!}$. Then
$$\left|\frac{a_{n+1}}{a_n}\right|=\frac{3^{n+1}/(n+1)!}{3^n/n!}=\frac{3}{n+1}.$$
So
$$\lim_{n\to\infty}\left|\frac{a_{n+1}}{a_n}\right|=0<1,$$
and the series converges by the Ratio Test.',
  recommendation_reasons = ARRAY['Core ratio-test setup with factorial cancellation.', 'Reinforces correct interpretation of the ratio limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Classic factorial-vs-exponential ratio test.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SERIES_RATIO_TEST',
  supporting_skill_ids = ARRAY['FACTORIAL_MANIPULATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.8-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.8',
  section_id = '10.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SERIES_RATIO_TEST', 'EXPONENTIAL_GROWTH_COMPARISON'],
  error_tags = ARRAY['E_RATIO_ALGEBRA_SLIP', 'E_FORGET_RATIO_TEST_CRITERIA'],
  prompt = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} \frac{n^5}{2^n}$$',
  latex = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} \frac{n^5}{2^n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges because $n^5$ increases without bound','explanation','Growth of $n^5$ does not decide convergence when divided by $2^n$.'),
    jsonb_build_object('id','B','text','Converges by the Ratio Test','explanation','Ratio tends to $\frac{1}{2}<1$ (polynomial factor becomes negligible).'),
    jsonb_build_object('id','C','text','Ratio Test is inconclusive','explanation','The ratio limit is not $1$.'),
    jsonb_build_object('id','D','text','Diverges by the nth-term test because $\frac{n^5}{2^n}\not\to 0$','explanation','In fact $\frac{n^5}{2^n}\to 0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{n^5}{2^n}$. Then
$$\frac{a_{n+1}}{a_n}=\frac{(n+1)^5/2^{n+1}}{n^5/2^n}=\left(\frac{n+1}{n}\right)^5\cdot\frac{1}{2}.$$
As $n\to\infty$, $\left(\frac{n+1}{n}\right)^5\to 1$, so
$$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=\frac{1}{2}<1.$$
Therefore, the series converges by the Ratio Test.',
  recommendation_reasons = ARRAY['Highlights the standard outcome: polynomial over exponential converges.', 'Checks ratio setup and limit evaluation without calculator.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Common trap: concluding divergence just because numerator grows.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SERIES_RATIO_TEST',
  supporting_skill_ids = ARRAY['EXPONENTIAL_GROWTH_COMPARISON'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.8-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.8',
  section_id = '10.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SERIES_RATIO_TEST', 'ALGEBRA_SIMPLIFICATION'],
  error_tags = ARRAY['E_FORGET_RATIO_TEST_CRITERIA', 'E_RATIO_ALGEBRA_SLIP'],
  prompt = 'For what values of $k$ does the series converge?

$$\sum_{n=1}^{\infty} \frac{k^n}{n}$$',
  latex = 'For what values of $k$ does the series converge?

$$\sum_{n=1}^{\infty} \frac{k^n}{n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges only when $k=0$','explanation','If $|k|<1$, the series converges; $k=0$ is just a special case.'),
    jsonb_build_object('id','B','text','Converges for $|k|<1$ and diverges for $|k|\ge 1$','explanation','At $k=-1$, the series is alternating harmonic and converges, so this is not fully correct.'),
    jsonb_build_object('id','C','text','Converges for $-1\le k<1$ and diverges otherwise','explanation','For $|k|<1$ ratio test gives convergence; $k=-1$ converges (alternating harmonic); $k=1$ diverges (harmonic).'),
    jsonb_build_object('id','D','text','Converges for $|k|\le 1$','explanation','$k=1$ gives the harmonic series, which diverges.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{k^n}{n}$. For $|k|<1$,
$$\left|\frac{a_{n+1}}{a_n}\right|=\left|\frac{k^{n+1}/(n+1)}{k^n/n}\right|=|k|\cdot\frac{n}{n+1}\to |k|<1,$$
so the series converges by the Ratio Test. For $k=1$, the series is $\sum \frac{1}{n}$ (diverges). For $k=-1$, the series is $\sum \frac{(-1)^n}{n}$ (converges by AST). Therefore it converges for $-1\le k<1$ and diverges otherwise.',
  recommendation_reasons = ARRAY['Checks ratio test for parameter series and careful endpoint analysis.', 'Targets a typical overgeneralization: “$|k|\ge 1$ always diverges.”'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Ratio test plus endpoint classification; includes $k=-1$ edge case.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SERIES_RATIO_TEST',
  supporting_skill_ids = ARRAY['ALGEBRA_SIMPLIFICATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.8-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.8',
  section_id = '10.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SERIES_RATIO_TEST', 'FACTORIAL_MANIPULATION'],
  error_tags = ARRAY['E_RATIO_ALGEBRA_SLIP', 'E_FORGET_RATIO_TEST_CRITERIA'],
  prompt = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} \frac{n!}{n^n}$$',
  latex = 'Determine whether the series converges or diverges.

$$\sum_{n=1}^{\infty} \frac{n!}{n^n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges because $n!$ grows quickly','explanation','Need a test; ratio test shows strong decay.'),
    jsonb_build_object('id','B','text','Ratio Test is inconclusive','explanation','The ratio limit is $1/e<1$, so it is conclusive.'),
    jsonb_build_object('id','C','text','Converges by the Ratio Test','explanation','Compute $\lim \frac{a_{n+1}}{a_n}=\lim \left(\frac{n}{n+1}\right)^n=\frac{1}{e}<1$.'),
    jsonb_build_object('id','D','text','Diverges by the nth-term test because $\frac{n!}{n^n}\not\to 0$','explanation','In fact $\frac{n!}{n^n}\to 0$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{n!}{n^n}$. Then
$$\frac{a_{n+1}}{a_n}=\frac{(n+1)!/(n+1)^{n+1}}{n!/n^n}=\left(\frac{n}{n+1}\right)^n.$$
So
$$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=\lim_{n\to\infty}\left(1-\frac{1}{n+1}\right)^n=\frac{1}{e}<1.$$
Therefore, the series converges by the Ratio Test.',
  recommendation_reasons = ARRAY['BC-style ratio limit producing $1/e$.', 'Strengthens algebra with factorial/exponent expressions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key limit: $(n/(n+1))^n\to 1/e$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SERIES_RATIO_TEST',
  supporting_skill_ids = ARRAY['FACTORIAL_MANIPULATION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.8-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.8',
  section_id = '10.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 200,
  skill_tags = ARRAY['SERIES_RATIO_TEST', 'RATIO_TEST_INCONCLUSIVE'],
  error_tags = ARRAY['E_FORGET_RATIO_TEST_CRITERIA', 'E_ASSUME_RATIO_ALWAYS_WORKS'],
  prompt = 'Use the Ratio Test to analyze the series.

$$\sum_{n=1}^{\infty} \frac{1}{n}$$
Which statement is correct?',
  latex = 'Use the Ratio Test to analyze the series.

$$\sum_{n=1}^{\infty} \frac{1}{n}$$
Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Ratio Test shows convergence because the ratio is less than $1$','explanation','Here $\frac{a_{n+1}}{a_n}=\frac{n}{n+1}\to 1$, not a number less than $1$.'),
    jsonb_build_object('id','B','text','Ratio Test shows divergence because the ratio is greater than $1$','explanation','The ratio is less than $1$ for each $n$, and the limit is $1$.'),
    jsonb_build_object('id','C','text','Ratio Test is inconclusive because the ratio limit equals $1$','explanation','Correct: ratio test is inconclusive when the limit is exactly $1$.'),
    jsonb_build_object('id','D','text','Ratio Test cannot be applied because the terms are not positive','explanation','The terms are positive; it can be applied but gives an inconclusive result.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\frac{1}{n}$. Then
$$\frac{a_{n+1}}{a_n}=\frac{1/(n+1)}{1/n}=\frac{n}{n+1},$$
so
$$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=1.$$
When the ratio limit equals $1$, the Ratio Test is inconclusive. The series actually diverges, but that requires another test.',
  recommendation_reasons = ARRAY['Directly targets the misconception that Ratio Test always decides.', 'Reinforces the exact decision rule: $L<1$ converge, $L>1$ diverge, $L=1$ inconclusive.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Ratio test inconclusive example (harmonic).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SERIES_RATIO_TEST',
  supporting_skill_ids = ARRAY['RATIO_TEST_INCONCLUSIVE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.8-P5';

COMMIT;
