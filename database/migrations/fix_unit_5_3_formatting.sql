-- Fix for Unit 5.3 Formatting Issues (Corrupted Text and LaTeX)

-- U5.3-P1
-- Fix "On \$which\$ interval(s)"
UPDATE public.questions
SET
    prompt = $txt$Let $f$ be differentiable on $(-3,3)$ with $f'(x)=(x-1)(x+2)$. On which interval(s) is $f$ increasing?$txt$,
    latex = $txt$Let $f$ be differentiable on $(-3,3)$ with $f'(x)=(x-1)(x+2)$. On which interval(s) is $f$ increasing?$txt$,
    updated_at = NOW()
WHERE title = 'U5.3-P1';

-- U5.3-P2
-- Fix "and $suppose", "On\$which\$ interval", and LaTeX display
UPDATE public.questions
SET
    prompt = $txt$Let $f$ be differentiable on $(-5,5)$ except possibly at $x=-2$ and $x=2$, and suppose
$$ f'(x)=\frac{x-2}{x^2-4} $$
On which interval(s) is $f$ increasing?$txt$,
    latex = $txt$Let $f$ be differentiable on $(-5,5)$ except possibly at $x=-2$ and $x=2$, and suppose
$$ f'(x)=\frac{x-2}{x^2-4} $$
On which interval(s) is $f$ increasing?$txt$,
    updated_at = NOW()
WHERE title = 'U5.3-P2';

-- U5.3-P3
-- Fix "On$ which interval"
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided sign chart for $f'(x)$.

On which interval is $f$ decreasing?$txt$,
    latex = $txt$Refer to the provided sign chart for $f'(x)$.

On which interval is $f$ decreasing?$txt$,
    updated_at = NOW()
WHERE title = 'U5.3-P3';

-- U5.3-P4
-- Fix "On $which$ interval(s)" and general cleanup
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f'(x)$ on the interval $[-4,4]$.

On which interval(s) is $f$ increasing?$txt$,
    latex = $txt$Refer to the provided graph of $f'(x)$ on the interval $[-4,4]$.

On which interval(s) is $f$ increasing?$txt$,
    updated_at = NOW()
WHERE title = 'U5.3-P4';
