BEGIN;

-- Update course to 'BC' for problems P1-P5 in sections 6.11, 6.12, 6.13, 7.5, 7.9, 8.13
-- Pattern: '<section>-P<1-5>' (e.g., '6.11-P1', '8.13-P5')

UPDATE public.questions
SET course = 'BC'
WHERE title SIMILAR TO '(6.11|6.12|6.13|7.5|7.9|8.13)-P[1-5]%'
   OR title SIMILAR TO '(6.11|6.12|6.13|7.5|7.9|8.13)-P[1-5]';

-- Note: The % wildcard covers cases with suffixes if any, but strictly speaking P1-P5 usually have cleaner titles.
-- Using regex for cleaner matching:
-- title ~ '^(6\.11|6\.12|6\.13|7\.5|7\.9|8\.13)-P[1-5]$'

UPDATE public.questions
SET course = 'BC'
WHERE title ~ '^(6\.11|6\.12|6\.13|7\.5|7\.9|8\.13)-P[1-5]$';

COMMIT;
