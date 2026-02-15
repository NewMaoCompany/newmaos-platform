-- Fix Unit 7.7 Formatting Issues (Exponential Models)
-- Fixes raw filename display

-- 1. Fix Q2 (Exponential growth graph)
-- Match: "u7_7_8_exp_graph.png"
UPDATE public.questions
SET
    prompt = $txt$Use the graph in U7.7 exponential growth graph. The model shown is exponential growth. Which statement best matches the meaning of a larger positive $k$ in $\frac{dP}{dt}=kP$?$txt$,
    latex = $txt$Use the graph in U7.7 exponential growth graph. The model shown is exponential growth. Which statement best matches the meaning of a larger positive $k$ in $\frac{dP}{dt}=kP$?$txt$,
    updated_at = NOW()
WHERE id = 'b96cd360-58fe-46d9-acc7-d4f901c06ca7';

-- 2. Fix Q3 (Data table)
-- Match: "u7_7_8_data_table.png"
UPDATE public.questions
SET
    prompt = $txt$Use the data table in U7.7 data table. Assume $P(t)$ follows $\frac{dP}{dt}=kP$. Which value of $k$ is most consistent with the data?$txt$,
    latex = $txt$Use the data table in U7.7 data table. Assume $P(t)$ follows $\frac{dP}{dt}=kP$. Which value of $k$ is most consistent with the data?$txt$,
    updated_at = NOW()
WHERE id = '6b7a2074-faa9-4942-96db-1e5de6d14c41';
