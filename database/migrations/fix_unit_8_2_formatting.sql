-- Fix Unit 8.2 Formatting Issue (Refined for JSON Syntax)
-- Replaces \text with simple math mode units and fixes JSON escape sequence errors.

UPDATE public.questions
SET
    prompt = $txt$If $a(t)$ is measured in $m/s^2$, what are the units of $\int_0^T a(t)\,dt$?$txt$,
    latex = $txt$If $a(t)$ is measured in $m/s^2$, what are the units of $\int_0^T a(t)\,dt$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$m/s^2$", "explanation": "This is acceleration."},
      {"id": "B", "label": "B", "value": "$m/s$", "explanation": "Correct: the integral of acceleration is velocity (m/s)."},
      {"id": "C", "label": "C", "value": "m", "explanation": "This is position/distance (meters)."},
      {"id": "D", "label": "D", "value": "$s/m$", "explanation": "These are not standard velocity units."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '0deaca7b-8a3f-4cb5-86a9-fbfa269384b1';
