-- Fix for Unit 5.4 Formatting Issues (Corrupted Text and LaTeX)

-- U5.4-P4
-- Fix "At \$which\$ x-value\$" typo
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f'(x)$.

At which x-value does $f$ have a local maximum?$txt$,
    latex = $txt$Refer to the provided graph of $f'(x)$.

At which x-value does $f$ have a local maximum?$txt$,
    updated_at = NOW()
WHERE title = 'U5.4-P4';
