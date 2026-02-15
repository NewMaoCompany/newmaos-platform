-- Fix Unit 10.14 & 10.15 Summation Notation (\sum)
-- Also retries U10.13-P1 prompt fix.

DO $$
BEGIN

    -- U10.13-P1 (RETRY)
    -- Fix: Simplify LaTeX. Remove \left \right.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the radius of convergence of $\sum_{n=1}^{\infty} n (\frac{x}{3})^n$.$prompt$
    WHERE title = 'U10.13-P1';

    -- U10.14-P2
    -- Fix: \\\sum -> \sum in options.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} x^n$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} (-1)^n x^n$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} (-1)^n x^n$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^{2n}}{2n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.14-P2';

    -- U10.15-P1
    -- Fix: \\\sum -> \sum in options.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} (2x)^n$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} 2^n x^{n+1}$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} (-2x)^n$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} (2x)^n$"}
        ]$json$::jsonb
    WHERE title = 'U10.15-P1';

    -- U10.15-P3
    -- Fix: \\\sum -> \sum in options.
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
    -- Fix: \\\sum -> \sum in options.
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
