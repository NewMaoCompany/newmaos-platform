-- Fix Unit 7.6 and Unit 7.5 Formatting Issues (Precise Fix)
-- Uses IDs to ensure updates are applied correctly.

-- 1. Fix Unit 7.6 Q5 - Text corruption (()) and LaTeX
UPDATE public.questions
SET
    prompt = $txt$A cooling liquid has temperature $T(t)$ (in $^\circ\!\!F$) at time $t$ (in minutes). The statement "at $t=10$ minutes, the temperature is $80^\circ\!\!F$" corresponds to which condition?$txt$,
    latex = $txt$A cooling liquid has temperature $T(t)$ (in $^\circ\!\!F$) at time $t$ (in minutes). The statement "at $t=10$ minutes, the temperature is $80^\circ\!\!F$" corresponds to which condition?$txt$,
    updated_at = NOW()
WHERE id = '44be7b91-8d7b-41b6-bd2f-0cba68e75d42';

-- 2. Fix Unit 7.5 Q1 - Text corruption (())
UPDATE public.questions
SET
    prompt = $txt$Which is an equivalent separated form of $\frac{dy}{dx}=\frac{x^2}{y}$ (assuming $y\neq 0$)?$txt$,
    latex = $txt$Which is an equivalent separated form of $\frac{dy}{dx}=\frac{x^2}{y}$ (assuming $y\neq 0$)?$txt$,
    updated_at = NOW()
WHERE id = '0012d0cc-e291-467a-98b5-6d88fa1a2871';
