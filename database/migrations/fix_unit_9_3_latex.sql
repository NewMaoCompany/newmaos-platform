-- Fix Unit 9.3 LaTeX Errors (U9.3-P4, U9.3-P5)
-- U9.3-P4: Fix red garbled text "\left \|\mathbf{v}(t)\right \|" in prompt.
-- U9.3-P5: Remove undefined macro "\interval" in prompt.

DO $$
BEGIN

    -- U9.3-P4
    -- Issue: Red text likely due to broken \left| \right| syntax or missing delimiters in previous updates.
    -- Fix: Revert to simple, robust standard notation: $|\mathbf{v}(t)|$.
    UPDATE public.questions
    SET prompt = 'A table of speed values $|\mathbf{v}(t)|$ is shown for $0 \le t \le 4$ with $\Delta t = 1$. Using the trapezoidal rule, approximate the arc length on $[0,4]$.'
    WHERE title = 'U9.3-P4';

    -- U9.3-P5
    -- Issue: Usage of "\interval" which is likely undefined, causing rendering issues.
    -- Fix: Replace with plain text "interval".
    UPDATE public.questions
    SET prompt = 'A curve is given by $x(t) = 1 - t$ and $y(t) = t^2$. The curve is traced from the point $(1,0)$ to the point $(-2,9)$. Which $t$-interval should be used for arc length?'
    WHERE title = 'U9.3-P5';

END $$;
