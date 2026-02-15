-- Targeted Fix for Question 11 (Unit 7 Test)
-- Also fixes Question 2 and Question 15 if they share the same ID.
-- Replaces raw filename with descriptive text to eliminate red text/jumbled display.

UPDATE public.questions
SET
    prompt = $txt$Use the graph in U7.5 logistic growth curve. Which statement best describes the long-term behavior of $y(t)$?$txt$,
    latex = $txt$Use the graph in U7.5 logistic growth curve. Which statement best describes the long-term behavior of $y(t)$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$y(t)$ increases without bound.", "explanation": "Logistic-type growth levels off rather than growing unbounded."},
      {"id": "B", "label": "B", "value": "$y(t)$ approaches a horizontal asymptote (levels off).", "explanation": "Correct: the graph clearly approaches a constant level."},
      {"id": "C", "label": "C", "value": "$y(t)$ oscillates around a constant value.", "explanation": "No oscillations are shown."},
      {"id": "D", "label": "D", "value": "$y(t)$ decreases to $0$.", "explanation": "The curve is increasing and leveling off, not decreasing."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id IN ('b508b1f0-b367-48a5-bae0-60e817f1bd36', 'b4ba378d-3528-445c-8767-93a76089fa54');
