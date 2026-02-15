-- MASTER FIX: Unit 10.13, 10.14, 10.15
-- Combines fixes for:
-- 1. U10.13-P1 (Red text fix)
-- 2. U10.13-P3, U10.14-P3, U10.15-P2 (Remove filenames)
-- 3. U10.14-P1, P4 (Fix fraction formatting)
-- 4. U10.15-P4 (Fix backslash spam)
-- 5. General cleanup for U10.13-P2, P5

DO $$
BEGIN

    -- ==========================================
    -- UNIT 10.13 FIXES
    -- ==========================================

    -- U10.13-P1 (The one with RED TEXT failure)
    -- Fix: Simplify LaTeX by removing \left and \right which are causing the rendering crash.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the radius of convergence of $\sum_{n=1}^{\infty} n (\frac{x}{3})^n$.$prompt$
    WHERE title = 'U10.13-P1';

    -- U10.13-P2
    -- Fix: Remove extra backslash in interval.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the interval of convergence of $\sum_{n=1}^{\infty} \frac{(x-1)^n}{n}$.$prompt$,
        explanation = $exp$Ratio test gives $|x-1| < 1 \Rightarrow 0 < x < 2$. Check endpoints: at $x=0$, the series is $\sum \frac{(-1)^n}{n}$ which converges (alternating harmonic). At $x=2$, it is $\sum \frac{1}{n}$ which diverges. So $[0, 2)$.$exp$
    WHERE title = 'U10.13-P2';

    -- U10.13-P3
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Figure 10.13-A. Which interval is shown?$prompt$
    WHERE title = 'U10.13-P3';

    -- U10.13-P5
    -- Fix: Remove extra backslash in interval.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the interval of convergence of $\sum_{n=0}^{\infty} (-1)^n \frac{(x-3)^{2n}}{2n+1}$.$prompt$,
        explanation = $exp$Let $u = (x-3)^2 \ge 0$. Ratio test gives $u < 1 \Rightarrow |x-3| < 1 \Rightarrow 2 < x < 4$. At $x=2$ or $x=4$, the series becomes $\sum (-1)^n \frac{1}{2n+1}$, which converges by AST. So the interval is $[2, 4]$.$exp$
    WHERE title = 'U10.13-P5';

    -- ==========================================
    -- UNIT 10.14 FIXES
    -- ==========================================

    -- U10.14-P1
    -- Fix: Standardize fractions in options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which power series represents $\frac{1}{1-x}$ for $|x| < 1$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} x^n$"},
            {"id": "B", "value": "$\\sum_{n=1}^{\\infty} x^n$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} (-1)^n x^n$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^n}{n!}$"}
        ]$json$::jsonb
    WHERE title = 'U10.14-P1';

    -- U10.14-P3
    -- Fix: Remove filename.
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.14-A. The shown coefficients match the beginning of which series?$prompt$
    WHERE title = 'U10.14-P3';

    -- U10.14-P4
    -- Fix: Standardize fractions in options.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which series equals $\arctan(x)$ for $|x| \le 1$ (with convergence at endpoints in the usual sense)?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{2n+1}}{2n+1}$"},
            {"id": "B", "value": "$\\sum_{n=0}^{\\infty} \\frac{x^{2n+1}}{2n+1}$"},
            {"id": "C", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^n}{n!}$"},
            {"id": "D", "value": "$\\sum_{n=0}^{\\infty} (-1)^n \\frac{x^{2n}}{2n+1}$"}
        ]$json$::jsonb
    WHERE title = 'U10.14-P4';

    -- ==========================================
    -- UNIT 10.15 FIXES
    -- ==========================================

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
