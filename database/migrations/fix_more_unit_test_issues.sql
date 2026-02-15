-- Fix for reported Unit Test issues (Part 3)

-- 1. Fix Question 3f678293-e82d-4368-8577-0717a129a045 (Derivative Definition Options)
-- Issue: Options B and C are raw text "lim..." in red.
-- Fix: Wrap in "$" and use proper escaping.
UPDATE public.questions
SET options = $$[
  {
    "id": "A",
    "type": "text",
    "label": "A",
    "value": "$\\lim_{h \\to 0} ( (a+h)^2 - a^2 )$",
    "explanation": "This is missing the division by h."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\lim_{h \\to 0} \\frac{(a+h)^2 - a^2}{h}$",
    "explanation": "Correct: This matches the limit definition of the derivative for f(x)=x^2."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\lim_{h \\to 0} \\frac{a^2 - (a+h)^2}{h}$",
    "explanation": "Incorrect order of subtraction."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\lim_{h \\to 0} \\frac{a^2}{h}$",
    "explanation": "Incorrect formula."
  }
]$$::jsonb
WHERE id = '3f678293-e82d-4368-8577-0717a129a045';

-- 2. Fix Question 891d304e-8db9-44e3-8b7c-f0dab0c25a78 (Mashed Prompt + Missing Graph)
-- Issue: Text "Thegraphof..." is mashed. Image link "/assets/..." is likely broken/local.
-- Fix: Restore spaces in text. Keep the image markdown but acknowledge it might still be broken (URL issue).
-- I'll use a standard placeholder if I can't find the image, but for now I'll just format the text cleanly.
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769403109_2.2-P4_graph.png)

The graph of $y=f(x)$ is shown, along with the tangent line at $x=1$. What is the value of $f'(1)$?$$
WHERE id = '891d304e-8db9-44e3-8b7c-f0dab0c25a78';
