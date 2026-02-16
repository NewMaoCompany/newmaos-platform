-- Unit 10.3 (The nth-Term Test for Divergence) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.3',
  section_id = '10.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_NTH_TERM_TEST', 'SK_LIMITS'],
  error_tags = ARRAY['E_FORGET_NTH_TERM_NEQ0', 'E_NTH_TERM_INCONCLUSIVE_MISUSE'],
  prompt = 'Consider the infinite series $$\sum_{n=1}^{\infty} \frac{3n+1}{2n-5}.$$ Which statement is true?',
  latex = '$$\sum_{n=1}^{\infty} \frac{3n+1}{2n-5}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The series diverges because $\lim_{n\to\infty} \frac{3n+1}{2n-5} \neq 0$.','explanation','Correct: the terms approach $\frac{3}{2}$, not $0$, so the series diverges by the nth-term test.'),
    jsonb_build_object('id','B','text','The series converges because $\lim_{n\to\infty} \frac{3n+1}{2n-5}$ exists.','explanation','Existence of the limit alone does not imply convergence of the series.'),
    jsonb_build_object('id','C','text','The series converges by the ratio test.','explanation','Ratio test is not needed; the terms do not even go to $0$.'),
    jsonb_build_object('id','D','text','The series diverges because it is a $p$-series with $p=1$.','explanation','This is not a $p$-series.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute the term limit: $$\lim_{n\to\infty} \frac{3n+1}{2n-5} = \lim_{n\to\infty} \frac{3+\frac{1}{n}}{2-\frac{5}{n}} = \frac{3}{2}.$$ Since the terms do not approach $0$, the series diverges by the nth-term test.',
  recommendation_reasons = ARRAY['Checks basic use of the nth-term test.', 'Targets the common mistake: confusing ''limit exists'' with convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test (divergence by nonzero term limit).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_LIMITS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.3-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.3',
  section_id = '10.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_NTH_TERM_TEST', 'SK_LIMITS'],
  error_tags = ARRAY['E_NTH_TERM_INCONCLUSIVE_MISUSE', 'E_FORGET_NTH_TERM_NEQ0'],
  prompt = 'Let $$a_n = \frac{\sin n}{\sqrt{n}}$$ and consider $$\sum_{n=1}^{\infty} a_n.$$ Which statement is correct based only on the nth-term test?',
  latex = '$$a_n=\frac{\sin n}{\sqrt{n}},\quad \sum_{n=1}^{\infty} a_n$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The series diverges because $\sin n$ does not have a limit.','explanation','Even though $\sin n$ oscillates, the factor $1/\sqrt{n}$ forces $a_n\to 0$.'),
    jsonb_build_object('id','B','text','The series converges because $\sin n$ is bounded between $-1$ and $1$.','explanation','Boundedness does not imply the series converges.'),
    jsonb_build_object('id','C','text','The series converges because $\lim_{n\to\infty} a_n=0$.','explanation','Nth-term test cannot prove convergence; it can only prove divergence when the limit is not $0$ or does not exist.'),
    jsonb_build_object('id','D','text','The nth-term test is inconclusive because $\lim_{n\to\infty} a_n=0$.','explanation','Correct: since $a_n\to 0$, the nth-term test gives no conclusion about convergence.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Because $|\sin n|\le 1$, we have $$|a_n|=\frac{|\sin n|}{\sqrt{n}}\le \frac{1}{\sqrt{n}}\to 0.$$ Thus $\lim_{n\to\infty} a_n=0$. The nth-term test does not decide convergence in this case, so it is inconclusive.',
  recommendation_reasons = ARRAY['Separates ''terms go to 0'' from ''series converges''.', 'Common AP trap: misusing nth-term test to claim convergence.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test only; do not conclude convergence from limit 0.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_LIMITS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.3-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.3',
  section_id = '10.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_NTH_TERM_TEST', 'SK_LIMITS', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_FORGET_NTH_TERM_NEQ0', 'E_NTH_TERM_INCONCLUSIVE_MISUSE'],
  prompt = 'Consider the series $$\sum_{n=1}^{\infty} \left(\sqrt{n+1}-\sqrt{n}\right).$$ What can be concluded using the nth-term test?',
  latex = '$$\sum_{n=1}^{\infty} (\sqrt{n+1}-\sqrt{n})$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The series converges because $\sqrt{n+1}-\sqrt{n}\to 0$.','explanation','Limit $0$ does not guarantee convergence.'),
    jsonb_build_object('id','B','text','The nth-term test is inconclusive because $\sqrt{n+1}-\sqrt{n}\to 0$.','explanation','Correct: the term limit is $0$, so nth-term test cannot decide convergence.'),
    jsonb_build_object('id','C','text','The series diverges because $\sqrt{n+1}-\sqrt{n}\to \infty$.','explanation','The terms do not go to infinity; they go to $0$.'),
    jsonb_build_object('id','D','text','The series converges by the integral test.','explanation','Integral test is not part of the conclusion requested; nth-term test only.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute the term limit: $$\sqrt{n+1}-\sqrt{n}=\frac{(n+1)-n}{\sqrt{n+1}+\sqrt{n}}=\frac{1}{\sqrt{n+1}+\sqrt{n}}\to 0.$$ Since the limit is $0$, the nth-term test is inconclusive.',
  recommendation_reasons = ARRAY['Reinforces rationalizing to evaluate limits of terms.', 'Prevents false ''converges because terms go to 0'' reasoning.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test; key algebra step is rationalizing.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_LIMITS', 'SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.3-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.3',
  section_id = '10.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_NTH_TERM_TEST', 'SK_LIMITS'],
  error_tags = ARRAY['E_FORGET_NTH_TERM_NEQ0', 'E_NTH_TERM_INCONCLUSIVE_MISUSE'],
  prompt = 'Consider $$\sum_{n=1}^{\infty} \frac{n^2+5}{n^2-5n}.$$ What does the nth-term test imply?',
  latex = '$$\sum_{n=1}^{\infty} \frac{n^2+5}{n^2-5n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The nth-term test is inconclusive because the terms are rational functions.','explanation','Rational form does not make the test inconclusive; the limit matters.'),
    jsonb_build_object('id','B','text','The series converges because the degrees in numerator and denominator are equal.','explanation','Equal degrees implies the term limit is a nonzero constant, which would force divergence.'),
    jsonb_build_object('id','C','text','The series diverges because $\lim_{n\to\infty}\frac{n^2+5}{n^2-5n}=1\ne 0$.','explanation','Correct: term limit is 1, so series diverges by nth-term test.'),
    jsonb_build_object('id','D','text','The series converges because $\frac{n^2+5}{n^2-5n}<1$ for large $n$.','explanation','Even if terms are less than 1, they must go to 0 for possible convergence.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Evaluate the term limit: $$\lim_{n\to\infty}\frac{n^2+5}{n^2-5n}=\lim_{n\to\infty}\frac{1+\frac{5}{n^2}}{1-\frac{5}{n}}=1.$$ Since the term limit is not $0$, the series diverges by the nth-term test.',
  recommendation_reasons = ARRAY['Rapid identification of divergence via term limit.', 'Targets common confusion about rational expressions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test with rational-function terms.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
    primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_LIMITS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.3-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.3',
  section_id = '10.3',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_NTH_TERM_TEST', 'SK_LIMITS', 'SK_ALGEBRA_SIMPLIFY'],
  error_tags = ARRAY['E_FORGET_NTH_TERM_NEQ0', 'E_NTH_TERM_INCONCLUSIVE_MISUSE'],
  prompt = 'For the series $$\sum_{n=1}^{\infty} \frac{n!}{(n+2)!},$$ what can be concluded from the nth-term test?',
  latex = '$$\sum_{n=1}^{\infty} \frac{n!}{(n+2)!}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The series diverges because factorials grow too fast.','explanation','The term simplifies to a rational expression that actually goes to 0.'),
    jsonb_build_object('id','B','text','The nth-term test is inconclusive because $\lim_{n\to\infty}\frac{n!}{(n+2)!}=0$.','explanation','Correct: term limit is 0, so nth-term test cannot decide convergence.'),
    jsonb_build_object('id','C','text','The series converges because $\lim_{n\to\infty}\frac{n!}{(n+2)!}=0$.','explanation','Limit 0 does not prove convergence.'),
    jsonb_build_object('id','D','text','The series diverges because $\lim_{n\to\infty}\frac{n!}{(n+2)!}$ does not exist.','explanation','The limit exists and equals 0.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Simplify the term: $$(n+2)!=(n+2)(n+1)n!\Rightarrow \frac{n!}{(n+2)!}=\frac{1}{(n+1)(n+2)}.$$ Then $$\lim_{n\to\infty}\frac{1}{(n+1)(n+2)}=0.$$ Therefore, the nth-term test is inconclusive.',
  recommendation_reasons = ARRAY['Tests algebraic simplification before applying nth-term test.', 'Reinforces the precise conclusion the test allows.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: nth-term test; factorial simplification is the key step.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_NTH_TERM_TEST',
  supporting_skill_ids = ARRAY['SK_LIMITS', 'SK_ALGEBRA_SIMPLIFY'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.3-P5';



-- Unit 10.4 (Integral Test for Convergence) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.4',
  section_id = '10.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_INTEGRAL_TEST', 'SK_IMPROPER_INTEGRAL', 'SK_SUBSTITUTION'],
  error_tags = ARRAY['E_INTEGRAL_TEST_CONDITIONS_IGNORED', 'E_INTEGRAL_EVAL_MISTAKE'],
  prompt = 'Determine whether the series $$\sum_{n=2}^{\infty} \frac{1}{n(\ln n)^2}$$ converges or diverges. Use the integral test.',
  latex = '$$\sum_{n=2}^{\infty} \frac{1}{n(\ln n)^2}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges, because $\frac{1}{n(\ln n)^2}$ is larger than $\frac{1}{n^2}$ for large $n$.','explanation','That comparison is incorrect; also the prompt asks for integral test reasoning.'),
    jsonb_build_object('id','B','text','Diverges, because $\int_2^{\infty} \frac{1}{x(\ln x)^2}\,dx$ diverges.','explanation','The integral actually converges.'),
    jsonb_build_object('id','C','text','Converges, because $\int_2^{\infty} \frac{1}{x(\ln x)^2}\,dx$ converges.','explanation','Correct: the improper integral converges, so the series converges by the integral test.'),
    jsonb_build_object('id','D','text','Converges, because $\lim_{n\to\infty} \frac{1}{n(\ln n)^2}=0$.','explanation','Limit 0 is not sufficient to conclude convergence.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $f(x)=\frac{1}{x(\ln x)^2}$ for $x\ge 2$. It is positive, continuous, and decreasing for $x\ge 2$. Compute $$\int_2^{\infty}\frac{1}{x(\ln x)^2}\,dx.$$ Let $u=\ln x$, $du=\frac{1}{x}dx$: $$\int_{\ln 2}^{\infty}\frac{1}{u^2}\,du=\left[-\frac{1}{u}\right]_{\ln 2}^{\infty}=\frac{1}{\ln 2}.$$ Finite integral ⇒ series converges by the integral test.',
  recommendation_reasons = ARRAY['Classic BC integral-test example with $u=\ln x$.', 'Targets improper integral setup and evaluation accuracy.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Integral test with logarithmic substitution.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_IMPROPER_INTEGRAL', 'SK_SUBSTITUTION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.4-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.4',
  section_id = '10.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_INTEGRAL_TEST', 'SK_TEST_CONDITIONS'],
  error_tags = ARRAY['E_INTEGRAL_TEST_CONDITIONS_IGNORED'],
  prompt = 'A student wants to apply the integral test to $$\sum_{n=1}^{\infty} \frac{1}{n+(-1)^n}.$$ Which is the best reason the integral test is not appropriate?',
  latex = '$$\sum_{n=1}^{\infty} \frac{1}{n+(-1)^n}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The terms are not defined by a function $f(x)$ that is positive for all sufficiently large $x$.','explanation','Correct: the expression depends on parity and has a zero denominator at $n=1$, preventing a suitable positive continuous model on an interval.'),
    jsonb_build_object('id','B','text','The limit of the terms is not zero.','explanation','In fact the terms go to 0; that is not the issue.'),
    jsonb_build_object('id','C','text','The integral of any rational function must diverge.','explanation','False statement.'),
    jsonb_build_object('id','D','text','Because the series is alternating, the integral test cannot be used.','explanation','Alternating behavior alone is not the formal obstruction; the issue is failure to meet continuity/positivity requirements.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'To use the integral test, we need a continuous, positive, decreasing function $f(x)$ on $[N,\infty)$ with $f(n)=a_n$. Here $a_n=\frac{1}{n+(-1)^n}$ cannot be naturally extended to a single continuous positive function on an interval: at $n=1$ the denominator is $0$, and the expression depends on parity, undermining a standard continuous model required for the test.',
  recommendation_reasons = ARRAY['Emphasizes integral test hypotheses (positive/continuous/decreasing).', 'Common error: applying integral test to parity-defined terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Integral test conditions check (positivity/continuity).',
  weight_primary = 0.75,
  weight_supporting = 0.25,
    primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_TEST_CONDITIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.4-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.4',
  section_id = '10.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_INTEGRAL_TEST', 'SK_IMPROPER_INTEGRAL', 'SK_SUBSTITUTION'],
  error_tags = ARRAY['E_INTEGRAL_EVAL_MISTAKE', 'E_INTEGRAL_TEST_CONDITIONS_IGNORED'],
  prompt = 'Use the integral test to determine whether $$\sum_{n=1}^{\infty} \frac{1}{\sqrt{n}(1+n)}$$ converges or diverges.',
  latex = '$$\sum_{n=1}^{\infty} \frac{1}{\sqrt{n}(1+n)}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Diverges, because $\int_1^{\infty} \frac{1}{\sqrt{x}(1+x)}\,dx$ diverges.','explanation','The improper integral actually converges.'),
    jsonb_build_object('id','B','text','Converges, because $\int_1^{\infty} \frac{1}{\sqrt{x}(1+x)}\,dx$ converges.','explanation','Correct: integral converges, so series converges by the integral test.'),
    jsonb_build_object('id','C','text','Diverges, because $\frac{1}{\sqrt{n}(1+n)} > \frac{1}{n}$ for large $n$.','explanation','Inequality is false for large $n$.'),
    jsonb_build_object('id','D','text','Converges, because it is a geometric series.','explanation','Not geometric.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $f(x)=\frac{1}{\sqrt{x}(1+x)}$ for $x\ge 1$ (positive, continuous, decreasing). Evaluate $$\int_1^{\infty}\frac{1}{\sqrt{x}(1+x)}\,dx.$$ Let $x=t^2$, $dx=2t\,dt$, $\sqrt{x}=t$: $$\int_1^{\infty}\frac{1}{t(1+t^2)}\cdot 2t\,dt=\int_1^{\infty}\frac{2}{1+t^2}\,dt=\left[2\arctan t\right]_1^{\infty}=\frac{\pi}{2}.$$ Finite integral ⇒ series converges by the integral test.',
  recommendation_reasons = ARRAY['Integral test with a strategic substitution ($x=t^2$).', 'Targets evaluation of improper integrals accurately.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Integral test with $x=t^2$ substitution; classic arctan result.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
    primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_IMPROPER_INTEGRAL', 'SK_SUBSTITUTION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.4-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.4',
  section_id = '10.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_INTEGRAL_TEST', 'SK_TEST_CONDITIONS'],
  error_tags = ARRAY['E_INTEGRAL_TEST_CONDITIONS_IGNORED'],
  prompt = 'Which series is the best candidate for the integral test (i.e., its terms come from a function that is positive, continuous, and decreasing for $x\ge 1$)?',
  latex = 'Integral test candidate selection',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \sum_{n=1}^{\infty} \frac{1}{n^2+1}$','explanation','Correct: $f(x)=\frac{1}{x^2+1}$ is positive, continuous, and decreasing for $x\ge 1$.'),
    jsonb_build_object('id','B','text','$\displaystyle \sum_{n=1}^{\infty} \frac{(-1)^n}{n}$','explanation','Not positive; integral test requires a positive function.'),
    jsonb_build_object('id','C','text','$\displaystyle \sum_{n=1}^{\infty} \sin n$','explanation','Not positive and not modeled by a decreasing positive function.'),
    jsonb_build_object('id','D','text','$\displaystyle \sum_{n=1}^{\infty} \frac{1}{1+\sin n}$','explanation','Not monotone and not well-modeled by a decreasing continuous function on an interval.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The integral test requires $a_n=f(n)$ where $f$ is positive, continuous, and decreasing on $[1,\infty)$. Among the options, $f(x)=\frac{1}{x^2+1}$ satisfies all conditions for $x\ge 1$.',
  recommendation_reasons = ARRAY['Quick diagnostic: recognizing when integral test hypotheses apply.', 'Targets the frequent mistake of ignoring positivity/monotonicity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Integral test applicability (hypotheses).',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_TEST_CONDITIONS'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.4-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.4',
  section_id = '10.4',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_INTEGRAL_TEST', 'SK_IMPROPER_INTEGRAL', 'SK_SUBSTITUTION'],
  error_tags = ARRAY['E_INTEGRAL_EVAL_MISTAKE', 'E_INTEGRAL_TEST_CONDITIONS_IGNORED'],
  prompt = 'Use the integral test to determine whether $$\sum_{n=3}^{\infty} \frac{1}{n\ln n\,\ln(\ln n)}$$ converges or diverges.',
  latex = '$$\sum_{n=3}^{\infty} \frac{1}{n\ln n\,\ln(\ln n)}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Converges, because the terms go to $0$.','explanation','Limit 0 is not sufficient.'),
    jsonb_build_object('id','B','text','Converges, because $\int_3^{\infty} \frac{1}{x\ln x\,\ln(\ln x)}\,dx$ converges.','explanation','That integral diverges (log-log growth is too slow).'),
    jsonb_build_object('id','C','text','Diverges, because $\int_3^{\infty} \frac{1}{x\ln x\,\ln(\ln x)}\,dx$ diverges.','explanation','Correct: the improper integral diverges, so the series diverges by the integral test.'),
    jsonb_build_object('id','D','text','Diverges by the nth-term test because the limit does not exist.','explanation','The term limit is 0 and exists; nth-term test is inconclusive.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Let $f(x)=\frac{1}{x\ln x\,\ln(\ln x)}$ for $x\ge 3$ (positive, continuous, decreasing). Evaluate $$\int_3^{\infty}\frac{1}{x\ln x\,\ln(\ln x)}\,dx.$$ Let $u=\ln x$, $du=\frac{1}{x}dx$: $$\int_{\ln 3}^{\infty}\frac{1}{u\ln u}\,du.$$ Let $v=\ln u$, $dv=\frac{1}{u}du$: $$\int_{\ln(\ln 3)}^{\infty}\frac{1}{v}\,dv,$$ which diverges. Therefore the original integral diverges, and the series diverges by the integral test.',
  recommendation_reasons = ARRAY['High-value BC-style integral-test example with nested logs.', 'Targets multi-substitution improper integral reasoning.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Integral test with nested substitutions; classic divergence.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_INTEGRAL_TEST',
  supporting_skill_ids = ARRAY['SK_IMPROPER_INTEGRAL', 'SK_SUBSTITUTION'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.4-P5';

COMMIT;
