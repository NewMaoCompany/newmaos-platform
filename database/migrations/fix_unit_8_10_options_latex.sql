-- Fix Unit 8.10 Options LaTeX Rendering (Full Batch)
-- Corrects options for multiple volume questions to ensure professional LaTeX rendering.

-- 1. Volume value about x=1 (ID: 5ce67712-d4ec-4720-aaae-f070ae630b07)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{16\\pi}{15}$", "explanation": "Correct: $V = 2\\pi \\int_0^1 (1-y^2)^2 \\,dy = 2\\pi [y - \\frac{2y^3}{3} + \\frac{y^5}{5}]_0^1 = 2\\pi(1 - 2/3 + 1/5) = \\frac{16\\pi}{15}$."},
      {"id": "B", "label": "B", "value": "$\\frac{8\\pi}{15}$", "explanation": " Arithmetic error, possibly missing the factor of $2$ from doubling the half-integral."},
      {"id": "C", "label": "C", "value": "$\\frac{4\\pi}{3}$", "explanation": "Arithmetic error in the integral evaluation."},
      {"id": "D", "label": "D", "value": "$\\frac{2\\pi}{3}$", "explanation": "Arithmetic error in the integral evaluation."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '5ce67712-d4ec-4720-aaae-f070ae630b07';

-- 2. Volume value about y=2 (ID: cc958eaa-b680-4f65-8610-90cbbc9a7976)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{128\\sqrt{2}\\pi}{15}$", "explanation": "Correct: $V = \\pi \\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2)^2 \\,dx = 2\\pi [4x - \\frac{4x^3}{3} + \\frac{x^5}{5}]_0^{\\sqrt{2}} = \\frac{128\\sqrt{2}\\pi}{15}$."},
      {"id": "B", "label": "B", "value": "$\\frac{64\\sqrt{2}\\pi}{15}$", "explanation": "Missing the factor of $2$ from doubling the half-integral."},
      {"id": "C", "label": "C", "value": "$\\frac{32\\sqrt{2}\\pi}{15}$", "explanation": "Arithmetic error in evaluating the integral."},
      {"id": "D", "label": "D", "value": "$\\frac{128\\pi}{15}$", "explanation": "Missing the $\\sqrt{2}$ factor from evaluating at the bounds."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'cc958eaa-b680-4f65-8610-90cbbc9a7976';

-- 3. Radius representation (ID: c6474d52-305b-4c38-be47-c56f0451e44c)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$r(x) = c - f(x)$", "explanation": "Correct: Distance = Upper boundary (axis $c$) - Lower boundary ($f(x)$)."},
      {"id": "B", "label": "B", "value": "$r(x) = f(x)$", "explanation": "This is the distance to the $x$-axis, not to $y=c$."},
      {"id": "C", "label": "C", "value": "$r(x) = f(x) - c$", "explanation": "This would give a negative radius since $c > f(x)$."},
      {"id": "D", "label": "D", "value": "$r(x) = c + f(x)$", "explanation": "This sums the distances instead of subtracting them."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'c6474d52-305b-4c38-be47-c56f0451e44c';

-- 4. Integral selection about y=2 (ID: e509e60b-3f80-48a3-9147-b882295def64)
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\pi \\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2)^2 \\,dx$", "explanation": "Correct: Disk method with $r(x) = 2 - x^2$."},
      {"id": "B", "label": "B", "value": "$\\pi \\int_{-\\sqrt{2}}^{\\sqrt{2}} (x^2)^2 \\,dx$", "explanation": "This would revolve the area under $y=x^2$ about the $x$-axis."},
      {"id": "C", "label": "C", "value": "$\\pi \\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2) \\,dx$", "explanation": "Forgets to square the radius."},
      {"id": "D", "label": "D", "value": "$\\int_{-\\sqrt{2}}^{\\sqrt{2}} (2-x^2)^2 \\,dx$", "explanation": "Forgets the constant $\\pi$."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'e509e60b-3f80-48a3-9147-b882295def64';
