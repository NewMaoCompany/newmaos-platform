-- Fix for Unit 5 Test Questions Formatting (Q18, Q19)

-- U5-UT-Q18
-- Fix "x - value" -> "x-value" in prompt
UPDATE public.questions
SET
    prompt = $txt$The provided graph is $f''(x)$. At which x-value does $f$ have an inflection point?$txt$,
    latex = $txt$The provided graph is $f''(x)$. At which x-value does $f$ have an inflection point?$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q18';

-- U5-UT-Q19
-- Fix corrupted \frac in options (Red text issue)
-- This is a duplicate of U5.12-P1 but in the unit test
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Correct: Correct collection of dy/dx terms."},
      {"id": "B", "label": "B", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{2x + y}$", "type": "text", "explanation": "Incorrect: Would force dy/dx=-1 always, which is not true."},
      {"id": "C", "label": "C", "value": "$\\frac{dy}{dx} = \\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Incorrect: Sign error."},
      {"id": "D", "label": "D", "value": "$\\frac{dy}{dx} = -\\frac{2x + 1}{1 + 2y}$", "type": "text", "explanation": "Incorrect: Breaks the product differentiation structure."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q19';
