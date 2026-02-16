
-- Unit 1.11 (Defining Continuity at a Point) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.11',
  section_id = '1.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_CONTINUITY_AT_A_POINT'],
  primary_skill_id = 'SK_CONTINUITY_AT_A_POINT',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_CONFUSE_LIMIT_WITH_VALUE','E_IGNORE_FUNCTION_VALUE'],
  prompt = 'Let $$f(x)=\begin{cases}x^2-1,& x\ne 1\\3,& x=1\end{cases}$$ Which statement is true about continuity at $x=1$?',
  latex = 'Let $$f(x)=\begin{cases}x^2-1,& x\ne 1\\3,& x=1\end{cases}$$ Which statement is true about continuity at $x=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ is continuous at $x=1$ because $f(1)$ exists.','explanation','Having $f(1)$ exist is only one requirement; the limit must also exist and equal $f(1)$.'),
    jsonb_build_object('id','B','text','$f$ is not continuous at $x=1$ because $\lim_{x\to 1} f(x)\ne f(1)$.','explanation','Correct: $\lim_{x\to 1}(x^2-1)=0$ but $f(1)=3$, so they are not equal.'),
    jsonb_build_object('id','C','text','$f$ is continuous at $x=1$ because $\lim_{x\to 1} f(x)$ exists.','explanation','The limit existing is not enough; it must equal $f(1)$.'),
    jsonb_build_object('id','D','text','$f$ is not continuous at $x=1$ because $\lim_{x\to 1} f(x)$ does not exist.','explanation','The limit does exist (it equals $0$). The failure is that it does not match $f(1)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Continuity at $x=1$ requires $f(1)$ exists, $\lim_{x\to 1}f(x)$ exists, and $\lim_{x\to 1}f(x)=f(1)$. Here $\lim_{x\to 1}f(x)=\lim_{x\to 1}(x^2-1)=0$ while $f(1)=3$, so $f$ is not continuous at $x=1$.',
  recommendation_reasons = ARRAY['Reinforces the 3-part definition of continuity at a point.','Targets the common mistake of checking only the limit or only the function value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply the 3-part continuity definition and compare limit vs. function value.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.11-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.11',
  section_id = '1.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_CONTINUITY_FROM_GRAPH','SK_ONE_SIDED_LIMITS'],
  primary_skill_id = 'SK_CONTINUITY_FROM_GRAPH',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMITS'],
  error_tags = ARRAY['E_IGNORE_ONE_SIDED','E_CONFUSE_LIMIT_WITH_VALUE'],
  prompt = 'Use the graph (image). At $x=2$, which statement is true?  I. $\lim_{x\to 2} f(x)$ exists.  II. $f(2)$ exists.  III. $f$ is continuous at $x=2$.',
  latex = 'Use the graph (image). At $x=2$, which statement is true?  I. $\lim_{x\to 2} f(x)$ exists.  II. $f(2)$ exists.  III. $f$ is continuous at $x=2$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','I only','explanation','The two-sided limit does not exist because the left- and right-hand limits are different.'),
    jsonb_build_object('id','B','text','I and II only','explanation','Since the two-sided limit does not exist, statement I is false, so this cannot be correct.'),
    jsonb_build_object('id','C','text','II only','explanation','Correct: the graph has a filled point at $x=2$ so $f(2)$ exists, but the one-sided limits are unequal so the two-sided limit does not exist; therefore not continuous.'),
    jsonb_build_object('id','D','text','I, II, and III','explanation','Continuity would require the two-sided limit to exist and equal $f(2)$, which fails on the graph.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'From the graph, there is a filled point at $x=2$, so $f(2)$ exists. The value approached from the left differs from the value approached from the right, so $\lim_{x\to 2} f(x)$ does not exist. Without the limit, $f$ cannot be continuous at $x=2$.',
  recommendation_reasons = ARRAY['Builds skill in diagnosing continuity using one-sided limits on a graph.','Targets the mistake of assuming continuity because a point is defined.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based continuity at a point: compare one-sided limits and the function value.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.11-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.11',
  section_id = '1.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONTINUITY_AT_A_POINT','SK_ALGEBRAIC_LIMITS'],
  primary_skill_id = 'SK_CONTINUITY_AT_A_POINT',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_LIMITS'],
  error_tags = ARRAY['E_SET_VALUE_INSTEAD_OF_LIMIT','E_SIGN_ALGEBRA'],
  prompt = 'Find the value of $k$ that makes $f$ continuous at $x=3$ if $$f(x)=\begin{cases}\dfrac{x^2-9}{x-3},& x\ne 3\\k,& x=3\end{cases}$$',
  latex = 'Find the value of $k$ that makes $f$ continuous at $x=3$ if $$f(x)=\begin{cases}\dfrac{x^2-9}{x-3},& x\ne 3\\k,& x=3\end{cases}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$k=0$','explanation','This equals $\lim_{x\to 3}(x^2-9)$ if you forget to simplify the fraction first.'),
    jsonb_build_object('id','B','text','$k=9$','explanation','This confuses the limit with $x^2$ evaluated at $3$.'),
    jsonb_build_object('id','C','text','$k$ cannot be chosen to make $f$ continuous at $x=3$.','explanation','The discontinuity is removable; choosing $k$ equal to the limit makes $f$ continuous.'),
    jsonb_build_object('id','D','text','$k=6$','explanation','Correct: for $x\ne 3$, $\dfrac{x^2-9}{x-3}=x+3$, so $\lim_{x\to 3}f(x)=6$; set $k=6$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'For $x\ne 3$, factor $x^2-9=(x-3)(x+3)$, so $f(x)=x+3$. Thus $\lim_{x\to 3}f(x)=6$. Continuity at $x=3$ requires $f(3)=k$ to equal this limit, so $k=6$.',
  recommendation_reasons = ARRAY['Connects removable discontinuities to continuity via redefining a point.','Reinforces simplifying before evaluating a limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Removable discontinuity: set the point value equal to the two-sided limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.11-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.11',
  section_id = '1.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_ONE_SIDED_LIMITS','SK_CONTINUITY_AT_A_POINT'],
  primary_skill_id = 'SK_ONE_SIDED_LIMITS',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_AT_A_POINT'],
  error_tags = ARRAY['E_ASSUME_PIECEWISE_CONTINUITY','E_IGNORE_ONE_SIDED'],
  prompt = 'Let $$f(x)=\begin{cases}2x+1,& x<0\\x^2+1,& x\ge 0\end{cases}$$ Is $f$ continuous at $x=0$?',
  latex = 'Let $$f(x)=\begin{cases}2x+1,& x<0\\x^2+1,& x\ge 0\end{cases}$$ Is $f$ continuous at $x=0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Yes, because $\lim_{x\to 0^-}f(x)=\lim_{x\to 0^+}f(x)=f(0)$.','explanation','Correct: left limit is $2(0)+1=1$, right limit is $0^2+1=1$, and $f(0)=1$.'),
    jsonb_build_object('id','B','text','Yes, because both formulas are polynomials.','explanation','Each piece is continuous on its own interval, but you must also check the boundary point $x=0$.'),
    jsonb_build_object('id','C','text','No, because $f(0)$ does not exist.','explanation','$f(0)$ exists and equals $0^2+1=1$.'),
    jsonb_build_object('id','D','text','No, because the left-hand limit and right-hand limit are different.','explanation','They are the same: both equal $1$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Compute one-sided limits at the junction. As $x\to 0^-$, $f(x)=2x+1\to 1$. As $x\to 0^+$, $f(x)=x^2+1\to 1$. Also $f(0)=1$. Since both one-sided limits match and equal $f(0)$, $f$ is continuous at $0$.',
  recommendation_reasons = ARRAY['Practices continuity at a piecewise junction using one-sided limits.','Targets the misconception that piecewise functions are automatically discontinuous.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity at a junction: left limit = right limit = function value.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.11-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.11',
  section_id = '1.11',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_SOLVE_FOR_PARAMETER','SK_CONTINUITY_AT_A_POINT'],
  primary_skill_id = 'SK_SOLVE_FOR_PARAMETER',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_AT_A_POINT'],
  error_tags = ARRAY['E_FORGET_CONTINUITY_REQUIREMENT','E_SIGN_ALGEBRA'],
  prompt = 'Choose $a$ so that $$f(x)=\begin{cases}ax+1,& x<1\\x^2,& x\ge 1\end{cases}$$ is continuous at $x=1$. What is $a$?',
  latex = 'Choose $a$ so that $$f(x)=\begin{cases}ax+1,& x<1\\x^2,& x\ge 1\end{cases}$$ is continuous at $x=1$. What is $a$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$a=2$','explanation','Then left-hand value at $1$ is $2(1)+1=3$, not $1$.'),
    jsonb_build_object('id','B','text','$a=0$','explanation','Correct: continuity requires $\lim_{x\to 1^-}(ax+1)=f(1)=1^2=1$, so $a+1=1$ and $a=0$.'),
    jsonb_build_object('id','C','text','$a=-1$','explanation','Then left-hand value at $1$ is $0$, not $1$.'),
    jsonb_build_object('id','D','text','$a=1$','explanation','Then left-hand value at $1$ is $2$, not $1$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $f(1)=1^2=1$, continuity at $x=1$ requires $\lim_{x\to 1^-}(ax+1)=1$. The left-hand limit is $a(1)+1=a+1$, so $a+1=1$ and $a=0$.',
  recommendation_reasons = ARRAY['Reinforces parameter solving using continuity at a junction.','Builds fluency with matching a one-sided limit to the function value.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.30,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Solve for a parameter by enforcing limit = function value at the boundary.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.11-P5';



-- Unit 1.12 (Confirming Continuity over an Interval) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.12',
  section_id = '1.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_CONTINUITY_OVER_INTERVAL','SK_DOMAIN_ENDPOINTS'],
  primary_skill_id = 'SK_CONTINUITY_OVER_INTERVAL',
  supporting_skill_ids = ARRAY['SK_DOMAIN_ENDPOINTS'],
  error_tags = ARRAY['E_DOMAIN_ENDPOINTS','E_TREAT_ENDPOINT_AS_TWO_SIDED'],
  prompt = 'Let $g(x)=\sqrt{4-x}$. On which interval is $g$ continuous (as a real-valued function)?',
  latex = 'Let $g(x)=\sqrt{4-x}$. On which interval is $g$ continuous (as a real-valued function)?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\infty,\infty)$','explanation','The square root requires $4-x\ge 0$, so $x\le 4$.'),
    jsonb_build_object('id','B','text','$(-\infty,4)$','explanation','$x=4$ is in the domain and $g$ is continuous from the left there, so excluding 4 is unnecessary.'),
    jsonb_build_object('id','C','text','$(-\infty,4]$','explanation','Correct: the domain is $x\le 4$, and the square root function is continuous on its domain (including the endpoint using one-sided continuity).'),
    jsonb_build_object('id','D','text','$[4,\infty)$','explanation','For $x>4$, $4-x<0$ so $g$ is not real-valued.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'The function $g(x)=\sqrt{4-x}$ is defined when $4-x\ge 0$, i.e., $x\le 4$. Since $\sqrt{\cdot}$ and linear functions are continuous where defined, $g$ is continuous on $(-\infty,4]$ (with one-sided continuity at the endpoint).',
  recommendation_reasons = ARRAY['Reinforces continuity on an interval as continuity on the domain.','Targets endpoint handling for radical functions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity over an interval depends on domain; endpoints use one-sided continuity within the domain.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.12-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.12',
  section_id = '1.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_SOLVE_FOR_PARAMETER','SK_CONTINUITY_OVER_INTERVAL'],
  primary_skill_id = 'SK_SOLVE_FOR_PARAMETER',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_OVER_INTERVAL'],
  error_tags = ARRAY['E_FORGET_CONTINUITY_REQUIREMENT','E_SIGN_ALGEBRA'],
  prompt = 'Choose $k$ so that $$h(x)=\begin{cases}kx+2,& x\le 2\\x^2-2,& x>2\end{cases}$$ is continuous for all real $x$. What is $k$?',
  latex = 'Choose $k$ so that $$h(x)=\begin{cases}kx+2,& x\le 2\\x^2-2,& x>2\end{cases}$$ is continuous for all real $x$. What is $k$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$k=0$','explanation','Correct: continuity at $x=2$ requires $2k+2=2^2-2=2$, so $k=0$.'),
    jsonb_build_object('id','B','text','$k=1$','explanation','Then $h(2)=4$ while the right-hand limit is $2$.'),
    jsonb_build_object('id','C','text','$k=-1$','explanation','Then $h(2)=0$ while the right-hand limit is $2$.'),
    jsonb_build_object('id','D','text','$k=2$','explanation','Then $h(2)=6$ while the right-hand limit is $2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The only possible discontinuity is at the split point $x=2$. Continuity requires $h(2)=\lim_{x\to 2^+}(x^2-2)$. Since $h(2)=2k+2$ and the right-hand value is $2^2-2=2$, set $2k+2=2$, giving $k=0$.',
  recommendation_reasons = ARRAY['Checks interval continuity by focusing on the single junction where continuity could fail.','Targets the error of not matching the branch values at the boundary.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity on all real numbers: enforce matching at the piecewise boundary.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.12-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.12',
  section_id = '1.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONTINUITY_OVER_INTERVAL','SK_CONTINUITY_FROM_GRAPH'],
  primary_skill_id = 'SK_CONTINUITY_OVER_INTERVAL',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_FROM_GRAPH'],
  error_tags = ARRAY['E_MISS_HOLE_ON_GRAPH','E_ASSUME_CONTINUITY'],
  prompt = 'Use the graph (image). On which set is $f$ continuous?',
  latex = 'Use the graph (image). On which set is $f$ continuous?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$[0,4]$','explanation','The graph is not continuous at $x=1$, so it cannot be continuous on the entire interval.'),
    jsonb_build_object('id','B','text','$[0,1]$','explanation','Including $x=1$ breaks continuity because the limit behavior and the defined value do not match at $x=1$.'),
    jsonb_build_object('id','C','text','$(1,4]$','explanation','This is a subset of where $f$ is continuous, but it misses the left interval $[0,1)$.'),
    jsonb_build_object('id','D','text','$[0,1)\cup(1,4]$','explanation','Correct: the only discontinuity shown is at $x=1$, so excluding 1 yields continuity on the remaining pieces.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'The graph shows a discontinuity at $x=1$ (the approached value(s) at $x=1$ do not agree with the function value). On each side of $1$, the graph is unbroken. Therefore $f$ is continuous on $[0,1)\cup(1,4]$.',
  recommendation_reasons = ARRAY['Practices identifying continuity intervals directly from a graph.','Targets the mistake of ignoring a single discontinuity inside an interval.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based interval continuity: exclude the interior discontinuity point; endpoints use one-sided continuity.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.12-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.12',
  section_id = '1.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_CONTINUITY_OVER_INTERVAL'],
  primary_skill_id = 'SK_CONTINUITY_OVER_INTERVAL',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_ASSUME_RATIONAL_ALWAYS_CONTINUOUS','E_DOMAIN_ENDPOINTS'],
  prompt = 'For what set of $x$-values is $$p(x)=\dfrac{1}{(x-2)(x+5)}$$ continuous?',
  latex = 'For what set of $x$-values is $$p(x)=\dfrac{1}{(x-2)(x+5)}$$ continuous?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','All real numbers','explanation','The function is not defined where the denominator is $0$.'),
    jsonb_build_object('id','B','text','$(-\infty,-5)\cup(-5,2)\cup(2,\infty)$','explanation','Correct: rational functions are continuous on their domain; exclude $x=-5$ and $x=2$.'),
    jsonb_build_object('id','C','text','$(-5,2)$ only','explanation','It is also continuous on $(-\infty,-5)$ and $(2,\infty)$.'),
    jsonb_build_object('id','D','text','$[-5,2]$','explanation','This includes points where the function is undefined, so it cannot be continuous there.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'A rational function is continuous everywhere it is defined. The denominator $(x-2)(x+5)=0$ at $x=2$ and $x=-5$, so $p$ is continuous on $(-\infty,-5)\cup(-5,2)\cup(2,\infty)$.',
  recommendation_reasons = ARRAY['Reinforces the rule: rational functions are continuous on their domains.','Targets domain mistakes when describing continuity intervals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity set equals domain for rational functions; exclude denominator zeros.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.12-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.12',
  section_id = '1.12',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 155,
  skill_tags = ARRAY['SK_IVT_APPLICATION','SK_CONTINUITY_OVER_INTERVAL'],
  primary_skill_id = 'SK_IVT_APPLICATION',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_OVER_INTERVAL'],
  error_tags = ARRAY['E_MISAPPLY_IVT','E_FORGET_CONTINUITY_REQUIREMENT'],
  prompt = 'Suppose $f$ is continuous on $[2,6]$, $f(2)=-3$, and $f(6)=5$. Which statement must be true?',
  latex = 'Suppose $f$ is continuous on $[2,6]$, $f(2)=-3$, and $f(6)=5$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c\in(2,6)$ such that $f(c)=6$.','explanation','The IVT guarantees values between $-3$ and $5$, not $6$.'),
    jsonb_build_object('id','B','text','There exists $c\in(2,6)$ such that $f(c)=-4$.','explanation','The IVT only guarantees values between the endpoint outputs; $-4$ is not between $-3$ and $5$.'),
    jsonb_build_object('id','C','text','There exists $c\in(2,6)$ such that $f(c)=0$.','explanation','Correct: $0$ is between $-3$ and $5$, so continuity guarantees some $c$ with $f(c)=0$.'),
    jsonb_build_object('id','D','text','$f$ must be increasing on $[2,6]$.','explanation','The IVT does not imply monotonicity.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'By the Intermediate Value Theorem, if $f$ is continuous on $[2,6]$, then for any value $L$ between $f(2)=-3$ and $f(6)=5$, there exists $c\in(2,6)$ such that $f(c)=L$. Since $0$ lies between $-3$ and $5$, there must be some $c$ with $f(c)=0$.',
  recommendation_reasons = ARRAY['Connects continuity on a closed interval to guaranteed solutions via IVT.','Targets the error of choosing a value outside the endpoint range.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.35,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'IVT requires continuity on a closed interval and a target value between endpoint outputs.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.12-P5';
