-- Fix Unit 8.11 Questions Prompt & Options LaTeX Rendering
-- Corrects prompts and options for two volume questions to ensure professional LaTeX rendering and fix corrupted text.

-- 1. Revolved about y-axis question (ID: 1075384f-803f-4bc5-b4a8-cc3eaa45407b)
UPDATE public.questions
SET
    prompt = E'The region $R$ is shown between $x=y^2$ and $x=1$ for $0 \\le y \\le 1$. The region is revolved about the $y$-axis. What is the volume?',
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{4\\pi}{5}$", "explanation": "Correct: Outer radius is $R(y)=1$ and inner radius is $r(y)=y^2$. Volume is $\\pi \\int_0^1 (1 - (y^2)^2) \\,dy = \\pi [y - \\frac{y^5}{5}]_0^1 = \\frac{4\\pi}{5}$."},
      {"id": "B", "label": "B", "value": "$\\frac{\\pi}{5}$", "explanation": "Arithmetic error or forgot the outer radius integral part."},
      {"id": "C", "label": "C", "value": "$\\frac{3\\pi}{5}$", "explanation": "Arithmetic error in the definite integral evaluation."},
      {"id": "D", "label": "D", "value": "$\\frac{\\pi}{2}$", "explanation": "Incorrect formula or setup for the integral."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '1075384f-803f-4bc5-b4a8-cc3eaa45407b';

-- 2. Revolved about x-axis question (ID: 344ef49b-3cfb-49ea-bbab-99057779bd4f)
UPDATE public.questions
SET
    prompt = E'The region $R$ is shown between $y=x$ and $y=2$ for $0 \\le x \\le 2$. The region is revolved about the $x$-axis. What is the volume?',
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{16\\pi}{3}$", "explanation": "Correct: Outer radius is $R(x)=2$ and inner radius is $r(x)=x$. Volume is $\\pi \\int_0^2 (2^2 - x^2) \\,dx = \\pi [4x - \\frac{x^3}{3}]_0^2 = \\pi(8 - 8/3) = \\frac{16\\pi}{3}$."},
      {"id": "B", "label": "B", "value": "$\\frac{8\\pi}{3}$", "explanation": "Arithmetic error or misses the outer radius squared term correctly."},
      {"id": "C", "label": "C", "value": "$4\\pi$", "explanation": "Incorrect integral evaluation."},
      {"id": "D", "label": "D", "value": "$\\frac{20\\pi}{3}$", "explanation": "Arithmetic error, possibly adding areas instead of subtracting."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '344ef49b-3cfb-49ea-bbab-99057779bd4f';
