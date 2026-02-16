-- Fix Unit 9 Topic: BC_Unit9 -> BC_Motion

BEGIN;

-- 1. Ensure the new topic exists in public.topic_content
INSERT INTO public.topic_content (id, title)
VALUES ('BC_Motion', 'Unit 9: Parametric, Polar, and Vector-Valued Functions')
ON CONFLICT (id) DO NOTHING;

-- 2. Update all questions to use the new topic
UPDATE public.questions
SET topic = 'BC_Motion'
WHERE topic = 'BC_Unit9';

-- 3. Update skills if they reference the unit name in a way that matches the topic (optional, but good for consistency if 'unit' column matches topic)
-- Checking schema, skills has a 'unit' column. Typically this is 'Unit 9', not 'BC_Unit9', but we can check.
-- If 'unit' column uses 'BC_Unit9', update it.
UPDATE public.skills
SET unit = 'BC_Motion'
WHERE unit = 'BC_Unit9';

COMMIT;
