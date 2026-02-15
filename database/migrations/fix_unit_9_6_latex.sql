-- Fix Unit 9.6 LaTeX Formatting (Motion Problems with Vectors)
-- Rewrites prompts and options for U9.6-P1 to U9.6-P5.
-- Uses named dollar quotes ($prompt$ and $json$) to strict preserve LaTeX backslashes for vectors.

DO $$
BEGIN

    -- U9.6-P1: Vector Value at t
    UPDATE public.questions
    SET 
        prompt = $prompt$A vector-valued function is $\mathbf{r}(t) = \langle t^2, 3-t \rangle$. What is $\mathbf{r}(2)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 4, 1 \\rangle$"},
            {"id": "B", "value": "$\\langle 2, 1 \\rangle$"},
            {"id": "C", "value": "$\\langle 4, -1 \\rangle$"},
            {"id": "D", "value": "$\\langle 1, 4 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.6-P1';

    -- U9.6-P2: Velocity Vector
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle’s position is $\mathbf{r}(t) = \langle t^2, 3-t \rangle$. What is its velocity vector $\mathbf{v}(t)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 2t, -1 \\rangle$"},
            {"id": "B", "value": "$\\langle t, -1 \\rangle$"},
            {"id": "C", "value": "$\\langle 2t, 1 \\rangle$"},
            {"id": "D", "value": "$\\langle t^2, 3-t \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.6-P2';

    -- U9.6-P3: Speed Calculation
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has velocity $\mathbf{v}(t) = \langle 3, 4t \rangle$. What is the speed at $t = 2$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sqrt{73}$"},
            {"id": "B", "value": "$11$"},
            {"id": "C", "value": "$\\sqrt{25}$"},
            {"id": "D", "value": "$\\sqrt{19}$"}
        ]$json$::jsonb
    WHERE title = 'U9.6-P3';

    -- U9.6-P4: Displacement from Table
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle’s position $\mathbf{r}(t) = \langle x(t), y(t) \rangle$ is given in the table. What is the displacement vector from $t = 0$ to $t = 3$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 0, 4 \\rangle$"},
            {"id": "B", "value": "$\\langle 4, 0 \\rangle$"},
            {"id": "C", "value": "$\\langle -4, 0 \\rangle$"},
            {"id": "D", "value": "$\\langle 1, 4 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.6-P4';

    -- U9.6-P5: Motion Description
    UPDATE public.questions
    SET 
        prompt = $prompt$The plotted points show sampled positions of a particle at $t = 0, 1, 2, 3$. Which statement best describes the motion from $t = 0$ to $t = 3$?$prompt$,
        options = $json$[
            {"id": "A", "value": "The particle moves generally upward (increasing $y$) while $x$ returns to its starting value."},
            {"id": "B", "value": "The particle moves generally rightward (increasing $x$) while $y$ returns to its starting value."},
            {"id": "C", "value": "The particle stays on a horizontal line (constant $y$)."},
            {"id": "D", "value": "The particle moves in a circle centered at the origin."}
        ]$json$::jsonb
    WHERE title = 'U9.6-P5';

END $$;
