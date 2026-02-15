-- Fix Unit 10.8 All Questions (P1 - P5)
-- Fixes limit formatting, filename removal, fractions, and ratio test notation.

DO $$
BEGIN

    -- U10.8-P1
    -- Fix: excessive backslashes in \lim, text "limit" in prompt, ratio notation in options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Apply the Ratio Test to $\sum_{n=1}^{\infty} \frac{n!}{3^n}$. Which limit is used?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\lim_{n \\to \\infty} \\left|\\frac{a_n}{a_{n+1}}\\right|$"},
            {"id": "B", "value": "$\\lim_{n \\to \\infty} \\left|\\frac{a_{n+1}}{a_n}\\right|$"},
            {"id": "C", "value": "$\\lim_{n \\to \\infty} a_n$"},
            {"id": "D", "value": "$\\lim_{n \\to \\infty} \\frac{a_n}{n}$"}
        ]$json$::jsonb,
        explanation = $exp$The Ratio Test uses $L = \lim_{n \to \infty} \left|\frac{a_{n+1}}{a_n}\right|$ when the limit exists.$exp$
    WHERE title = 'U10.8-P1';

    -- U10.8-P2
    -- Fix: Fraction formatting in options (text -> latex), abs value formatting.
    UPDATE public.questions
    SET 
        prompt = $prompt$For $a_n = \frac{n!}{3^n}$, compute $\left| \frac{a_{n+1}}{a_n} \right|$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{n+1}{3}$"},
            {"id": "B", "value": "$\\frac{3}{n+1}$"},
            {"id": "C", "value": "$\\frac{n}{3}$"},
            {"id": "D", "value": "$\\frac{3}{n}$"}
        ]$json$::jsonb,
        explanation = $exp$\left|\frac{a_{n+1}}{a_n}\right| = \frac{(n+1)!/3^{n+1}}{n!/3^n} = \frac{n+1}{3}.$exp$
    WHERE title = 'U10.8-P2';

    -- U10.8-P3
    -- Fix: Remove filename. Fix |ratio| notation.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.8-A for $a_n = \frac{n!}{2^n}$. Based on the Ratio Test, what is the behavior of $\sum_{n=1}^{\infty} a_n$?$prompt$,
        options = $json$[
            {"id": "A", "value": "Converges because $|\\frac{a_{n+1}}{a_n}| < 1$ for the shown values."},
            {"id": "B", "value": "Diverges because $|\\frac{a_{n+1}}{a_n}|$ grows beyond $1$ as $n$ increases."},
            {"id": "C", "value": "Converges absolutely because the terms are positive."},
            {"id": "D", "value": "The Ratio Test is inconclusive because the ratio is not constant."}
        ]$json$::jsonb,
        explanation = $exp$Here $\left|\frac{a_{n+1}}{a_n}\right| = \frac{n+1}{2} \to \infty$, so $L > 1$ and the series diverges by the Ratio Test.$exp$
    WHERE title = 'U10.8-P3';

    -- U10.8-P4
    -- Fix: excessive backslashes in \lim, abs notation.
    UPDATE public.questions
    SET 
        prompt = $prompt$The Ratio Test gives $L = \lim_{n \to \infty} \left| \frac{a_{n+1}}{a_n} \right| = 1$. What can you conclude?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges."},
            {"id": "B", "value": "The series diverges."},
            {"id": "C", "value": "The Ratio Test is inconclusive."},
            {"id": "D", "value": "The series is geometric."}
        ]$json$::jsonb
    WHERE title = 'U10.8-P4';

    -- U10.8-P5
    -- Fix: Ensure capitalization of Ratio Test. Standardize fractions to \frac.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series is typically best matched to the Ratio Test as a first choice?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "$\\sum \\frac{\\ln(n)}{n}$"},
            {"id": "C", "value": "$\\sum \\frac{n!}{5^n}$"},
            {"id": "D", "value": "$\\sum \\frac{1}{n}$"}
        ]$json$::jsonb
    WHERE title = 'U10.8-P5';

END $$;
