-- Fix Unit 8.4 Options LaTeX Rendering (Refined for JSON Syntax)
-- Corrects options for the "area under ln x" question and fixes JSON escape sequence errors.

UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$1$", "explanation": "Correct: $\\int_1^e \\ln x \\,dx = [x \\ln x - x]_1^e = (e-e) - (0-1) = 1$."},
      {"id": "B", "label": "B", "value": "$e-1$", "explanation": "This would be the result of $\\int_0^1 e^x dx$."},
      {"id": "C", "label": "C", "value": "$e-2$", "explanation": "Incorrect evaluation of the definite integral."},
      {"id": "D", "label": "D", "value": "$2-e$", "explanation": "Incorrect evaluation/sign error."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'c60cde02-5979-43df-a804-8d1240d029bd';
