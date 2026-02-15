-- Fix for Unit 5.8 Notation Issues (Plain f -> $f$)

-- U5.8-P1
-- "Refer to the provided graph of f." -> "$f$"
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f$.

On which interval is $f$ increasing?$txt$,
    latex = $txt$Refer to the provided graph of $f$.

On which interval is $f$ increasing?$txt$,
    updated_at = NOW()
WHERE title = 'U5.8-P1';

-- U5.8-P2
-- "Refer to the provided graph of f'." -> "$f'$"
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f'$.

How many local extrema does $f$ have on $(-3,3)$?$txt$,
    latex = $txt$Refer to the provided graph of $f'$.

How many local extrema does $f$ have on $(-3,3)$?$txt$,
    updated_at = NOW()
WHERE title = 'U5.8-P2';

-- U5.8-P3
-- "Suppose f is differentiable..."
UPDATE public.questions
SET
    prompt = $txt$Suppose $f$ is differentiable and $f'$ is increasing on $(a,b)$. Which statement must be true on $(a,b)$?$txt$,
    latex = $txt$Suppose $f$ is differentiable and $f'$ is increasing on $(a,b)$. Which statement must be true on $(a,b)$?$txt$,
    updated_at = NOW()
WHERE title = 'U5.8-P3';

-- U5.8-P4
-- "Refer to the provided graph of f." -> "$f$" (This matches the screenshot)
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f$.

At $x=1$, which combination of signs is most consistent with the graph?$txt$,
    latex = $txt$Refer to the provided graph of $f$.

At $x=1$, which combination of signs is most consistent with the graph?$txt$,
    updated_at = NOW()
WHERE title = 'U5.8-P4';
