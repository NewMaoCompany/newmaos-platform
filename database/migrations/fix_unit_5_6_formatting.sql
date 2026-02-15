-- Fix for Unit 5.6 Formatting Issues (Corrupted Text)

-- U5.6-P3
-- Fix "On$ which" typo seen in user screenshot
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f''(x)$.

On which interval is $f$ concave down?$txt$,
    latex = $txt$Refer to the provided graph of $f''(x)$.

On which interval is $f$ concave down?$txt$,
    updated_at = NOW()
WHERE title = 'U5.6-P3';

-- U5.6-P5
-- Precautionary fix for similar structure
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided concavity summary table.

On which interval is $f$ concave down?$txt$,
    latex = $txt$Refer to the provided concavity summary table.

On which interval is $f$ concave down?$txt$,
    updated_at = NOW()
WHERE title = 'U5.6-P5';
