-- Fix 10 Corrupted Questions (Batch V2)
-- Includes Previous 5 + 5 New found in this session

-- 1. Q398 (8819D62B)
UPDATE questions
SET
  prompt = 'Which statement is always true for a function $f$ at $x=a$? I. If $f$ is differentiable at $x=a$, then $f$ is continuous at $x=a$. II. If $f$ is continuous at $x=a$, then $f$ is differentiable at $x=a$.',
  explanation = 'Differentiability at $x=a$ forces $\lim_{x\to a}f(x)=f(a)$, so $f$ must be continuous at $x=a$. But continuity can occur without differentiability (e.g., corners).',
  options = '[
    {"id": "A", "text": "I only", "explanation": "Correct. Differentiability implies continuity."},
    {"id": "B", "text": "II only", "explanation": "Continuity does not imply differentiability, so II is not always true."},
    {"id": "C", "text": "Both I and II", "explanation": "II fails for functions like $|x|$ at $x=0$."},
    {"id": "D", "text": "Neither I nor II", "explanation": "I is true, so this cannot be correct."}
  ]'::jsonb
WHERE id = '8819D62B-11AE-4131-9A73-F9060B516421';

-- 2. Q482 (A42F296D)
UPDATE questions
SET
  prompt = 'Find the value of $k$ that makes $f$ continuous at $x=3$ if $f(x) = \begin{cases} \frac{x^2-9}{x-3}, & x \ne 3 \\ k, & x=3 \end{cases}$',
  explanation = 'For $x \ne 3$, factor $x^2-9 = (x-3)(x+3)$, so $f(x) = x+3$. Thus $\lim_{x\to 3} f(x) = 6$. Continuity at $x=3$ requires $f(3)=k$ to equal this limit, so $k=6$.',
  options = '[
    {"id": "A", "text": "$k=0$", "explanation": "This equals $\\lim_{x\\to 3}(x^2-9)$ if you forget to simplify the fraction first."},
    {"id": "B", "text": "$k=9$", "explanation": "This confuses the limit with $x^2$ evaluated at 3."},
    {"id": "C", "text": "$k$ cannot be chosen to make $f$ continuous at $x=3$", "explanation": "The discontinuity is removable; choosing $k$ equal to the limit makes $f$ continuous."},
    {"id": "D", "text": "$k=6$", "explanation": "Correct: for $x \\ne 3$, $\\frac{x^2-9}{x-3} = x+3$, so $\\lim_{x\\to 3} f(x) = 6$; set $k=6$."}
  ]'::jsonb
WHERE id = 'A42F296D-1BA8-4E0B-A145-62988C59870C';

-- 3. Q540 (B508B1F0)
UPDATE questions
SET
  prompt = 'Consider the logistic differential equation $\frac{dP}{dt} = P(6-P)$. Which statement about equilibrium solutions is correct?',
  explanation = 'Equilibrium solutions satisfy $\frac{dP}{dt} = 0$. $P(6-P)=0 \implies P=0$ or $P=6$.',
  options = '[
    {"id": "A", "text": "The only equilibrium solution is $P=0$.", "explanation": "Set dP/dt = 0: both factors can be zero, giving P=0 and P=6."},
    {"id": "B", "text": "The only equilibrium solution is $P=6$.", "explanation": "There are two equilibria: P=0 and P=6."},
    {"id": "C", "text": "The equilibrium solutions are $P=0$ and $P=6$.", "explanation": "Correct: equilibria occur when $P(6-P)=0$, i.e., $P=0$ or $P=6$."},
    {"id": "D", "text": "There are no equilibrium solutions because $dP/dt$ depends on $P$.", "explanation": "Equilibria are constant solutions where $dP/dt = 0$ for that constant value of $P$."}
  ]'::jsonb
WHERE id = 'B508B1F0-B367-48A5-BAE0-60E817F1BD36';

-- 4. Q575 (C47718C9)
UPDATE questions
SET
  prompt = 'Refer to the position graph (velocity is slope). What is the cart''s velocity at $t = 6$ seconds?',
  explanation = 'Velocity is the slope of the position graph. At $t=6$, the cart lies on the segment from $(5, 6)$ to $(7, 2)$, so $m = \frac{2-6}{7-5} = -2$ m/s.',
  options = '[
    {"id": "A", "text": "$-2$ m/s", "explanation": "Correct: slope on the segment from $(5, 6)$ to $(7, 2)$ is $\\frac{2-6}{7-5} = -2$."},
    {"id": "B", "text": "$2$ m/s", "explanation": "Correct magnitude but wrong sign."},
    {"id": "C", "text": "$-4$ m/s", "explanation": "Uses rise $-4$ but forgets to divide by run 2."},
    {"id": "D", "text": "$0$ m/s", "explanation": "Confuses the flat segment (earlier) with the segment containing $t=6$."}
  ]'::jsonb
WHERE id = 'C47718C9-0FCE-43D6-B659-10083653AE99';

-- 5. Q596 (CA6B2EDA)
UPDATE questions
SET
  prompt = 'Let $g(x)=\sqrt{x}$. Which expression best estimates $g''(9)$ using $h=0.01$?',
  explanation = 'A standard estimate uses $g''(a)\approx \frac{g(a+h)-g(a)}{h}$. With $a=9$ and $h=0.01$, the correct setup is $\frac{\sqrt{9.01}-\sqrt{9}}{0.01}$.',
  options = '[
    {"id": "A", "text": "$\\frac{\\sqrt{9.01}-\\sqrt{9}}{0.01}$", "explanation": "Correct forward-difference quotient with h=0.01."},
    {"id": "B", "text": "$\\frac{\\sqrt{9}-\\sqrt{8.99}}{0.01}$", "explanation": "This is a backward difference, not the stated forward form."},
    {"id": "C", "text": "$\\frac{\\sqrt{9.01}-\\sqrt{8.99}}{0.01}$", "explanation": "If using symmetric points, you must divide by $2h = 0.02$, not 0.01."},
    {"id": "D", "text": "$\\frac{\\sqrt{9.01}-\\sqrt{9}}{9.01-9}$", "explanation": "This is equivalent to option A since 9.01-9=0.01."}
  ]'::jsonb
WHERE id = 'CA6B2EDA-8919-4BFF-9DA7-84BDB3322CB2';

-- 6. Q642 (D90DC96E)
UPDATE questions
SET
  prompt = 'Define $f(x)=\begin{cases} \frac{x^2-1}{x-1}, & x \ne 1 \\ 3, & x=1 \end{cases}$. Which statement is true about $f$ at $x=1$?',
  explanation = 'For $x \ne 1$, $\frac{x^2-1}{x-1} = x+1$. So $\lim_{x\to 1}f(x) = 1+1=2$. However, $f(1)=3$. Since $\lim_{x\to 1}f(x) \ne f(1)$, $f$ is not continuous at $x=1$, and thus not differentiable there.',
  options = '[
    {"id": "A", "text": "Not continuous at $x=1$, but differentiable at $x=1$", "explanation": "Differentiability requires continuity; if it''s not continuous, it cannot be differentiable."},
    {"id": "B", "text": "Continuous at $x=1$, but not differentiable at $x=1$", "explanation": "Limit is 2, value is 3; they are not equal, so it is not continuous."},
    {"id": "C", "text": "Continuous and differentiable at $x=1$", "explanation": "Not continuous because limit (2) != function value (3)."},
    {"id": "D", "text": "Not continuous and not differentiable at $x=1$", "explanation": "Correct: The limit is 2 but $f(1)=3$, so discontinuous implies not differentiable."}
  ]'::jsonb
WHERE id = 'D90DC96E-148D-4AC8-A406-2903DBD38E8A';

-- 7. Q694 (EBDCF9BF)
UPDATE questions
SET
  prompt = 'Let $f(x)=\begin{cases} 2x+1, & x<0 \\ x^2+1, & x\ge 0 \end{cases}$. Is $f$ continuous at $x=0$?',
  explanation = 'Check one-sided limits: $\lim_{x\to 0^-} (2x+1) = 1$. $\lim_{x\to 0^+} (x^2+1) = 1$. Also $f(0) = 0^2+1 = 1$. Since limits match and equal $f(0)$, $f$ is continuous.',
  options = '[
    {"id": "A", "text": "Yes, because $\\lim_{x\\to 0^-}f(x) = \\lim_{x\\to 0^+}f(x) = f(0)$", "explanation": "Correct: left limit is 1, right limit is 1, value is 1."},
    {"id": "B", "text": "Yes, because both formulas are polynomials", "explanation": "Polynomials are continuous on their domains, but piecewise functions need checking at the boundary."},
    {"id": "C", "text": "No, because $f(0)$ does not exist", "explanation": "$f(0)$ is defined by the $x\\ge 0$ case as $1$."},
    {"id": "D", "text": "No, because the left-hand limit and right-hand limit are different", "explanation": "Both limits equal 1."}
  ]'::jsonb
WHERE id = 'EBDCF9BF-CC03-4B4E-BA2D-49DC62E535C9';

-- 8. EDE9CE0C (Q???)
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

-- 9. F1BBD9AF (Q???)
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

-- 10. Q662 (E19748F6)
UPDATE questions
SET
  prompt = 'Determine whether $\sum_{n=1}^\infty (-1)^n \frac{1}{\sqrt{n}}$ converges absolutely, converges conditionally, or diverges.',
  explanation = 'The series alternates. Let $b_n = \frac{1}{\sqrt{n}}$. $b_n \to 0$ and decreases, so it converges by AST. However, $\sum |a_n| = \sum \frac{1}{n^{1/2}}$ is a p-series with $p=1/2 \le 1$, so it diverges. Thus, conditional convergence.',
  options = '[
    {"id": "A", "text": "Converges conditionally", "explanation": "Correct: Converges by AST, but absolute series diverges (p=1/2)."},
    {"id": "B", "text": "Converges absolutely", "explanation": "Absolute series is p-series with p=1/2 <= 1, so diverges."},
    {"id": "C", "text": "Diverges", "explanation": "Alternating series test shows convergence."},
    {"id": "D", "text": "Inconclusive", "explanation": "AST works fine here."}
  ]'::jsonb
WHERE id = 'E19748F6-4F34-40EF-9AA4-0DF1647B9C05';
