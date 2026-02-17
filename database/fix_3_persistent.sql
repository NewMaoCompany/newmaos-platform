-- Fix 3 Persistent Questions (V3)
-- Using explicit double-blackslashes for piecewise functions

-- 1. Q703 (EDE9CE0C)
UPDATE questions
SET
  prompt = 'Let $f(x)=\begin{cases} x^2-1, & x \ne 1 \\ 3, & x=1 \end{cases}$. Which statement is true about continuity at $x=1$?',
  explanation = '$\lim_{x\to 1} (x^2-1) = 0$. But $f(1)=3$. Since limit (0) $\ne$ value (3), $f$ is not continuous at $x=1$.',
  options = '[
    {"id": "A", "text": "Continuous because limits exist", "explanation": "Limit exists (0) but does not equal function value (3)."},
    {"id": "B", "text": "Not continuous because limit does not exist", "explanation": "Limit exists and is 0."},
    {"id": "C", "text": "Not continuous because $f(1)$ is undefined", "explanation": "$f(1)=3$ is defined."},
    {"id": "D", "text": "Not continuous because $\\lim_{x\\to 1}f(x) \\ne f(1)$", "explanation": "Correct: $0 \\ne 3$."}
  ]'::jsonb
WHERE id = 'EDE9CE0C-1D22-49D6-A995-208F49EF89C3';

-- 2. Q717 (F1BBD9AF)
UPDATE questions
SET
  prompt = 'Choose $a$ so that $f(x)=\begin{cases} ax+1, & x<1 \\ x^2, & x\ge 1 \end{cases}$ is continuous at $x=1$. What is $a$?',
  explanation = 'Left limit: $\lim_{x\to 1^-}(ax+1) = a+1$. Right limit/value: $\lim_{x\to 1^+}(x^2)=1$. continuity $\implies a+1=1 \implies a=0$.',
  options = '[
    {"id": "A", "text": "$a=1$", "explanation": "Would give left limit 2, right limit 1."},
    {"id": "B", "text": "$a=0$", "explanation": "Correct: $0(1)+1 = 1$, matches $1^2=1$."},
    {"id": "C", "text": "$a=-1$", "explanation": "Left limit 0, right limit 1."},
    {"id": "D", "text": "No such $a$ exists", "explanation": "We can solve $a+1=1$."}
  ]'::jsonb
WHERE id = 'F1BBD9AF-C033-45D5-82BC-B45FFF0E4248';

-- 3. Q730 (F60E26B6) - NEW
UPDATE questions
SET
  prompt = 'Choose $k$ so that $h(x)=\begin{cases} kx+2, & x\le 2 \\ x^2-2, & x>2 \end{cases}$ is continuous for all real $x$. What is $k$?',
  explanation = 'The only possible discontinuity is at the split point $x=2$. Continuity requires $h(2) = \lim_{x\to 2^+} (x^2-2)$. Since $h(2) = 2k+2$ and the right-hand value is $2^2-2=2$, set $2k+2=2$, giving $k=0$.',
  options = '[
    {"id": "A", "text": "$k=0$", "explanation": "Correct: continuity at $x=2$ requires $2k+2 = 2^2-2=2$, so $k=0$."},
    {"id": "B", "text": "$k=1$", "explanation": "Then $h(2)=4$ while the right-hand limit is 2."},
    {"id": "C", "text": "$k=-1$", "explanation": "Then $h(2)=0$ while the right-hand limit is 2."},
    {"id": "D", "text": "$k=2$", "explanation": "Then $h(2)=6$ while the right-hand limit is 2."}
  ]'::jsonb
WHERE id = 'F60E26B6-8238-4D1C-9540-5174EBD4F98F';
