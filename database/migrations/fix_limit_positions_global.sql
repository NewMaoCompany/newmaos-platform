
-- Fix Limits in JSON-encoded prompts (escaped backslashes)
UPDATE public.questions
SET prompt = REGEXP_REPLACE(prompt, '\\\\lim_\{', '\\\\lim\\\\limits_{', 'g')
WHERE prompt LIKE '[%';

-- Fix Limits in Raw Text prompts (single backslashes)
UPDATE public.questions
SET prompt = REGEXP_REPLACE(prompt, '\\lim_\{', '\\lim\\limits_{', 'g')
WHERE prompt NOT LIKE '[%';

-- Also fix the Option explanations and values if they span multiple lines or complex math?
-- Usually text in options is raw text or JSON?
-- "options" column is JSONB. simple update on JSONB is harder.
-- But usually limits in options value field: "value": "..."
-- If "value": "...", the JSONB string representation has escaped backslashes.
-- We can cast to text, replace, cast back?
-- UPDATE public.questions SET options = REGEXP_REPLACE(options::text, '\\\\lim_\{', '\\\\lim\\\\limits_{', 'g')::jsonb;

UPDATE public.questions
SET options = REGEXP_REPLACE(options::text, '\\\\lim_\{', '\\\\lim\\\\limits_{', 'g')::jsonb;
