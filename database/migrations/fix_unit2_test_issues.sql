-- Fix for Unit 2 Unit Test Report
-- Issues:
-- 1. Question 9 (88fa7ab9...): Red garbled options (Quotient Rule).
-- 2. Question 10 (271d5001...): Mashed prompt text.
-- 3. Question 17 (4eb3349b...): Mashed prompt text.

-- 1. Fix Question 9 (88fa7ab9-c412-41be-be20-0c1ccd0c66a0)
UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\frac{(2x)(x-1) - (x^2+1)(1)}{(x-1)^2}$",
    "explanation": "Correct. Using u'v - uv' over v^2."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\frac{(2x)(x-1) + (x^2+1)(1)}{(x-1)^2}$",
    "explanation": "Quotient rule uses subtraction."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\frac{2x}{x-1}$",
    "explanation": "Incorrect differentiation."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\frac{x^2+1}{(x-1)^2}$",
    "explanation": "Incorrect application of the rule."
  }
]$$::jsonb
WHERE id = '88fa7ab9-c412-41be-be20-0c1ccd0c66a0';

-- 2. Fix Question 10 (271d5001-ab77-40ee-863d-ecb908e00ee7)
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_UT_Q4_graph.png)

The graph of $f$ is provided. Estimate $f'(1)$}.$$
WHERE id = '271d5001-ab77-40ee-863d-ecb908e00ee7';

-- 3. Fix Question 17 (4eb3349b-6d4c-469f-9a3b-aada3e83c2c1)
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_UT_Q10_graph.png)

The graph of $g$ is provided. At $x=0$, which is true?$$
WHERE id = '4eb3349b-6d4c-469f-9a3b-aada3e83c2c1';
