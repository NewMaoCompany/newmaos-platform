BEGIN;

-- 0. PRE-REQUISITE: Insert Skill Definitions (IF MISSING)
-- This avoids the "Key (skill_id)=(SK_...) is not present" FK error.
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
  ('SK_GRAPH_SKETCH', 'Curve Sketching', 'Unit 5', '{"SK_GRAPH_CONNECT"}'),
  ('SK_INCREASING_DECREASING', 'Increasing and Decreasing Behavior', 'Unit 5', '{"SK_SIGN_CHART"}'),
  ('SK_CONCAVITY', 'Concavity and Points of Inflection', 'Unit 5', '{"SK_SECOND_DERIV_TEST"}'),
  ('SK_EVT', 'Extreme Value Theorem', 'Unit 5', '{"SK_MVT"}'),
  ('SK_ABS_EXTREMA_CANDIDATES', 'Absolute Extrema Candidates Test', 'Unit 5', '{"SK_EVT"}'),
  ('SK_GRAPH_CONNECT', 'Connecting f, f'', f''''', 'Unit 5', '{"SK_GRAPH_MATCH"}'),
  ('SK_SIGN_CHART', 'Sign Chart Analysis', 'Unit 5', '{}'),
  ('SK_SECOND_DERIV_TEST', 'Second Derivative Test', 'Unit 5', '{"SK_FIRST_DERIV_TEST"}'),
  ('SK_MVT', 'Mean Value Theorem', 'Unit 5', '{}'),
  ('SK_GRAPH_MATCH', 'Matching Graphs to Functions', 'Unit 5', '{}'),
  ('SK_FIRST_DERIV_TEST', 'First Derivative Test', 'Unit 5', '{"SK_INCREASING_DECREASING"}')
ON CONFLICT (id) DO NOTHING;

-- Insert DEPENDENT Error Tags
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
  ('E_SIGN_CHART', 'Sign Chart Error', 'Procedural', 3, 'Unit 5'),
  ('E_CONCAVITY_SIGN', 'Concavity Sign Error', 'Conceptual', 3, 'Unit 5'),
  ('E_EVT_MISUSE', 'Misuse of Extreme Value Theorem', 'Conceptual', 3, 'Unit 5'),
  ('E_ENDPOINTS_IGNORED', 'Endpoints Ignored in Extrema Check', 'Procedural', 4, 'Unit 5')
ON CONFLICT (id) DO NOTHING;


-- 1. Q12 Update
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_Analytical',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 5,
  target_time_seconds = 180,
  -- Sync columns:
  primary_skill_id = 'SK_GRAPH_SKETCH',
  supporting_skill_ids = ARRAY['SK_INCREASING_DECREASING','SK_CONCAVITY'],
  skill_tags = ARRAY['SK_GRAPH_SKETCH','SK_INCREASING_DECREASING','SK_CONCAVITY'],
  error_tags = ARRAY['E_SIGN_CHART','E_CONCAVITY_SIGN'],
  prompt = 'A twice-differentiable function $f$ satisfies:
(i) $f''(x)>0$ for $x<0$,
(ii) $f''(x)<0$ for $0<x<2$,
(iii) $f''(x)>0$ for $x>2$.
Which statement must be true?',
  latex = 'A twice-differentiable function $f$ satisfies:
(i) $f''(x)>0$ for $x<0$,
(ii) $f''(x)<0$ for $0<x<2$,
(iii) $f''(x)>0$ for $x>2$.
Which statement must be true?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$f$ is increasing on $(0,2)$.','explanation','$f''(x)<0$ on $(0,2)$ means $f$ is decreasing there.'),
    jsonb_build_object('id','B','text','$f$ is decreasing on $(2,\\infty)$.','explanation','$f''(x)>0$ on $(2,\\infty)$ means $f$ is increasing there.'),
    jsonb_build_object('id','C','text','$f$ has a local minimum at $x=0$.','explanation','A local minimum would require $f''$ to change from $-$ to $+$ at $0$, but it changes from $+$ to $-$ here.'),
    jsonb_build_object('id','D','text','$f$ has a local maximum at $x=0$ and a local minimum at $x=2$.','explanation','Sign of $f''$ gives increasing to decreasing at $0$ (local max) and decreasing to increasing at $2$ (local min).')
  ),
  correct_option_id = 'D',
  tolerance = 0.0010,
  explanation = 'Since $f''(x)>0$ for $x<0$ and $f''(x)<0$ for $0<x<2$, $f$ changes from increasing to decreasing at $x=0$, so $f$ has a local maximum at $x=0$. Also, $f''(x)<0$ for $0<x<2$ and $f''(x)>0$ for $x>2$, so $f$ changes from decreasing to increasing at $x=2$, giving a local minimum at $x=2$.',
  recommendation_reasons = ARRAY['Synthesizes sign information into local-extrema conclusions.', 'Targets confusion between $f''$ sign and concavity vs monotonicity.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.25,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Local max: $f''$ changes $+\\to-$; local min: $-\\to+$.',
  weight_primary = 0.65,
  weight_supporting = 0.35,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_Analytical',
  updated_at = NOW()
WHERE title = '5.0-UT-Q12';


-- 2. Q2 Update
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


-- 3. Q3 Update
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

-- 4. Sync Relation Table question_skills (For Q12, Q2, Q3)
DELETE FROM question_skills
WHERE question_id IN (
    SELECT id FROM questions WHERE title IN ('5.0-UT-Q12', '5.0-UT-Q2', '5.0-UT-Q3')
);

-- Insert PRIMARY skills (First in array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, skill_tags[1], 'primary'
FROM questions 
WHERE title IN ('5.0-UT-Q12', '5.0-UT-Q2', '5.0-UT-Q3')
  AND array_length(skill_tags, 1) >= 1;

-- Insert SUPPORTING skills (Rest of array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, unnest(skill_tags[2:]), 'supporting'
FROM questions
WHERE title IN ('5.0-UT-Q12', '5.0-UT-Q2', '5.0-UT-Q3')
  AND array_length(skill_tags, 1) >= 2;

COMMIT;
