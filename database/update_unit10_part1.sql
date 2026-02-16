-- Unit 10.1 (Defining Convergent and Divergent Infinite Series) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_LINEARIZATION', 'SK_TANGENT_LINE'],
  primary_skill_id = 'SK_LINEARIZATION',
  supporting_skill_ids = ARRAY['SK_TANGENT_LINE'],
  error_tags = ARRAY['E_WRONG_POINT', 'E_ALGEBRA', 'E_ARITHMETIC'],
  prompt = 'Use linearization to approximate $\\sqrt{4.1}$.',
  latex = 'Use linearization to approximate $\\sqrt{4.1}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.025$','explanation','Correct: $f(x)=\\sqrt{x}$, $f(4)=2$, $f''(4)=\\frac{1}{4}$, so $L(4.1)=2+\\frac{1}{4}(0.1)=2.025$.'),
    jsonb_build_object('id','B','text','$2.05$','explanation','Uses slope $\\frac{1}{2}$ instead of $\\frac{1}{4}$.'),
    jsonb_build_object('id','C','text','$2.0025$','explanation','Treats $4.1-4$ as $0.01$ instead of $0.1$.'),
    jsonb_build_object('id','D','text','$1.975$','explanation','Sign error in $(x-4)$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Let $f(x)=\\sqrt{x}$. Linearize at $a=4$:
$$L(x)=f(4)+f''(4)(x-4)=2+\\frac{1}{4}(x-4).$$
Then
$$\\sqrt{4.1}\\approx L(4.1)=2+\\frac{1}{4}(0.1)=2.025.$$',
  recommendation_reasons = ARRAY['Direct AP skill: build a tangent-line approximation near a convenient point.', 'Targets common slope and sign mistakes in $L(x)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Choose $a$ with easy exact values (like $4$ for square roots).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_DIFFERENTIALS', 'SK_LINEARIZATION'],
  primary_skill_id = 'SK_DIFFERENTIALS',
  supporting_skill_ids = ARRAY['SK_LINEARIZATION'],
  error_tags = ARRAY['E_SIGN', 'E_ARITHMETIC', 'E_INTERPRETATION'],
  prompt = 'Let $f(x)=x^3$. Use differentials to estimate the change in $f$ when $x$ changes from $2$ to $2.02$.',
  latex = 'Let $f(x)=x^3$. Use differentials to estimate the change in $f$ when $x$ changes from $2$ to $2.02$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.12$','explanation','Uses $f''(2)=6$ instead of $12$.'),
    jsonb_build_object('id','B','text','$0.24$','explanation','Correct: $df\\approx f''(2)\\,dx=12(0.02)=0.24$.'),
    jsonb_build_object('id','C','text','$0.08$','explanation','Uses $dx=0.01$ instead of $0.02$.'),
    jsonb_build_object('id','D','text','$0.48$','explanation','Overcounts by doubling $dx$ or doubling the derivative.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use $df\\approx f''(a)\\,dx$ with $a=2$.
Since $f''(x)=3x^2$, we have $f''(2)=12$ and $dx=2.02-2=0.02$.
Thus
$$df\\approx 12(0.02)=0.24.$$',
  recommendation_reasons = ARRAY['Differentials vs exact change is a frequent AP concept check.', 'Reinforces correct identification of $dx$ and evaluation point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'This is an estimate of $\\Delta f$, not an exact value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_NEWTON_METHOD', 'SK_TANGENT_LINE'],
  primary_skill_id = 'SK_NEWTON_METHOD',
  supporting_skill_ids = ARRAY['SK_TANGENT_LINE'],
  error_tags = ARRAY['E_FORMULA', 'E_ARITHMETIC', 'E_SIGN'],
  prompt = 'Use one Newton''s method iteration to approximate a root of $f(x)=x^2-5$ starting from $x_0=2$.',
  latex = 'Use one Newton''s method iteration to approximate a root of $f(x)=x^2-5$ starting from $x_0=2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.25$','explanation','Correct: $x_1=2-\\frac{f(2)}{f''(2)}=2-\\frac{-1}{4}=2.25$.'),
    jsonb_build_object('id','B','text','$1.75$','explanation','Sign error in the Newton update.'),
    jsonb_build_object('id','C','text','$2.20$','explanation','Arithmetic slip with $\\frac{1}{4}$ or wrong derivative value.'),
    jsonb_build_object('id','D','text','$2.50$','explanation','Uses $f''(2)=2$ instead of $4$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute $f(2)=2^2-5=-1$ and $f''(x)=2x$ so $f''(2)=4$.
Newton update:
$$x_1=2-\\frac{-1}{4}=2.25.$$',
  recommendation_reasons = ARRAY['Tests the Newton update formula and tangent-line interpretation.', 'Targets sign handling when $f(x_0)$ is negative.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'One iteration only (do not continue).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_LINEARIZATION_ERROR', 'SK_SECOND_DERIVATIVE_BOUND'],
  primary_skill_id = 'SK_LINEARIZATION_ERROR',
  supporting_skill_ids = ARRAY['SK_SECOND_DERIVATIVE_BOUND'],
  error_tags = ARRAY['E_WRONG_FORMULA', 'E_WRONG_INTERVAL', 'E_ARITHMETIC'],
  prompt = 'Let $f(x)=\\ln x$. Use the linearization at $a=1$ to approximate $\\ln(1.1)$. Using the bound $|R(x)|\\le \\frac{M}{2}(x-a)^2$, where $M$ is a maximum of $|f''''(x)|$ on the interval between $a$ and $x$, what is an upper bound on the absolute error?',
  latex = 'Let $f(x)=\\ln x$. Use the linearization at $a=1$ to approximate $\\ln(1.1)$. Using the bound $|R(x)|\\le \\frac{M}{2}(x-a)^2$, where $M$ is a maximum of $|f''''(x)|$ on the interval between $a$ and $x$, what is an upper bound on the absolute error?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{1}{100}$','explanation','Forgets the factor $\\frac{1}{2}$ in the bound.'),
    jsonb_build_object('id','B','text','$\\frac{1}{200}$','explanation','Correct: on $[1,1.1]$, $|f''''(x)|=\\frac{1}{x^2}\\le 1$, so $|R|\\le \\frac{1}{2}(0.1)^2=\\frac{1}{200}$.'),
    jsonb_build_object('id','C','text','$\\frac{1}{400}$','explanation','Uses $M=\\frac{1}{(1.1)^2}$ (not the maximum) and still includes $\\frac{1}{2}(0.1)^2$.'),
    jsonb_build_object('id','D','text','$\\frac{1}{220}$','explanation','Uses a non-maximum bound value and/or mis-squares $0.1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Here $f''''(x)=-\\frac{1}{x^2}$, so $|f''''(x)|=\\frac{1}{x^2}$. On $[1,1.1]$, the maximum occurs at $x=1$, so $M=1$.
Thus
$$|R(1.1)|\\le \\frac{1}{2}(1.1-1)^2=\\frac{1}{2}(0.1)^2=0.005=\\frac{1}{200}.$$',
  recommendation_reasons = ARRAY['AP-style error bound for linearization; emphasizes selecting $M$ on the correct interval.', 'Targets max-vs-min confusion for $|f''''|$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use the maximum of $|f''''(x)|$ between $a$ and $x$ (here it is at $x=1$).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Derivatives',
  sub_topic_id = '10.1',
  section_id = '10.1',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_NEWTON_METHOD', 'SK_FUNCTION_SIGN'],
  primary_skill_id = 'SK_NEWTON_METHOD',
  supporting_skill_ids = ARRAY['SK_FUNCTION_SIGN'],
  error_tags = ARRAY['E_SIGN', 'E_INTERPRETATION', 'E_FORMULA'],
  prompt = 'Consider $f(x)=x^3-2x-2$ (see graph). Starting at $x_0=2$, the Newton iterate is $x_1=x_0-\\frac{f(x_0)}{f''(x_0)}$. Which statement is true?',
  latex = 'Consider $f(x)=x^3-2x-2$. Starting at $x_0=2$, the Newton iterate is $x_1=x_0-\\frac{f(x_0)}{f''(x_0)}$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x_1<2$ because $f(2)<0$.','explanation','Incorrect: $f(2)=8-4-2=2>0$.'),
    jsonb_build_object('id','B','text','$x_1>2$ because $f(2)>0$ and $f''''(2)>0$.','explanation','If $f(2)>0$ and $f''''(2)>0$, then $x_1=2-\\frac{f(2)}{f''''(2)}<2$, not $>2$.'),
    jsonb_build_object('id','C','text','$x_1<2$ because $f(2)>0$ and $f''''(2)>0$.','explanation','Correct: $f(2)=2>0$ and $f''''(2)=3(2^2)-2=10>0$, so $x_1=2-\\frac{2}{10}=1.8<2$.'),
    jsonb_build_object('id','D','text','$x_1=2$ because Newton''s method always stays at the initial guess for cubic functions.','explanation','False: Newton''s method moves unless $f(x_0)=0$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'At $x_0=2$, $f(2)=2>0$ and $f''''(2)=3(2^2)-2=10>0$.
Newton update subtracts a positive amount:
$$x_1=2-\\frac{2}{10}=1.8<2.$$',
  recommendation_reasons = ARRAY['Checks sign-based interpretation of the Newton update (AP conceptual style).', 'Distinguishes direction of the iterate with minimal computation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Direction depends on the sign of $\\frac{f(x_0)}{f''''(x_0)}$. Image file: 10.1-P5.png',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Derivatives',
  updated_at = NOW()
WHERE title = '10.1-P5';



-- Unit 10.2 (Working with Geometric Series) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_GEOM_CONVERGENCE_CONDITION','SK_GEOM_IDENTIFY_RATIO'],
  primary_skill_id = 'SK_GEOM_CONVERGENCE_CONDITION',
  supporting_skill_ids = ARRAY['SK_GEOM_IDENTIFY_RATIO'],
  error_tags = ARRAY['E_GEOM_RATIO_WRONG','E_GEOM_CONVERGENCE_MISAPPLY'],
  prompt = 'Consider the series $\sum_{n=0}^{\infty} 6\left(-\frac{1}{3}\right)^n$. Which statement is true?',
  latex = 'This is geometric with ratio $r=-\frac{1}{3}$. A geometric series converges when $|r|<1$, so it converges.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','It converges because $\left|-\frac{1}{3}\right|<1$.','explanation','Correct: $|r|<1$ guarantees convergence for a geometric series.'),
    jsonb_build_object('id','B','text','It diverges because the terms alternate in sign.','explanation','Alternating signs do not prevent convergence for geometric series.'),
    jsonb_build_object('id','C','text','It diverges because $r$ is negative.','explanation','Negative ratio is allowed; magnitude controls convergence.'),
    jsonb_build_object('id','D','text','It converges only if $r>0$.','explanation','There is no requirement that $r$ be positive.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The series is geometric with ratio $r=-\frac{1}{3}$. Since $|r|<1$, the series converges.',
  recommendation_reasons = ARRAY['Checks the core convergence criterion for geometric series.','Targets sign-based misconceptions about ratios.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Convergence depends on $|r|$, not the sign of $r$.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_GEOM_CONVERGENCE_CONDITION',
  supporting_skill_ids = ARRAY['SK_GEOM_IDENTIFY_RATIO'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_GEOM_SUM_INFINITE','SK_GEOM_IDENTIFY_A_AND_R'],
  primary_skill_id = 'SK_GEOM_SUM_INFINITE',
  supporting_skill_ids = ARRAY['SK_GEOM_IDENTIFY_A_AND_R'],
  error_tags = ARRAY['E_GEOM_SUM_FORMULA_MISUSE','E_GEOM_RATIO_WRONG'],
  prompt = 'Find the sum of the infinite geometric series $$5-\frac{5}{2}+\frac{5}{4}-\frac{5}{8}+\cdots.$$',
  latex = 'First term $a=5$, ratio $r=-\frac{1}{2}$. Since $|r|<1$, the sum is $S=\frac{a}{1-r}=\frac{5}{1-(-1/2)}=\frac{10}{3}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{5}{3}$','explanation','Often comes from using $1+r$ instead of $1-r$ in the denominator.'),
    jsonb_build_object('id','B','text','$\frac{10}{3}$','explanation','Correct: $S=\frac{5}{1-(-1/2)}=\frac{10}{3}$.'),
    jsonb_build_object('id','C','text','$\frac{15}{2}$','explanation','This can result from summing only the first few terms, not the infinite sum.'),
    jsonb_build_object('id','D','text','$\frac{10}{7}$','explanation','Uses an incorrect formula such as $1-r^2$ in the denominator.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Identify $a=5$ and $r=-\frac{1}{2}$. The infinite geometric sum is $S=\frac{a}{1-r}=\frac{10}{3}$.',
  recommendation_reasons = ARRAY['Practices identifying $a$ and $r$ from a written series.','Reinforces the infinite geometric sum formula with negative ratio.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Denominator is $1-r$ even when $r<0$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_GEOM_SUM_INFINITE',
  supporting_skill_ids = ARRAY['SK_GEOM_IDENTIFY_A_AND_R'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_REPEAT_DECIMAL_GEOM_MODEL','SK_GEOM_SUM_INFINITE'],
  primary_skill_id = 'SK_REPEAT_DECIMAL_GEOM_MODEL',
  supporting_skill_ids = ARRAY['SK_GEOM_SUM_INFINITE'],
  error_tags = ARRAY['E_PLACE_VALUE_ERROR','E_GEOM_SUM_FORMULA_MISUSE'],
  prompt = 'Write $0.\overline{27}$ as a fraction by interpreting it as a geometric series.',
  latex = '0.\overline{27}=\frac{27}{100}+\frac{27}{100^2}+\frac{27}{100^3}+\cdots$ is geometric with $a=\frac{27}{100}$ and $r=\frac{1}{100}$. Sum $S=\frac{a}{1-r}=\frac{27/100}{1-1/100}=\frac{27}{99}=\frac{3}{11}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{27}{100}$','explanation','This is only the first term; it does not include the repeating tail.'),
    jsonb_build_object('id','B','text','$\frac{27}{99}$','explanation','This is correct but not simplified; it reduces to $\frac{3}{11}$.'),
    jsonb_build_object('id','C','text','$\frac{3}{11}$','explanation','Correct simplified fraction.'),
    jsonb_build_object('id','D','text','$\frac{27}{11}$','explanation','Places the decimal incorrectly, making the value too large.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Model the repeating decimal as a geometric series with first term $\frac{27}{100}$ and ratio $\frac{1}{100}$. The sum is $\frac{27}{99}=\frac{3}{11}$.',
  recommendation_reasons = ARRAY['Connects geometric series to a classic application (repeating decimals).','Targets common place-value and ratio mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Be explicit about first term $\frac{27}{100}$ and ratio $\frac{1}{100}$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_REPEAT_DECIMAL_GEOM_MODEL',
  supporting_skill_ids = ARRAY['SK_GEOM_SUM_INFINITE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_GEOM_SOLVE_FOR_RATIO','SK_GEOM_SUM_INFINITE'],
  primary_skill_id = 'SK_GEOM_SOLVE_FOR_RATIO',
  supporting_skill_ids = ARRAY['SK_GEOM_SUM_INFINITE'],
  error_tags = ARRAY['E_GEOM_CONVERGENCE_MISAPPLY','E_ALGEBRA_SETUP_ERROR'],
  prompt = 'An infinite geometric series has first term $a$ and ratio $r$. Its sum is $12$, and its second term is $6$. What is $r$?',
  latex = 'Sum: $\frac{a}{1-r}=12$ so $a=12(1-r)$. Second term: $ar=6$. Then $12(1-r)r=6 \Rightarrow 12(r-r^2)=6 \Rightarrow 2r^2-2r+1=0 \Rightarrow (r-\frac{1}{2})^2=0$, so $r=\frac{1}{2}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{2}$','explanation','Correct: it satisfies both the sum and the second-term condition, and $|r|<1$.'),
    jsonb_build_object('id','B','text','$2$','explanation','If $r=2$, the series cannot converge because $|r|<1$ is required.'),
    jsonb_build_object('id','C','text','$-\frac{1}{2}$','explanation','With $a=12(1-r)$, this would not produce a positive second term of $6$.'),
    jsonb_build_object('id','D','text','$\frac{3}{2}$','explanation','Fails convergence since $|r|>1$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use $S=\frac{a}{1-r}=12$ so $a=12(1-r)$. The second term is $ar=6$. Solving $12(1-r)r=6$ gives $r=\frac{1}{2}$.',
  recommendation_reasons = ARRAY['Combines parameter identification with the infinite sum formula.','Reinforces that an infinite geometric sum requires $|r|<1$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Set up equations from “sum” and “second term”; enforce $|r|<1$.',
  weight_primary = 0.50,
  weight_supporting = 0.50,
    primary_skill_id = 'SK_GEOM_SOLVE_FOR_RATIO',
  supporting_skill_ids = ARRAY['SK_GEOM_SUM_INFINITE'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.2',
  section_id = '10.2',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_GEOM_SIGMA_NOTATION','SK_GEOM_IDENTIFY_RATIO','SK_GEOM_IDENTIFY_FIRST_TERM'],
  primary_skill_id = 'SK_GEOM_SIGMA_NOTATION',
  supporting_skill_ids = ARRAY['SK_GEOM_IDENTIFY_RATIO', 'SK_GEOM_IDENTIFY_FIRST_TERM'],
  error_tags = ARRAY['E_INDEX_SHIFT','E_GEOM_RATIO_WRONG'],
  prompt = 'Which sigma notation represents the geometric series $$\frac{3}{4}+\frac{3}{10}+\frac{3}{25}+\frac{3}{62.5}+\cdots\ ?$$',
  latex = 'Compute the common ratio: $\frac{(3/10)}{(3/4)}=\frac{2}{5}$ and $\frac{(3/25)}{(3/10)}=\frac{2}{5}$. So $a=\frac{3}{4}$ and $r=\frac{2}{5}$. A matching sigma form is $\sum_{n=0}^{\infty} \frac{3}{4}\left(\frac{2}{5}\right)^n$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\displaystyle \sum_{n=1}^{\infty} \frac{3}{4}\left(\frac{2}{5}\right)^n$','explanation','Starts at $n=1$, so the first term becomes $\frac{3}{4}\cdot\frac{2}{5}$, which is too small.'),
    jsonb_build_object('id','B','text','$\displaystyle \sum_{n=0}^{\infty} \frac{3}{4}\left(\frac{5}{2}\right)^n$','explanation','Uses the reciprocal ratio $\frac{5}{2}$, which makes terms grow.'),
    jsonb_build_object('id','C','text','$\displaystyle \sum_{n=0}^{\infty} \frac{3}{4}\left(\frac{2}{5}\right)^n$','explanation','Correct: matches the first term when $n=0$ and uses ratio $\frac{2}{5}$.'),
    jsonb_build_object('id','D','text','$\displaystyle \sum_{n=1}^{\infty} \frac{3}{4}\left(\frac{5}{2}\right)^{n-1}$','explanation','Uses the wrong ratio $\frac{5}{2}$; also produces increasing terms.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The common ratio is $r=\frac{2}{5}$ and the first term is $\frac{3}{4}$. Using $n=0$ gives the first term directly, so $\sum_{n=0}^{\infty} \frac{3}{4}\left(\frac{2}{5}\right)^n$ matches the series.',
  recommendation_reasons = ARRAY['Tests precise control of indexing ($n=0$ vs $n=1$) in sigma form.','Reinforces identifying ratio from consecutive terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Primary trap: indexing. Using $n=0$ matches the first term cleanly.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_GEOM_SIGMA_NOTATION',
  supporting_skill_ids = ARRAY['SK_GEOM_IDENTIFY_RATIO', 'SK_GEOM_IDENTIFY_FIRST_TERM'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.2-P5';

COMMIT;
