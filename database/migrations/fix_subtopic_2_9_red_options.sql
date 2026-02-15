-- Fix 4 questions in Subtopic 2.9 (Quotient Rule) with Red Garbled Options
-- Issue: Missing "$" delimiters causing raw LaTeX to display as error text.
-- Fix: Force update options with correct "$" wrapping and standard 2-backslash escaping.

-- 1. Question 184e3ee3-de68-47e6-aaeb-a6acab457ffd (x^2 / x+1)
UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\frac{(2x)(x+1) - x^2(1)}{(x+1)^2}$",
    "explanation": "Correct. This matches (u'v - uv')/v^2."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{(2x)(x+1) + x^2(1)}{(x+1)^2}$",
    "explanation": "Quotient rule uses subtraction in the numerator."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{2x}{1}$",
    "explanation": "You cannot just differentiate top and bottom separately."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{(x+1)(2x) - x^2(1)}{(x+1)}$",
    "explanation": "Denominator must be squared."
  }
]$$::jsonb
WHERE id = '184e3ee3-de68-47e6-aaeb-a6acab457ffd';

-- 2. Question 3828181b-4115-4bf0-bc85-5f5813ca1857 (ln x / x)
UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\frac{(1/x)(x) - (\\ln x)(1)}{x^2}$",
    "explanation": "Correct. u'v - uv' over v^2 gives the right structure."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{(1/x)(x) + (\\ln x)(1)}{x^2}$",
    "explanation": "Quotient rule has a minus sign."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{1/x}{1}$",
    "explanation": "Cannot treat quotient as separate derivatives."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{\\ln x}{x^2}$",
    "explanation": "Incorrect application of the rule."
  }
]$$::jsonb
WHERE id = '3828181b-4115-4bf0-bc85-5f5813ca1857';

-- 3. Question 5f28158d-416c-4237-b617-427fdd4fac14 ((3x^2 - 1)/x)
UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\frac{(6x)(x) - (3x^2 - 1)(1)}{x^2}$",
    "explanation": "Correct. This is u'v - uv' over v^2."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{(6x)(x) + (3x^2 - 1)(1)}{x^2}$",
    "explanation": "Quotient rule requires subtraction."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{6x}{1}$",
    "explanation": "Incorrect: treated as separate derivatives."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{(3x^2 - 1)(1) - (6x)(x)}{x^2}$",
    "explanation": "Reversed order of u'v and uv'."
  }
]$$::jsonb
WHERE id = '5f28158d-416c-4237-b617-427fdd4fac14';

-- 4. Question 8d676d26-b96a-4f4b-8b5e-6b034eabc24a (sin x / x^2)
UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\frac{(\\cos x)(x^2) - (\\sin x)(2x)}{(x^2)^2}$",
    "explanation": "Correct. This is u'v - uv' over v^2."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{(\\cos x)(x^2) + (\\sin x)(2x)}{(x^2)^2}$",
    "explanation": "Quotient rule uses subtraction."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{\\cos x}{2x}$",
    "explanation": "Cannot differentiate top and bottom independently."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{\\sin x}{2x}$",
    "explanation": "Incorrect formula."
  }
]$$::jsonb
WHERE id = '8d676d26-b96a-4f4b-8b5e-6b034eabc24a';
