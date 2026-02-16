
-- Unit 1.7 (Selecting Procedures for Determining Limits) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.7',
  section_id = '1.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LIMIT_PROCEDURE_SELECT', 'SK_GRAPH_LIMIT_INTERP'],
  primary_skill_id = 'SK_LIMIT_PROCEDURE_SELECT',
  supporting_skill_ids = ARRAY['SK_GRAPH_LIMIT_INTERP'],
  error_tags = ARRAY['E6_MISREAD_GRAPH', 'E2_IGNORE_ONE_SIDED', 'E1_CONFUSE_VALUE_WITH_LIMIT'],
  prompt = 'Use the graph of $f$ to evaluate $\lim_{x\to -1} f(x)$. [image:1.7-P1.png]',
  latex = 'Use the graph of $f$ to evaluate $\lim_{x\to -1} f(x)$. [image:1.7-P1.png]',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\tfrac{1}{2}$','explanation','Both sides approach the open circle on the line at $x=-1$, which is $y=\tfrac{1}{2}$.'),
    jsonb_build_object('id','B','text','$2$','explanation','$2$ is the filled point value at $x=-1$, not the limit.'),
    jsonb_build_object('id','C','text','DNE because there is a hole','explanation','A hole does not prevent the limit from existing if both sides approach the same value.'),
    jsonb_build_object('id','D','text','DNE because there is a jump','explanation','The jump shown is at $x=0$, not at $x=-1$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Near $x=-1$, the curve follows the line segment on both sides and approaches the open-circle height. The filled point at $x=-1$ changes $f(-1)$ but not the limit.',
  recommendation_reasons = ARRAY['Practice distinguishing limit from function value using a graph.', 'Build method-selection fluency for non-algebraic representations.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: select graph-based evaluation; distinguish $\lim_{x\to a}f(x)$ from $f(a)$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.7-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.7',
  section_id = '1.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LIMIT_PROCEDURE_SELECT', 'SK_ALG_LIMIT_EVAL'],
  primary_skill_id = 'SK_LIMIT_PROCEDURE_SELECT',
  supporting_skill_ids = ARRAY['SK_ALG_LIMIT_EVAL'],
  error_tags = ARRAY['E4_WRONG_METHOD_CHOICE', 'E3_ALGEBRA_SLIP'],
  prompt = 'Which procedure is most efficient for evaluating $\lim_{x\to 3}\dfrac{x^2-9}{x-3}$?',
  latex = 'Which procedure is most efficient for evaluating $\lim_{x\to 3}\dfrac{x^2-9}{x-3}$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Direct substitution','explanation','Direct substitution gives $\frac{0}{0}$, so more work is needed.'),
    jsonb_build_object('id','B','text','Factor and cancel before substituting','explanation','Factor $x^2-9=(x-3)(x+3)$, cancel, then substitute.'),
    jsonb_build_object('id','C','text','Squeeze Theorem','explanation','No natural bounding functions are suggested; algebraic simplification is standard.'),
    jsonb_build_object('id','D','text','One-sided limits from a table','explanation','A table could work but is less efficient than factoring here.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'This is a removable discontinuity form $\frac{0}{0}$ that resolves by factoring and canceling the common factor, then substituting.',
  recommendation_reasons = ARRAY['Reinforce quick recognition of $\frac{0}{0}$ patterns that require simplification.', 'Reduce overuse of tables/graphs when algebra is cleaner.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: choose factoring/canceling as the efficient procedure for removable forms.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.7-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.7',
  section_id = '1.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_LIMIT_PROCEDURE_SELECT', 'SK_ONE_SIDED_LIMITS'],
  primary_skill_id = 'SK_LIMIT_PROCEDURE_SELECT',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMITS'],
  error_tags = ARRAY['E2_IGNORE_ONE_SIDED', 'E4_WRONG_METHOD_CHOICE'],
  prompt = 'For $f(x)=\dfrac{|x|}{x}$, what is $\lim_{x\to 0} f(x)$?',
  latex = 'For $f(x)=\dfrac{|x|}{x}$, what is $\lim_{x\to 0} f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The expression approaches $1$ from the right and $-1$ from the left, not $0$.'),
    jsonb_build_object('id','B','text','$1$','explanation','$1$ is the right-hand limit only.'),
    jsonb_build_object('id','C','text','$-1$','explanation','$-1$ is the left-hand limit only.'),
    jsonb_build_object('id','D','text','DNE','explanation','Left-hand and right-hand limits are different, so the two-sided limit does not exist.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Use one-sided limits: if $x>0$, $\frac{|x|}{x}=1$; if $x<0$, $\frac{|x|}{x}=-1$. Since $1\ne -1$, the limit does not exist.',
  recommendation_reasons = ARRAY['Strengthen automatic check of one-sided limits for absolute value/step behavior.', 'Prevent false plug-in habits near sign changes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: select one-sided analysis when sign changes create different behaviors.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.7-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.7',
  section_id = '1.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LIMIT_PROCEDURE_SELECT', 'SK_INFINITE_LIMITS_ASYM'],
  primary_skill_id = 'SK_LIMIT_PROCEDURE_SELECT',
  supporting_skill_ids = ARRAY['SK_INFINITE_LIMITS_ASYM'],
  error_tags = ARRAY['E4_WRONG_METHOD_CHOICE', 'E3_ALGEBRA_SLIP'],
  prompt = 'Evaluate $\lim_{x\to 2}\dfrac{1}{(x-2)^2}$.',
  latex = 'Evaluate $\lim_{x\to 2}\dfrac{1}{(x-2)^2}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','The denominator approaches $0$, so the expression does not approach $0$.'),
    jsonb_build_object('id','B','text','$+\infty$','explanation','Because $(x-2)^2>0$ and approaches $0$, the reciprocal grows without bound positively.'),
    jsonb_build_object('id','C','text','$-\infty$','explanation','The square keeps the denominator positive, so it cannot go to $-\infty$.'),
    jsonb_build_object('id','D','text','DNE because of $\frac{1}{0}$','explanation','The limit exists as an infinite limit and equals $+\infty$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'As $x\to 2$, $(x-2)^2\to 0^+$, so $\frac{1}{(x-2)^2}\to +\infty$ (vertical asymptote at $x=2$).',
  recommendation_reasons = ARRAY['Practice choosing infinite-limit interpretation when denominator goes to $0^+$.', 'Avoid labeling all blow-ups as DNE without sign analysis.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify $0^+$ in denominator and conclude $+\infty$.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.7-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.7',
  section_id = '1.7',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_LIMIT_PROCEDURE_SELECT'],
  primary_skill_id = 'SK_LIMIT_PROCEDURE_SELECT',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E4_WRONG_METHOD_CHOICE', 'E1_CONFUSE_VALUE_WITH_LIMIT'],
  prompt = 'A function $h$ is defined by a graph that clearly shows a jump discontinuity at $x=a$. Which statement must be true?',
  latex = 'A function $h$ is defined by a graph that clearly shows a jump discontinuity at $x=a$. Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to a} h(x)$ does not exist','explanation','At a jump, the left-hand and right-hand limits are finite but unequal, so the two-sided limit does not exist.'),
    jsonb_build_object('id','B','text','$h(a)$ is undefined','explanation','A jump can still have a defined value at $x=a$ (a filled point).'),
    jsonb_build_object('id','C','text','$\lim_{x\to a} h(x)=h(a)$','explanation','A jump prevents the two-sided limit from matching a single value.'),
    jsonb_build_object('id','D','text','Both one-sided limits are infinite','explanation','A jump is typically finite on both sides; infinite behavior is a vertical asymptote.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'A jump discontinuity means $\lim_{x\to a^-}h(x)$ and $\lim_{x\to a^+}h(x)$ exist (finite) but are not equal, so the two-sided limit does not exist.',
  recommendation_reasons = ARRAY['Solidify classification of discontinuities into limit exists vs limit DNE.', 'Reduce confusion between jump vs asymptote vs removable.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.80,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: jump implies unequal one-sided limits, so the two-sided limit does not exist.',
  weight_primary = 1.00,
  weight_supporting = 0.00,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.7-P5';



-- Unit 1.8 (Determining Limits Using the Squeeze Theorem) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.8',
  section_id = '1.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_SQUEEZE', 'SK_TRIG_BOUNDS'],
  primary_skill_id = 'SK_SQUEEZE',
  supporting_skill_ids = ARRAY['SK_TRIG_BOUNDS'],
  error_tags = ARRAY['E5_ASSUME_SQUEEZE_WITHOUT_BOUNDS', 'E7_BOUND_NOT_TIGHT'],
  prompt = 'Evaluate $\lim_{x\to 0} x^2\cos\left(\dfrac{1}{x}\right)$.',
  latex = 'Evaluate $\lim_{x\to 0} x^2\cos\left(\dfrac{1}{x}\right)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','DNE because $\cos(1/x)$ oscillates','explanation','Oscillation alone does not prevent a limit when a factor forces the product to $0$.'),
    jsonb_build_object('id','B','text','$1$','explanation','$x^2\to 0$, so the product cannot approach $1$.'),
    jsonb_build_object('id','C','text','$0$','explanation','Since $-1\le \cos(1/x)\le 1$, we have $-x^2\le x^2\cos(1/x)\le x^2$ and both bounds go to $0$.'),
    jsonb_build_object('id','D','text','$-1$','explanation','The product is between $-x^2$ and $x^2$, so it cannot approach $-1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use $-1\le \cos(1/x)\le 1$. Multiplying by $x^2\ge 0$ gives $-x^2\le x^2\cos(1/x)\le x^2$. As $x\to 0$, both $\pm x^2\to 0$, so the limit is $0$.',
  recommendation_reasons = ARRAY['Rehearse standard trig bounds $-1\le\sin,\cos\le 1$ for squeeze products.', 'Avoid “oscillates therefore DNE” overgeneralization.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: squeeze an oscillatory factor using $[-1,1]$ bounds.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.8-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.8',
  section_id = '1.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 80,
  skill_tags = ARRAY['SK_SQUEEZE', 'SK_INEQUALITY_BOUND'],
  primary_skill_id = 'SK_SQUEEZE',
  supporting_skill_ids = ARRAY['SK_INEQUALITY_BOUND'],
  error_tags = ARRAY['E5_ASSUME_SQUEEZE_WITHOUT_BOUNDS', 'E6_MISREAD_GRAPH'],
  prompt = 'The graph shows three functions near $x=0$: $y=-|x|$, $y=x\sin(1/x)$, and $y=|x|$. What is $\lim_{x\to 0} x\sin(1/x)$? [image:1.8-P2.png]',
  latex = 'The graph shows three functions near $x=0$: $y=-|x|$, $y=x\sin(1/x)$, and $y=|x|$. What is $\lim_{x\to 0} x\sin(1/x)$? [image:1.8-P2.png]',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','DNE','explanation','The oscillation is bounded by functions that both go to $0$, so the limit exists.'),
    jsonb_build_object('id','B','text','$0$','explanation','Because $-1\le \sin(1/x)\le 1$, multiplying by $x$ gives $-|x|\le x\sin(1/x)\le |x|$, and both bounds go to $0$.'),
    jsonb_build_object('id','C','text','$1$','explanation','The middle function stays between $-|x|$ and $|x|$, which both shrink to $0$.'),
    jsonb_build_object('id','D','text','The limit depends on the path to $0$','explanation','This is a single-variable limit; squeeze forces a unique value.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Since $-1\le \sin(1/x)\le 1$, we have $-|x|\le x\sin(1/x)\le |x|$. As $x\to 0$, both $-|x|$ and $|x|$ approach $0$, so by the Squeeze Theorem the limit is $0$.',
  recommendation_reasons = ARRAY['Connect algebraic inequalities to graphical squeezing.', 'Build confidence recognizing classic $x\sin(1/x)$ squeeze pattern.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: apply squeeze with $-|x|$ and $|x|$ as bounds.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.8-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.8',
  section_id = '1.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 105,
  skill_tags = ARRAY['SK_SQUEEZE', 'SK_GRAPH_LIMIT_INTERP'],
  primary_skill_id = 'SK_SQUEEZE',
  supporting_skill_ids = ARRAY['SK_GRAPH_LIMIT_INTERP'],
  error_tags = ARRAY['E5_ASSUME_SQUEEZE_WITHOUT_BOUNDS', 'E1_CONFUSE_VALUE_WITH_LIMIT'],
  prompt = 'The graph shows $g(x)=\sin(1/x)$ near $x=0$. What is $\lim_{x\to 0} g(x)$? [image:1.8-P3.png]',
  latex = 'The graph shows $g(x)=\sin(1/x)$ near $x=0$. What is $\lim_{x\to 0} g(x)$? [image:1.8-P3.png]',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Although values hit $0$ infinitely often, they also hit values near $1$ and $-1$ arbitrarily close to $0$.'),
    jsonb_build_object('id','B','text','$1$','explanation','The function also takes values near $-1$ arbitrarily close to $0$.'),
    jsonb_build_object('id','C','text','$-1$','explanation','The function also takes values near $1$ arbitrarily close to $0$.'),
    jsonb_build_object('id','D','text','DNE','explanation','The function oscillates between $-1$ and $1$ without approaching a single value.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Even though $-1\le \sin(1/x)\le 1$, the bounds do not squeeze to a single value. Near $0$, the function attains values arbitrarily close to many numbers in $[-1,1]$, so the limit does not exist.',
  recommendation_reasons = ARRAY['Differentiate bounded from squeezed.', 'Prevent incorrect squeeze attempts when bounds do not converge.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: oscillation without narrowing bounds implies the limit does not exist.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.8-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.8',
  section_id = '1.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 95,
  skill_tags = ARRAY['SK_SQUEEZE', 'SK_ABS_INEQUAL'],
  primary_skill_id = 'SK_SQUEEZE',
  supporting_skill_ids = ARRAY['SK_ABS_INEQUAL'],
  error_tags = ARRAY['E7_BOUND_NOT_TIGHT', 'E3_ALGEBRA_SLIP'],
  prompt = 'Suppose $|f(x)|\le 5|x-2|$ for all $x$ near $2$. What is $\lim_{x\to 2} f(x)$?',
  latex = 'Suppose $|f(x)|\le 5|x-2|$ for all $x$ near $2$. What is $\lim_{x\to 2} f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Since $-5|x-2|\le f(x)\le 5|x-2|$ and $5|x-2|\to 0$, squeeze gives $\lim_{x\to 2} f(x)=0$.'),
    jsonb_build_object('id','B','text','$5$','explanation','The inequality bounds $f(x)$ by something that goes to $0$, not by $5$.'),
    jsonb_build_object('id','C','text','DNE','explanation','The bounds converge to $0$, which forces existence and value $0$.'),
    jsonb_build_object('id','D','text','Cannot be determined','explanation','The inequality is enough: it forces $f(x)$ to be trapped near $0$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because $|f(x)|\le 5|x-2|$, we have $-5|x-2|\le f(x)\le 5|x-2|$. As $x\to 2$, both bounds go to $0$, so by Squeeze Theorem $\lim_{x\to 2} f(x)=0$.',
  recommendation_reasons = ARRAY['Use absolute value inequalities as ready-made squeeze setups.', 'Practice translating $|f(x)|\le \text{small}$ into two-sided bounds.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: convert $|f(x)|\le C|x-a|$ into symmetric bounds that go to $0$.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.8-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.8',
  section_id = '1.8',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_SQUEEZE', 'SK_INEQUALITY_BOUND'],
  primary_skill_id = 'SK_SQUEEZE',
  supporting_skill_ids = ARRAY['SK_INEQUALITY_BOUND'],
  error_tags = ARRAY['E5_ASSUME_SQUEEZE_WITHOUT_BOUNDS', 'E3_ALGEBRA_SLIP'],
  prompt = 'Evaluate $\lim_{x\to 0}\dfrac{\sin^2 x}{x}$.',
  latex = 'Evaluate $\lim_{x\to 0}\dfrac{\sin^2 x}{x}$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$1$','explanation','$\frac{\sin^2 x}{x}=\left(\frac{\sin x}{x}\right)\sin x\to 1\cdot 0=0$, not $1$.'),
    jsonb_build_object('id','B','text','DNE because it is $\frac{0}{0}$','explanation','An indeterminate form indicates you must analyze; it may still have a limit.'),
    jsonb_build_object('id','C','text','$0$','explanation','Rewrite as $\left(\frac{\sin x}{x}\right)\sin x$; since $\frac{\sin x}{x}\to 1$ and $\sin x\to 0$, the product goes to $0$.'),
    jsonb_build_object('id','D','text','$-1$','explanation','The expression is near $0$, not near $-1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Use the factorization $\frac{\sin^2 x}{x}=\left(\frac{\sin x}{x}\right)\sin x$. As $x\to 0$, $\frac{\sin x}{x}\to 1$ and $\sin x\to 0$, so the product tends to $0$.',
  recommendation_reasons = ARRAY['Combine standard small-angle limits with squeeze/product reasoning.', 'Target high-frequency mistake: treating $\sin^2 x/x$ like $\sin x/x$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: rewrite into a product with $\sin x/x$ to control the limit.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.8-P5';
