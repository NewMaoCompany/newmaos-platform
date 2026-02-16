
-- Unit 1 (Limits and Continuity) — Unit Test (1.0-UT-Q1 to 1.0-UT-Q20)

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LIMIT_NOTATION','SK_LIMIT_LAWS'],
  primary_skill_id = 'SK_LIMIT_NOTATION',
  supporting_skill_ids = ARRAY['SK_LIMIT_LAWS'],
  error_tags = ARRAY['E_NOTATION_MISREAD','E_ONE_SIDED_VS_TWO'],
  prompt = 'Evaluate the limit.

$$\lim_{x\to 3}\left(2x^2-5x+1\right)$$',
  latex = 'Evaluate the limit.

$$\lim_{x\to 3}\left(2x^2-5x+1\right)$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','0','explanation','This comes from incorrect arithmetic or dropping terms.'),
    jsonb_build_object('id','B','text','4','explanation','Substitute $x=3$: $2(9)-5(3)+1=18-15+1=4$.'),
    jsonb_build_object('id','C','text','10','explanation','This is $2(9)+1$ but forgetting the $-5(3)$.'),
    jsonb_build_object('id','D','text','-4','explanation','Sign error when evaluating $-5x$ or combining terms.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Polynomials are continuous everywhere, so evaluate by direct substitution:
$$\lim_{x\to 3}(2x^2-5x+1)=2(3^2)-5(3)+1=18-15+1=4.$$',
  recommendation_reasons = ARRAY['Reinforces direct substitution for continuous functions.','Checks careful arithmetic under time pressure.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Limits of continuous functions via direct substitution.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMIT','SK_LIMIT_LAWS'],
  primary_skill_id = 'SK_ALGEBRAIC_LIMIT',
  supporting_skill_ids = ARRAY['SK_LIMIT_LAWS'],
  error_tags = ARRAY['E_ALGEBRA_CANCEL','E_NOTATION_MISREAD'],
  prompt = 'Evaluate the limit.

$$\lim_{x\to 2}\frac{x^2-4}{x-2}$$',
  latex = 'Evaluate the limit.

$$\lim_{x\to 2}\frac{x^2-4}{x-2}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','0','explanation','This is the numerator value at $x=2$, not the simplified limit.'),
    jsonb_build_object('id','B','text','2','explanation','This would be $x$ at $2$, but the simplified expression is $x+2$.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','The original form is $0/0$, which is indeterminate, not automatically DNE.'),
    jsonb_build_object('id','D','text','4','explanation','Factor: $x^2-4=(x-2)(x+2)$, cancel $x-2$, then evaluate $x+2$ at $2$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Rewrite and simplify:
$$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2\quad (x\ne 2).$$
So
$$\lim_{x\to 2}\frac{x^2-4}{x-2}=\lim_{x\to 2}(x+2)=4.$$',
  recommendation_reasons = ARRAY['Targets the classic $0/0$ indeterminate form.','Builds factoring/canceling fluency for limits.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Algebraic simplification (factoring/canceling) for $0/0$ limits.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_GRAPHICAL_LIMIT'],
  primary_skill_id = 'SK_GRAPHICAL_LIMIT',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_ONE_SIDED_VS_TWO','E_ASYMPTOTE_MISREAD'],
  prompt = 'Use the graph in the image.

What is
$$\lim_{x\to 2} f(x)?$$',
  latex = 'Use the graph in the image.

What is
$$\lim_{x\to 2} f(x)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Does not exist','explanation','As $x\to 2^-$, $f(x)\to -\infty$ and as $x\to 2^+$, $f(x)\to +\infty$, so the two-sided limit does not exist.'),
    jsonb_build_object('id','B','text','0','explanation','Confuses the $x$-axis intersection with the limit at $x=2$.'),
    jsonb_build_object('id','C','text','$+\infty$','explanation','That is only the right-hand behavior; two-sided limit requires both sides match.'),
    jsonb_build_object('id','D','text','$-\infty$','explanation','That is only the left-hand behavior; two-sided limit requires both sides match.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'From the graph, there is a vertical asymptote at $x=2$. The function decreases without bound as $x\to 2^-$ and increases without bound as $x\to 2^+$. Since the one-sided behaviors are not equal, the two-sided limit does not exist.',
  recommendation_reasons = ARRAY['Checks correct interpretation of vertical asymptotes.','Forces two-sided vs one-sided distinction from a graph.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based limit with opposite infinite one-sided behavior.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_NUMERICAL_LIMIT'],
  primary_skill_id = 'SK_NUMERICAL_LIMIT',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_DIRECTION_CONFUSION','E_NOTATION_MISREAD'],
  prompt = 'Use the table in the image.

What is the best estimate of
$$\lim_{x\to 2} g(x)?$$',
  latex = 'Use the table in the image.

What is the best estimate of
$$\lim_{x\to 2} g(x)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','3.6','explanation','This uses the value at $x=1.9$ only and ignores values closer to $2$.'),
    jsonb_build_object('id','B','text','3.9','explanation','This uses $x=1.99$ only and ignores the trend from both sides.'),
    jsonb_build_object('id','C','text','4.0','explanation','Values approach $4$ from both sides, so the best estimate is $4.0$.'),
    jsonb_build_object('id','D','text','4.4','explanation','This uses the value at $x=2.1$ which is not very close to $2$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'As $x$ gets closer to $2$ from the left, $g(x)$ is near $4$, and from the right, $g(x)$ is also near $4$. Both sides approach $4$, so the best estimate is $4.0$.',
  recommendation_reasons = ARRAY['Trains reading two-sided trend from a table.','Reinforces that limits depend on approach, not necessarily value at the point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Two-sided numerical evidence from a table near a point.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_LIMIT_LAWS','SK_STRATEGY_SELECTION'],
  primary_skill_id = 'SK_LIMIT_LAWS',
  supporting_skill_ids = ARRAY['SK_STRATEGY_SELECTION'],
  error_tags = ARRAY['E_INFINITY_ARITH','E_NOTATION_MISREAD'],
  prompt = 'Evaluate the limit using limit laws.

$$\lim_{x\to -1}\left(\frac{3}{x+2}+\frac{2x}{x^2+3}\right)$$',
  latex = 'Evaluate the limit using limit laws.

$$\lim_{x\to -1}\left(\frac{3}{x+2}+\frac{2x}{x^2+3}\right)$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{5}{4}$','explanation','Direct substitution gives $3-\frac12=\frac52$, not $\frac54$.'),
    jsonb_build_object('id','B','text','$\frac{5}{2}$','explanation','Direct substitution works since denominators are nonzero at $x=-1$.'),
    jsonb_build_object('id','C','text','$\frac{1}{2}$','explanation','This is only the second term value, missing the first term.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The expression is defined at $x=-1$, so the limit exists.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Both denominators are nonzero at $x=-1$, so substitute:
$$\frac{3}{-1+2}+\frac{2(-1)}{(-1)^2+3}=3-\frac12=\frac{5}{2}.$$',
  recommendation_reasons = ARRAY['Checks denominator-nonzero condition before substituting.','Reinforces combining rational limits via limit laws.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Limit laws with rational expressions where substitution is valid.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q5';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_ALGEBRAIC_LIMIT','SK_STRATEGY_SELECTION'],
  primary_skill_id = 'SK_ALGEBRAIC_LIMIT',
  supporting_skill_ids = ARRAY['SK_STRATEGY_SELECTION'],
  error_tags = ARRAY['E_ALGEBRA_CANCEL','E_NOTATION_MISREAD'],
  prompt = 'Evaluate the limit.

$$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}$$',
  latex = 'Evaluate the limit.

$$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','0','explanation','Direct substitution gives $0/0$, which is indeterminate.'),
    jsonb_build_object('id','B','text','1','explanation','This is a common guess, but the correct limit is $\frac12$.'),
    jsonb_build_object('id','C','text','2','explanation','This comes from an incorrect rationalization step.'),
    jsonb_build_object('id','D','text','$\frac12$','explanation','Rationalize, simplify, then substitute $x=0$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Rationalize:
$$\frac{\sqrt{1+x}-1}{x}\cdot\frac{\sqrt{1+x}+1}{\sqrt{1+x}+1}=\frac{1}{\sqrt{1+x}+1}.$$
Then
$$\lim_{x\to 0}\frac{1}{\sqrt{1+x}+1}=\frac12.$$',
  recommendation_reasons = ARRAY['Core algebraic manipulation limit (rationalization).','Targets the common mistake of stopping at $0/0$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Rationalization to resolve an indeterminate form.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q6';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_STRATEGY_SELECTION','SK_ALGEBRAIC_LIMIT'],
  primary_skill_id = 'SK_STRATEGY_SELECTION',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_LIMIT'],
  error_tags = ARRAY['E_NOTATION_MISREAD','E_ONE_SIDED_VS_TWO'],
  prompt = 'Let
$$f(x)=\begin{cases}
\frac{x^2-1}{x-1},& x\ne 1\\
7,& x=1
\end{cases}$$
Which statement is true?',
  latex = 'Let
$$f(x)=\begin{cases}
\frac{x^2-1}{x-1},& x\ne 1\\
7,& x=1
\end{cases}$$
Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to 1}f(x)=7$','explanation','The limit depends on nearby values, not $f(1)$.'),
    jsonb_build_object('id','B','text','$\lim_{x\to 1}f(x)=2$ but $f(1)=7$','explanation','For $x\ne 1$, $\frac{x^2-1}{x-1}=x+1$, so the limit is $2$ while $f(1)=7$.'),
    jsonb_build_object('id','C','text','$\lim_{x\to 1}f(x)$ does not exist because $f(1)$ is defined differently','explanation','Changing a single point does not prevent the limit from existing.'),
    jsonb_build_object('id','D','text','$\lim_{x\to 1}f(x)=7$ and $f$ is continuous at $x=1$','explanation','Continuity requires $f(1)=\lim_{x\to 1}f(x)$, which is false here.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $x\ne 1$, $\frac{x^2-1}{x-1}=x+1$, so
$$\lim_{x\to 1}f(x)=\lim_{x\to 1}(x+1)=2,$$
but $f(1)=7$. The limit exists; the function is not continuous at $x=1$.',
  recommendation_reasons = ARRAY['Separates $\lim_{x\to a}f(x)$ from $f(a)$.','Checks procedure: simplify first, then evaluate.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Distinguish limit value from function value; simplify a removable form.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q7';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_SQUEEZE_THEOREM'],
  primary_skill_id = 'SK_SQUEEZE_THEOREM',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_SQUEEZE_MISUSE','E_INFINITY_ARITH'],
  prompt = 'Evaluate the limit.

$$\lim_{x\to 0} x^2\sin\left(\frac{1}{x}\right)$$',
  latex = 'Evaluate the limit.

$$\lim_{x\to 0} x^2\sin\left(\frac{1}{x}\right)$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Does not exist','explanation','$\sin(1/x)$ oscillates, but the $x^2$ factor forces the product to $0$.'),
    jsonb_build_object('id','B','text','1','explanation','There is no mechanism pushing the expression to $1$.'),
    jsonb_build_object('id','C','text','0','explanation','Since $-1\le \sin(1/x)\le 1$, then $-x^2\le x^2\sin(1/x)\le x^2$, so the limit is $0$.'),
    jsonb_build_object('id','D','text','-1','explanation','The amplitude shrinks to $0$, so it cannot approach $-1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $-1\le \sin(1/x)\le 1$, multiplying by $x^2\ge 0$ gives
$$-x^2\le x^2\sin(1/x)\le x^2.$$
As $x\to 0$, both bounds go to $0$, so by the Squeeze Theorem the limit is $0$.',
  recommendation_reasons = ARRAY['Canonical squeeze theorem structure.','Targets oscillation-with-damping misconception.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Squeeze theorem with oscillation and shrinking bounds.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q8';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_STRATEGY_SELECTION','SK_NUMERICAL_LIMIT','SK_GRAPHICAL_LIMIT'],
  primary_skill_id = 'SK_STRATEGY_SELECTION',
  supporting_skill_ids = ARRAY['SK_NUMERICAL_LIMIT', 'SK_GRAPHICAL_LIMIT'],
  error_tags = ARRAY['E_DIRECTION_CONFUSION','E_ONE_SIDED_VS_TWO'],
  prompt = 'A student wants to estimate $\lim_{x\to 1} f(x)$.

Which set of $x$-values is most appropriate for a numerical estimate of the limit?',
  latex = 'A student wants to estimate $\lim_{x\to 1} f(x)$.

Which set of $x$-values is most appropriate for a numerical estimate of the limit?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$x=0.5,\ 0.6,\ 0.7,\ 0.8$','explanation','These values approach $1$ only from the left and are not very close to $1$.'),
    jsonb_build_object('id','B','text','$x=1,\ 1,\ 1,\ 1$','explanation','A limit is about nearby values; repeatedly using $x=1$ does not estimate approach behavior.'),
    jsonb_build_object('id','C','text','$x=1.1,\ 1.2,\ 1.3,\ 1.4$','explanation','These values approach $1$ only from the right and are not very close to $1$.'),
    jsonb_build_object('id','D','text','$x=0.9,\ 0.99,\ 0.999,\ 1.001,\ 1.01,\ 1.1$','explanation','These values approach $1$ from both sides and get progressively closer to $1$.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'To estimate a two-sided limit numerically, choose $x$-values that approach the target from both sides and get very close without being exactly equal to the target. Option D satisfies this.',
  recommendation_reasons = ARRAY['Tests strategy selection for numerical limits.','Targets the misconception of plugging in the point.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Choosing effective input values for a two-sided numerical limit estimate.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q9';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  skill_tags = ARRAY['SK_DISCONTINUITY_CLASS','SK_GRAPHICAL_LIMIT'],
  primary_skill_id = 'SK_DISCONTINUITY_CLASS',
  supporting_skill_ids = ARRAY['SK_GRAPHICAL_LIMIT'],
  error_tags = ARRAY['E_ONE_SIDED_VS_TWO','E_CONTINUITY_COND'],
  prompt = 'Use the graph in the image.

At $x=1$, what type of discontinuity does $h(x)$ have?',
  latex = 'Use the graph in the image.

At $x=1$, what type of discontinuity does $h(x)$ have?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Removable discontinuity','explanation','The left- and right-hand limits are not equal, so it is not removable.'),
    jsonb_build_object('id','B','text','Jump discontinuity','explanation','The one-sided limits are finite but unequal, so there is a jump.'),
    jsonb_build_object('id','C','text','Infinite discontinuity','explanation','There is no vertical asymptote behavior here.'),
    jsonb_build_object('id','D','text','No discontinuity (continuous)','explanation','Continuity would require matching one-sided limits and equality with $h(1)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'From the graph, as $x\to 1^-$, $h(x)\to 2$ (open circle). As $x\to 1^+$, $h(x)\to 3$ (right-hand segment). Since the one-sided limits are finite but unequal, the discontinuity is a jump discontinuity.',
  recommendation_reasons = ARRAY['High-frequency discontinuity classification task.','Reinforces one-sided limits as the criterion for jump.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Graph-based classification: jump discontinuity via unequal one-sided limits.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q10';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 125,
  skill_tags = ARRAY['SK_CONTINUITY_POINT','SK_LIMIT_NOTATION'],
  primary_skill_id = 'SK_CONTINUITY_POINT',
  supporting_skill_ids = ARRAY['SK_LIMIT_NOTATION'],
  error_tags = ARRAY['E_CONTINUITY_COND','E_NOTATION_MISREAD'],
  prompt = 'Which condition is NOT required for $f$ to be continuous at $x=a$?',
  latex = 'Which condition is NOT required for $f$ to be continuous at $x=a$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f''(a)$ exists','explanation','Differentiability is stronger than continuity; it is not required for continuity.'),
    jsonb_build_object('id','B','text','$f(a)$ is defined','explanation','This is required.'),
    jsonb_build_object('id','C','text','$\lim_{x\to a} f(x)$ exists','explanation','This is required.'),
    jsonb_build_object('id','D','text','$\lim_{x\to a} f(x)=f(a)$','explanation','This is required.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Continuity at $x=a$ requires: (1) $f(a)$ exists, (2) $\lim_{x\to a}f(x)$ exists, and (3) the limit equals the function value. Differentiability is not required.',
  recommendation_reasons = ARRAY['Definition-level mastery check for continuity.','Targets the common confusion: continuity vs differentiability.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity definition: three conditions; differentiability not required.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q11';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_CONTINUITY_INTERVAL','SK_DISCONTINUITY_CLASS'],
  primary_skill_id = 'SK_CONTINUITY_INTERVAL',
  supporting_skill_ids = ARRAY['SK_DISCONTINUITY_CLASS'],
  error_tags = ARRAY['E_ENDPOINT_INCLUSION','E_CONTINUITY_COND'],
  prompt = 'Let
$$f(x)=\frac{1}{x-3}.$$
On which interval is $f$ continuous?',
  latex = 'Let
$$f(x)=\frac{1}{x-3}.$$
On which interval is $f$ continuous?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\infty,\infty)$','explanation','The function is undefined at $x=3$.'),
    jsonb_build_object('id','B','text','$(-\infty,3]$','explanation','Including $3$ is invalid because $f(3)$ is undefined.'),
    jsonb_build_object('id','C','text','$(-\infty,3)\cup(3,\infty)$','explanation','Rational functions are continuous on their domains; exclude $x=3$.'),
    jsonb_build_object('id','D','text','$[3,\infty)$','explanation','This includes $x=3$ where the function is undefined.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'A rational function is continuous wherever its denominator is nonzero. Here $x-3\ne 0\Rightarrow x\ne 3$, so $f$ is continuous on $(-\infty,3)\cup(3,\infty)$.',
  recommendation_reasons = ARRAY['Tests continuity over intervals via domain analysis.','Targets endpoint inclusion mistakes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Continuity on an interval determined by domain restrictions.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q12';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_REMOVE_REMOVABLE','SK_ALGEBRAIC_LIMIT','SK_CONTINUITY_POINT'],
  primary_skill_id = 'SK_REMOVE_REMOVABLE',
  supporting_skill_ids = ARRAY['SK_ALGEBRAIC_LIMIT', 'SK_CONTINUITY_POINT'],
  error_tags = ARRAY['E_ALGEBRA_CANCEL','E_CONTINUITY_COND'],
  prompt = 'Find the value of $k$ that makes $f$ continuous at $x=2$.

$$f(x)=\begin{cases}
\frac{x^2-4}{x-2},& x\ne 2\\
k,& x=2
\end{cases}$$',
  latex = 'Find the value of $k$ that makes $f$ continuous at $x=2$.

$$f(x)=\begin{cases}
\frac{x^2-4}{x-2},& x\ne 2\\
k,& x=2
\end{cases}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','0','explanation','Continuity requires $k$ equal the limit, not the numerator value.'),
    jsonb_build_object('id','B','text','4','explanation','Simplify to $x+2$, so the limit at $2$ is $4$.'),
    jsonb_build_object('id','C','text','2','explanation','This is the approach value, not the limit value.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The limit exists; you can define $k$ to match it.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'For $x\ne 2$,
$$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2.$$
Thus
$$\lim_{x\to 2}f(x)=4.$$
Continuity at $x=2$ requires $k=4$.',
  recommendation_reasons = ARRAY['Classic removable discontinuity repair problem.','Links algebraic limits to the continuity definition.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Remove a removable discontinuity by defining the point value to match the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q13';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_INFINITE_LIMITS_VA','SK_GRAPHICAL_LIMIT'],
  primary_skill_id = 'SK_INFINITE_LIMITS_VA',
  supporting_skill_ids = ARRAY['SK_GRAPHICAL_LIMIT'],
  error_tags = ARRAY['E_ASYMPTOTE_MISREAD','E_ONE_SIDED_VS_TWO'],
  prompt = 'Let
$$f(x)=\frac{5}{(x-4)^2}.$$
Evaluate
$$\lim_{x\to 4} f(x).$$',
  latex = 'Let
$$f(x)=\frac{5}{(x-4)^2}.$$
Evaluate
$$\lim_{x\to 4} f(x).$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','0','explanation','The denominator goes to $0$, so the fraction does not go to $0$.'),
    jsonb_build_object('id','B','text','$-\infty$','explanation','$(x-4)^2\to 0^+$ and the expression stays positive, so it cannot go to $-\infty$.'),
    jsonb_build_object('id','C','text','$+\infty$','explanation','As $x\to 4$, $(x-4)^2\to 0^+$, so $\frac{5}{(x-4)^2}\to +\infty$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The limit is an infinite limit ($+\infty$), not DNE in the AP convention.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $(x-4)^2\to 0^+$ as $x\to 4$ and the numerator is positive, the quotient increases without bound:
$$\lim_{x\to 4}\frac{5}{(x-4)^2}=+\infty.$$',
  recommendation_reasons = ARRAY['Recognize vertical-asymptote behavior from algebraic form.','Targets sign reasoning with squared denominators.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Infinite limit at a vertical asymptote with squared denominator.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q14';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_LIMITS_INFINITY_HA','SK_LIMIT_LAWS'],
  primary_skill_id = 'SK_LIMITS_INFINITY_HA',
  supporting_skill_ids = ARRAY['SK_LIMIT_LAWS'],
  error_tags = ARRAY['E_INFINITY_ARITH','E_NOTATION_MISREAD'],
  prompt = 'Evaluate the limit.

$$\lim_{x\to \infty}\frac{3x^2-7}{2x^2+5x}$$',
  latex = 'Evaluate the limit.

$$\lim_{x\to \infty}\frac{3x^2-7}{2x^2+5x}$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\frac{3}{2}$','explanation','Divide numerator and denominator by $x^2$; leading coefficients give $\frac{3}{2}$.'),
    jsonb_build_object('id','B','text','$\frac{3}{5}$','explanation','Incorrectly compared $3x^2$ to $5x$ instead of the highest powers.'),
    jsonb_build_object('id','C','text','0','explanation','For equal degrees, the limit is not $0$; it is the ratio of leading coefficients.'),
    jsonb_build_object('id','D','text','$\infty$','explanation','Equal degrees lead to a constant limit, not infinity.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Divide by $x^2$:
$$\frac{3-7/x^2}{2+5/x}\xrightarrow[x\to\infty]{}\frac{3}{2}.$$',
  recommendation_reasons = ARRAY['Core end-behavior limit for rational functions.','Supports horizontal asymptote identification.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Limit at infinity for rational functions with equal degree.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q15';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 170,
  skill_tags = ARRAY['SK_IVT','SK_CONTINUITY_INTERVAL'],
  primary_skill_id = 'SK_IVT',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_INTERVAL'],
  error_tags = ARRAY['E_IVT_MISAPPLY','E_ENDPOINT_INCLUSION'],
  prompt = 'Suppose $f$ is continuous on $[1,5]$, with $f(1)=-2$ and $f(5)=4$. Which statement must be true?',
  latex = 'Suppose $f$ is continuous on $[1,5]$, with $f(1)=-2$ and $f(5)=4$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','There exists $c$ in $(1,5)$ such that $f(c)=0$ and $f''(c)$ exists.','explanation','IVT guarantees a zero, but says nothing about differentiability.'),
    jsonb_build_object('id','B','text','There exists $c$ in $(1,5)$ such that $f(c)=1$ and $f$ is increasing on $[1,5]$.','explanation','IVT can guarantee $f(c)=1$, but not monotonicity.'),
    jsonb_build_object('id','C','text','There exists $c$ in $(1,5)$ such that $f(c)=0$.','explanation','Since $0$ lies between $-2$ and $4$, IVT guarantees a point where $f(c)=0$.'),
    jsonb_build_object('id','D','text','There exists $c$ in $(1,5)$ such that $f(c)=6$.','explanation','IVT only guarantees values between $f(1)$ and $f(5)$; $6$ is not between $-2$ and $4$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'By the Intermediate Value Theorem, if $f$ is continuous on $[1,5]$, then for any value $L$ between $f(1)=-2$ and $f(5)=4$, there exists $c\in(1,5)$ with $f(c)=L$. Since $0$ is between $-2$ and $4$, such a $c$ must exist.',
  recommendation_reasons = ARRAY['High-discrimination IVT question with tempting extra claims.','Reinforces what IVT does and does not guarantee.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'IVT: must-true conclusions vs non-guaranteed extra properties.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q16';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 145,
  skill_tags = ARRAY['SK_DISCONTINUITY_CLASS','SK_CONTINUITY_POINT'],
  primary_skill_id = 'SK_DISCONTINUITY_CLASS',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_POINT'],
  error_tags = ARRAY['E_CONTINUITY_COND','E_ONE_SIDED_VS_TWO'],
  prompt = 'For a function $f$, suppose
$$\lim_{x\to 2^-} f(x)=5\quad\text{and}\quad\lim_{x\to 2^+} f(x)=5,$$
but $f(2)$ is undefined.

Which statement is true?',
  latex = 'For a function $f$, suppose
$$\lim_{x\to 2^-} f(x)=5\quad\text{and}\quad\lim_{x\to 2^+} f(x)=5,$$
but $f(2)$ is undefined.

Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to 2} f(x)$ does not exist.','explanation','If both one-sided limits exist and are equal, the two-sided limit exists.'),
    jsonb_build_object('id','B','text','$f$ is continuous at $x=2$.','explanation','Continuity requires $f(2)$ be defined and equal to the limit.'),
    jsonb_build_object('id','C','text','$x=2$ is a jump discontinuity.','explanation','Jump requires unequal one-sided limits.'),
    jsonb_build_object('id','D','text','$\lim_{x\to 2} f(x)=5$ and the discontinuity is removable.','explanation','The limit exists (equals 5), but the value is missing; defining $f(2)=5$ makes it continuous.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $\lim_{x\to 2^-}f(x)=\lim_{x\to 2^+}f(x)=5$, the two-sided limit exists and equals $5$. Because $f(2)$ is undefined, $f$ is not continuous at $2$, but the discontinuity is removable: defining $f(2)=5$ restores continuity.',
  recommendation_reasons = ARRAY['Connects one-sided limits to two-sided limit existence.','Reinforces removable discontinuity definition.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Equal one-sided limits with missing value implies removable discontinuity.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q17';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 155,
  skill_tags = ARRAY['SK_IVT','SK_CONTINUITY_INTERVAL','SK_GRAPHICAL_LIMIT'],
  primary_skill_id = 'SK_IVT',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_INTERVAL', 'SK_GRAPHICAL_LIMIT'],
  error_tags = ARRAY['E_IVT_MISAPPLY','E_ENDPOINT_INCLUSION'],
  prompt = 'Use the graph in the image.

The function $p(x)$ is continuous on $[0,3]$. Based on the graph, which value is guaranteed to be attained by $p(x)$ for some $c\in(0,3)$?',
  latex = 'Use the graph in the image.

The function $p(x)$ is continuous on $[0,3]$. Based on the graph, which value is guaranteed to be attained by $p(x)$ for some $c\in(0,3)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','-2','explanation','The graph does not show $p(x)$ going down to $-2$ on $[0,3]$.'),
    jsonb_build_object('id','B','text','0','explanation','From the graph, $p(0)<0$ and $p(3)>0$, so by IVT there is a point where $p(c)=0$.'),
    jsonb_build_object('id','C','text','6','explanation','The endpoint values do not bracket 6, so IVT does not guarantee it.'),
    jsonb_build_object('id','D','text','There is not enough information to guarantee any value.','explanation','Continuity plus endpoint values does guarantee intermediate values.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Because $p$ is continuous on $[0,3]$, it satisfies IVT. The graph indicates $p(0)<0$ and $p(3)>0$, so $0$ lies between them. Therefore there must exist $c\in(0,3)$ such that $p(c)=0$.',
  recommendation_reasons = ARRAY['Graph-based IVT application with sign change.','Targets the misconception that IVT requires a formula.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'IVT from a graph: sign change guarantees a root.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q18';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_LIMIT_NOTATION','SK_GRAPHICAL_LIMIT'],
  primary_skill_id = 'SK_LIMIT_NOTATION',
  supporting_skill_ids = ARRAY['SK_GRAPHICAL_LIMIT'],
  error_tags = ARRAY['E_ONE_SIDED_VS_TWO','E_DIRECTION_CONFUSION'],
  prompt = 'If
$$\lim_{x\to 4^-} f(x)=2\quad\text{and}\quad\lim_{x\to 4^+} f(x)=2,$$
then what is
$$\lim_{x\to 4} f(x)?$$',
  latex = 'If
$$\lim_{x\to 4^-} f(x)=2\quad\text{and}\quad\lim_{x\to 4^+} f(x)=2,$$
then what is
$$\lim_{x\to 4} f(x)?$$',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Does not exist','explanation','Equal one-sided limits imply the two-sided limit exists.'),
    jsonb_build_object('id','B','text','4','explanation','Confused the approach value $4$ with the limit value.'),
    jsonb_build_object('id','C','text','2','explanation','When left- and right-hand limits exist and are equal, the two-sided limit equals that common value.'),
    jsonb_build_object('id','D','text','Cannot be determined without knowing $f(4)$','explanation','The limit can be determined from one-sided limits even if $f(4)$ is unknown.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because the one-sided limits exist and are equal, the two-sided limit exists and equals that common value:
$$\lim_{x\to 4} f(x)=2.$$',
  recommendation_reasons = ARRAY['Fast check of the two-sided limit definition.','Targets confusion about needing $f(a)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Two-sided limit exists when one-sided limits match.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q19';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 135,
  skill_tags = ARRAY['SK_STRATEGY_SELECTION','SK_DISCONTINUITY_CLASS','SK_LIMIT_LAWS'],
  primary_skill_id = 'SK_STRATEGY_SELECTION',
  supporting_skill_ids = ARRAY['SK_DISCONTINUITY_CLASS', 'SK_LIMIT_LAWS'],
  error_tags = ARRAY['E_ASYMPTOTE_MISREAD','E_ALGEBRA_CANCEL'],
  prompt = 'Consider
$$f(x)=\frac{x-5}{\sqrt{x-1}}.$$
Which statement about $\lim_{x\to 1^+} f(x)$ is true?',
  latex = 'Consider
$$f(x)=\frac{x-5}{\sqrt{x-1}}.$$
Which statement about $\lim_{x\to 1^+} f(x)$ is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','The limit is $-\infty$.','explanation','As $x\to 1^+$, $x-5\to -4$ and $\sqrt{x-1}\to 0^+$, so the quotient decreases without bound.'),
    jsonb_build_object('id','B','text','The limit is $+\infty$.','explanation','The numerator approaches a negative value, so the quotient is negative and unbounded.'),
    jsonb_build_object('id','C','text','The limit is $-4$.','explanation','This treats the denominator as approaching 1 instead of 0.'),
    jsonb_build_object('id','D','text','The limit does not exist because $x=1$ is not in the domain.','explanation','A limit can exist even if the function is not defined at the point; here the one-sided limit is infinite.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'The domain requires $x\ge 1$, so consider $x\to 1^+$. As $x\to 1^+$,
$$x-5\to -4<0,\quad \sqrt{x-1}\to 0^+.$$
A negative constant divided by a positive number approaching $0$ tends to $-\infty$, so
$$\lim_{x\to 1^+}\frac{x-5}{\sqrt{x-1}}=-\infty.$$',
  recommendation_reasons = ARRAY['Forces one-sided domain reasoning with radicals.','Tests sign analysis for infinite one-sided limits.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'One-sided infinite limit determined by domain restriction and sign.',
  weight_primary = 0.75,
  weight_supporting = 0.25,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.0-UT-Q20';
