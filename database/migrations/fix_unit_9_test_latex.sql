-- Fix Unit 9 Test LaTeX Formatting (Q1-Q20) - COMPREHENSIVE
-- Rewrites prompts and options for U9-UT-Q1 to U9-UT-Q20.
-- Applies STRICT LaTeX formatting: named dollar quotes, no triple backslashes, all numbers/vars in $.

DO $$
BEGIN

    -- U9-UT-Q1
    UPDATE public.questions
    SET 
        prompt = $prompt$A curve is given by $x = t^2 + 1$ and $y = 3t - 2$. Find $\frac{dy}{dx}$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{3}{2t}$"},
            {"id": "B", "value": "$\\frac{3}{t}$"},
            {"id": "C", "value": "$\\frac{2t}{3}$"},
            {"id": "D", "value": "$6t$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q1';

    -- U9-UT-Q2
    -- Fix: Replaced `\\\\\\\sin` with `\sin`.
    UPDATE public.questions
    SET 
        prompt = $prompt$Given $x = \sin t$ and $y = \cos t$, what is $\frac{dy}{dx}$ at $t = \frac{\pi}{4}$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$-1$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$-\\sqrt{2}$"},
            {"id": "D", "value": "$0$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q2';

    -- U9-UT-Q3
    UPDATE public.questions
    SET 
        prompt = $prompt$If $x = t^2$ and $y = t^3 - 3t$, which expression equals $\frac{d^2y}{dx^2}$ (in terms of $t$)?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{3t^2-3}{2t}$"},
            {"id": "B", "value": "$\\frac{3t^2-3}{2t^2}$"},
            {"id": "C", "value": "$\\frac{3t^2-3}{4t^2}$"},
            {"id": "D", "value": "$\\frac{3t^2-3}{4t^3}$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q3';

    -- U9-UT-Q4
    UPDATE public.questions
    SET 
        prompt = $prompt$A parametric curve is shown. Which ordered pair corresponds to the point at the largest shown parameter value?$prompt$,
        options = $json$[
            {"id": "A", "value": "The rightmost labeled point on the curve"},
            {"id": "B", "value": "The leftmost labeled point on the curve"},
            {"id": "C", "value": "The highest labeled point on the curve"},
            {"id": "D", "value": "Cannot be determined from the diagram"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q4';

    -- U9-UT-Q5
    -- Fix: Replaced `\integral` with `integral`. Fix integral options.
    UPDATE public.questions
    SET 
        prompt = $prompt$A curve is given by $x = t^2$ and $y = \ln(t+1)$ for $0 \le t \le 2$. Which integral represents the arc length?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\int_0^2 \\sqrt{(\\frac{dx}{dt})^2 + (\\frac{dy}{dt})^2} \\, dt$"},
            {"id": "B", "value": "$\\int_0^2 (\\frac{dx}{dt} + \\frac{dy}{dt}) \\, dt$"},
            {"id": "C", "value": "$\\int_0^2 \\sqrt{1 + (\\frac{dy}{dt})^2} \\, dt$"},
            {"id": "D", "value": "$\\int_0^2 ((\\frac{dx}{dt})^2 + (\\frac{dy}{dt})^2) \\, dt$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q5';

    -- U9-UT-Q6
    -- Fix: Replaced `\second derivative` with `second derivative`.
    UPDATE public.questions
    SET 
        prompt = $prompt$A table related to parametric motion is shown. Which choice best matches the correct sign of the second derivative based on the table trend?$prompt$,
        options = $json$[
            {"id": "A", "value": "Positive"},
            {"id": "B", "value": "Negative"},
            {"id": "C", "value": "Zero"},
            {"id": "D", "value": "Cannot be determined"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q6';

    -- U9-UT-Q7
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has acceleration $\mathbf{a}(t) = \langle 2, 0 \rangle$ and velocity $\mathbf{v}(0) = \langle 1, 3 \rangle$. What is $\mathbf{v}(t)$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 2t+1, 3 \\rangle$"},
            {"id": "B", "value": "$\\langle 2t, 3 \\rangle$"},
            {"id": "C", "value": "$\\langle t+1, 3t \\rangle$"},
            {"id": "D", "value": "$\\langle 2t+3, 1 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q7';

    -- U9-UT-Q8
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has position $\mathbf{r}(t) = \langle e^t, t \rangle$. What is the speed at time $t$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\sqrt{e^{2t}+1}$"},
            {"id": "B", "value": "$e^t+1$"},
            {"id": "C", "value": "$\\sqrt{e^t+1}$"},
            {"id": "D", "value": "$e^{2t}+1$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q8';

    -- U9-UT-Q9
    -- Fix: Replaced `|\mathbf{v}(t)|` with `\|\mathbf{v}(t)\|`. LaTeX for numbers.
    UPDATE public.questions
    SET 
        prompt = $prompt$A table of speed values is shown. Using the trapezoidal rule, approximate $\int_0^4 \|\mathbf{v}(t)\| \, dt$.$prompt$,
        options = $json$[
            {"id": "A", "value": "$10.0$"},
            {"id": "B", "value": "$8.0$"},
            {"id": "C", "value": "$12.0$"},
            {"id": "D", "value": "$5.0$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q9';

    -- U9-UT-Q10
    UPDATE public.questions
    SET 
        prompt = $prompt$A vector-valued path $\mathbf{r}(t)$ is shown. Which statement is true about the direction of motion as $t$ increases?$prompt$,
        options = $json$[
            {"id": "A", "value": "The motion follows the arrow on the curve."},
            {"id": "B", "value": "The motion always goes left to right."},
            {"id": "C", "value": "The motion always goes upward."},
            {"id": "D", "value": "Direction cannot be determined."}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q10';

    -- U9-UT-Q11
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle moves in the plane with velocity $\mathbf{v}(t) = \langle 2t, 1 \rangle$ for $0 \le t \le 2$. What is the displacement vector on $[0, 2]$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\langle 4, 2 \\rangle$"},
            {"id": "B", "value": "$\\langle 2, 1 \\rangle$"},
            {"id": "C", "value": "$\\langle 2, 2 \\rangle$"},
            {"id": "D", "value": "$\\langle 0, 2 \\rangle$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q11';

    -- U9-UT-Q12
    -- Fix: Replaced `\\\\\\\sin` with `\sin`.
    UPDATE public.questions
    SET 
        prompt = $prompt$A polar curve is $r = 1 + \sin\theta$. Which expression equals $\frac{dr}{d\theta}$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\cos\\theta$"},
            {"id": "B", "value": "$-\\cos\\theta$"},
            {"id": "C", "value": "$1 + \\cos\\theta$"},
            {"id": "D", "value": "$\\sin\\theta$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q12';

    -- U9-UT-Q13
    -- Fix: Replaced `\\\int` with `\int`.
    UPDATE public.questions
    SET 
        prompt = $prompt$Which expression gives the area inside a polar curve $r = f(\theta)$ from $\theta = a$ to $\theta = b$?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{1}{2} \\int_a^b (f(\\theta))^2 \\, d\\theta$"},
            {"id": "B", "value": "$\\int_a^b f(\\theta) \\, d\\theta$"},
            {"id": "C", "value": "$\\int_a^b \\sqrt{1 + (f''(\\theta))^2} \\, d\\theta$"},
            {"id": "D", "value": "$| \\int_a^b f(\\theta) \\, d\\theta |$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q13';

    -- U9-UT-Q14
    -- Fix: Replaced `\intersection` with `intersection`.
    UPDATE public.questions
    SET 
        prompt = $prompt$Two polar curves are shown. Which value of $\theta$ is an intersection in the first quadrant?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{2}$"},
            {"id": "C", "value": "$\\frac{2\\pi}{3}$"},
            {"id": "D", "value": "$\\pi$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q14';

    -- U9-UT-Q15
    -- Fix: LaTeX for numbers and negative numbers.
    UPDATE public.questions
    SET 
        prompt = $prompt$A particle has velocity $\mathbf{v}(t) = \langle -3, 4 \rangle$. What is its speed?$prompt$,
        options = $json$[
            {"id": "A", "value": "$5$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$7$"},
            {"id": "D", "value": "$-5$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q15';

    -- U9-UT-Q16
    -- Fix: Replaced `\interval` with `interval`.
    UPDATE public.questions
    SET 
        prompt = $prompt$A position table is shown. Approximate the average rate of change of the $x$-coordinate over the full time interval.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{\\Delta x}{\\Delta t}$ using the first and last rows"},
            {"id": "B", "value": "Average of all listed $x$ values"},
            {"id": "C", "value": "Largest listed $x$ value"},
            {"id": "D", "value": "Sum of all listed $x$ values"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q16';

    -- U9-UT-Q17
    -- Fix: Replaced `\\\\\\\cos` with `\cos`.
    UPDATE public.questions
    SET 
        prompt = $prompt$Find the area of the region inside $r = 2\cos\theta$ and outside $r = 1$ in the first quadrant.$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{\\pi}{6} + \\frac{\\sqrt{3}}{4}$"},
            {"id": "B", "value": "$\\frac{\\pi}{6} - \\frac{\\sqrt{3}}{4}$"},
            {"id": "C", "value": "$\\frac{\\pi}{3} + \\frac{\\sqrt{3}}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{12} + \\frac{\\sqrt{3}}{8}$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q17';

    -- U9-UT-Q18
    -- Fix: Replaced `\interval` with `interval`. LaTeX numbers.
    UPDATE public.questions
    SET 
        prompt = $prompt$A table of speed values is shown. Using the trapezoidal rule with the given spacing, approximate total distance over the interval shown.$prompt$,
        options = $json$[
            {"id": "A", "value": "$7.5$"},
            {"id": "B", "value": "$9.5$"},
            {"id": "C", "value": "$7.0$"},
            {"id": "D", "value": "$3.5$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q18';

    -- U9-UT-Q19
    -- Fix: Replaced `\\\\\\\cos` with `\cos`. Replaced `\intersection` with `intersection`.
    UPDATE public.questions
    SET 
        prompt = $prompt$Two polar curves are $r = 2\cos\theta$ and $r = 1$. Which value is the correct first-quadrant intersection angle?$prompt$,
        options = $json$[
            {"id": "A", "value": "$\\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{6}$"},
            {"id": "C", "value": "$\\frac{\\pi}{2}$"},
            {"id": "D", "value": "$\\frac{2\\pi}{3}$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q19';

    -- U9-UT-Q20
    -- Fix: Replaced `\\\\\\\cos` with `\cos`. Replaced `\interval` with `interval`.
    UPDATE public.questions
    SET 
        prompt = $prompt$The curves $r = 2\cos\theta$ and $r = 1$ are shown. Which interval correctly describes where $r = 2\cos\theta$ is outside $r = 1$ in the first quadrant?$prompt$,
        options = $json$[
            {"id": "A", "value": "$0 \\le \\theta \\le \\frac{\\pi}{3}$"},
            {"id": "B", "value": "$\\frac{\\pi}{3} \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "C", "value": "$0 \\le \\theta \\le \\frac{\\pi}{2}$"},
            {"id": "D", "value": "$\\frac{\\pi}{6} \\le \\theta \\le \\frac{\\pi}{3}$"}
        ]$json$::jsonb
    WHERE title = 'U9-UT-Q20';

END $$;
