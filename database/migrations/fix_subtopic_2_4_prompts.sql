-- Fix 5 questions in Subtopic 2.4 (Mashed Text & Broken Graph Placeholders)
-- Use standard text string with single backslashes for LaTeX.

-- 1. Question 1d9802c3-0bb0-4ee2-b28b-e4c3f9d62d74
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.4-P2_graph.png)

The graph of $y=f(x)$ is shown. Is $f$ differentiable at $x=1$?$$
WHERE id = '1d9802c3-0bb0-4ee2-b28b-e4c3f9d62d74';

-- 2. Question 408aed1b-0bf7-4b20-9168-ce3048175967
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.4-P4_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=2$?$$
WHERE id = '408aed1b-0bf7-4b20-9168-ce3048175967';

-- 3. Question 878d6f75-6746-419a-9dfd-5a10fae3966f (No Image, Text Only)
-- Re-saving to ensuring proper spacing.
UPDATE public.questions
SET prompt = 
$$Which statement must be true if a function $f$ is differentiable at $x=a$?$$
WHERE id = '878d6f75-6746-419a-9dfd-5a10fae3966f';

-- 4. Question 8819d62b-11ae-4131-9a73-f9060b516421
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.4-P1_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=0$?$$
WHERE id = '8819d62b-11ae-4131-9a73-f9060b516421';

-- 5. Question d90dc96e-148d-4ac8-a406-2903dbd38e8a
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.4-P3_graph.png)

The graph of $y=f(x)$ is shown. Which statement is true about $f$ at $x=1$?$$
WHERE id = 'd90dc96e-148d-4ac8-a406-2903dbd38e8a';
