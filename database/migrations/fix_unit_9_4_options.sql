-- Fix Unit 9.4 Options LaTeX Formatting (U9.4-P1 to U9.4-P5)
-- Rewrites options to ensure proper LaTeX rendering for vector-valued functions using standard \langle \rangle delimiters.

DO $$
BEGIN

    -- U9.4-P1: Vector Derivative
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$\\langle 2t, 3, \\cos(t) \\rangle$"},
        {"id": "B", "value": "$\\langle t^2, 3t, \\sin(t) \\rangle$"},
        {"id": "C", "value": "$\\langle 2, 3, \\cos(t) \\rangle$"},
        {"id": "D", "value": "$\\langle 2t, 0, \\cos(t) \\rangle$"}
    ]$json$::jsonb
    WHERE title = 'U9.4-P1';

    -- U9.4-P2: Velocity Vector Value
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$\\langle 1, 4 \\rangle$"},
        {"id": "B", "value": "$\\langle 2, 4 \\rangle$"},
        {"id": "C", "value": "$\\langle 1, 2 \\rangle$"},
        {"id": "D", "value": "$\\langle 2, 8 \\rangle$"}
    ]$json$::jsonb
    WHERE title = 'U9.4-P2';

    -- U9.4-P3: Speed Calculation
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$-1$"},
        {"id": "B", "value": "$7$"},
        {"id": "C", "value": "$5$"},
        {"id": "D", "value": "$1$"}
    ]$json$::jsonb
    WHERE title = 'U9.4-P3';

    -- U9.4-P4: Position from Velocity
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "$\\langle 1+\\pi^2, 0 \\rangle$"},
        {"id": "B", "value": "$\\langle \\pi^2, 0 \\rangle$"},
        {"id": "C", "value": "$\\langle 1+2\\pi, 1 \\rangle$"},
        {"id": "D", "value": "$\\langle 1+\\pi^2, 2 \\rangle$"}
    ]$json$::jsonb
    WHERE title = 'U9.4-P4';

    -- U9.4-P5: Vector Path Interpretation
    UPDATE public.questions
    SET options = $json$[
        {"id": "A", "value": "It moves along the upper semicircle from $(1,0)$ to $(-1,0)$ counterclockwise."},
        {"id": "B", "value": "It moves along the upper semicircle from $(-1,0)$ to $(1,0)$ counterclockwise."},
        {"id": "C", "value": "It moves along the lower semicircle from $(1,0)$ to $(-1,0)$."},
        {"id": "D", "value": "It stays at $(1,0)$ because the position is periodic."}
    ]$json$::jsonb
    WHERE title = 'U9.4-P5';

END $$;
