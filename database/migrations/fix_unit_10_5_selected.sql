-- Fix Unit 10.5 Selected Questions (P2, P3, P4) based on User Screenshots
-- Fixes filename in prompt, p-series formatting, and standardizes fractions.

DO $$
BEGIN

    -- U10.5-P3 (Question 5 in screenshot)
    -- Fix: Remove filename. Fix option fractions.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.5-A. Which statement is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "Both $\\sum \\frac{1}{n}$ and $\\sum \\frac{1}{n^2}$ diverge because their terms approach $0$."},
            {"id": "B", "value": "$\\sum \\frac{1}{n}$ converges and $\\sum \\frac{1}{n^2}$ diverges."},
            {"id": "C", "value": "$\\sum \\frac{1}{n}$ diverges and $\\sum \\frac{1}{n^2}$ converges."},
            {"id": "D", "value": "Both series converge because the terms decrease."}
        ]$json$::jsonb
    WHERE title = 'U10.5-P3';

    -- U10.5-P4 (Question 1 in screenshot)
    -- Fix: "$p$-series" formatting and fractions.
    UPDATE public.questions
    SET 
        prompt = $prompt$Determine whether the series $\sum_{n=1}^{\infty} \frac{1}{n^{\frac{3}{2}}}$ converges or diverges.$prompt$,
        options = $json$[
            {"id": "A", "value": "Converges ($p$-series with $p = \\frac{3}{2} > 1$)"},
            {"id": "B", "value": "Diverges ($p$-series with $p = \\frac{3}{2} > 1$)"},
            {"id": "C", "value": "Converges because $\\frac{1}{n^{\\frac{3}{2}}} \\to 0$"},
            {"id": "D", "value": "Diverges because $\\frac{1}{n^{\\frac{3}{2}}} \\to 0$"}
        ]$json$::jsonb
    WHERE title = 'U10.5-P4';

    -- U10.5-P2 (Question 4 in screenshot)
    -- Fix: Standardize options to LaTeX fractions.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series is the harmonic series?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n}$"},
            {"id": "B", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{2^n}$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n!}$"}
        ]$json$::jsonb
    WHERE title = 'U10.5-P2';

END $$;
