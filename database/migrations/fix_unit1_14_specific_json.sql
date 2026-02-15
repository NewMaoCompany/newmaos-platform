-- Fix for Question 4a20b9f3-7002-470a-b576-e8a4850d729c
-- ATTEMPT 5: Standard JSON escaping (2 backslashes).
-- Source `all_questions.json` shows `\\lim` for correct options.
-- We replicate this exactly in the SQL using dollar quotes.
-- `$$ ... \\lim ... $$` -> JSON Parser receives `\\lim` -> Stored Value `\lim`.
-- Markdown `\lim` -> LaTeX `\lim`.

UPDATE public.questions
SET 
  -- 1. Prompt (JSON Array): Needs `\\lim` to become `\lim` in the string element.
  prompt = $$["Use the graph provided. Which statement is correct?", "https://xzpjlnkirboevkjzitcx.supabase.co/storage/v1/object/public/images/questions/b55d71f0-0649-4ca1-ab0e-2bb06e7f286a/1769384224211_xnrzy.jpg"]$$,

  -- 2. Options (Text): Using standard `\\` escaping.
  options = $$[
  {
    "id": "A",
    "type": "text", 
    "label": "A",
    "value": "$\\lim_{x\\to 1^-} f(x)=\\infty$ and $\\lim_{x\\to 1^+} f(x)=\\infty$",
    "explanation": "Left side goes downward, not upward."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "$\\lim_{x\\to 1^-} f(x)=-\\infty$ and $\\lim_{x\\to 1^+} f(x)=\\infty$",
    "explanation": "Correct: opposite infinite behavior on the two sides."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "$\\lim_{x\\to 1^-} f(x)=0$ and $\\lim_{x\\to 1^+} f(x)=0$",
    "explanation": "The function does not approach 0 near the asymptote."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "$\\lim_{x\\to 1} f(x)$ exists and equals 1",
    "explanation": "Correct: left and right limits do not match."
  }
]$$::jsonb
WHERE id = '4a20b9f3-7002-470a-b576-e8a4850d729c';
