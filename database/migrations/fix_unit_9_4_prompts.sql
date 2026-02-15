-- Fix Unit 9.4 Prompts LaTeX Formatting (U9.4-P1 to U9.4-P5)
-- Rewrites prompts to ensure proper LaTeX rendering for vector-valued functions using standard \mathbf and \langle \rangle delimiters.

DO $$
BEGIN

    -- U9.4-P1: Vector Derivative
    UPDATE public.questions
    SET prompt = $prompt$Let $\mathbf{r}(t) = \langle t^2-1, 3t, \sin(t) \rangle$. What is $\mathbf{r}''(t)$?$prompt$
    WHERE title = 'U9.4-P1';

    -- U9.4-P2: Velocity Vector Value
    UPDATE public.questions
    SET prompt = $prompt$A particle has position $\mathbf{r}(t) = \langle t, t^2 \rangle$. What is its velocity vector $\mathbf{v}(2)$?$prompt$
    WHERE title = 'U9.4-P2';

    -- U9.4-P3: Speed Calculation
    UPDATE public.questions
    SET prompt = $prompt$A particle has velocity $\mathbf{v}(t) = \langle 3, -4 \rangle$. What is its speed?$prompt$
    WHERE title = 'U9.4-P3';

    -- U9.4-P4: Position from Velocity
    UPDATE public.questions
    SET prompt = $prompt$A particle has velocity $\mathbf{v}(t) = \langle 2t, \cos(t) \rangle$ and position $\mathbf{r}(0) = \langle 1, 0 \rangle$. What is $\mathbf{r}(\pi)$?$prompt$
    WHERE title = 'U9.4-P4';

    -- U9.4-P5: Vector Path Interpretation
    UPDATE public.questions
    SET prompt = $prompt$The path of a particle is shown for $0 \le t \le \pi$. The particle’s position is $\mathbf{r}(t) = \langle \cos(t), \sin(t) \rangle$. Which statement is true?$prompt$
    WHERE title = 'U9.4-P5';

END $$;
