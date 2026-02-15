-- Fix for Question c351da6f-a1c7-4cc5-aa9f-efed76b3930b
-- Issue: Prompt is RAW TEXT (not JSON), so $$ \lim $$ (1 backslash) is required.
-- Previous attempt used 2 backslashes, which corrupted the LaTeX command.

UPDATE public.questions
SET 
  -- Prompt: Single backslashes for Raw Text Column
  prompt = $$Which statement correctly interprets $\lim_{x\to 3^-} f(x)=-\infty$?$$,
  
  -- Options: JSON encoded. "$" is safe. No other complex latex in these options.
  options = $$[
  {
    "id": "A",
    "type": "text", 
    "label": "A",
    "value": "As $x$ approaches 3 from the left, $f(x)$ decreases without bound.",
    "explanation": "Correct: left-hand approach and values go down without bound."
  },
  {
    "id": "B",
    "type": "text",
    "label": "B",
    "value": "As $x$ approaches 3 from the right, $f(x)$ decreases without bound.",
    "explanation": "This incorrectly uses the right-hand side."
  },
  {
    "id": "C",
    "type": "text",
    "label": "C",
    "value": "As $x$ approaches 3 from the left, $f(x)$ approaches 0.",
    "explanation": "The limit is infinite, not zero."
  },
  {
    "id": "D",
    "type": "text",
    "label": "D",
    "value": "As $x$ approaches 3, $f(3)$ must be undefined.",
    "explanation": "While true for the graph, this is not what the limit statement says."
  }
]$$::jsonb
WHERE id = 'c351da6f-a1c7-4cc5-aa9f-efed76b3930b';
