-- Fix for Unit 5.12 Question 5 Text Corruption (Empty Parentheses)

-- U5.12-P5 (labeled Question 4 or 5 in UI depending on sort order)
-- Fix "greatest (()) slope" -> "greatest (most positive) slope"
UPDATE public.questions
SET
    prompt = $txt$A table is provided showing approximate $\frac{dy}{dx}$ values for the implicit relation $x^2 + x y + y^2 = 7$ at several points. Which point has the greatest (most positive) slope among those listed?$txt$,
    latex = $txt$A table is provided showing approximate $\frac{dy}{dx}$ values for the implicit relation $x^2 + x y + y^2 = 7$ at several points. Which point has the greatest (most positive) slope among those listed?$txt$,
    updated_at = NOW()
WHERE title = 'U5.12-P5';
