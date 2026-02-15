-- Fix Unit 9.8 LaTeX Formatting (Vectors: Speed/Distance)
-- Rewrites prompts and options for U9.8-P1 to U9.8-P5 to ensure ALL numbers are LaTeX formatted.
-- Uses named dollar quotes ($prompt$ and $json$) to strict preserve LaTeX backslashes.

DO $$
BEGIN

    -- U9.8-P1: Speed Expression
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has velocity $\mathbf{v}(t) = \langle \cos t, \sin t \rangle$. What is the speed $\|\mathbf{v}(t)\|$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$1$"},
            {"id": "B", "value": "$\\sin t + \\cos t$"},
            {"id": "C", "value": "$\\sqrt{\\sin t + \\cos t}$"},
            {"id": "D", "value": "$\\sin^2 t + \\cos^2 t$"}
        ]$json$::jsonb
    WHERE title = 'U9.8-P1';

    -- U9.8-P2: Speed Calculation
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle’s position is $\mathbf{r}(t) = \langle t^2, t^3 \rangle$. What is the speed at $t = 1$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sqrt{13}$"},
            {"id": "B", "value": "$5$"},
            {"id": "C", "value": "$\\sqrt{5}$"},
            {"id": "D", "value": "$13$"}
        ]$json$::jsonb
    WHERE title = 'U9.8-P2';

    -- U9.8-P3: Total Distance (Trapezoidal)
    -- Fix: Ensure numbers 0, 3, 1 are LaTeX.
    UPDATE public.questions
    SET 
        prompt = $prompt$A table of speed values $\|\mathbf{v}(t)\|$ is shown for $0 \le t \le 3$. Using the trapezoidal rule with $\Delta t = 1$, approximate the total distance traveled on $[0, 3]$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$7.5$"},
            {"id": "B", "value": "$9.5$"},
            {"id": "C", "value": "$7.0$"},
            {"id": "D", "value": "$3.5$"}
        ]$json$::jsonb
    WHERE title = 'U9.8-P3';

    -- U9.8-P4: Displacement Vector
    -- Fix: Ensure numbers 2, -1, 0, 5, 10, -5, -2, -10 are LaTeX.
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has velocity $\mathbf{v}(t) = \langle 2, -1 \rangle$ for $0 \le t \le 5$. What is the displacement vector on $[0, 5]$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 10, -5 \\rangle$"},
            {"id": "B", "value": "$\\langle 2, -1 \\rangle$"},
            {"id": "C", "value": "$\\langle 5, -2 \\rangle$"},
            {"id": "D", "value": "$\\langle -10, 5 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.8-P4';

    -- U9.8-P5: Total Distance Integral
    -- Fix: Ensure [a, b] is LaTeX. Fix norm syntax.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which expression represents the total distance traveled by a particle on $[a, b]$ if its velocity is $\mathbf{v}(t)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\int_a^b \\|\\mathbf{v}(t)\\| \\, dt$"},
            {"id": "B", "value": "$\\| \\int_a^b \\mathbf{v}(t) \\, dt \\|$"},
            {"id": "C", "value": "$\\int_a^b \\mathbf{v}(t) \\, dt$"},
            {"id": "D", "value": "$\\int_a^b \\|\\mathbf{v}(t)\\|^2 \\, dt$"}
        ]$json$::jsonb
    WHERE title = 'U9.8-P5';

END $$;
