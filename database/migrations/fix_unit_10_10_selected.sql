-- Fix Unit 10.10 Selected Questions (P1 - P5)
-- Fixes filename, inequality formatting (\le, <), and special symbols (\pm).

DO $$
BEGIN

    -- U10.10-P1 (Screenshot Q2)
    -- Fix: Inequality <= to \le.
    UPDATE public.questions
    SET 
        prompt = $prompt$An alternating series satisfies the alternating series test. Which statement about the remainder $R_N$ after $N$ terms is correct?$prompt$,
        options = $json$[
            {"id": "A", "value": "$|R_N| \\le |a_N|$"},
            {"id": "B", "value": "$|R_N| \\le |a_{N+1}|$"},
            {"id": "C", "value": "$|R_N| \\le |a_{N+1}|/2$"},
            {"id": "D", "value": "$|R_N| \\le \\sum_{n=N+1}^{\\infty} |a_n|$"}
        ]$json$::jsonb
    WHERE title = 'U10.10-P1';

    -- U10.10-P2
    -- Fix: Ensure standard formatting.
    UPDATE public.questions
    SET 
        prompt = $prompt$Let $\sum_{n=1}^{\infty}(-1)^{n+1}\frac{1}{n^2+1}$ satisfy the alternating series test. What is the smallest $N$ that guarantees the alternating series approximation error is less than $0.01$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$N=4$"},
            {"id": "B", "value": "$N=9$"},
            {"id": "C", "value": "$N=10$"},
            {"id": "D", "value": "$N=11$"}
        ]$json$::jsonb
    WHERE title = 'U10.10-P2';

    -- U10.10-P3 (Screenshot Q3)
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.10-A. For which listed $N$ is the guaranteed error bound less than $0.01$?$prompt$
    WHERE title = 'U10.10-P3';

    -- U10.10-P4 (Screenshot Q5)
    -- Fix: Ensure \pm rendering and inequalities.
    UPDATE public.questions
    SET 
        prompt = $prompt$An alternating series satisfies AST, and you compute the partial sum $S_N$. Which statement is correct about where the true sum $S$ lies relative to $S_N$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$S$ is always greater than $S_N$."},
            {"id": "B", "value": "$S$ is always less than $S_N$."},
            {"id": "C", "value": "$S$ lies within $\\pm|a_{N+1}|$ of $S_N$."},
            {"id": "D", "value": "$S$ must equal $S_N$ when $N$ is even."}
        ]$json$::jsonb
    WHERE title = 'U10.10-P4';

    -- U10.10-P5 (Screenshot Q4)
    -- Fix: Inequality formatting ensuring < is treated as latex if needed, though usually fine. Ensuring consistent spacing.
    UPDATE public.questions
    SET 
        prompt = $prompt$You want the error in an alternating series approximation to be less than $0.0005$. Which setup correctly expresses the goal using the alternating series error bound?$prompt$,
        options = $json$[
            {"id": "A", "value": "Choose $N$ so that $|a_N| < 0.0005$."},
            {"id": "B", "value": "Choose $N$ so that $|a_{N+1}| < 0.0005$."},
            {"id": "C", "value": "Choose $N$ so that $\\sum_{n=N+1}^{\\infty} |a_n| < 0.0005$."},
            {"id": "D", "value": "Choose $N$ so that $|a_{N+1} - a_N| < 0.0005$."}
        ]$json$::jsonb
    WHERE title = 'U10.10-P5';

END $$;
