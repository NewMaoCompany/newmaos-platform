-- Fix Unit 10.1-P2 ONLY
-- Target: "Let a_n = 1/(n(n+1))..."
-- Strict Named Dollar Quote Fix as requested.

UPDATE public.questions
SET 
    prompt = $prompt$Let $a_n = \frac{1}{n(n+1)}$ and $S_N = \sum_{n=1}^{N} a_n$. Which expression for $S_N$ is correct?$prompt$,
    options = $json$[
        {"id": "A", "value": "$S_N = \\frac{N}{N+1}$"},
        {"id": "B", "value": "$S_N = \\frac{N+1}{N}$"},
        {"id": "C", "value": "$S_N = \\ln(N+1)$"},
        {"id": "D", "value": "$S_N = \\frac{1}{N+1}$"}
    ]$json$::jsonb,
    explanation = $exp$Using partial fractions $\frac{1}{n(n+1)} = \frac{1}{n} - \frac{1}{n+1}$, the sum telescopes to $S_N = 1 - \frac{1}{N+1} = \frac{N}{N+1}$.$exp$
WHERE title = 'U10.1-P2';
