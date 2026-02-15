-- Final Targeted Fix for Unit 7 BC Questions (Q2 & Q3 variants)
-- Addresses red text and filenames for the specific questions in the latest screenshots.

-- 1. Fix "initial condition most consistent" question (ID: 95e59a49-62f2-4046-9522-47ce60796905)
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
WHERE id = '95e59a49-62f2-4046-9522-47ce60796905';

-- 2. Fix "equilibrium solution(s) are always present" question (ID: 3c939d8b-af89-4b07-8f27-b0bc5b32393f)
UPDATE public.questions
SET
    prompt = $txt$For the logistic differential equation $\frac{dP}{dt}=kP\left(1-\frac{P}{K}\right)$ with $k>0$ and $K>0$, which equilibrium solutions are always present?$txt$,
    latex = $txt$For the logistic differential equation $\frac{dP}{dt}=kP\left(1-\frac{P}{K}\right)$ with $k>0$ and $K>0$, which equilibrium solutions are always present?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$P=0$ only", "explanation": "Misses the equilibrium at $P=K$."},
      {"id": "B", "label": "B", "value": "$P=K$ only", "explanation": "Misses the equilibrium at $P=0$."},
      {"id": "C", "label": "C", "value": "$P=0$ and $P=K$", "explanation": "Correct: both factors can make the rate zero."},
      {"id": "D", "label": "D", "value": "No equilibria because $P$ changes with $t$", "explanation": "Equilibria occur specifically where the rate is zero, meaning $P$ does NOT change."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = '3c939d8b-af89-4b07-8f27-b0bc5b32393f';
