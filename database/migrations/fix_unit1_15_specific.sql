-- Fix for Question 051cdc2e-fd06-4eb2-b3b1-ba75e807a64a
-- Issue: Red garbled text in Option A. Likely malformed LaTeX escaping.
-- Solution: Force update with standarized LaTeX syntax using 2 backslashes for JSON string content.

UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\lim_{x \\to \\infty} f(x)=-2$ or $\\lim_{x \\to -\\infty} f(x)=-2$ (or both)",
    "explanation": "Correct: this is the definition of a horizontal asymptote."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$f(x)=-2$ for all $x$",
    "explanation": "An asymptote is approached, not necessarily equal everywhere."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$f(x)$ can never cross $y=-2$",
    "explanation": "Functions can cross horizontal asymptotes (e.g., oscillating functions)."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$f$ has a vertical asymptote",
    "explanation": "Horizontal asymptotes do not imply vertical asymptotes."
  }
]$$::jsonb
WHERE id = '051cdc2e-fd06-4eb2-b3b1-ba75e807a64a';
