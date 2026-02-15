-- Fix Unit 6 Test Issues (Robust Version)
-- Relaxed WHERE clauses to ensure matching despite LaTeX spacing variations.

-- 1. Fix Q1/Q14 (Total Dist) - Red Option B
-- Problem: Option B has `\right$|` which is invalid.
-- Match rule: "Car's velocity" AND "total distance traveled"
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "value": "$\\int_0^5 v(t)\\,dt$", "explanation": "Wrong: gives net change (displacement), not total distance."},
      {"id": "B", "value": "$|\\int_0^5 v(t)\\,dt|$", "explanation": "Wrong: absolute value after integrating can still cancel direction changes."},
      {"id": "C", "value": "$\\int_0^5 |v(t)|\\,dt$", "explanation": "Correct: integrates speed $|v(t)|$."},
      {"id": "D", "value": "$\\int_0^5 v'(t)\\,dt$", "explanation": "Wrong: $\\int v'(t)$ relates to change in velocity, not distance."}
    ]$txt$
WHERE prompt LIKE '%A car’s velocity%$v(t)$%total distance traveled%';

-- 2. Fix Q6 (Odd Function) - Red Option D
-- Match rule: "f is odd" AND "what is \int"
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "value": "0", "explanation": "Odd functions over symmetric interval integrate to 0, but the bounds are not symmetric here."},
      {"id": "B", "value": "$2\\int_0^4 f(x)\\,dx$", "explanation": "This property applies to EVEN functions."},
      {"id": "C", "value": "$\\int_0^4 f(x)\\,dx$", "explanation": "Incorrect."},
      {"id": "D", "value": "$|\\int_0^4 f(x)\\,dx|$", "explanation": "Absolute value is not the general rule for odd functions."}
    ]$txt$
WHERE prompt LIKE '%If f is odd%what is%';

-- 3. Fix Q2 (Piecewise) - Invalid \piecewise command
-- Match rule: contains "\piecewise"
UPDATE public.questions
SET
    prompt = REPLACE(prompt, '(\piecewise', '(piecewise'),
    latex = REPLACE(latex, '(\piecewise', '(piecewise'),
    updated_at = NOW()
WHERE prompt LIKE '%(\piecewise%';

-- 4. Fix Q12 (Evaluate integral) - "Evaluate , dx"
-- Match rule: "Evaluate" AND "6x(3x^2+1)^4"
UPDATE public.questions
SET
    prompt = $txt$Evaluate $\int_{0}^{2} 6x(3x^2+1)^4\,dx$ using substitution.$txt$,
    latex = $txt$Evaluate $\int_{0}^{2} 6x(3x^2+1)^4\,dx$ using substitution.$txt$,
    options = $txt$[
      {"id": "A", "value": "$\\frac{(13)^5-(1)^5}{5}$", "explanation": "Correct: correct u-bounds and antiderivative."},
      {"id": "B", "value": "$\\frac{(13)^5-(1)^5}{30}$", "explanation": "Wrong: extra factor introduced."},
      {"id": "C", "value": "$\\frac{(13)^4-(1)^4}{4}$", "explanation": "Wrong: exponent dropped; should integrate $u^4$."},
      {"id": "D", "value": "$\\frac{(13)^5+(1)^5}{5}$", "explanation": "Wrong: should subtract upper-lower, not add."}
    ]$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%Evaluate%6x%(3x^2+1)^4%';

-- 5. Fix Q13 (Equivalent integral) - "equivalent to , dx"
-- Match rule: "equivalent to" AND "3x+1"
UPDATE public.questions
SET
    prompt = $txt$Use the provided substitution map. If $u=3x+1$, which integral in $u$ is equivalent to $\int_{0}^{2} \frac{1}{3x+1}\,dx$?$txt$,
    latex = $txt$Use the provided substitution map. If $u=3x+1$, which integral in $u$ is equivalent to $\int_{0}^{2} \frac{1}{3x+1}\,dx$?$txt$,
    options = $txt$[
      {"id": "A", "value": "$\\frac{1}{3}\\int_{1}^{7} \\frac{1}{u}\\,du$", "explanation": "Correct: correct factor and changed bounds."},
      {"id": "B", "value": "$\\int_{1}^{7} \\frac{1}{u}\\,du$", "explanation": "Wrong: missing the $1/3$ factor."},
      {"id": "C", "value": "$\\frac{1}{3}\\int_{0}^{2} \\frac{1}{u}\\,du$", "explanation": "Wrong: bounds were not converted to u."},
      {"id": "D", "value": "$\\frac{1}{3}\\int_{7}^{1} \\frac{1}{u}\\,du$", "explanation": "Wrong: bounds reversed."}
    ]$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%equivalent to%3x+1%';

-- 6. Fix Q18 (Evaluate appropriate method) - "appropriate to evaluate , dx"
-- Match rule: "most appropriate to evaluate" AND "2x" AND "x^2+1"
UPDATE public.questions
SET
    prompt = $txt$Which method is most appropriate to evaluate $\int \frac{2x}{x^2+1}\,dx$?$txt$,
    latex = $txt$Which method is most appropriate to evaluate $\int \frac{2x}{x^2+1}\,dx$?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%most appropriate to evaluate%2x%x^2+1%';

-- 7. Fix Unit 6.11 Question 2 (Complete Square) - "evaluate , dx"
-- Match rule: "complete the square to evaluate" AND "x sin x"
UPDATE public.questions
SET
    prompt = $txt$A student plans to complete the square to evaluate $\int x \sin x \, dx$. Which statement is best?$txt$,
    latex = $txt$A student plans to complete the square to evaluate $\int x \sin x \, dx$. Which statement is best?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%complete the square to evaluate%x%sin%';

-- 8. Fix Unit 7.1 Q4 (Rate Table) - Remove filename reference
-- Match rule: "Use the rate table in file" OR "u7_7_1_rate_table.png"
UPDATE public.questions
SET
    prompt = $txt$Use the rate table in U7.1rate table. Which differential equation best matches the data?$txt$,
    latex = $txt$Use the rate table in U7.1rate table. Which differential equation best matches the data?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%rate table%u7_7_1_rate_table%';
