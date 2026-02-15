-- Fix for Question beab9937-2e0a-420e-a540-3e46624c7188
-- Issue: Options B and C display raw LaTeX (red text) because they are missing `$` delimiters.
-- Fix: Wrap the expressions in `$`. Use 2 backslashes for JSON string escaping.

UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$f(a+h) - f(a)$",
    "explanation": "This is the change in y, not the rate of change."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{f(a+h) - f(a)}{h}$",
    "explanation": "Correct: calculate the slope between (a, f(a)) and (a+h, f(a+h))."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{f(a) - f(a+h)}{h}$",
    "explanation": "This has the sign reversed."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{f(a)}{h}$",
    "explanation": "Incorrect formula."
  }
]$$::jsonb
WHERE id = 'beab9937-2e0a-420e-a540-3e46624c7188';
