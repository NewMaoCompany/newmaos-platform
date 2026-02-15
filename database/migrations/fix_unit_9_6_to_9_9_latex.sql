-- Fix Unit 9.6 - 9.9 LaTeX Formatting (Vectors & Polar)
-- Addresses pervasive LaTeX escaping issues (triple backslashes) and invalid custom commands.
-- Uses named dollar quotes to ensure strict preservation of LaTeX syntax.

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
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has velocity components given in the table. Using the trapezoidal rule with $\Delta t = 1$, approximate the displacement vector $\int_0^4 \langle v_x(t), v_y(t) \rangle \, dt$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 4, 0 \\rangle$"},
            {"id": "B", "value": "$\\langle 2, 0 \\rangle$"},
            {"id": "C", "value": "$\\langle 4, -4 \\rangle$"},
            {"id": "D", "value": "$\\langle 0, 4 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9.7-P4';

    -- U9.7-P5: Speed at t=3
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
    UPDATE public.questions
    SET 
        prompt = $prompt$A table of speed values $|\mathbf{v}(t)|$ is shown for $0 \le t \le 3$. Using the trapezoidal rule with $\Delta t = 1$, approximate the total distance traveled on $[0, 3]$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$7.5$"},
            {"id": "B", "value": "$9.5$"},
            {"id": "C", "value": "$7.0$"},
            {"id": "D", "value": "$3.5$"}
        ]$json$::jsonb
    WHERE title = 'U9.8-P3';

    -- U9.8-P4: Displacement Vector
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

    -- U9.9-P1: Polar Intersection
    -- Fix: Replaced "\intersect" with "intersect".
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
    -- Fix: Replaced "\integral" with "integral".
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
    -- Fix: Replaced "\interval" and "\intersect" with plain text.
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
