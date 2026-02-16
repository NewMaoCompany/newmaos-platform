
-- Unit 1.9 (Connecting Multiple Representations of Limits) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.9',
  section_id = '1.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 75,
  skill_tags = ARRAY['SK_LIMIT_GRAPH', 'SK_ONE_SIDED_LIMITS'],
  primary_skill_id = 'SK_LIMIT_GRAPH',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMITS'],
  error_tags = ARRAY['E_OPEN_CLOSED', 'E_VALUE_VS_LIMIT', 'E_IGNORE_ONE_SIDED'],
  prompt = 'The graph of $f$ is shown in the figure labeled 1.9-P1. What is $\lim_{x\to 2} f(x)$?',
  latex = 'The graph of $f$ is shown in the figure labeled 1.9-P1. What is $\lim_{x\to 2} f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3$','explanation','From both the left and the right, the graph approaches $y=3$.'),
    jsonb_build_object('id','B','text','$1$','explanation','This is $f(2)$ (the filled point), not the limit.'),
    jsonb_build_object('id','C','text','Does not exist','explanation','The left-hand and right-hand approach values match, so the limit exists.'),
    jsonb_build_object('id','D','text','$2$','explanation','The graph does not approach $2$ near $x=2$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Read the approach values on both sides of $x=2$. The left-hand limit is $3$ and the right-hand limit is also $3$, so $\lim_{x\to 2} f(x)=3$.',
  recommendation_reasons = ARRAY['Connects a graph to a two-sided limit.', 'Targets the common confusion between $f(2)$ and $\lim_{x\to 2} f(x)$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: determine a two-sided limit from a graph when the function value differs from the limit.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.9-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.9',
  section_id = '1.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 90,
  skill_tags = ARRAY['SK_LIMIT_ALGEBRA', 'SK_VALUE_VS_LIMIT'],
  primary_skill_id = 'SK_LIMIT_ALGEBRA',
  supporting_skill_ids = ARRAY['SK_VALUE_VS_LIMIT'],
  error_tags = ARRAY['E_VALUE_VS_LIMIT'],
  prompt = 'A function satisfies $f(x)=(x-3)(x+1)$ for $x\ne 3$, and $f(3)=10$. What is $\lim_{x\to 3} f(x)$?',
  latex = 'A function satisfies $f(x)=(x-3)(x+1)$ for $x\ne 3$, and $f(3)=10$. What is $\lim_{x\to 3} f(x)$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$10$','explanation','This is $f(3)$, but the limit depends on nearby values.'),
    jsonb_build_object('id','B','text','$4$','explanation','This is $x+1$ at $x=3$, but you must multiply by the factor approaching $0$.'),
    jsonb_build_object('id','C','text','$0$','explanation','As $x\to 3$, $(x-3)(x+1)\to (0)(4)=0$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','Polynomials have limits at every real number.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'For $x\ne 3$, $f(x)=(x-3)(x+1)$ is a polynomial expression, so the limit equals its value at $x=3$: $(3-3)(3+1)=0$.',
  recommendation_reasons = ARRAY['Reinforces that the limit can exist even if $f(3)$ is redefined.', 'Targets the frequent AP trap: mixing function value with limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: compute a limit from a symbolic rule and distinguish it from the function value at the point.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.9-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.9',
  section_id = '1.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 110,
  skill_tags = ARRAY['SK_LIMIT_TABLE', 'SK_ONE_SIDED_LIMITS'],
  primary_skill_id = 'SK_LIMIT_TABLE',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMITS'],
  error_tags = ARRAY['E_IGNORE_ONE_SIDED', 'E_TABLE_ASSUMPTION'],
  prompt = 'A table gives values of $g(x)$ near $x=1$. For $x<1$, the values trend toward $2$. For $x>1$, the values trend toward $-1$. Which statement is true?',
  latex = 'A table gives values of $g(x)$ near $x=1$. For $x<1$, the values trend toward $2$. For $x>1$, the values trend toward $-1$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to 1} g(x)=2$','explanation','This matches only the left-hand trend, not the right-hand trend.'),
    jsonb_build_object('id','B','text','$\lim_{x\to 1} g(x)=-1$','explanation','This matches only the right-hand trend, not the left-hand trend.'),
    jsonb_build_object('id','C','text','$g(1)=2$','explanation','A table trend near $1$ does not determine the actual value at $x=1$.'),
    jsonb_build_object('id','D','text','$\lim_{x\to 1} g(x)$ does not exist','explanation','The one-sided limits approach different values, so the two-sided limit does not exist.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'A two-sided limit exists only if the left-hand and right-hand limits are equal. Here the left-hand limit is $2$ and the right-hand limit is $-1$, so $\lim_{x\to 1} g(x)$ does not exist.',
  recommendation_reasons = ARRAY['Forces explicit one-sided reasoning from a table.', 'Targets the common mistake of choosing the more stable-looking side as the limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: connect table trends to one-sided limits and determine whether the two-sided limit exists.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.9-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.9',
  section_id = '1.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  skill_tags = ARRAY['SK_LIMIT_TABLE'],
  primary_skill_id = 'SK_LIMIT_TABLE',
  supporting_skill_ids = ARRAY[]::text[],
  error_tags = ARRAY['E_TABLE_FAR_VALUES', 'E_VALUE_VS_LIMIT'],
  prompt = 'The table shown in the figure labeled 1.9-P4 gives values of $f(x)$ near $x=2$. Estimate $\lim_{x\to 2} f(x)$.',
  latex = 'The table shown in the figure labeled 1.9-P4 gives values of $f(x)$ near $x=2$. Estimate $\lim_{x\to 2} f(x)$.',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3.61$','explanation','This is a single table entry (for $x=1.9$), not the approached value near $2$.'),
    jsonb_build_object('id','B','text','$4$','explanation','Values closest to $2$ cluster around $4$, so the limit is about $4$.'),
    jsonb_build_object('id','C','text','$4.41$','explanation','This is $f(2.1)$, which is farther from $2$ than values like $2.01$.'),
    jsonb_build_object('id','D','text','Does not exist','explanation','The table suggests approach toward a single value from both sides.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'As $x$ gets closer to $2$ from both sides, the function values get closer to $4$, so $\lim_{x\to 2} f(x)\approx 4$.',
  recommendation_reasons = ARRAY['Builds fast table-to-limit estimation.', 'Targets the mistake of using a farther x-value instead of the closest ones.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: estimate a limit from tabular values by prioritizing inputs closest to the target.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.9-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.9',
  section_id = '1.9',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 140,
  skill_tags = ARRAY['SK_ONE_SIDED_LIMITS', 'SK_ABSOLUTE_VALUE'],
  primary_skill_id = 'SK_ONE_SIDED_LIMITS',
  supporting_skill_ids = ARRAY['SK_ABSOLUTE_VALUE'],
  error_tags = ARRAY['E_ABS_VALUE_ONE_SIDED', 'E_IGNORE_ONE_SIDED'],
  prompt = 'Define $h(x)=\dfrac{|x-2|}{x-2}$ for $x\ne 2$. Which statement is true?',
  latex = 'Define $h(x)=\dfrac{|x-2|}{x-2}$ for $x\ne 2$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to 2} h(x)=0$','explanation','Near $2$, the function takes values $-1$ or $1$, not values approaching $0$.'),
    jsonb_build_object('id','B','text','$\lim_{x\to 2} h(x)=1$','explanation','The right-hand limit is $1$, but the left-hand limit is $-1$.'),
    jsonb_build_object('id','C','text','$\lim_{x\to 2} h(x)$ does not exist','explanation','For $x>2$, $h(x)=1$; for $x<2$, $h(x)=-1$, so the one-sided limits differ.'),
    jsonb_build_object('id','D','text','$h(x)=1$ for all $x\ne 2$','explanation','For $x<2$, $|x-2|=-(x-2)$ so $h(x)=-1$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'If $x>2$, then $|x-2|=x-2$ so $h(x)=1$. If $x<2$, then $|x-2|=-(x-2)$ so $h(x)=-1$. Since the one-sided limits are different, $\lim_{x\to 2} h(x)$ does not exist.',
  recommendation_reasons = ARRAY['Connects absolute value behavior to one-sided limits.', 'High-discrimination AP pattern: piecewise reasoning from $|x-a|$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: determine limit existence by comparing one-sided limits for an absolute-value expression.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.9-P5';



-- Unit 1.10 (Exploring Types of Discontinuities) — Practice 1–5

UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.10',
  section_id = '1.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 85,
  skill_tags = ARRAY['SK_DISC_CLASSIFY', 'SK_LIMIT_GRAPH'],
  primary_skill_id = 'SK_DISC_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_LIMIT_GRAPH'],
  error_tags = ARRAY['E_JUMP_VS_REMOVABLE', 'E_OPEN_CLOSED'],
  prompt = 'The graph of $f$ is shown in the figure labeled 1.10-P1. What type of discontinuity does $f$ have at $x=1$?',
  latex = 'The graph of $f$ is shown in the figure labeled 1.10-P1. What type of discontinuity does $f$ have at $x=1$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Removable discontinuity','explanation','A removable discontinuity requires matching one-sided limits.'),
    jsonb_build_object('id','B','text','Infinite discontinuity','explanation','An infinite discontinuity requires unbounded behavior near the point.'),
    jsonb_build_object('id','C','text','No discontinuity','explanation','The left and right sides do not approach one common value.'),
    jsonb_build_object('id','D','text','Jump discontinuity','explanation','The one-sided limits are finite but unequal, which indicates a jump.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'At $x=1$, the function approaches one finite value from the left and a different finite value from the right, so the discontinuity is a jump discontinuity.',
  recommendation_reasons = ARRAY['Builds correct classification of discontinuities from a graph.', 'Targets the frequent confusion between jump and removable discontinuities.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: classify discontinuity type using one-sided limits read from a graph.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.10-P1';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.10',
  section_id = '1.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 100,
  skill_tags = ARRAY['SK_DISC_REMOVABLE', 'SK_LIMIT_ALGEBRA'],
  primary_skill_id = 'SK_DISC_REMOVABLE',
  supporting_skill_ids = ARRAY['SK_LIMIT_ALGEBRA'],
  error_tags = ARRAY['E_CANCEL_INCORRECTLY', 'E_VALUE_VS_LIMIT'],
  prompt = 'Consider $p(x)=\dfrac{x^2-9}{x-3}$ for $x\ne 3$. What must $p(3)$ be to make $p$ continuous at $x=3$?',
  latex = 'Consider $p(x)=\dfrac{x^2-9}{x-3}$ for $x\ne 3$. What must $p(3)$ be to make $p$ continuous at $x=3$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$0$','explanation','Simplifying shows the limit is not $0$.'),
    jsonb_build_object('id','B','text','$6$','explanation','Since $\lim_{x\to 3} \dfrac{x^2-9}{x-3}=6$, defining $p(3)=6$ makes the function continuous.'),
    jsonb_build_object('id','C','text','$3$','explanation','This is the x-value, not the required y-value for continuity.'),
    jsonb_build_object('id','D','text','No value works','explanation','This is removable, so defining the point appropriately does work.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Factor $x^2-9=(x-3)(x+3)$. For $x\ne 3$, $p(x)=x+3$, so $\lim_{x\to 3} p(x)=6$. Continuity requires $p(3)=6$.',
  recommendation_reasons = ARRAY['Connects removable discontinuity to redefining the point value.', 'Reinforces continuity as “value equals limit.”'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: remove a discontinuity by defining the function value to match the limit.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.10-P2';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.10',
  section_id = '1.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 115,
  skill_tags = ARRAY['SK_INFINITE_LIMITS', 'SK_VERT_ASYMPTOTE', 'SK_ONE_SIDED_LIMITS'],
  primary_skill_id = 'SK_INFINITE_LIMITS',
  supporting_skill_ids = ARRAY['SK_VERT_ASYMPTOTE', 'SK_ONE_SIDED_LIMITS'],
  error_tags = ARRAY['E_SIGN_INFINITY', 'E_IGNORE_ONE_SIDED'],
  prompt = 'The graph of $f$ is shown in the figure labeled 1.10-P3. Which statement is true about limits near $x=0$?',
  latex = 'The graph of $f$ is shown in the figure labeled 1.10-P3. Which statement is true about limits near $x=0$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\lim_{x\to 0} f(x)=0$','explanation','The function is unbounded near $x=0$, so it does not approach $0$.'),
    jsonb_build_object('id','B','text','$\lim_{x\to 0^-} f(x)=+\infty$ and $\lim_{x\to 0^+} f(x)=+\infty$','explanation','The left-hand side goes to $-\infty$, not $+\infty$.'),
    jsonb_build_object('id','C','text','$\lim_{x\to 0^-} f(x)=-\infty$ and $\lim_{x\to 0^+} f(x)=+\infty$','explanation','The left branch decreases without bound and the right branch increases without bound, indicating a vertical asymptote at $x=0$.'),
    jsonb_build_object('id','D','text','$\lim_{x\to 0} f(x)$ exists and is finite','explanation','Unbounded behavior prevents a finite two-sided limit.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'From the graph, as $x\to 0^-$ the function decreases without bound, and as $x\to 0^+$ it increases without bound. Therefore $\lim_{x\to 0^-} f(x)=-\infty$ and $\lim_{x\to 0^+} f(x)=+\infty$.',
  recommendation_reasons = ARRAY['Trains correct sign reading for infinite limits.', 'Connects infinite limits to vertical asymptotes.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify an infinite discontinuity and state correct one-sided infinite limits with signs.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.10-P3';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.10',
  section_id = '1.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 65,
  skill_tags = ARRAY['SK_DISC_CLASSIFY', 'SK_CONTINUITY_DEF'],
  primary_skill_id = 'SK_DISC_CLASSIFY',
  supporting_skill_ids = ARRAY['SK_CONTINUITY_DEF'],
  error_tags = ARRAY['E_JUMP_VS_REMOVABLE', 'E_VALUE_VS_LIMIT'],
  prompt = 'At $x=a$, a function has $\lim_{x\to a^-} f(x)=5$ and $\lim_{x\to a^+} f(x)=5$, but $f(a)$ is not defined. What type of discontinuity is at $x=a$?',
  latex = 'At $x=a$, a function has $\lim_{x\to a^-} f(x)=5$ and $\lim_{x\to a^+} f(x)=5$, but $f(a)$ is not defined. What type of discontinuity is at $x=a$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Removable discontinuity','explanation','The limit exists and is finite, but the function value is missing; defining $f(a)=5$ would make it continuous.'),
    jsonb_build_object('id','B','text','Jump discontinuity','explanation','A jump requires unequal one-sided limits.'),
    jsonb_build_object('id','C','text','Infinite discontinuity','explanation','Infinite discontinuities involve unbounded limits.'),
    jsonb_build_object('id','D','text','No discontinuity','explanation','Continuity also requires $f(a)$ to exist and equal the limit.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Because both one-sided limits equal $5$, the two-sided limit exists and equals $5$. Since $f(a)$ is undefined, the discontinuity can be removed by defining $f(a)=5$.',
  recommendation_reasons = ARRAY['Reinforces the “limit exists but value missing” pattern.', 'Builds fast classification without a graph.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.95,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: classify a removable discontinuity using one-sided limit facts and the continuity definition.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.10-P4';


UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Limits',
  sub_topic_id = '1.10',
  section_id = '1.10',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 150,
  skill_tags = ARRAY['SK_CONTINUITY_DEF', 'SK_ONE_SIDED_LIMITS'],
  primary_skill_id = 'SK_CONTINUITY_DEF',
  supporting_skill_ids = ARRAY['SK_ONE_SIDED_LIMITS'],
  error_tags = ARRAY['E_VALUE_VS_LIMIT', 'E_JUMP_VS_REMOVABLE', 'E_IGNORE_ONE_SIDED'],
  prompt = 'A function $f$ has $\lim_{x\to 4^-} f(x)=2$ and $\lim_{x\to 4^+} f(x)=2$. Also $f(4)=7$. Which statement is true?',
  latex = 'A function $f$ has $\lim_{x\to 4^-} f(x)=2$ and $\lim_{x\to 4^+} f(x)=2$. Also $f(4)=7$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ is continuous at $x=4$ because both one-sided limits exist','explanation','Continuity requires $f(4)$ to equal the limit.'),
    jsonb_build_object('id','B','text','$\lim_{x\to 4} f(x)=7$','explanation','The limit is determined by nearby values; both sides approach $2$, not $7$.'),
    jsonb_build_object('id','C','text','$f$ has a removable discontinuity at $x=4$','explanation','The limit exists and equals $2$, but $f(4)=7\ne 2$, so redefining $f(4)$ to $2$ would make it continuous.'),
    jsonb_build_object('id','D','text','$f$ has a jump discontinuity at $x=4$','explanation','A jump requires different left- and right-hand limits, but they are equal here.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Since $\lim_{x\to 4^-} f(x)=\lim_{x\to 4^+} f(x)=2$, the two-sided limit exists and equals $2$. Because $f(4)=7\ne 2$, the discontinuity is removable.',
  recommendation_reasons = ARRAY['Separates “limit exists” from “function is continuous.”', 'Targets the high-frequency AP error of treating $f(a)$ as the limit.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.15,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Focus: identify removable discontinuity when the point value does not match the (existing) limit.',
  weight_primary = 0.60,
  weight_supporting = 0.40,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Limits',
  updated_at = NOW()
WHERE title = '1.10-P5';
