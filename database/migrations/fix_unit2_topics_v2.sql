-- Fix Unit 2 Topics Consistency (Version 2)
-- Targets Unit 2 questions by Title pattern to catch Unit Tests (U2-UT-Q...) which have sub_topic_id='unit_test'

BEGIN;

-- 1. Update based on Title patterns (U2-...) which includes Unit Tests
UPDATE public.questions
SET
  topic = 'Both_Derivatives',
  course = 'Both'
WHERE
  title LIKE 'U2-%'
  AND (topic != 'Both_Derivatives' OR course != 'Both');

-- 2. Update based on Title patterns (2.x-...) which includes Practice questions
UPDATE public.questions
SET
  topic = 'Both_Derivatives',
  course = 'Both'
WHERE
  title LIKE '2.%'
  AND (topic != 'Both_Derivatives' OR course != 'Both');

-- 3. Safety net: specific sub_topic_id check again
UPDATE public.questions
SET
  topic = 'Both_Derivatives',
  course = 'Both'
WHERE
  sub_topic_id LIKE '2.%'
  AND (topic != 'Both_Derivatives' OR course != 'Both');

COMMIT;
