-- Fix Unit 10.6 Selected Questions (P1, P3, P4, P5) based on User Screenshots
-- Fixes filename in prompt and standardizes inequalities/fractions in options.

DO $$
BEGIN

    -- U10.6-P3 (Question 5 in screenshot)
    -- Fix: Remove filename. Fix option fractions.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.6-A, which lists $a_n$, $b_n$, and $\frac{a_n}{b_n}$ where $b_n = \frac{3}{n}$. Which conclusion is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum a_n$ converges because $\\frac{a_n}{b_n} < 1$ for the shown $n$."},
            {"id": "B", "value": "$\\sum a_n$ diverges because $\\frac{a_n}{b_n}$ approaches a finite positive constant and $\\sum b_n$ diverges."},
            {"id": "C", "value": "$\\sum a_n$ converges because $\\frac{a_n}{b_n} \\to 0$."},
            {"id": "D", "value": "No conclusion can be drawn because the table uses only finitely many terms."}
        ]$json$::jsonb
    WHERE title = 'U10.6-P3';

    -- U10.6-P1 (Question 3 in screenshot)
    -- Fix: Inequality LaTeX formatting.
    UPDATE public.questions
    SET 
        prompt = $prompt$You know that $\sum_{n=1}^{\infty} \frac{1}{n^2}$ converges. Which inequality would be most useful to prove that $\sum_{n=1}^{\infty} \frac{1}{n^2+5}$ also converges by direct comparison?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{n^2+5} \\le \\frac{1}{n^2}$ for $n \\ge 1$"},
            {"id": "B", "value": "$\\frac{1}{n^2+5} \\ge \\frac{1}{n^2}$ for $n \\ge 1$"},
            {"id": "C", "value": "$\\frac{1}{n^2+5} \\le \\frac{1}{n}$ for $n \\ge 1$"},
            {"id": "D", "value": "$\\frac{1}{n^2+5} \\ge \\frac{1}{n}$ for $n \\ge 1$"}
        ]$json$::jsonb
    WHERE title = 'U10.6-P1';

    -- U10.6-P4 (Question 2 in screenshot)
    -- Fix: Inequality LaTeX formatting in options.
    UPDATE public.questions
    SET 
        prompt = $prompt$To test $\sum_{n=1}^{\infty} \frac{n}{n^3+1}$, which comparison is most appropriate?$prompt$,
        options = $json$[
            {"id": "A", "value": "Compare to $\\sum \\frac{1}{n^2}$ because $\\frac{n}{n^3+1} \\le \\frac{1}{n^2}$ for $n \\ge 1$."},
            {"id": "B", "value": "Compare to $\\sum \\frac{1}{n}$ because $\\frac{n}{n^3+1} \\ge \\frac{1}{n}$ for $n \\ge 1$."},
            {"id": "C", "value": "Compare to $\\sum 1$ because $\\frac{n}{n^3+1} \\ge 1$ for $n \\ge 1$."},
            {"id": "D", "value": "Compare to $\\sum n$ because $\\frac{n}{n^3+1} \\approx n$ for large $n$."}
        ]$json$::jsonb
    WHERE title = 'U10.6-P4';

    -- U10.6-P5 (Question 4 in screenshot)
    -- Fix: Standardize fractions.
    UPDATE public.questions
    SET 
        prompt = $prompt$For large $n$, $\frac{2n^2+1}{n^3-4n}$ behaves most like which term, making it a good choice for Limit Comparison?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{n}$"},
            {"id": "B", "value": "$\\frac{1}{n^2}$"},
            {"id": "C", "value": "$\\frac{1}{n^3}$"},
            {"id": "D", "value": "$n$"}
        ]$json$::jsonb
    WHERE title = 'U10.6-P5';

END $$;
