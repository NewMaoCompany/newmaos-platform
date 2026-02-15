-- Fix Unit 10.9 Question 3 (P3)
-- Removes filename from prompt.

DO $$
BEGIN

    -- U10.9-P3
    -- Fix: Remove filename (U10.9_Practice_Table1_AbsVsCond.png)
    UPDATE public.questions
    SET 
        prompt = $prompt$Refer to Table 10.9-A for $a_n = \frac{(-1)^{n+1}}{\sqrt{n}}$. Which statement is correct?$prompt$
    WHERE title = 'U10.9-P3';

END $$;
