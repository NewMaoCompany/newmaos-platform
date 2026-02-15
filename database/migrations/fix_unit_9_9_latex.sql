-- Fix Unit 9.9 LaTeX Formatting (Polar Areas/Intersections)
-- Rewrites prompts and options for U9.9-P1 to U9.9-P5 to ensure ALL numbers are LaTeX formatted.
-- Uses named dollar quotes ($prompt$ and $json$) to strict preserve LaTeX backslashes.

DO $$
BEGIN

    -- U9.9-P1: Polar Intersection
    UPDATE public.questions
    SET 
        prompt = $prompt$Two polar curves are $r = 2\cos\theta$ and $r = 1$. At which angle in $[0, \pi]$ do they intersect with $r > 0$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{2}$"},
            {"id": "C", "value": "$\\frac{2\\pi}{3}$"},
            {"id": "D", "value": "$\\frac{\\pi}{6}$"}
        ]$json$::jsonb
    WHERE title = 'U9.9-P1';

    -- U9.9-P2: Area Setup First Quadrant
    -- Fix: Ensure integrals usage is correct.
    UPDATE public.questions
    SET 
        prompt = $prompt$The curves $r = 2\cos\theta$ and $r = 1$ are shown. Which integral gives the area of the region inside $r = 2\cos\theta$ and outside $r = 1$ in the first quadrant?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{2} \\int_{0}^{\\frac{\\pi}{3}} ((2\\cos\\theta)^2 - 1^2) \\, d\\theta$"},
            {"id": "B", "value": "$\\frac{1}{2} \\int_{0}^{\\frac{\\pi}{2}} ((2\\cos\\theta)^2 - 1^2) \\, d\\theta$"},
            {"id": "C", "value": "$\\frac{1}{2} \\int_{0}^{\\frac{\\pi}{3}} (1^2 - (2\\cos\\theta)^2) \\, d\\theta$"},
            {"id": "D", "value": "$\\int_{0}^{\\frac{\\pi}{3}} (2\\cos\\theta - 1) \\, d\\theta$"}
        ]$json$::jsonb
    WHERE title = 'U9.9-P2';

    -- U9.9-P3: Possible Area Value
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the exact area of the region inside $r = 2\cos\theta$ and outside $r = 1$ in the first quadrant.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{\\pi}{6} + \\frac{\\sqrt{3}}{4}$"},
            {"id": "B", "value": "$\\frac{\\pi}{6} - \\frac{\\sqrt{3}}{4}$"},
            {"id": "C", "value": "$\\frac{\\pi}{3} + \\frac{\\sqrt{3}}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{12} + \\frac{\\sqrt{3}}{8}$"}
        ]$json$::jsonb
    WHERE title = 'U9.9-P3';

    -- U9.9-P4: Trapezoidal Area
    -- Fix: Ensure numbers 1.47, 1.10, 1.99, 0.74 are LaTeX wrapped.
    UPDATE public.questions
    SET 
        prompt = $prompt$The table shows values for $r = 2\cos\theta$ at $\theta = 0, \frac{\pi}{6}, \frac{\pi}{3}, \frac{\pi}{2}$. Using the trapezoidal rule on $\frac{1}{2} \int_0^{\\frac{\pi}{2}} r(\theta)^2 \, d\theta$, approximate the area inside $r = 2\cos\theta$ for $0 \le \theta \le \frac{\pi}{2}$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$1.47$"},
            {"id": "B", "value": "$1.10$"},
            {"id": "C", "value": "$1.99$"},
            {"id": "D", "value": "$0.74$"}
        ]$json$::jsonb
    WHERE title = 'U9.9-P4';

    -- U9.9-P5: Outer vs Inner Logic
    -- Fix: Replaced "\interval" and "\intersect" with plain text/standard LaTeX, ensuring no red code.
    UPDATE public.questions
    SET 
        prompt = $prompt$On which interval is $r = 2\cos\theta$ the outer curve compared to $r = 1$ (with $r \ge 0$) for the first-quadrant region where they intersect?$prompt$,
        options = $json$[
            {"id": "A", "value": "$0 \\le \\theta \\le \\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{3} \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "C", "value": "$0 \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{6} \\le \\theta \\le \\frac{\\pi}{3}$"}
        ]$json$::jsonb
    WHERE title = 'U9.9-P5';

END $$;
