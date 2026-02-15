-- Fix Unit 10 Unit Test Q16 (U10-UT-Q16)
-- Removes filename from prompt and forces LaTeX rendering for options.

DO $$
BEGIN

    -- U10-UT-Q16
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Figure 10.13-A. Which \interval is shown?$prompt$,
        options = $json$[
            {"id": "A", "value": "$(0, 2)$"},
            {"id": "B", "value": "$[0, 2)$"},
            {"id": "C", "value": "$(0, 2]$"},
            {"id": "D", "value": "$[0, 2]$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q16';

END $$;
