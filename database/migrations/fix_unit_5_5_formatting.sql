-- Fix for Unit 5.5 Formatting Issues (Corrupted LaTeX/Text)

-- U5.5-P4
-- Fix "At $which x-value does f attain its absolute maximum on [0,6]$?"
-- The $ signs caused the text to be rendered as math mode (no spaces).
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f$ on $[0,6]$.

At which x-value does $f$ attain its absolute maximum on $[0,6]$?$txt$,
    latex = $txt$Refer to the provided graph of $f$ on $[0,6]$.

At which x-value does $f$ attain its absolute maximum on $[0,6]$?$txt$,
    updated_at = NOW()
WHERE title = 'U5.5-P4';
