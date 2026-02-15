-- Fix Unit 10.4 Selected Questions (P1, P2, P3, P4) based on User Screenshots
-- Fixes filename in prompt, \integral command, and standardizes fractions.

DO $$
BEGIN

    -- U10.4-P1 (Question 2 in screenshot)
    -- Fix: Prompt backslashes. Options: \integral -> integral, fraction format.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=2}^{\infty} \frac{1}{n\ln(n)}$. If $f(x) = \frac{1}{x\ln(x)}$, which statement best matches the Integral Test conclusion?$prompt$,
        options = $json$[
            {"id": "A", "value": "The integral converges, so the series converges."},
            {"id": "B", "value": "The integral diverges, so the series diverges."},
            {"id": "C", "value": "The Integral Test cannot be applied because $f(x)$ is positive."},
            {"id": "D", "value": "The series converges because $\\frac{1}{n \\ln(n)} \\to 0$."}
        ]$json$::jsonb,
        explanation = $exp$Here $f$ is positive, continuous, and decreasing for $x > 1$, and $\int_2^{\infty} \frac{1}{x \ln x} \, dx = \infty$, so the series diverges by the Integral Test.$exp$
    WHERE title = 'U10.4-P1';

    -- U10.4-P2 (Question 1 in screenshot)
    -- Fix: Option A fraction format \frac{1}{n^2}.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{1}{n^2}$. Which statement is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "It diverges because $\\frac{1}{n^2} \\to 0$."},
            {"id": "B", "value": "It converges because it is a $p$-series with $p > 1$."},
            {"id": "C", "value": "It diverges because it is a $p$-series with $p > 1$."},
            {"id": "D", "value": "The $p$-series test is inconclusive when $p = 2$."}
        ]$json$::jsonb
    WHERE title = 'U10.4-P2';

    -- U10.4-P3 (Question 5 in screenshot)
    -- Fix: \integral -> integral. Option D fraction format.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{1}{n^2+1}$. Using $f(x) = \frac{1}{x^2+1}$, which conclusion is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "The integral converges, so the series converges."},
            {"id": "B", "value": "The integral diverges, so the series diverges."},
            {"id": "C", "value": "The Integral Test cannot be applied because $f(x)$ is decreasing."},
            {"id": "D", "value": "The series diverges because $\\frac{1}{n^2+1} \\to 0$."}
        ]$json$::jsonb
    WHERE title = 'U10.4-P3';

    -- U10.4-P4 (Question 3 in screenshot)
    -- Fix: Remove filename. Fix \integer -> integer. Fix \lim format.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.4-A, where $f(x) = \frac{x-1}{x}$ is listed at integer inputs. Which condition needed for the Integral Test fails for $f$ on $[1, \infty)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$f$ is not positive on $[1, \\infty)$."},
            {"id": "B", "value": "$f$ is not continuous on $[1, \\infty)$."},
            {"id": "C", "value": "$f$ is not decreasing on $[1, \\infty)$."},
            {"id": "D", "value": "$f$ does not satisfy $\\lim_{x \\to \\infty} f(x) = 0$."}
        ]$json$::jsonb
    WHERE title = 'U10.4-P4';

END $$;
