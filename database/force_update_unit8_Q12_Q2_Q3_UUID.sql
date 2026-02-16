BEGIN;

-- 1. Insert Missing Uppercase Skills for Unit 8
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
  ('SK_VOLUME_WASHER', 'Volume by Washer Method', 'Unit 8', '{"SK_VOLUME_DISC"}'),
  ('SK_SETUP_INTEGRAL', 'Setting up Definite Integrals', 'Unit 8', '{}'),
  ('SK_MOTION_DISTANCE', 'Total Distance Traveled', 'Unit 8', '{"SK_MOTION_V_FROM_A"}'),
  ('SK_SIGN_ANALYSIS', 'Sign Analysis', 'Unit 8', '{}'),
  ('SK_ACCUMULATION', 'Accumulation Function', 'Unit 8', '{"SK_DEF_INT_PROP"}'),
  ('SK_EVAL_DEF_INT', 'Evaluating Definite Integrals', 'Unit 8', '{"SK_FTC"}'),
  ('SK_VOLUME_DISC', 'Volume by Disc Method', 'Unit 8', '{}'),
  ('SK_MOTION_V_FROM_A', 'Velocity from Acceleration', 'Unit 8', '{}'),
  ('SK_DEF_INT_PROP', 'Properties of Definite Integrals', 'Unit 8', '{}'),
  ('SK_FTC', 'Fundamental Theorem of Calculus', 'Unit 8', '{}')
ON CONFLICT (id) DO UPDATE SET unit = EXCLUDED.unit;

-- Insert Error Tags if missing
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
  ('E_WRONG_RADIUS', 'Wrong Radius Definition', 'Conceptual', 4, 'Unit 8'),
  ('E_FORGET_SQUARE', 'Forgot to Square Term', 'Procedural', 3, 'Unit 8'),
  ('E_LIMITS_SWAP', 'Limits Swapped', 'Conceptual', 3, 'Unit 8'),
  ('E_SIGN_ERROR', 'Sign Error', 'Procedural', 3, 'Unit 8'),
  ('E_MISSING_ABS', 'Missing Absolute Value', 'Conceptual', 3, 'Unit 8'),
  ('E_ACCUMULATION_CONFUSE', 'Accumulation Concept Confusion', 'Conceptual', 4, 'Unit 8'),
  ('E_FTC_MISAPPLY', 'Misapplication of FTC', 'Conceptual', 4, 'Unit 8')
ON CONFLICT (id) DO NOTHING;


-- 2. Update Question 12 (Unit 8) BY UUID
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
WHERE id = 'a5266a5e-801a-42eb-b4a8-035d81680c60'; -- Explicit ID for Q12


-- 3. Update Question 2 (Unit 8) BY UUID
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  primary_skill_id = 'SK_MOTION_DISTANCE',
  supporting_skill_ids = ARRAY['SK_SIGN_ANALYSIS'],
  skill_tags = ARRAY['SK_MOTION_DISTANCE', 'SK_SIGN_ANALYSIS'],
  error_tags = ARRAY['E_SIGN_ERROR', 'E_MISSING_ABS'],
  prompt = 'A particle moves on a line with velocity $v(t)=2t-5$ (m/s) for $0\\le t\\le 6$. What is the total distance traveled on $[0,6]$?',
  latex = 'A particle moves on a line with velocity $v(t)=2t-5$ (m/s) for $0\\le t\\le 6$. What is the total distance traveled on $[0,6]$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$6$','explanation','This is the displacement $\\int_0^6(2t-5)dt$, not total distance.'),
    jsonb_build_object('id','B','text','$19$','explanation','Correct: split at $t=2.5$ and compute $\\int_0^{2.5}(5-2t)dt+\\int_{2.5}^6(2t-5)dt=19$.'),
    jsonb_build_object('id','C','text','$13$','explanation','This usually comes from applying absolute value on only one subinterval.'),
    jsonb_build_object('id','D','text','$0$','explanation','Over a full interval, displacement can cancel, but distance cannot.')
  ),
  correct_option_id = 'B',
  tolerance = 0.0010,
  explanation = 'Total distance is $\\int_0^6|v(t)|dt$. Since $2t-5=0$ at $t=2.5$,\n$$\\int_0^{2.5}(5-2t)dt+\\int_{2.5}^6(2t-5)dt=6.25+12.75=19.$$',
  recommendation_reasons = ARRAY['Separates displacement from total distance.', 'Forces splitting at the sign-change time.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Total distance requires absolute value of velocity.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE id = 'ffa716d6-6dfa-4e60-aef7-f7a2abad2420'; -- Explicit ID for Q2


-- 4. Update Question 3 (Unit 8) BY UUID
UPDATE public.questions
SET
  course = 'Both',
  topic = 'Both_AppIntegration',
  sub_topic_id = 'unit_test',
  section_id = 'unit_test',
  type = 'MCQ',
  calculator_allowed = FALSE,
  difficulty = 3,
  target_time_seconds = 120,
  primary_skill_id = 'SK_ACCUMULATION',
  supporting_skill_ids = ARRAY['SK_EVAL_DEF_INT'],
  skill_tags = ARRAY['SK_ACCUMULATION', 'SK_EVAL_DEF_INT'],
  error_tags = ARRAY['E_ACCUMULATION_CONFUSE', 'E_SIGN_ERROR'],
  prompt = 'Water flows into a tank at rate $R(t)=4+\\sin t$ liters/minute for $0\\le t\\le \\pi$. The tank initially contains $10$ liters. How much water is in the tank at $t=\\pi$?',
  latex = 'Water flows into a tank at rate $R(t)=4+\\sin t$ liters/minute for $0\\le t\\le \\pi$. The tank initially contains $10$ liters. How much water is in the tank at $t=\\pi$?',
  options = jsonb_build_array(
    jsonb_build_object('id','A','text','$10+4\\pi+2$','explanation','Correct: add the initial amount to the accumulated inflow.'),
    jsonb_build_object('id','B','text','$4\\pi+2$','explanation','This is the change in amount, but it omits the initial $10$ liters.'),
    jsonb_build_object('id','C','text','$10+4\\pi-2$','explanation','Incorrect evaluation of $\\int_0^\\pi \\sin t\\,dt$.'),
    jsonb_build_object('id','D','text','$10+4\\pi$','explanation','This ignores the sine contribution to the inflow.')
  ),
  correct_option_id = 'A',
  tolerance = 0.0010,
  explanation = 'Amount equals initial plus accumulation:\n$$A(\\pi)=10+\\int_0^\\pi(4+\\sin t)dt=10+4\\pi+2.$$',
  recommendation_reasons = ARRAY['Reinforces “initial + integral of rate”.', 'Targets the common mistake of reporting only the net change.'],
  status = 'published',
  version = version + 1,
  reasoning_level = 3,
  mastery_weight = 1.00,
  source = 'NewMaoS',
  source_year = 2026,
  notes = 'Accumulation with initial condition.',
  weight_primary = 0.70,
  weight_supporting = 0.30,
  prompt_type = 'text',
  representation_type = 'symbolic',
  topic_id = 'Both_AppIntegration',
  updated_at = NOW()
WHERE id = '1b426fb4-0188-4cb3-8bde-df050cd920a7'; -- Explicit ID for Q3


-- 5. Sync Relation Table question_skills (For Q12, Q2, Q3)
DELETE FROM question_skills
WHERE question_id IN (
    'a5266a5e-801a-42eb-b4a8-035d81680c60',
    'ffa716d6-6dfa-4e60-aef7-f7a2abad2420',
    '1b426fb4-0188-4cb3-8bde-df050cd920a7'
);

-- Insert PRIMARY skills (First in array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, skill_tags[1], 'primary'
FROM questions 
WHERE id IN (
  'a5266a5e-801a-42eb-b4a8-035d81680c60',
  'ffa716d6-6dfa-4e60-aef7-f7a2abad2420',
  '1b426fb4-0188-4cb3-8bde-df050cd920a7'
)
  AND array_length(skill_tags, 1) >= 1;

-- Insert SUPPORTING skills (Rest of array)
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, unnest(skill_tags[2:]), 'supporting'
FROM questions
WHERE id IN (
  'a5266a5e-801a-42eb-b4a8-035d81680c60',
  'ffa716d6-6dfa-4e60-aef7-f7a2abad2420',
  '1b426fb4-0188-4cb3-8bde-df050cd920a7'
)
  AND array_length(skill_tags, 1) >= 2;

COMMIT;
