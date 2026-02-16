BEGIN;

-- Update Question 8.0-UT-Q12
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 4,
  target_time_seconds = 150,
  -- Sync columns with array from user request
  primary_skill_id = 'SK_VOLUME_WASHER',
  supporting_skill_ids = ARRAY['SK_SETUP_INTEGRAL'],
  skill_tags = ARRAY['SK_VOLUME_WASHER', 'SK_SETUP_INTEGRAL'],
  error_tags = ARRAY['E_WRONG_RADIUS', 'E_FORGET_SQUARE', 'E_LIMITS_SWAP'],
  prompt = 'The region between $y=x$ and $y=x^2$ on $0\\le x\\le 1$ is shown in 8.0-UT-Q12.png. It is revolved about $y=3$. Which integral gives the volume?',
  latex = 'The region between $y=x$ and $y=x^2$ on $0\\le x\\le 1$ is shown in 8.0-UT-Q12.png. It is revolved about $y=3$. Which integral gives the volume?\n\n![8.0-UT-Q12](8.0-UT-Q12.png)',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$\\pi\\int_0^1\\big((3-x)^2-(3-x^2)^2\\big)dx$','explanation','This reverses outer and inner radii; must have $R\\ge r$.'),
    jsonb_build_object('id','B','text','$\\pi\\int_0^1\\big((3-x^2)^2-(3-x)^2\\big)dx$','explanation','Correct: outer radius uses the lower curve $y=x^2$ so $R=3-x^2$, inner uses $y=x$ so $r=3-x$.'),
    jsonb_build_object('id','C','text','$\\pi\\int_0^1\\big((3-x^2)-(3-x)\\big)dx$','explanation','Missing squares on radii.'),
    jsonb_build_object('id','D','text','$2\\pi\\int_0^1 (3-x)(x-x^2)dx$','explanation','This is not the washer formula for rotation about a horizontal line.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Distances to $y=3$ give radii. Since $x^2\\le x$ on $[0,1]$, the lower curve is $y=x^2$ and is farther from $y=3$, so $R=3-x^2$ and $r=3-x$.\n$$V=\\pi\\int_0^1\\left((3-x^2)^2-(3-x)^2\\right)dx.$$',
  recommendation_reasons = ARRAY['Targets shifted-axis washer radii.', 'Prevents swapping outer/inner radii.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 4,
  mastery_weight = 1.10,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Washers about $y=3$ with vertical slices ($dx$).',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text_and_image',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE title = '8.0-UT-Q12';

-- Sync question_skills
DELETE FROM question_skills
WHERE question_id IN (SELECT id FROM questions WHERE title = '8.0-UT-Q12');

-- Insert PRIMARY skills
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, 'SK_VOLUME_WASHER', 'primary'
FROM questions WHERE title = '8.0-UT-Q12';

-- Insert SUPPORTING skills
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, 'SK_SETUP_INTEGRAL', 'supporting'
FROM questions WHERE title = '8.0-UT-Q12';

COMMIT;
