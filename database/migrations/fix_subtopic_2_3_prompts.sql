-- Fix 5 questions in Subtopic 2.3 (Mashed Text & Broken Graph Placeholders)
-- Use standard text string with single backslashes for LaTeX.

-- 1. Question 22333f09-d3e6-4f04-b4ba-a6781c1cb98c
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.3-P4_graph.png)

The graph of $y=h(x)$ is shown, along with the tangent line at $x=0$. What is the best estimate of $h'(0)$?$$
WHERE id = '22333f09-d3e6-4f04-b4ba-a6781c1cb98c';

-- 2. Question 4cf08aad-480a-4ee7-8ad3-aa81da9665a5
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.3-P1_graph.png)

The graph of $y=f(x)$ is shown, along with the tangent line at $x=2$. What is the best estimate of $f'(2)$?$$
WHERE id = '4cf08aad-480a-4ee7-8ad3-aa81da9665a5';

-- 3. Question 512e4ef2-cfb6-48ac-91da-fae6d237ea84 (Table)
UPDATE public.questions
SET prompt = 
$$![Table](/assets/U2_1769404469_2.3-P2_table.png)

The table gives values of $f(x)$. Use the table to estimate $f'(3)$.$$
WHERE id = '512e4ef2-cfb6-48ac-91da-fae6d237ea84';

-- 4. Question 72dd142e-bef9-4f05-b426-56c2c61e8c27
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.3-P5_graph.png)

The graph of $y=p(x)$ is shown, along with the tangent line at $x=4$. What is the best estimate of $p'(4)$?$$
WHERE id = '72dd142e-bef9-4f05-b426-56c2c61e8c27';

-- 5. Question ca6b2eda-8919-4bff-9da7-84bdb3322cb2
UPDATE public.questions
SET prompt = 
$$![Graph](/assets/U2_1769404469_2.3-P3_graph.png)

The graph of $y=g(x)$ is shown, along with the tangent line at $x=1$. What is $g'(1)$?$$
WHERE id = 'ca6b2eda-8919-4bff-9da7-84bdb3322cb2';
