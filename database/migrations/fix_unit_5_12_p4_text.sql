-- Fix for Unit 5.12 Question 4 Text Corruption (Empty Parentheses)

-- U5.12-P4
-- Restore text inside parentheses for options C and D
-- Current state in screenshot: "The slope is 0 (())."
-- Intended state: "The slope is 0 (horizontal tangent)."
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "The slope is positive.", "type": "text", "explanation": "Correct: $\\sqrt{5}$ is positive."},
      {"id": "B", "label": "B", "value": "The slope is negative.", "type": "text", "explanation": "Incorrect: sign mistake."},
      {"id": "C", "label": "C", "value": "The slope is 0 (horizontal tangent).", "type": "text", "explanation": "Incorrect: would require $x = 0$ at that point."},
      {"id": "D", "label": "D", "value": "The slope is undefined (vertical tangent).", "type": "text", "explanation": "Incorrect: would require $y = 0$ at that point."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U5.12-P4';
