
-- Unit 1.15 (Connecting Limits at Infinity and Horizontal Asymptotes) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  section_id = '1.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA_RULES','SK_RATIONAL_END_BEHAVIOR'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA_RULES',
  supporting_skill_ids = ARRAY['SK_RATIONAL_END_BEHAVIOR'],
  error_tags = ARRAY['E_LIMIT_INFINITY_DEGREE_RULE','E_END_BEHAVIOR_SIGN'],
  prompt = 'For the function $$f(x)=\frac{5x^3-2x+7}{2x^3+9},$$ what is the horizontal asymptote of the graph of $f$?',
  latex = 'For the function $$f(x)=\frac{5x^3-2x+7}{2x^3+9},$$ what is the horizontal asymptote of the graph of $f$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=\frac{5}{2}x$','explanation','This confuses equal-degree end behavior with a slant asymptote; equal degrees do not produce a linear asymptote.'),
    jsonb_build_object('id','B','text','$y=\frac{5}{2}$','explanation','Correct: degrees are equal, so the horizontal asymptote is the ratio of leading coefficients $\frac{5}{2}$.'),
    jsonb_build_object('id','C','text','$y=0$','explanation','This would occur only if the numerator degree were less than the denominator degree.'),
    jsonb_build_object('id','D','text','No horizontal asymptote','explanation','There is a horizontal asymptote because the degrees are equal.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'As $x\to\pm\infty$, the highest-degree terms dominate:
$$f(x)=\frac{5x^3-2x+7}{2x^3+9}\sim\frac{5x^3}{2x^3}=\frac{5}{2}.$$
So the horizontal asymptote is $y=\frac{5}{2}$.',
  recommendation_reasons = ARRAY[
    'Reinforces the degree/leading-coefficient rule for limits at infinity of rational functions.',
    'Targets common confusion between horizontal and slant asymptotes.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: horizontal asymptote for equal-degree rational functions.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.15-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  section_id = '1.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA_RULES','SK_NUMERICAL_ESTIMATION_LIMITS'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA_RULES',
  supporting_skill_ids = ARRAY['SK_NUMERICAL_ESTIMATION_LIMITS'],
  error_tags = ARRAY['E_LIMIT_INFINITY_DEGREE_RULE','E_END_BEHAVIOR_SIGN'],
  prompt = 'The table shows values of $f(x)=\dfrac{3x^2+1}{x^2-4}$ for large $x$.
See image: 1.15-P2.png
Based on end behavior, which horizontal asymptote is correct?',
  latex = 'The table shows values of $f(x)=\dfrac{3x^2+1}{x^2-4}$ for large $x$.
See image: 1.15-P2.png
Based on end behavior, which horizontal asymptote is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$y=3$','explanation','Correct: degrees are equal, so the limit at infinity approaches the ratio of leading coefficients $\frac{3}{1}=3$, consistent with the table.'),
    jsonb_build_object('id','B','text','$y=-3$','explanation','The leading-coefficient ratio is positive, and the table approaches a positive value.'),
    jsonb_build_object('id','C','text','$y=0$','explanation','That would require the numerator degree to be less than the denominator degree.'),
    jsonb_build_object('id','D','text','No horizontal asymptote','explanation','This rational function has a horizontal asymptote determined by degrees.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'For $$f(x)=\frac{3x^2+1}{x^2-4},$$ the degrees match, so
$$\lim_{x\to\pm\infty} f(x)=\frac{3}{1}=3.$$
Thus the horizontal asymptote is $y=3$.',
  recommendation_reasons = ARRAY[
    'Connects numerical evidence (table) to the leading-term asymptote rule.',
    'Builds confidence interpreting end behavior from data.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.85,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Uses a table to infer a horizontal asymptote; reinforces leading-coefficient rule.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.15-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  section_id = '1.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_GRAPH_INTERPRETATION_LIMITS','SK_LIMITS_INFINITY_HA_RULES'],
  primary_skill_id = 'SK_GRAPH_INTERPRETATION_LIMITS',
  supporting_skill_ids = ARRAY['SK_LIMITS_INFINITY_HA_RULES'],
  error_tags = ARRAY['E_ASYMPTOTE_CONFUSION','E_END_BEHAVIOR_SIGN'],
  prompt = 'A graph is shown.
See image: 1.15-P3.png
What is $$\lim_{x\to\infty} f(x)?$$',
  latex = 'A graph is shown.
See image: 1.15-P3.png
What is $$\lim_{x\to\infty} f(x)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The right-hand end of the graph does not approach $0$; it levels off near $1$.'),
    jsonb_build_object('id','B','text','$2$','explanation','This confuses vertical behavior near the vertical asymptote with end behavior as $x\to\infty$.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','The graph approaches a constant value as $x\to\infty$, so the limit exists.'),
    jsonb_build_object('id','D','text','$1$','explanation','Correct: the right tail approaches the horizontal line $y=1$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'From the graph, as $x$ increases without bound, the curve approaches the horizontal line $y=1$. Therefore,
$$\lim_{x\to\infty} f(x)=1.$$',
  recommendation_reasons = ARRAY[
    'Builds fluency reading limits at infinity directly from a graph.',
    'Targets the common confusion between vertical-asymptote behavior and end behavior.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based evaluation of a limit at infinity; distinguish end behavior from vertical-asymptote behavior.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.15-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  section_id = '1.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA_RULES','SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA_RULES',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION'],
  error_tags = ARRAY['E_LIMIT_INFINITY_DEGREE_RULE','E_ALGEBRA_SIMPLIFY_ERROR'],
  prompt = 'Evaluate the limit:
$$\lim_{x\to-\infty}\frac{-4x^4+7x^2-1}{2x^4+5x-9}.$$',
  latex = 'Evaluate the limit:
$$\lim_{x\to-\infty}\frac{-4x^4+7x^2-1}{2x^4+5x-9}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\infty$','explanation','Equal degrees give a finite limit (ratio of leading coefficients), not an infinite limit.'),
    jsonb_build_object('id','B','text','$-\infty$','explanation','Equal degrees give a finite limit; the expression is not unbounded.'),
    jsonb_build_object('id','C','text','$-2$','explanation','Correct: the ratio of leading coefficients is $\frac{-4}{2}=-2$.'),
    jsonb_build_object('id','D','text','$2$','explanation','This misses the negative leading coefficient in the numerator.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Divide numerator and denominator by $x^4$:
$$\frac{-4+7/x^2-1/x^4}{2+5/x^3-9/x^4}.$$
As $x\to-\infty$, the terms with $1/x^k$ go to $0$, so the limit is
$$\frac{-4}{2}=-2.$$',
  recommendation_reasons = ARRAY[
    'Strengthens the divide-by-highest-power method.',
    'Emphasizes sign control in leading-term reasoning.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Limit at negative infinity; requires careful leading-term reasoning.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.15-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.15',
  section_id = '1.15',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION','SK_LIMITS_INFINITY_HA_RULES'],
  primary_skill_id = 'SK_ALGEBRAIC_SIMPLIFICATION',
  supporting_skill_ids = ARRAY['SK_LIMITS_INFINITY_HA_RULES'],
  error_tags = ARRAY['E_ALGEBRA_SIMPLIFY_ERROR','E_END_BEHAVIOR_SIGN'],
  prompt = 'Find the end behavior of
$$f(x)=\frac{\sqrt{x^2+4x+1}}{x}.$$
Which statement is correct?',
  latex = 'Find the end behavior of
$$f(x)=\frac{\sqrt{x^2+4x+1}}{x}.$$
Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to\infty}f(x)=0$ and $\lim_{x\to-\infty}f(x)=0$','explanation','The numerator grows like $|x|$, so the ratio does not approach $0$.'),
    jsonb_build_object('id','B','text','$\lim_{x\to\infty}f(x)=1$ and $\lim_{x\to-\infty}f(x)=-1$','explanation','Correct: $\sqrt{x^2+4x+1}\sim|x|$, so $f(x)\sim|x|/x$.'),
    jsonb_build_object('id','C','text','$\lim_{x\to\infty}f(x)=1$ and $\lim_{x\to-\infty}f(x)=1$','explanation','This ignores that $\sqrt{x^2+4x+1}\sim|x|$, not $x$.'),
    jsonb_build_object('id','D','text','Neither limit exists','explanation','Both one-sided-infinity limits exist and are finite (possibly different).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Factor $x^2$ inside the radical:
$$f(x)=\frac{\sqrt{x^2(1+4/x+1/x^2)}}{x}=\frac{|x|}{x}\sqrt{1+4/x+1/x^2}.$$
As $x\to\infty$, $\frac{|x|}{x}=1$ and the radical $\to 1$, so the limit is $1$.
As $x\to-\infty$, $\frac{|x|}{x}=-1$ and the radical $\to 1$, so the limit is $-1$.',
  recommendation_reasons = ARRAY[
    'Targets a common AP trap: radicals at infinity introduce $|x|$.',
    'Builds correct two-sided end-behavior reasoning ($x\to\infty$ vs $x\to-\infty$).'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Advanced end behavior with radicals; distinguishes $x$ vs $|x|$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.15-P5';



-- Unit 1.16 (Working with the Intermediate Value Theorem) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  section_id = '1.16',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_IVT_APPLICATION','SK_FUNCTION_CONTINUITY_CHECK'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_FUNCTION_CONTINUITY_CHECK'],
  error_tags = ARRAY['E_IVT_CONDITIONS_MISUSED','E_CONTINUITY_ASSUMPTION'],
  prompt = 'Let $f$ be continuous on $[2,7]$ with $f(2)=-3$ and $f(7)=5$. Which statement must be true?',
  latex = 'Let $f$ be continuous on $[2,7]$ with $f(2)=-3$ and $f(7)=5$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c\in(2,7)$ such that $f(c)=10$.','explanation','$10$ is not between $-3$ and $5$, so IVT does not guarantee it.'),
    jsonb_build_object('id','B','text','There exists $c\in(2,7)$ such that $f(c)=-4$.','explanation','$-4$ is not between $-3$ and $5$, so IVT does not guarantee it.'),
    jsonb_build_object('id','C','text','There exists $c\in(2,7)$ such that $f(c)=0$.','explanation','Correct: $0$ is between $-3$ and $5$, and continuity on $[2,7]$ guarantees some $c$ with $f(c)=0$.'),
    jsonb_build_object('id','D','text','$f$ must be increasing on $[2,7]$.','explanation','IVT does not imply monotonicity.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $f$ is continuous on $[2,7]$ and $0$ lies between $f(2)=-3$ and $f(7)=5$, the Intermediate Value Theorem guarantees a value $c\in(2,7)$ such that $f(c)=0$.',
  recommendation_reasons = ARRAY[
    'Reinforces the basic IVT guarantee: continuous functions hit all intermediate $y$-values.',
    'Targets common overclaims (values outside the endpoint range and monotonicity).'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'IVT existence of a root via sign change across endpoints.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.16-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  section_id = '1.16',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_IVT_APPLICATION','SK_EQUATION_SETUP'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_EQUATION_SETUP'],
  error_tags = ARRAY['E_IVT_CONDITIONS_MISUSED','E_IVT_DOMAIN_MISREAD'],
  prompt = 'Let $f(x)=x^3-6x+1$. Use the Intermediate Value Theorem to justify that there is a solution to $f(x)=-2$ in the interval $(0,1)$. Which calculation correctly supports the conclusion?',
  latex = 'Let $f(x)=x^3-6x+1$. Use the Intermediate Value Theorem to justify that there is a solution to $f(x)=-2$ in the interval $(0,1)$. Which calculation correctly supports the conclusion?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f(0)=1$ and $f(1)=-4$, so there is a solution to $f(x)=2$.','explanation','This targets the wrong value; IVT requires $-2$ to lie between the endpoint outputs.'),
    jsonb_build_object('id','B','text','$f(0)=1$ and $f(1)=-4$, so there is a solution to $f(x)=0$.','explanation','That conclusion is true, but it is not the target equation $f(x)=-2$.'),
    jsonb_build_object('id','C','text','$f(0)=-2$ and $f(1)=2$, so there is a solution to $f(x)=-2$.','explanation','These endpoint values are incorrect for this function.'),
    jsonb_build_object('id','D','text','Let $g(x)=f(x)+2$. Then $g(0)=3$ and $g(1)=-2$, so there exists $c\in(0,1)$ with $g(c)=0$, i.e., $f(c)=-2$.','explanation','Correct: $g$ is continuous and changes sign on $(0,1)$, so IVT guarantees a root of $g$, which corresponds to $f(x)=-2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Define $g(x)=f(x)+2$. Since $f$ is a polynomial, $g$ is continuous on $[0,1]$.
Compute:
$$g(0)=f(0)+2=(1)+2=3,\quad g(1)=f(1)+2=(-4)+2=-2.$$
Because $g(0)>0$ and $g(1)<0$, IVT guarantees a $c\in(0,1)$ with $g(c)=0$, so $f(c)=-2$.',
  recommendation_reasons = ARRAY[
    'Builds correct IVT framing for equations of the form $f(x)=k$ via shifting.',
    'Targets the common mistake of proving existence for the wrong target value.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'IVT setup for $f(x)=k$ using a shifted function $f(x)-k$ (or $f(x)+2$ here).',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.16-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  section_id = '1.16',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_IVT_APPLICATION','SK_GRAPH_INTERPRETATION_LIMITS'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_GRAPH_INTERPRETATION_LIMITS'],
  error_tags = ARRAY['E_IVT_DOMAIN_MISREAD','E_IVT_CONDITIONS_MISUSED'],
  prompt = 'A continuous function $y=f(x)$ is graphed, and the line $y=2$ is shown.
See image: 1.16-P3.png
Which statement is guaranteed by the Intermediate Value Theorem?',
  latex = 'A continuous function $y=f(x)$ is graphed, and the line $y=2$ is shown.
See image: 1.16-P3.png
Which statement is guaranteed by the Intermediate Value Theorem?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c$ such that $f(c)=2$.','explanation','Correct: the graph shows the continuous curve crossing $y=2$, so on an interval bracketing a crossing, IVT guarantees a $c$ with $f(c)=2$.'),
    jsonb_build_object('id','B','text','There exists $c$ such that $f(c)=5$.','explanation','IVT requires a specified interval whose endpoint values bracket $5$; this is not guaranteed here.'),
    jsonb_build_object('id','C','text','There exists $c$ such that $f(c)=0$.','explanation','Nothing in the graph guarantees a value of $0$.'),
    jsonb_build_object('id','D','text','$f$ must be differentiable everywhere shown.','explanation','IVT requires continuity, not differentiability.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because the curve is continuous and it crosses the horizontal line $y=2$, there is at least one point $c$ where $f(c)=2$. IVT justifies existence on any interval whose endpoints have function values on opposite sides of $2$.',
  recommendation_reasons = ARRAY[
    'Connects visual “crossing” behavior to the formal IVT guarantee.',
    'Reinforces that IVT is about $y$-values, not differentiability.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based IVT: guaranteed intermediate $y$-value on a continuous curve.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.16-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  section_id = '1.16',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_FUNCTION_CONTINUITY_CHECK','SK_IVT_APPLICATION','SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_FUNCTION_CONTINUITY_CHECK',
  supporting_skill_ids = ARRAY['SK_IVT_APPLICATION', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  error_tags = ARRAY['E_CONTINUITY_ASSUMPTION','E_IVT_CONDITIONS_MISUSED'],
  prompt = 'Consider $$h(x)=\frac{x^2-9}{x-3}.$$ Which statement is correct about using the Intermediate Value Theorem to guarantee a solution to $h(x)=4$ on the interval $[2,5]$?',
  latex = 'Consider $$h(x)=\frac{x^2-9}{x-3}.$$ Which statement is correct about using the Intermediate Value Theorem to guarantee a solution to $h(x)=4$ on the interval $[2,5]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','IVT applies on $[2,5]$ because $h$ is a rational function.','explanation','Rational functions are not continuous where the denominator is $0$; here $x=3$ is in $[2,5]$.'),
    jsonb_build_object('id','B','text','IVT does not apply on $[2,5]$ because $h$ is not continuous on $[2,5]$.','explanation','Correct: $h$ is undefined at $x=3$, which lies in the interval, so $h$ is not continuous on $[2,5]$.'),
    jsonb_build_object('id','C','text','IVT applies on $[2,5]$ because $h(x)=x+3$ after simplification.','explanation','Even though $h(x)=x+3$ for $x\ne 3$, the original function still has a discontinuity at $x=3$.'),
    jsonb_build_object('id','D','text','IVT applies on $[2,5]$ only if $h(3)=6$ is defined.','explanation','Defining $h(3)$ would create a different function; as given, $h$ is not continuous on $[2,5]$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'IVT requires continuity on the entire closed interval. The function
$$h(x)=\frac{x^2-9}{x-3}$$
is undefined at $x=3$, and $3\in[2,5]$, so $h$ is not continuous on $[2,5]$. Therefore IVT cannot be applied on that interval to guarantee a solution to $h(x)=4$.',
  recommendation_reasons = ARRAY[
    'Targets a high-frequency IVT mistake: canceling factors does not remove a hole from the original function.',
    'Reinforces the “continuous on the whole interval” requirement.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity condition check for IVT on a closed interval.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.16-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.16',
  section_id = '1.16',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_FUNCTION_CONTINUITY_CHECK','SK_IVT_APPLICATION','SK_GRAPH_INTERPRETATION_LIMITS'],
  primary_skill_id = 'SK_FUNCTION_CONTINUITY_CHECK',
  supporting_skill_ids = ARRAY['SK_IVT_APPLICATION', 'SK_GRAPH_INTERPRETATION_LIMITS'],
  error_tags = ARRAY['E_CONTINUITY_ASSUMPTION','E_IVT_CONDITIONS_MISUSED'],
  prompt = 'A graph of $y=g(x)$ is shown.
See image: 1.16-P5.png
Which statement is correct?',
  latex = 'A graph of $y=g(x)$ is shown.
See image: 1.16-P5.png
Which statement is correct?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','IVT guarantees that $g(x)$ takes every value between $0$ and $2$ on $[0,4]$.','explanation','There is a discontinuity at $x=2$, so IVT cannot be applied on $[0,4]$.'),
    jsonb_build_object('id','B','text','$g$ is continuous on $[0,4]$ because the left and right sides approach the same value at $x=2$.','explanation','A hole means $g(2)$ is not defined, so the function is not continuous at $x=2$.'),
    jsonb_build_object('id','C','text','IVT cannot be used on $[0,4]$ because $g$ is not continuous on that interval.','explanation','Correct: the hole at $x=2$ breaks continuity on the interval.'),
    jsonb_build_object('id','D','text','IVT guarantees there exists $c\in(0,4)$ such that $g(c)=1$.','explanation','Even if $g(x)=1$ occurs, IVT on $[0,4]$ is not a valid justification when continuity fails.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The graph shows a removable discontinuity (a hole) at $x=2$. Since $g$ is not continuous on $[0,4]$, the Intermediate Value Theorem cannot be applied on that interval.',
  recommendation_reasons = ARRAY[
    'Builds the habit: verify continuity on the entire interval before invoking IVT.',
    'Targets the common error of assuming a “nice-looking” graph is continuous.'
  ],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based continuity check; IVT non-applicability due to a hole.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.16-P5';
