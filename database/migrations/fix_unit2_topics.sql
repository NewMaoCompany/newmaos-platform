-- Fix Unit 2 Topics Consistency
-- Standardizes all Unit 2 questions to use 'Both_Derivatives' and course 'Both'

BEGIN;

-- 1. Standardize Unit 2 topics
UPDATE public.questions
SET
  topic = 'Both_Derivatives',
  course = 'Both'
WHERE
  sub_topic_id LIKE '2.%'
  AND (topic != 'Both_Derivatives' OR course != 'Both');

-- 2. Clean up any remaining ABBC_Derivatives if they were intended for Unit 2 but missed the sub_topic check (safety net)
-- Only targeting Derivatives topics, likely Unit 2 or 3.
-- Restricting to known Unit 2 scope for safety.
UPDATE public.questions
SET
  topic = 'Both_Derivatives',
  course = 'Both'
WHERE
  topic = 'ABBC_Derivatives'
  AND sub_topic_id LIKE '2.%';

COMMIT;
