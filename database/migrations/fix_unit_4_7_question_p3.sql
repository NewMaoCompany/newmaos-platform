-- Fix for U4.7-P3: Corrupted LaTeX rendering
-- Issue: The LaTeX "\frac{1 - \cos x}{x^2}" is displaying as red raw text "\frac...".
-- Fix: Ensure the string is stored with proper delimiters and potentially double-escaped backslashes for Markdown compatibility.
-- We will use $$...$$ for clear display math.

UPDATE public.questions
SET
    prompt = $txt$Evaluate the limit as $x$ approaches $0$ of the following expression using L’Hospital’s Rule:
$$ \frac{1 - \cos x}{x^2} $$
$txt$,
    latex = $txt$Evaluate the limit as $x$ approaches $0$ of the following expression using L’Hospital’s Rule:
$$ \frac{1 - \cos x}{x^2} $$
$txt$,
    updated_at = NOW()
WHERE title = 'U4.7-P3';
