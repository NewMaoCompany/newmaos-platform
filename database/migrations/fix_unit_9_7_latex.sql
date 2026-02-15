-- Fix Unit 9.7 LaTeX Formatting (Polar/Vector Derivatives) - REFINED
-- Rewrites prompts and options for U9.7-P1 to U9.7-P5 to ensure ALL numbers are LaTeX formatted.
-- Uses named dollar quotes ($prompt$ and $json$) to strict preserve LaTeX backslashes.

DO $$
BEGIN

    -- U9.7-P1: Velocity from Position
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle’s position is $\mathbf{r}(t) = \langle t, t^2 \rangle$. What is the velocity vector $\mathbf{v}(t)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 1, 2t \\rangle$"},
            {"id": "B", "value": "$\\langle t, 2t \\rangle$"},
            {"id": "C", "value": "$\\langle 1, t^2 \\rangle$"},
            {"id": "D", "value": "$\\langle 2t, 1 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.7-P1';

    -- U9.7-P2: Slope dy/dx
    UPDATE public.questions
    SET 
        prompt = $prompt$A curve is given by $x = t$ and $y = t^2$. What is $\frac{dy}{dx}$ at $t = \frac{3}{2}$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$3$"},
            {"id": "B", "value": "$\\frac{3}{2}$"},
            {"id": "C", "value": "$\\frac{9}{4}$"},
            {"id": "D", "value": "$\\frac{4}{9}$"}
        ]$json$::jsonb
    WHERE title = 'U9.7-P2';

    -- U9.7-P3: Point corresponding to t
    UPDATE public.questions
    SET 
        prompt = $prompt$The curve for $0 \le t \le 2$ with $x = t$ and $y = t^2$ is shown. Which point on the graph corresponds to $t = 2$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$(2, 4)$"},
            {"id": "B", "value": "$(4, 2)$"},
            {"id": "C", "value": "$(2, 2)$"},
            {"id": "D", "value": "$(0, 2)$"}
        ]$json$::jsonb
    WHERE title = 'U9.7-P3';

    -- U9.7-P4: Approximate Displacement (Trapezoidal)
    -- Fix: Ensure numbers 1, 4, 0 are LaTeX. Ensure v_y is v_{y}.
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has velocity components given in the table. Using the trapezoidal rule with $\Delta t = 1$, approximate the displacement vector $\int_{0}^{4} \langle v_{x}(t), v_{y}(t) \rangle \, dt$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 4, 0 \\rangle$"},
            {"id": "B", "value": "$\\langle 2, 0 \\rangle$"},
            {"id": "C", "value": "$\\langle 4, -4 \\rangle$"},
            {"id": "D", "value": "$\\langle 0, 4 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.7-P4';

    -- U9.7-P5: Speed at t=3
    -- Fix: Ensure t=3 is LaTeX everywhere.
    UPDATE public.questions
    SET 
        prompt = $prompt$Using the table values at $t = 3$, the velocity is $\mathbf{v}(3) = \langle 1, -1 \rangle$. What is the speed at $t = 3$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sqrt{2}$"},
            {"id": "B", "value": "$0$"},
            {"id": "C", "value": "$2$"},
            {"id": "D", "value": "$-\\sqrt{2}$"}
        ]$json$::jsonb
    WHERE title = 'U9.7-P5';

END $$;
