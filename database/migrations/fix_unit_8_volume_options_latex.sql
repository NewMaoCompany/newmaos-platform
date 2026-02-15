-- Fix Unit 8 Volume Options LaTeX Rendering
-- Corrects options for the "trapezoidal rule semicircle volume" question to ensure LaTeX rendering.

UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{33\\pi}{16}$", "explanation": "Correct: $V \\approx \\frac{1}{2}(A_0 + 2(A_1+A_2+A_3) + A_4) = \\frac{1}{2}(\\frac{\\pi}{8}(0^2 + 2(2^2 + 3^2 + 4^2) + 5^2))$ calculation result."},
      {"id": "B", "label": "B", "value": "$\\frac{33\\pi}{8}$", "explanation": "Forgets the $1/2$ factor from the trapezoidal rule."},
      {"id": "C", "label": "C", "value": "$\\frac{33\\pi}{32}$", "explanation": "Extra factor of $1/2$ applied incorrectly."},
      {"id": "D", "label": "D", "value": "$\\frac{11\\pi}{4}$", "explanation": "Arithmetic error in summing the areas."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'a7c27dfd-4986-4ee5-9278-6b3221965db9';
