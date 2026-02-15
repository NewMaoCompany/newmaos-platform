-- COMPREHENSIVE FIX: Unit 10 Unit Test (Q5 - Q18)
-- Fixes plain text options, bad fraction syntax, limit backslashes, and redundant text.

DO $$
BEGIN

    -- U10-UT-Q5 (User's Question 7)
    -- Fix: Plain text options p > 0 -> $p > 0$
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$p > 0$"},
            {"id": "B", "value": "$p > 1$"},
            {"id": "C", "value": "$p \\ge 1$"},
            {"id": "D", "value": "All real $p$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q5';

    -- U10-UT-Q6 (User's Question 9)
    -- Fix: Fraction syntax \frac{1}{n}^2 -> \frac{1}{n^2} in options A/B.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "Converges by comparison with $\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "Diverges by comparison with $\\sum \\frac{1}{n^2}$"},
            {"id": "C", "value": "Diverges by the $n$th-term test"},
            {"id": "D", "value": "Converges only if alternating"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q6';

    -- U10-UT-Q7
    -- Fix: Prompt backslashes \\\\limit -> \limit comparison
    -- Fix: Options syntax \frac{1}{n}^2 -> \frac{1}{n^2}
    UPDATE public.questions
    SET 
        prompt = $prompt$Use Limit Comparison to determine behavior of $\sum_{n=1}^{\infty} \frac{3n^2+1}{n^3-4}$.$prompt$,
        options = $json$[
            {"id": "A", "value": "Converges (like $\\sum \\frac{1}{n^2}$)"},
            {"id": "B", "value": "Diverges (like $\\sum \\frac{1}{n}$)"},
            {"id": "C", "value": "Diverges because it is geometric"},
            {"id": "D", "value": "Converges by alternating series test"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q7';

    -- U10-UT-Q8
    -- Fix: excessive backslashes in limit (\lim)
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$b_n$ increases and $\\lim_{n \\to \\infty} b_n = 0$"},
            {"id": "B", "value": "$b_n$ decreases and $\\lim_{n \\to \\infty} b_n = 0$"},
            {"id": "C", "value": "$\\sum b_n$ converges absolutely"},
            {"id": "D", "value": "$b_n$ is bounded above by $1$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q8';

    -- U10-UT-Q9
    -- Fix: excessive backslashes in limit prompt (\lim)
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.6-A (`U10.6_Practice_Table1_LimitComparison.png`). The table suggests $\lim \frac{a_n}{b_n} = L$ with $0 < L < \infty$. What conclusion is valid?$prompt$
    WHERE title = 'U10-UT-Q9';

    -- U10-UT-Q10
    -- Fix: excessive backslashes in prompt/options/explanation (\limit -> limit, \lim -> \lim)
    UPDATE public.questions
    SET 
        prompt = $prompt$Use the Ratio Test to determine $\sum_{n=1}^{\infty} \frac{n!}{3^n}$.$prompt$,
        options = $json$[
            {"id": "A", "value": "Converges because the limit is $\\frac{1}{3}$"},
            {"id": "B", "value": "Diverges because the ratio limit is $\\infty$"},
            {"id": "C", "value": "Converges by $p$-series"},
            {"id": "D", "value": "Diverges by the Integral Test"}
        ]$json$::jsonb,
        explanation = $exp$\frac{a_{n+1}}{a_n} = \frac{(n+1)!/3^{n+1}}{n!/3^n} = \frac{n+1}{3} \to \infty > 1, so the series diverges.$exp$
    WHERE title = 'U10-UT-Q10';

    -- U10-UT-Q11 (User's Question 11)
    -- Fix: Bad fraction syntax \frac{1}{n}^2 -> \frac{1}{n^2} in options A/C.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "$\\sum (-1)^n \\frac{1}{n}$"},
            {"id": "C", "value": "$\\sum (-1)^n \\frac{1}{n^2}$"},
            {"id": "D", "value": "$\\sum \\frac{1}{n}$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q11';

    -- U10-UT-Q18 (User's Question 8)
    -- Fix: Remove redundant text (n=0 to \infty) from options.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} (n+1)x^n$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} n x^n$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^n}{n+1}$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} x^n$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q18';

END $$;
