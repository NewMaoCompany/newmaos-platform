-- Fix for Question 52fe8fe2-8729-4d93-a390-97f661acfd9a (Subtopic 2.10 - Derivatives of Trig)
-- Issue: Options displayed as red garbled LaTeX due to missing "$" wrappers.
-- Fix: Force update options with proper "$" delimiters and correct LaTeX escaping.

UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\frac{(\\sec^2 x)(x) - (\\tan x)(1)}{x^2}$",
    "explanation": "Correct. u'v - uv' over v^2 gives the right form."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{(\\sec^2 x)(x) + (\\tan x)(1)}{x^2}$",
    "explanation": "This uses + instead of - in the numerator."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{\\sec^2 x}{x}$",
    "explanation": "Incorrectly differentiating numerator and denominator separately."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{\\tan x}{x^2}$",
    "explanation": "Incorrect power rule application."
  }
]$$::jsonb
WHERE id = '52fe8fe2-8729-4d93-a390-97f661acfd9a';
