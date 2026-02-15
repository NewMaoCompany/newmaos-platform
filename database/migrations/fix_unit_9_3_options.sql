-- Fix Unit 9.3 Options LaTeX Formatting (U9.3-P1 to U9.3-P5)
-- Rewrites options to ensure proper LaTeX rendering using standard delimiters and strict escaping.

DO $$
BEGIN

    -- U9.3-P1: Arc Length Integral
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$\\int_0^1 \\sqrt{(2t)^2+(e^t)^2} \\, dt$"},
        {"id": "B", "value": "$\\int_0^1 (2t+e^t) \\, dt$"},
        {"id": "C", "value": "$\\int_0^1 \\sqrt{1+\\left(\\frac{e^t}{2t}\\right)^2} \\, dt$"},
        {"id": "D", "value": "$\\int_0^1 \\sqrt{2t+e^t} \\, dt$"}
    ]$json$::jsonb
    WHERE title = 'U9.3-P1';

    -- U9.3-P2: Arc Length Value
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$10$"},
        {"id": "B", "value": "$20$"},
        {"id": "C", "value": "$5$"},
        {"id": "D", "value": "$\\sqrt{5}$"}
    ]$json$::jsonb
    WHERE title = 'U9.3-P2';

    -- U9.3-P3: Unit Circle Arc Length
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$1$"},
        {"id": "B", "value": "$\\frac{\\pi}{2}$"},
        {"id": "C", "value": "$\\pi$"},
        {"id": "D", "value": "$2$"}
    ]$json$::jsonb
    WHERE title = 'U9.3-P3';

    -- U9.3-P4: Trapezoidal Rule Approximation
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$17.8$"},
        {"id": "B", "value": "$18.0$"},
        {"id": "C", "value": "$16.8$"},
        {"id": "D", "value": "$35.6$"}
    ]$json$::jsonb
    WHERE title = 'U9.3-P4';

    -- U9.3-P5: t-interval
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$0 \\le t \\le 3$"},
        {"id": "B", "value": "$-3 \\le t \\le 0$"},
        {"id": "C", "value": "$1 \\le t \\le 9$"},
        {"id": "D", "value": "$-2 \\le t \\le 1$"}
    ]$json$::jsonb
    WHERE title = 'U9.3-P5';

END $$;
