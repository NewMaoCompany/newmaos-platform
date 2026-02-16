BEGIN;

-- 1. Insert Missing Uppercase Skills for Unit 8 (from screenshot)
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
  ('SK_CROSS_SECTIONS_SQUARE', 'Volume by Cross Sections (Squares)', 'Unit 8', '{}'),
  ('SK_AVG_VALUE_FROM_GRAPH', 'Average Value from Graph/Table', 'Unit 8', '{"SK_AVG_VALUE_FORMULA"}'),
  ('SK_AVG_VALUE_INTERPRETATION', 'Interpretation of Average Value', 'Unit 8', '{"SK_AVG_VALUE_FORMULA"}'),
  ('SK_AVG_VALUE_FORMULA', 'Average Value Formula', 'Unit 8', '{}'),
  ('SK_VOLUME_CROSS_SECTIONS_SETUP', 'Volume by Cross Sections Setup', 'Unit 8', '{}'),
  ('SK_UNITS_INTERPRETATION', 'Units Interpretation in Applications', 'Unit 8', '{}')
ON CONFLICT (id) DO UPDATE SET unit = EXCLUDED.unit;

-- 2. Update Question 1 (a5266a5e...) - Cross Sections Square
UPDATE public.questions
SET
  primary_skill_id = 'SK_CROSS_SECTIONS_SQUARE',
  supporting_skill_ids = ARRAY['SK_VOLUME_CROSS_SECTIONS_SETUP'],
  skill_tags = ARRAY['SK_CROSS_SECTIONS_SQUARE', 'SK_VOLUME_CROSS_SECTIONS_SETUP'],
  updated_at = NOW()
WHERE id = 'a5266a5e-801a-42eb-b4a8-035d81680c60';

-- 3. Update Question 2 (ffa716d6...) - Average Value From Graph
UPDATE public.questions
SET
  primary_skill_id = 'SK_AVG_VALUE_FROM_GRAPH',
  supporting_skill_ids = ARRAY['SK_AVG_VALUE_FORMULA'],
  skill_tags = ARRAY['SK_AVG_VALUE_FROM_GRAPH', 'SK_AVG_VALUE_FORMULA'],
  updated_at = NOW()
WHERE id = 'ffa716d6-6dfa-4e60-aef7-f7a2abad2420';

-- 4. Update Question 3 (1b426fb4...) - Average Value Interpretation
UPDATE public.questions
SET
  primary_skill_id = 'SK_AVG_VALUE_INTERPRETATION',
  supporting_skill_ids = ARRAY['SK_UNITS_INTERPRETATION'],
  skill_tags = ARRAY['SK_AVG_VALUE_INTERPRETATION', 'SK_UNITS_INTERPRETATION'],
  updated_at = NOW()
WHERE id = '1b426fb4-0188-4cb3-8bde-df050cd920a7';


-- 5. Sync question_skills table for these 3 questions
DELETE FROM question_skills 
WHERE question_id IN (
  'a5266a5e-801a-42eb-b4a8-035d81680c60',
  'ffa716d6-6dfa-4e60-aef7-f7a2abad2420',
  '1b426fb4-0188-4cb3-8bde-df050cd920a7'
);

-- Insert Primary
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, skill_tags[1], 'primary'
FROM questions
WHERE id IN (
  'a5266a5e-801a-42eb-b4a8-035d81680c60',
  'ffa716d6-6dfa-4e60-aef7-f7a2abad2420',
  '1b426fb4-0188-4cb3-8bde-df050cd920a7'
);

-- Insert Supporting
INSERT INTO question_skills (question_id, skill_id, role)
SELECT id, unnest(skill_tags[2:]), 'supporting'
FROM questions
WHERE id IN (
  'a5266a5e-801a-42eb-b4a8-035d81680c60',
  'ffa716d6-6dfa-4e60-aef7-f7a2abad2420',
  '1b426fb4-0188-4cb3-8bde-df050cd920a7'
);

COMMIT;
