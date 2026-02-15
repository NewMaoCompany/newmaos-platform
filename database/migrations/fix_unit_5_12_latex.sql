-- Fix for Unit 5.12 LaTeX Options (Corrupted Backslashes)

-- U5.12-P1
-- Fix corrupted \frac in options (likely interpreted as form feed \f)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Correct: matches the result after collecting dy/dx terms."},
      {"id": "B", "label": "B", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{2x + y}$", "type": "text", "explanation": "Incorrect: would force $\\frac{dy}{dx} = -1$ always, which is not true."},
      {"id": "C", "label": "C", "value": "$\\frac{dy}{dx} = \\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Incorrect: sign error."},
      {"id": "D", "label": "D", "value": "$\\frac{dy}{dx} = -\\frac{2x + 1}{1 + 2y}$", "type": "text", "explanation": "Incorrect: treats $y$ like a constant and breaks the product structure."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U5.12-P1';

-- U5.12-P3
-- Fix potential corruption in fraction options (-5/4 etc)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$-\\frac{5}{4}$", "type": "text", "explanation": "Correct: correct substitution gives -5/4."},
      {"id": "B", "label": "B", "value": "$-\\frac{4}{5}$", "type": "text", "explanation": "Incorrect: reciprocal error."},
      {"id": "C", "label": "C", "value": "$\\frac{5}{4}$", "type": "text", "explanation": "Incorrect: sign error."},
      {"id": "D", "label": "D", "value": "$\\frac{4}{5}$", "type": "text", "explanation": "Incorrect: sign and reciprocal are both wrong."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U5.12-P3';
