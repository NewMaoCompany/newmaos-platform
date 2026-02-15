-- FIX: Unit 10 Unit Test Symbols (Q3, Q12, Q15, Q16, Q20)
-- Fixes textual fractions, invalid commands, and missing LaTeX wrappers.

DO $$
BEGIN

    -- U10-UT-Q3 (User's Question 13)
    -- Fix: Textual fractions a/(1-r) -> \frac{a}{1-r}
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$\\frac{a}{1-r}$"},
            {"id": "B", "value": "$a(1-r)$"},
            {"id": "C", "value": "$\\frac{a}{1+r}$"},
            {"id": "D", "value": "$\\frac{a}{r-1}$ for $|r| > 1$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q3';

    -- U10-UT-Q12 (User's Question 19)
    -- Fix: Prompt limit backslashes. Options \le and formatting.
    UPDATE public.questions
    SET 
        prompt = $prompt$For an alternating series with decreasing $b_n$ and $\lim b_n = 0$, the error after using $n$ terms satisfies$prompt$,
        options = $json$[
            {"id": "A", "value": "$|R_n| \\le b_{n+1}$"},
            {"id": "B", "value": "$|R_n| \\le b_n^2$"},
            {"id": "C", "value": "$|R_n| \\ge b_{n+1}$"},
            {"id": "D", "value": "$|R_n| \\le b_{n+1}/2$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q12';

    -- U10-UT-Q15 (User's Question 14)
    -- Fix: Textual fractions in options.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$M \\frac{|x-a|^n}{n!}$"},
            {"id": "B", "value": "$M \\frac{|x-a|^{n+1}}{(n+1)!}$"},
            {"id": "C", "value": "$\\frac{|x-a|^{n+1}}{n!}$"},
            {"id": "D", "value": "$M |x-a|$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q15';

    -- U10-UT-Q16 (User's Question 4 - revisited for prompt command)
    -- Fix: Remove \interval command from prompt (replace with text "interval").
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Figure 10.13-A. Which interval is shown?$prompt$
    WHERE title = 'U10-UT-Q16';

    -- U10-UT-Q20 (User's Question 15)
    -- Fix: Wrap options in LaTeX $.
    UPDATE public.questions
    SET 
        options = $json$[
            {"id": "A", "value": "$a_4$"},
            {"id": "B", "value": "$a_2$"},
            {"id": "C", "value": "$a_6$"},
            {"id": "D", "value": "$a_0$"}
        ]$json$::jsonb
    WHERE title = 'U10-UT-Q20';

END $$;
