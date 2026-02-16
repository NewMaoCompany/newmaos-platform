
-- Unit 1.13 (Removing Discontinuities) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_REMOVABLE_DISCONTINUITY', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_REMOVABLE_DISCONTINUITY',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION'],
  error_tags = ARRAY['E_CANCEL_FACTOR_WITHOUT_DOMAIN', 'E_LIMIT_EQUALS_VALUE', 'E_DOMAIN_RESTRICTION_IGNORED'],
  prompt = 'Let
$$f(x)=\frac{x^2-9}{x-3}$$
for $x\ne 3$. Which value of $f(3)$ makes $f$ continuous at $x=3$?',
  latex = 'Let
$$f(x)=\frac{x^2-9}{x-3}$$
for $x\ne 3$. Which value of $f(3)$ makes $f$ continuous at $x=3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','After simplifying for $x\\ne 3$, the expression becomes $x+3$, not $x$.'),
    jsonb_build_object('id','B','text','$0$','explanation','Continuity requires $f(3)$ to equal the limit as $x\\to 3$, not an arbitrary value.'),
    jsonb_build_object('id','C','text','$6$','explanation','Correct: $\\frac{x^2-9}{x-3}=x+3$ for $x\\ne 3$, so the limit as $x\\to 3$ is $6$.'),
    jsonb_build_object('id','D','text','No value works','explanation','A removable discontinuity can be removed by defining the point value to match the limit.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Factor $x^2-9=(x-3)(x+3)$. For $x\\ne 3$, $f(x)=x+3$, so
$$\lim_{x\\to 3} f(x)=3+3=6.$$
Define $f(3)=6$ to make $f$ continuous at $x=3$.',
  recommendation_reasons = ARRAY['Practice removing a removable discontinuity by defining the function value to match the limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: fill the hole by matching $f(a)$ to $\\lim_{x\\to a} f(x)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.13-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_CONTINUITY_PARAMETER', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_CONTINUITY_PARAMETER',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION'],
  error_tags = ARRAY['E_LIMIT_EQUALS_VALUE', 'E_ONE_SIDED_LIMIT_NOT_CHECKED', 'E_ALGEBRA_SIMPLIFY_ERROR'],
  prompt = 'Define
$$g(x)=\begin{cases}
\frac{x^2-1}{x-1}, & x\ne 1 \\
k, & x=1
\end{cases}$$
Which value of $k$ makes $g$ continuous at $x=1$?',
  latex = 'Define
$$g(x)=\begin{cases}
\frac{x^2-1}{x-1}, & x\ne 1 \\
k, & x=1
\end{cases}$$
Which value of $k$ makes $g$ continuous at $x=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The limit as $x\\to 1$ is not $0$.'),
    jsonb_build_object('id','B','text','$2$','explanation','Correct: for $x\\ne 1$, $\\frac{x^2-1}{x-1}=x+1$, so the limiting value at $1$ is $2$.'),
    jsonb_build_object('id','C','text','$1$','explanation','Continuity requires matching the function value to the limit, not to the input $x=1$.'),
    jsonb_build_object('id','D','text','No such $k$','explanation','This is a removable discontinuity, so a suitable $k$ exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Factor $x^2-1=(x-1)(x+1)$. For $x\\ne 1$, $g(x)=x+1$, so
$$\lim_{x\\to 1} g(x)=2.$$
Continuity at $x=1$ requires $k=2$.',
  recommendation_reasons = ARRAY['Reinforces the continuity condition $\\lim_{x\\to a} g(x)=g(a)$ for piecewise definitions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: choose the point value to remove a hole.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.13-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION', 'SK_REMOVABLE_DISCONTINUITY'],
  primary_skill_id = 'SK_ALGEBRAIC_SIMPLIFICATION',
  supporting_skill_ids = ARRAY['SK_REMOVABLE_DISCONTINUITY'],
  error_tags = ARRAY['E_CANCEL_FACTOR_WITHOUT_DOMAIN', 'E_ALGEBRA_SIMPLIFY_ERROR', 'E_DOMAIN_RESTRICTION_IGNORED'],
  prompt = 'Evaluate
$$\lim_{x\to -2}\frac{x^2+5x+6}{x+2}.$$',
  latex = 'Evaluate
$$\lim_{x\to -2}\frac{x^2+5x+6}{x+2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-2$','explanation','This typically comes from substituting $x=-2$ too early or from an incorrect cancellation.'),
    jsonb_build_object('id','B','text','$-1$','explanation','This is a sign/arithmetic slip after simplifying to $x+3$.'),
    jsonb_build_object('id','C','text','$1$','explanation','Correct: $x^2+5x+6=(x+2)(x+3)$, so the expression simplifies to $x+3$ and the limit is $1$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Although the expression is undefined at $x=-2$, the limit exists after simplification.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Factor $x^2+5x+6=(x+2)(x+3)$. For $x\\ne -2$,
$$\frac{x^2+5x+6}{x+2}=x+3.$$
Thus
$$\lim_{x\\to -2}(x+3)=1.$$',
  recommendation_reasons = ARRAY['Builds the habit: simplify first to remove a removable discontinuity, then substitute.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: factoring and canceling to evaluate a limit at a hole.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.13-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_CONTINUITY_PARAMETER', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_CONTINUITY_PARAMETER',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION'],
  error_tags = ARRAY['E_ONE_SIDED_LIMIT_NOT_CHECKED', 'E_ALGEBRA_SIMPLIFY_ERROR', 'E_LIMIT_EQUALS_VALUE'],
  prompt = 'Let
$$h(x)=\begin{cases}
\frac{x^2-4}{x-2}, & x<2 \\
ax+b, & x\ge 2
\end{cases}$$
If $h$ is continuous at $x=2$ and $h(3)=7$, what are $a$ and $b$?',
  latex = 'Let
$$h(x)=\begin{cases}
\frac{x^2-4}{x-2}, & x<2 \\
ax+b, & x\ge 2
\end{cases}$$
If $h$ is continuous at $x=2$ and $h(3)=7$, what are $a$ and $b$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$a=1,\\ b=4$','explanation','This makes $h(2)=6$ and does not satisfy continuity at $x=2$.'),
    jsonb_build_object('id','B','text','$a=3,\\ b=-2$','explanation','Correct: continuity gives $2a+b=4$ and $h(3)=7$ gives $3a+b=7$; solving yields $a=3$, $b=-2$.'),
    jsonb_build_object('id','C','text','$a=2,\\ b=0$','explanation','This gives $h(2)=4$ but $h(3)=6$, not $7$.'),
    jsonb_build_object('id','D','text','$a=0,\\ b=4$','explanation','This gives $h(3)=4$, not $7$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $x<2$,
$$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2\quad(x\\ne 2),$$
so $\lim_{x\\to 2^-} h(x)=4$. Continuity at $x=2$ uses the right branch, so
$$h(2)=2a+b=4.$$
Also $h(3)=3a+b=7$. Subtract to get $a=3$, then $2(3)+b=4$ gives $b=-2$.',
  recommendation_reasons = ARRAY['Combines removable-discontinuity limits with parameter constraints from continuity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: continuity condition creates an equation; additional point creates a second equation.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.13-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.13',
  section_id = '1.13',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION', 'SK_REMOVABLE_DISCONTINUITY'],
  primary_skill_id = 'SK_ALGEBRAIC_SIMPLIFICATION',
  supporting_skill_ids = ARRAY['SK_REMOVABLE_DISCONTINUITY'],
  error_tags = ARRAY['E_ALGEBRA_SIMPLIFY_ERROR', 'E_LIMIT_EQUALS_VALUE', 'E_INDETERMINATE_FORM_STOP'],
  prompt = 'Evaluate
$$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
  latex = 'Evaluate
$$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\frac{3}{2}$','explanation','Correct: rationalizing yields $\\frac{3}{\\sqrt{1+3x}+1}\\to \\frac{3}{2}$.'),
    jsonb_build_object('id','B','text','$3$','explanation','This drops the factor $\\sqrt{1+3x}+1$ after rationalizing.'),
    jsonb_build_object('id','C','text','$0$','explanation','This comes from substituting directly into the indeterminate form $0/0$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','After algebraic manipulation, the limit exists and is finite.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Rationalize:
$$\frac{\sqrt{1+3x}-1}{x}\cdot\frac{\sqrt{1+3x}+1}{\sqrt{1+3x}+1}
=\frac{(1+3x)-1}{x(\sqrt{1+3x}+1)}
=\frac{3}{\sqrt{1+3x}+1}.$$
As $x\\to 0$, this approaches $\frac{3}{2}$.',
  recommendation_reasons = ARRAY['Strengthens the conjugate method to remove an indeterminate form and evaluate a limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: conjugate/rationalization technique.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.13-P5';



-- Unit 1.14 (Connecting Infinite Limits and Vertical Asymptotes) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_INFINITE_LIMITS_VA', 'SK_ONE_SIDED_SIGN_ANALYSIS'],
  primary_skill_id = 'SK_INFINITE_LIMITS_VA',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_SIGN_ANALYSIS'],
  error_tags = ARRAY['E_VA_SIGN_ERROR', 'E_ONE_SIDED_LIMIT_NOT_CHECKED', 'E_SUBSTITUTE_INTO_ZERO_DENOM'],
  prompt = 'Evaluate
$$\lim_{x\to 2^+}\frac{5}{x-2}.$$',
  latex = 'Evaluate
$$\lim_{x\to 2^+}\frac{5}{x-2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$+\\infty$','explanation','Correct: as $x\\to 2^+$, $x-2\\to 0^+$ so the quotient grows without bound.'),
    jsonb_build_object('id','B','text','$-\\infty$','explanation','That occurs for $x\\to 2^-$, where $x-2\\to 0^-$.'),
    jsonb_build_object('id','C','text','$0$','explanation','A denominator approaching $0$ does not force the expression to approach $0$; here it becomes unbounded.'),
    jsonb_build_object('id','D','text','$5$','explanation','Direct substitution is invalid because the expression is undefined at $x=2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'As $x\\to 2^+$, the denominator $x-2\\to 0^+$, so
$$\frac{5}{x-2}\\to +\\infty.$$',
  recommendation_reasons = ARRAY['Builds one-sided sign analysis for infinite limits and vertical asymptotes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: right-hand infinite limit.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.14-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 130,
  skill_tags = ARRAY['SK_INFINITE_LIMITS_VA', 'SK_ONE_SIDED_SIGN_ANALYSIS', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  primary_skill_id = 'SK_INFINITE_LIMITS_VA',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_SIGN_ANALYSIS', 'SK_ALGEBRAIC_SIMPLIFICATION'],
  error_tags = ARRAY['E_HOLE_VS_ASYMPTOTE', 'E_VA_SIGN_ERROR', 'E_CANCEL_FACTOR_WITHOUT_DOMAIN'],
  prompt = 'Let
$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}.$$
Which statement is true?',
  latex = 'Let
$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}.$$
Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=1$ is a removable discontinuity (a hole)','explanation','One $(x-1)$ cancels but one remains in the denominator, so the discontinuity is not removable.'),
    jsonb_build_object('id','B','text','$\\lim_{x\\to 1}p(x)$ is finite','explanation','After simplification to $\\frac{x+2}{x-1}$, the denominator still goes to $0$ at $x=1$, so the behavior is unbounded.'),
    jsonb_build_object('id','C','text','$x=1$ is a vertical asymptote and $\\lim_{x\\to 1^+}p(x)=+\\infty$','explanation','Correct: $p(x)=\\frac{x+2}{x-1}$ for $x\\ne 1$, and as $x\\to 1^+$ the denominator $\\to 0^+$ while the numerator $\\to 3>0$.'),
    jsonb_build_object('id','D','text','$x=-2$ is a vertical asymptote','explanation','At $x=-2$, the numerator is $0$ and the denominator is not, so it is an $x$-intercept, not an asymptote.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Cancel one factor:
$$p(x)=\frac{(x-1)(x+2)}{(x-1)^2}=\frac{x+2}{x-1}\quad(x\\ne 1).$$
The denominator still approaches $0$ at $x=1$, so there is a vertical asymptote at $x=1$. For $x\\to 1^+$, $x-1\\to 0^+$ and $x+2\\to 3$, hence $p(x)\\to +\\infty$.',
  recommendation_reasons = ARRAY['Targets the common confusion: partial cancellation can leave a vertical asymptote (not a hole).'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: hole vs vertical asymptote after cancellation + one-sided behavior.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.14-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_ONE_SIDED_SIGN_ANALYSIS', 'SK_INFINITE_LIMITS_VA'],
  primary_skill_id = 'SK_ONE_SIDED_SIGN_ANALYSIS',
  supporting_skill_ids = ARRAY['SK_INFINITE_LIMITS_VA'],
  error_tags = ARRAY['E_VA_SIGN_ERROR', 'E_ONE_SIDED_LIMIT_NOT_CHECKED', 'E_INFINITY_MEANS_DNE'],
  prompt = 'Evaluate
$$\lim_{x\to -3^-}\frac{2}{(x+3)^3}.$$',
  latex = 'Evaluate
$$\lim_{x\to -3^-}\frac{2}{(x+3)^3}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$+\\infty$','explanation','For $x\\to -3^-$, $(x+3)$ is negative and an odd power stays negative, so the quotient is negative unbounded.'),
    jsonb_build_object('id','B','text','$-\\infty$','explanation','Correct: $(x+3)^3\\to 0^-$, so $\\frac{2}{(x+3)^3}\\to -\\infty$.'),
    jsonb_build_object('id','C','text','$0$','explanation','Near a vertical asymptote the function becomes unbounded, not $0$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The limit exists as an infinite limit ($-\\infty$).')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'As $x\\to -3^-$, $x+3\\to 0^-$, so $(x+3)^3\\to 0^-$. Therefore
$$\frac{2}{(x+3)^3}\\to -\\infty.$$',
  recommendation_reasons = ARRAY['Strengthens sign reasoning for odd powers near vertical asymptotes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: left-hand infinite limit with odd power denominator.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.14-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 160,
  skill_tags = ARRAY['SK_RATIONAL_VA_HOLE_ANALYSIS', 'SK_ALGEBRAIC_SIMPLIFICATION', 'SK_INFINITE_LIMITS_VA'],
  primary_skill_id = 'SK_RATIONAL_VA_HOLE_ANALYSIS',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_SIMPLIFICATION', 'SK_INFINITE_LIMITS_VA'],
  error_tags = ARRAY['E_HOLE_VS_ASYMPTOTE', 'E_CANCEL_FACTOR_WITHOUT_DOMAIN', 'E_VA_SIGN_ERROR'],
  prompt = 'For
$$q(x)=\frac{x^2-4x+3}{x^2-5x+6},$$
which $x$-value is a vertical asymptote of $q$?',
  latex = 'For
$$q(x)=\frac{x^2-4x+3}{x^2-5x+6},$$
which $x$-value is a vertical asymptote of $q$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=2$','explanation','Correct: after factoring and canceling, the remaining denominator has $(x-2)$, giving a vertical asymptote at $x=2$.'),
    jsonb_build_object('id','B','text','$x=3$','explanation','The factor $(x-3)$ cancels, so $x=3$ is a hole (removable discontinuity), not a vertical asymptote.'),
    jsonb_build_object('id','C','text','$x=1$','explanation','$x=1$ is a zero of the numerator, not a zero of the uncanceled denominator.'),
    jsonb_build_object('id','D','text','No vertical asymptotes','explanation','There is a vertical asymptote at the uncanceled denominator zero.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Factor:
$$x^2-4x+3=(x-1)(x-3),\quad x^2-5x+6=(x-2)(x-3).$$
Then for $x\\ne 3$,
$$q(x)=\frac{(x-1)(x-3)}{(x-2)(x-3)}=\frac{x-1}{x-2}.$$
The canceled factor creates a hole at $x=3$, while the remaining denominator zero gives a vertical asymptote at $x=2$.',
  recommendation_reasons = ARRAY['Separates removable discontinuities (holes) from vertical asymptotes via factoring/cancellation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 5,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify VA vs hole from factored form.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.14-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.14',
  section_id = '1.14',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_INFINITE_LIMITS_VA', 'SK_ONE_SIDED_SIGN_ANALYSIS'],
  primary_skill_id = 'SK_INFINITE_LIMITS_VA',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_SIGN_ANALYSIS'],
  error_tags = ARRAY['E_VA_SIGN_ERROR', 'E_INFINITY_MEANS_DNE', 'E_SUBSTITUTE_INTO_ZERO_DENOM'],
  prompt = 'Evaluate
$$\lim_{x\to 4}\frac{x+1}{(x-4)^2}.$$',
  latex = 'Evaluate
$$\lim_{x\to 4}\frac{x+1}{(x-4)^2}.$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$-\\infty$','explanation','Because $(x-4)^2\\to 0^+$ from both sides and $x+1\\to 5>0$, the expression cannot go to $-\\infty$.'),
    jsonb_build_object('id','B','text','$+\\infty$','explanation','Correct: positive numerator near $4$ divided by a square approaching $0^+$ grows to $+\\infty$.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','The expression approaches $+\\infty$ from both sides; that is an infinite limit.'),
    jsonb_build_object('id','D','text','$5$','explanation','Direct substitution fails because the denominator becomes $0$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'As $x\\to 4$, $x+1\\to 5>0$ and $(x-4)^2\\to 0^+$ (from both sides). Therefore
$$\frac{x+1}{(x-4)^2}\\to +\\infty.$$',
  recommendation_reasons = ARRAY['Highlights that even powers in the denominator force the same sign ($0^+$) from both sides.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: two-sided infinite limit with squared denominator.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.14-P5';
