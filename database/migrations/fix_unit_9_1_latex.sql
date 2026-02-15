-- Fix Unit 9.1 LaTeX Formatting (U9.1-P4, U9.1-P5)
-- Addresses linear division formatting in options (e.g., 1/2x -> \frac{1}{2}x)
-- Fix: Uses named dollar quotes ($json$ ... $json$) to avoid conflict with outer DO $$ block.

DO $$
BEGIN

    -- U9.1-P4: Fix linear division in option D
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$y = x - 1$"},
        {"id": "B", "value": "$y = -x + 1$"},
        {"id": "C", "value": "$y = 2x - 2$"},
        {"id": "D", "value": "$y = \\frac{1}{2}x - \\frac{1}{2}$"}
    ]$json$::jsonb
    WHERE title = 'U9.1-P4';

    -- U9.1-P5: Fix linear division in options A and C
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$y = \\left(\\frac{x-1}{2}\\right)^2$"},
        {"id": "B", "value": "$y = \\frac{x-1}{2}$"},
        {"id": "C", "value": "$y = \\left(\\frac{2}{x-1}\\right)^2$"},
        {"id": "D", "value": "$y = (x-1)^2$"}
    ]$json$::jsonb
    WHERE title = 'U9.1-P5';

END $$;
