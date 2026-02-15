-- Fix Unit 7.3 Formatting Issues (Slope Fields) - Robust Matches
-- Fixes Red LaTeX errors (\left, \right escaping), text corruption (()), and raw filenames.

-- 1. Fix Q1 (Slope at point) - Red LaTeX `\left(2,1\\right)`
-- Match: "differential equation" AND "x-y" AND "slope at the point" AND "2,1"
UPDATE public.questions
SET
    prompt = $txt$For the differential equation $\frac{dy}{dx}=x-y$, what is the slope at the point $(2,1)$?$txt$,
    latex = $txt$For the differential equation $\frac{dy}{dx}=x-y$, what is the slope at the point $(2,1)$?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope at the point%2,1%';

-- 2. Fix Q2 (Solution curve through 0,2) - Red Option, Filename, Text Corruption (())
-- Match: "slope field" AND "curve passes through" AND "0,2"
-- Note: Matching "0,2" matches both "(0,2)" and "\left(0,2\right)"
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.3slope field A. A solution curve passes through $(0,2)$. Which statement must be true at that point?$txt$,
    latex = $txt$Use the slope field in U7.3slope field A. A solution curve passes through $(0,2)$. Which statement must be true at that point?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%curve passes through%0,2%';

-- 3. Fix Q3 (Solution through 1,3) - Filename
-- Match: "slope field" AND "passes through" AND "1,3"
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.3slope field A. A solution passes through $(1,3)$. Which description best matches the slope of the solution at that point?$txt$,
    latex = $txt$Use the slope field in U7.3slope field A. A solution passes through $(1,3)$. Which description best matches the slope of the solution at that point?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%passes through%1,3%';

-- 4. Fix Q4 (Slope field definition) - Red LaTeX `\left(x_0,y_0\\right)`
-- Match: "slope field" AND "drawing short line segments" AND "x_0,y_0"
UPDATE public.questions
SET
    prompt = $txt$A slope field for $\frac{dy}{dx}=f(x,y)$ is made by drawing short line segments. At the point $(x_0,y_0)$, what should the slope of the segment be?$txt$,
    latex = $txt$A slope field for $\frac{dy}{dx}=f(x,y)$ is made by drawing short line segments. At the point $(x_0,y_0)$, what should the slope of the segment be?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%drawing short line segments%';

-- 5. Fix Q5 (Horizontal segments) - Text corruption `(())` and Filename
-- Match: "slope field" AND "horizontal" AND "consistently"
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.3slope field A. Along which line do the direction segments appear horizontal (slope $0$) most consistently?$txt$,
    latex = $txt$Use the slope field in U7.3slope field A. Along which line do the direction segments appear horizontal (slope $0$) most consistently?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%appear horizontal%';
