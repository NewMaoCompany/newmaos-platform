-- Targeted Unit 7 Test Fixes (Handling Red Text and Filenames)
-- Addresses raw filenames, dollar sign wrappers, and underscores causing red LaTeX.
-- USES regex-like replacements to catch both '$file_name.png$' and 'file_name.png'.

-- 1. Fix Population Table questions (e.g., Q6, Q11, Q15 variants)
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
WHERE prompt LIKE '%u7_7_12_pop_table.png%';

-- 2. Fix Logistic Growth Curve questions (e.g., Q2, Q11, Q15 variants)
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
WHERE prompt LIKE '%u7_7_9_logistic_curve.png%';
