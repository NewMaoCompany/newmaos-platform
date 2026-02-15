-- Fix Unit 7 BC Euler Table Formatting Issues
-- Replaces raw filenames with descriptive labels in prompts.

-- 1. Fix Euler Table A question (ID: 701bf98b-cd27-4087-a79b-91671756f49e)
UPDATE public.questions
SET
    prompt = $txt$Use the Euler table in U7.5 Euler table A (step size $h=1$) for $\frac{dy}{dt}=t-y$. What value completes the table entry for $y_2$ (the approximation at $t=2$)?$txt$,
    latex = $txt$Use the Euler table in U7.5 Euler table A (step size $h=1$) for $\frac{dy}{dt}=t-y$. What value completes the table entry for $y_2$ (the approximation at $t=2$)?$txt$,
    updated_at = NOW()
WHERE id = '701bf98b-cd27-4087-a79b-91671756f49e';

-- 2. Fix Euler Table B question (ID: 45d9bc53-5afc-4f55-bc35-ebbf25dba13e)
UPDATE public.questions
SET
    prompt = $txt$Use the Euler steps shown in U7.5 Euler table B for $\frac{dy}{dt}=-0.4y$ with $y(0)=50$ and $h=1$. What is the Euler approximation for $y(2)$?$txt$,
    latex = $txt$Use the Euler steps shown in U7.5 Euler table B for $\frac{dy}{dt}=-0.4y$ with $y(0)=50$ and $h=1$. What is the Euler approximation for $y(2)$?$txt$,
    updated_at = NOW()
WHERE id = '45d9bc53-5afc-4f55-bc35-ebbf25dba13e';
