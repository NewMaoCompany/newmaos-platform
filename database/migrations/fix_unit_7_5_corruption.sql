-- Fix Unit 7.5 Q1 Formatting Issue (Robust Match)
-- User request: Remove (()) text corruption

UPDATE public.questions
SET
    prompt = $txt$Which is an equivalent separated form of $\frac{dy}{dx}=\frac{x^2}{y}$ (assuming $y\neq 0$)?$txt$,
    latex = $txt$Which is an equivalent separated form of $\frac{dy}{dx}=\frac{x^2}{y}$ (assuming $y\neq 0$)?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%equivalent%separated%form%' 
  AND (prompt LIKE '%x^2/y%' OR prompt LIKE '%x^2}{y%')
  AND prompt LIKE '%(()%';
