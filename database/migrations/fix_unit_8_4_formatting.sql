-- Fix Unit 8.4 Formatting Issue (Refined for JSON Syntax)
-- Corrects corrupted LaTeX rendering and fixes JSON escape sequence errors.

UPDATE public.questions
SET
    prompt = $txt$Find the area of the region between $y = \sin x$ and $y = \cos x$ on $\left[0, \frac{\pi}{2}\right]$.$txt$,
    latex = $txt$Find the area of the region between $y = \sin x$ and $y = \cos x$ on $\left[0, \frac{\pi}{2}\right]$.$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$2\\sqrt{2}-2$", "explanation": "Correct: Area is $\\int_0^{\\pi/4}(\\cos x-\\sin x)dx + \\int_{\\pi/4}^{\\pi/2}(\\sin x-\\cos x)dx = (\\sqrt{2}-1) + (\\sqrt{2}-1) = 2\\sqrt{2}-2$."},
      {"id": "B", "label": "B", "value": "$\\sqrt{2}-1$", "explanation": "This is only the area of half the region (from $0$ to $\\pi/4$)."},
      {"id": "C", "label": "C", "value": "$1$", "explanation": "Incorrect evaluation of the definite integrals."},
      {"id": "D", "label": "D", "value": "$2-2\\sqrt{2}$", "explanation": "Wrong sign (area must be positive)."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'b2d3bb71-074f-4c5c-b345-1d137f262c02';
