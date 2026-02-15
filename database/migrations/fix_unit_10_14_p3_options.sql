-- Fix Unit 10.14-P3 Options Formatting
-- Replaces ugly exponent fractions (x^\frac{2}{2}) and inline division (1/(1-x)) with standard \frac.
-- Fixes spacing for plus and minus signs.

DO $$
BEGIN

    -- U10.14-P3
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\ln(1+x) = x - \\frac{x^2}{2} + \\frac{x^3}{3} - \\frac{x^4}{4} + \\dots$"},
            {"id": "B", "value": "$\\frac{1}{1-x} = 1 + x + x^2 + x^3 + \\dots$"},
            {"id": "C", "value": "$e^x = 1 + x + \\frac{x^2}{2} + \\frac{x^3}{6} + \\dots$"},
            {"id": "D", "value": "$\\sin x = x - \\frac{x^3}{6} + \\frac{x^5}{120} - \\dots$"}
        ]$json$::jsonb
    WHERE title = 'U10.14-P3';

END $$;
