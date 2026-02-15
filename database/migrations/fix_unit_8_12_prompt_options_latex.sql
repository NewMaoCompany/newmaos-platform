-- Fix Unit 8.12 Question Prompt & Options LaTeX Rendering
-- Corrects prompt and options for the "revolved about y=1" washer method question to ensure professional LaTeX rendering and fix corrupted text.

UPDATE public.questions
SET
    prompt = E'For the region $x^2 \\le y \\le 4$ on $-2 \\le x \\le 2$ revolved about $y=1$, what is the volume?',
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{544\\pi}{15}$", "explanation": "Correct: $V = \\pi \\int_{-2}^{2} (3^2 - (x^2-1)^2) \\,dx = \\pi \\int_{-2}^{2} (8 + 2x^2 - x^4) \\,dx = \\frac{544\\pi}{15}$."},
      {"id": "B", "label": "B", "value": "$\\frac{272\\pi}{15}$", "explanation": "Arithmetic error, likely forgetting the doubling if integrating from 0 to 2."},
      {"id": "C", "label": "C", "value": "$\\frac{424\\pi}{15}$", "explanation": "Arithmetic error in the integration expansion or evaluation."},
      {"id": "D", "label": "D", "value": "$\\frac{544\\pi}{5}$", "explanation": "Arithmetic error in evaluating the denominator."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '2ebdfdda-162a-4aea-887f-57dd3f9b4fb3';
