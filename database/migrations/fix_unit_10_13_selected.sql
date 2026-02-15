-- Fix Unit 10.13 Selected Questions (P1, P2, P3, P5)
-- Fixes broken sum rendering, filenames, and interval formatting.

DO $$
BEGIN

    -- U10.13-P1 (Screenshot Q2)
    -- Fix: Simplify LaTeX by removing \left \right which caused rendering failure in red text.
    -- Original: $\sum_{n=1}^{\infty} n \left(\frac{x}{3}\right)^n$
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the radius of convergence of $\sum_{n=1}^{\infty} n (\frac{x}{3})^n$.$prompt$
    WHERE title = 'U10.13-P1';

    -- U10.13-P2
    -- Fix: Remove extra backslash in \\interval.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the interval of convergence of $\sum_{n=1}^{\infty} \frac{(x-1)^n}{n}$.$prompt$,
        explanation = $exp$Ratio test gives $|x-1| < 1 \Rightarrow 0 < x < 2$. Check endpoints: at $x=0$, the series is $\sum \frac{(-1)^n}{n}$ which converges (alternating harmonic). At $x=2$, it is $\sum \frac{1}{n}$ which diverges. So $[0, 2)$.$exp$
    WHERE title = 'U10.13-P2';

    -- U10.13-P3 (Screenshot Q3)
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Figure 10.13-A. Which interval is shown?$prompt$
    WHERE title = 'U10.13-P3';

    -- U10.13-P5
    -- Fix: Remove extra backslash in \\interval.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the interval of convergence of $\sum_{n=0}^{\infty} (-1)^n \frac{(x-3)^{2n}}{2n+1}$.$prompt$,
        explanation = $exp$Let $u = (x-3)^2 \ge 0$. Ratio test gives $u < 1 \Rightarrow |x-3| < 1 \Rightarrow 2 < x < 4$. At $x=2$ or $x=4$, the series becomes $\sum (-1)^n \frac{1}{2n+1}$, which converges by AST. So the interval is $[2, 4]$.$exp$
    WHERE title = 'U10.13-P5';

END $$;
