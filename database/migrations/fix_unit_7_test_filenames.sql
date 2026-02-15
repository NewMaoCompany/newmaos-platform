-- Fix Unit 7 Test Formatting Issues
-- Replaces raw filenames with descriptive labels in prompts.

-- 1. Fix Euler-method table question
UPDATE public.questions
SET
    prompt = $txt$Use the Euler-method table in U7 Unit Test Euler table for $\frac{dy}{dx}=x+y$ with $y(0)=1$ and step size $h=0.5$. What is the Euler approximation for $y(1)$?$txt$,
    latex = $txt$Use the Euler-method table in U7 Unit Test Euler table for $\frac{dy}{dx}=x+y$ with $y(0)=1$ and step size $h=0.5$. What is the Euler approximation for $y(1)$?$txt$,
    updated_at = NOW()
WHERE id = '538306cb-d42a-4efc-8876-a384d638b5c8';

-- 2. Fix slope at point question (u7_7_11_slopefield_candidates.png)
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.3 slope field candidates for $\frac{dy}{dx}=x-y$. What is the slope at the point $(1,0)$?$txt$,
    latex = $txt$Use the slope field in U7.3 slope field candidates for $\frac{dy}{dx}=x-y$. What is the slope at the point $(1,0)$?$txt$,
    updated_at = NOW()
WHERE id = '5d1ae77d-f99c-4d57-8a34-4ec2bf1372f2';

-- 3. Fix decay table question (u7_7_14_decay_table.png)
UPDATE public.questions
SET
    prompt = $txt$Use the data in U7.6 decay table. Assume $A(t)$ follows $\frac{dA}{dt}=kA$. Which value of $k$ is most consistent with the table?$txt$,
    latex = $txt$Use the data in U7.6 decay table. Assume $A(t)$ follows $\frac{dA}{dt}=kA$. Which value of $k$ is most consistent with the table?$txt$,
    updated_at = NOW()
WHERE id = 'c22d56eb-21de-4fd4-8aea-3ac092fdd75d';

-- 4. Fix curve match question (u7_7_13_slopefield_xy_candidates.png)
UPDATE public.questions
SET
    prompt = $txt$In U7.3 slope field xy candidates for $\frac{dy}{dx}=xy$, which labeled curve matches $y(0)=1$?$txt$,
    latex = $txt$In U7.3 slope field xy candidates for $\frac{dy}{dx}=xy$, which labeled curve matches $y(0)=1$?$txt$,
    updated_at = NOW()
WHERE id = 'ef57750a-04fe-4568-acfb-b9006785b543';

-- 5. Fix labeled curve question (u7_7_11_slopefield_candidates.png)
UPDATE public.questions
SET
    prompt = $txt$In U7.3 slope field candidates for $\frac{dy}{dx}=x-y$, which labeled curve matches the initial condition $y(0)=1$?$txt$,
    latex = $txt$In U7.3 slope field candidates for $\frac{dy}{dx}=x-y$, which labeled curve matches the initial condition $y(0)=1$?$txt$,
    updated_at = NOW()
WHERE id = 'f04b3e25-07c5-4b20-889f-3ebb72a715ae';

-- 6. Fix initial condition question (u7_7_14_decay_table.png)
UPDATE public.questions
SET
    prompt = $txt$Use the table in U7.6 decay table. Which initial condition is directly supported by the data?$txt$,
    latex = $txt$Use the table in U7.6 decay table. Which initial condition is directly supported by the data?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%Use the table in file%u7_7_14_decay_table.png%';
