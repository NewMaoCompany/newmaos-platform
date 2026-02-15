-- Fix Unit 10.11 Selected Questions (P1 - P5)
-- Fixes exponent fractions (x^\frac{2}{2} -> \frac{x^2}{2}), filenames, and excessive backslashes.

DO $$
BEGIN

    -- U10.11-P1
    -- Fix: x^\frac{2}{2} to \frac{x^2}{2} in options A and C.
    UPDATE public.questions
    SET 
        prompt = $prompt$What is the 2nd-degree Maclaurin polynomial for $e^x$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$1 + x + \\frac{x^2}{2}$"},
            {"id": "B", "value": "$1 + x + x^2$"},
            {"id": "C", "value": "$1 + \\frac{x}{2} + \\frac{x^2}{2}$"},
            {"id": "D", "value": "$1 + x + \\frac{x^3}{6}$"}
        ]$json$::jsonb
    WHERE title = 'U10.11-P1';

    -- U10.11-P2
    -- Fix: \frac formatting in explanation and options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Use the 2nd-degree Maclaurin polynomial for $e^x$ to approximate $e^{0.2}$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$1.02$"},
            {"id": "B", "value": "$1.20$"},
            {"id": "C", "value": "$1.22$"},
            {"id": "D", "value": "$1.24$"}
        ]$json$::jsonb
    WHERE title = 'U10.11-P2';

    -- U10.11-P3
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.11-A, where $T_2(x) = 1 + x + \frac{x^2}{2}$ approximates $e^x$. Which statement is best supported by the table?$prompt$
    WHERE title = 'U10.11-P3';

    -- U10.11-P4
    -- Fix: Clean up prompt (remove \second) backslashes.
    UPDATE public.questions
    SET 
        prompt = $prompt$A Taylor polynomial centered at $x=0$ is required to match a function’s value, first derivative, and second derivative at $0$. What is the minimum degree needed?$prompt$,
        options = $json$[
            {"id": "A", "value": "Degree 0"},
            {"id": "B", "value": "Degree 1"},
            {"id": "C", "value": "Degree 2"},
            {"id": "D", "value": "Degree 3"}
        ]$json$::jsonb,
        explanation = $exp$To match through the second derivative at the center, you need terms up to $x^2$, so the minimum degree is 2.$exp$
    WHERE title = 'U10.11-P4';

    -- U10.11-P5
    -- Fix: x^\frac{2}{2} to \frac{x^2}{2}, fix \\\\\\\ln.
    UPDATE public.questions
    SET 
        prompt = $prompt$What is the 2nd-degree Maclaurin polynomial for $\ln(1+x)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$x + \\frac{x^2}{2}$"},
            {"id": "B", "value": "$x - \\frac{x^2}{2}$"},
            {"id": "C", "value": "$1 + x - \\frac{x^2}{2}$"},
            {"id": "D", "value": "$x - \\frac{x^2}{2} + \\frac{x^3}{3}$"}
        ]$json$::jsonb,
        explanation = $exp$\ln(1+x) = x - \frac{x^2}{2} + \dots$, so the 2nd-degree polynomial is $x - \frac{x^2}{2}.$exp$
    WHERE title = 'U10.11-P5';

END $$;
