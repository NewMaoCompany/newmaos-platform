-- Fix for Unit 5.1 Prompt Typo (Stray $ in "Choose$")

-- U5.1-P1
-- Fix prompt and latex fields to remove the typo "Choose$" -> "Choose"
UPDATE public.questions
SET
    prompt = $txt$Let $f(x)=\sqrt{x-1}$ on the interval $[1,5]$. Does the Mean Value Theorem apply on $[1,5]$?

Choose the best justification.$txt$,
    latex = $txt$Let $f(x)=\sqrt{x-1}$ on the interval $[1,5]$. Does the Mean Value Theorem apply on $[1,5]$?

Choose the best justification.$txt$,
    updated_at = NOW()
WHERE title = 'U5.1-P1';
