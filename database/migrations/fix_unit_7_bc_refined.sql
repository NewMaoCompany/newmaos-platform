-- Refined Unit 7 BC Formatting and LaTeX Fixes
-- Covers all duplicate question IDs discovered for Logistic Models and Equilibrium Solutions.
-- USES DOUBLE BACKSLASHES in JSON options for \frac to prevent rendering issues.

-- 1. Logistic Growth Curve / Initial Condition Questions (Multiple IDs)
UPDATE public.questions
SET
    prompt = $txt$Use the graph in U7.5 logistic growth curve. Suppose this graph represents the solution to a logistic model. Which initial condition is most consistent with the graph?$txt$,
    latex = $txt$Use the graph in U7.5 logistic growth curve. Suppose this graph represents the solution to a logistic model. Which initial condition is most consistent with the graph?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$y(0)$ is close to $0$", "explanation": "Correct: starts far below the limiting value and rises toward it."},
      {"id": "B", "label": "B", "value": "$y(0)$ is close to the carrying capacity", "explanation": "If it started near carrying capacity, it would begin nearly flat."},
      {"id": "C", "label": "C", "value": "$y(0)$ is negative", "explanation": "The graph shows positive values throughout."},
      {"id": "D", "label": "D", "value": "$y(0)$ is larger than the carrying capacity", "explanation": "Starting above carrying capacity would typically decrease toward it."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id IN (
    '95e59a49-62f2-4046-9522-47ce60796905', 
    'b4ba378d-3528-445c-8767-93a76089fa54', 
    'b508b1f0-b367-48a5-bae0-60e817f1bd36'
);

-- 2. Equilibrium Solutions Question (Multiple IDs)
-- Includes "solution(s)" handling and double backslash \frac in options.
UPDATE public.questions
SET
    prompt = $txt$For the logistic differential equation $\frac{dP}{dt}=kP\left(1-\frac{P}{K}\right)$ with $k>0$ and $K>0$, which equilibrium solution(s) are always present?$txt$,
    latex = $txt$For the logistic differential equation $\frac{dP}{dt}=kP\left(1-\frac{P}{K}\right)$ with $k>0$ and $K>0$, which equilibrium solution(s) are always present?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$P=0$ only", "explanation": "Misses the factor $1-\\frac{P}{K}=0$ at $P=K$."},
      {"id": "B", "label": "B", "value": "$P=K$ only", "explanation": "Misses $P=0$, which makes the right side zero."},
      {"id": "C", "label": "C", "value": "$P=0$ and $P=K$", "explanation": "Correct: both are roots of the right-hand side (making the rate zero)."},
      {"id": "D", "label": "D", "value": "No equilibria because $P$ changes with $t$", "explanation": "Equilibria are constant solutions where the rate is zero."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id IN (
    '3c939d8b-af89-4b07-8f27-b0bc5b32393f', 
    '0e923b8f-3402-405c-aca3-58cdeac9e4c1'
);
