-- Fix for Unit 4 Unit Test Questions (Corrupted Text and LaTeX)
-- Issue 1: Prompt text corruption (e.g. "(in miles)" -> "(()")
-- Issue 2: LaTeX rendering issues (red text "\frac...")

-- U4-UT-Q2 (User Q12)
-- Fix prompt text and Option B LaTeX
UPDATE public.questions
SET
    prompt = $txt$A car’s position is given by $s(t)$ (in miles). Which expression represents the average velocity from $t=2$ to $t=6$?$txt$,
    latex = $txt$A car’s position is given by $s(t)$ (in miles). Which expression represents the average velocity from $t=2$ to $t=6$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$s(6) - s(2)$", "type": "text", "explanation": "Missing division by the time length."},
      {"id": "B", "label": "B", "value": "$\\frac{s(6) - s(2)}{6 - 2}$", "type": "text", "explanation": "Correct: slope of the secant line from $2$ to $6$."},
      {"id": "C", "label": "C", "value": "$s'(6) - s'(2)$", "type": "text", "explanation": "Difference of instantaneous velocities is not an average velocity."},
      {"id": "D", "label": "D", "value": "$s'(4)$", "type": "text", "explanation": "Instantaneous velocity at one time is not the average over an interval."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U4-UT-Q2';

-- U4-UT-Q14 (User Q15)
-- Fix prompt LaTeX to block math for reliability
UPDATE public.questions
SET
    prompt = $txt$Evaluate the limit as $x$ approaches $0$ of the following expression using L’Hospital’s Rule:
$$ \frac{e^x - 1}{x} $$
$txt$,
    latex = $txt$Evaluate the limit as $x$ approaches $0$ of the following expression using L’Hospital’s Rule:
$$ \frac{e^x - 1}{x} $$
$txt$,
    updated_at = NOW()
WHERE title = 'U4-UT-Q14';

-- U4-UT-Q15 (User Q11)
-- Fix prompt LaTeX to block math for reliability
UPDATE public.questions
SET
    prompt = $txt$Evaluate the limit as $x$ approaches $0$ of the following expression using L’Hospital’s Rule:
$$ \frac{\sin x - x}{x^3} $$
$txt$,
    latex = $txt$Evaluate the limit as $x$ approaches $0$ of the following expression using L’Hospital’s Rule:
$$ \frac{\sin x - x}{x^3} $$
$txt$,
    updated_at = NOW()
WHERE title = 'U4-UT-Q15';

-- U4-UT-Q17 (User Q17)
-- Fix prompt LaTeX to block math for reliability
UPDATE public.questions
SET
    prompt = $txt$The graph shows two functions near $x=0$: $y = e^x - 1 - x$ and $y = x^2$. What does their behavior suggest about the limit of the following expression as $x$ approaches $0$?
$$ \frac{e^x - 1 - x}{x^2} $$
$txt$,
    latex = $txt$The graph shows two functions near $x=0$: $y = e^x - 1 - x$ and $y = x^2$. What does their behavior suggest about the limit of the following expression as $x$ approaches $0$?
$$ \frac{e^x - 1 - x}{x^2} $$
$txt$,
    updated_at = NOW()
WHERE title = 'U4-UT-Q17';
