-- Fix for Unit 5 Test Question 3 Formatting

-- U5-UT-Q03
-- Fix "x - values" (LaTeX with spacing issue) -> "x-values" (Plain text)
-- Current DB likely has: "... possible $x - values$ that can ..."
-- Intended: "... possible x-values that can ..."
UPDATE public.questions
SET
    prompt = $txt$Which list includes all possible x-values that can be critical points of $f$ on an interval?$txt$,
    latex = $txt$Which list includes all possible x-values that can be critical points of $f$ on an interval?$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q03';
