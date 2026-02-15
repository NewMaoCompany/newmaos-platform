-- Fix Unit 10.7 Selected Questions (P1, P2, P3, P4, P5) based on User Screenshots
-- Fixes filename in prompt, |to 0 typo, and standardizes inequalities/fractions.

DO $$
BEGIN

    -- U10.7-P3 (Question 5 in screenshot)
    -- Fix: Remove filename. Fix |to 0 typo.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.7-A, where $a_n = \frac{(-1)^{n+1}}{n}$. Which condition is needed (in addition to $|a_n| \to 0$) to apply the alternating series test?$prompt$,
        options = $json$[
            {"id": "A", "value": "The terms must be positive (no alternating signs)."},
            {"id": "B", "value": "The absolute values $|a_n|$ must be eventually decreasing."},
            {"id": "C", "value": "The partial sums must be increasing."},
            {"id": "D", "value": "The series must be geometric."}
        ]$json$::jsonb
    WHERE title = 'U10.7-P3';

    -- U10.7-P1 (Question 2 in screenshot)
    -- Fix: Fraction formatting in options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{(-1)^{n+1}}{n}$. Which statement is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "It converges absolutely because $\\sum \\frac{1}{n}$ converges."},
            {"id": "B", "value": "It converges conditionally by the alternating series test."},
            {"id": "C", "value": "It diverges because the terms alternate."},
            {"id": "D", "value": "It diverges because $\\frac{1}{n} \\to 0$."}
        ]$json$::jsonb
    WHERE title = 'U10.7-P1';

    -- U10.7-P2 (Question 1 in screenshot)
    -- Fix: Fraction formatting in options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} (-1)^n \frac{n}{n+1}$. Which conclusion is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "Converges by AST because $\\frac{n}{n+1}$ decreases and approaches $0$."},
            {"id": "B", "value": "Converges by AST because $\\frac{n}{n+1} \\to 1$."},
            {"id": "C", "value": "Diverges because $\\frac{n}{n+1}$ does not approach $0$."},
            {"id": "D", "value": "Converges absolutely because alternating signs guarantee absolute convergence."}
        ]$json$::jsonb
    WHERE title = 'U10.7-P2';

    -- U10.7-P4 (Question 4 in screenshot)
    -- Fix: Inequality <= to \le, fraction formatting.
    UPDATE public.questions
    SET 
        prompt = $prompt$For an alternating series that satisfies the alternating series test, which statement about the error after $N$ terms is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "The error is always exactly $a_N$."},
            {"id": "B", "value": "The error satisfies $|R_N| \\le |a_{N+1}|$."},
            {"id": "C", "value": "The error satisfies $|R_N| \\le \\sum_{n=N+1}^{\\infty} |a_n|$ and equals that sum."},
            {"id": "D", "value": "The error is bounded by $|a_N - a_{N+1}|$."}
        ]$json$::jsonb
    WHERE title = 'U10.7-P4';

    -- U10.7-P5 (Question 3 in screenshot)
    -- Fix: Fraction formatting.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series is best suited to be tested first with the alternating series test?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "$\\sum (-1)^{n+1} \\frac{1}{n^{3/2}}$"},
            {"id": "C", "value": "$\\sum \\frac{2^n}{n}$"},
            {"id": "D", "value": "$\\sum \\frac{1}{3^n}$"}
        ]$json$::jsonb
    WHERE title = 'U10.7-P5';

END $$;
