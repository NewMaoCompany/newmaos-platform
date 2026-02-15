-- Fix Unit 10.15 Options Formatting
-- Standardizes inline division (/) to LaTeX fractions (\frac{}{}).

DO $$
BEGIN

    -- U10.15-P2
    -- Fix: 1/(1-2x) -> \frac{1}{1-2x} etc.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{1-2x}$"},
            {"id": "B", "value": "$\\frac{1}{1-x}$"},
            {"id": "C", "value": "$\\ln(1+x)$"},
            {"id": "D", "value": "$e^x$"}
        ]$json$::jsonb
    WHERE title = 'U10.15-P2';

    -- U10.15-P3
    -- Fix: x^n/(n+1) -> \frac{x^n}{n+1}
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} n x^{n-1}$"},
            {"id": "B", "value": "$\\sum_{n=1}^{\\infty} n x^{n-1}$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} (n+1)x^n$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^n}{n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.15-P3';

    -- U10.15-P4
    -- Fix: inline division in options.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{n+1}}{n+1}$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^n}{n+1}$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} (-1)^n \\frac{x^n}{n+1}$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{2n+1}}{2n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.15-P4';

END $$;
