-- Fix Unit 10 Unit Test Issues (Q2, Q14, Q19)
-- Fixes limit notation, removes filenames, and corrects LaTeX syntax usage.

DO $$
BEGIN

    -- U10-UT-Q2 (User's Question 2)
    -- Fix: Bad limit notation in Option C.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "Converges by comparison with $\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "Converges by telescoping"},
            {"id": "C", "value": "Diverges because $\\lim_{n \\to \\infty} \\frac{n}{n+1} \\neq 0$"},
            {"id": "D", "value": "Converges because terms are less than $1$"}
        ]$json$::jsonb,
        explanation = $exp$\\lim_{n \to \infty} \frac{n}{n+1} = 1 \ne 0, so the series diverges by the $n$th-term test.$exp$
    WHERE title = 'U10-UT-Q2';

    -- U10-UT-Q14 (User's Question 3 in session, but could vary)
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.11-A. Based on the table, for which $x$ is $T_2(x)$ the most accurate approximation to $e^x$?$prompt$
    WHERE title = 'U10-UT-Q14';

    -- U10-UT-Q19 (User's Question 1 in session)
    -- Fix: Correct prompt ln(1+x) backslashes, fix options text/fraction format.
    UPDATE public.questions
    SET 
        prompt = $prompt$Using $\frac{1}{1+x} = \sum_{n=0}^{\infty} (-1)^n x^n$, a correct series for $\ln(1+x)$ is$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{n+1}}{n+1}$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^n}{n+1}$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} (-1)^n \\frac{x^n}{n}$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{2n}}{2n+1}$"}
        ]$json$::jsonb,
        explanation = $exp$Integrate term-by-term and choose the constant so the value at $x=0$ is 0: $\ln(1+x) = \sum_{n=0}^{\infty} (-1)^n \frac{x^{n+1}}{n+1}$.$exp$
    WHERE title = 'U10-UT-Q19';

END $$;
