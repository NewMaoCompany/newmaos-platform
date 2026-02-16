BEGIN;

-- Q2 Update (from update_unit5_unit_test.sql)
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
  primary_skill_id = 'SK_EVT',
  supporting_skill_ids = ARRAY[]::text[],
  skill_tags = ARRAY['SK_EVT'],
  error_tags = ARRAY['E_EVT_MISUSE'],
  prompt = 'Let $f(x)=\sqrt{4-x^2}$ on $[-2,2]$. Which statement is true?',
  latex = 'Let $f(x)=\sqrt{4-x^2}$ on $[-2,2]$. Which statement is true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ has both an absolute maximum and minimum','explanation','EVT applies on closed intervals.'),
    jsonb_build_object('id','B','text','$f$ has no absolute minimum','explanation','False: minimum is $0$.'),
    jsonb_build_object('id','C','text','$f$ has no absolute maximum','explanation','False: maximum is $2$.'),
    jsonb_build_object('id','D','text','EVT does not apply','explanation','Differentiability is not required.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Since $f$ is continuous on a closed interval, EVT guarantees absolute extrema.',
  recommendation_reasons = ARRAY['Tests EVT conditions.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'EVT depends on continuity.',
  weight_primary = 0.90,
  weight_supporting = 0.10,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q2';

-- Q3 Update (from update_unit5_unit_test.sql)
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
  primary_skill_id = 'SK_ABS_EXTREMA_CANDIDATES',
  supporting_skill_ids = ARRAY[]::text[],
  skill_tags = ARRAY['SK_ABS_EXTREMA_CANDIDATES'],
  error_tags = ARRAY['E_ENDPOINTS_IGNORED'],
  prompt = 'A function is continuous on $[1,5]$. Where can absolute extrema occur?',
  latex = 'A function is continuous on $[1,5]$. Where can absolute extrema occur?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','Only where $f''(x)=0$','explanation','Endpoints must be included.'),
    jsonb_build_object('id','B','text','Only at endpoints','explanation','Interior critical points must be checked.'),
    jsonb_build_object('id','C','text','At endpoints and critical points','explanation','Correct candidates test.'),
    jsonb_build_object('id','D','text','Only where $f''$ is undefined','explanation','Incomplete.')
  ),
  correct_option_id = 'C',
  tolerance = 0.0010,
  explanation = 'Absolute extrema occur at endpoints and interior critical points.',
  recommendation_reasons = ARRAY['Reinforces candidates test.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 2,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Include endpoints.',
  weight_primary = 0.85,
  weight_supporting = 0.15,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q3';

-- Q5 Update (from User Request)
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

-- Q9 Update (from User Request)
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

-- Sync Relation Table question_skills (For Q2, Q3, Q5, Q9)
DELETE FROM question_skills
WHERE question_id IN (
    SELECT id FROM questions WHERE title IN ('5.0-UT-Q2', '5.0-UT-Q3', '5.0-UT-Q5', '5.0-UT-Q9')
);

-- Insert PRIMARY skills (First in array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, skill_tags[1], 'primary'
FROM questions 
WHERE title IN ('5.0-UT-Q2', '5.0-UT-Q3', '5.0-UT-Q5', '5.0-UT-Q9')
  AND array_length(skill_tags, 1) >= 1;

-- Insert SUPPORTING skills (Rest of array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, unnest(skill_tags[2:]), 'supporting'
FROM questions
WHERE title IN ('5.0-UT-Q2', '5.0-UT-Q3', '5.0-UT-Q5', '5.0-UT-Q9')
  AND array_length(skill_tags, 1) >= 2;

COMMIT;
