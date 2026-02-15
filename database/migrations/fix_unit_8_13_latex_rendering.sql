-- Fix LaTeX Rendering for Unit 8.13 (BC Only)
-- Addresses unformatted math in prompts and incorrect integral/square root escaping in options.
-- Uses E'...' syntax with quadruple backslashes (\\\\) for JSON blocks to ensure proper rendering.

-- U8.13-P1: Arc Length Formula General
UPDATE public.questions SET
    prompt = E'Which integral represents the arc length of $y = f(x)$ on $[a,b]$?',
    explanation = E'Arc length for $y = f(x)$ on $[a,b]$ is $\\int_a^b \\sqrt{1+(f\'\'(x))^2} \\, dx$.',
    options = E'[
        {"id": "A", "value": "$\\\\int_a^b \\\\sqrt{1+(f\'\'(x))^2} \\\\, dx$"},
        {"id": "B", "value": "$\\\\int_a^b (1+f\'\'(x)) \\\\, dx$"},
        {"id": "C", "value": "$\\\\int_a^b \\\\sqrt{1+f\'\'(x)} \\\\, dx$"},
        {"id": "D", "value": "$\\\\int_a^b (1+f\'\'(x)^2) \\\\, dx$"}
    ]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8.13-P1' AND sub_topic_id = '8.13';

-- U8.13-P2: Arc Length for y = 1/4 x^2
UPDATE public.questions SET
    prompt = E'The curve $y = \\frac{1}{4}x^2$ on $0 \\le x \\le 2$ is shown. Which integral gives its arc length?',
    explanation = E'Here $f(x) = \\frac{1}{4}x^2$ so $f\'\'(x) = \\frac{x}{2}$. Arc length is $\\int_0^2 \\sqrt{1+(f\'\'(x))^2} \\, dx = \\int_0^2 \\sqrt{1+\\left(\\frac{x}{2}\\right)^2} \\, dx$.',
    options = E'[
        {"id": "A", "value": "$\\\\int_0^2 \\\\sqrt{1+(\\\\frac{x}{2})^2} \\\\, dx$"},
        {"id": "B", "value": "$\\\\int_0^2 (1+\\\\frac{x}{2}) \\\\, dx$"},
        {"id": "C", "value": "$\\\\int_0^2 \\\\sqrt{1+\\\\frac{x}{2}} \\\\, dx$"},
        {"id": "D", "value": "$\\\\int_0^2 (1+(\\\\frac{x}{2})^2) \\\\, dx$"}
    ]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8.13-P2' AND sub_topic_id = '8.13';

-- U8.13-P3: Total Distance Traveled Formula
UPDATE public.questions SET
    prompt = E'A particle has velocity $v(t)$ on $[a,b]$. Which expression gives the total distance traveled?',
    explanation = E'Displacement is $\\int_a^b v(t) \\, dt$, but total distance counts motion in either direction, so use $\\int_a^b |v(t)| \\, dt$.',
    options = E'[
        {"id": "A", "value": "$\\\\int_a^b v(t) \\\\, dt$"},
        {"id": "B", "value": "$\\\\int_a^b |v(t)| \\\\, dt$"},
        {"id": "C", "value": "$|\\\\int_a^b v(t) \\\\, dt|$"},
        {"id": "D", "value": "$\\\\int_a^b v(t)^2 \\\\, dt$"}
    ]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8.13-P3' AND sub_topic_id = '8.13';

-- U8.13-P4: Total Distance from velocity graph
UPDATE public.questions SET
    prompt = E'The velocity graph $v(t)$ is shown. The particle moves from $t = 0$ to $t = 3$. What is the total distance traveled?',
    explanation = E'From $0$ to $1$, $v > 0$ and area is $1$. From $1$ to $2$, $v < 0$ and absolute area is $1$. From $2$ to $3$, $v = -2$ so distance adds $2$. Total distance $= 1+1+2=5$.',
    options = E'[
        {"id": "A", "value": "5"},
        {"id": "B", "value": "3"},
        {"id": "C", "value": "1"},
        {"id": "D", "value": "7"}
    ]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8.13-P4' AND sub_topic_id = '8.13';

-- U8.13-P5: Units and meaning
UPDATE public.questions SET
    prompt = E'A function $v(t)$ gives velocity in meters per second. Which statement is correct about the units of $\\int_0^5 |v(t)| \\, dt$?',
    explanation = E'Velocity (m/s) times time (s) gives meters. Using $|v(t)|$ makes it total distance rather than signed displacement.',
    options = E'[
        {"id": "A", "value": "It has units of meters and represents total distance traveled."},
        {"id": "B", "value": "It has units of meters per second and represents average velocity."},
        {"id": "C", "value": "It has units of seconds and represents total time traveled."},
        {"id": "D", "value": "It is unitless because of the absolute value."}
    ]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8.13-P5' AND sub_topic_id = '8.13';
