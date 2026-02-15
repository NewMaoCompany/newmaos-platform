
-- Fix LIMIT syntax in JSON prompts: Move superscript -/+ inside the limit subscript
-- Improved Regex: Handles optional \limits (e.g. \lim\limits_{...}^-)
-- Matches: \lim (optional \limits) _{ content } ^ (- or +)
-- Group 1: (\s*\\limits)?  -- Optional \limits
-- Group 2: ([^{}]*)        -- Content inside braces
-- Group 3: ([-+])          -- The sign

-- NOTE: Using 2 backslashes for \lim in Python r-string => SQL '\\lim' => Regex matches literal '\lim'
-- Using 1 backslash for \^ in Python r-string => SQL '\^' => Regex matches literal '^'

UPDATE public.questions
SET prompt = REGEXP_REPLACE(prompt, '\\lim(\\s*\\limits)?_\{([^{}]*)\}\\^([-+])', '\\lim\1_{\2\3}', 'g')
WHERE prompt LIKE '[%';

-- 2. JSON: \lim^..._{...} (Superscript FIRST)
-- Matches: \lim (opt \limits) ^ (- or +) _{ content }
-- Group 1: (\s*\\limits)?
-- Group 2: ([-+])
-- Group 3: ([^{}]*)
UPDATE public.questions
SET prompt = REGEXP_REPLACE(prompt, '\\lim(\\s*\\limits)?\\^([-+])_\{([^{}]*)\}', '\\lim\1_{\3\2}', 'g')
WHERE prompt LIKE '[%';

-- Fix LIMIT syntax in Raw Text prompts

-- 1. Raw: \lim_{...}^-
UPDATE public.questions
SET prompt = REGEXP_REPLACE(prompt, '\\lim(\\s*\\limits)?_\{([^{}]*)\}\\^([-+])', '\\lim\1_{\2\3}', 'g')
WHERE prompt NOT LIKE '[%';

-- 2. Raw: \lim^-_{...}
UPDATE public.questions
SET prompt = REGEXP_REPLACE(prompt, '\\lim(\\s*\\limits)?\\^([-+])_\{([^{}]*)\}', '\\lim\1_{\3\2}', 'g')
WHERE prompt NOT LIKE '[%';

-- Fix Options as well (JSONB)
-- 1. Subscript first
UPDATE public.questions
SET options = REGEXP_REPLACE(options::text, '\\\\lim(\\s*\\\\limits)?_\{([^{}]*)\}\\\\^([-+])', '\\\\lim\1_{\2\3}', 'g')::jsonb;

-- 2. Superscript first
-- NOTE: For Options, we retain 4 backslashes IF options are double-escaped? 
-- The user said "Global fix". The options table is likely single-escaped in the JSONB value (as seen in attempts 1-5 analysis).
-- JSONB::text converts to textual representation.
-- If value is '\lim', jsonb::text is '"\\lim"'. (Double escaped).
-- So Regexp on `options::text` needs to match `\\lim`.
-- So Regex needs `\\\\lim`.
-- So Python needs 4 backslashes `\\\\lim`.
-- So I should KEEP 4 backslashes for the OPTIONS updates!
-- BUT wait. The user's specific fix (Attempt 5) fixed the OPTION storage.
-- My manual fix for 4a20b9f3 used `\\lim` in standard text.
-- If I use `REGEXP_REPLACE` on `options::text`.
-- '{"v": "\\lim"}'::jsonb::text -> '{"v": "\\lim"}'.
-- The string contains `\\lim`.
-- So regex `\\\\lim` is CORRECT for options::text.
-- So I should ONLY change the PROMPT updates (1-4) to single backslash `\\lim`.
-- AND keep OPTIONS updates (5-6) as double backslash `\\\\lim`.

-- WAIT. The prompt update (1-2) targets `prompt LIKE '[%'`.
-- This is JSON array stored as text.
-- `["\lim"]`.
-- Text value in DB is `["\lim"]`. (Single slash).
-- So Prompt updates needs `\\lim`. (Correct).

-- SO: Prompt updates -> Change to `\\lim`.
-- Options updates -> Keep `\\\\lim`.

-- Let's adjust the replacement content to reflect this mixed strategy.
-- PROMPT Section: `\\lim`, `\\limits`, `\\^` (Wait. `\\^` or `\^`? If Prompt is `["...^..."]`, `^` is literal. So `\^`).
-- OPTIONS Section: `\\\\lim`, `\\\\limits`. `\\\\^`? 
-- jsonb::text of `^` is `^`.
-- So regex `\^`.
-- So `\\\\^` -> `\^` in Options too. (Because `^` is not escaped in JSON string).

-- Redoing Options logic:
-- `options::text` of `{"a": "^"}` is `{"a": "^"}`.
-- So `^` is just `^`.
-- So regex must match `^`. So `\^`.
-- So `\\\\^` was definitely wrong everywhere.

-- Summary:
-- Prompts: `\\lim`, `\\limits`, `\^`.
-- Options: `\\\\lim`, `\\\\limits`, `\^`.

UPDATE public.questions
SET options = REGEXP_REPLACE(options::text, '\\\\lim(\\s*\\\\limits)?_\{([^{}]*)\}\\^([-+])', '\\\\lim\1_{\2\3}', 'g')::jsonb;

UPDATE public.questions
SET options = REGEXP_REPLACE(options::text, '\\\\lim(\\s*\\\\limits)?\\^([-+])_\{([^{}]*)\}', '\\\\lim\1_{\3\2}', 'g')::jsonb;
