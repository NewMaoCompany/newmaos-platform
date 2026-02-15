-- Fix Unit 10.3 Selected Questions (P1, P2, P5) based on User Screenshots
-- Fixes missing arrows (\to) and standardizes fraction formatting in options.

DO $$
BEGIN

    -- U10.3-P1 (Question 2 in screenshot)
    -- Fix: Convert text fractions "n/(n+1)" to LaTeX \frac{n}{n+1}. Fix arrows.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{n}{n+1}$. What does the $n$th-term test tell you about this series?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges because $\\frac{n}{n+1} \\to 0$."},
            {"id": "B", "value": "The series diverges because $\\frac{n}{n+1}$ does not approach $0$."},
            {"id": "C", "value": "The series converges because it is a $p$-series."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because $\\frac{n}{n+1} \\to 0$."}
        ]$json$::jsonb,
        explanation = $exp$Since $\lim_{n \to \infty} \frac{n}{n+1} = 1 \neq 0$, the series must diverge by the $n$th-term test.$exp$
    WHERE title = 'U10.3-P1';

    -- U10.3-P2 (Question 1 in screenshot)
    -- Fix: Convert "sin(n)/n" to \frac{\sin(n)}{n}. Fix arrows.
    UPDATE public.questions
    SET 
        prompt = $prompt$Consider the series $\sum_{n=1}^{\infty} \frac{\sin(n)}{n}$. Which conclusion is correct based only on the $n$th-term test?$prompt$,
        options = $json$[
            {"id": "A", "value": "The series converges because $\\frac{\\sin(n)}{n} \\to 0$."},
            {"id": "B", "value": "The series diverges because $\\sin(n)$ oscillates."},
            {"id": "C", "value": "The $n$th-term test is inconclusive because $\\frac{\\sin(n)}{n} \\to 0$."},
            {"id": "D", "value": "The series diverges because $\\frac{\\sin(n)}{n}$ is not decreasing."}
        ]$json$::jsonb,
        explanation = $exp$Since $\lim_{n \to \infty} \frac{\sin(n)}{n} = 0$, the necessary condition is met, but the $n$th-term test is inconclusive (it cannot prove convergence).$exp$
    WHERE title = 'U10.3-P2';

    -- U10.3-P5 (Question 4 in screenshot)
    -- Fix: Missing arrow in prompt "a_n \to 0".
    -- "condition a_n [gap] 0" -> "condition $a_n \to 0$"
    UPDATE public.questions
    SET 
        prompt = $prompt$Which statement about the condition $a_n \to 0$ is correct for an infinite series $\sum_{n=1}^{\infty} a_n$?$prompt$,
        options = $json$[
            {"id": "A", "value": "If $a_n \\to 0$, then the series must converge."},
            {"id": "B", "value": "If $a_n \\to 0$, then the series must diverge."},
            {"id": "C", "value": "If $a_n \\to 0$, the $n$th-term test is inconclusive."},
            {"id": "D", "value": "If $a_n \\to 0$, then the series is geometric."}
        ]$json$::jsonb,
        explanation = $exp$The condition $\lim_{n \to \infty} a_n = 0$ is necessary but not sufficient for convergence. If it holds, we cannot determine convergence without further tests.$exp$
    WHERE title = 'U10.3-P5';

END $$;
