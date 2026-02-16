-- 1. Ensure the new topic exists
INSERT INTO public.topic_content (id, title)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO UPDATE
SET title = EXCLUDED.title;

-- 2. Update any existing questions with the old Unit 10 topic identifier
UPDATE public.questions
SET 
    topic = 'BC_Series',
    topic_id = 'BC_Series'
WHERE 
    topic = 'BC_Unit10' OR topic = 'Unit 10' OR topic = 'Unit10' OR 
    (topic IS NULL AND title LIKE '10.%');

-- 3. Update any existing unit test questions with the old topic identifier
UPDATE public.questions
SET
    topic = 'BC_Series',
    topic_id = 'BC_Series'
WHERE
    title LIKE '10.%-UT-%' AND topic IS DISTINCT FROM 'BC_Series';
    
-- Optionally, you can remove the old topic if no longer used by any questions
-- DELETE FROM public.topic_content WHERE id = 'BC_Unit10';
