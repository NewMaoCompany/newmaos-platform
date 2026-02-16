BEGIN;

-- Q4 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  -- Sync columns:
  primary_skill_id = 'SK_SIGN_CHART',
  supporting_skill_ids = ARRAY['SK_INCREASING_DECREASING'],
  skill_tags = ARRAY['SK_SIGN_CHART','SK_INCREASING_DECREASING'],
  error_tags = ARRAY['E_SIGN_CHART','E_GRAPH_MISMATCH'],
  prompt = 'Let $f''(x)=\dfrac{(x-2)(x+1)}{(x-1)^2}$. On which set of intervals is $f$ increasing?',
  latex = 'Let $f''(x)=\dfrac{(x-2)(x+1)}{(x-1)^2}$. On which set of intervals is $f$ increasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-1,1)\cup(1,2)$','explanation','On $(-1,2)$ the numerator $(x-2)(x+1)$ is negative, so $f''(x)<0$ for $x\\ne 1$.'),
    jsonb_build_object('id','B','text','$(-\\infty,-1)\\cup(-1,1)$','explanation','$(-1,1)$ gives $(x-2)(x+1)<0$, so $f$ is decreasing there (excluding $x=1$).'),
    jsonb_build_object('id','C','text','$(-\\infty,-1)\\cup(2,\\infty)$','explanation','Since $(x-1)^2>0$ for $x\\ne1$, the sign of $f''$ is the sign of $(x-2)(x+1)$, which is positive on $(-\\infty,-1)$ and $(2,\\infty)$.'),
    jsonb_build_object('id','D','text','$(1,2)$ only','explanation','On $(1,2)$, $(x-2)(x+1)<0$, so $f$ is decreasing, not increasing.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Because $(x-1)^2>0$ for $x\\ne 1$, the sign of $f''(x)$ matches the sign of $(x-2)(x+1)$. That product is positive on $(-\\infty,-1)$ and $(2,\\infty)$, so $f$ is increasing on
$$(-\\infty,-1)\\cup(2,\\infty).$$',
  recommendation_reasons = ARRAY['Builds a correct sign chart for a rational derivative.', 'Avoids the common mistake of treating a squared denominator as changing sign.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Monotonicity from the sign of $f''(x)$; note $(x-1)^2$ is always positive for $x\\ne1$.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q4';

-- Q5 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 1,
  target_time_seconds = 60,
  -- Sync columns:
  primary_skill_id = 'SK_FIRST_DERIV_TEST',
  supporting_skill_ids = ARRAY[]::text[],
  skill_tags = ARRAY['SK_FIRST_DERIV_TEST'],
  error_tags = ARRAY['E_SIGN_CHART','E_LOCAL_VS_GLOBAL'],
  prompt = 'Suppose $f$ is differentiable and $f''(x)$ changes sign from positive to negative at $x=5$. What can be concluded?',
  latex = 'Suppose $f$ is differentiable and $f''(x)$ changes sign from positive to negative at $x=5$. What can be concluded?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local maximum at $x=5$.','explanation','If $f''$ changes from $+$ to $-$, then $f$ increases then decreases, so there is a local maximum.'),
    jsonb_build_object('id','B','text','$f$ has a local minimum at $x=5$.','explanation','A local minimum requires a sign change from $-$ to $+$.'),
    jsonb_build_object('id','C','text','$f$ has an inflection point at $x=5$.','explanation','Inflection points require concavity change, not a sign change of $f''$.'),
    jsonb_build_object('id','D','text','No conclusion can be drawn without knowing $f''''(5)$.','explanation','The first derivative test is sufficient when the sign change is known.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'When $f''(x)$ changes from positive to negative at $x=5$, $f$ changes from increasing to decreasing at $x=5$. Therefore, $f$ has a local maximum at $x=5$.',
  recommendation_reasons = ARRAY['Fast recognition of the first derivative test pattern.', 'Targets confusion between local extrema and inflection points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 1,
  mastery_weight = 0.90,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Local max occurs when $f''$ changes from $+$ to $-$.',
  weight_primary = 0.95,
  weight_supporting = 0.05,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q5';

-- Q6 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  -- Sync columns:
  primary_skill_id = 'SK_ABS_EXTREMA_CANDIDATES',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],
  skill_tags = ARRAY['SK_ABS_EXTREMA_CANDIDATES','SK_ALGEBRA'],
  error_tags = ARRAY['E_ENDPOINTS_IGNORED','E_ARITHMETIC'],
  prompt = 'Let $f(x)=x\\sqrt{9-x^2}$ on $[0,3]$. What is the maximum value of $f$ on $[0,3]$?',
  latex = 'Let $f(x)=x\\sqrt{9-x^2}$ on $[0,3]$. What is the maximum value of $f$ on $[0,3]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$3\\sqrt{3}$','explanation','This results from evaluating at the wrong $x$ or simplifying incorrectly.'),
    jsonb_build_object('id','B','text','$6$','explanation','This is not the value at the maximizing input.'),
    jsonb_build_object('id','C','text','$\\dfrac{9}{2}$','explanation','Correct: check endpoints and the interior critical point to get $\\dfrac{9}{2}$.'),
    jsonb_build_object('id','D','text','$9$','explanation','This is not attainable by $x\\sqrt{9-x^2}$ on $[0,3]$.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Differentiate:
$$f''(x)=\\sqrt{9-x^2}-\\frac{x^2}{\\sqrt{9-x^2}}=\\frac{9-2x^2}{\\sqrt{9-x^2}}.$$
Set $9-2x^2=0\\Rightarrow x=\\frac{3}{\\sqrt{2}}$ (in $[0,3]$). Candidates:
$$f(0)=0,\\quad f(3)=0,$$
$$f\\!\\left(\\frac{3}{\\sqrt{2}}\\right)=\\frac{3}{\\sqrt{2}}\\cdot\\sqrt{9-\\frac{9}{2}}=\\frac{3}{\\sqrt{2}}\\cdot\\frac{3}{\\sqrt{2}}=\\frac{9}{2}.$$
So the maximum value is $\\dfrac{9}{2}$.',
  recommendation_reasons = ARRAY['Uses candidates test on a closed interval.', 'Targets the common mistake of skipping endpoints or mishandling radicals.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.20,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Maximize on a closed interval: check endpoints and interior critical points.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q6';

-- Q7 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  -- Sync columns:
  primary_skill_id = 'SK_INCREASING_DECREASING',
  supporting_skill_ids = ARRAY['SK_INTERPRET_GRAPH'],
  skill_tags = ARRAY['SK_INCREASING_DECREASING','SK_INTERPRET_GRAPH'],
  error_tags = ARRAY['E_GRAPH_MISMATCH','E_SIGN_CHART'],
  prompt = 'IMAGE: unit_test-P7.png

The graph shown is $f''(x)$. On which interval is $f$ decreasing?',
  latex = 'IMAGE: unit_test-P7.png

The graph shown is $f''(x)$. On which interval is $f$ decreasing?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\\infty,-1)$','explanation','There the graph is above the $x$-axis, so $f''(x)>0$ and $f$ is increasing.'),
    jsonb_build_object('id','B','text','$(-1,2)$','explanation','Between $-1$ and $2$, the graph is below the $x$-axis, so $f''(x)<0$ and $f$ is decreasing.'),
    jsonb_build_object('id','C','text','$(2,\\infty)$','explanation','There the graph is above the $x$-axis, so $f$ is increasing.'),
    jsonb_build_object('id','D','text','None; $f$ is increasing for all $x$.','explanation','False: the derivative graph is negative on $(-1,2)$.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = '$f$ is decreasing where $f''(x)<0$. From the graph, $f''(x)$ is negative on $(-1,2)$, so $f$ is decreasing on $(-1,2)$.',
  recommendation_reasons = ARRAY['Reads monotonicity from the sign of a derivative graph.', 'Targets reversing above/below-axis interpretation.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Decreasing where the derivative graph lies below the $x$-axis.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q7';

-- Q8 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  -- Sync columns:
  primary_skill_id = 'SK_CONCAVITY',
  supporting_skill_ids = ARRAY['SK_ALGEBRA'],
  skill_tags = ARRAY['SK_CONCAVITY','SK_ALGEBRA'],
  error_tags = ARRAY['E_CONCAVITY_SIGN','E_SIGN_CHART'],
  prompt = 'Let $f(x)=x^3-6x^2+9x+1$. On which interval is $f$ concave up?',
  latex = 'Let $f(x)=x^3-6x^2+9x+1$. On which interval is $f$ concave up?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(-\\infty,2)$','explanation','For $x<2$, $f''''(x)=6(x-2)<0$, so $f$ is concave down.'),
    jsonb_build_object('id','B','text','$(2,\\infty)$','explanation','Since $f''''(x)=6(x-2)>0$ for $x>2$, $f$ is concave up on $(2,\\infty)$.'),
    jsonb_build_object('id','C','text','$(-\\infty,0)$','explanation','Concavity changes where $f''''(x)=0$, which occurs at $x=2$, not $0$.'),
    jsonb_build_object('id','D','text','$(0,2)$','explanation','On $(0,2)$, $f''''(x)<0$, so $f$ is concave down.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Compute
$$f''''(x)=6x-12=6(x-2).$$
$f$ is concave up where $f''''(x)>0$, i.e. where $x>2$.',
  recommendation_reasons = ARRAY['Practices concavity from the second derivative.', 'Targets the sign mistake when solving $f''''(x)>0$.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.05,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concave up where $f''''(x)>0$.',
  weight_primary = 0.80,
  weight_supporting = 0.20,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q8';

-- Q9 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  -- Sync columns:
  primary_skill_id = 'SK_SECOND_DERIV_TEST',
  supporting_skill_ids = ARRAY[]::text[],
  skill_tags = ARRAY['SK_SECOND_DERIV_TEST'],
  error_tags = ARRAY['E_CONCAVITY_SIGN','E_LOCAL_VS_GLOBAL'],
  prompt = 'Suppose $f''(2)=0$ and $f''''(2)<0$. Which conclusion is justified?',
  latex = 'Suppose $f''(2)=0$ and $f''''(2)<0$. Which conclusion is justified?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has a local minimum at $x=2$.','explanation','A local minimum via the second derivative test requires $f''''(2)>0$.'),
    jsonb_build_object('id','B','text','$f$ has an inflection point at $x=2$.','explanation','An inflection point requires concavity to change sign, not just $f''''(2)<0$.'),
    jsonb_build_object('id','C','text','No conclusion can be drawn.','explanation','Here a conclusion can be drawn because $f''''(2)\\ne 0$.'),
    jsonb_build_object('id','D','text','$f$ has a local maximum at $x=2$.','explanation','At a critical point, $f''''(2)<0$ means concave down, so it is a local maximum.')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Second derivative test: if $f''(c)=0$ and $f''''(c)<0$, then $f$ has a local maximum at $c$. With $c=2$, $f$ has a local maximum at $x=2$.',
  recommendation_reasons = ARRAY['Directly applies the second derivative test.', 'Targets confusion between concavity and inflection points.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Second derivative test at a critical point ($f''''(c)\\ne 0$).',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q9';

-- Q10 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 2,
  target_time_seconds = 90,
  -- Sync columns:
  primary_skill_id = 'SK_CONCAVITY',
  supporting_skill_ids = ARRAY['SK_INTERPRET_GRAPH'],
  skill_tags = ARRAY['SK_CONCAVITY','SK_INTERPRET_GRAPH'],
  error_tags = ARRAY['E_CONCAVITY_SIGN','E_GRAPH_MISMATCH'],
  prompt = 'IMAGE: unit_test-P10.png

The graph shown is $f''''(x)$. On which interval is $f$ concave down?',
  latex = 'IMAGE: unit_test-P10.png

The graph shown is $f''''(x)$. On which interval is $f$ concave down?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$(1,3)$','explanation','On $(1,3)$, the graph is below the $x$-axis, so $f''''(x)<0$ and $f$ is concave down.'),
    jsonb_build_object('id','B','text','$(-\\infty,1)$','explanation','There $f''''(x)>0$, so $f$ is concave up.'),
    jsonb_build_object('id','C','text','$(3,\\infty)$','explanation','There $f''''(x)>0$, so $f$ is concave up.'),
    jsonb_build_object('id','D','text','All real $x$','explanation','$f''''(x)$ changes sign, so concavity cannot be down for all $x$.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = '$f$ is concave down where $f''''(x)<0$. From the graph, $f''''(x)$ is negative on $(1,3)$, so $f$ is concave down on $(1,3)$.',
  recommendation_reasons = ARRAY['Reads concavity directly from a second-derivative graph.', 'Targets the common sign-interpretation error.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Concave down where the $f''''$ graph lies below the $x$-axis.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q10';

-- Sync Relation Table question_skills (with Primary Constraint Handling)
DELETE FROM question_skills
WHERE question_id IN (
    SELECT id FROM questions WHERE title IN (
       '5.0-UT-Q4', '5.0-UT-Q5', '5.0-UT-Q6', '5.0-UT-Q7',
       '5.0-UT-Q8', '5.0-UT-Q9', '5.0-UT-Q10'
    )
);

-- Insert PRIMARY skills (First in array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, skill_tags[1], 'primary'
FROM questions 
WHERE title IN (
       '5.0-UT-Q4', '5.0-UT-Q5', '5.0-UT-Q6', '5.0-UT-Q7',
       '5.0-UT-Q8', '5.0-UT-Q9', '5.0-UT-Q10'
    ) 
  AND array_length(skill_tags, 1) >= 1;

-- Insert SUPPORTING skills (Rest of array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, unnest(skill_tags[2:]), 'supporting'
FROM questions
WHERE title IN (
       '5.0-UT-Q4', '5.0-UT-Q5', '5.0-UT-Q6', '5.0-UT-Q7',
       '5.0-UT-Q8', '5.0-UT-Q9', '5.0-UT-Q10'
    )
  AND array_length(skill_tags, 1) >= 2;

COMMIT;
