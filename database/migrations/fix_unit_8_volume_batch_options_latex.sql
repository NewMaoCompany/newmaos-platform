-- Fix Unit 8 Volume Questions Options LaTeX Rendering
-- Corrects options for two volume questions to ensure professional LaTeX rendering.

-- 1. Fix revolved about y-axis question (ID: 2c20fb9c-e5de-43e8-82b3-75d6cf47aa8c)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{32\\pi}{5}$", "explanation": "Correct: $V = \\pi\\int_0^2 (y^2)^2 \\,dy = \\pi\\int_0^2 y^4 \\,dy = \\pi[\\frac{y^5}{5}]_0^2 = \\frac{32\\pi}{5}$."},
      {"id": "B", "label": "B", "value": "$\\frac{16\\pi}{5}$", "explanation": "Arithmetic error in evaluating the integral."},
      {"id": "C", "label": "C", "value": "$\\frac{32\\pi}{3}$", "explanation": "Incorrectly uses $r(y)=y^2$ as the integrand without squaring or wrong power rule."},
      {"id": "D", "label": "D", "value": "$\\frac{8\\pi}{5}$", "explanation": "Arithmetic error in evaluating $2^5/5$."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '2c20fb9c-e5de-43e8-82b3-75d6cf47aa8c';

-- 2. Fix revolved about x-axis question (ID: 2c689f9b-7fc2-470a-9237-5b69245cfcba)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{8\\pi}{3}$", "explanation": "Correct: $r=2-x$, $V = \\pi\\int_0^2 (2-x)^2 \\,dx = \\pi\\int_0^2 (4-4x+x^2) \\,dx = \\pi[4x-2x^2+\\frac{x^3}{3}]_0^2 = \\frac{8\\pi}{3}$."},
      {"id": "B", "label": "B", "value": "$\\frac{4\\pi}{3}$", "explanation": "Arithmetic error in evaluation."},
      {"id": "C", "label": "C", "value": "$8\\pi$", "explanation": "Incorrectly integrates $2-x$ or misses the squared radius."},
      {"id": "D", "label": "D", "value": "$\\frac{16\\pi}{3}$", "explanation": "Mistakenly doubles the volume or arithmetic error."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '2c689f9b-7fc2-470a-9237-5b69245cfcba';
