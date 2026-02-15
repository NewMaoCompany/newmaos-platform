-- Refined Unit 7 Test Formatting and LaTeX Fixes
-- Addresses raw filenames, 'times' corruption (×), and red LaTeX.
-- USES DOUBLE BACKSLASHES in JSON options for \frac to prevent \f (form feed) issues.

-- 1. Q6 (ID: e218920c-de93-4c6a-a1de-143b7a59b817) - Pop table, 'times' corruption
UPDATE public.questions
SET
    prompt = $txt$Use the data in U7.6 population table. The population is leveling off. Which statement is most reasonable about the rate of change $\frac{dP}{dt}$ at later times?$txt$,
    latex = $txt$Use the data in U7.6 population table. The population is leveling off. Which statement is most reasonable about the rate of change $\frac{dP}{dt}$ at later times?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$\\frac{dP}{dt}$ stays constant and positive.", "explanation": "A constant positive rate would not level off."},
      {"id": "B", "label": "B", "value": "$\\frac{dP}{dt}$ is still positive but getting closer to $0$.", "explanation": "Correct: growth continues but slows as it approaches a limit."},
      {"id": "C", "label": "C", "value": "$\\frac{dP}{dt}$ must be negative.", "explanation": "The table shows increasing values, not decreasing."},
      {"id": "D", "label": "D", "value": "$\\frac{dP}{dt}$ must be exactly $0$ for all later times.", "explanation": "A leveling trend does not imply the rate is identically zero immediately."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'e218920c-de93-4c6a-a1de-143b7a59b817';

-- 2. Q2 (ID: b508b1f0-b367-48a5-bae0-60e817f1bd36) - Logistic curve filename
UPDATE public.questions
SET
    prompt = $txt$Use the graph in U7.5 logistic growth curve. Which statement best describes the long-term behavior of $y(t)$?$txt$,
    latex = $txt$Use the graph in U7.5 logistic growth curve. Which statement best describes the long-term behavior of $y(t)$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$y(t)$ increases without bound.", "explanation": "Logistic-type growth levels off rather than growing unbounded."},
      {"id": "B", "label": "B", "value": "$y(t)$ approaches a horizontal asymptote (levels off).", "explanation": "Correct: the graph clearly approaches a constant level."},
      {"id": "C", "label": "C", "value": "$y(t)$ oscillates around a constant value.", "explanation": "No oscillations are shown."},
      {"id": "D", "label": "D", "value": "$y(t)$ decreases to $0$.", "explanation": "The curve is increasing and leveling off, not decreasing."}
    ]$txt$::jsonb,
    updated_at = NOW()
WHERE id = 'b508b1f0-b367-48a5-bae0-60e817f1bd36';

-- 3. Q (ID: e24d1fdf-9d44-4d41-bb25-158916db2bb1) - Logistic sign table, Red LaTeX
UPDATE public.questions
SET
    prompt = $txt$Use the sign chart in U7.5 logistic sign table for $\frac{dP}{dt}=0.2P\left(1-\frac{P}{500}\right)$. Which equilibrium is stable for nearby positive populations?$txt$,
    latex = $txt$Use the sign chart in U7.5 logistic sign table for $\frac{dP}{dt}=0.2P\left(1-\frac{P}{500}\right)$. Which equilibrium is stable for nearby positive populations?$txt$,
    updated_at = NOW()
WHERE id = 'e24d1fdf-9d44-4d41-bb25-158916db2bb1';

-- 4. Q (ID: 5ea5cae2-3aae-4de0-8e70-6a8c164f8203) - Logistic sign table, Red LaTeX
UPDATE public.questions
SET
    prompt = $txt$Use the sign chart in U7.5 logistic sign table for $\frac{dP}{dt}=0.2P\left(1-\frac{P}{500}\right)$. Which statement is correct?$txt$,
    latex = $txt$Use the sign chart in U7.5 logistic sign table for $\frac{dP}{dt}=0.2P\left(1-\frac{P}{500}\right)$. Which statement is correct?$txt$,
    updated_at = NOW()
WHERE id = '5ea5cae2-3aae-4de0-8e70-6a8c164f8203';

-- 5. Q8 (ID: 4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68) - Separation layout
UPDATE public.questions
SET
    prompt = $txt$After separating variables for $\frac{dy}{dx}=xy$ as $\frac{1}{y}\,dy=x\,dx$, which integrated equation is correct?$txt$,
    latex = $txt$After separating variables for $\frac{dy}{dx}=xy$ as $\frac{1}{y}\,dy=x\,dx$, which integrated equation is correct?$txt$,
    updated_at = NOW()
WHERE id = '4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68';

-- 6. Q10 (ID: 3c939d8b-af89-4b07-8f27-b0bc5b32393f) - Red LaTeX (Logistic DE)
UPDATE public.questions
SET
    prompt = $txt$For the logistic differential equation $\frac{dP}{dt}=kP\left(1-\frac{P}{K}\right)$ with $k>0$ and $K>0$, which equilibrium solutions are always present?$txt$,
    latex = $txt$For the logistic differential equation $\frac{dP}{dt}=kP\left(1-\frac{P}{K}\right)$ with $k>0$ and $K>0$, which equilibrium solutions are always present?$txt$,
    updated_at = NOW()
WHERE id = '3c939d8b-af89-4b07-8f27-b0bc5b32393f';
