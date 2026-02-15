-- Fix Unit 9.5 LaTeX Formatting (U9.5-P1 to U9.5-P5)
-- Rewrites prompts and options to fix triple backslash issues and custom command (e.g. \integral) rendering.
-- Uses named dollar quotes ($prompt$ and $json$) to strictly preserve LaTeX backslashes.

DO $$
BEGIN

    -- U9.5-P1: Polar Area (Simple)
    UPDATE public.questions
    SET 
        prompt = $prompt$The region enclosed by the polar curve $r = 1 + \sin(\theta)$ is traced once as $\theta$ goes from $0$ to $2\pi$. Which expression gives the area of the region?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{2} \\int_0^{2\\pi} (1 + \\sin\\theta)^2 \\, d\\theta$"},
            {"id": "B", "value": "$\\int_0^{2\\pi} (1 + \\sin\\theta)^2 \\, d\\theta$"},
            {"id": "C", "value": "$\\frac{1}{2} \\int_0^{2\\pi} (1 + \\sin\\theta) \\, d\\theta$"},
            {"id": "D", "value": "$\\int_0^{2\\pi} (1 + \\sin\\theta) \\, d\\theta$"}
        ]$json$::jsonb
    WHERE title = 'U9.5-P1';

    -- U9.5-P2: Area Between Polar Curves
    UPDATE public.questions
    SET 
        prompt = $prompt$Let $R$ be the region inside $r = 2$ and outside $r = 1 + \cos(\theta)$ for $0 \le \theta \le 2\pi$. Which expression gives the area of $R$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{2} \\int_0^{2\\pi} (2^2 - (1 + \\cos\\theta)^2) \\, d\\theta$"},
            {"id": "B", "value": "$\\frac{1}{2} \\int_0^{2\\pi} ((1 + \\cos\\theta)^2 - 2^2) \\, d\\theta$"},
            {"id": "C", "value": "$\\int_0^{2\\pi} (2 - (1 + \\cos\\theta)) \\, d\\theta$"},
            {"id": "D", "value": "$\\frac{1}{2} (\\int_0^{2\\pi} 2^2 \\, d\\theta - \\int_0^{2\\pi} (1 + \\cos\\theta) \\, d\\theta)$"}
        ]$json$::jsonb
    WHERE title = 'U9.5-P2';

    -- U9.5-P3: Polar Graph Interpretation
    UPDATE public.questions
    SET 
        prompt = $prompt$The polar curve $r = 2\cos(\theta)$ is shown. Which statement is true about the graph?$prompt$,
        options = $json$[
            {"id": "A", "value": "It is a circle of radius $1$ centered at $(1,0)$."},
            {"id": "B", "value": "It is a circle of radius $2$ centered at the origin."},
            {"id": "C", "value": "It is a cardioid with a cusp at the origin."},
            {"id": "D", "value": "It is a line segment along the $y$-axis."}
        ]$json$::jsonb
    WHERE title = 'U9.5-P3';

    -- U9.5-P4: Area Setup from Graph
    -- Fix: Replaced "\integral" with "integral" in prompt.
    UPDATE public.questions
    SET 
        prompt = $prompt$The curves $r = 2$ and $r = 1 + \cos(\theta)$ are shown. Which integral gives the area inside $r = 2$ and outside $r = 1 + \cos(\theta)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{2} \\int_0^{2\\pi} (4 - (1 + \\cos\\theta)^2) \\, d\\theta$"},
            {"id": "B", "value": "$\\frac{1}{2} \\int_0^{2\\pi} ((1 + \\cos\\theta)^2 - 4) \\, d\\theta$"},
            {"id": "C", "value": "$\\int_0^{2\\pi} (2 - (1 + \\cos\\theta)) \\, d\\theta$"},
            {"id": "D", "value": "$\\frac{1}{2} \\int_0^{\\pi} (4 - (1 + \\cos\\theta)^2) \\, d\\theta$"}
        ]$json$::jsonb
    WHERE title = 'U9.5-P4';

    -- U9.5-P5: Arc Length Formula
    -- Fix: Replaced "\integrand" with "integrand" in prompt.
    UPDATE public.questions
    SET 
        prompt = $prompt$A polar curve is given by $r = f(\theta)$ on $\alpha \le \theta \le \beta$. Which integrand is used to compute the arc length of the curve (with respect to $\theta$)?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sqrt{r^2 + (\\frac{dr}{d\\theta})^2}$"},
            {"id": "B", "value": "$\\sqrt{1 + (\\frac{dr}{d\\theta})^2}$"},
            {"id": "C", "value": "$r + \\frac{dr}{d\\theta}$"},
            {"id": "D", "value": "$r^2 + (\\frac{dr}{d\\theta})^2$"}
        ]$json$::jsonb
    WHERE title = 'U9.5-P5';

END $$;
