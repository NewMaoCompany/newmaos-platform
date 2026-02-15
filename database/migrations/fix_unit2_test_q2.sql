-- Fix for Unit 2 Unit Test Question 2 (b1fdc896-1b99-4753-b986-7ee1fcdb27ac)
-- Issue: Garbled text "(()" instead of "(in meters)" and "(in seconds)".
-- Fix: Force update prompt with clean text.

UPDATE public.questions
SET prompt = $$The function $f$ represents position (in meters) as a function of time $t$ (in seconds). If $f(2)=5$ and $f(6)=17$, what is the average rate of change of $f$ from $t=2$ to $t=6$?$$
WHERE id = 'b1fdc896-1b99-4753-b986-7ee1fcdb27ac';
