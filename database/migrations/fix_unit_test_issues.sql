-- Fix specific Unit Test / Practice Session issues reported by user.

-- 1. Fix Question 9823692e-26d8-4e6d-9d33-9eeed60e4ff3
-- Issue: Garbled text "(()" instead of "(in meters)".
-- Fix: Force clean prompt text.
UPDATE public.questions
SET prompt = $$A particle moves along a line so that its position is given by $s(t) = t^2 + 3t$ (in meters). What is the average velocity on the interval $[2, 4]$?$$
WHERE id = '9823692e-26d8-4e6d-9d33-9eeed60e4ff3';

-- 2. Fix Question 6437c89c-ffff-4f06-84e7-db84847b05dd
-- Issue: Red garbled text "Evaluate \lim...".
-- Mistake in previous attempt: Missed the closing `$` delimiter!
-- Fix: Add closing `$` to properly terminate the math block.
UPDATE public.questions
SET prompt = $$Evaluate $\lim_{x \to -1} \frac{x^2+3x+2}{x+1}$.$$
WHERE id = '6437c89c-ffff-4f06-84e7-db84847b05dd';
