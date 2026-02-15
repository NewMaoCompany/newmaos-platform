-- Fix Unit 10.15 Selected Questions (P2, P4)
-- Fixes filenames and excessive backslashes.

DO $$
BEGIN

    -- U10.15-P2
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.15-A. Which function could produce $A(x) = 1 + 2x + 4x^2 + 8x^3 + \dots$?$prompt$
    WHERE title = 'U10.15-P2';

    -- U10.15-P4
    -- Fix: Remove excessive backslashes in \ln.
    UPDATE public.questions
    SET 
        prompt = $prompt$Given $\frac{1}{1+x} = \sum_{n=0}^{\infty} (-1)^n x^n$ for $|x| < 1$, a series for $\ln(1+x)$ is$prompt$,
        explanation = $exp$Integrate term-by-term: $\ln(1+x) = \int \frac{1}{1+x} \, dx = \sum_{n=0}^{\infty} (-1)^n \frac{x^{n+1}}{n+1}$ (choose constant so $\ln(1+0) = 0$).$exp$
    WHERE title = 'U10.15-P4';

END $$;
