-- PREVENT FK ERROR: ensure topic_id exists in public.topic_content
INSERT INTO public.topic_content (id, title)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO NOTHING;

-- Unit 10.0 (Infinite Sequences and Series) — Unit Test Q1–Q20

BEGIN;

UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_NTH_TERM_TEST','SK_SERIES_CONVERGENCE_CLASSIFY'],
  primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_SERIES_CONVERGENCE_CLASSIFY'],
  error_tags = ARRAY['E_SKIP_TERM_TEST','E_CONFUSE_CONV_DIV'],
  prompt = 'Determine whether the infinite series $$\\sum_{n=1}^{\\infty}\\frac{n}{n+1}$$ converges or diverges.',
  latex = 'Determine whether the infinite series $$\\sum_{n=1}^{\\infty}\\frac{n}{n+1}$$ converges or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges','explanation','Correct: $\\lim_{n\\to\\infty}\\frac{n}{n+1}=1\\ne 0$, so the series diverges by the nth-term test.'),
    jsonb_build_object('id','B','text','Converges by comparison with $$\\sum \\frac{1}{n}$$','explanation','Comparison is unnecessary; if terms do not approach $0$, the series cannot converge.'),
    jsonb_build_object('id','C','text','Converges by telescoping','explanation','The terms do not form a telescoping difference that sums to a finite limit.'),
    jsonb_build_object('id','D','text','Converges by the ratio test','explanation','The nth-term test already shows divergence.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute the term limit: $$\\lim_{n\\to\\infty}\\frac{n}{n+1}=\\lim_{n\\to\\infty}\\frac{1}{1+1/n}=1\\ne 0.$$ Since the terms do not approach $0$, the series diverges by the nth-term test.',
  recommendation_reasons = ARRAY['Checks the required condition $a_n\\to 0$ for series convergence.','Targets the common mistake of skipping the nth-term test.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test must be checked before other convergence tests.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q1';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_GEOMETRIC_SERIES','SK_SERIES_CONVERGENCE_CLASSIFY'],
  primary_skill_id = 'SK_GEOMETRIC_SERIES',
  supporting_skill_ids = ARRAY['SK_SERIES_CONVERGENCE_CLASSIFY'],
  error_tags = ARRAY['E_GEOMETRIC_FORMULA','E_CONFUSE_CONV_DIV'],
  prompt = 'Find the sum of the infinite series $$\\sum_{n=0}^{\\infty} 6\\left(\\frac{2}{3}\\right)^n$$ if it converges.',
  latex = 'Find the sum of the infinite series $$\\sum_{n=0}^{\\infty} 6\\left(\\frac{2}{3}\\right)^n$$ if it converges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','6','explanation','This is only the first term, not the infinite sum.'),
    jsonb_build_object('id','B','text','18','explanation','Correct: $|r|=2/3<1$ and $S=\\frac{a}{1-r}=\\frac{6}{1-2/3}=18$.'),
    jsonb_build_object('id','C','text','12','explanation','This comes from using $1+r$ instead of $1-r$ in the denominator.'),
    jsonb_build_object('id','D','text','Diverges','explanation','It converges because $|r|<1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'This is geometric with first term $a=6$ and ratio $r=\\frac{2}{3}$. Since $|r|<1$, it converges and $$S=\\frac{a}{1-r}=\\frac{6}{1-2/3}=18.$$',
  recommendation_reasons = ARRAY['Reinforces geometric convergence criterion and infinite-sum formula.','Targets the common sign error in $1-r$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify $a$ and $r$ correctly; apply $S=a/(1-r)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q2';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_INTEGRAL_TEST','SK_LOG_SUBSTITUTION'],
  primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_LOG_SUBSTITUTION'],
  error_tags = ARRAY['E_WRONG_SUBSTITUTION','E_CONFUSE_CONV_DIV'],
  prompt = 'Determine whether the series $$\\sum_{n=2}^{\\infty}\\frac{1}{n(\\ln n)^2}$$ converges or diverges.',
  latex = 'Determine whether the series $$\\sum_{n=2}^{\\infty}\\frac{1}{n(\\ln n)^2}$$ converges or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges because it is larger than $$\\sum \\frac{1}{n}$$','explanation','For large $n$, $\\frac{1}{n(\\ln n)^2}<\\frac{1}{n}$, and the correct method here is the integral test.'),
    jsonb_build_object('id','B','text','Diverges by the ratio test','explanation','The ratio test is not the natural tool for this form.'),
    jsonb_build_object('id','C','text','Converges by the integral test','explanation','Correct: $\\int_2^{\\infty}\\frac{1}{x(\\ln x)^2}\\,dx$ converges.'),
    jsonb_build_object('id','D','text','Converges because it is a $p$-series with $p=2$','explanation','It is not of the form $\\sum 1/n^p$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use the integral test with $f(x)=\\frac{1}{x(\\ln x)^2}$. Compute $$\\int_2^{\\infty}\\frac{1}{x(\\ln x)^2}\\,dx.$$ Let $u=\\ln x$, $du=\\frac{1}{x}dx$. Then $$\\int_{\\ln 2}^{\\infty}\\frac{1}{u^2}\\,du=\\left[-\\frac{1}{u}\\right]_{\\ln 2}^{\\infty}=\\frac{1}{\\ln 2},$$ which is finite, so the series converges.',
  recommendation_reasons = ARRAY['Builds mastery of the classic $1/(n(\\ln n)^p)$ boundary behavior.','Targets substitution errors in integral test problems.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: integral test with $u=\\ln x$ substitution.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q3';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 70,
  skill_tags = ARRAY['SK_P_SERIES'],
  primary_skill_id = 'SK_P_SERIES',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_P_SERIES_THRESHOLD'],
  prompt = 'For what values of $p$ does the series $$\\sum_{n=1}^{\\infty}\\frac{1}{n^p}$$ converge?',
  latex = 'For what values of $p$ does the series $$\\sum_{n=1}^{\\infty}\\frac{1}{n^p}$$ converge?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$p>0$','explanation','Not enough: the harmonic case $p=1$ diverges.'),
    jsonb_build_object('id','B','text','$p\\ge 1$','explanation','At $p=1$ the series is harmonic and diverges.'),
    jsonb_build_object('id','C','text','$p>1$','explanation','Correct: a $p$-series converges if and only if $p>1$.'),
    jsonb_build_object('id','D','text','All real $p$','explanation','False: for $p\\le 1$ it diverges, and for $p\\le 0$ terms do not approach $0$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'A $p$-series $$\\sum_{n=1}^{\\infty}\\frac{1}{n^p}$$ converges if and only if $p>1$, and it diverges for $p\\le 1$.',
  recommendation_reasons = ARRAY['Locks in a foundational criterion used in comparison tests.','Targets the frequent endpoint mistake at $p=1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: $p$-series convergence threshold.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q4';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_LIMIT_COMPARISON','SK_P_SERIES'],
  primary_skill_id = 'SK_LIMIT_COMPARISON',
  supporting_skill_ids = ARRAY['SK_P_SERIES'],
  error_tags = ARRAY['E_WRONG_DOMINANT_TERM','E_CONFUSE_CONV_DIV'],
  prompt = 'Determine whether the series $$\\sum_{n=1}^{\\infty}\\frac{3n+1}{n^3+2}$$ converges or diverges.',
  latex = 'Determine whether the series $$\\sum_{n=1}^{\\infty}\\frac{3n+1}{n^3+2}$$ converges or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges because it behaves like $$\\sum \\frac{1}{n}$$','explanation','Dominant terms give $\\frac{3n}{n^3}=\\frac{3}{n^2}$, not $1/n$.'),
    jsonb_build_object('id','B','text','Converges by limit comparison with $$\\sum \\frac{1}{n^2}$$','explanation','Correct: the limit comparison constant is finite and nonzero.'),
    jsonb_build_object('id','C','text','Diverges by the nth-term test','explanation','Here $\\lim a_n=0$, so the nth-term test is inconclusive.'),
    jsonb_build_object('id','D','text','Converges by the alternating series test','explanation','The series is not alternating.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use limit comparison with $\\sum \\frac{1}{n^2}$. Let $a_n=\\frac{3n+1}{n^3+2}$ and $b_n=\\frac{1}{n^2}$. Then\n$$\\lim_{n\\to\\infty}\\frac{a_n}{b_n}=\\lim_{n\\to\\infty}\\frac{(3n+1)n^2}{n^3+2}=\\lim_{n\\to\\infty}\\frac{3n^3+n^2}{n^3+2}=3.$$ Since $0<3<\\infty$ and $\\sum 1/n^2$ converges, the given series converges.',
  recommendation_reasons = ARRAY['Builds dominant-term reasoning for rational functions.','Targets the common mistake of comparing to $1/n$ instead of $1/n^2$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: limit comparison with a $p$-series.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q5';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_SERIES_ALTERNATING_TEST','SK_ABS_COND_CONVERGENCE'],
  primary_skill_id = 'SK_SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['SK_ABS_COND_CONVERGENCE'],
  error_tags = ARRAY['E_AST_CONDITIONS','E_ABS_VS_COND'],
  prompt = 'Determine whether the series $$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{\\ln n}{n}$$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether the series $$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{\\ln n}{n}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges absolutely','explanation','The absolute series $\\sum \\frac{\\ln n}{n}$ diverges.'),
    jsonb_build_object('id','B','text','Diverges','explanation','By AST, it converges because $\\frac{\\ln n}{n}\\to 0$ and is eventually decreasing.'),
    jsonb_build_object('id','C','text','Converges conditionally','explanation','Correct: the alternating series converges, but the absolute series diverges.'),
    jsonb_build_object('id','D','text','Converges but cannot be classified','explanation','It can be classified by checking the absolute series.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $b_n=\\frac{\\ln n}{n}$. Then $b_n>0$, $\\lim b_n=0$, and $b_n$ is eventually decreasing, so the alternating series converges by AST. For absolute convergence, consider $$\\sum_{n=1}^{\\infty}\\frac{\\ln n}{n}.$$ By the integral test, $$\\int \\frac{\\ln x}{x}\\,dx=\\frac{1}{2}(\\ln x)^2\\to\\infty,$$ so the absolute series diverges. Therefore the series converges conditionally.',
  recommendation_reasons = ARRAY['Strengthens conditional vs absolute classification in BC series.','Targets confusion between AST convergence and absolute convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: AST plus absolute divergence via an integral test.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q6';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_RATIO_TEST'],
  primary_skill_id = 'SK_RATIO_TEST',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_RATIO_TEST_INTERPRET','E_ALGEBRA_SLIP'],
  prompt = 'Use the ratio test to determine the convergence of $$\\sum_{n=1}^{\\infty}\\frac{n!}{3^n}$$.',
  latex = 'Use the ratio test to determine the convergence of $$\\sum_{n=1}^{\\infty}\\frac{n!}{3^n}$$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges','explanation','The ratio test gives a limit greater than $1$, so it does not converge.'),
    jsonb_build_object('id','B','text','Diverges','explanation','Correct: $\\frac{a_{n+1}}{a_n}=\\frac{n+1}{3}\\to\\infty>1$, so it diverges.'),
    jsonb_build_object('id','C','text','Inconclusive','explanation','The ratio test is conclusive because the limit exists and is $>1$.'),
    jsonb_build_object('id','D','text','Converges conditionally','explanation','All terms are positive, so conditional convergence does not apply.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\\frac{n!}{3^n}$. Then\n$$\\frac{a_{n+1}}{a_n}=\\frac{(n+1)!/3^{n+1}}{n!/3^n}=\\frac{n+1}{3}.$$ Thus $$\\lim_{n\\to\\infty}\\frac{a_{n+1}}{a_n}=\\infty>1,$$ so the series diverges by the ratio test.',
  recommendation_reasons = ARRAY['Reinforces factorial vs exponential growth under the ratio test.','Targets misinterpretation of the ratio test conclusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: ratio test mechanics with factorial terms.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q7';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_SERIES_ALTERNATING_TEST','SK_ABS_COND_CONVERGENCE','SK_P_SERIES'],
  primary_skill_id = 'SK_SERIES_ALTERNATING_TEST',
  supporting_skill_ids = ARRAY['SK_P_SERIES'],
  error_tags = ARRAY['E_ABS_VS_COND','E_P_SERIES_THRESHOLD'],
  prompt = 'Determine whether $$\\sum_{n=1}^{\\infty}(-1)^n\\frac{1}{\\sqrt{n}}$$ converges absolutely, converges conditionally, or diverges.',
  latex = 'Determine whether $$\\sum_{n=1}^{\\infty}(-1)^n\\frac{1}{\\sqrt{n}}$$ converges absolutely, converges conditionally, or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges conditionally','explanation','Correct: AST applies, but $\\sum 1/\\sqrt{n}$ diverges as a $p$-series with $p=1/2$.'),
    jsonb_build_object('id','B','text','Converges absolutely','explanation','The absolute series is $\\sum 1/\\sqrt{n}$, which diverges.'),
    jsonb_build_object('id','C','text','Diverges','explanation','Because $1/\\sqrt{n}\\downarrow 0$, the alternating series converges by AST.'),
    jsonb_build_object('id','D','text','Inconclusive','explanation','AST is conclusive here.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'With $b_n=1/\\sqrt{n}$, we have $b_n\\downarrow 0$, so the series converges by the alternating series test. The absolute series is $$\\sum_{n=1}^{\\infty}\\frac{1}{\\sqrt{n}},$$ a $p$-series with $p=\\tfrac12\\le 1$, which diverges. Therefore the series converges conditionally.',
  recommendation_reasons = ARRAY['Builds correct classification: alternating convergence does not imply absolute convergence.','Targets the frequent mistake of assuming $p<1$ still converges.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: AST + absolute divergence via $p$-series.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q8';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_ALTERNATING_ERROR_BOUND','SK_SERIES_ALTERNATING_TEST'],
  primary_skill_id = 'SK_ALTERNATING_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_SERIES_ALTERNATING_TEST'],
  error_tags = ARRAY['E_OFF_BY_ONE_N','E_AST_CONDITIONS'],
  prompt = 'Let $$S=\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{1}{n^2}.$$ What is the least $N$ such that the partial sum $S_N$ satisfies $|S-S_N|<0.001$?',
  latex = 'Let $$S=\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{1}{n^2}.$$ What is the least $N$ such that the partial sum $S_N$ satisfies $|S-S_N|<0.001$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$N=10$','explanation','$b_{11}=1/11^2\\approx 0.00826$, which is not less than $0.001$.'),
    jsonb_build_object('id','B','text','$N=20$','explanation','$b_{21}=1/21^2\\approx 0.00227$, which is not less than $0.001$.'),
    jsonb_build_object('id','C','text','$N=31$','explanation','Correct: $b_{32}=1/32^2=1/1024\\approx 0.0009766<0.001$, and $b_{31}=1/31^2>0.001$.'),
    jsonb_build_object('id','D','text','$N=32$','explanation','This works, but it is not the least. $N=31$ already guarantees the bound.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'For an alternating series with decreasing $b_n$, the remainder satisfies $|S-S_N|\\le b_{N+1}$. Here $b_n=1/n^2$, so require $$\\frac{1}{(N+1)^2}<0.001=\\frac{1}{1000}.$$ Thus $(N+1)^2>1000$. Since $31^2=961<1000$ and $32^2=1024>1000$, the least $N$ is $31$.',
  recommendation_reasons = ARRAY['Reinforces alternating remainder bound and correct off-by-one handling.','Targets the frequent confusion between $N$ and $N+1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: alternating series error bound with least $N$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q9';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_TAYLOR_POLYNOMIAL','SK_MACLAURIN_KNOWN_SERIES'],
  primary_skill_id = 'SK_TAYLOR_POLYNOMIAL',
  supporting_skill_ids = ARRAY['SK_MACLAURIN_KNOWN_SERIES'],
  error_tags = ARRAY['E_TAYLOR_SIGN','E_ALGEBRA_SLIP'],
  prompt = 'Find the Maclaurin polynomial of degree 3 for $f(x)=\\sin x$.',
  latex = 'Find the Maclaurin polynomial of degree 3 for $f(x)=\\sin x$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x-\\frac{x^3}{6}$','explanation','Correct: $\\sin x=x-\\frac{x^3}{3!}+\\cdots$.'),
    jsonb_build_object('id','B','text','$x+\\frac{x^3}{6}$','explanation','Sign error on the $x^3$ term.'),
    jsonb_build_object('id','C','text','$1-\\frac{x^2}{2}$','explanation','This is the degree-2 Maclaurin polynomial for $\\cos x$.'),
    jsonb_build_object('id','D','text','$x-\\frac{x^2}{2}+\\frac{x^3}{6}$','explanation','Includes terms not present in the Maclaurin series for $\\sin x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The Maclaurin series is $$\\sin x=x-\\frac{x^3}{3!}+\\frac{x^5}{5!}-\\cdots.$$ Truncating at degree 3 gives $$P_3(x)=x-\\frac{x^3}{6}.$$',
  recommendation_reasons = ARRAY['Checks a standard BC Maclaurin expansion.','Targets sign mistakes in odd-power terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: Maclaurin polynomial (degree 3) for $\\sin x$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q10';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_LAGRANGE_ERROR_BOUND','SK_TAYLOR_POLYNOMIAL'],
  primary_skill_id = 'SK_LAGRANGE_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_TAYLOR_POLYNOMIAL'],
  error_tags = ARRAY['E_LAGRANGE_ORDER','E_WRONG_INTERVAL_MAX'],
  prompt = 'Let $P_3(x)$ be the degree-3 Maclaurin polynomial for $e^x$. Using the Lagrange error bound, which is an upper bound for $|e^{0.2}-P_3(0.2)|$?',
  latex = 'Let $P_3(x)$ be the degree-3 Maclaurin polynomial for $e^x$. Using the Lagrange error bound, which is an upper bound for $|e^{0.2}-P_3(0.2)|$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{e^{0.2}(0.2)^4}{4!}$','explanation','Correct: $|R_3(x)|\\le \\dfrac{M|x|^4}{4!}$ with $M=\\max_{[0,0.2]} e^x=e^{0.2}$.'),
    jsonb_build_object('id','B','text','$\\dfrac{e^{0.2}(0.2)^3}{3!}$','explanation','Uses the wrong remainder order for a degree-3 polynomial.'),
    jsonb_build_object('id','C','text','$\\dfrac{(0.2)^4}{4!}$','explanation','Missing the maximum value $M$ of the 4th derivative on the interval.'),
    jsonb_build_object('id','D','text','$\\dfrac{e^{0.2}(0.2)^5}{5!}$','explanation','This corresponds to bounding the degree-4 remainder, not the degree-3 remainder.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For a degree-3 Taylor polynomial, the Lagrange remainder satisfies $$|R_3(x)|\\le \\frac{M|x|^4}{4!}$$ where $M=\\max |f^{(4)}(t)|$ for $t$ between $0$ and $x$. For $f(x)=e^x$, $f^{(4)}(t)=e^t$, so on $[0,0.2]$ we have $M=e^{0.2}$. Therefore $$|e^{0.2}-P_3(0.2)|\\le \\frac{e^{0.2}(0.2)^4}{4!}.$$',
  recommendation_reasons = ARRAY['Builds correct Lagrange remainder structure and order.','Targets the common mistake of using $3!$ instead of $4!$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: Lagrange error bound with correct derivative order and maximum on interval.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q11';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_RADIUS_CONVERGENCE','SK_RATIO_TEST'],
  primary_skill_id = 'SK_RADIUS_CONVERGENCE',
  supporting_skill_ids = ARRAY['SK_RATIO_TEST'],
  error_tags = ARRAY['E_RADIUS_RECIPROCAL','E_ALGEBRA_SLIP'],
  prompt = 'Find the radius of convergence of the power series $$\\sum_{n=1}^{\\infty}\\frac{(x-2)^n}{n\\,3^n}.$$',
  latex = 'Find the radius of convergence of the power series $$\\sum_{n=1}^{\\infty}\\frac{(x-2)^n}{n\\,3^n}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$R=1$','explanation','This ignores the $3^n$ factor that sets the scaling.'),
    jsonb_build_object('id','B','text','$R=3$','explanation','Correct: ratio test gives $|x-2|<3$.'),
    jsonb_build_object('id','C','text','$R=\\frac{1}{3}$','explanation','This is the reciprocal of the correct radius.'),
    jsonb_build_object('id','D','text','$R=0$','explanation','This would mean convergence only at $x=2$, which is false.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\\frac{(x-2)^n}{n3^n}$. Then $$\\left|\\frac{a_{n+1}}{a_n}\\right|=\\left|\\frac{x-2}{3}\\right|\\cdot\\frac{n}{n+1}\\to \\left|\\frac{x-2}{3}\\right|.$$ Convergence requires $\\left|\\frac{x-2}{3}\\right|<1$, i.e. $|x-2|<3$. Thus $R=3$.',
  recommendation_reasons = ARRAY['Reinforces radius via ratio test including the $n/(n+1)$ factor.','Targets reciprocal mistakes when solving $|x-a|/k<1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: radius of convergence centered at 2.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q12';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_INTERVAL_CONVERGENCE','SK_RATIO_TEST','SK_ENDPOINT_TESTING'],
  primary_skill_id = 'SK_INTERVAL_CONVERGENCE',
  supporting_skill_ids = ARRAY['SK_RATIO_TEST'],
  error_tags = ARRAY['E_ENDPOINT_NOT_CHECKED','E_AST_CONDITIONS'],
  prompt = 'Find the interval of convergence of $$\\sum_{n=1}^{\\infty}\\frac{(x+1)^n}{n}.$$',
  latex = 'Find the interval of convergence of $$\\sum_{n=1}^{\\infty}\\frac{(x+1)^n}{n}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-2,0)$','explanation','This misses that $x=-2$ converges as an alternating harmonic series.'),
    jsonb_build_object('id','B','text','$[-2,0)$','explanation','Correct: $x=-2$ gives $\\sum (-1)^n/n$ (converges) and $x=0$ gives $\\sum 1/n$ (diverges).'),
    jsonb_build_object('id','C','text','$(-2,0]$','explanation','At $x=0$ the series is harmonic and diverges.'),
    jsonb_build_object('id','D','text','$[-2,0]$','explanation','Includes $x=0$, but $\\sum 1/n$ diverges.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Ratio test: with $a_n=\\frac{(x+1)^n}{n}$, $$\\left|\\frac{a_{n+1}}{a_n}\\right|=|x+1|\\cdot\\frac{n}{n+1}\\to |x+1|.$$ So the series converges for $|x+1|<1$, i.e. $-2<x<0$. Endpoint checks: at $x=-2$, the series is $\\sum \\frac{(-1)^n}{n}$ (converges by AST). At $x=0$, the series is $\\sum \\frac{1}{n}$ (diverges). Therefore the interval is $[-2,0)$.',
  recommendation_reasons = ARRAY['Forces endpoint testing after finding the radius.','Targets the common mistake of excluding all endpoints automatically.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interval of convergence with contrasting endpoint behavior.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q13';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_MACLAURIN_KNOWN_SERIES','SK_TAYLOR_POLYNOMIAL'],
  primary_skill_id = 'SK_MACLAURIN_KNOWN_SERIES',
  supporting_skill_ids = ARRAY['SK_TAYLOR_POLYNOMIAL'],
  error_tags = ARRAY['E_TAYLOR_SIGN','E_WRONG_FUNCTION_SERIES'],
  prompt = 'Find the first three nonzero terms of the Maclaurin series for $\\ln(1+x)$.',
  latex = 'Find the first three nonzero terms of the Maclaurin series for $\\ln(1+x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x+\\frac{x^2}{2}+\\frac{x^3}{3}$','explanation','The signs should alternate after the first term.'),
    jsonb_build_object('id','B','text','$x-\\frac{x^2}{2}+\\frac{x^3}{3}$','explanation','Correct: $\\ln(1+x)=x-\\frac{x^2}{2}+\\frac{x^3}{3}-\\cdots$.'),
    jsonb_build_object('id','C','text','$1-x+\\frac{x^2}{2}$','explanation','This resembles the start of $e^{-x}$, not $\\ln(1+x)$.'),
    jsonb_build_object('id','D','text','$x-\\frac{x^3}{3}+\\frac{x^5}{5}$','explanation','This is the start of the series for $\\arctan x$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A standard Maclaurin series is $$\\ln(1+x)=\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^n}{n}=x-\\frac{x^2}{2}+\\frac{x^3}{3}-\\cdots.$$ Thus the first three nonzero terms are $x-\\frac{x^2}{2}+\\frac{x^3}{3}$.',
  recommendation_reasons = ARRAY['Reinforces a key memorized Maclaurin series.','Targets sign-pattern errors and confusing series between functions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: known series for $\\ln(1+x)$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q14';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_POWER_SERIES_OPERATIONS','SK_DERIVATIVE_OF_POWER_SERIES','SK_INTERVAL_CONVERGENCE'],
  primary_skill_id = 'SK_POWER_SERIES_OPERATIONS',
  supporting_skill_ids = ARRAY['SK_DERIVATIVE_OF_POWER_SERIES'],
  error_tags = ARRAY['E_INDEX_SHIFT','E_ENDPOINT_NOT_CHECKED'],
  prompt = 'Given $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty}x^n\\quad (|x|<1),$$ find a power series for $$\\frac{1}{(1-x)^2}$$ and state its interval of convergence.',
  latex = 'Given $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty}x^n\\quad (|x|<1),$$ find a power series for $$\\frac{1}{(1-x)^2}$$ and state its interval of convergence.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\sum_{n=0}^{\\infty}x^n,\\ |x|<1$$','explanation','That series equals $\\frac{1}{1-x}$, not $\\frac{1}{(1-x)^2}$.'),
    jsonb_build_object('id','B','text','$$\\sum_{n=1}^{\\infty}n x^{n},\\ |x|<1$$','explanation','After differentiation, the exponent should be $n-1$, not $n$.'),
    jsonb_build_object('id','C','text','$$\\sum_{n=1}^{\\infty}n x^{n-1},\\ |x|<1$$','explanation','Correct: differentiate term-by-term; the interval remains $|x|<1$.'),
    jsonb_build_object('id','D','text','$$\\sum_{n=0}^{\\infty}(n+1)x^{n+1},\\ |x|\\le 1$$','explanation','The interval remains $|x|<1$; endpoints are not included.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate $$\\frac{1}{1-x}=\\sum_{n=0}^{\\infty}x^n$$ for $|x|<1$. The left side becomes $$\\frac{d}{dx}(1-x)^{-1}=(1-x)^{-2}.$$ The right side becomes $$\\sum_{n=1}^{\\infty}n x^{n-1}.$$ Differentiation preserves the radius, so the interval of convergence remains $|x|<1$.',
  recommendation_reasons = ARRAY['Builds the core BC skill of differentiating a power series.','Targets indexing and interval-of-convergence mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: operate on a power series and keep the same radius of convergence.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q15';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_NTH_TERM_TEST','SK_LIMITS_WITH_E'],
  primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_LIMITS_WITH_E'],
  error_tags = ARRAY['E_SKIP_TERM_TEST','E_CONFUSE_CONV_DIV'],
  prompt = 'Determine whether the series $$\\sum_{n=1}^{\\infty}\\left(\\frac{n}{n+1}\\right)^n$$ converges or diverges.',
  latex = 'Determine whether the series $$\\sum_{n=1}^{\\infty}\\left(\\frac{n}{n+1}\\right)^n$$ converges or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by the ratio test','explanation','The nth-term test applies first because the term limit is not $0$.'),
    jsonb_build_object('id','B','text','Diverges by the nth-term test','explanation','Correct: $\\left(\\frac{n}{n+1}\\right)^n=\\left(1+\\frac{1}{n}\\right)^{-n}\\to \\frac{1}{e}\\ne 0$.'),
    jsonb_build_object('id','C','text','Converges by comparison with $$\\sum \\frac{1}{n}$$','explanation','If terms do not approach $0$, no comparison can make the series converge.'),
    jsonb_build_object('id','D','text','Diverges because it is geometric','explanation','It is not geometric because the ratio changes with $n$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\\left(\\frac{n}{n+1}\\right)^n=\\left(\\frac{1}{1+1/n}\\right)^n$. Then $$\\lim_{n\\to\\infty}a_n=\\left(\\lim_{n\\to\\infty}\\left(1+\\frac{1}{n}\\right)^n\\right)^{-1}=\\frac{1}{e}\\ne 0.$$ Since $\\lim a_n\\ne 0$, the series diverges by the nth-term test.',
  recommendation_reasons = ARRAY['Reinforces the $e$-limit pattern in the nth-term test.','Targets the misconception that a base less than 1 always forces terms to 0.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test with a classic limit involving $e$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q16';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_INTEGRAL_TEST','SK_LOG_SUBSTITUTION'],
  primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_LOG_SUBSTITUTION'],
  error_tags = ARRAY['E_WRONG_SUBSTITUTION','E_CONFUSE_CONV_DIV'],
  prompt = 'Determine whether the series $$\\sum_{n=2}^{\\infty}\\frac{1}{n\\ln n}$$ converges or diverges.',
  latex = 'Determine whether the series $$\\sum_{n=2}^{\\infty}\\frac{1}{n\\ln n}$$ converges or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges by the integral test','explanation','The corresponding integral diverges because it becomes $\\int \\frac{1}{u}\\,du$.'),
    jsonb_build_object('id','B','text','Converges by comparison with $$\\sum \\frac{1}{n^2}$$','explanation','This comparison does not establish convergence; the terms are not bounded above by a constant multiple of $1/n^2$.'),
    jsonb_build_object('id','C','text','Diverges','explanation','Correct: $\\int_2^{\\infty}\\frac{1}{x\\ln x}\\,dx$ diverges.'),
    jsonb_build_object('id','D','text','Converges conditionally','explanation','The series is positive, so conditional convergence does not apply.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Apply the integral test with $f(x)=\\frac{1}{x\\ln x}$. Then $$\\int_2^{\\infty}\\frac{1}{x\\ln x}\\,dx.$$ Let $u=\\ln x$, $du=\\frac{1}{x}dx$, giving $$\\int_{\\ln 2}^{\\infty}\\frac{1}{u}\\,du=\\infty.$$ Therefore the series diverges.',
  recommendation_reasons = ARRAY['Builds recognition of the classic divergent boundary $\\sum 1/(n\\ln n)$.','Targets substitution errors and incorrect conclusions from the integral test.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: integral test divergence with $u=\\ln x$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q17';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_COMPARISON_TEST','SK_P_SERIES'],
  primary_skill_id = 'SK_COMPARISON_TEST',
  supporting_skill_ids = ARRAY['SK_P_SERIES'],
  error_tags = ARRAY['E_BOUNDED_TERM_CONFUSION','E_CONFUSE_CONV_DIV'],
  prompt = 'Determine whether the series $$\\sum_{n=1}^{\\infty}\\frac{1}{n^2+\\sin n}$$ converges or diverges.',
  latex = 'Determine whether the series $$\\sum_{n=1}^{\\infty}\\frac{1}{n^2+\\sin n}$$ converges or diverges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges because $\\sin n$ oscillates','explanation','$\\sin n$ is bounded, and $n^2$ dominates; oscillation does not force divergence here.'),
    jsonb_build_object('id','B','text','Converges by comparison with $$\\sum \\frac{1}{n^2}$$','explanation','Correct: for $n\\ge 2$, $\\frac{1}{n^2+\\sin n}\\le \\frac{2}{n^2}$.'),
    jsonb_build_object('id','C','text','Diverges by the nth-term test','explanation','Here $\\lim a_n=0$, so the nth-term test is inconclusive.'),
    jsonb_build_object('id','D','text','Inconclusive because the denominator is not monotone','explanation','Monotonicity is not required for comparison.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $-1\\le \\sin n\\le 1$, for $n\\ge 2$ we have $n^2+\\sin n\\ge n^2-1\\ge \\frac{1}{2}n^2$. Thus $$0<\\frac{1}{n^2+\\sin n}\\le \\frac{2}{n^2}.$$ Because $\\sum \\frac{2}{n^2}$ converges, the given series converges by comparison.',
  recommendation_reasons = ARRAY['Reinforces bounding with a bounded oscillatory term.','Targets the misconception that oscillation implies divergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: comparison using bounds on $\\sin n$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q18';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 145,
  skill_tags = ARRAY['SK_POWER_SERIES_FROM_GEOMETRIC','SK_POWER_SERIES_OPERATIONS'],
  primary_skill_id = 'SK_POWER_SERIES_FROM_GEOMETRIC',
  supporting_skill_ids = ARRAY['SK_POWER_SERIES_OPERATIONS'],
  error_tags = ARRAY['E_INDEX_SHIFT','E_TAYLOR_SIGN'],
  prompt = 'Find the Maclaurin series for $$\\frac{x^2}{1+x^2}.$$',
  latex = 'Find the Maclaurin series for $$\\frac{x^2}{1+x^2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$$\\sum_{n=0}^{\\infty}(-1)^n x^{2n}$$','explanation','That equals $\\frac{1}{1+x^2}$; it is missing the factor $x^2$.'),
    jsonb_build_object('id','B','text','$$\\sum_{n=0}^{\\infty}(-1)^n x^{2n+2}$$','explanation','Correct: $\\frac{1}{1+x^2}=\\sum (-1)^n x^{2n}$ for $|x|<1$, then multiply by $x^2$.'),
    jsonb_build_object('id','C','text','$$\\sum_{n=1}^{\\infty}(-1)^{n-1}x^{n}$$','explanation','Wrong power pattern; only even powers appear.'),
    jsonb_build_object('id','D','text','$$\\sum_{n=0}^{\\infty}x^{2n+2}$$','explanation','Missing the alternating sign from using $r=-x^2$ in the geometric series.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use $$\\frac{1}{1-r}=\\sum_{n=0}^{\\infty}r^n$$ for $|r|<1$. Here $$\\frac{1}{1+x^2}=\\frac{1}{1-(-x^2)}=\\sum_{n=0}^{\\infty}(-x^2)^n=\\sum_{n=0}^{\\infty}(-1)^n x^{2n},\\quad |x|<1.$$ Multiply by $x^2$: $$\\frac{x^2}{1+x^2}=\\sum_{n=0}^{\\infty}(-1)^n x^{2n+2},\\quad |x|<1.$$',
  recommendation_reasons = ARRAY['Builds power series by substitution into the geometric series.','Targets missing-factor and sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: geometric-series substitution with $r=-x^2$ and multiplication by $x^2$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q19';


UPDATE public.questions
SET
  course = 'BC',
  topic = 'BC_Series',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 175,
  skill_tags = ARRAY['SK_INTERVAL_CONVERGENCE','SK_RATIO_TEST','SK_ENDPOINT_TESTING'],
  primary_skill_id = 'SK_INTERVAL_CONVERGENCE',
  supporting_skill_ids = ARRAY['SK_RATIO_TEST'],
  error_tags = ARRAY['E_ENDPOINT_NOT_CHECKED','E_RATIO_TEST_INTERPRET'],
  prompt = 'Consider the power series $$\\sum_{n=1}^{\\infty}\\frac{(x-1)^n}{n^2}.$$ Which statement is true?',
  latex = 'Consider the power series $$\\sum_{n=1}^{\\infty}\\frac{(x-1)^n}{n^2}.$$ Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Radius of convergence is $R=0$','explanation','The ratio test gives a nonzero radius.'),
    jsonb_build_object('id','B','text','Radius of convergence is $R=1$, and the interval is $(0,2)$','explanation','Radius is $1$, but both endpoints converge and must be included.'),
    jsonb_build_object('id','C','text','Radius of convergence is $R=1$, and the interval is $[0,2]$','explanation','Correct: $x=0$ gives $\\sum (-1)^n/n^2$ and $x=2$ gives $\\sum 1/n^2$, both convergent.'),
    jsonb_build_object('id','D','text','Radius of convergence is $R=2$','explanation','Ratio test gives $|x-1|<1$, so $R=1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $a_n=\\frac{(x-1)^n}{n^2}$. Ratio test: $$\\left|\\frac{a_{n+1}}{a_n}\\right|=|x-1|\\cdot\\frac{n^2}{(n+1)^2}\\to |x-1|.$$ Thus convergence for $|x-1|<1$, giving radius $R=1$ and preliminary interval $(0,2)$. Check endpoints: at $x=0$, the series is $$\\sum \\frac{(-1)^n}{n^2}$$ which converges absolutely since $\\sum 1/n^2$ converges. At $x=2$, the series is $$\\sum \\frac{1}{n^2}$$ which converges. Therefore the interval of convergence is $[0,2]$.',
  recommendation_reasons = ARRAY['Integrates radius and endpoint testing in one BC-standard task.','Targets the common habit of excluding endpoints without checking.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: interval of convergence with both endpoints convergent via $p$-series.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.0-UT-Q20';

COMMIT;
