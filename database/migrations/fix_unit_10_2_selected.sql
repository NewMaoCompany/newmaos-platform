-- Fix Unit 10.2 Selected Questions (P1, P2, P3) based on User Screenshots
-- Fixes red raw LaTeX in prompts and ensures strict formatting.

DO $$
BEGIN

    -- U10.2-P2 (Question 1 in screenshot)
    -- Fix: Prompt had raw LaTeX without delimiters causing red text.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the geometric series $\sum_{n=0}^{\infty} 5 \left(\frac{1}{3}\right)^n$. What is its sum?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{5}{1-\\frac{1}{3}}$"},
            {"id": "B", "value": "$\\frac{5}{1+\\frac{1}{3}}$"},
            {"id": "C", "value": "$\\frac{1}{1-\\frac{1}{3}}$"},
            {"id": "D", "value": "The series diverges because $\\frac{1}{3} \\neq 0$"}
        ]$json$::jsonb,
        explanation = $exp$Here $a = 5$ and $r = \frac{1}{3}$ with $|r| < 1$, so the sum is $\frac{a}{1-r} = \frac{5}{1-\frac{1}{3}}$.$exp$
    WHERE title = 'U10.2-P2';

    -- U10.2-P3 (Question 3 in screenshot)
    -- Fix: Prompt had raw LaTeX without delimiters.
    UPDATE public.questions
    SET 
        prompt = $prompt$For the series $\sum_{n=1}^{\infty} 12 \left(-\frac{2}{3}\right)^{n-1}$, which statement is true?$prompt$,
        options = $json$[
            {"id": "A", "value": "It diverges because $r < 0$"},
            {"id": "B", "value": "It converges and its sum is $\\frac{12}{1+\\frac{2}{3}}$"},
            {"id": "C", "value": "It converges and its sum is $\\frac{12}{1-(-\\frac{2}{3})}$"},
            {"id": "D", "value": "It diverges because $|r| > 1$"}
        ]$json$::jsonb,
        explanation = $exp$This is geometric with $a=12$ and $r = -\frac{2}{3}$; since $|r| < 1$, it converges and the sum is $\frac{a}{1-r} = \frac{12}{1-(-\frac{2}{3})}$.$exp$
    WHERE title = 'U10.2-P3';

    -- U10.2-P1 (Question 5 in screenshot)
    -- Fix: Ensure strict LaTeX formatting for options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series is geometric?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n}$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} 3 \\cdot 2^n$"},
            {"id": "C", "value": "$\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$"},
            {"id": "D", "value": "$\\sum_{n=1}^{\\infty} \\frac{n}{n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.2-P1';

END $$;
