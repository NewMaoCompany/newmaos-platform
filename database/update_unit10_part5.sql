-- PREVENT FK ERROR: ensure topic_id exists in public.topic_content
-- If your topic_content table uses a different primary key column name, change (id) accordingly.
INSERT INTO public.topic_content (id, title)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO NOTHING;

-- Unit 10.9 (Determining Absolute or Conditional Convergence) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.9',
  section_id = '10.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_SERIES_ABS_COND_CLASSIFY', 'SK_ALT_SERIES_TEST'],
  error_tags = ARRAY['E_CONFUSE_ABS_VS_COND', 'E_FORGET_AST_CONDITIONS'],
  prompt = 'Determine whether the series $\sum_{n=1}^{\infty} \frac{(-1)^{n}}{n}$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether the series $$\sum_{n=1}^{\infty} \frac{(-1)^{n}}{n}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges absolutely','explanation','Absolute convergence would require $\sum \left|\frac{(-1)^n}{n}\right|=\sum \frac{1}{n}$ to converge, but the harmonic series diverges.'),
    jsonb_build_object('id','B','text','Converges conditionally','explanation','The alternating harmonic series converges by the Alternating Series Test, but not absolutely since $\sum \frac{1}{n}$ diverges.'),
    jsonb_build_object('id','C','text','Diverges because terms alternate','explanation','Alternation alone does not imply divergence; the Alternating Series Test can guarantee convergence.'),
    jsonb_build_object('id','D','text','Diverges because it is a $p$-series with $p=1$','explanation','That conclusion applies to $\sum \frac{1}{n}$ (non-alternating). The given series is alternating.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Check absolute convergence:
$$\sum_{n=1}^{\infty}\left|\frac{(-1)^n}{n}\right|=\sum_{n=1}^{\infty}\frac{1}{n}$$
diverges. For conditional convergence, let $b_n=\frac{1}{n}$. Then $b_n$ decreases and $\lim_{n\to\infty}b_n=0$, so by AST,
$$\sum_{n=1}^{\infty}\frac{(-1)^n}{n}$$
converges. Therefore it converges conditionally.',
  recommendation_reasons = ARRAY['Reinforces the difference between convergence and absolute convergence.', 'Targets the trap of applying $p$-series conclusions without checking the alternating sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: classify as absolute vs conditional using absolute-value series and AST.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_SERIES_ABS_COND_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_ALT_SERIES_TEST'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.9-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.9',
  section_id = '10.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_SERIES_ABS_COND_CLASSIFY', 'SK_LIMIT_COMPARISON'],
  error_tags = ARRAY['E_CONFUSE_ABS_VS_COND', 'E_WRONG_ASYMPTOTIC'],
  prompt = 'Determine whether the series $\sum_{n=1}^{\infty} \frac{(-1)^n\, n}{n^2+1}$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether the series $$\sum_{n=1}^{\infty} \frac{(-1)^n\, n}{n^2+1}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges absolutely','explanation','Absolute convergence would require $\sum \frac{n}{n^2+1}$ to converge, but $\frac{n}{n^2+1}\sim \frac{1}{n}$ so it diverges.'),
    jsonb_build_object('id','B','text','Diverges by the $n$th-term test','explanation','Here $\frac{n}{n^2+1}\to 0$, so the $n$th-term test does not prove divergence.'),
    jsonb_build_object('id','C','text','Diverges because it is comparable to $\sum \frac{1}{n^2}$','explanation','The correct asymptotic behavior is $\frac{n}{n^2+1}\sim \frac{1}{n}$, not $\frac{1}{n^2}$.'),
    jsonb_build_object('id','D','text','Converges conditionally','explanation','The absolute-value series diverges (harmonic-like), but the alternating series converges by AST since $b_n=\frac{n}{n^2+1}$ decreases eventually and tends to $0$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Absolute value series:
$$\sum_{n=1}^{\infty}\left|\frac{(-1)^n n}{n^2+1}\right|=\sum_{n=1}^{\infty}\frac{n}{n^2+1}.$$
Since
$$\lim_{n\to\infty}\frac{\frac{n}{n^2+1}}{\frac{1}{n}}=\lim_{n\to\infty}\frac{n^2}{n^2+1}=1,$$
it diverges by limit comparison with $\sum \frac{1}{n}$. For the original series, $b_n=\frac{n}{n^2+1}\to 0$ and is decreasing for large $n$, so the alternating series converges by AST. Therefore it converges conditionally.',
  recommendation_reasons = ARRAY['Practices absolute vs conditional via limit comparison.', 'Builds asymptotic recognition: $\frac{n}{n^2+1}\sim \frac{1}{n}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: use asymptotics/limit comparison for absolute divergence, then AST for conditional convergence.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_SERIES_ABS_COND_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_LIMIT_COMPARISON'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.9-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.9',
  section_id = '10.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_SERIES_ABS_COND_CLASSIFY', 'SK_RATIO_TEST'],
  error_tags = ARRAY['E_MISAPPLY_RATIO_TEST', 'E_CONFUSE_ABS_VS_COND'],
  prompt = 'Determine whether the series $\sum_{n=1}^{\infty} (-1)^n\frac{3^n}{n!}$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether the series $$\sum_{n=1}^{\infty} (-1)^n\frac{3^n}{n!}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges absolutely','explanation','Apply the Ratio Test to $\sum \frac{3^n}{n!}$: $\frac{a_{n+1}}{a_n}=\frac{3}{n+1}\to 0<1$, so it converges absolutely.'),
    jsonb_build_object('id','B','text','Converges conditionally','explanation','Conditional convergence only occurs when the absolute-value series diverges. Here the absolute-value series converges.'),
    jsonb_build_object('id','C','text','Diverges by the $n$th-term test','explanation','The terms go to $0$ (factorial dominates), so the $n$th-term test does not prove divergence.'),
    jsonb_build_object('id','D','text','Diverges because it alternates','explanation','Alternation does not imply divergence.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Consider absolute convergence:
$$\sum_{n=1}^{\infty}\left|(-1)^n\frac{3^n}{n!}\right|=\sum_{n=1}^{\infty}\frac{3^n}{n!}.$$
Ratio Test:
$$\frac{a_{n+1}}{a_n}=\frac{3^{n+1}/(n+1)!}{3^n/n!}=\frac{3}{n+1}\to 0<1.$$
Thus the absolute-value series converges, so the original series converges absolutely.',
  recommendation_reasons = ARRAY['Connects absolute convergence with the Ratio Test.', 'Reinforces factorial growth leading to rapid convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply Ratio Test to absolute values to conclude absolute convergence.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_SERIES_ABS_COND_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_RATIO_TEST'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.9-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.9',
  section_id = '10.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_SERIES_ABS_COND_CLASSIFY', 'SK_DIRECT_COMPARISON', 'SK_ALT_SERIES_TEST'],
  error_tags = ARRAY['E_CONFUSE_ABS_VS_COND', 'E_FORGET_AST_CONDITIONS', 'E_BAD_COMPARISON_DIRECTION'],
  prompt = 'Determine whether the series $\sum_{n=2}^{\infty} (-1)^n\frac{1}{\ln n}$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether the series $$\sum_{n=2}^{\infty} (-1)^n\frac{1}{\ln n}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges absolutely','explanation','Absolute convergence would require $\sum \frac{1}{\ln n}$ to converge, but it diverges.'),
    jsonb_build_object('id','B','text','Converges conditionally','explanation','AST gives convergence since $b_n=\frac{1}{\ln n}$ decreases (for $n>e$) and tends to $0$, while $\sum \frac{1}{\ln n}$ diverges.'),
    jsonb_build_object('id','C','text','Diverges','explanation','The alternating series converges by AST; divergence is not correct.'),
    jsonb_build_object('id','D','text','Cannot be determined without the Integral Test','explanation','AST is sufficient to decide convergence of the alternating series.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Absolute value series:
$$\sum_{n=2}^{\infty}\left|(-1)^n\frac{1}{\ln n}\right|=\sum_{n=2}^{\infty}\frac{1}{\ln n}.$$
For $n\ge 3$, $\ln n < n$, so $\frac{1}{\ln n}>\frac{1}{n}$. Since $\sum \frac{1}{n}$ diverges, $\sum \frac{1}{\ln n}$ diverges by comparison. For the alternating series, $b_n=\frac{1}{\ln n}$ is decreasing for $n>e$ and $\lim_{n\to\infty}b_n=0$, so it converges by AST. Therefore it converges conditionally.',
  recommendation_reasons = ARRAY['High-frequency classification: alternating series with very slow decay.', 'Targets the misconception that $\sum \frac{1}{\ln n}$ might converge.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.40,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: conditional convergence via AST, and absolute divergence via comparison to harmonic series.',
  weight_primary = 0.50,
  weight_supporting = 0.50,
    primary_skill_id = 'SK_SERIES_ABS_COND_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_DIRECT_COMPARISON', 'SK_ALT_SERIES_TEST'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.9-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.9',
  section_id = '10.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_SERIES_ABS_COND_CLASSIFY', 'SK_P_SERIES'],
  error_tags = ARRAY['E_CONFUSE_ABS_VS_COND', 'E_MISAPPLY_PSERIES'],
  prompt = 'Determine whether the series $\sum_{n=1}^{\infty} \frac{(-1)^{n+1}}{n^3}$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether the series $$\sum_{n=1}^{\infty} \frac{(-1)^{n+1}}{n^3}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges conditionally','explanation','If $\sum |a_n|$ converges, then the series converges absolutely, not just conditionally.'),
    jsonb_build_object('id','B','text','Converges absolutely','explanation','$\sum \left|\frac{(-1)^{n+1}}{n^3}\right|=\sum \frac{1}{n^3}$ is a $p$-series with $p=3>1$, so it converges.'),
    jsonb_build_object('id','C','text','Diverges','explanation','The absolute-value series is a convergent $p$-series, so divergence is not correct.'),
    jsonb_build_object('id','D','text','Diverges because it alternates','explanation','Alternation does not imply divergence.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute absolute values:
$$\sum_{n=1}^{\infty}\left|\frac{(-1)^{n+1}}{n^3}\right|=\sum_{n=1}^{\infty}\frac{1}{n^3}.$$
This is a $p$-series with $p=3>1$, so it converges. Therefore the original series converges absolutely.',
  recommendation_reasons = ARRAY['Quick classification via $p$-series after taking absolute values.', 'Reinforces that absolute convergence implies convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: absolute convergence using a $p$-series test.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_SERIES_ABS_COND_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_P_SERIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.9-P5';



-- Unit 10.10 (Alternating Series Error Bound) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.10',
  section_id = '10.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_ALT_ERROR_BOUND', 'SK_ALT_SERIES_TEST'],
  error_tags = ARRAY['E_ERROR_BOUND_OFF_BY_ONE', 'E_FORGET_AST_CONDITIONS'],
  prompt = 'Let $S=\sum_{n=1}^{\infty} \frac{(-1)^{n+1}}{n^2}$. If $S_N$ is the $N$th partial sum, which is a valid bound for the error $|S-S_N|$?',
  latex = 'Let $S=\sum_{n=1}^{\infty} \frac{(-1)^{n+1}}{n^2}$. If $S_N$ is the $N$th partial sum, which is a valid bound for the error $|S-S_N|$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$|S-S_N|\le \frac{1}{N^2}$','explanation','The alternating-series bound uses the first omitted term $b_{N+1}=\frac{1}{(N+1)^2}$, not $b_N$.'),
    jsonb_build_object('id','B','text','$|S-S_N|\le \frac{1}{(N+1)^2}$','explanation','Correct: by the Alternating Series Estimation Theorem, $|S-S_N|\le b_{N+1}$ where $b_n=\frac{1}{n^2}$.'),
    jsonb_build_object('id','C','text','$|S-S_N|\le \sum_{n=N+1}^{\infty}\frac{1}{n^2}$','explanation','This is true, but the theorem guarantees the simpler bound $|S-S_N|\le b_{N+1}$.'),
    jsonb_build_object('id','D','text','$|S-S_N|\le \frac{1}{2(N+1)^2}$','explanation','There is no general factor of $\frac{1}{2}$ in the alternating-series error bound.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Here $b_n=\frac{1}{n^2}$ is positive, decreasing, and tends to $0$. By the Alternating Series Estimation Theorem,
$$|S-S_N|\le b_{N+1}=\frac{1}{(N+1)^2}.$$',
  recommendation_reasons = ARRAY['Direct practice of the Alternating Series Estimation Theorem.', 'Targets the common off-by-one remainder mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify the correct remainder bound $b_{N+1}$ for alternating series.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_ALT_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_ALT_SERIES_TEST'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.10-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.10',
  section_id = '10.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_ALT_ERROR_BOUND', 'SK_INEQUALITY_SOLVE'],
  error_tags = ARRAY['E_ERROR_BOUND_OFF_BY_ONE', 'E_INEQUALITY_ARITHMETIC'],
  prompt = 'Use the Alternating Series Estimation Theorem to find the smallest $N$ such that the partial sum $S_N$ of $\sum_{n=1}^{\infty}\frac{(-1)^{n+1}}{n}$ approximates the sum within $0.001$.',
  latex = 'Use the Alternating Series Estimation Theorem to find the smallest $N$ such that the partial sum $S_N$ of $$\sum_{n=1}^{\infty}\frac{(-1)^{n+1}}{n}$$ approximates the sum within $0.001$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$N=999$','explanation','Require $|S-S_N|\le b_{N+1}=\frac{1}{N+1}\le 0.001$, so $N+1\ge 1000$ and the smallest is $N=999$.'),
    jsonb_build_object('id','B','text','$N=1000$','explanation','This works but is not the smallest; $N=999$ already satisfies the bound.'),
    jsonb_build_object('id','C','text','$N=1001$','explanation','This is larger than necessary.'),
    jsonb_build_object('id','D','text','$N=998$','explanation','Then $b_{N+1}=\frac{1}{999}>0.001$, so it does not guarantee the accuracy.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For an alternating series with decreasing terms,
$$|S-S_N|\le b_{N+1}.$$
Here $b_n=\frac{1}{n}$, so require
$$\frac{1}{N+1}\le 0.001=\frac{1}{1000}.$$
Thus $N+1\ge 1000$ and the smallest integer is $N=999$.',
  recommendation_reasons = ARRAY['Connects remainder bounds to solving for required number of terms.', 'Targets off-by-one errors in $b_{N+1}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: solve $b_{N+1}\le \varepsilon$ for the smallest $N$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ALT_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_INEQUALITY_SOLVE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.10-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.10',
  section_id = '10.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 155,
  skill_tags = ARRAY['SK_ALT_ERROR_BOUND', 'SK_REMAINDER_INTERPRET'],
  error_tags = ARRAY['E_ERROR_BOUND_OFF_BY_ONE', 'E_CONFUSE_ABS_VS_COND'],
  prompt = 'Let $S=\sum_{n=1}^{\infty} (-1)^{n+1}\frac{1}{\sqrt{n}}$. Which statement is guaranteed by the Alternating Series Estimation Theorem?',
  latex = 'Let $S=\sum_{n=1}^{\infty} (-1)^{n+1}\frac{1}{\sqrt{n}}$. Which statement is guaranteed by the Alternating Series Estimation Theorem?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$|S-S_N|\le \frac{1}{\sqrt{N}}$','explanation','The bound uses the first omitted term $b_{N+1}=\frac{1}{\sqrt{N+1}}$, not $b_N$.'),
    jsonb_build_object('id','B','text','The series converges absolutely','explanation','Not guaranteed; in fact $\sum \frac{1}{\sqrt{n}}$ diverges, so it is not absolutely convergent.'),
    jsonb_build_object('id','C','text','$|S-S_N|\le \frac{1}{\sqrt{N+1}}$','explanation','Correct: if $b_n=\frac{1}{\sqrt{n}}$ decreases and tends to $0$, then $|S-S_N|\le b_{N+1}$.'),
    jsonb_build_object('id','D','text','$S_N$ is always less than $S$','explanation','Partial sums alternate around the limit; they are not always on one side.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'With $b_n=\frac{1}{\sqrt{n}}$, we have $b_n>0$, $b_n$ decreasing, and $b_n\to 0$. Thus the alternating series converges and
$$|S-S_N|\le b_{N+1}=\frac{1}{\sqrt{N+1}}.$$
The theorem does not claim absolute convergence or a fixed direction between $S_N$ and $S$.',
  recommendation_reasons = ARRAY['Separates what the theorem guarantees (a bound) from what it does not (absolute convergence).', 'Targets off-by-one mistakes in $b_{N+1}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interpret the alternating-series remainder bound and avoid extra claims.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_ALT_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_REMAINDER_INTERPRET'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.10-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.10',
  section_id = '10.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_ALT_ERROR_BOUND', 'SK_INEQUALITY_SOLVE'],
  error_tags = ARRAY['E_ERROR_BOUND_OFF_BY_ONE', 'E_INEQUALITY_ARITHMETIC'],
  prompt = 'For $S=\sum_{n=1}^{\infty} (-1)^{n+1}\frac{1}{2n+1}$, find the smallest $N$ such that $|S-S_N|<0.01$ is guaranteed.',
  latex = 'For $S=\sum_{n=1}^{\infty} (-1)^{n+1}\frac{1}{2n+1}$, find the smallest $N$ such that $|S-S_N|<0.01$ is guaranteed.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$N=49$','explanation','Require $b_{N+1}=\frac{1}{2(N+1)+1}=\frac{1}{2N+3}<0.01$. Solving gives $N>48.5$, so smallest integer is $49$.'),
    jsonb_build_object('id','B','text','$N=50$','explanation','This works but is not the smallest; $N=49$ already guarantees the bound.'),
    jsonb_build_object('id','C','text','$N=99$','explanation','This is far larger than necessary.'),
    jsonb_build_object('id','D','text','$N=24$','explanation','Then $b_{N+1}=\frac{1}{51}\approx 0.0196>0.01$, so it does not guarantee the accuracy.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'By Alternating Series Estimation Theorem,
$$|S-S_N|\le b_{N+1},\quad b_n=\frac{1}{2n+1}.$$
Require
$$\frac{1}{2(N+1)+1}<0.01\;\Rightarrow\;\frac{1}{2N+3}<0.01\;\Rightarrow\;2N+3>100\;\Rightarrow\;N>48.5.$$
Smallest integer is $N=49$.',
  recommendation_reasons = ARRAY['Fast practice turning an error tolerance into an inequality.', 'Targets off-by-one and rounding mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: solve for minimal $N$ using $b_{N+1}$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_ALT_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_INEQUALITY_SOLVE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.10-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.10',
  section_id = '10.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 185,
  skill_tags = ARRAY['SK_ALT_ERROR_BOUND', 'SK_REMAINDER_ESTIMATE'],
  error_tags = ARRAY['E_ERROR_BOUND_OFF_BY_ONE', 'E_INEQUALITY_ARITHMETIC', 'E_CANCEL_INCORRECTLY'],
  prompt = 'Let $S=\sum_{n=1}^{\infty} (-1)^{n+1}\frac{1}{n(n+1)}$. What is the smallest $N$ that guarantees $|S-S_N|\le 0.0005$?',
  latex = 'Let $S=\sum_{n=1}^{\infty} (-1)^{n+1}\frac{1}{n(n+1)}$. What is the smallest $N$ that guarantees $|S-S_N|\le 0.0005$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$N=44$','explanation','Here $b_{N+1}=\frac{1}{(N+1)(N+2)}$. For $N=44$, $b_{45}=\frac{1}{45\cdot 46}=\frac{1}{2070}\approx 0.000483<0.0005$, and $N=43$ fails.'),
    jsonb_build_object('id','B','text','$N=43$','explanation','Then $b_{44}=\frac{1}{44\cdot 45}=\frac{1}{1980}\approx 0.000505>0.0005$, so it does not guarantee the bound.'),
    jsonb_build_object('id','C','text','$N=45$','explanation','This works but is not the smallest, since $N=44$ already works.'),
    jsonb_build_object('id','D','text','$N=31$','explanation','Then $b_{32}=\frac{1}{32\cdot 33}=\frac{1}{1056}\approx 0.000947>0.0005$, so it does not guarantee the bound.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $b_n=\frac{1}{n(n+1)}$. Since $b_n>0$, decreases, and $b_n\to 0$, the alternating series converges and
$$|S-S_N|\le b_{N+1}=\frac{1}{(N+1)(N+2)}.$$
Require
$$\frac{1}{(N+1)(N+2)}\le 0.0005=\frac{1}{2000}\;\Rightarrow\;(N+1)(N+2)\ge 2000.$$
Check $N=43$: $(44)(45)=1980<2000$ (fails). Check $N=44$: $(45)(46)=2070\ge 2000$ (works). Thus the smallest is $N=44$.',
  recommendation_reasons = ARRAY['High-discrimination: near-threshold remainder bound with minimality check.', 'Targets the common off-by-one and inequality arithmetic errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.40,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute $b_{N+1}$ correctly and verify the smallest $N$ by testing neighboring integers.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_ALT_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_REMAINDER_ESTIMATE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.10-P5';

COMMIT;
