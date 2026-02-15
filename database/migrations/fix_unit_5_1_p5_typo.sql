-- Fix for Unit 5.1 Question P5 Typo (Stray $ in "Choose$")

-- U5.1-P5
-- Fix prompt and latex fields to remove the typo "Choose$" -> "Choose"
UPDATE public.questions
SET
    prompt = $txt$Let $g(x)=|x|$ on the interval $[-1,2]$. Can the Mean Value Theorem be applied on $[-1,2]$?

Choose the best answer.$txt$,
    latex = $txt$Let $g(x)=|x|$ on the interval $[-1,2]$. Can the Mean Value Theorem be applied on $[-1,2]$?

Choose the best answer.$txt$,
    updated_at = NOW()
WHERE title = 'U5.1-P5';
