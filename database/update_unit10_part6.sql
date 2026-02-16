-- PREVENT FK ERROR: ensure topic_id exists in public.topic_content
-- If your topic_content table uses a different primary key column name, change (id) accordingly.
INSERT INTO public.topic_content (id, title)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO NOTHING;

-- Unit 10.11 (Finding Taylor Polynomial Approximations of Functions) — Practice 1–5

BEGIN;

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.11',
  section_id = '10.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_TAYLOR_POLY_BUILD','SK_DERIV_EVAL'],
  error_tags = ARRAY['ET_FORGET_FACTORIAL','ET_EVAL_POINT_WRONG'],
  prompt = 'Let $f(x)=\\ln x$. What is the third-degree Taylor polynomial for $f(x)$ about $x=1$?',
  latex = 'Let $f(x)=\\ln x$. What is the third-degree Taylor polynomial for $f(x)$ about $x=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$T_3(x)=(x-1)-\\dfrac{(x-1)^2}{2}+\\dfrac{(x-1)^3}{3}$','explanation','At $x=1$: $f(1)=0$, $f^{\\prime}(1)=1$, $f^{\\prime\\prime}(1)=-1$, $f^{(3)}(1)=2$. So $T_3(x)=0+1(x-1)+\\dfrac{-1}{2!}(x-1)^2+\\dfrac{2}{3!}(x-1)^3=(x-1)-\\dfrac{(x-1)^2}{2}+\\dfrac{(x-1)^3}{3}$.'),
    jsonb_build_object('id','B','text','$T_3(x)=1+(x-1)-\\dfrac{(x-1)^2}{2}+\\dfrac{(x-1)^3}{3}$','explanation','Incorrect constant term: $\\ln(1)=0$, not $1$.'),
    jsonb_build_object('id','C','text','$T_3(x)=(x-1)+\\dfrac{(x-1)^2}{2}+\\dfrac{(x-1)^3}{3}$','explanation','Sign error: $f^{\\prime\\prime}(1)=-1$, so the quadratic term must be negative.'),
    jsonb_build_object('id','D','text','$T_3(x)=(x-1)-\\dfrac{(x-1)^2}{2}+\\dfrac{(x-1)^3}{6}$','explanation','Factorial error: the cubic coefficient is $\\dfrac{f^{(3)}(1)}{3!}=\\dfrac{2}{6}=\\dfrac{1}{3}$, not $\\dfrac{1}{6}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use $T_3(x)=\\sum_{k=0}^3 \\dfrac{f^{(k)}(1)}{k!}(x-1)^k$. For $f(x)=\\ln x$: $f(1)=0$, $f^{\\prime}(1)=1$, $f^{\\prime\\prime}(1)=-1$, $f^{(3)}(1)=2$. Thus\n$$T_3(x)=(x-1)-\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{3}.$$',
  recommendation_reasons = ARRAY['Reinforces building a Taylor polynomial from derivatives at a center.','Targets common sign and factorial coefficient mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Center at $x=1$. Ensure factorials and signs are applied correctly.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_TAYLOR_POLY_BUILD',
  supporting_skill_ids = ARRAY['SK_DERIV_EVAL'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.11-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.11',
  section_id = '10.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_TAYLOR_APPROX_VALUE','SK_TAYLOR_POLY_BUILD'],
  error_tags = ARRAY['ET_SHIFT_MISUSE','ET_FORGET_FACTORIAL'],
  prompt = 'Use the second-degree Taylor polynomial for $f(x)=\\sqrt{x}$ about $x=4$ to approximate $\\sqrt{4.1}$.',
  latex = 'Use the second-degree Taylor polynomial for $f(x)=\\sqrt{x}$ about $x=4$ to approximate $\\sqrt{4.1}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2.0125$','explanation','This value typically comes from mishandling the quadratic correction or centering at the wrong value.'),
    jsonb_build_object('id','B','text','$2.000625$','explanation','This treats $\\sqrt{4.1}$ as if it were near $1$ rather than near $2$ (wrong shift/center).'),
    jsonb_build_object('id','C','text','$2.024375$','explanation','Close, but it comes from an arithmetic slip in the quadratic term; the correction should be $-(0.01)/64=0.00015625$.'),
    jsonb_build_object('id','D','text','$2.02484375$','explanation','$f(4)=2$, $f^{\\prime}(4)=\\dfrac{1}{4}$, $f^{\\prime\\prime}(4)=-\\dfrac{1}{32}$, $h=0.1$: $T_2(4.1)=2+\\dfrac{1}{4}(0.1)+\\dfrac{-1/32}{2}(0.1)^2=2.02484375$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'At $a=4$, $f(4)=2$, $f^{\\prime}(4)=\\dfrac{1}{4}$, $f^{\\prime\\prime}(4)=-\\dfrac{1}{32}$. With $h=0.1$,\n$$T_2(4.1)=2+\\frac{1}{4}(0.1)+\\frac{-1/32}{2}(0.1)^2=2+0.025-0.00015625=2.02484375.$$',
  recommendation_reasons = ARRAY['Practices Taylor approximation about a nonzero center.','Reinforces correct use of $h=x-a$ and the $\\dfrac{f^{\\prime\\prime}(a)}{2}$ term.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use $h=0.1$ explicitly; the quadratic correction is small but important.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_TAYLOR_APPROX_VALUE',
  supporting_skill_ids = ARRAY['SK_TAYLOR_POLY_BUILD'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.11-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.11',
  section_id = '10.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_MACLAURIN_COEFF','SK_SERIES_ALGEBRA'],
  error_tags = ARRAY['ET_SIGN_PATTERN_ERROR','ET_FORGET_FACTORIAL'],
  prompt = 'The Maclaurin series for $\\sin x$ begins $\\sin x=x-\\dfrac{x^3}{3!}+\\dfrac{x^5}{5!}-\\cdots$. What is the coefficient of $x^5$?',
  latex = 'The Maclaurin series for $\\sin x$ begins $\\sin x=x-\\dfrac{x^3}{3!}+\\dfrac{x^5}{5!}-\\cdots$. What is the coefficient of $x^5$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{1}{120}$','explanation','From the standard expansion, the $x^5$ term is $\\dfrac{x^5}{5!}$, so the coefficient is $\\dfrac{1}{120}$.'),
    jsonb_build_object('id','B','text','$-\\dfrac{1}{120}$','explanation','Sign error: the $x^5$ term in $\\sin x$ is positive.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{24}$','explanation','Factorial error: this uses $4!$ instead of $5!$.'),
    jsonb_build_object('id','D','text','$-\\dfrac{1}{24}$','explanation','Wrong sign and wrong factorial.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'From $\\sin x=x-\\dfrac{x^3}{3!}+\\dfrac{x^5}{5!}-\\cdots$, the coefficient of $x^5$ is\n$$\\frac{1}{5!}=\\frac{1}{120}.$$',
  recommendation_reasons = ARRAY['Checks recognition of standard Maclaurin coefficients.','Targets factorial and sign-pattern errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Direct coefficient extraction from a known Maclaurin expansion.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_MACLAURIN_COEFF',
  supporting_skill_ids = ARRAY['SK_SERIES_ALGEBRA'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.11-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.11',
  section_id = '10.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_TAYLOR_POLY_BUILD','SK_FUNCTION_COMPOSITION_SERIES'],
  error_tags = ARRAY['ET_SHIFT_MISUSE','ET_SERIES_TRUNCATION_ERROR'],
  prompt = 'Find the third-degree Maclaurin polynomial for $g(x)=e^{2x}$.',
  latex = 'Find the third-degree Maclaurin polynomial for $g(x)=e^{2x}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1+2x+\\dfrac{(2x)^2}{2!}+\\dfrac{(2x)^3}{3!}$','explanation','This matches $e^u$ with $u=2x$ and is correct, but not simplified.'),
    jsonb_build_object('id','B','text','$1+2x+2x^2+\\dfrac{4}{3}x^3$','explanation','Correct: $e^{2x}=1+2x+\\dfrac{(2x)^2}{2!}+\\dfrac{(2x)^3}{3!}+\\cdots=1+2x+2x^2+\\dfrac{4}{3}x^3$.'),
    jsonb_build_object('id','C','text','$1+2x+2x^2+\\dfrac{2}{3}x^3$','explanation','Cubic coefficient error: $\\dfrac{(2x)^3}{3!}=\\dfrac{8}{6}x^3=\\dfrac{4}{3}x^3$, not $\\dfrac{2}{3}x^3$.'),
    jsonb_build_object('id','D','text','$1+2x+\\dfrac{x^2}{2}+\\dfrac{x^3}{6}$','explanation','Failed to apply $(2x)^n$; coefficients are too small.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use $e^u=1+u+\\dfrac{u^2}{2!}+\\dfrac{u^3}{3!}+\\cdots$ with $u=2x$. Truncate at degree 3:\n$$P_3(x)=1+2x+\\frac{(2x)^2}{2!}+\\frac{(2x)^3}{3!}=1+2x+2x^2+\\frac{4}{3}x^3.$$',
  recommendation_reasons = ARRAY['Practices composition into a known Maclaurin series.','Targets the common error of not raising the inner factor to the correct power.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Substitute $u=2x$ then truncate correctly through $x^3$.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_TAYLOR_POLY_BUILD',
  supporting_skill_ids = ARRAY['SK_FUNCTION_COMPOSITION_SERIES'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.11-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.11',
  section_id = '10.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_TAYLOR_APPROX_VALUE','SK_TAYLOR_POLY_BUILD'],
  error_tags = ARRAY['ET_EVAL_POINT_WRONG','ET_SIGN_PATTERN_ERROR'],
  prompt = 'Let $f(x)=\\cos x$. Use the fourth-degree Maclaurin polynomial to approximate $\\cos(0.2)$.',
  latex = 'Let $f(x)=\\cos x$. Use the fourth-degree Maclaurin polynomial to approximate $\\cos(0.2)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0.980066666\\ldots$','explanation','$1-\\dfrac{0.2^2}{2}+\\dfrac{0.2^4}{24}=1-0.02+0.000066666\\ldots=0.980066666\\ldots$.'),
    jsonb_build_object('id','B','text','$0.979933333\\ldots$','explanation','Sign error on the $x^4$ term: it should be plus for $\\cos x$.'),
    jsonb_build_object('id','C','text','$0.990066666\\ldots$','explanation','Arithmetic error: $\\dfrac{0.04}{2}=0.02$, not $0.01$.'),
    jsonb_build_object('id','D','text','$0.980133333\\ldots$','explanation','Arithmetic error: $0.0016/24=0.000066666\\ldots$, not $0.000133333\\ldots$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use $\\cos x\\approx 1-\\dfrac{x^2}{2!}+\\dfrac{x^4}{4!}$. With $x=0.2$:\n$$1-\\frac{0.2^2}{2}+\\frac{0.2^4}{24}=1-0.02+0.000066666\\ldots=0.980066666\\ldots.$$',
  recommendation_reasons = ARRAY['Builds fluency with a standard Maclaurin polynomial.','Targets sign and arithmetic reliability in series approximations.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Fourth-degree Maclaurin for cosine: keep terms through $x^4$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_TAYLOR_APPROX_VALUE',
  supporting_skill_ids = ARRAY['SK_TAYLOR_POLY_BUILD'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.11-P5';



-- Unit 10.12 (Lagrange Error Bound) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.12',
  section_id = '10.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 165,
  skill_tags = ARRAY['SK_LAGRANGE_ERROR_BOUND','SK_BOUND_MAX_DERIV'],
  error_tags = ARRAY['ET_REMAINDER_FORMULA_MISUSE','ET_MAX_MISIDENTIFY'],
  prompt = 'Use the Lagrange error bound to bound the error when approximating $e^{0.3}$ by the third-degree Maclaurin polynomial for $e^x$.',
  latex = 'Use the Lagrange error bound to bound the error when approximating $e^{0.3}$ by the third-degree Maclaurin polynomial for $e^x$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{e^{0.3}(0.3)^4}{4!}$','explanation','Correct: for $n=3$, $|R_3(0.3)|\\le \\dfrac{M(0.3)^4}{4!}$, and on $[0,0.3]$ the maximum of $e^t$ is $e^{0.3}$.'),
    jsonb_build_object('id','B','text','$\\dfrac{e^{0.3}(0.3)^3}{3!}$','explanation','Wrong order: for degree 3, the remainder uses power $4$ and factorial $4!$.'),
    jsonb_build_object('id','C','text','$\\dfrac{(0.3)^4}{4!}$','explanation','Missing the factor $M$; here $M$ is not $1$.'),
    jsonb_build_object('id','D','text','$\\dfrac{e^{0}(0.3)^4}{4!}$','explanation','Uses $M=1$, but the maximum on $[0,0.3]$ is $e^{0.3}$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For $e^x$, the 4th derivative is $e^x$. On $[0,0.3]$, $M=\\max e^t=e^{0.3}$. Thus\n$$|R_3(0.3)|\\le \\frac{e^{0.3}(0.3)^4}{4!}.$$',
  recommendation_reasons = ARRAY['Reinforces the structure $M|x-a|^{n+1}/(n+1)!$.','Builds correct identification of $M$ as a maximum on an interval.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use interval $[0,0.3]$ for the maximum derivative value.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
    primary_skill_id = 'SK_LAGRANGE_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_BOUND_MAX_DERIV'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.12-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.12',
  section_id = '10.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 200,
  skill_tags = ARRAY['SK_BOUND_MAX_DERIV','SK_LAGRANGE_ERROR_BOUND'],
  error_tags = ARRAY['ET_MAX_MISIDENTIFY','ET_INTERVAL_ENDPOINTS_WRONG'],
  prompt = 'Approximate $\\ln(1.2)$ using the third-degree Taylor polynomial for $\\ln x$ about $x=1$. Using the Lagrange error bound, which is a valid upper bound for the magnitude of the error?',
  latex = 'Approximate $\\ln(1.2)$ using the third-degree Taylor polynomial for $\\ln x$ about $x=1$. Using the Lagrange error bound, which is a valid upper bound for the magnitude of the error?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{6(0.2)^4}{4!}$','explanation','This matches the correct numeric bound, but the key is justifying $M$ as the maximum of $|f^{(4)}|$ on $[1,1.2]$.'),
    jsonb_build_object('id','B','text','$\\dfrac{6(0.2)^4}{4!\\cdot 1^4}$','explanation','$f^{(4)}(x)=-\\dfrac{6}{x^4}$, so $|f^{(4)}(x)|=\\dfrac{6}{x^4}$ is maximized at $x=1$ on $[1,1.2]$, giving $M=6$. Then $|R_3(1.2)|\\le \\dfrac{6(0.2)^4}{4!}$.'),
    jsonb_build_object('id','C','text','$\\dfrac{6(0.2)^3}{3!}$','explanation','Wrong order: degree 3 remainder uses $(0.2)^4/4!$.'),
    jsonb_build_object('id','D','text','$\\dfrac{6(0.2)^4}{4!\\cdot (1.2)^4}$','explanation','Chooses $M$ at $x=1.2$, but $\\dfrac{6}{x^4}$ is decreasing, so the maximum is at $x=1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $f(x)=\\ln x$, $f^{(4)}(x)=-\\dfrac{6}{x^4}$. On $[1,1.2]$, $|f^{(4)}(x)|=\\dfrac{6}{x^4}$ is maximized at $x=1$, so $M=6$. Thus\n$$|R_3(1.2)|\\le \\frac{6(0.2)^4}{4!}.$$',
  recommendation_reasons = ARRAY['Combines Taylor approximation with a rigorous remainder bound.','Targets choosing the correct endpoint for maximizing $|f^{(4)}|$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Maximize $6/x^4$ on $[1,1.2]$; the maximum is at $x=1$.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_BOUND_MAX_DERIV',
  supporting_skill_ids = ARRAY['SK_LAGRANGE_ERROR_BOUND'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.12-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.12',
  section_id = '10.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_LAGRANGE_ERROR_BOUND','SK_REMAINDER_SETUP'],
  error_tags = ARRAY['ET_REMAINDER_FORMULA_MISUSE','ET_N_PLUS_ONE_CONFUSION'],
  prompt = 'A function $f$ has $|f^{(5)}(x)|\\le 48$ for all $x$ between $0$ and $0.5$. What is a Lagrange error bound for approximating $f(0.5)$ using the fourth-degree Maclaurin polynomial for $f$?',
  latex = 'A function $f$ has $|f^{(5)}(x)|\\le 48$ for all $x$ between $0$ and $0.5$. What is a Lagrange error bound for approximating $f(0.5)$ using the fourth-degree Maclaurin polynomial for $f$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{48(0.5)^4}{4!}$','explanation','Wrong order: for degree 4, use power $5$ and $5!$.'),
    jsonb_build_object('id','B','text','$\\dfrac{48(0.5)^5}{4!}$','explanation','Correct power but wrong factorial: should be $5!$.'),
    jsonb_build_object('id','C','text','$\\dfrac{48(0.5)^5}{5!}$','explanation','Correct: $|R_4(0.5)|\\le \\dfrac{M(0.5)^5}{5!}$ with $M=48$.'),
    jsonb_build_object('id','D','text','$\\dfrac{48(0.5)^6}{6!}$','explanation','Uses $(n+2)$ instead of $(n+1)$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'For a degree-4 Maclaurin polynomial,\n$$|R_4(x)|\\le \\frac{M|x|^{5}}{5!}.$$\nGiven $|f^{(5)}(x)|\\le 48$ on $[0,0.5]$, take $M=48$ and $x=0.5$:\n$$|R_4(0.5)|\\le \\frac{48(0.5)^5}{5!}.$$',
  recommendation_reasons = ARRAY['Checks the exact remainder structure for degree $n$.','Targets the common $(n+1)$ indexing mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'No derivative computation required; pure remainder-form recognition.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_LAGRANGE_ERROR_BOUND',
  supporting_skill_ids = ARRAY['SK_REMAINDER_SETUP'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.12-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.12',
  section_id = '10.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 240,
  skill_tags = ARRAY['SK_CHOOSE_N_FOR_ACCURACY','SK_LAGRANGE_ERROR_BOUND'],
  error_tags = ARRAY['ET_MAX_MISIDENTIFY','ET_FACTORIAL_GROWTH_MISJUDGE'],
  prompt = 'What is the smallest $n$ such that the Maclaurin polynomial of degree $n$ for $\\sin x$ guarantees an error less than $10^{-6}$ when approximating $\\sin(0.5)$ using the Lagrange error bound?',
  latex = 'What is the smallest $n$ such that the Maclaurin polynomial of degree $n$ for $\\sin x$ guarantees an error less than $10^{-6}$ when approximating $\\sin(0.5)$ using the Lagrange error bound?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$n=4$','explanation','For $n=4$: $|R_4(0.5)|\\le \\dfrac{0.5^5}{5!}\\approx2.6\\times10^{-4}$, not $<10^{-6}$.'),
    jsonb_build_object('id','B','text','$n=6$','explanation','For $n=6$: $|R_6(0.5)|\\le \\dfrac{0.5^7}{7!}\\approx1.55\\times10^{-6}$, still not below $10^{-6}$.'),
    jsonb_build_object('id','C','text','$n=7$','explanation','For $n=7$: $|R_7(0.5)|\\le \\dfrac{0.5^8}{8!}\\approx9.69\\times10^{-8}<10^{-6}$, and $n=6$ is not sufficient.'),
    jsonb_build_object('id','D','text','$n=8$','explanation','This works, but it is not smallest since $n=7$ already guarantees $<10^{-6}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'For $\\sin x$, all derivatives have magnitude $\\le 1$, so take $M=1$. Need\n$$\\frac{0.5^{n+1}}{(n+1)!}<10^{-6}.$$\nCheck: $n=6$ gives $\\dfrac{0.5^7}{7!}\\approx1.55\\times10^{-6}$, while $n=7$ gives $\\dfrac{0.5^8}{8!}\\approx9.69\\times10^{-8}$. Thus the smallest is $n=7$.',
  recommendation_reasons = ARRAY['AP-style selection of polynomial degree from an error requirement.','Builds intuition for factorial growth vs power decay.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Use $M=1$ for sine derivatives; compare successive bounds to find the smallest $n$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
    primary_skill_id = 'SK_CHOOSE_N_FOR_ACCURACY',
  supporting_skill_ids = ARRAY['SK_LAGRANGE_ERROR_BOUND'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.12-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'BC_Series',
  sub_topic_id = '10.12',
  section_id = '10.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_BOUND_MAX_DERIV','SK_LAGRANGE_ERROR_BOUND'],
  error_tags = ARRAY['ET_MAX_MISIDENTIFY','ET_ABS_VALUE_OMIT'],
  prompt = 'Use the Lagrange error bound to estimate an upper bound on the error when approximating $\\sqrt[3]{1.1}$ by the linearization (degree-1 Taylor polynomial) of $f(x)=x^{1/3}$ about $x=1$.',
  latex = 'Use the Lagrange error bound to estimate an upper bound on the error when approximating $\\sqrt[3]{1.1}$ by the linearization (degree-1 Taylor polynomial) of $f(x)=x^{1/3}$ about $x=1$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\dfrac{2}{9}\\cdot\\dfrac{(0.1)^2}{2}$','explanation','$f^{\\prime\\prime}(x)=-\\dfrac{2}{9}x^{-5/3}$ so $|f^{\\prime\\prime}(x)|=\\dfrac{2}{9}x^{-5/3}$. On $[1,1.1]$ this is maximized at $x=1$, giving $M=\\dfrac{2}{9}$ and $|R_1|\\le \\dfrac{M(0.1)^2}{2}$.'),
    jsonb_build_object('id','B','text','$\\dfrac{2}{9}(1.1)^{-5/3}\\cdot\\dfrac{(0.1)^2}{2}$','explanation','Chooses $M$ at $x=1.1$, but $x^{-5/3}$ decreases, so the maximum is at $x=1$.'),
    jsonb_build_object('id','C','text','$\\dfrac{1}{3}\\cdot\\dfrac{(0.1)^2}{2}$','explanation','Uses $f^{\\prime}(x)$ instead of $f^{\\prime\\prime}(x)$ for a degree-1 remainder bound.'),
    jsonb_build_object('id','D','text','$\\dfrac{2}{9}\\cdot\\dfrac{(0.1)}{2}$','explanation','Wrong power: for degree 1, the remainder uses $|x-1|^2/2!$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For degree 1,\n$$|R_1(x)|\\le \\frac{M|x-1|^2}{2!},\\quad M=\\max_{1\\le t\\le 1.1}|f^{\\prime\\prime}(t)|.$$\nHere $f^{\\prime\\prime}(x)=-\\dfrac{2}{9}x^{-5/3}$, so $|f^{\\prime\\prime}(x)|=\\dfrac{2}{9}x^{-5/3}$ is maximized at $x=1$ on $[1,1.1]$. Thus\n$$|R_1(1.1)|\\le \\frac{\\left(\\frac{2}{9}\\right)(0.1)^2}{2}.$$',
  recommendation_reasons = ARRAY['Connects linearization to a rigorous second-derivative remainder bound.','Targets correct endpoint-max logic for decreasing $x^{-5/3}$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Key step: maximize $|f^{\\prime\\prime}|$ on $[1,1.1]$; it occurs at the left endpoint.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
    primary_skill_id = 'SK_BOUND_MAX_DERIV',
  supporting_skill_ids = ARRAY['SK_LAGRANGE_ERROR_BOUND'],
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'BC_Series',
  updated_at = NOW()
WHERE title = '10.12-P5';

COMMIT;
