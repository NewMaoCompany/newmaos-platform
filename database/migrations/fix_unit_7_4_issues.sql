-- Fix Unit 7.4 Formatting Issues (Slope Fields)
-- Fixes raw filename display u7_7_4_slopefield_B.png -> U7.4slope field B

-- 1. Fix Q3 (Initial condition y(0)=2)
-- Match: "slope field" AND "u7_7_4_slopefield_B" AND "y(0)=2"
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.4slope field B for $\frac{dy}{dx}=y(1-y)$. A solution has initial condition $y(0)=2$. Which long-term behavior is most consistent with the slope field?$txt$,
    latex = $txt$Use the slope field in U7.4slope field B for $\frac{dy}{dx}=y(1-y)$. A solution has initial condition $y(0)=2$. Which long-term behavior is most consistent with the slope field?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%u7_7_4_slopefield_B%y(0)=2%';

-- 2. Fix Q4 (Solution starts 0<y<1)
-- Match: "slope field" AND "u7_7_4_slopefield_B" AND "0<y<1"
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.4slope field B for $\frac{dy}{dx}=y(1-y)$. If a solution starts with $0<y<1$, what happens to $y$ as $x$ increases?$txt$,
    latex = $txt$Use the slope field in U7.4slope field B for $\frac{dy}{dx}=y(1-y)$. If a solution starts with $0<y<1$, what happens to $y$ as $x$ increases?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%u7_7_4_slopefield_B%0<y<1%';

-- 3. Fix Q5 (Equilibria and stability)
-- Match: "slope field" AND "u7_7_4_slopefield_B" AND "equilibria and stability"
UPDATE public.questions
SET
    prompt = $txt$Use the slope field in U7.4slope field B for $\frac{dy}{dx}=y(1-y)$. Which statement about equilibria and stability is correct?$txt$,
    latex = $txt$Use the slope field in U7.4slope field B for $\frac{dy}{dx}=y(1-y)$. Which statement about equilibria and stability is correct?$txt$,
    updated_at = NOW()
WHERE prompt LIKE '%slope field%u7_7_4_slopefield_B%equilibria and stability%';
