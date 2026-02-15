-- Fix for U4.2-P5: Corrupted prompt text and missing table
-- Issue: The original prompt had garbled units (likely `(()`) and was missing the table data required to solve it.
-- The explanation also contained calculation errors.
-- This script updates the prompt to include a Markdown table with correct values that lead to the answer 90 ft/min.

UPDATE public.questions
SET
    prompt = $txt$The table below gives position $s(t)$ (in feet) of a runner at times $t$ (in minutes). Which is the best estimate of the runner’s velocity at $t=3.0$ minutes?

| $t$ (min) | $s(t)$ (ft) |
| :---: | :---: |
| 2.9 | 150.0 |
| 3.0 | 159.0 |
| 3.1 | 168.0 |
$txt$,
    latex = $txt$The table below gives position $s(t)$ (in feet) of a runner at times $t$ (in minutes). Which is the best estimate of the runner’s velocity at $t=3.0$ minutes?

| $t$ (min) | $s(t)$ (ft) |
| :---: | :---: |
| 2.9 | 150.0 |
| 3.0 | 159.0 |
| 3.1 | 168.0 |
$txt$,
    explanation = $txt$Use a symmetric difference quotient around $t=3.0$ to estimate the derivative (velocity):
$$v(3.0) \approx \frac{s(3.1)-s(2.9)}{3.1-2.9} = \frac{168.0-150.0}{0.2} = \frac{18.0}{0.2} = 90 \text{ ft/min}$$
The best estimate is 90 ft/min.$txt$,
    updated_at = NOW()
WHERE title = 'U4.2-P5';
