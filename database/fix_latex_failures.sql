-- Fix broken LaTeX for question c256c221-d33b-437e-b5b9-e9e5f9cfa85a
-- Error: "inner radius to $y=x is $r=3-x" -> missing closing $ for y=x
-- Correct: "inner radius to $y=x$ is $r=3-x"

UPDATE public.questions
SET explanation = 'About $y=3$, outer radius to $y=0$ is $R=3$, inner radius to $y=x$ is $r=3-x$. $$V=\pi\int_0^2\left(R^2-r^2\right)dx=\pi\int_0^2\left(9-(3-x)^2\right)dx.$$ Since $9-(3-x)^2=6x-x^2$, $$V=\pi\int_0^2(6x-x^2)\,dx=\pi\left[3x^2-\frac{x^3}{3}\right]_0^2=\pi\left(12-\frac{8}{3}\right)=\frac{28\pi}{3}.$'
WHERE id = 'c256c221-d33b-437e-b5b9-e9e5f9cfa85a';
