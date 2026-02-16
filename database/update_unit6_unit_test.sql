-- Unit 6 (Integration) — Unit Test (Q1–Q20)

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_ACCUM_RATE', 'SK_UNITS_CONTEXT'],

  primary_skill_id = 'SK_ACCUM_RATE',

  supporting_skill_ids = ARRAY['SK_UNITS_CONTEXT'],
  error_tags = ARRAY['E_UNITS', 'E_SIGN_AREA'],
  prompt = 'A car''s velocity is given by $v(t)=3t^2-12t+9$ (meters per second), where $t$ is in seconds. What is the car''s displacement on the interval $0\le t\le 4$?',
  latex = 'A car''s velocity is given by $v(t)=3t^2-12t+9$ (meters per second), where $t$ is in seconds. What is the car''s displacement on the interval $0\le t\le 4$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$4$','explanation','Displacement is $\int_0^4 v(t)\,dt=[t^3-6t^2+9t]_0^4=64-96+36=4$.'),
    jsonb_build_object('id','B','text','$0$','explanation','This would require equal positive and negative signed area on $[0,4]$, which does not occur here.'),
    jsonb_build_object('id','C','text','$12$','explanation','This is a common arithmetic slip when evaluating the antiderivative at $t=4$.'),
    jsonb_build_object('id','D','text','$-4$','explanation','This would come from reversing bounds or dropping the sign incorrectly.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Displacement equals the signed area under velocity:
$$\int_0^4 (3t^2-12t+9)\,dt=[t^3-6t^2+9t]_0^4=4.$$',
  recommendation_reasons = ARRAY['Reinforces accumulation from a rate via a definite integral.', 'Targets common sign and endpoint-evaluation errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: accumulation from velocity; displacement is signed area.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_RIEMANN_SUMS', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_RIEMANN_SUMS',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_RIEMANN_SETUP', 'E_ALG'],
  prompt = 'The diagram shows rectangles used to approximate $\int_0^4 \sqrt{x}\,dx$. Which expression matches the approximation shown?',
  latex = 'The diagram shows rectangles used to approximate $\int_0^4 \sqrt{x}\,dx$. Which expression matches the approximation shown?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{4}{4}\big(\sqrt{1}+\sqrt{2}+\sqrt{3}+\sqrt{4}\big)$','explanation','This is a right Riemann sum using right endpoints $1,2,3,4$, not the pictured left-endpoint rectangles.'),
    jsonb_build_object('id','B','text','$\frac{4}{4}\big(\sqrt{0}+\sqrt{1}+\sqrt{2}+\sqrt{3}\big)$','explanation','Left endpoints for $n=4$ on $[0,4]$ are $0,1,2,3$ and $\Delta x=1$.'),
    jsonb_build_object('id','C','text','$\frac{4}{5}\big(\sqrt{0}+\sqrt{1}+\sqrt{2}+\sqrt{3}+\sqrt{4}\big)$','explanation','This incorrectly uses $5$ terms and the wrong $\Delta x$.'),
    jsonb_build_object('id','D','text','$\frac{4}{4}\big(\sqrt{0}+\sqrt{1}+\sqrt{2}+\sqrt{4}\big)$','explanation','This omits the rectangle over $[3,4]$ (left endpoint $3$).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'The picture shows a left Riemann sum with $n=4$ on $[0,4]$. Thus $\Delta x=1$ and sample points are $0,1,2,3$:
$$L_4=\Delta x\sum_{i=0}^{3}\sqrt{i}=1(\sqrt0+\sqrt1+\sqrt2+\sqrt3).$$',
  recommendation_reasons = ARRAY['Builds reliable translation between a diagram and a sum.', 'Targets left/right endpoint confusion.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: Riemann sums from a diagram (left endpoints).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_SIGMA_NOTATION', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_SIGMA_NOTATION',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_RIEMANN_SETUP', 'E_ALG'],
  prompt = 'Let $f(x)=x^2+1$ on $[0,3]$. Partition $[0,3]$ into $n$ equal subintervals and use right endpoints. Which limit equals $\int_0^3 (x^2+1)\,dx$?',
  latex = 'Let $f(x)=x^2+1$ on $[0,3]$. Partition $[0,3]$ into $n$ equal subintervals and use right endpoints. Which limit equals $\int_0^3 (x^2+1)\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{n\to\infty}\sum_{i=1}^{n}\left(\left(\frac{3i}{n}\right)^2+1\right)$','explanation','Missing the factor $\Delta x=\frac{3}{n}$.'),
    jsonb_build_object('id','B','text','$\lim_{n\to\infty}\frac{1}{n}\sum_{i=1}^{n}\left(\left(\frac{3i}{n}\right)^2+1\right)$','explanation','Uses $\Delta x=\frac{1}{n}$ instead of $\frac{3}{n}$.'),
    jsonb_build_object('id','C','text','$\lim_{n\to\infty}\frac{3}{n}\sum_{i=1}^{n}\left(\left(\frac{3i}{n}\right)^2+1\right)$','explanation','Right endpoints are $x_i^*=\frac{3i}{n}$ and $\Delta x=\frac{3}{n}$.'),
    jsonb_build_object('id','D','text','$\lim_{n\to\infty}\frac{3}{n}\sum_{i=0}^{n-1}\left(\left(\frac{3i}{n}\right)^2+1\right)$','explanation','This uses left endpoints ($i=0$ to $n-1$).')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'For $[0,3]$ with $n$ subintervals, $\Delta x=\frac{3}{n}$. Right endpoints are $x_i^*=\frac{3i}{n}$. Therefore
$$\int_0^3 (x^2+1)\,dx=\lim_{n\to\infty}\frac{3}{n}\sum_{i=1}^{n}\left(\left(\frac{3i}{n}\right)^2+1\right).$$',
  recommendation_reasons = ARRAY['Tests precise Riemann-sum construction in sigma notation.', 'Targets the missing-$\Delta x$ mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: sigma form of a definite integral (right endpoints).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_INT_PROPERTIES', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_INT_PROPERTIES',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_BOUNDS', 'E_FTC'],
  prompt = 'Given $\int_1^5 f(x)\,dx=7$ and $\int_1^5 g(x)\,dx=-2$, what is $\int_5^1 (2f(x)-3g(x))\,dx$?',
  latex = 'Given $\int_1^5 f(x)\,dx=7$ and $\int_1^5 g(x)\,dx=-2$, what is $\int_5^1 (2f(x)-3g(x))\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$20$','explanation','This forgets that reversing bounds changes the sign.'),
    jsonb_build_object('id','B','text','$-8$','explanation','This applies linearity incorrectly. First compute $2(7)-3(-2)=20$.'),
    jsonb_build_object('id','C','text','$8$','explanation','This incorrectly flips the sign on $-3g$ while combining the integrals.'),
    jsonb_build_object('id','D','text','$-20$','explanation','Compute on $[1,5]$: $\int_1^5(2f-3g)=2(7)-3(-2)=20$. Reverse bounds: $\int_5^1(2f-3g)=-20$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use linearity and reversal:
$$\int_1^5(2f-3g)=2\int_1^5 f-3\int_1^5 g=2(7)-3(-2)=20,$$
so
$$\int_5^1(2f-3g)=-20.$$',
  recommendation_reasons = ARRAY['Reinforces properties of definite integrals.', 'Targets the bounds-reversal sign error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: linearity + reversed bounds.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ACCUM_BEHAVIOR', 'SK_FTC_ACCUM_FUNC'],

  primary_skill_id = 'SK_ACCUM_BEHAVIOR',

  supporting_skill_ids = ARRAY['SK_FTC_ACCUM_FUNC'],
  error_tags = ARRAY['E_FTC', 'E_SIGN_AREA'],
  prompt = 'Let $F(x)=\int_0^x g(t)\,dt$. The graph of $g$ is shown. Which statement is true?',
  latex = 'Let $F(x)=\int_0^x g(t)\,dt$. The graph of $g$ is shown. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists a point in $(2,3)$ where $F$ has a local maximum.','explanation','A local maximum of $F$ occurs where $F''s$ derivative changes from positive to negative, i.e., where $g$ changes from positive to negative. The graph shows such a change between $2$ and $3$.'),
    jsonb_build_object('id','B','text','$F$ is increasing on $(2,3)$.','explanation','False because $F''(x)=g(x)$ and the graph shows $g(x)<0$ on $(2,3)$.'),
    jsonb_build_object('id','C','text','$F(4)<F(3)$.','explanation','From $3$ to $4$, the graph shows $g$ mostly above $0$, so $F$ increases and $F(4)>F(3)$.'),
    jsonb_build_object('id','D','text','If $g(2)=0$, then $F$ must have an inflection point at $x=2$.','explanation','Inflection of $F$ depends on $F''''(x)=g''(x)$ changing sign, not just $g(2)=0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'By FTC, $F''(x)=g(x)$. $F$ increases where $g>0$ and decreases where $g<0$. A local maximum of $F$ occurs where $g$ changes from positive to negative; the graph shows that change within $(2,3)$.',
  recommendation_reasons = ARRAY['Tests interpreting accumulation functions from a graph.', 'Targets confusion between $F''$, $F''''$, and sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: interpret $F(x)=\int_0^x g$ using the graph of $g$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_FTC_EVAL', 'SK_CHAIN_INTEGRALS'],

  primary_skill_id = 'SK_FTC_EVAL',

  supporting_skill_ids = ARRAY['SK_CHAIN_INTEGRALS'],
  error_tags = ARRAY['E_FTC', 'E_ALG'],
  prompt = 'If $H(x)=\int_{1}^{x^3} (2t-5)\,dt$, what is $H''(x)$?',
  latex = 'If $H(x)=\int_{1}^{x^3} (2t-5)\,dt$, what is $H''(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2x^3-5$','explanation','This forgets the chain rule factor from the upper limit $x^3$.'),
    jsonb_build_object('id','B','text','$(2x^3-5)\cdot 3x^2$','explanation','By FTC and chain rule: $H''(x)=(2(x^3)-5)\cdot 3x^2$.'),
    jsonb_build_object('id','C','text','$\int_1^{x^3}(2t-5)\,dt$','explanation','That is $H(x)$, not the derivative.'),
    jsonb_build_object('id','D','text','$6x^2$','explanation','This differentiates only the upper limit and ignores evaluating the integrand at $t=x^3$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Use FTC with a variable upper bound:
$$\frac{d}{dx}\int_1^{x^3}(2t-5)\,dt=(2(x^3)-5)\cdot 3x^2=(2x^3-5)\cdot 3x^2.$$',
  recommendation_reasons = ARRAY['Tests FTC with a nontrivial upper bound.', 'Targets the missing chain-rule factor error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: FTC + chain rule with upper bound $x^3$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q6';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_INT_PROPERTIES', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_INT_PROPERTIES',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_BOUNDS', 'E_SIGN_AREA'],
  prompt = 'If $f$ is continuous and $\int_0^2 f(x)\,dx=5$, what is $\int_0^2 f(2-x)\,dx$?',
  latex = 'If $f$ is continuous and $\int_0^2 f(x)\,dx=5$, what is $\int_0^2 f(2-x)\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-5$','explanation','A negative would come from reversing bounds without compensating; the substitution here preserves the value.'),
    jsonb_build_object('id','B','text','Cannot be determined from the information given.','explanation','It can be determined using substitution on $[0,2]$.'),
    jsonb_build_object('id','C','text','$\frac{5}{2}$','explanation','No averaging occurs; the substitution does not halve the integral.'),
    jsonb_build_object('id','D','text','$5$','explanation','Let $u=2-x$. Then $du=-dx$ and bounds swap, giving $\int_0^2 f(2-x)\,dx=\int_0^2 f(u)\,du=5$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Let $u=2-x$, so $du=-dx$. When $x=0$, $u=2$; when $x=2$, $u=0$:
$$\int_0^2 f(2-x)\,dx=\int_2^0 f(u)(-du)=\int_0^2 f(u)\,du=5.$$',
  recommendation_reasons = ARRAY['Checks substitution with correct bound tracking.', 'Targets common sign/bounds mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: substitution symmetry on a fixed interval.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q7';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_AREA_BETWEEN', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_AREA_BETWEEN',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_SIGN_AREA', 'E_BOUNDS'],
  prompt = 'The shaded region is between $y=x$ and $y=x^2$ on $0\le x\le 1$. What is the area of the region?',
  latex = 'The shaded region is between $y=x$ and $y=x^2$ on $0\le x\le 1$. What is the area of the region?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\int_0^1 (x^2-x)\,dx$','explanation','This is bottom minus top, which gives a negative value on $[0,1]$.'),
    jsonb_build_object('id','B','text','$\int_0^1 (x+x^2)\,dx$','explanation','Area between curves is not found by adding the functions.'),
    jsonb_build_object('id','C','text','$\frac{1}{6}$','explanation','On $[0,1]$, $x\ge x^2$, so area is $\int_0^1(x-x^2)\,dx=\left[\frac{x^2}{2}-\frac{x^3}{3}\right]_0^1=\frac16$.'),
    jsonb_build_object('id','D','text','$\frac{1}{3}$','explanation','This often results from forgetting the $\frac12$ in $\int x\,dx=\frac{x^2}{2}$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'On $[0,1]$, the top curve is $y=x$ and the bottom curve is $y=x^2$, so
$$\text{Area}=\int_0^1 (x-x^2)\,dx=\left[\frac{x^2}{2}-\frac{x^3}{3}\right]_0^1=\frac16.$$',
  recommendation_reasons = ARRAY['Core setup: area between curves as top minus bottom.', 'Targets the frequent sign/top-bottom mistake.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: area between curves with correct top-minus-bottom.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q8';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_ANTIDERIV_RULES', 'SK_PLUS_C'],

  primary_skill_id = 'SK_ANTIDERIV_RULES',

  supporting_skill_ids = ARRAY['SK_PLUS_C'],
  error_tags = ARRAY['E_ALG', 'E_FTC'],
  prompt = 'Find $\int (6x^2-4\sin x)\,dx$.',
  latex = 'Find $\int (6x^2-4\sin x)\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$2x^3+4\cos x+C$','explanation','Integrate term-by-term: $\int 6x^2 dx=2x^3$ and $\int -4\sin x dx=4\cos x$.'),
    jsonb_build_object('id','B','text','$2x^3-4\cos x+C$','explanation','Sign error: $\int -4\sin x\,dx=4\cos x$, not $-4\cos x$.'),
    jsonb_build_object('id','C','text','$6x^3+4\cos x+C$','explanation','Power rule misapplied: $\int 6x^2 dx=2x^3$, not $6x^3$.'),
    jsonb_build_object('id','D','text','$2x^3+4\sin x+C$','explanation','$\int -4\sin x\,dx$ is not $4\sin x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use linearity:
$$\int (6x^2-4\sin x)\,dx=2x^3+4\cos x+C.$$',
  recommendation_reasons = ARRAY['Reinforces basic antiderivative rules and $+C$.', 'Targets common trig-antiderivative sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: basic indefinite integrals and notation.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q9';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_U_SUB', 'SK_ALG_SIMPLIFY'],

  primary_skill_id = 'SK_U_SUB',

  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_U_SUB', 'E_ALG'],
  prompt = 'Evaluate $\int \frac{2x}{x^2+5}\,dx$.',
  latex = 'Evaluate $\int \frac{2x}{x^2+5}\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{2}{x^2+5}+C$','explanation','This treats the integral like a reciprocal rule; it is not correct.'),
    jsonb_build_object('id','B','text','$\ln(x^2+5)+C$','explanation','Let $u=x^2+5$, $du=2x\,dx$. Then the integral becomes $\int \frac{1}{u}\,du=\ln|u|+C$.'),
    jsonb_build_object('id','C','text','$\arctan\!\left(\frac{x}{\sqrt5}\right)+C$','explanation','This matches $\int \frac{1}{x^2+a^2}\,dx$, but the numerator here is $2x$.'),
    jsonb_build_object('id','D','text','$\frac12\ln(x^2+5)+C$','explanation','Factor error: since $du=2x\,dx$ matches exactly, no $\frac12$ is needed.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Let $u=x^2+5$, $du=2x\,dx$:
$$\int \frac{2x}{x^2+5}\,dx=\int \frac{1}{u}\,du=\ln|u|+C=\ln(x^2+5)+C.$$',
  recommendation_reasons = ARRAY['Tests canonical $u$-sub pattern matching.', 'Targets missing/extra constant-factor mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: substitution leading to logarithms.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q10';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_ALG_TECHNIQUE', 'SK_ALG_SIMPLIFY'],

  primary_skill_id = 'SK_ALG_TECHNIQUE',

  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_ALG', 'E_U_SUB'],
  prompt = 'Evaluate $\int \frac{x^2+1}{x}\,dx$.',
  latex = 'Evaluate $\int \frac{x^2+1}{x}\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\ln|x|+C$','explanation','This integrates only $1/x$ and ignores the $x$ term after simplification.'),
    jsonb_build_object('id','B','text','$x^2+\ln|x|+C$','explanation','Power rule error: $\int x\,dx=\frac{x^2}{2}$, not $x^2$.'),
    jsonb_build_object('id','C','text','$\frac{x^2}{2}+\ln|x|+C$','explanation','Rewrite $\frac{x^2+1}{x}=x+\frac{1}{x}$. Then integrate term-by-term.'),
    jsonb_build_object('id','D','text','$\frac{x^3}{3}+\ln|x|+C$','explanation','This treats the $x$ term as $x^2$ by mistake.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Simplify first:
$$\frac{x^2+1}{x}=x+\frac{1}{x}.$$
Then
$$\int\left(x+\frac{1}{x}\right)\,dx=\frac{x^2}{2}+\ln|x|+C.$$',
  recommendation_reasons = ARRAY['Reinforces simplify-first strategy for rational integrands.', 'Targets common algebra and power-rule errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: simplify rational integrand before integrating.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q11';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_INT_BY_PARTS', 'SK_ALG_SIMPLIFY'],

  primary_skill_id = 'SK_INT_BY_PARTS',

  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_IBP_SETUP', 'E_ALG'],
  prompt = 'Evaluate $\int x e^{x}\,dx$.',
  latex = 'Evaluate $\int x e^{x}\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$xe^{x}+C$','explanation','Differentiate to check: $(xe^x)''=e^x+xe^x$, not $xe^x$.'),
    jsonb_build_object('id','B','text','$e^{x}+C$','explanation','This ignores the $x$ factor.'),
    jsonb_build_object('id','C','text','$-xe^{x}+e^{x}+C$','explanation','Sign error from misusing $\int u\,dv=uv-\int v\,du$.'),
    jsonb_build_object('id','D','text','$(x-1)e^{x}+C$','explanation','Let $u=x$, $dv=e^x dx$. Then $\int xe^x dx=xe^x-\int e^x dx=(x-1)e^x+C$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Integration by parts with $u=x$, $dv=e^x dx$:
$$\int xe^x\,dx=xe^x-\int e^x\,dx=(x-1)e^x+C.$$',
  recommendation_reasons = ARRAY['BC staple: integration by parts with exponential.', 'Targets sign and setup errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: integration by parts.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q12';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_PARTIAL_FRAC', 'SK_ALG_SIMPLIFY'],

  primary_skill_id = 'SK_PARTIAL_FRAC',

  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_PF_SETUP', 'E_ALG'],
  prompt = 'Evaluate $\int \frac{5}{x^2-1}\,dx$.',
  latex = 'Evaluate $\int \frac{5}{x^2-1}\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{5}{2}\ln|x^2-1|+C$','explanation','This would require a $2x$ numerator to match $\frac{d}{dx}(x^2-1)$.'),
    jsonb_build_object('id','B','text','$5\arctan(x)+C$','explanation','$\arctan$ arises from $1/(x^2+a^2)$, not $1/(x^2-1)$.'),
    jsonb_build_object('id','C','text','$\frac{5}{2}\ln\left|\frac{x-1}{x+1}\right|+C$','explanation','Decompose $\frac{5}{(x-1)(x+1)}=\frac{5/2}{x-1}-\frac{5/2}{x+1}$, then integrate to logs.'),
    jsonb_build_object('id','D','text','$\frac{5}{2}\ln\left|\frac{x+1}{x-1}\right|+C$','explanation','This is the negative log ratio; while equivalent up to a constant, it does not match the stated decomposition signs.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Factor and decompose:
$$\frac{5}{x^2-1}=\frac{5}{(x-1)(x+1)}=\frac{5/2}{x-1}-\frac{5/2}{x+1}.$$
Then
$$\int \frac{5}{x^2-1}dx=\frac{5}{2}\ln|x-1|-\frac{5}{2}\ln|x+1|+C=\frac{5}{2}\ln\left|\frac{x-1}{x+1}\right|+C.$$',
  recommendation_reasons = ARRAY['BC staple: partial fractions to logarithms.', 'Targets decomposition/sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: partial fractions with linear factors.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q13';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 145,
  skill_tags = ARRAY['SK_ALG_TECHNIQUE', 'SK_ALG_SIMPLIFY'],

  primary_skill_id = 'SK_ALG_TECHNIQUE',

  supporting_skill_ids = ARRAY['SK_ALG_SIMPLIFY'],
  error_tags = ARRAY['E_ALG', 'E_U_SUB'],
  prompt = 'Evaluate $\int \frac{x^2+4x+5}{x+2}\,dx$.',
  latex = 'Evaluate $\int \frac{x^2+4x+5}{x+2}\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\ln|x+2|+C$','explanation','This would require a numerator proportional to $\frac{d}{dx}(x+2)=1$.'),
    jsonb_build_object('id','B','text','$x^2+2x+\ln|x+2|+C$','explanation','Power rule error: $\int x\,dx=\frac{x^2}{2}$, not $x^2$.'),
    jsonb_build_object('id','C','text','$\frac{x^2}{2}+2x-\ln|x+2|+C$','explanation','Sign error on $\int \frac{1}{x+2}\,dx$.'),
    jsonb_build_object('id','D','text','$\frac{x^2}{2}+2x+\ln|x+2|+C$','explanation','Divide: $\frac{x^2+4x+5}{x+2}=x+2+\frac{1}{x+2}$. Integrate to get $\frac{x^2}{2}+2x+\ln|x+2|+C$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Rewrite by division:
$$\frac{x^2+4x+5}{x+2}=x+2+\frac{1}{x+2}.$$
Then
$$\int\left(x+2+\frac{1}{x+2}\right)\,dx=\frac{x^2}{2}+2x+\ln|x+2|+C.$$',
  recommendation_reasons = ARRAY['Tests long-division rewrite before integrating.', 'Targets algebra and log-sign errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: algebraic technique selection (rewrite then integrate).',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q14';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_U_SUB', 'SK_TRIG_INT'],

  primary_skill_id = 'SK_U_SUB',

  supporting_skill_ids = ARRAY['SK_TRIG_INT'],
  error_tags = ARRAY['E_U_SUB', 'E_ALG'],
  prompt = 'Evaluate $\int \cos(3x)\,dx$.',
  latex = 'Evaluate $\int \cos(3x)\,dx$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{1}{3}\sin(3x)+C$','explanation','Let $u=3x$, $du=3dx$, so $\int \cos(3x)dx=\frac13\int \cos u\,du=\frac13\sin u+C$.'),
    jsonb_build_object('id','B','text','$\sin(3x)+C$','explanation','Missing the factor $\frac13$ from substitution.'),
    jsonb_build_object('id','C','text','$-\cos(3x)+C$','explanation','Derivative of $\cos(3x)$ is $-3\sin(3x)$, not $\cos(3x)$.'),
    jsonb_build_object('id','D','text','$3\sin(3x)+C$','explanation','This multiplies by $3$ instead of dividing by $3$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Use $u=3x$, $dx=\frac{1}{3}du$:
$$\int \cos(3x)\,dx=\frac13\int \cos u\,du=\frac13\sin u+C=\frac13\sin(3x)+C.$$',
  recommendation_reasons = ARRAY['Reinforces constant-factor discipline in substitution.', 'Targets the frequent missing-$\frac13$ error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: substitution with trig and constant multiple.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q15';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_TECH_SELECT', 'SK_INT_BY_PARTS'],

  primary_skill_id = 'SK_TECH_SELECT',

  supporting_skill_ids = ARRAY['SK_INT_BY_PARTS'],
  error_tags = ARRAY['E_U_SUB', 'E_IBP_SETUP'],
  prompt = 'Which method is most appropriate to evaluate $\int x\ln(x)\,dx$?',
  latex = 'Which method is most appropriate to evaluate $\int x\ln(x)\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Substitution with $u=\ln(x)$','explanation','With $u=\ln x$, $du=\frac{1}{x}dx$ does not match $x\,dx$ cleanly; it leads to harder algebra.'),
    jsonb_build_object('id','B','text','Partial fractions','explanation','The integrand is not a rational function.'),
    jsonb_build_object('id','C','text','Integration by parts','explanation','Choose $u=\ln x$ and $dv=x\,dx$ so $du=\frac{1}{x}dx$ simplifies and $v=\frac{x^2}{2}$.'),
    jsonb_build_object('id','D','text','Trigonometric substitution','explanation','No square-root quadratic form appears.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The product $x\ln x$ is best handled with integration by parts: let $u=\ln x$ (simplifies when differentiated) and $dv=x\,dx$ (easy to integrate).',
  recommendation_reasons = ARRAY['Assesses technique selection under AP-style prompts.', 'Targets the tendency to force the wrong method.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: selecting an antiderivative technique.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q16';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = TRUE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_IMPROPER_INT', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_IMPROPER_INT',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_IMPROPER_CONV', 'E_FTC'],
  prompt = 'Consider $\int_0^4 \frac{1}{(x-2)^2}\,dx$. The graph of $y=\frac{1}{(x-2)^2}$ is shown. Which statement is true?',
  latex = 'Consider $\int_0^4 \frac{1}{(x-2)^2}\,dx$. The graph of $y=\frac{1}{(x-2)^2}$ is shown. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The integral diverges.','explanation','There is a vertical asymptote at $x=2$ with power $2\ge 1$, so each side integral diverges.'),
    jsonb_build_object('id','B','text','The integral converges to $\frac12$.','explanation','A finite value would require convergence on both sides of $x=2$, which fails here.'),
    jsonb_build_object('id','C','text','The integral converges to $1$.','explanation','The improper integral near $x=2$ does not converge.'),
    jsonb_build_object('id','D','text','The integral equals $\left[-\frac{1}{x-2}\right]_0^4$.','explanation','You cannot apply FTC across the discontinuity without splitting at $x=2$ and using limits.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Split at the discontinuity:
$$\int_0^4 \frac{1}{(x-2)^2}dx=\lim_{b\to2^-}\int_0^b\frac{1}{(x-2)^2}dx+\lim_{a\to2^+}\int_a^4\frac{1}{(x-2)^2}dx.$$
Each term diverges, so the integral diverges.',
  recommendation_reasons = ARRAY['BC staple: improper integrals with interior asymptotes.', 'Targets invalid FTC-across-discontinuity mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: improper integral divergence due to vertical asymptote.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q17';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_AVG_VALUE', 'SK_DEF_INT_CONCEPT'],

  primary_skill_id = 'SK_AVG_VALUE',

  supporting_skill_ids = ARRAY['SK_DEF_INT_CONCEPT'],
  error_tags = ARRAY['E_UNITS', 'E_ALG'],
  prompt = 'The average value of a continuous function $f$ on $[2,6]$ is $3$. What is $\int_2^6 f(x)\,dx$?',
  latex = 'The average value of a continuous function $f$ on $[2,6]$ is $3$. What is $\int_2^6 f(x)\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','This confuses average value with total accumulation.'),
    jsonb_build_object('id','B','text','$8$','explanation','This uses only the interval length $6-2=4$ incorrectly.'),
    jsonb_build_object('id','C','text','$\frac{3}{4}$','explanation','This inverts the average value formula.'),
    jsonb_build_object('id','D','text','$12$','explanation','$\int_2^6 f= f_{\text{avg}}(6-2)=3\cdot 4=12$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Average value satisfies
$$3=\frac{1}{6-2}\int_2^6 f(x)\,dx,$$
so
$$\int_2^6 f(x)\,dx=3(4)=12.$$',
  recommendation_reasons = ARRAY['Connects average value to total accumulation.', 'Targets common inversion/forgetting-interval-length errors.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: average value relationship.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q18';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_FTC_EVAL', 'SK_INT_PROPERTIES'],

  primary_skill_id = 'SK_FTC_EVAL',

  supporting_skill_ids = ARRAY['SK_INT_PROPERTIES'],
  error_tags = ARRAY['E_FTC', 'E_ALG'],
  prompt = 'If $\int_0^x f(t)\,dt = x^2\sin x$ for all $x$, what is $f(\pi)$?',
  latex = 'If $\int_0^x f(t)\,dt = x^2\sin x$ for all $x$, what is $f(\pi)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','This evaluates $x^2\sin x$ at $x=\pi$ without differentiating.'),
    jsonb_build_object('id','B','text','$\pi^2$','explanation','This substitutes $x=\pi$ into $x^2\sin x$ and ignores FTC.'),
    jsonb_build_object('id','C','text','$2\pi$','explanation','This drops the $x^2\cos x$ term or mis-evaluates trig.'),
    jsonb_build_object('id','D','text','$-\pi^2$','explanation','Differentiate: $f(x)=\frac{d}{dx}(x^2\sin x)=2x\sin x+x^2\cos x$. Then $f(\pi)=0+\pi^2(-1)=-\pi^2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'By FTC,
$$f(x)=\frac{d}{dx}\left(\int_0^x f(t)\,dt\right)=\frac{d}{dx}(x^2\sin x)=2x\sin x+x^2\cos x.$$
Thus
$$f(\pi)=2\pi\sin\pi+\pi^2\cos\pi=0+\pi^2(-1)=-\pi^2.$$',
  recommendation_reasons = ARRAY['Tests FTC as an inverse process with product rule.', 'Targets dropping product-rule terms.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: recover integrand by differentiating an accumulation identity.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q19';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Integration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  skill_tags = ARRAY['SK_TECH_SELECT', 'SK_U_SUB'],

  primary_skill_id = 'SK_TECH_SELECT',

  supporting_skill_ids = ARRAY['SK_U_SUB'],
  error_tags = ARRAY['E_U_SUB', 'E_PF_SETUP'],
  prompt = 'Which technique is most appropriate to evaluate $\int \frac{x}{x^2-1}\,dx$?',
  latex = 'Which technique is most appropriate to evaluate $\int \frac{x}{x^2-1}\,dx$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Integration by parts','explanation','No product structure suggests parts; it complicates the integral.'),
    jsonb_build_object('id','B','text','Long division','explanation','The degree of the numerator is less than the denominator; division does not simplify.'),
    jsonb_build_object('id','C','text','Substitution with $u=x^2-1$','explanation','Since $\frac{d}{dx}(x^2-1)=2x$, substitution is direct and leads to a logarithm.'),
    jsonb_build_object('id','D','text','Partial fractions','explanation','Possible, but not the most direct approach when the numerator matches the derivative of the denominator up to a constant.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $\frac{d}{dx}(x^2-1)=2x$ matches the numerator up to a constant, the most appropriate method is substitution $u=x^2-1$.',
  recommendation_reasons = ARRAY['Assesses technique selection (recognize $f''(x)/f(x)$ structure).', 'Targets overuse of heavier methods like partial fractions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Unit 6 UT: selecting substitution for $f''(x)/f(x)$ forms.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Integration',
  updated_at = NOW()
WHERE title = '6.0-UT-Q20';
