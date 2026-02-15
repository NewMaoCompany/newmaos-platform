-- Fix Unit 8.3 Formatting Issue (Refined for JSON Syntax)
-- Corrects corrupted LaTeX rendering and fixes JSON escape sequence errors.

UPDATE public.questions
SET
    prompt = $txt$A company’s revenue rate is $R(t)$ measured in dollars per day. What are the units of $\int_0^{10} R(t)\,dt$?$txt$,
    latex = $txt$A company’s revenue rate is $R(t)$ measured in dollars per day. What are the units of $\int_0^{10} R(t)\,dt$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "dollars/day", "explanation": "This is the rate of change of revenue."},
      {"id": "B", "label": "B", "value": "days/dollar", "explanation": "Incorrect units."},
      {"id": "C", "label": "C", "value": "dollars", "explanation": "Correct: the integral of dollars/day over time (days) gives total dollars."},
      {"id": "D", "label": "D", "value": "days", "explanation": "This is a unit of time."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'bbdafb05-9f3f-4b9d-8962-10edf3438b1a';
