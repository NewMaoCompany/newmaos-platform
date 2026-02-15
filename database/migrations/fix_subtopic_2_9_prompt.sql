-- Fix Prompt for Question 5f28158d-416c-4237-b617-427fdd4fac14 (Subtopic 2.9)
-- Issue: Prompt displays red garbled LaTeX "If f(x)=\frac{3x^2 - 1}{x}..."
-- Fix: Force update with proper "$" delimiters and correctly escaped LaTeX.

UPDATE public.questions
SET prompt = 
$$If $f(x)=\frac{3x^2 - 1}{x}$, what is $f'(x)$?$$
WHERE id = '5f28158d-416c-4237-b617-427fdd4fac14';
