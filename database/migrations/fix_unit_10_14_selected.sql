-- Fix Unit 10.14 Selected Questions (P1, P3, P4)
-- Fixes broken fraction formatting in power series options and removes filenames.

DO $$
BEGIN

    -- U10.14-P1
    -- Fix: Text-style fractions x^\frac{n}{n}! -> \frac{x^n}{n!}
    UPDATE public.questions
    SET 
        prompt = $prompt$Which power series represents $\frac{1}{1-x}$ for $|x| < 1$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} x^n$"},
            {"id": "B", "value": "$\\sum_{n=1}^{\\infty} x^n$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} (-1)^n x^n$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^n}{n!}$"}
        ]$json$::jsonb
    WHERE title = 'U10.14-P1';

    -- U10.14-P3
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.14-A. The shown coefficients match the beginning of which series?$prompt$
    WHERE title = 'U10.14-P3';

    -- U10.14-P4
    -- Fix: Text-style fractions x^\frac{n}{n}! -> \frac{x^n}{n!} in Option C.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series equals $\arctan(x)$ for $|x| \le 1$ (with convergence at endpoints in the usual sense)?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{2n+1}}{2n+1}$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^{2n+1}}{2n+1}$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^n}{n!}$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{2n}}{2n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.14-P4';

END $$;
