BEGIN;

UPDATE public.questions
SET course = 'BC'
WHERE topic IN ('BC_Motion', 'BC_Series');

COMMIT;
