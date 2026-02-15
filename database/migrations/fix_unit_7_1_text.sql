-- Fix Unit 7.1 Q4 Text Only
-- User request: Change "file u7_7_1_rate_table.png" to "U7.1rate table"

UPDATE public.questions
SET
    prompt = $txt$Use the rate table in U7.1rate table. Which differential equation best matches the data?$txt$,
    latex = $txt$Use the rate table in U7.1rate table. Which differential equation best matches the data?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%rate table%u7_7_1_rate_table%';
