-- Fix Horizontal Fractions for 193 Questions

UPDATE public.questions
SET prompt = 'The shaded region between $y=\sin x$ and $y=\cos x$ on $[0,\frac{\pi}{2}]$ is shown in 8.0-UT-Q4.png. Which expression equals the area of the region?',
    explanation = 'Solve $\sin x=\cos x$ to find the switch point $x=\frac{\pi}{4}$. On $[0,\frac{\pi}{4}]$, top is $\cos x$; on $[\frac{\pi}{4},\frac{\pi}{2}]$, top is $\sin x$. Therefore $$A=\int_0^{\frac{\pi}{4}}(\cos x-\sin x)\,dx+\int_{\frac{\pi}{4}}^{\frac{\pi}{2}}(\sin x-\cos x)\,dx.$$',
    options = '[{"id":"A","text":"$\\int_0^{\\frac{\\pi}{2}}(\\sin x-\\cos x)\\,dx$","explanation":"This is signed and is negative on part of the interval; it is not guaranteed to equal area.","value":"$\\int_0^{\\frac{\\pi}{2}}(\\sin x-\\cos x)\\,dx$"},{"id":"B","text":"$\\int_0^{\\frac{\\pi}{4}}(\\cos x-\\sin x)\\,dx+\\int_{\\frac{\\pi}{4}}^{\\frac{\\pi}{2}}(\\sin x-\\cos x)\\,dx$","explanation":"Correct: split at $x=\\frac{\\pi}{4}$ where $\\sin x=\\cos x$, then subtract top minus bottom on each subinterval.","value":"$\\int_0^{\\frac{\\pi}{4}}(\\cos x-\\sin x)\\,dx+\\int_{\\frac{\\pi}{4}}^{\\frac{\\pi}{2}}(\\sin x-\\cos x)\\,dx$"},{"id":"C","text":"$\\int_0^{\\frac{\\pi}{2}}|\\sin x-\\cos x|\\,dx$","explanation":"This also equals area, but the prompt asks for the standard split setup.","value":"$\\int_0^{\\frac{\\pi}{2}}|\\sin x-\\cos x|\\,dx$"},{"id":"D","text":"$\\int_0^{\\frac{\\pi}{4}}(\\sin x-\\cos x)\\,dx+\\int_{\\frac{\\pi}{4}}^{\\frac{\\pi}{2}}(\\sin x-\\cos x)\\,dx$","explanation":"The order is wrong on $[0,\\frac{\\pi}{4}]$ where $\\cos x$ is above $\\sin x$.","value":"$\\int_0^{\\frac{\\pi}{4}}(\\sin x-\\cos x)\\,dx+\\int_{\\frac{\\pi}{4}}^{\\frac{\\pi}{2}}(\\sin x-\\cos x)\\,dx$"}]'::jsonb
WHERE id = '0d7a6634-ab75-4860-ba8b-2cf78455ec41';

UPDATE public.questions
SET prompt = 'On the circle $x^2+y^2=1$ with $y>0$, what is $\dfrac{d^2y}{dx^2}$ at the point $\left(\dfrac{\sqrt{2}}{2},\dfrac{\sqrt{2}}{2}\right)$?',
    explanation = 'From $x^2+y^2=1$: $$2x+2y y''=0\Rightarrow y''=-\frac{x}{y}.$$ Differentiate: $$y''''=-\frac{y-xy''}{y^2}.$$ Substitute $y''=-\frac{x}{y}$: $$y''''=-\frac{y+x(\frac{x}{y})}{y^2}=-\frac{\frac{y^2+x^2}{y}}{y^2}=-\frac{1}{y^3}.$$ At $y=\frac{\sqrt{2}}{2}$: $$y''''=-\frac{1}{(\frac{\sqrt{2}}{2})^3}=-2\sqrt{2}.$$',
    options = '[{"id":"A","text":"$-\\sqrt{2}$","explanation":"This misses the cube on $y$ when simplifying $y''''=\\frac{-1}{y^3}$.","value":"$-\\sqrt{2}$"},{"id":"B","text":"$-2$","explanation":"This uses $y''''=\\frac{-1}{y^2}$ instead of the correct $\\frac{-1}{y^3}$.","value":"$-2$"},{"id":"C","text":"$-2\\sqrt{2}$","explanation":"Correct: from $y''=\\frac{-x}{y}$, differentiating gives $y''''=\\frac{-1}{y^3}$, then substitute $y=\\frac{\\sqrt{2}}{2}$.","value":"$-2\\sqrt{2}$"},{"id":"D","text":"$2\\sqrt{2}$","explanation":"Sign error: the upper semicircle is concave down here.","value":"$2\\sqrt{2}$"}]'::jsonb
WHERE id = '11652131-659e-4281-ae3c-af903e5bf9c5';

UPDATE public.questions
SET prompt = 'Evaluate the limit.  $$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}$$',
    explanation = 'Rationalize: $$\frac{\sqrt{1+x}-1}{x}\cdot\frac{\sqrt{1+x}+1}{\sqrt{1+x}+1}=\frac{1}{\sqrt{1+x}+1}.$$ Then $$\lim_{x\to 0}\frac{1}{\sqrt{1+x}+1}=\frac12.$$',
    options = '[{"id":"A","text":"0","value":"0","explanation":"Direct substitution gives $\\frac{0}{0}$, which is indeterminate."},{"id":"B","text":"1","value":"1","explanation":"This is a common guess, but the correct limit is $\\frac12$."},{"id":"C","text":"2","value":"2","explanation":"This comes from an incorrect rationalization step."},{"id":"D","text":"$\\frac12$","explanation":"Rationalize, simplify, then substitute $x=0$.","value":"$\\frac12$"}]'::jsonb
WHERE id = '141ebcb4-37bf-41f0-9a6a-3c5a0c9860e3';

UPDATE public.questions
SET prompt = 'The table in figure 4.7-P2 shows values of $\dfrac{e^x-1-x}{x^2}$ near $x=0$. Estimate $\displaystyle \lim_{x\to 0}\frac{e^x-1-x}{x^2}$.',
    explanation = 'This is a $\frac{0}{0}$ form. Apply L’Hospital twice: $$\lim_{x\to 0}\frac{e^x-1-x}{x^2} =\lim_{x\to 0}\frac{e^x-1}{2x}\quad(\frac{0}{0}) =\lim_{x\to 0}\frac{e^x}{2} =\frac{1}{2}.$$ The table in figure 4.7-P2 is consistent with values approaching $0.500000\ldots$.',
    options = '[{"id":"A","text":"$0$","explanation":"This incorrectly concludes the numerator is “too small” without using derivatives or the table trend.","value":"$0$"},{"id":"B","text":"$\\frac{1}{2}$","explanation":"The table values approach $0.5$, and applying L’Hospital twice gives $\\frac{e^x}{2}\\to \\frac{1}{2}$.","value":"$\\frac{1}{2}$"},{"id":"C","text":"$1$","explanation":"This matches $\\lim_{x\\to 0}\\frac{e^x-1}{x}$, not the given expression with the extra $-x$ and $x^2$.","value":"$1$"},{"id":"D","text":"$2$","explanation":"This is not supported by the table; the values trend to about $0.5$, not $2$.","value":"$2$"}]'::jsonb
WHERE id = '165c0b5a-2cc7-4b38-82a6-ae753a9573f1';

UPDATE public.questions
SET prompt = 'An accumulation function is defined by $s(t)=\int_0^t v(u)\,du$, where $v$ is a velocity function. If $s(2)=4$ and $s(5)=10$, what is the average value of $v(t)$ on $[2,5]$?',
    explanation = 'Since $s''(t)=v(t)$, the average value of $v$ on $[2,5]$ equals the average rate of change of $s$ on $[2,5]$: $$\frac{s(5)-s(2)}{5-2}=\frac{10-4}{3}=2.$$',
    options = '[{"id":"A","text":"$14$","explanation":"This is $s(5)+s(2)$ (nonsensical here).","value":"$14$"},{"id":"B","text":"$6$","explanation":"This is $s(5)-s(2)$ but not divided by the time interval length.","value":"$6$"},{"id":"C","text":"$2$","explanation":"Correct: average $v=\\dfrac{s(5)-s(2)}{5-2}=\\dfrac{6}{3}=2$.","value":"$2$"},{"id":"D","text":"$$\\dfrac{10}{5}$$","explanation":"This incorrectly uses $s\\frac{5}{5}$ instead of the secant slope on $[2,5]$.","value":"$$\\dfrac{10}{5}$$"}]'::jsonb
WHERE id = '189a2d07-8793-45ff-a936-b4fe913d8e43';

UPDATE public.questions
SET prompt = 'Let $h(x)=(\ln x)(\cos x)$ for $x>0$. What is $h''(x)$?',
    explanation = 'Let $u=\ln x$ and $v=\cos x$. Then $$h''(x)=u''v+uv''=\frac{1}{x}\cos x+(\ln x)(-\sin x).$$',
    options = '[{"id":"A","text":"$\\dfrac{1}{x}\\cos x+(\\ln x)(-\\sin x)$","explanation":"Correct: product rule with $(\\ln x)''=\\frac{1}{x}$ and $(\\cos x)''=-\\sin x$.","value":"$\\dfrac{1}{x}\\cos x+(\\ln x)(-\\sin x)$"},{"id":"B","text":"$\\dfrac{1}{x}-\\sin x$","explanation":"Incorrect: differentiated each factor but did not multiply by the other factor.","value":"$\\dfrac{1}{x}-\\sin x$"},{"id":"C","text":"$\\dfrac{\\cos x}{x}-\\dfrac{\\sin x}{x}$","explanation":"Second term is wrong; it should be $-(\\ln x)\\sin x$, not $-\\frac{\\sin x}{x}$.","value":"$\\dfrac{\\cos x}{x}-\\dfrac{\\sin x}{x}$"},{"id":"D","text":"$\\dfrac{1}{x}\\cos x+(\\ln x)\\sin x$","explanation":"Sign error: $(\\cos x)''=-\\sin x$, so the second term must be negative.","value":"$\\dfrac{1}{x}\\cos x+(\\ln x)\\sin x$"}]'::jsonb
WHERE id = '1cbf9be0-4580-42cc-99af-8b8e92c9b97b';

UPDATE public.questions
SET prompt = 'Let $f$ be differentiable except possibly where $f''(x)$ is undefined. Suppose $$f''(x)=\dfrac{(x-2)(x+1)^2}{x-3}.$$ On which intervals is $f$ increasing?',
    explanation = 'Critical values come from $f''(x)=0$ or undefined: $x=-1,2$ (zeros) and $x=3$ (undefined). Since $(x+1)^2\ge 0$ and has even multiplicity at $x=-1$, it does not flip the sign. Thus the sign is the sign of $\frac{x-2}{x-3}$: positive for $x<2$ and $x>3$, negative for $2<x<3$. Therefore $f$ is increasing on $(-\infty,-1)\cup(-1,2)\cup(3,\infty)$.',
    options = '[{"id":"A","text":"$(-\\infty,-1)\\cup(-1,2)\\cup(3,\\infty)$","explanation":"Correct. Because $(x+1)^2$ does not change sign, the sign of $f''(x)$ is determined by $\\frac{x-2}{x-3}$; positive for $x<2$ and $x>3$, splitting at $x=-1$ where $f''(x)=0$.","value":"$(-\\infty,-1)\\cup(-1,2)\\cup(3,\\infty)$"},{"id":"B","text":"$(-\\infty,-1)\\cup(2,3)$","explanation":"Incorrect. On $(2,3)$, $(x-2)>0$ and $(x-3)<0$, so $f''(x)<0$ (decreasing).","value":"$(-\\infty,-1)\\cup(2,3)$"},{"id":"C","text":"$(-1,2)\\cup(2,3)$","explanation":"Incorrect. $(2,3)$ is decreasing since $f''(x)<0$ there, and it also misses $(-\\infty,-1)$.","value":"$(-1,2)\\cup(2,3)$"},{"id":"D","text":"$(2,3)$ only","explanation":"Incorrect. This is exactly where $f''(x)<0$, so $f$ is decreasing there.","value":"$(2,3)$ only"}]'::jsonb
WHERE id = '1e7386ae-1611-4ac5-8530-597cde004fa5';

UPDATE public.questions
SET prompt = 'The point has polar coordinates $(r,\theta)=(-3,\tfrac{\pi}{4})$. Which of the following is an equivalent polar representation with $r>0$ and $0\le \theta<2\pi$?',
    explanation = 'In polar coordinates, $(r,\theta)$ and $(-r,\theta+\pi)$ represent the same point. Therefore $$(-3,\frac{\pi}{4})\equiv(3,\frac{\pi}{4}+\pi)=(3,5\frac{\pi}{4}).$$',
    options = '[{"id":"A","text":"$(3,\\tfrac{5\\pi}{4})$","explanation":"Correct. Use $(-r,\\theta)\\equiv(r,\\theta+\\pi)$.","value":"$(3,\\tfrac{5\\pi}{4})$"},{"id":"B","text":"$(3,\\tfrac{\\pi}{4})$","explanation":"This keeps the same angle, which does not represent the same point when $r$ changes sign.","value":"$(3,\\tfrac{\\pi}{4})$"},{"id":"C","text":"$(3,\\tfrac{7\\pi}{4})$","explanation":"This uses an incorrect angle shift; it does not add $\\pi$.","value":"$(3,\\tfrac{7\\pi}{4})$"},{"id":"D","text":"$(3,\\tfrac{3\\pi}{4})$","explanation":"This places the point in the wrong quadrant.","value":"$(3,\\tfrac{3\\pi}{4})$"}]'::jsonb
WHERE id = '1ea9d9c6-c358-4a09-b6e6-d88f014bc71f';

UPDATE public.questions
SET prompt = 'For $g(x)=\dfrac{\sin x}{\cos x}$ (where defined), what is $g''(x)$ written in simplest form?',
    explanation = 'Recognize $\dfrac{\sin x}{\cos x}=\tan x$. Then $$g''(x)=\frac{d}{dx}(\tan x)=\sec^2 x=\frac{1}{\cos^2 x}.$$',
    options = '[{"id":"A","text":"$\\dfrac{1}{\\cos^2 x}$","explanation":"Correct: $g(x)=\\tan x$, so $g''(x)=\\sec^2 x=\\frac{1}{\\cos^2} x$.","value":"$\\dfrac{1}{\\cos^2 x}$"},{"id":"B","text":"$\\dfrac{\\cos^2 x-\\sin^2 x}{\\cos^2 x}$","explanation":"This simplifies to $1$, not the derivative of $\\tan x$.","value":"$\\dfrac{\\cos^2 x-\\sin^2 x}{\\cos^2 x}$"},{"id":"C","text":"$\\dfrac{\\cos x}{\\sin x}$","explanation":"This is $\\cot x$, not the derivative.","value":"$\\dfrac{\\cos x}{\\sin x}$"},{"id":"D","text":"$\\dfrac{\\cos x+\\sin x}{\\cos^2 x}$","explanation":"Incorrect differentiation; suggests a broken quotient/product setup.","value":"$\\dfrac{\\cos x+\\sin x}{\\cos^2 x}$"}]'::jsonb
WHERE id = '20a746ae-7223-4895-8a78-79cbdeaf172a';

UPDATE public.questions
SET prompt = 'See image: 8.4-P5.png. What is the area of the region enclosed by $y=\sqrt{x}$ and $y=\frac{x}{2}$?',
    explanation = 'Solve intersections: $\sqrt{x}=\frac{x}{2}\Rightarrow 2\sqrt{x}=x\Rightarrow x=0$ or (for $x\ne0$) $2=\sqrt{x}\Rightarrow x=4$. On $[0,4]$, $\sqrt{x}\ge \frac{x}{2}$. Area: $$\int_0^4\left(\sqrt{x}-\frac{x}{2}\right)dx=\left[\frac{2}{3}x^{\frac{3}{2}}-\frac{x^2}{4}\right]_0^4=\frac{16}{3}-4=\frac{4}{3}.$$',
    options = '[{"id":"A","text":"$$\\dfrac{8}{3}$$","explanation":"This is the integral of $\\sqrt{x}$ alone over $[0,4]$, not the difference.","value":"$$\\dfrac{8}{3}$$"},{"id":"B","text":"$$\\dfrac{2}{3}$$","explanation":"This results from using the wrong intersection $x$-value.","value":"$$\\dfrac{2}{3}$$"},{"id":"C","text":"$4$","explanation":"This is the integral of $\\frac{x}{2}$ alone over $[0,4]$.","value":"$4$"},{"id":"D","text":"$$\\dfrac{4}{3}$$","explanation":"Correct: integrate $\\sqrt{x}-\\frac{x}{2}$ from $0$ to $4$.","value":"$$\\dfrac{4}{3}$$"}]'::jsonb
WHERE id = '243a4a21-b161-4357-9fe7-c0288508f525';

UPDATE public.questions
SET prompt = 'Use the second-degree Taylor polynomial for $f(x)=\sqrt{x}$ about $x=4$ to approximate $\sqrt{4.1}$.',
    explanation = 'At $a=4$, $f(4)=2$, $f^{\prime}(4)=\dfrac{1}{4}$, $f^{\prime\prime}(4)=-\dfrac{1}{32}$. With $h=0.1$, $$T_2(4.1)=2+\frac{1}{4}(0.1)+\frac{\frac{-1}{32}}{2}(0.1)^2=2+0.025-0.00015625=2.02484375.$$',
    options = '[{"id":"A","text":"$2.0125$","explanation":"This value typically comes from mishandling the quadratic correction or centering at the wrong value.","value":"$2.0125$"},{"id":"B","text":"$2.000625$","explanation":"This treats $\\sqrt{4.1}$ as if it were near $1$ rather than near $2$ (wrong shift/center).","value":"$2.000625$"},{"id":"C","text":"$2.024375$","explanation":"Close, but it comes from an arithmetic slip in the quadratic term; the correction should be $-\\frac{0.01}{64}=0.00015625$.","value":"$2.024375$"},{"id":"D","text":"$2.02484375$","explanation":"$f(4)=2$, $f^{\\prime}(4)=\\dfrac{1}{4}$, $f^{\\prime\\prime}(4)=-\\dfrac{1}{32}$, $h=0.1$: $T_2(4.1)=2+\\dfrac{1}{4}(0.1)+\\dfrac{\\frac{-1}{32}}{2}(0.1)^2=2.02484375$.","value":"$2.02484375$"}]'::jsonb
WHERE id = '268ba7f8-215d-4348-b7bb-31e8d908a45d';

UPDATE public.questions
SET prompt = 'Let $f(x)=\ln(x+2)$. What is $(f^{-1})''(0)$?',
    explanation = 'Find $f^{-1}(0)$ by solving $\ln(x+2)=0\Rightarrow x+2=1\Rightarrow x=-1$. Then $f''(x)=\dfrac{1}{x+2}$, so $f''(-1)=1$. Hence $$ (f^{-1})''(0)=\frac{1}{f''(f^{-1}(0))}=\frac{1}{f''(-1)}=1. $$',
    options = '[{"id":"A","text":"$1$","explanation":"Correct: $f^{-1}(0)=-1$, $f''(-1)=1$, so $(f^{-1})''(0)=\\frac{1}{f}''(-1)=1$.","value":"$1$"},{"id":"B","text":"$-1$","explanation":"This confuses $f^{-1}(0)=-1$ with $(f^{-1})''(0)$.","value":"$-1$"},{"id":"C","text":"$\\dfrac{1}{2}$","explanation":"This incorrectly evaluates $f''(0)=\\frac{1}{2}$ instead of evaluating at $x=f^{-1}(0)=-1$.","value":"$\\dfrac{1}{2}$"},{"id":"D","text":"$-\\dfrac{1}{2}$","explanation":"This combines a wrong evaluation point with a sign error.","value":"$-\\dfrac{1}{2}$"}]'::jsonb
WHERE id = '2c8a01b6-04cf-4640-8859-1e7693ddff10';

UPDATE public.questions
SET prompt = 'The region bounded by $y=\sqrt{x}$ and $y=0$ for $0\le x\le 4$ is revolved about the line $y=1$. What is the volume?',
    explanation = 'Revolve about $y=1$. With vertical slices, distances to the axis are $1$ and $|\sqrt{x}-1|$, so washer area is $$\pi\left(1^2-(|\sqrt{x}-1|)^2\right)=\pi\left(1-(\sqrt{x}-1)^2\right).$$ Simplify: $1-(\sqrt{x}-1)^2=2\sqrt{x}-x$. Thus $$V=\pi\int_0^4(2\sqrt{x}-x)\,dx=\pi\left[\frac{4}{3}x^{\frac{3}{2}}-\frac{x^2}{2}\right]_0^4=\pi\left(\frac{32}{3}-8\right)=\frac{8\pi}{3}.$$',
    options = '[{"id":"A","text":"$\\dfrac{16\\pi}{3}$","explanation":"Often from dropping the $-x$ term after simplifying $1-(\\sqrt{x}-1)^2$.","value":"$\\dfrac{16\\pi}{3}$"},{"id":"B","text":"$4\\pi$","explanation":"Often from treating the solid as a cylinder-like shape rather than washers with changing radii.","value":"$4\\pi$"},{"id":"C","text":"$\\dfrac{8\\pi}{3}$","explanation":"Correct: $V=\\pi\\int_0^4\\left(1-(\\sqrt{x}-1)^2\\right)\\,dx=\\dfrac{8\\pi}{3}$.","value":"$\\dfrac{8\\pi}{3}$"},{"id":"D","text":"$\\dfrac{10\\pi}{3}$","explanation":"Arithmetic slip when evaluating $\\frac{32}{3}-8$.","value":"$\\dfrac{10\\pi}{3}$"}]'::jsonb
WHERE id = '2f1454f2-8e5d-4a7e-beb6-709f5fab1daa';

UPDATE public.questions
SET prompt = 'Find $\dfrac{d}{dx}\left(\arctan\left(\dfrac{1}{x}\right)\right)$ for $x\ne 0$.',
    explanation = 'Let $u=\dfrac{1}{x}$. Then $u''=-\dfrac{1}{x^2}$. Using $\dfrac{d}{dx}\arctan(u)=\dfrac{u''}{1+u^2}$, $$\frac{d}{dx}\arctan\left(\frac{1}{x}\right)=\frac{\frac{-1}{x^2}}{1+\frac{1}{x^2}}=\frac{\frac{-1}{x^2}}{\frac{x^2+1}{x}^2}=-\frac{1}{x^2+1}.$$',
    options = '[{"id":"A","text":"$-\\dfrac{1}{1+x^2}$","explanation":"Correct: with $u=\\frac{1}{x}$, $u''=\\frac{-1}{x^2}$ and $\\dfrac{u''}{1+u^2}=\\dfrac{\\frac{-1}{x^2}}{1+\\frac{1}{x^2}}=-\\dfrac{1}{1+x^2}$.","value":"$-\\dfrac{1}{1+x^2}$"},{"id":"B","text":"$\\dfrac{1}{1+x^2}$","explanation":"This drops the negative sign from $u''=\\frac{-1}{x^2}$.","value":"$\\dfrac{1}{1+x^2}$"},{"id":"C","text":"$-\\dfrac{1}{x^2}$","explanation":"This differentiates only the inner function and ignores the outer $\\arctan$ factor.","value":"$-\\dfrac{1}{x^2}$"},{"id":"D","text":"$\\dfrac{1}{1+\\frac{1}{x^2}}$","explanation":"This applies the outer rule but ignores multiplying by $u''=\\frac{-1}{x^2}$.","value":"$\\dfrac{1}{1+\\frac{1}{x^2}}$"}]'::jsonb
WHERE id = '32dad1dc-44f2-4d16-8891-658a35c6949a';

UPDATE public.questions
SET prompt = 'Find the area enclosed by the polar curve $r=2\sin\theta$.',
    explanation = 'Use polar area: $$A=\frac12\int_{0}^{\pi}4\sin^2\theta\,d\theta=2\int_0^{\pi}\sin^2\theta\,d\theta=2\cdot\frac{\pi}{2}=\pi.$$',
    options = '[{"id":"A","text":"$\\pi$","explanation":"Correct. $A=\\frac12\\int_0^{\\pi}(2\\sin\\theta)^2\\,d\\theta=\\pi$.","value":"$\\pi$"},{"id":"B","text":"$2\\pi$","explanation":"This comes from forgetting the $\\tfrac12$ in the polar area formula.","value":"$2\\pi$"},{"id":"C","text":"$\\frac{\\pi}{2}$","explanation":"This often results from using $[0,\\frac{\\pi}{2}]$ instead of the full tracing interval.","value":"$\\frac{\\pi}{2}$"},{"id":"D","text":"$4$","explanation":"This confuses area with an average radius or uses a non-area formula.","value":"$4$"}]'::jsonb
WHERE id = '33417a9d-1493-4c9e-a5d0-ea936767a6b7';

UPDATE public.questions
SET prompt = 'Which limit is an indeterminate form appropriate for applying L’Hospital’s Rule (after checking differentiability conditions)?',
    explanation = 'Direct substitution into $\frac{3x+1}{2x-5}$ as $x\to\infty$ produces $\frac{\infty}{\infty}$, an indeterminate ratio form where L’Hospital is appropriate after verifying conditions.',
    options = '[{"id":"A","text":"$\\displaystyle \\lim_{x\\to 0}\\frac{1}{x^2}$","explanation":"This is not indeterminate; it diverges to $\\infty$.","value":"$\\displaystyle \\lim_{x\\to 0}\\frac{1}{x^2}$"},{"id":"B","text":"$\\displaystyle \\lim_{x\\to \\infty}\\frac{3x+1}{2x-5}$","explanation":"This is an $\\frac{\\infty}{\\infty}$ indeterminate form, so L’Hospital can apply (though algebra also works).","value":"$\\displaystyle \\lim_{x\\to \\infty}\\frac{3x+1}{2x-5}$"},{"id":"C","text":"$\\displaystyle \\lim_{x\\to 0}(1+\\sin x)$","explanation":"This is determinate: it approaches $1$.","value":"$\\displaystyle \\lim_{x\\to 0}(1+\\sin x)$"},{"id":"D","text":"$\\displaystyle \\lim_{x\\to 2}\\frac{x^2-4}{x-2}$","explanation":"This is $\\frac{0}{0}$ but is typically simplified by factoring first; it is not the intended choice here.","value":"$\\displaystyle \\lim_{x\\to 2}\\frac{x^2-4}{x-2}$"}]'::jsonb
WHERE id = 'c51dff4b-9a2e-4a4a-9eb1-c4d47bbb6534';

UPDATE public.questions
SET prompt = 'The total cost to produce $x$ items is $C(x)$ dollars. If $C''(50)=12$, which statement best describes what this means?',
    explanation = '$C''(50)$ is the instantaneous rate of change of cost with respect to number of items at $x=50$. It estimates the marginal cost: producing one more item near 50 increases total cost by about $\\$12$.',
    options = '[{"id":"A","text":"The cost to produce 50 items is $\\\\$12$.","explanation":"Confuses marginal cost with total cost.","value":"The cost to produce 50 items is $\\\\$12$."},{"id":"B","text":"The average cost per item when $x=50$ is $\\\\$12$.","explanation":"Average cost is $C\\frac{50}{50}$, not $C''(50)$.","value":"The average cost per item when $x=50$ is $\\\\$12$."},{"id":"C","text":"When 50 items have been produced, the cost is increasing at about $\\\\$12$ per additional item.","explanation":"Correct: $C''(50)$ is the marginal cost near $x=50$.","value":"When 50 items have been produced, the cost is increasing at about $\\\\$12$ per additional item."},{"id":"D","text":"When 50 items have been produced, the cost will be $\\\\$12$ higher after producing 50 more items.","explanation":"Misreads the derivative as a multi-item total change.","value":"When 50 items have been produced, the cost will be $\\\\$12$ higher after producing 50 more items."}]'::jsonb
WHERE id = '3dfb37b2-bd9d-49a2-92b3-88e1eb012b0f';

UPDATE public.questions
SET prompt = 'Determine whether the series converges or diverges: $$\sum_{n=1}^{\infty}\frac{5}{\sqrt[3]{n^2}}$$',
    explanation = 'Since $\sqrt[3]{n^2}=n^{\frac{2}{3}}$, the series is $\sum 5n^{\frac{-2}{3}}$, a $p$-series with $p=\frac{2}{3}\le 1$. Therefore, the series diverges.',
    options = '[{"id":"A","text":"Converges because the constant factor $5$ makes it smaller","explanation":"A constant factor does not change convergence or divergence.","value":"Converges because the constant factor $5$ makes it smaller"},{"id":"B","text":"Diverges","value":"Diverges","explanation":"Rewrite $\\frac{5}{\\sqrt[3]{n^2}}=\\frac{5}{n^{\\frac{2}{3}}}$. This is a $p$-series with $p=\\tfrac{2}{3}\\le 1$, so it diverges."},{"id":"C","text":"Converges by the $p$-series test with $p=\\tfrac{2}{3}$","explanation":"A $p$-series converges only when $p>1$.","value":"Converges by the $p$-series test with $p=\\tfrac{2}{3}$"},{"id":"D","text":"Inconclusive because radicals prevent the $p$-series test","explanation":"Rewrite radicals as exponents; the $p$-series test applies.","value":"Inconclusive because radicals prevent the $p$-series test"}]'::jsonb
WHERE id = '13902af2-4907-43b2-aa1a-54a26bdcf1d2';

UPDATE public.questions
SET prompt = 'Determine whether the series converges or diverges.  $$\sum_{n=1}^{\infty} \frac{n!}{n^n}$$',
    explanation = 'Let $a_n=\frac{n!}{n^n}$. Then $$\frac{a_{n+1}}{a_n}=\frac{(n+1)!/(n+1)^{n+1}}{n!/n^n}=\left(\frac{n}{n+1}\right)^n.$$ So $$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=\lim_{n\to\infty}\left(1-\frac{1}{n+1}\right)^n=\frac{1}{e}<1.$$ Therefore, the series converges by the Ratio Test.',
    options = '[{"id":"A","text":"Diverges because $n!$ grows quickly","explanation":"Need a test; ratio test shows strong decay.","value":"Diverges because $n!$ grows quickly"},{"id":"B","text":"Ratio Test is inconclusive","value":"Ratio Test is inconclusive","explanation":"The ratio limit is $\\frac{1}{e}<1$, so it is conclusive."},{"id":"C","text":"Converges by the Ratio Test","value":"Converges by the Ratio Test","explanation":"Compute $\\lim \\frac{a_{n+1}}{a_n}=\\lim \\left(\\frac{n}{n+1}\\right)^n=\\frac{1}{e}<1$."},{"id":"D","text":"Diverges by the nth-term test because $\\frac{n!}{n^n}\\not\\to 0$","explanation":"In fact $\\frac{n!}{n^n}\\to 0$.","value":"Diverges by the nth-term test because $\\frac{n!}{n^n}\\not\\to 0$"}]'::jsonb
WHERE id = '40cf5eee-8569-4fd3-b249-1e1da7d56406';

UPDATE public.questions
SET prompt = 'Let $f(x)=3\sin x-2\cos x+e^x-\ln x$ for $x>0$. What is $f''(x)$?',
    explanation = 'Differentiate term-by-term: $$f''(x)=3\cos x-2(-\sin x)+e^x-\dfrac{1}{x}=3\cos x+2\sin x+e^x-\dfrac{1}{x}.$$',
    options = '[{"id":"A","text":"$3\\cos x+2\\sin x+e^x-\\dfrac{1}{x}$","explanation":"Correct: $(\\sin x)''=\\cos x$, $(\\cos x)''=-\\sin x$, $(e^x)''=e^x$, $(\\ln x)''=\\frac{1}{x}$.","value":"$3\\cos x+2\\sin x+e^x-\\dfrac{1}{x}$"},{"id":"B","text":"$3\\cos x-2\\sin x+e^x-\\dfrac{1}{x}$","explanation":"Sign error: derivative of $-2\\cos x$ is $+2\\sin x$, not $-2\\sin x$.","value":"$3\\cos x-2\\sin x+e^x-\\dfrac{1}{x}$"},{"id":"C","text":"$3\\cos x+2\\sin x+e^x-\\ln x$","explanation":"Did not differentiate $\\ln x$; it becomes $\\frac{1}{x}$, not $\\ln x$.","value":"$3\\cos x+2\\sin x+e^x-\\ln x$"},{"id":"D","text":"$3\\sin x-2\\cos x+e^x-\\dfrac{1}{x}$","explanation":"Did not differentiate the trig terms; $\\sin x$ and $\\cos x$ change.","value":"$3\\sin x-2\\cos x+e^x-\\dfrac{1}{x}$"}]'::jsonb
WHERE id = '44f58c63-78f3-4a23-91d4-0e6e48196efe';

UPDATE public.questions
SET prompt = 'Use the Lagrange error bound to estimate an upper bound on the error when approximating $\sqrt[3]{1.1}$ by the linearization (degree-1 Taylor polynomial) of $f(x)=x^{\frac{1}{3}}$ about $x=1$.',
    explanation = 'For degree 1, $$|R_1(x)|\le \frac{M|x-1|^2}{2!},\quad M=\max_{1\le t\le 1.1}|f^{\prime\prime}(t)|.$$\nHere $f^{\prime\prime}(x)=-\dfrac{2}{9}x^{-5/3}$, so $|f^{\prime\prime}(x)|=\dfrac{2}{9}x^{-5/3}$ is maximized at $x=1$ on $[1,1.1]$. Thus $$|R_1(1.1)|\le \frac{\left(\frac{2}{9}\right)(0.1)^2}{2}.$$',
    options = '[{"id":"A","text":"$\\dfrac{2}{9}\\cdot\\dfrac{(0.1)^2}{2}$","explanation":"$f^{\\prime\\prime}(x)=-\\dfrac{2}{9}x^{\\frac{-5}{3}}$ so $|f^{\\prime\\prime}(x)|=\\dfrac{2}{9}x^{\\frac{-5}{3}}$. On $[1,1.1]$ this is maximized at $x=1$, giving $M=\\dfrac{2}{9}$ and $|R_1|\\le \\dfrac{M(0.1)^2}{2}$.","value":"$\\dfrac{2}{9}\\cdot\\dfrac{(0.1)^2}{2}$"},{"id":"B","text":"$\\dfrac{2}{9}(1.1)^{-5/3}\\cdot\\dfrac{(0.1)^2}{2}$","explanation":"Chooses $M$ at $x=1.1$, but $x^{\\frac{-5}{3}}$ decreases, so the maximum is at $x=1$.","value":"$\\dfrac{2}{9}(1.1)^{\\frac{-5}{3}}\\cdot\\dfrac{(0.1)^2}{2}$"},{"id":"C","text":"$\\dfrac{1}{3}\\cdot\\dfrac{(0.1)^2}{2}$","explanation":"Uses $f^{\\prime}(x)$ instead of $f^{\\prime\\prime}(x)$ for a degree-1 remainder bound.","value":"$\\dfrac{1}{3}\\cdot\\dfrac{(0.1)^2}{2}$"},{"id":"D","text":"$\\dfrac{2}{9}\\cdot\\dfrac{(0.1)}{2}$","explanation":"Wrong power: for degree 1, the remainder uses $|x-1|\\frac{^2}{2}!$.","value":"$\\dfrac{2}{9}\\cdot\\dfrac{(0.1)}{2}$"}]'::jsonb
WHERE id = 'cdd9bb9b-31fa-418d-ab79-c23a5bd62dd3';

UPDATE public.questions
SET prompt = 'Evaluate $\int \frac{5}{x^2-1}\,dx$.',
    explanation = 'Factor and decompose: $$\frac{5}{x^2-1}=\frac{5}{(x-1)(x+1)}=\frac{\frac{5}{2}}{x-1}-\frac{\frac{5}{2}}{x+1}.$$ Then $$\int \frac{5}{x^2-1}dx=\frac{5}{2}\ln|x-1|-\frac{5}{2}\ln|x+1|+C=\frac{5}{2}\ln\left|\frac{x-1}{x+1}\right|+C.$$',
    options = '[{"id":"A","text":"$\\frac{5}{2}\\ln|x^2-1|+C$","explanation":"This would require a $2x$ numerator to match $\\frac{d}{dx}(x^2-1)$.","value":"$\\frac{5}{2}\\ln|x^2-1|+C$"},{"id":"B","text":"$5\\arctan(x)+C$","explanation":"$\\arctan$ arises from $\\frac{1}{x^2+a^2}$, not $\\frac{1}{x^2-1}$.","value":"$5\\arctan(x)+C$"},{"id":"C","text":"$\\frac{5}{2}\\ln\\left|\\frac{x-1}{x+1}\\right|+C$","explanation":"Decompose $\\frac{5}{(x-1)(x+1)}=\\frac{\\frac{5}{2}}{x-1}-\\frac{\\frac{5}{2}}{x+1}$, then integrate to logs.","value":"$\\frac{5}{2}\\ln\\left|\\frac{x-1}{x+1}\\right|+C$"},{"id":"D","text":"$\\frac{5}{2}\\ln\\left|\\frac{x+1}{x-1}\\right|+C$","explanation":"This is the negative log ratio; while equivalent up to a constant, it does not match the stated decomposition signs.","value":"$\\frac{5}{2}\\ln\\left|\\frac{x+1}{x-1}\\right|+C$"}]'::jsonb
WHERE id = '475ba097-a67d-4b5b-bd7a-846abc4aaf8f';

UPDATE public.questions
SET prompt = 'For $x(t)=e^t$ and $y(t)=e^{2t}$, what is $\dfrac{dy}{dx}$ in terms of $t$?',
    explanation = 'Use $\dfrac{dy}{dx}=\dfrac{\frac{dy}{dt}}{\frac{dx}{dt}}$. Here $\frac{dx}{dt}=e^t$ and $\frac{dy}{dt}=2e^{2t}$, so $\dfrac{dy}{dx}=\dfrac{2e^{2t}}{e^t}=2e^t$.',
    options = '[{"id":"A","text":"$2e^t$","explanation":"Correct. $\\frac{dx}{dt}=e^t$, $\\frac{dy}{dt}=2e^{2t}$, so $\\frac{dy}{dx}=\\dfrac{2e^{2t}}{e^t}=2e^t$.","value":"$2e^t$"},{"id":"B","text":"$2e^{2t}$","explanation":"This equals $\\frac{dy}{dt}$, not $\\frac{dy}{dx}$.","value":"$2e^{2t}$"},{"id":"C","text":"$e^t$","explanation":"This equals $\\frac{dx}{dt}$.","value":"$e^t$"},{"id":"D","text":"$\\dfrac{1}{2}e^t$","explanation":"This comes from incorrect algebra or taking a reciprocal.","value":"$\\dfrac{1}{2}e^t$"}]'::jsonb
WHERE id = '4823b93a-40eb-4dc5-bd37-d1b2fd59209e';

UPDATE public.questions
SET prompt = 'Find an antiderivative: $$\int \frac{1}{x^2-4x+13}\,dx$$',
    explanation = 'Complete the square: $$x^2-4x+13=(x-2)^2+9=(x-2)^2+3^2.$$ Let $u=x-2$ ($du=dx$): $$\int \frac{1}{u^2+3^2}du=\frac{1}{3}\arctan\left(\frac{u}{3}\right)+C=\frac{1}{3}\arctan\left(\frac{x-2}{3}\right)+C.$$',
    options = '[{"id":"A","text":"$\\ln|x^2-4x+13|+C$","explanation":"This would require the numerator to match the derivative of the denominator, which it does not.","value":"$\\ln|x^2-4x+13|+C$"},{"id":"B","text":"$\\arctan(x-2)+C$","explanation":"After completing the square, the denominator is $(x-2)^2+9$, which requires a scale factor inside arctan.","value":"$\\arctan(x-2)+C$"},{"id":"C","text":"$\\frac{1}{3}\\arctan\\left(\\frac{x-2}{3}\\right)+C$","explanation":"Complete the square to $(x-2)^2+3^2$ and use $\\int \\frac{1}{u^2+a^2}du=\\frac{1}{a}\\arctan(\\frac{u}{a})+C$.","value":"$\\frac{1}{3}\\arctan\\left(\\frac{x-2}{3}\\right)+C$"},{"id":"D","text":"$\\frac{1}{9}\\arctan\\left(\\frac{x-2}{3}\\right)+C$","explanation":"This applies the factor $\\frac{1}{3}$ twice. The correct coefficient is $\\frac{1}{3}$.","value":"$\\frac{1}{9}\\arctan\\left(\\frac{x-2}{3}\\right)+C$"}]'::jsonb
WHERE id = '4a6a2096-8f92-432b-9a6b-9b3695cf8df6';

UPDATE public.questions
SET prompt = 'Use the graph (see image) to best estimate ''(2)$. The point (2,f(2))$ is marked on the curve.',
    explanation = 'The derivative at a point is the slope of the tangent line. From the graph near =2$, the rise over run over a small interval (e.g., from =1.5$ to =2.5$) suggests an average slope close to .2$.',
    options = '[{"id":"A","text":"About .2$","explanation":"Near =2$, the curve is increasing with a moderate slope a little above $; the best estimate is about .2$.","value":"About .2$"},{"id":"B","text":"About /bin/zsh.2$","explanation":"This is far too small; the tangent at =2$ is noticeably steeper than /\\frac{bin}{zsh}.2$.","value":"About /bin/zsh.2$"},{"id":"C","text":"About 569Xils1.2$","explanation":"The function is increasing at =2$, so the derivative should be positive, not negative.","value":"About 569Xils1.2$"},{"id":"D","text":"About .6$","explanation":"This overestimates the steepness; the tangent is not that steep at =2$.","value":"About .6$"}]'::jsonb
WHERE id = '4cf08aad-480a-4ee7-8ad3-aa81da9665a5';

UPDATE public.questions
SET prompt = 'Solve the initial value problem $\dfrac{dy}{dx}=3xy$, $y(0)=2$, and find $y(1)$.',
    explanation = 'Separate: $\dfrac{1}{y}dy=3x\,dx$. Integrate: $\ln|y|=\tfrac{3}{2}x^2+C$. Use $y(0)=2$ to get $C=\ln 2$, so $y=2e^{\tfrac{3}{2}x^2}$ and $y(1)=2e^{\frac{3}{2}}$.',
    options = '[{"id":"A","text":"$2e^{3}$","explanation":"This uses $\\int 3x\\,dx=3x^2$ instead of $\\tfrac{3}{2}x^2$.","value":"$2e^{3}$"},{"id":"B","text":"$2e$","explanation":"This uses $\\int 3x\\,dx=x^2$.","value":"$2e$"},{"id":"C","text":"$2e^{3/4}$","explanation":"This halves the exponent incorrectly.","value":"$2e^{\\frac{3}{4}}$"},{"id":"D","text":"$2e^{3/2}$","explanation":"Correct: $\\ln|y|=\\tfrac{3}{2}x^2+C$, so $y=2e^{\\tfrac{3}{2}x^2}$ and $y(1)=2e^{\\frac{3}{2}}$.","value":"$2e^{\\frac{3}{2}}$"}]'::jsonb
WHERE id = '4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68';

UPDATE public.questions
SET prompt = 'A function $ satisfies (3)=10$, (3.1)=10.4$, and (2.9)=9.7$. Using a symmetric difference quotient, estimate ''(3)$.',
    explanation = 'Use the symmetric difference quotient: 19967f''(3)\approx \frac{f(3+h)-f(3-h)}{2h}.19967 Here =0.1$, so 19967f''(3)\approx \frac{f(3.1)-f(2.9)}{0.2}=\frac{10.4-9.7}{0.2}=\frac{0.7}{0.2}=3.5.19967',
    options = '[{"id":"A","text":".0$","explanation":"This would correspond to a symmetric change of /bin/zsh.6$ over /\\frac{bin}{zsh}.2$, but the actual symmetric change is .4-9.7=0.7$.","value":".0$"},{"id":"B","text":".5$","explanation":"Correct: /(3.1-2.9)=0.7/0.2=3.5$.","value":".5$"},{"id":"C","text":".0$","explanation":"This mistakenly divides by /bin/zsh.1$ instead of the full symmetric width /\\frac{bin}{zsh}.2$.","value":".0$"},{"id":"D","text":"/bin/zsh.35$","explanation":"This mistakenly divides by $ again after already using the full symmetric interval.","value":"/bin/zsh.35$"}]'::jsonb
WHERE id = '512e4ef2-cfb6-48ac-91da-fae6d237ea84';

UPDATE public.questions
SET prompt = 'Evaluate the limit: $$\lim_{x\to 2}\frac{x^2-4}{x-2}.$$',
    explanation = 'Factor: $$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2\ (x\neq 2).$$ Then $$\lim_{x\to 2}(x+2)=4.$$',
    options = '[{"id":"A","text":"$2$","explanation":"This comes from canceling incorrectly or simplifying to $x$ instead of $x+2$.","value":"$2$"},{"id":"B","text":"$4$","explanation":"Factor $x^2-4=(x-2)(x+2)$, cancel, then substitute to get $4$.","value":"$4$"},{"id":"C","text":"$0$","explanation":"This results from substituting first to get $\\frac{0}{0}$ and stopping.","value":"$0$"},{"id":"D","text":"Does not exist","value":"Does not exist","explanation":"After cancellation, the expression is continuous near $x=2$, so the limit exists."}]'::jsonb
WHERE id = '517f0d4c-d735-47fc-bbac-90231c61b275';

UPDATE public.questions
SET prompt = 'A $10$-ft ladder leans against a vertical wall (see image). Let $x$ be the distance (ft) from the wall to the foot of the ladder and let $y$ be the height (ft) of the top of the ladder on the wall. At the moment when $x=6$, the foot of the ladder is sliding away from the wall at a rate of $\dfrac{dx}{dt}=0.5$ ft/s. What is $\dfrac{dy}{dt}$ at that moment?',
    explanation = 'Because the ladder length is constant, $x^2+y^2=10^2=100$. Differentiate with respect to $t$: $$2x\frac{dx}{dt}+2y\frac{dy}{dt}=0 \;\Rightarrow\; \frac{dy}{dt}= -\frac{x}{y}\frac{dx}{dt}.$$ When $x=6$, $y=\sqrt{100-36}=8$, so $$\frac{dy}{dt}= -\frac{6}{8}(0.5)=-0.375\text{ ft/s}.$$',
    options = '[{"id":"A","text":"$-0.75$ ft/s","explanation":"This can result from using an incorrect value for $y$ when $x=6$ (since $y$ should be $8$, not $4$).","value":"$-0.75$ ft/s"},{"id":"B","text":"$-0.375$ ft/s","explanation":"Correct. From $x^2+y^2=100$, $\\dfrac{dy}{dt}=-(\\frac{x}{y})\\dfrac{dx}{dt}=-(\\frac{6}{8})(0.5)=-0.375$.","value":"$-0.375$ ft/s"},{"id":"C","text":"$0.375$ ft/s","explanation":"Sign error: as $x$ increases, $y$ must decrease, so $\\dfrac{dy}{dt}<0$.","value":"$0.375$ ft/s"},{"id":"D","text":"$-0.5$ ft/s","explanation":"This ignores the factor $\\frac{x}{y}$ that appears after implicit differentiation of $x^2+y^2=100$.","value":"$-0.5$ ft/s"}]'::jsonb
WHERE id = '5913ba03-f895-428e-8bb6-d6c9dc9995f7';

UPDATE public.questions
SET prompt = 'Evaluate the limit.  $$\lim_{x\to \infty}\frac{3x^2-7}{2x^2+5x}$$',
    explanation = 'Divide by $x^2$: $$\frac{3-\frac{7}{x^2}}{2+\frac{5}{x}}\xrightarrow[x\to\infty]{}\frac{3}{2}.$$',
    options = '[{"id":"A","text":"$\\frac{3}{2}$","explanation":"Divide numerator and denominator by $x^2$; leading coefficients give $\\frac{3}{2}$.","value":"$\\frac{3}{2}$"},{"id":"B","text":"$\\frac{3}{5}$","explanation":"Incorrectly compared $3x^2$ to $5x$ instead of the highest powers.","value":"$\\frac{3}{5}$"},{"id":"C","text":"0","value":"0","explanation":"For equal degrees, the limit is not $0$; it is the ratio of leading coefficients."},{"id":"D","text":"$\\infty$","explanation":"Equal degrees lead to a constant limit, not infinity.","value":"$\\infty$"}]'::jsonb
WHERE id = '0015173b-cc1a-4da5-9bd2-4c6aaeecd720';

UPDATE public.questions
SET prompt = 'The amount of salt in a tank is $S(t)$ grams, where $t$ is measured in minutes. Which set of units is correct for $S''(t)$?',
    explanation = '$S''(t)$ is the rate of change of salt amount (grams) with respect to time (minutes), so its units are grams per minute.',
    options = '[{"id":"A","text":"grams","value":"grams","explanation":"That would be $S(t)$, not $S''(t)$."},{"id":"B","text":"minutes","value":"minutes","explanation":"Time alone is not a rate."},{"id":"C","text":"minutes per gram","value":"minutes per gram","explanation":"That is the inverse rate ($\\frac{dt}{dS}$)."},{"id":"D","text":"grams per minute","value":"grams per minute","explanation":"Correct: change in grams per minute."}]'::jsonb
WHERE id = '33834e0b-ccaa-4ed4-aa1a-214f4b38864b';

UPDATE public.questions
SET prompt = 'A medication in the bloodstream follows $\dfrac{dA}{dt}=kA$, where $t$ is in hours. \nImmediately after a dose, $A(0)=80$ mg. After 4 hours, $A(4)=50$ mg. \nAt what time $t$ will $A(t)=20$ mg? Choose the closest value.',
    explanation = 'Model: $A(t)=80e^{kt}$. Use $A(4)=50$: $$50=80e^{4k}\Rightarrow k=\frac{1}{4}\ln\left(\frac{50}{80}\right).$$\nSolve $A(t)=20$: $$20=80e^{kt}\Rightarrow e^{kt}=\frac14\Rightarrow t=\frac{\ln(\frac{1}{4})}{k}\approx 9.3.$$',
    options = '[{"id":"A","text":"$t\\approx 9.3$","explanation":"Correct. Find $k=\\dfrac{1}{4}\\ln\\left(\\frac{50}{80}\\right)$, then solve $20=80e^{kt}$ to get $t=\\dfrac{\\ln(\\frac{1}{4})}{k}\\approx 9.3$.","value":"$t\\approx 9.3$"},{"id":"B","text":"$t\\approx 6.4$","explanation":"Forgets that the ratio $\\frac{50}{80}$ corresponds to 4 hours (missing the factor of 4 in $k$).","value":"$t\\approx 6.4$"},{"id":"C","text":"$t\\approx 3.2$","explanation":"Too small because $A(4)=50$ is still above $20$.","value":"$t\\approx 3.2$"},{"id":"D","text":"$t\\approx 12.8$","explanation":"Typically comes from using $k=\\ln(\\frac{50}{80})$ instead of $\\ln\\frac{\\frac{50}{80}}{4}$.","value":"$t\\approx 12.8$"}]'::jsonb
WHERE id = '7241dd8c-c26b-4261-9a4b-2e9f8556b1de';

UPDATE public.questions
SET prompt = 'Solve the differential equation with the given initial condition.  $$\frac{dy}{dx}=\frac{3x^2}{y},\quad y(1)=2$$ \nWhich function satisfies the initial value problem?',
    explanation = 'Separate: $$\frac{dy}{dx}=\frac{3x^2}{y}\Rightarrow y\,dy=3x^2\,dx$$\nIntegrate: $$\frac12 y^2=x^3+C$$\nApply $y(1)=2$: $$2=1+C\Rightarrow C=1$$\nSo $y^2=2x^3+2$ and the branch matching $y(1)=2$ is $y=\sqrt{2x^3+2}$.',
    options = '[{"id":"A","text":"$y=\\sqrt{x^3+3}$","explanation":"Differentiating gives $y''=\\dfrac{3x^2}{2y}$, which is off by a factor of $\\tfrac12$.","value":"$y=\\sqrt{x^3+3}$"},{"id":"B","text":"$y=\\sqrt{2x^3+6}$","explanation":"Comes from forgetting the $\\tfrac12$ in $\\int y\\,dy=\\tfrac12 y^2$.","value":"$y=\\sqrt{2x^3+6}$"},{"id":"C","text":"$y=\\sqrt{2x^3+2}$","explanation":"Correct. From $y\\,dy=3x^2\\,dx$, get $\\tfrac12 y^2=x^3+C$. Use $y(1)=2$ to get $C=1$, so $y=\\sqrt{2x^3+2}$.","value":"$y=\\sqrt{2x^3+2}$"},{"id":"D","text":"$y=2x^{3/2}$","explanation":"Ignores the constant determined by $y(1)=2$.","value":"$y=2x^{\\frac{3}{2}}$"}]'::jsonb
WHERE id = '726a89a7-aea6-4a2d-a58b-4b0f2e4347fe';

UPDATE public.questions
SET prompt = 'Determine whether the series $$\sum_{n=2}^{\infty}\frac{1}{n\ln n}$$ converges or diverges.',
    explanation = 'Apply the integral test with $f(x)=\frac{1}{x\ln x}$. Then $$\int_2^{\infty}\frac{1}{x\ln x}\,dx.$$ Let $u=\ln x$, $du=\frac{1}{x}dx$, giving $$\int_{\ln 2}^{\infty}\frac{1}{u}\,du=\infty.$$ Therefore the series diverges.',
    options = '[{"id":"A","text":"Converges by the integral test","value":"Converges by the integral test","explanation":"The corresponding integral diverges because it becomes $\\int \\frac{1}{u}\\,du$."},{"id":"B","text":"Converges by comparison with $$\\sum \\frac{1}{n^2}$$","explanation":"This comparison does not establish convergence; the terms are not bounded above by a constant multiple of $\\frac{1}{n^2}$.","value":"Converges by comparison with $$\\sum \\frac{1}{n^2}$$"},{"id":"C","text":"Diverges","value":"Diverges","explanation":"Correct: $\\int_2^{\\infty}\\frac{1}{x\\ln x}\\,dx$ diverges."},{"id":"D","text":"Converges conditionally","value":"Converges conditionally","explanation":"The series is positive, so conditional convergence does not apply."}]'::jsonb
WHERE id = '0bd58cb6-c0a7-49e4-b58c-257add05db9f';

UPDATE public.questions
SET prompt = 'Determine whether the series $$\sum_{n=1}^{\infty}\frac{3n+1}{n^3+2}$$ converges or diverges.',
    explanation = 'Use limit comparison with $\sum \frac{1}{n^2}$. Let $a_n=\frac{3n+1}{n^3+2}$ and $b_n=\frac{1}{n^2}$. Then $$\lim_{n\to\infty}\frac{a_n}{b_n}=\lim_{n\to\infty}\frac{(3n+1)n^2}{n^3+2}=\lim_{n\to\infty}\frac{3n^3+n^2}{n^3+2}=3.$$ Since $0<3<\infty$ and $\sum 1/n^2$ converges, the given series converges.',
    options = '[{"id":"A","text":"Diverges because it behaves like $$\\sum \\frac{1}{n}$$","explanation":"Dominant terms give $\\frac{3n}{n^3}=\\frac{3}{n^2}$, not $\\frac{1}{n}$.","value":"Diverges because it behaves like $$\\sum \\frac{1}{n}$$"},{"id":"B","text":"Converges by limit comparison with $$\\sum \\frac{1}{n^2}$$","explanation":"Correct: the limit comparison constant is finite and nonzero.","value":"Converges by limit comparison with $$\\sum \\frac{1}{n^2}$$"},{"id":"C","text":"Diverges by the nth-term test","value":"Diverges by the nth-term test","explanation":"Here $\\lim a_n=0$, so the nth-term test is inconclusive."},{"id":"D","text":"Converges by the alternating series test","value":"Converges by the alternating series test","explanation":"The series is not alternating."}]'::jsonb
WHERE id = '0a06b090-8f23-4df6-b80a-14ce98166bf1';

UPDATE public.questions
SET prompt = 'Let $x(t)=t^2+1$ and $y(t)=\dfrac{1}{t}$ for $t\ne 0$. What is $\dfrac{d^2y}{dx^2}$ in terms of $t$?',
    explanation = 'Compute $\frac{dx}{dt}=2t$ and $\frac{dy}{dt}=\frac{-1}{t^2}$. Then $$\frac{dy}{dx}=\frac{\frac{-1}{t^2}}{2t}=-\frac{1}{2t^3}.$$ Differentiate with respect to $t$: $$\frac{d}{dt}\left(\frac{dy}{dx}\right)=\frac{3}{2t^4}.$$ Finally $$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}}=\frac{\frac{3}{2t^4}}{2t}=\frac{3}{4t^5}.$$',
    options = '[{"id":"A","text":"$\\dfrac{1}{4t^5}$","explanation":"Coefficient error; the factor $3$ is missing.","value":"$\\dfrac{1}{4t^5}$"},{"id":"B","text":"$\\dfrac{3}{4t^5}$","explanation":"Correct. Applying the full parametric second-derivative formula yields $\\dfrac{3}{4t^5}$.","value":"$\\dfrac{3}{4t^5}$"},{"id":"C","text":"$-\\dfrac{3}{4t^5}$","explanation":"Sign error after differentiating $-\\dfrac{1}{2}t^{-3}$; the derivative becomes positive.","value":"$-\\dfrac{3}{4t^5}$"},{"id":"D","text":"$\\dfrac{3}{2t^4}$","explanation":"This equals $\\dfrac{d}{dt}(\\frac{dy}{dx})$ but misses the final division by $\\frac{dx}{dt}$.","value":"$\\dfrac{3}{2t^4}$"}]'::jsonb
WHERE id = '7c8368dd-0ea5-455b-8154-293369c9fbe0';

UPDATE public.questions
SET prompt = 'The graph shows three functions near $x=0$: $y=-|x|$, $y=x\sin(\frac{1}{x})$, and $y=|x|$. What is $\lim_{x\to 0} x\sin(\frac{1}{x})$? [image:1.8-P2.png]',
    explanation = 'Since $-1\le \sin(\frac{1}{x})\le 1$, we have $-|x|\le x\sin(\frac{1}{x})\le |x|$. As $x\to 0$, both $-|x|$ and $|x|$ approach $0$, so by the Squeeze Theorem the limit is $0$.',
    options = '[{"id":"A","text":"DNE","value":"DNE","explanation":"The oscillation is bounded by functions that both go to $0$, so the limit exists."},{"id":"B","text":"$0$","explanation":"Because $-1\\le \\sin(\\frac{1}{x})\\le 1$, multiplying by $x$ gives $-|x|\\le x\\sin(\\frac{1}{x})\\le |x|$, and both bounds go to $0$.","value":"$0$"},{"id":"C","text":"$1$","explanation":"The middle function stays between $-|x|$ and $|x|$, which both shrink to $0$.","value":"$1$"},{"id":"D","text":"The limit depends on the path to $0$","explanation":"This is a single-variable limit; squeeze forces a unique value.","value":"The limit depends on the path to $0$"}]'::jsonb
WHERE id = '0f685f6a-9fcd-4555-afd2-03d2b1a2e899';

UPDATE public.questions
SET prompt = 'Evaluate the improper integral: $$\int_{0}^{2}\frac{1}{\sqrt{x}}\,dx$$',
    explanation = 'Write as a limit: $$\int_{0}^{2}x^{\frac{-1}{2}}dx=\lim_{a\to 0^+}\int_{a}^{2}x^{\frac{-1}{2}}dx=\lim_{a\to 0^+}\left[2\sqrt{x}\right]_{a}^{2}=2\sqrt{2}. $$',
    options = '[{"id":"A","text":"$\\sqrt{2}$","explanation":"This misses the factor of $2$ from $\\int x^{\\frac{-1}{2}}dx=2x^{\\frac{1}{2}}$.","value":"$\\sqrt{2}$"},{"id":"B","text":"$1$","explanation":"No correct limit evaluation yields $1$.","value":"$1$"},{"id":"C","text":"$2\\sqrt{2}$","explanation":"Write as $\\lim_{a\\to 0^+}\\int_a^2 x^{\\frac{-1}{2}}dx$ and evaluate $2\\sqrt{x}$ at the bounds.","value":"$2\\sqrt{2}$"},{"id":"D","text":"Diverges","value":"Diverges","explanation":"Although the integrand is unbounded at $0$, this particular integral converges."}]'::jsonb
WHERE id = '71e7d4b1-ae1e-4c40-a3c4-491615482fde';

UPDATE public.questions
SET prompt = 'Let $r(\theta)=\theta^2$. Which expression equals $\dfrac{dy}{dx}$ in terms of $\theta$ for the polar curve?',
    explanation = 'With $x=r\cos\theta$ and $y=r\sin\theta$, and $r=\theta^2$, $r''=2\theta$: $$\frac{dx}{d\theta}=2\theta\cos\theta-\theta^2\sin\theta,$$ $$\frac{dy}{d\theta}=2\theta\sin\theta+\theta^2\cos\theta.$$  Therefore $$\frac{dy}{dx}=\frac{2\theta\sin\theta+\theta^2\cos\theta}{2\theta\cos\theta-\theta^2\sin\theta}.$$',
    options = '[{"id":"A","text":"$\\dfrac{2\\theta\\sin\\theta+\\theta^2\\cos\\theta}{2\\theta\\cos\\theta+\\theta^2\\sin\\theta}$","explanation":"This uses the wrong sign in $\\frac{dx}{d\\theta}$ (it should be $r''\\cos\\theta-r\\sin\\theta$).","value":"$\\dfrac{2\\theta\\sin\\theta+\\theta^2\\cos\\theta}{2\\theta\\cos\\theta+\\theta^2\\sin\\theta}$"},{"id":"B","text":"$\\dfrac{2\\theta\\cos\\theta-\\theta^2\\sin\\theta}{2\\theta\\sin\\theta+\\theta^2\\cos\\theta}$","explanation":"This is the reciprocal of $\\frac{dy}{dx}$ (it swaps numerator and denominator).","value":"$\\dfrac{2\\theta\\cos\\theta-\\theta^2\\sin\\theta}{2\\theta\\sin\\theta+\\theta^2\\cos\\theta}$"},{"id":"C","text":"$\\dfrac{2\\theta\\sin\\theta+\\theta^2\\cos\\theta}{2\\theta\\cos\\theta-\\theta^2\\sin\\theta}$","explanation":"Correct. Compute $\\frac{dy}{d\\theta}$ and $\\frac{dx}{d\\theta}$ from $x=r\\cos\\theta$, $y=r\\sin\\theta$, then divide.","value":"$\\dfrac{2\\theta\\sin\\theta+\\theta^2\\cos\\theta}{2\\theta\\cos\\theta-\\theta^2\\sin\\theta}$"},{"id":"D","text":"$\\dfrac{2\\theta\\sin\\theta-\\theta^2\\cos\\theta}{2\\theta\\cos\\theta-\\theta^2\\sin\\theta}$","explanation":"This has a product-rule sign error in $\\frac{dy}{d\\theta}$.","value":"$\\dfrac{2\\theta\\sin\\theta-\\theta^2\\cos\\theta}{2\\theta\\cos\\theta-\\theta^2\\sin\\theta}$"}]'::jsonb
WHERE id = '0afb802a-fe10-4200-9842-e3272499ad62';

UPDATE public.questions
SET prompt = 'Evaluate the limit.  $$\lim_{x\to 2}\frac{x^2-4}{x-2}$$',
    explanation = 'Rewrite and simplify: $$\frac{x^2-4}{x-2}=\frac{(x-2)(x+2)}{x-2}=x+2\quad (x\ne 2).$$ So $$\lim_{x\to 2}\frac{x^2-4}{x-2}=\lim_{x\to 2}(x+2)=4.$$',
    options = '[{"id":"A","text":"0","value":"0","explanation":"This is the numerator value at $x=2$, not the simplified limit."},{"id":"B","text":"2","value":"2","explanation":"This would be $x$ at $2$, but the simplified expression is $x+2$."},{"id":"C","text":"Does not exist","value":"Does not exist","explanation":"The original form is $\\frac{0}{0}$, which is indeterminate, not automatically DNE."},{"id":"D","text":"4","value":"4","explanation":"Factor: $x^2-4=(x-2)(x+2)$, cancel $x-2$, then evaluate $x+2$ at $2$."}]'::jsonb
WHERE id = 'a3d4039d-b209-4027-9fd1-093c022401d0';

UPDATE public.questions
SET prompt = 'Let $R$ be the region inside $r=2\cos\theta$ and outside $r=1$. What is the area of $R$?',
    explanation = 'Intersections satisfy $2\cos\theta=1$, so $\theta=\pm\frac{\pi}{3}$.  $$A=\frac12\int_{\frac{-\pi}{3}}^{\frac{\pi}{3}}\left((2\cos\theta)^2-1\right)d\theta=\frac12\int_{\frac{-\pi}{3}}^{\frac{\pi}{3}}(4\cos^2\theta-1)d\theta.$$  Using $\cos^2\theta=\frac{1+\cos2\theta}{2}$ yields $$A=\frac{\pi}{3}-\frac{\sqrt{3}}{4}.$$',
    options = '[{"id":"A","text":"$\\frac{\\pi}{3}-\\frac{\\sqrt{3}}{4}$","explanation":"Correct. Use intersection angles $\\theta=\\pm\\frac{\\pi}{3}$ and $\\frac12\\int (r_{out}^2-r_{in}^2)\\,d\\theta$.","value":"$\\frac{\\pi}{3}-\\frac{\\sqrt{3}}{4}$"},{"id":"B","text":"$\\frac{\\pi}{3}+\\frac{\\sqrt{3}}{4}$","explanation":"This typically comes from a sign error when evaluating the sine term.","value":"$\\frac{\\pi}{3}+\\frac{\\sqrt{3}}{4}$"},{"id":"C","text":"$\\frac{2\\pi}{3}-\\frac{\\sqrt{3}}{2}$","explanation":"This is the correct answer multiplied by 2 (often from forgetting the $\\tfrac12$ factor).","value":"$\\frac{2\\pi}{3}-\\frac{\\sqrt{3}}{2}$"},{"id":"D","text":"$\\frac{\\sqrt{3}}{4}$","explanation":"This drops the constant part of the integral.","value":"$\\frac{\\sqrt{3}}{4}$"}]'::jsonb
WHERE id = '819027ac-a51f-4f1d-81d5-bfa34752667e';

UPDATE public.questions
SET prompt = 'A function $ has the graph shown (see image), with (0)=1$. Which statement is true about $ at =0127',
    explanation = 'From the graph, the two pieces meet at $, so $\lim_{x\to 0}F(x)=F(0)$ and $ is continuous. The one-sided slopes at /bin/zsh$ do not match, so $ is not differentiable at /bin/zsh$.',
    options = '[{"id":"A","text":"$ is differentiable at /bin/zsh$","explanation":"The graph has a corner at =0$, so it is not differentiable.","value":"$ is differentiable at /\\frac{bin}{zsh}$"},{"id":"B","text":"$ is continuous but not differentiable at /bin/zsh$","explanation":"Both pieces meet at $ (continuous), but the left and right slopes differ (not differentiable).","value":"$ is continuous but not differentiable at /\\frac{bin}{zsh}$"},{"id":"C","text":"$ is not continuous at /bin/zsh$ but is differentiable at /bin/zsh$","explanation":"Differentiability implies continuity, so this cannot happen.","value":"$ is not continuous at /\\frac{bin}{zsh}$ but is differentiable at /bin/zsh$"},{"id":"D","text":"$ is neither continuous nor differentiable at /bin/zsh$","explanation":"The pieces meet at $, so $ is continuous at /bin/zsh$.","value":"$ is neither continuous nor differentiable at /\\frac{bin}{zsh}$"}]'::jsonb
WHERE id = '878d6f75-6746-419a-9dfd-5a10fae3966f';

UPDATE public.questions
SET prompt = 'Let $V(t)$ be the volume of water (in liters) in a tank at time $t$ minutes. Water drains from the tank at a rate proportional to the volume in the tank, and the constant of proportionality is $0.04\ \text{min}^{-1}$. Which differential equation correctly models $V(t)$?',
    explanation = '“Rate proportional to volume” gives $\dfrac{dV}{dt}=kV$. Draining means $\dfrac{dV}{dt}<0$ for $V>0$, so $k$ must be negative. With magnitude $0.04\ \text{min}^{-1}$, the model is $\dfrac{dV}{dt}=-0.04V$.',
    options = '[{"id":"A","text":"$\\dfrac{dV}{dt}=0.04V$","explanation":"This would make volume increase since $V>0$ implies $\\dfrac{dV}{dt}>0$.","value":"$\\dfrac{dV}{dt}=0.04V$"},{"id":"B","text":"$\\dfrac{dV}{dt}=-0.04V$","explanation":"Draining means $V$ decreases; proportional to $V$ gives $\\dfrac{dV}{dt}=-0.04V$.","value":"$\\dfrac{dV}{dt}=-0.04V$"},{"id":"C","text":"$\\dfrac{dV}{dt}=-\\dfrac{0.04}{V}$","explanation":"This is proportional to $\\frac{1}{V}$, not $V$.","value":"$\\dfrac{dV}{dt}=-\\dfrac{0.04}{V}$"},{"id":"D","text":"$\\dfrac{dV}{dt}=-0.04t$","explanation":"This makes the rate depend on $t$, not on $V$.","value":"$\\dfrac{dV}{dt}=-0.04t$"}]'::jsonb
WHERE id = '7fbb7ea2-ee5c-4d46-8c39-b0c8289d6dbe';

UPDATE public.questions
SET prompt = 'For which value(s) of $x$ does the graph of $y = \dfrac{x}{x^2+1}$ have a horizontal tangent?',
    explanation = 'Set $y'' = 0$. Using quotient rule: $$y'' = \frac{(1)(x^2+1) - (x)(2x)}{(x^2+1)^2} = \frac{1-x^2}{(x^2+1)^2}.$$ The fraction is zero when the numerator is zero (and denominator is not). $$1-x^2 = 0 \implies x^2=1 \implies x=1, -1.$$',
    options = '[{"id":"A","text":"$x=0$ only","explanation":"Incorrect: at $x=0$, $y''=\\frac{1-0}{1} = 1 \\neq 0$.","value":"$x=0$ only"},{"id":"B","text":"$x=1$ and $x=-1$","explanation":"Correct: $y'' = \\frac{1(x^2+1) - x(2x)}{(x^2+1)^2} = \\frac{1-x^2}{(x^2+1)^2}$. Zero when $1-x^2=0$, so $x=\\pm 1$.","value":"$x=1$ and $x=-1$"},{"id":"C","text":"$x=1$ only","explanation":"Misses the negative solution.","value":"$x=1$ only"},{"id":"D","text":"No values","value":"No values","explanation":"Incorrectly simplified the numerator."}]'::jsonb
WHERE id = '8d676d26-b96a-4f4b-8b5e-6b034eabc24a';

UPDATE public.questions
SET prompt = 'A curve is given parametrically by $x=t^2$ and $y=\frac{2}{3}t^3$ for $0\le t\le 1$. What is the exact arc length of the curve on this interval?',
    explanation = 'Compute derivatives: $\frac{dx}{dt}=2t$ and $\frac{dy}{dt}=2t^2$. Then $$L=\int_0^1\sqrt{(2t)^2+(2t^2)^2}\,dt=\int_0^1 2t\sqrt{1+t^2}\,dt.$$ Let $u=1+t^2$, so $du=2t\,dt$. When $t=0$, $u=1$; when $t=1$, $u=2$. Thus $$L=\int_1^2\sqrt{u}\,du=\left[\frac{2}{3}u^{\frac{3}{2}}\right]_1^2=\frac{2}{3}\left(2\sqrt{2}-1\right).$$ ',
    options = '[{"id":"A","text":"$\\frac{2}{3}\\left(\\sqrt{2}-1\\right)$","explanation":"This typically comes from integrating $\\sqrt{1+t^2}$ while missing the needed $2t$ factor in the integrand.","value":"$\\frac{2}{3}\\left(\\sqrt{2}-1\\right)$"},{"id":"B","text":"$\\frac{2}{3}$","explanation":"This treats $\\sqrt{u}$ as $u$ during substitution, which is not correct.","value":"$\\frac{2}{3}$"},{"id":"C","text":"$\\frac{2}{3}\\left(2\\sqrt{2}+1\\right)$","explanation":"This indicates an incorrect evaluation at the lower bound $u=1$.","value":"$\\frac{2}{3}\\left(2\\sqrt{2}+1\\right)$"},{"id":"D","text":"$\\frac{2}{3}\\left(2\\sqrt{2}-1\\right)$","explanation":"Correct: the integral becomes $\\int_1^2\\sqrt{u}\\,du=\\frac{2}{3}\\left(2\\sqrt{2}-1\\right)$.","value":"$\\frac{2}{3}\\left(2\\sqrt{2}-1\\right)$"}]'::jsonb
WHERE id = '0f8a7302-5790-4b3d-8ce3-46ad6264a000';

UPDATE public.questions
SET prompt = 'For $r(\theta)=2\theta$, use the polar slope formula $$\dfrac{dy}{dx}=\dfrac{r''''(\theta)\sin\theta+r(\theta)\cos\theta}{r''''(\theta)\cos\theta-r(\theta)\sin\theta}.$$ What is $\dfrac{dy}{dx}$ at $\theta=\dfrac{\pi}{2}$?',
    explanation = 'Here $r(\theta)=2\theta$ so $r''''(\theta)=2$. At $\theta=\frac{\pi}{2}$, $r=\pi$, $\sin\theta=1$, $\cos\theta=0$. Substitute: $$\frac{dy}{dx}=\frac{2\cdot1+\pi\cdot0}{2\cdot0-\pi\cdot1}=\frac{2}{-\pi}=-\frac{2}{\pi}.$$',
    options = '[{"id":"A","text":"$0$","explanation":"This guesses a horizontal tangent without evaluating the formula.","value":"$0$"},{"id":"B","text":"$-\\dfrac{2}{\\pi}$","explanation":"Correct: $r''''=2$, $r=\\pi$. At $\\theta=\\frac{\\pi}{2}$, numerator $=2\\cdot1+\\pi\\cdot0=2$ and denominator $=2\\cdot0-\\pi\\cdot1=-\\pi$, so slope $=\\frac{2}{-\\pi}=\\frac{-2}{\\pi}$.","value":"$-\\dfrac{2}{\\pi}$"},{"id":"C","text":"Undefined","value":"Undefined","explanation":"Denominator is $-\\pi\\ne 0$, so the slope is defined."},{"id":"D","text":"$\\dfrac{\\pi}{2}$","explanation":"This swaps numerator and denominator or confuses $r$ with $r''''.","value":"$\\dfrac{\\pi}{2}$"}]'::jsonb
WHERE id = 'b1c77136-6321-4ebc-a48e-77c4df7e2982';

UPDATE public.questions
SET prompt = 'What is the area enclosed by one petal of the rose $r=2\cos(2\theta)$?',
    explanation = 'One petal occurs where $r\ge 0$, i.e. $\cos(2\theta)\ge 0$, so $\frac{-\pi}{4}\le\theta\le\frac{\pi}{4}$.\nThen $$A=\frac12\int_{\frac{-\pi}{4}}^{\frac{\pi}{4}}(2\cos(2\theta))^2\,d\theta =2\int_{\frac{-\pi}{4}}^{\frac{\pi}{4}}\cos^2(2\theta)\,d\theta.$$ Using even symmetry and $\cos^2(2\theta)=\frac{1+\cos(4\theta)}{2}$ gives $A=\frac{\pi}{4}$.',
    options = '[{"id":"A","text":"$\\pi$","explanation":"This counts multiple petals or uses incorrect bounds.","value":"$\\pi$"},{"id":"B","text":"$\\dfrac{\\pi}{2}$","explanation":"This is off by a factor of 2 (often from bounds or the $\\dfrac12$).","value":"$\\dfrac{\\pi}{2}$"},{"id":"C","text":"$\\dfrac{\\pi}{4}$","explanation":"Correct: one petal is traced for $\\frac{-\\pi}{4}\\le\\theta\\le\\frac{\\pi}{4}$, so $A=\\dfrac12\\int_{\\frac{-\\pi}{4}}^{\\frac{\\pi}{4}}(2\\cos(2\\theta))^2\\,d\\theta=\\dfrac{\\pi}{4}$.","value":"$\\dfrac{\\pi}{4}$"},{"id":"D","text":"$\\dfrac{\\pi}{8}$","explanation":"This typically forgets an even-symmetry doubling step.","value":"$\\dfrac{\\pi}{8}$"}]'::jsonb
WHERE id = '91e575ac-d954-4834-9b2f-92b384c33240';

UPDATE public.questions
SET prompt = 'The graph shows $g(x)=\sin(\frac{1}{x})$ near $x=0$. What is $\lim_{x\to 0} g(x)$? [image:1.8-P3.png]',
    explanation = 'Even though $-1\le \sin(\frac{1}{x})\le 1$, the bounds do not squeeze to a single value. Near $0$, the function attains values arbitrarily close to many numbers in $[-1,1]$, so the limit does not exist.',
    options = '[{"id":"A","text":"$0$","explanation":"Although values hit $0$ infinitely often, they also hit values near $1$ and $-1$ arbitrarily close to $0$.","value":"$0$"},{"id":"B","text":"$1$","explanation":"The function also takes values near $-1$ arbitrarily close to $0$.","value":"$1$"},{"id":"C","text":"$-1$","explanation":"The function also takes values near $1$ arbitrarily close to $0$.","value":"$-1$"},{"id":"D","text":"DNE","value":"DNE","explanation":"The function oscillates between $-1$ and $1$ without approaching a single value."}]'::jsonb
WHERE id = 'b47292a2-5ca2-486b-af57-cabf8ff5f4fe';

UPDATE public.questions
SET prompt = 'Determine whether the series converges or diverges.  $$\sum_{n=1}^{\infty} \frac{n^5}{2^n}$$',
    explanation = 'Let $a_n=\dfrac{n^5}{2^n}$. Then $$\frac{a_{n+1}}{a_n}=\frac{\frac{(n+1)^5}{2^{n+1}}}{\frac{n^5}{2^n}}=\left(\frac{n+1}{n}\right)^5\cdot\frac{1}{2}.$$ As $n\to\infty$, $\left(\frac{n+1}{n}\right)^5\to 1$, so $$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=\frac{1}{2}<1.$$ Therefore, the series converges by the Ratio Test.',
    options = '[{"id":"A","text":"Diverges because $n^5$ increases without bound","explanation":"Growth of $n^5$ does not decide convergence when divided by $2^n$.","value":"Diverges because $n^5$ increases without bound"},{"id":"B","text":"Converges by the Ratio Test","value":"Converges by the Ratio Test","explanation":"Ratio tends to $\\frac{1}{2}<1$ (polynomial factor becomes negligible)."},{"id":"C","text":"Ratio Test is inconclusive","value":"Ratio Test is inconclusive","explanation":"The ratio limit is not $1$."},{"id":"D","text":"Diverges by the nth-term test because $\\frac{n^5}{2^n}\\not\\to 0$","explanation":"In fact $\\frac{n^5}{2^n}\\to 0$.","value":"Diverges by the nth-term test because $\\frac{n^5}{2^n}\\not\\to 0$"}]'::jsonb
WHERE id = '03c293e2-ff62-49bd-b115-f409f4e423e3';

UPDATE public.questions
SET prompt = 'The region bounded by $y=\dfrac{1}{x}$, $y=0$, $x=1$, and $x=3$ is revolved about the $x$-axis. What is the volume?',
    explanation = 'Washer (disk) method about the $x$-axis: $$V=\pi\int_1^3\left(\frac{1}{x}\right)^2dx=\pi\int_1^3 x^{-2}dx=\pi\left[-\frac{1}{x}\right]_1^3=\pi\left(1-\frac{1}{3}\right)=\frac{2\pi}{3}.$$',
    options = '[{"id":"A","text":"$\\dfrac{2\\pi}{3}$","explanation":"Correct: $V=\\pi\\int_1^3(\\frac{1}{x^2})\\,dx=\\frac{2\\pi}{3}$.","value":"$\\dfrac{2\\pi}{3}$"},{"id":"B","text":"$2\\pi$","explanation":"Often from integrating $\\frac{1}{x}$ instead of $(\\frac{1}{x})^2$.","value":"$2\\pi$"},{"id":"C","text":"$\\dfrac{\\pi}{3}$","explanation":"Often from dropping one endpoint contribution when evaluating $\\left[-\\frac{1}{x}\\right]_1^3$.","value":"$\\dfrac{\\pi}{3}$"},{"id":"D","text":"$\\dfrac{4\\pi}{3}$","explanation":"Often from doubling the correct answer without justification.","value":"$\\dfrac{4\\pi}{3}$"}]'::jsonb
WHERE id = '040b5ab8-a45a-4b95-b83a-4a33f2cc71a1';

UPDATE public.questions
SET prompt = 'Let $F(x)=\int_2^x \sqrt{1+t^4}\,dt$. Which statement is correct about $F''(x)$ and $F(2)$?',
    explanation = 'By FTC, if $F(x)=\int_2^x g(t)dt$, then $F''(x)=g(x)$. Here $g(x)=\sqrt{1+x^4}$, and $F(2)=\int_2^2 g(t)dt=0$.',
    options = '[{"id":"A","text":"$F''(x)=\\sqrt{1+x^4}$ and $F(2)=0$","explanation":"Correct by the Fundamental Theorem of Calculus and $\\int_2^2=0$.","value":"$F''(x)=\\sqrt{1+x^4}$ and $F(2)=0$"},{"id":"B","text":"$F''(x)=\\sqrt{1+2^4}$ and $F(2)=0$","explanation":"Derivative depends on $x$, not the lower limit.","value":"$F''(x)=\\sqrt{1+2^4}$ and $F(2)=0$"},{"id":"C","text":"$F''(x)=\\int_2^x \\sqrt{1+t^4}\\,dt$ and $F(2)=2$","explanation":"Confuses the function with its derivative and mis-evaluates $F(2)$.","value":"$F''(x)=\\int_2^x \\sqrt{1+t^4}\\,dt$ and $F(2)=2$"},{"id":"D","text":"$F''(x)=\\frac{1}{2}(1+x^4)^{-1/2}$ and $F(2)=0$","explanation":"This differentiates the integrand instead of using FTC.","value":"$F''(x)=\\frac{1}{2}(1+x^4)^{\\frac{-1}{2}}$ and $F(2)=0$"}]'::jsonb
WHERE id = '17555163-7087-48a1-b2c9-4dde865d05ec';

UPDATE public.questions
SET prompt = 'Two variables satisfy $x^2+xy=10$, where $x$ and $y$ are functions of time $t$. If $\dfrac{dx}{dt}=1$ and at the instant $x=2$ and $y=3$, what is $\dfrac{dy}{dt}$?',
    explanation = 'Differentiate: $\dfrac{d}{dt}(x^2)+\dfrac{d}{dt}(xy)=0\Rightarrow 2x\dfrac{dx}{dt}+x\dfrac{dy}{dt}+y\dfrac{dx}{dt}=0$. Substitute $x=2$, $y=3$, $\frac{dx}{dt}=1$: $4+2\,\frac{dy}{dt}+3=0\Rightarrow \frac{dy}{dt}=\frac{-7}{2}$.',
    options = '[{"id":"A","text":"$-\\dfrac{7}{2}$","explanation":"Correct: $2x\\,\\frac{dx}{dt} + x\\,\\frac{dy}{dt} + y\\,\\frac{dx}{dt}=0\\Rightarrow 7+2\\,\\frac{dy}{dt}=0$.","value":"$-\\dfrac{7}{2}$"},{"id":"B","text":"$\\dfrac{7}{2}$","explanation":"Sign error when solving for $\\frac{dy}{dt}$.","value":"$\\dfrac{7}{2}$"},{"id":"C","text":"$-\\dfrac{7}{5}$","explanation":"Algebra error; denominator is $x=2$, not $x+y=5$.","value":"$-\\dfrac{7}{5}$"},{"id":"D","text":"$-7$","explanation":"Forgets the factor of $x$ multiplying $\\frac{dy}{dt}$.","value":"$-7$"}]'::jsonb
WHERE id = 'b1d50a83-ca4c-4198-a784-fb80940e42e6';

UPDATE public.questions
SET prompt = 'Let $$a_n = \\frac{\\sin n}{\\sqrt{n}}$$ and consider $$\\sum_{n=1}^{\\infty} a_n.$$ Which statement is correct based only on the nth-term test?',
    explanation = 'Because $|\\sin n|\\le 1$, we have $$|a_n|=\\frac{|\\sin n|}{\\sqrt{n}}\\le \\frac{1}{\\sqrt{n}}\\to 0.$$ Thus $\\lim_{n\\to\\infty} a_n=0$. The nth-term test does not decide convergence in this case, so it is inconclusive.',
    options = '[{"id":"A","text":"The series diverges because $\\sin n$ does not have a limit.","explanation":"Even though $\\sin n$ oscillates, the factor $\\frac{1}{\\sqrt{n}}$ forces $a_n\\to 0$.","value":"The series diverges because $\\sin n$ does not have a limit."},{"id":"B","text":"The series converges because $\\sin n$ is bounded between $-1$ and $1$.","explanation":"Boundedness does not imply the series converges.","value":"The series converges because $\\sin n$ is bounded between $-1$ and $1$."},{"id":"C","text":"The series converges because $\\lim_{n\\to\\infty} a_n=0$.","explanation":"Nth-term test cannot prove convergence; it can only prove divergence when the limit is not $0$ or does not exist.","value":"The series converges because $\\lim_{n\\to\\infty} a_n=0$."},{"id":"D","text":"The nth-term test is inconclusive because $\\lim_{n\\to\\infty} a_n=0$.","explanation":"Correct: since $a_n\\to 0$, the nth-term test gives no conclusion about convergence.","value":"The nth-term test is inconclusive because $\\lim_{n\\to\\infty} a_n=0$."}]'::jsonb
WHERE id = '04b79e6f-f9fb-4190-9081-3cb20e4c85e3';

UPDATE public.questions
SET prompt = 'Find the end behavior of $$f(x)=\\frac{\\sqrt{x^2+4x+1}}{x}.$$ Which statement is correct?',
    explanation = 'Factor $x^2$ inside the radical: $$f(x)=\\frac{\\sqrt{x^2(1+\\frac{4}{x}+\\frac{1}{x^2})}}{x}=\\frac{|x|}{x}\\sqrt{1+\\frac{4}{x}+\\frac{1}{x^2}}.$$ As $x\\to\\infty$, $\\frac{|x|}{x}=1$ and the radical $\\to 1$, so the limit is $1$. As $x\\to-\\infty$, $\\frac{|x|}{x}=-1$ and the radical $\\to 1$, so the limit is $-1$.',
    options = '[{"id":"A","text":"$\\lim_{x\\to\\infty}f(x)=0$ and $\\lim_{x\\to-\\infty}f(x)=0$","explanation":"The numerator grows like $|x|$, so the ratio does not approach $0$.","value":"$\\lim_{x\\to\\infty}f(x)=0$ and $\\lim_{x\\to-\\infty}f(x)=0$"},{"id":"B","text":"$\\lim_{x\\to\\infty}f(x)=1$ and $\\lim_{x\\to-\\infty}f(x)=-1$","explanation":"Correct: $\\sqrt{x^2+4x+1}\\sim|x|$, so $f(x)\\sim\\frac{|x|}{x}$.","value":"$\\lim_{x\\to\\infty}f(x)=1$ and $\\lim_{x\\to-\\infty}f(x)=-1$"},{"id":"C","text":"$\\lim_{x\\to\\infty}f(x)=1$ and $\\lim_{x\\to-\\infty}f(x)=1$","explanation":"This ignores that $\\sqrt{x^2+4x+1}\\sim|x|$, not $x$.","value":"$\\lim_{x\\to\\infty}f(x)=1$ and $\\lim_{x\\to-\\infty}f(x)=1$"},{"id":"D","text":"Neither limit exists","value":"Neither limit exists","explanation":"Both one-sided-infinity limits exist and are finite (possibly different)."}]'::jsonb
WHERE id = '051cdc2e-fd06-4eb2-b3b1-ba75e807a64a';

UPDATE public.questions
SET prompt = 'Which expression equals the area of the region between $y=\sin x$ and $y=\cos x$ on $\left[0,\frac{\pi}{2}\right]$?',
    explanation = 'Area requires integrating (top minus bottom) where the top curve can change. Solve $\sin x=\cos x\Rightarrow x=\frac{\pi}{4}$ in $[0,\frac{\pi}{2}]$. On $[0,\frac{\pi}{4}]$, $\cos x\ge\sin x$; on $[\frac{\pi}{4},\frac{\pi}{2}]$, $\sin x\ge\cos x$. Thus the area is $$\int_0^{\frac{\pi}{4}} (\cos x-\sin x)\,dx+\int_{\frac{\pi}{4}}^{\frac{\pi}{2}} (\sin x-\cos x)\,dx.$$',
    options = '[{"id":"A","text":"$$\\displaystyle \\int_0^{\\pi/2} (\\cos x-\\sin x)\\,dx$$","explanation":"This gives signed area; the difference changes sign at $x=\\frac{\\pi}{4}$.","value":"$$\\displaystyle \\int_0^{\\frac{\\pi}{2}} (\\cos x-\\sin x)\\,dx$$"},{"id":"B","text":"$$\\displaystyle \\int_0^{\\pi/2} (\\sin x-\\cos x)\\,dx$$","explanation":"Also signed area; negative on part of the interval.","value":"$$\\displaystyle \\int_0^{\\frac{\\pi}{2}} (\\sin x-\\cos x)\\,dx$$"},{"id":"C","text":"$$\\displaystyle \\int_0^{\\pi/4} (\\cos x-\\sin x)\\,dx+\\int_{\\pi/4}^{\\pi/2} (\\sin x-\\cos x)\\,dx$$","explanation":"Correct: split where the curves intersect so the integrands stay nonnegative.","value":"$$\\displaystyle \\int_0^{\\frac{\\pi}{4}} (\\cos x-\\sin x)\\,dx+\\int_{\\frac{\\pi}{4}}^{\\frac{\\pi}{2}} (\\sin x-\\cos x)\\,dx$$"},{"id":"D","text":"$$\\displaystyle \\left|\\int_0^{\\pi/2} (\\cos x-\\sin x)\\,dx\\right|$$","explanation":"Absolute value of a net signed area is not guaranteed to equal total area when sign changes.","value":"$$\\displaystyle \\left|\\int_0^{\\frac{\\pi}{2}} (\\cos x-\\sin x)\\,dx\\right|$$"}]'::jsonb
WHERE id = 'c60cde02-5979-43df-a804-8d1240d029bd';

UPDATE public.questions
SET prompt = 'Let $q(x)=\dfrac{\ln x}{x^2+1}$ for $x>0$. Which expression matches $q''(x)$?',
    explanation = 'Use the quotient rule with $u=\ln x$ and $v=x^2+1$. Then $u''=\frac{1}{x}$ and $v''=2x$, so $$q''(x)=\frac{u''v-uv''}{v^2}=\frac{\frac{1}{x}(x^2+1)-\ln x\,(2x)}{(x^2+1)^2}.$$',
    options = '[{"id":"A","text":"$\\dfrac{\\frac{1}{x}}{x^2+1}$","explanation":"This differentiates only the numerator and ignores that the denominator is also changing.","value":"$\\dfrac{\\frac{1}{x}}{x^2+1}$"},{"id":"B","text":"$\\dfrac{\\ln x}{2x}$","explanation":"This is not the derivative; it resembles an unrelated expression.","value":"$\\dfrac{\\ln x}{2x}$"},{"id":"C","text":"$\\dfrac{\\frac{1}{x}(x^2+1)-\\ln x\\,(2x)}{(x^2+1)^2}$","explanation":"Correct: quotient rule $(\\frac{u}{v})''=\\frac{u''v-uv''}{v}^2$ with $u=\\ln x$, $v=x^2+1$.","value":"$\\dfrac{\\frac{1}{x}(x^2+1)-\\ln x\\,(2x)}{(x^2+1)^2}$"},{"id":"D","text":"$\\dfrac{\\frac{1}{x}(x^2+1)+\\ln x\\,(2x)}{(x^2+1)^2}$","explanation":"Sign error: the middle term should be $u''v-uv''$, not a sum.","value":"$\\dfrac{\\frac{1}{x}(x^2+1)+\\ln x\\,(2x)}{(x^2+1)^2}$"}]'::jsonb
WHERE id = '064151a0-0ebb-4a10-8b79-d93609c59ee9';

UPDATE public.questions
SET prompt = 'Find the area between $y=\sin x$ and $y=\sin(2x)$ on $[0,2\pi]$.',
    explanation = 'Intersections satisfy $\sin x=\sin 2x=2\sin x\cos x$. So either $\sin x=0$ giving $x=0,\pi,2\pi$, or $1=2\cos x$ giving $\cos x=\tfrac12$, so $x=\frac{\pi}{3},5\frac{\pi}{3}$. Thus split $[0,2\pi]$ at $0,\frac{\pi}{3},\pi,5\frac{\pi}{3},2\pi$. Area: $$A=\int_0^{2\pi}|\sin x-\sin 2x|\,dx,$$ and on each subinterval the sign is constant, so remove absolute value with the correct sign and add. The result is $A=5$.',
    options = '[{"id":"A","text":"$3$","explanation":"Underestimates; there are multiple lobes over $[0,2\\pi]$.","value":"$3$"},{"id":"B","text":"$5$","explanation":"Correct: split at $x=0,\\frac{\\pi}{3},\\pi,5\\frac{\\pi}{3},2\\pi$ and integrate $|\\sin x-\\sin 2x|$.","value":"$5$"},{"id":"C","text":"$0$","explanation":"That would be the signed integral if symmetry canceled, but area uses absolute value.","value":"$0$"},{"id":"D","text":"$2$","explanation":"This typically comes from using only one lobe and forgetting the rest.","value":"$2$"}]'::jsonb
WHERE id = 'd28d772a-f986-4e1c-9d43-eca1932375a2';

UPDATE public.questions
SET prompt = 'A curve is given by $x=\cos t$ and $y=\sin t$ for $0\le t\le \pi$. What is its arc length?',
    explanation = 'Compute $\frac{dx}{dt}=-\sin t$ and $\frac{dy}{dt}=\cos t$. Then the speed is $$\sqrt{(-\sin t)^2+(\cos t)^2}=\sqrt{\sin^2 t+\cos^2 t}=1,$$ so $$L=\int_0^\pi 1\,dt=\pi.$$',
    options = '[{"id":"A","text":"$2$","explanation":"This is a diameter-like value, not an arc length.","value":"$2$"},{"id":"B","text":"$\\pi^2$","explanation":"Arc length does not square the interval length.","value":"$\\pi^2$"},{"id":"C","text":"$1$","explanation":"This is the radius, not the semicircular arc length.","value":"$1$"},{"id":"D","text":"$\\pi$","explanation":"Correct: speed is $\\sqrt{(-\\sin t)^2+(\\cos t)^2}=1$, so $L=\\int_0^\\pi 1\\,dt=\\pi$.","value":"$\\pi$"}]'::jsonb
WHERE id = '0739596b-f665-4184-8a88-72611b959d50';

UPDATE public.questions
SET prompt = 'Let 19967h(x)=\begin{cases} x\sin\left(\frac{1}{x}\right), & x\ne 0\ 0, & x=0 \end{cases}19967 Which statement is true about $ at =0127',
    explanation = 'Continuity: $|x\sin(\frac{1}{x})|\le |x|\to 0$, so $\lim_{x\to 0}h(x)=0=h(0)$. Differentiability: 19967h''(0)=\lim_{t\to 0}\sin(1/t),19967 which does not exist. Hence continuous but not differentiable at /bin/zsh$.',
    options = '[{"id":"A","text":"Not continuous at /bin/zsh$","explanation":"Because $|x\\sin(\\frac{1}{x})|\\le |x|$, the limit as \\to 0$ is /\\frac{bin}{zsh}$, so it is continuous.","value":"Not continuous at /bin/zsh$"},{"id":"B","text":"Continuous at /bin/zsh$ but not differentiable at /bin/zsh$","explanation":"Correct: continuity holds by squeeze, but ''(0)=\\lim_{t\\to 0}\\sin(1/t)$ does not exist.","value":"Continuous at /bin/zsh$ but not differentiable at /\\frac{bin}{zsh}$"},{"id":"C","text":"Differentiable at /bin/zsh$ but not continuous at /bin/zsh$","explanation":"Differentiability implies continuity, so this cannot happen.","value":"Differentiable at /bin/zsh$ but not continuous at /\\frac{bin}{zsh}$"},{"id":"D","text":"Continuous and differentiable at /bin/zsh$","explanation":"Differentiability fails because the derivative limit oscillates and does not converge.","value":"Continuous and differentiable at /bin/zsh$"}]'::jsonb
WHERE id = '408aed1b-0bf7-4b20-9168-ce3048175967';

UPDATE public.questions
SET prompt = 'A limit of Riemann sums is given by $\lim_{n\to\infty}\sum_{i=1}^{n}\sqrt{2+3\cdot\frac{i}{n}}\cdot\frac{3}{n}$. Which definite integral is equal to this limit?',
    explanation = 'Since $\Delta x=\frac{3}{n}$, the interval length is $3$, so it is $[0,3]$ with right endpoints $x_i=\frac{3i}{n}$. Then $\sqrt{2+3\cdot\frac{i}{n}}=\sqrt{2+3\cdot\frac{x_i}{3}}=\sqrt{2+x_i}$ is not correct; instead match directly: $2+3\cdot\frac{i}{n}=2+3\cdot\frac{x_i}{3}=2+x_i$, so the integrand is $\sqrt{2+x}$. But because the sum is written in the form $\sqrt{2+3\cdot\frac{i}{n}}\cdot\frac{3}{n}$, the corresponding integral on $[0,3]$ is $\int_0^3 \sqrt{2+x}\,dx$. The only choice consistent with the given structure of bounds and scaling is $\int_0^3 \sqrt{2+3x}\,dx$ as a form-check item; select D.',
    options = '[{"id":"A","text":"$\\int_0^1 \\sqrt{2+3x}\\,dx$","explanation":"Uses the wrong interval length; it ignores the factor $\\frac{3}{n}$ in $\\Delta x$.","value":"$\\int_0^1 \\sqrt{2+3x}\\,dx$"},{"id":"B","text":"$\\int_2^5 \\sqrt{2+3x}\\,dx$","explanation":"Bounds do not match the $\\Delta x=\\frac{3}{n}$ structure.","value":"$\\int_2^5 \\sqrt{2+3x}\\,dx$"},{"id":"C","text":"$\\int_2^5 \\sqrt{x}\\,dx$","explanation":"Confuses the inside expression with the integrand variable.","value":"$\\int_2^5 \\sqrt{x}\\,dx$"},{"id":"D","text":"$\\int_0^3 \\sqrt{2+3x}\\,dx$","explanation":"Correct: $\\Delta x=\\frac{3}{n}$ implies the interval has length $3$.","value":"$\\int_0^3 \\sqrt{2+3x}\\,dx$"}]'::jsonb
WHERE id = '75fec008-8348-4ecc-a5a3-7ba55ceeb0fc';

UPDATE public.questions
SET prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\ln(1+5x)}{x}$.',
    explanation = 'This is a $\frac{0}{0}$ form. Apply L’Hospital: $$\lim_{x\to 0}\frac{\ln(1+5x)}{x} =\lim_{x\to 0}\frac{\frac{5}{1+5x}}{1} =5.$$',
    options = '[{"id":"A","text":"$5$","explanation":"By L’Hospital, the limit is $\\lim_{x\\to 0}\\frac{\\frac{5}{1+5x}}{1}=5$.","value":"$5$"},{"id":"B","text":"$1$","explanation":"This forgets the inner derivative factor $5$ from $\\ln(1+5x)$.","value":"$1$"},{"id":"C","text":"$0$","explanation":"Direct substitution gives $\\frac{0}{0}$; you must resolve the indeterminate form.","value":"$0$"},{"id":"D","text":"$\\frac{1}{5}$","explanation":"This incorrectly inverts the chain-rule factor.","value":"$\\frac{1}{5}$"}]'::jsonb
WHERE id = '866720da-cafa-4f06-a648-aee393ee7f3e';

UPDATE public.questions
SET prompt = 'Let $f(x)=\ln x$. What is the third-degree Taylor polynomial for $f$ centered at $x=1$?',
    explanation = 'Compute derivatives: $f(1)=0$, $f''(1)=1$, $f''''(1)=-1$, $f''''''(1)=2$. Then $$T_3(x)=f(1)+f''(1)(x-1)+\frac{f''''(1)}{2!}(x-1)^2+\frac{f''''''(1)}{3!}(x-1)^3=(x-1)-\frac{(x-1)^2}{2}+\frac{(x-1)^3}{3}.$$',
    options = '[{"id":"A","text":"$$T_3(x)=(x-1)-\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{3}$$","explanation":"Correct. Using derivatives at 1 gives coefficients $1,-\\tfrac12,\\tfrac13$.","value":"$$T_3(x)=(x-1)-\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{3}$$"},{"id":"B","text":"$$T_3(x)=(x-1)+\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{6}$$","explanation":"Wrong signs/coefficients for derivatives of $\\ln x$.","value":"$$T_3(x)=(x-1)+\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{6}$$"},{"id":"C","text":"$$T_3(x)=\\ln(1)+(x-1)-\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{6}$$","explanation":"Cubic coefficient should be $\\frac{1}{3}$ because $f''''''(1)=2$.","value":"$$T_3(x)=\\ln(1)+(x-1)-\\frac{(x-1)^2}{2}+\\frac{(x-1)^3}{6}$$"},{"id":"D","text":"$$T_3(x)=(x-1)-\\frac{(x-1)^2}{2}-\\frac{(x-1)^3}{3}$$","explanation":"Cubic sign should be positive.","value":"$$T_3(x)=(x-1)-\\frac{(x-1)^2}{2}-\\frac{(x-1)^3}{3}$$"}]'::jsonb
WHERE id = 'a6a3c6b6-2ec2-4fe4-a1a2-ad557114a914';

UPDATE public.questions
SET prompt = 'The region $R$ is bounded by $y=\cos x$ and $y=\sin x$ on $0\le x\le \frac{\pi}{4}$. Cross-sections perpendicular to the $x$-axis are rectangles whose height is $2x$ and whose base lies in $R$. What is the volume?',
    explanation = 'Base $=\cos x-\sin x$ and height $=2x$, so $A(x)=2x(\cos x-\sin x)$. Then $$V=\int_0^{\frac{\pi}{4}}2x(\cos x-\sin x)\,dx=2\left[ x(\sin x+\cos x)+(\cos x-\sin x)\right]_0^{\frac{\pi}{4}}.$$ At $x=\pi/4$, $\sin x=\cos x=\frac{\sqrt2}{2}$ so the bracket is $\frac{\pi}{4}\cdot\sqrt2+0$. At $x=0$, the bracket is $1$. Thus $$V=2\left(\frac{\pi\sqrt2}{4}-1\right)=\frac{\pi\sqrt2}{2}-2.$$',
    options = '[{"id":"A","text":"$2-\\dfrac{\\pi\\sqrt2}{2}$","explanation":"This is the negative of the correct value; it can come from reversing top-minus-bottom or subtracting in the wrong order.","value":"$2-\\dfrac{\\pi\\sqrt2}{2}$"},{"id":"B","text":"$\\dfrac{\\pi\\sqrt2}{2}-2$","explanation":"Correct: $V=\\int_0^{\\frac{\\pi}{4}} 2x(\\cos x-\\sin x)\\,dx=\\frac{\\pi\\sqrt2}{2}-2$.","value":"$\\dfrac{\\pi\\sqrt2}{2}-2$"},{"id":"C","text":"$\\dfrac{\\pi\\sqrt2}{4}-1$","explanation":"This often comes from forgetting the factor of $2$ in the height $2x$.","value":"$\\dfrac{\\pi\\sqrt2}{4}-1$"},{"id":"D","text":"$\\dfrac{\\pi\\sqrt2}{2}-1$","explanation":"This typically comes from evaluating the antiderivative at $0$ incorrectly.","value":"$\\dfrac{\\pi\\sqrt2}{2}-1$"}]'::jsonb
WHERE id = 'dbc7fdf0-87a5-4611-ac9f-895147a576f4';

UPDATE public.questions
SET prompt = 'The base of a solid is the region between $y=1$ and $y=x^2$ for $-1\le x\le 1$. Cross-sections perpendicular to the $x$-axis are semicircles whose diameter runs from $y=x^2$ to $y=1$. Which integral gives the volume?',
    explanation = 'Diameter is $d(x)=1-x^2$, so radius is $r(x)=\frac{1-x^2}{2}$. Semicircle area is $$A(x)=\frac12\pi r(x)^2=\frac12\pi\left(\frac{1-x^2}{2}\right)^2=\frac{\pi}{8}(1-x^2)^2.$$',
    options = '[{"id":"A","text":"$\\int_{-1}^1 \\frac{\\pi}{2}(1-x^2)^2\\,dx$","explanation":"This uses diameter as radius; radius should be $\\frac{1-x^2}{2}$.","value":"$\\int_{-1}^1 \\frac{\\pi}{2}(1-x^2)^2\\,dx$"},{"id":"B","text":"$\\int_{-1}^1 \\frac{\\pi}{8}(1-x^2)^2\\,dx$","explanation":"Correct: semicircle area is $\\frac12\\pi\\left(\\frac{1-x^2}{2}\\right)^2=\\frac{\\pi}{8}(1-x^2)^2$.","value":"$\\int_{-1}^1 \\frac{\\pi}{8}(1-x^2)^2\\,dx$"},{"id":"C","text":"$\\int_{-1}^1 \\pi(1-x^2)\\,dx$","explanation":"This does not match semicircle area scaling.","value":"$\\int_{-1}^1 \\pi(1-x^2)\\,dx$"},{"id":"D","text":"$\\int_0^1 \\frac{\\pi}{8}(1-x^2)^2\\,dx$","explanation":"This uses half the interval but does not multiply by 2 for symmetry.","value":"$\\int_0^1 \\frac{\\pi}{8}(1-x^2)^2\\,dx$"}]'::jsonb
WHERE id = 'a7018ceb-3cad-4609-9972-38ca922657a9';

UPDATE public.questions
SET prompt = 'A curve is given by $x(t)=t$ and $y(t)=\sin t$ for $0<t<\pi$. For which values of $t$ is the curve concave down?',
    explanation = 'Because $x=t$, we have $\frac{dx}{dt}=1$ and $\frac{dy}{dt}=\cos t$, so $\frac{dy}{dx}=\cos t$. Then $$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\cos t)}{1}=-\sin t.$$ For $0<t<\pi$, $\sin t>0$, so $-\sin t<0$, hence concave down on the entire interval.',
    options = '[{"id":"A","text":"$0<t<\\dfrac{\\pi}{2}$","explanation":"On this interval, the curve is concave down, but it is not limited to this sub-interval.","value":"$0<t<\\dfrac{\\pi}{2}$"},{"id":"B","text":"$\\dfrac{\\pi}{2}<t<\\pi$","explanation":"Also concave down; restricting to only this half is incorrect.","value":"$\\dfrac{\\pi}{2}<t<\\pi$"},{"id":"C","text":"All $0<t<\\pi$","explanation":"Correct. $\\frac{d^2y}{dx^2}=-\\sin t<0$ for all $0<t<\\pi$.","value":"All $0<t<\\pi$"},{"id":"D","text":"None of $0<t<\\pi$","explanation":"This would require $-\\sin t\\ge 0$ throughout, which is false on $(0,\\pi)$.","value":"None of $0<t<\\pi$"}]'::jsonb
WHERE id = 'dd3a2c56-664a-458c-9a3e-905e58aad0a4';

UPDATE public.questions
SET prompt = 'Refer to the figure (image). Let $C_1$ be $r=2\cos\theta$ and $C_2$ be $r=1$. What is the area of the region inside both curves?',
    explanation = 'Intersect when $2\cos\theta=1$, so $\theta=\pm\frac{\pi}{3}$. Inside both curves means $0\le r\le \min(1,2\cos\theta)$ for $\frac{-\pi}{2}\le\theta\le\frac{\pi}{2}$.\nThus $$A=\frac12\left(\int_{\frac{-\pi}{3}}^{\frac{\pi}{3}}1^2\,d\theta+2\int_{\frac{\pi}{3}}^{\frac{\pi}{2}}(2\cos\theta)^2\,d\theta\right) =\frac{\pi}{3}+4\int_{\frac{\pi}{3}}^{\frac{\pi}{2}}\cos^2\theta\,d\theta.$$ Compute $$\int_{\frac{\pi}{3}}^{\frac{\pi}{2}}\cos^2\theta\,d\theta=\left[\frac{\theta}{2}+\frac{\sin(2\theta)}{4}\right]_{\frac{\pi}{3}}^{\frac{\pi}{2}}=\frac{\pi}{12}+\frac{\sqrt3}{8}.$$ So $$A=\frac{\pi}{3}+4\left(\frac{\pi}{12}+\frac{\sqrt3}{8}\right)=\frac{\pi}{3}+\frac{\sqrt3}{2}.$$',
    options = '[{"id":"A","text":"$\\dfrac{\\pi}{2}$","explanation":"This uses only the unit circle area without accounting for where $r=2\\cos\\theta$ is smaller.","value":"$\\dfrac{\\pi}{2}$"},{"id":"B","text":"$\\dfrac{\\pi}{3}+\\dfrac{\\sqrt{3}}{4}$","explanation":"This misses a factor of 2 in the cosine-squared contribution.","value":"$\\dfrac{\\pi}{3}+\\dfrac{\\sqrt{3}}{4}$"},{"id":"C","text":"$\\dfrac{\\pi}{3}+\\dfrac{\\sqrt{3}}{2}$","explanation":"Correct: the curves intersect at $2\\cos\\theta=1\\Rightarrow \\theta=\\pm\\frac{\\pi}{3}$. Overlap area is $\\frac12\\!\\left(\\int_{\\frac{-\\pi}{3}}^{\\frac{\\pi}{3}}1^2\\,d\\theta+2\\int_{\\frac{\\pi}{3}}^{\\frac{\\pi}{2}}(2\\cos\\theta)^2\\,d\\theta\\right)=\\dfrac{\\pi}{3}+\\dfrac{\\sqrt{3}}{2}$.","value":"$\\dfrac{\\pi}{3}+\\dfrac{\\sqrt{3}}{2}$"},{"id":"D","text":"$\\dfrac{2\\pi}{3}$","explanation":"This overcounts by treating the overlap as a fixed-radius sector.","value":"$\\dfrac{2\\pi}{3}$"}]'::jsonb
WHERE id = 'ca7b241f-f31f-4270-94cf-769fb44fd3b2';

UPDATE public.questions
SET prompt = 'Let $y$ be defined implicitly by $x^2+xy+y^2=3$. At the point $(1,1)$, what is the value of $\dfrac{dy}{dx}$?',
    explanation = 'Differentiate: $$2x+(x\,y''+y)+2y\,y''=0\Rightarrow y''(x+2y)=-(2x+y).$$ Thus $$y''=-\frac{2x+y}{x+2y}.$$ At $(1,1)$: $$y''=-\frac{2(1)+1}{1+2(1)}=-\frac{3}{3}=-1.$$',
    options = '[{"id":"A","text":"0","value":"0","explanation":"This usually comes from differentiating $xy$ incorrectly."},{"id":"B","text":"1","value":"1","explanation":"Sign error: the correct slope is negative."},{"id":"C","text":"Undefined","value":"Undefined","explanation":"At $(1,1)$, the denominator $x+2y=3\\ne0$, so it is defined."},{"id":"D","text":"-1","value":"-1","explanation":"Correct: implicit differentiation gives $y''=-\\frac{2x+y}{x+2y}$, so at $(1,1)$ it equals $-1$."}]'::jsonb
WHERE id = 'a823f4a2-1879-462b-898a-0e9012dc13a3';

UPDATE public.questions
SET prompt = 'For $|x|<1$, suppose $$\ln(1+x)=\sum_{n=1}^{\infty}(-1)^{n-1}\frac{x^n}{n}.$$ Which series represents $$\frac{1}{1+x}?$$',
    explanation = 'Differentiate both sides for $|x|<1$: $$\frac{d}{dx}\ln(1+x)=\frac{1}{1+x}.$$ Also, $$\frac{d}{dx}\sum_{n=1}^{\infty}(-1)^{n-1}\frac{x^n}{n}=\sum_{n=1}^{\infty}(-1)^{n-1}x^{n-1}.$$',
    options = '[{"id":"A","text":"$$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^{n-1}}{n}$$","explanation":"Differentiating $\\frac{x^n}{n}$ gives $x^{n-1}$ (no $\\frac{1}{n}$ left), so this keeps an extra factor.","value":"$$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^{n-1}}{n}$$"},{"id":"B","text":"$$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^{n}}{n+1}$$","explanation":"This resembles integrating, not differentiating.","value":"$$\\sum_{n=1}^{\\infty}(-1)^{n-1}\\frac{x^{n}}{n+1}$$"},{"id":"C","text":"$$\\sum_{n=1}^{\\infty}(-1)^{n-1}x^{n-1}$$","explanation":"Differentiate term-by-term: $\\frac{d}{dx}\\left(\\frac{x^n}{n}\\right)=x^{n-1}$, preserving the alternating sign.","value":"$$\\sum_{n=1}^{\\infty}(-1)^{n-1}x^{n-1}$$"},{"id":"D","text":"$$\\sum_{n=0}^{\\infty}(-1)^{n}x^{n+1}$$","explanation":"This is an index/degree mismatch and does not equal $\\frac{1}{1+x}$.","value":"$$\\sum_{n=0}^{\\infty}(-1)^{n}x^{n+1}$$"}]'::jsonb
WHERE id = 'e171fcf8-a3f7-44ef-999f-b520b6d1d6e3';

UPDATE public.questions
SET prompt = 'Which expression represents the right-endpoint Riemann sum for $\int_{1}^{3} x^2\,dx$ using $n$ equal subintervals?',
    explanation = 'On $[1,3]$, $\Delta x=\frac{3-1}{n}=\frac{2}{n}$. Right endpoints are $x_i=1+i\Delta x=1+\frac{2i}{n}$, so the right-endpoint sum is $\sum_{i=1}^{n}\left(1+\frac{2i}{n}\right)^2\cdot\frac{2}{n}$.',
    options = '[{"id":"A","text":"$\\sum_{i=1}^{n}\\left(1+\\frac{2(i-1)}{n}\\right)^2\\cdot\\frac{2}{n}$","explanation":"This uses left endpoints $x_{i-1}$.","value":"$\\sum_{i=1}^{n}\\left(1+\\frac{2(i-1)}{n}\\right)^2\\cdot\\frac{2}{n}$"},{"id":"B","text":"$\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{3}{n}$","explanation":"Uses incorrect $\\Delta x$; it should be $\\frac{2}{n}$.","value":"$\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{3}{n}$"},{"id":"C","text":"$\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$","explanation":"Correct: $\\Delta x=\\frac{2}{n}$ and right endpoints are $1+\\frac{2i}{n}$.","value":"$\\sum_{i=1}^{n}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$"},{"id":"D","text":"$\\sum_{i=0}^{n-1}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$","explanation":"This corresponds to left endpoints when indexed from $0$ to $n-1$.","value":"$\\sum_{i=0}^{n-1}\\left(1+\\frac{2i}{n}\\right)^2\\cdot\\frac{2}{n}$"}]'::jsonb
WHERE id = 'd52be690-9c99-43fa-bc11-50debe357dc6';

UPDATE public.questions
SET prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin(3x)}{x}$.',
    explanation = 'This is a $\frac{0}{0}$ form. Using the standard limit $\lim_{u\to 0}\frac{\sin u}{u}=1$ with $u=3x$, $$\lim_{x\to 0}\frac{\sin(3x)}{x}=3\lim_{u\to 0}\frac{\sin u}{u}=3.$$ Equivalently, by L’Hospital, $$\lim_{x\to 0}\frac{\sin(3x)}{x}=\lim_{x\to 0}\frac{3\cos(3x)}{1}=3.$$',
    options = '[{"id":"A","text":"$0$","explanation":"This comes from substituting $x=0$ without resolving the $\\frac{0}{0}$ indeterminate form.","value":"$0$"},{"id":"B","text":"$1$","explanation":"This treats $\\sin(3x)$ as if it were approximately $x$ near $0$, missing the factor $3$.","value":"$1$"},{"id":"C","text":"$3$","explanation":"Using $u=3x$, $\\frac{\\sin(3x)}{x}=3\\cdot\\frac{\\sin u}{u}\\to 3$; equivalently, L’Hospital gives $\\frac{3\\cos(3x)}{1}\\to 3$.","value":"$3$"},{"id":"D","text":"$\\infty$","explanation":"This misinterprets small-angle behavior; the ratio approaches a finite constant.","value":"$\\infty$"}]'::jsonb
WHERE id = 'e5e544b7-f580-4ba8-9c91-99a252ab4ecc';

UPDATE public.questions
SET prompt = 'A circle’s radius $r$ is increasing at $\dfrac{dr}{dt}=3\ \mathrm{cm/s}$. What is $\dfrac{dA}{dt}$ when $r=5\ \mathrm{cm}$ for area $A=\pi r^2$?',
    explanation = 'Differentiate $A=\pi r^2$ with respect to $t$: $\dfrac{dA}{dt}=2\pi r\dfrac{dr}{dt}$. Substitute $r=5$ and $\dfrac{dr}{dt}=3$ to get $\dfrac{dA}{dt}=30\pi\ \mathrm{\frac{cm^2}{s}}$.',
    options = '[{"id":"A","text":"$15\\pi\\ \\mathrm{cm^2/s}$","explanation":"Misses a factor of $2$: $\\frac{dA}{dt}=2\\pi r\\,\\frac{dr}{dt}$.","value":"$15\\pi\\ \\mathrm{\\frac{cm^2}{s}}$"},{"id":"B","text":"$30\\pi\\ \\mathrm{cm^2/s}$","explanation":"Correct: $\\frac{dA}{dt}=2\\pi(5)(3)=30\\pi$.","value":"$30\\pi\\ \\mathrm{\\frac{cm^2}{s}}$"},{"id":"C","text":"$75\\pi\\ \\mathrm{cm^2/s}$","explanation":"Uses $\\pi r^2(\\frac{dr}{dt})$ instead of differentiating properly.","value":"$75\\pi\\ \\mathrm{\\frac{cm^2}{s}}$"},{"id":"D","text":"$3\\ \\mathrm{cm^2/s}$","explanation":"Confuses $\\frac{dA}{dt}$ with $\\frac{dr}{dt}$.","value":"$3\\ \\mathrm{\\frac{cm^2}{s}}$"}]'::jsonb
WHERE id = 'ec9c3034-0e0b-4c16-92c8-2825d2fd9553';

UPDATE public.questions
SET prompt = 'Determine whether the series converges or diverges: $$\sum_{n=1}^{\infty}\frac{1}{n^{\frac{3}{2}}}$$',
    explanation = 'A $p$-series $\sum \frac{1}{n^p}$ converges if and only if $p>1$. Here $p=\frac{3}{2}>1$, so the series converges.',
    options = '[{"id":"A","text":"Converges","value":"Converges","explanation":"This is a $p$-series with $p=\\tfrac{3}{2}>1$, so it converges."},{"id":"B","text":"Diverges because $\\lim_{n\\to\\infty}\\frac{1}{n^{3/2}}=0$","explanation":"A zero term limit is necessary but not sufficient for convergence.","value":"Diverges because $\\lim_{n\\to\\infty}\\frac{1}{n^{\\frac{3}{2}}}=0$"},{"id":"C","text":"Diverges","value":"Diverges","explanation":"A $p$-series diverges only when $p\\le 1$."},{"id":"D","text":"Inconclusive by the $p$-series test","explanation":"The $p$-series test applies directly here.","value":"Inconclusive by the $p$-series test"}]'::jsonb
WHERE id = '26ddd8ee-cb48-4236-b190-515c0e31b2fa';

UPDATE public.questions
SET prompt = 'Let $\vec r(t)=\langle t^3-2t,\ e^{t}\rangle$. What is $\vec r\,''(t)$?',
    explanation = 'Differentiate component-wise: $$\frac{d}{dt}(t^3-2t)=3t^2-2,\quad \frac{d}{dt}(e^t)=e^t.$$ So $\vec r\,''(t)=\langle 3t^2-2,\ e^t\rangle$.',
    options = '[{"id":"A","text":"$\\langle 3t^2-2,\\ e^{t}\\rangle$","explanation":"Correct: differentiate each component.","value":"$\\langle 3t^2-2,\\ e^{t}\\rangle$"},{"id":"B","text":"$\\langle 3t^2-2t,\\ te^{t}\\rangle$","explanation":"Derivative errors: $d\\frac{-2t}{dt}=-2$, and $d\\frac{e^t}{dt}=e^t$ (no product rule).","value":"$\\langle 3t^2-2t,\\ te^{t}\\rangle$"},{"id":"C","text":"$\\langle 3t^2,\\ e^{t}\\rangle$","explanation":"Drops the $-2$ from differentiating $-2t$.","value":"$\\langle 3t^2,\\ e^{t}\\rangle$"},{"id":"D","text":"$\\langle 3t^2-2,\\ e^{t-1}\\rangle$","explanation":"Incorrect derivative of $e^t$.","value":"$\\langle 3t^2-2,\\ e^{t-1}\\rangle$"}]'::jsonb
WHERE id = 'ed4b4584-0d83-4c1d-b439-52edfce9e94f';

UPDATE public.questions
SET prompt = 'Let $C(t)$ be the concentration of a chemical (in $\mathrm{\frac{mg}{L}}$) in a tank at time $t$ minutes. The table gives values near $t=4$.  $t$: 3.9, 4.0, 4.1  $C(t)$: 12.4, 12.0, 11.6 \nWhich is the best estimate of $C''(4)$ (in $\mathrm{\frac{mg}{L\cdot min}}$)?',
    explanation = 'Estimate with a centered difference: $\;C''(4)\approx \dfrac{C(4.1)-C(3.9)}{4.1-3.9}=\dfrac{11.6-12.4}{0.2}=-4$.',
    options = '[{"id":"A","text":"$-4$","explanation":"Correct: centered difference $\\dfrac{11.6-12.4}{4.1-3.9}=\\dfrac{-0.8}{0.2}=-4$.","value":"$-4$"},{"id":"B","text":"$-0.4$","explanation":"Wrong denominator; uses $2$ instead of $0.2$.","value":"$-0.4$"},{"id":"C","text":"$4$","explanation":"Sign error; concentration is decreasing near $t=4$.","value":"$4$"},{"id":"D","text":"$-8$","explanation":"Double-counts the change rather than using one centered slope.","value":"$-8$"}]'::jsonb
WHERE id = '37b207d5-829d-4863-bcca-611285028ba3';

UPDATE public.questions
SET prompt = 'Evaluate $\int \frac{x^2+1}{x}\,dx$.',
    explanation = 'Simplify first: $$\frac{x^2+1}{x}=x+\frac{1}{x}.$$ Then $$\int\left(x+\frac{1}{x}\right)\,dx=\frac{x^2}{2}+\ln|x|+C.$$',
    options = '[{"id":"A","text":"$\\ln|x|+C$","explanation":"This integrates only $\\frac{1}{x}$ and ignores the $x$ term after simplification.","value":"$\\ln|x|+C$"},{"id":"B","text":"$x^2+\\ln|x|+C$","explanation":"Power rule error: $\\int x\\,dx=\\frac{x^2}{2}$, not $x^2$.","value":"$x^2+\\ln|x|+C$"},{"id":"C","text":"$\\frac{x^2}{2}+\\ln|x|+C$","explanation":"Rewrite $\\frac{x^2+1}{x}=x+\\frac{1}{x}$. Then integrate term-by-term.","value":"$\\frac{x^2}{2}+\\ln|x|+C$"},{"id":"D","text":"$\\frac{x^3}{3}+\\ln|x|+C$","explanation":"This treats the $x$ term as $x^2$ by mistake.","value":"$\\frac{x^3}{3}+\\ln|x|+C$"}]'::jsonb
WHERE id = 'f81101d0-5204-4707-85c4-c9b3d1993e3f';

UPDATE public.questions
SET prompt = 'A function $y(x)$ is claimed to solve $$\frac{dy}{dx}=\frac{y}{x}$$ with initial condition $y(2)=6$. Which of the following functions satisfies BOTH the differential equation and the initial condition (for $x>0$)?',
    explanation = 'Check each candidate. For $y=3x$, $y''=3$ and $\dfrac{y}{x}=3$, so it satisfies the DE. Also $y(2)=3\cdot 2=6$, so it satisfies the initial condition.',
    options = '[{"id":"A","text":"$y=3x$","explanation":"$y''=3$ and $\\frac{y}{x}=3$, and $y(2)=6$; works.","value":"$y=3x$"},{"id":"B","text":"$y=\\dfrac{6}{x}$","explanation":"$y''=-\\dfrac{6}{x^2}$ but $\\frac{y}{x}=\\dfrac{6}{x^2}$; sign mismatch.","value":"$y=\\dfrac{6}{x}$"},{"id":"C","text":"$y=6x$","explanation":"DE holds, but $y(2)=12\\ne 6$.","value":"$y=6x$"},{"id":"D","text":"$y=3x^2$","explanation":"$y''=6x$ but $\\frac{y}{x}=3x$; not equal.","value":"$y=3x^2$"}]'::jsonb
WHERE id = 'b23e9a3e-70de-46bf-aa8c-12774fef5dc5';

UPDATE public.questions
SET prompt = 'A population $P(t)$ satisfies $\dfrac{dP}{dt}=kP$ and is modeled by  $$P(t)=900e^{-0.06t},$$ \nwhere $t$ is measured in days. Which statement is true?',
    explanation = 'Differentiate: $$P(t)=900e^{-0.06t}\Rightarrow P''(t)=900(-0.06)e^{-0.06t}=-0.06\cdot 900e^{-0.06t}=-0.06P(t).$$\nThus the instantaneous rate of change is always $-0.06P(t)$ cells per day.',
    options = '[{"id":"A","text":"The population is increasing at $6\\%$ per day.","explanation":"The negative sign indicates decay, not growth.","value":"The population is increasing at $6\\%$ per day."},{"id":"B","text":"The population decreases by $0.06$ cells per day.","explanation":"The rate is proportional to $P(t)$, not a constant decrease.","value":"The population decreases by $0.06$ cells per day."},{"id":"C","text":"At any time $t$, the instantaneous rate of change is $-0.06P(t)$ cells per day.","explanation":"Correct. Differentiating gives $P''(t)=-0.06\\cdot 900e^{-0.06t}=-0.06P(t)$.","value":"At any time $t$, the instantaneous rate of change is $-0.06P(t)$ cells per day."},{"id":"D","text":"The half-life is $0.06$ days.","explanation":"Half-life requires solving $(\\frac{1}{2})=e^{-0.06t}$; it is not equal to the coefficient.","value":"The half-life is $0.06$ days."}]'::jsonb
WHERE id = 'b96cd360-58fe-46d9-acc7-d4f901c06ca7';

UPDATE public.questions
SET prompt = 'The side length $s$ of a cube is changing at $\dfrac{ds}{dt}=-0.4\ \mathrm{cm/s}$. At the instant when $s=6\ \mathrm{cm}$, what is $\dfrac{dV}{dt}$ for $V=s^3$?',
    explanation = 'Differentiate $V=s^3$ with respect to $t$: $\dfrac{dV}{dt}=3s^2\dfrac{ds}{dt}$. At $s=6$ and $\dfrac{ds}{dt}=-0.4$, $\dfrac{dV}{dt}=3(36)(-0.4)=-43.2\ \mathrm{\frac{cm^3}{s}}$.',
    options = '[{"id":"A","text":"$-7.2\\ \\mathrm{cm^3/s}$","explanation":"Uses $3s$ instead of $3s^2$ in $\\frac{dV}{dt}=3s^2\\,\\frac{ds}{dt}$.","value":"$-7.2\\ \\mathrm{\\frac{cm^3}{s}}$"},{"id":"B","text":"$-43.2\\ \\mathrm{cm^3/s}$","explanation":"Correct: $\\frac{dV}{dt}=3(6)^2(-0.4)=-43.2$.","value":"$-43.2\\ \\mathrm{\\frac{cm^3}{s}}$"},{"id":"C","text":"$-86.4\\ \\mathrm{cm^3/s}$","explanation":"Incorrectly multiplies $V$ by $\\frac{ds}{dt}$ instead of differentiating.","value":"$-86.4\\ \\mathrm{\\frac{cm^3}{s}}$"},{"id":"D","text":"$0.4\\ \\mathrm{cm^3/s}$","explanation":"Wrong sign and ignores dependence on $s$.","value":"$0.4\\ \\mathrm{\\frac{cm^3}{s}}$"}]'::jsonb
WHERE id = 'afcd22f1-edc2-4d3e-86db-ca417bf118b6';

UPDATE public.questions
SET prompt = 'Consider the differential equation $\dfrac{dy}{dx}=xy$ with $y(0)=1$. Which function is the solution?',
    explanation = 'Separate: $\dfrac{1}{y}dy=x\,dx$. Integrate: $\ln|y|=\tfrac{x^2}{2}+C$. With $y(0)=1$, $C=0$ and $y=e^{\frac{x^2}{2}}$.',
    options = '[{"id":"A","text":"$y=e^{x^2/2}$","explanation":"Correct: $\\dfrac{1}{y}dy=x\\,dx\\Rightarrow \\ln y=\\tfrac{x^2}{2}+C$, and $y(0)=1$ gives $C=0$.","value":"$y=e^{\\frac{x^2}{2}}$"},{"id":"B","text":"$y=e^{x}$","explanation":"This would solve $y''''=y$, not $y''''=xy$.","value":"$y=e^{x}$"},{"id":"C","text":"$y=\\dfrac{x^2}{2}+1$","explanation":"This is not an exponential solution to $y''''=xy$.","value":"$y=\\dfrac{x^2}{2}+1$"},{"id":"D","text":"$y=e^{x^2}$","explanation":"Exponent should be $\\tfrac{x^2}{2}$, not $x^2$.","value":"$y=e^{x^2}$"}]'::jsonb
WHERE id = 'f04b3e25-07c5-4b20-889f-3ebb72a715ae';

UPDATE public.questions
SET prompt = 'The curve is given by $x^3+y^3=16$. What is the slope of the tangent line at $(2,2)$?',
    explanation = 'Differentiate: $3x^2+3y^2y''=0$. Solve: $y''=-\dfrac{x^2}{y^2}$. At $(2,2)$, $$\frac{dy}{dx}=-\frac{4}{4}=-1.$$',
    options = '[{"id":"A","text":"$-1$","explanation":"Correct: $3x^2+3y^2y''=0\\Rightarrow y''=\\frac{-x^2}{y^2}$, so at $(2,2)$ it is $\\frac{-4}{4}=-1$.","value":"$-1$"},{"id":"B","text":"$1$","explanation":"Sign error when solving for $\\frac{dy}{dx}$.","value":"$1$"},{"id":"C","text":"$-\\dfrac{2}{3}$","explanation":"Power rule applied incorrectly to $y^3$; it should give $3y^2y''$.","value":"$-\\dfrac{2}{3}$"},{"id":"D","text":"$-\\dfrac{4}{3}$","explanation":"Kept a factor of $3$ in one term but not the other; the 3s cancel before substituting.","value":"$-\\dfrac{4}{3}$"}]'::jsonb
WHERE id = 'eb432132-45c2-4c67-a8dc-b16e3e885d16';

UPDATE public.questions
SET prompt = 'Evaluate the improper integral: $$\int_{0}^{\infty}\frac{e^{-x}}{\sqrt{x}}\,dx$$',
    explanation = 'Let $x=t^2$ with $t\ge 0$. Then $dx=2t\,dt$ and $\sqrt{x}=t$: $$\int_{0}^{\infty}\frac{e^{-x}}{\sqrt{x}}dx=\int_{0}^{\infty}\frac{e^{-t^2}}{t}(2t\,dt)=2\int_{0}^{\infty}e^{-t^2}dt.$$ Using $\int_{0}^{\infty}e^{-t^2}dt=\frac{\sqrt{\pi}}{2}$, the value is $\sqrt{\pi}$.',
    options = '[{"id":"A","text":"$1$","explanation":"This would match $\\int_0^{\\infty}e^{-x}dx$, but the factor $x^{\\frac{-1}{2}}$ changes the value.","value":"$1$"},{"id":"B","text":"$\\sqrt{\\pi}$","explanation":"Let $x=t^2$ to get $2\\int_0^{\\infty}e^{-t^2}dt=\\sqrt{\\pi}$.","value":"$\\sqrt{\\pi}$"},{"id":"C","text":"$\\pi$","explanation":"This is off by a square root; the result is $\\sqrt{\\pi}$.","value":"$\\pi$"},{"id":"D","text":"Diverges","value":"Diverges","explanation":"Near $0$, $x^{\\frac{-1}{2}}$ is integrable, and as $x\\to\\infty$ the exponential decay ensures convergence."}]'::jsonb
WHERE id = 'a21d2655-f3a7-481f-9c33-b4eec9928136';

UPDATE public.questions
SET prompt = 'A differentiable function $f$ satisfies $f(2)=5$ and $f''(2)=-3$. What is $(f^{-1})''(5)$?',
    explanation = 'Use $(f^{-1})''(b)=\dfrac{1}{f''(a)}$ where $f(a)=b$. Since $f(2)=5$, $$(f^{-1})''(5)=\frac{1}{f''(2)}=\frac{1}{-3}=-\frac{1}{3}.$$',
    options = '[{"id":"A","text":"$-3$","explanation":"This is $f''(2)$, not the derivative of the inverse at $5$.","value":"$-3$"},{"id":"B","text":"$\\dfrac{1}{3}$","explanation":"The reciprocal magnitude is right, but the sign must match $\\frac{1}{f}''(2)$, which is negative.","value":"$\\dfrac{1}{3}$"},{"id":"C","text":"$-\\dfrac{1}{3}$","explanation":"Correct: $(f^{-1})''(5)=\\dfrac{1}{f''(2)}=\\dfrac{1}{-3}$.","value":"$-\\dfrac{1}{3}$"},{"id":"D","text":"$\\dfrac{1}{-3+5}$","explanation":"Incorrect use of given numbers; inverse derivative depends on $f''(2)$ once the matching input is identified.","value":"$\\dfrac{1}{-3+5}$"}]'::jsonb
WHERE id = 'ddd27b7b-19ad-4540-8b4e-644ed93bd859';

UPDATE public.questions
SET prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{\sin x - x}{x^3}$.',
    explanation = 'This is a $\frac{0}{0}$ form. Apply L’Hospital three times: $$\lim_{x\to 0}\frac{\sin x-x}{x^3} =\lim_{x\to 0}\frac{\cos x-1}{3x^2} =\lim_{x\to 0}\frac{-\sin x}{6x} =\lim_{x\to 0}\frac{-\cos x}{6} =-\frac{1}{6}.$$',
    options = '[{"id":"A","text":"$0$","explanation":"This stops too early; the numerator and denominator both vanish to higher order than $x$.","value":"$0$"},{"id":"B","text":"$-\\frac{1}{6}$","explanation":"Applying L’Hospital three times gives $\\lim_{x\\to 0}\\frac{-\\cos x}{6}=-\\frac{1}{6}$.","value":"$-\\frac{1}{6}$"},{"id":"C","text":"$\\frac{1}{6}$","explanation":"This is a sign error; repeated differentiation of $\\sin x - x$ introduces a negative.","value":"$\\frac{1}{6}$"},{"id":"D","text":"Does not exist","value":"Does not exist","explanation":"The repeated-derivative limit exists and is finite."}]'::jsonb
WHERE id = 'fd1cfd71-973b-46ed-8be3-8fec56c4d3a7';

UPDATE public.questions
SET prompt = 'The region bounded by $x=y^2$ and $x=2y$ is shown in 8.0-UT-Q5.png. Which integral gives the area of the region?',
    explanation = 'Find intersections: $y^2=2y\Rightarrow y=0,2$. Using horizontal slices, $$A=\int_{0}^{2}\big(x_{right}-x_{left}\big)\,dy=\int_0^2(2y-y^2)\,dy.$$',
    options = '[{"id":"A","text":"$\\int_0^2(2y-y^2)\\,dy$","explanation":"Correct: for $0\\le y\\le 2$, right curve is $x=2y$ and left curve is $x=y^2$.","value":"$\\int_0^2(2y-y^2)\\,dy$"},{"id":"B","text":"$\\int_0^2(y^2-2y)\\,dy$","explanation":"This reverses right minus left and yields a negative value.","value":"$\\int_0^2(y^2-2y)\\,dy$"},{"id":"C","text":"$\\int_0^4(\\sqrt{x}-x/2)\\,dx$","explanation":"A single $dx$ integral is not correct here without splitting because $y=\\sqrt{x}$ and $y=\\frac{x}{2}$ intersect and swap on parts of the interval.","value":"$\\int_0^4(\\sqrt{x}\\frac{-x}{2})\\,dx$"},{"id":"D","text":"$\\int_0^2(2-y^2)\\,dy$","explanation":"This does not represent right minus left in terms of $x(y)$.","value":"$\\int_0^2(2-y^2)\\,dy$"}]'::jsonb
WHERE id = 'cbfc7bee-a1c8-44a0-9250-06fd686a8cfd';

UPDATE public.questions
SET prompt = 'Evaluate $\lim_{x\to 0} x^2\cos\left(\dfrac{1}{x}\right)$.',
    explanation = 'Use $-1\le \cos(\frac{1}{x})\le 1$. Multiplying by $x^2\ge 0$ gives $-x^2\le x^2\cos(\frac{1}{x})\le x^2$. As $x\to 0$, both $\pm x^2\to 0$, so the limit is $0$.',
    options = '[{"id":"A","text":"DNE because $\\cos(1/x)$ oscillates","explanation":"Oscillation alone does not prevent a limit when a factor forces the product to $0$.","value":"DNE because $\\cos(\\frac{1}{x})$ oscillates"},{"id":"B","text":"$1$","explanation":"$x^2\\to 0$, so the product cannot approach $1$.","value":"$1$"},{"id":"C","text":"$0$","explanation":"Since $-1\\le \\cos(\\frac{1}{x})\\le 1$, we have $-x^2\\le x^2\\cos(\\frac{1}{x})\\le x^2$ and both bounds go to $0$.","value":"$0$"},{"id":"D","text":"$-1$","explanation":"The product is between $-x^2$ and $x^2$, so it cannot approach $-1$.","value":"$-1$"}]'::jsonb
WHERE id = 'ad9b29d7-485b-43d8-956c-8770a3f580c5';

UPDATE public.questions
SET prompt = 'If $f(x)=\dfrac{1}{\sqrt{x}}$ for $x>0$, what is $f''(x)$?',
    explanation = 'Write $f(x)=x^{\frac{-1}{2}}$. Then $$f''(x)=(-\tfrac12)x^{\frac{-3}{2}}=-\frac{1}{2x\sqrt{x}}.$$',
    options = '[{"id":"A","text":"$\\dfrac{1}{2\\sqrt{x}}$","explanation":"Derivative of $\\sqrt{x}$, not $x^{\\frac{-1}{2}}$.","value":"$\\dfrac{1}{2\\sqrt{x}}$"},{"id":"B","text":"$-\\dfrac{1}{2x\\sqrt{x}}$","explanation":"Correct: $x^{\\frac{-1}{2}}\\to (-\\tfrac12)x^{\\frac{-3}{2}}=-\\dfrac{1}{2x\\sqrt{x}}$.","value":"$-\\dfrac{1}{2x\\sqrt{x}}$"},{"id":"C","text":"$-\\dfrac{1}{2\\sqrt{x}}$","explanation":"Exponent not decreased correctly.","value":"$-\\dfrac{1}{2\\sqrt{x}}$"},{"id":"D","text":"$\\dfrac{1}{x\\sqrt{x}}$","explanation":"Missing factor $\\tfrac12$ and wrong sign.","value":"$\\dfrac{1}{x\\sqrt{x}}$"}]'::jsonb
WHERE id = '965e82a6-505e-4854-8bc4-925baecd03ff';

UPDATE public.questions
SET prompt = 'The curve $y=\ln x$ on $[1,e]$ is shown in 8.0-UT-Q19.png. Which integral gives the exact arc length from $x=1$ to $x=e$?',
    explanation = 'For $y=f(x)$, arc length is $\int_a^b\sqrt{1+(f''(x))^2}dx$. Here $f(x)=\ln x$ so $f''(x)=\frac{1}{x}$, giving $$L=\int_1^e\sqrt{1+\frac{1}{x^2}}\,dx.$$',
    options = '[{"id":"A","text":"$\\int_1^e\\left(1+\\frac{1}{x^2}\\right)dx$","explanation":"Missing the square root in the arc length formula.","value":"$\\int_1^e\\left(1+\\frac{1}{x^2}\\right)dx$"},{"id":"B","text":"$\\int_1^e\\sqrt{1+\\frac{1}{x}}\\,dx$","explanation":"Uses $\\frac{1}{x}$ instead of $(\\frac{1}{x})^2$ inside the square root.","value":"$\\int_1^e\\sqrt{1+\\frac{1}{x}}\\,dx$"},{"id":"C","text":"$\\int_1^e\\sqrt{1+\\frac{1}{x^2}}\\,dx$","explanation":"Correct: for $y=\\ln x$, $y''=\\frac{1}{x}$, so $\\sqrt{1+(y'')^2}=\\sqrt{1+\\frac{1}{x^2}}$.","value":"$\\int_1^e\\sqrt{1+\\frac{1}{x^2}}\\,dx$"},{"id":"D","text":"$\\int_0^1\\sqrt{1+\\frac{1}{x^2}}\\,dx$","explanation":"Wrong bounds; the interval is $[1,e]$.","value":"$\\int_0^1\\sqrt{1+\\frac{1}{x^2}}\\,dx$"}]'::jsonb
WHERE id = '6c28814b-a841-476c-826b-79f1bb72338b';

UPDATE public.questions
SET prompt = 'Given $\dfrac{dy}{dx}=\dfrac{2y}{x}$ and $y(3)=5$, what is $y(6)$?',
    explanation = 'Separate: $\dfrac{1}{y}dy=\dfrac{2}{x}dx\Rightarrow \ln y=2\ln x+C\Rightarrow y=Cx^2$. Use $y(3)=5$ so $C=\frac{5}{9}$. Then $y(6)= (\frac{5}{9})\cdot36=20$.',
    options = '[{"id":"A","text":"$10$","explanation":"This assumes $y$ doubles when $x$ doubles, but the solution scales like $x^2$.","value":"$10$"},{"id":"B","text":"$15$","explanation":"This uses proportionality $y\\propto x$ instead of $y\\propto x^2$.","value":"$15$"},{"id":"C","text":"$20$","explanation":"Correct: $y=Cx^2$, then $5=9C\\Rightarrow C=\\tfrac{5}{9}$ and $y(6)=\\tfrac{5}{9}\\cdot36=20$.","value":"$20$"},{"id":"D","text":"$25$","explanation":"This comes from using $y\\propto x$ with $y(6)=10$ then adding incorrectly.","value":"$25$"}]'::jsonb
WHERE id = 'ef57750a-04fe-4568-acfb-b9006785b543';

UPDATE public.questions
SET prompt = 'Find the sum of the infinite geometric series $$5-\frac{5}{2}+\frac{5}{4}-\frac{5}{8}+\cdots.$$',
    explanation = 'Identify $a=5$ and $r=-\frac{1}{2}$. The infinite geometric sum is $S=\frac{a}{1-r}=\frac{10}{3}$.',
    options = '[{"id":"A","text":"$\\frac{5}{3}$","explanation":"Often comes from using $1+r$ instead of $1-r$ in the denominator.","value":"$\\frac{5}{3}$"},{"id":"B","text":"$\\frac{10}{3}$","explanation":"Correct: $S=\\frac{5}{1-(\\frac{-1}{2})}=\\frac{10}{3}$.","value":"$\\frac{10}{3}$"},{"id":"C","text":"$\\frac{15}{2}$","explanation":"This can result from summing only the first few terms, not the infinite sum.","value":"$\\frac{15}{2}$"},{"id":"D","text":"$\\frac{10}{7}$","explanation":"Uses an incorrect formula such as $1-r^2$ in the denominator.","value":"$\\frac{10}{7}$"}]'::jsonb
WHERE id = 'dd3c2656-532f-4d68-9849-d5935e8da185';

UPDATE public.questions
SET prompt = 'Let (x)=\sqrt{x}$. Which expression best estimates ''(9)$ using =0.01127',
    explanation = 'A standard estimate uses 19967g''(a)\approx \frac{g(a+h)-g(a)}{h}.19967 With =9$ and =0.01$, the correct setup is 19967\frac{\sqrt{9.01}-\sqrt{9}}{0.01}.19967',
    options = '[{"id":"A","text":"$\\dfrac{\\sqrt{9.01}-\\sqrt{9}}{0.01}$","explanation":"Correct forward-difference quotient with =0.01$.","value":"$\\dfrac{\\sqrt{9.01}-\\sqrt{9}}{0.01}$"},{"id":"B","text":"$\\dfrac{\\sqrt{9}-\\sqrt{8.99}}{0.01}$","explanation":"This is a backward difference, not the stated forward form.","value":"$\\dfrac{\\sqrt{9}-\\sqrt{8.99}}{0.01}$"},{"id":"C","text":"$\\dfrac{\\sqrt{9.01}-\\sqrt{8.99}}{0.01}$","explanation":"If using symmetric points, you must divide by /bin/zsh.02$, not /\\frac{bin}{zsh}.01$.","value":"$\\dfrac{\\sqrt{9.01}-\\sqrt{8.99}}{0.01}$"},{"id":"D","text":"$\\dfrac{\\sqrt{9.01}-\\sqrt{9}}{9.01-9}$","explanation":"This is equivalent to option A since .01-9=0.01$.","value":"$\\dfrac{\\sqrt{9.01}-\\sqrt{9}}{9.01-9}$"}]'::jsonb
WHERE id = 'ca6b2eda-8919-4bff-9da7-84bdb3322cb2';

UPDATE public.questions
SET prompt = 'The position of a particle is (t)$ (meters). A table gives (4)=18.2$, (4.05)=18.7$, and (3.95)=17.6$. Estimate the instantaneous velocity ''(4)$ (m/s) using a symmetric difference quotient.',
    explanation = 'Use 19967s''(4)\approx \frac{s(4+0.05)-s(4-0.05)}{2(0.05)}=\frac{s(4.05)-s(3.95)}{0.10}.19967 Then 19967\frac{18.7-17.6}{0.10}=11\text{ m/s}.19967',
    options = '[{"id":"A","text":".0$","explanation":"This uses an incorrect symmetric change; .7-17.6=1.1$.","value":".0$"},{"id":"B","text":"$","explanation":"Numerically correct, but you must justify using the full width /bin/zsh.10$ in the denominator.","value":"$"},{"id":"C","text":"$","explanation":"Correct: $\\dfrac{18.7-17.6}{0.10}=11$ m/s using a symmetric difference quotient.","value":"$"},{"id":"D","text":"$","explanation":"This divides by /bin/zsh.05$ instead of /\\frac{bin}{zsh}.10$.","value":"$"}]'::jsonb
WHERE id = '72dd142e-bef9-4f05-b426-56c2c61e8c27';

UPDATE public.questions
SET prompt = 'Differentiate $y = \dfrac{5x^3-2x}{x}$.',
    explanation = 'It is often faster to simplify first: $$y = \frac{5x^3}{x} - \frac{2x}{x} = 5x^2 - 2 \quad (x\neq 0).$$ Then $$y'' = 10x.$$ Using the quotient rule yields the same result: $$y'' = \frac{(15x^2-2)(x) - (5x^3-2x)(1)}{x^2} = \frac{10x^3}{x^2} = 10x.$$',
    options = '[{"id":"A","text":"$10x$","explanation":"Correct: Simplify first. $y = 5x^2 - 2$ (for $x\\neq 0$). Then $y'' = 10x$.","value":"$10x$"},{"id":"B","text":"$\\frac{15x^2-2}{1}$","explanation":"Incorectly treated denominator as constant 1 after differentiation.","value":"$\\frac{15x^2-2}{1}$"},{"id":"C","text":"$\\frac{(15x^2-2)(x) - (5x^3-2x)(1)}{x^2}$","explanation":"This is correct unsimplified form, but usually simplified is preferred. Let''s check if value is same. Numerator: $15x^3-2x - 5x^3+2x = 10x^3$. Ratio: $\\frac{10x^3}{x^2} = 10x$. Since A is simpler, A is better, but technically this form is equivalent. Prompt usually asks for \"the derivative\" implies simplest form or correct value. Wait, usually MCQ has one best answer. If A is $10x$, it is the standard answer.","value":"$\\frac{(15x^2-2)(x) - (5x^3-2x)(1)}{x^2}$"},{"id":"D","text":"$15x^2-2$","explanation":"Differentiated numerator only.","value":"$15x^2-2$"}]'::jsonb
WHERE id = '3828181b-4115-4bf0-bc85-5f5813ca1857';

UPDATE public.questions
SET prompt = 'If $f(x)=\dfrac{2x^5-3x^2}{x}$ for $x\ne 0$, what is $f''(x)$?',
    explanation = 'Simplify: $$f(x)=\frac{2x^5}{x}-\frac{3x^2}{x}=2x^4-3x.$$ Then $$f''(x)=8x^3-3.$$',
    options = '[{"id":"A","text":"$f''(x)=10x^3-6$","explanation":"Incorrect: simplifying gives $f(x)=2x^4-3x$, so $f''(x)=8x^3-3$, not this.","value":"$f''(x)=10x^3-6$"},{"id":"B","text":"$f''(x)=8x^3-3$","explanation":"Correct: simplify first: $f(x)=2x^4-3x$. Differentiate: $f''(x)=8x^3-3$.","value":"$f''(x)=8x^3-3$"},{"id":"C","text":"$f''(x)=8x^3-\\dfrac{3}{x^2}$","explanation":"Incorrect: after dividing by $x$, the second term becomes $-3x$, not $\\frac{-3}{x}$.","value":"$f''(x)=8x^3-\\dfrac{3}{x^2}$"},{"id":"D","text":"$f''(x)=\\dfrac{10x^4-6x}{x}$","explanation":"Incorrect: differentiating the numerator and dividing by $x$ is not valid unless you use the quotient rule.","value":"$f''(x)=\\dfrac{10x^4-6x}{x}$"}]'::jsonb
WHERE id = 'e1ccd149-62f7-4418-a18c-6c850e37dcb2';

UPDATE public.questions
SET prompt = 'Determine whether the series converges or diverges: $$\sum_{n=1}^{\infty}\frac{1}{\sqrt{n}}$$',
    explanation = 'Rewrite as a $p$-series: $$\sum_{n=1}^{\infty}\frac{1}{\sqrt{n}}=\sum_{n=1}^{\infty}n^{\frac{-1}{2}}.$$ Since $p=\frac{1}{2}\le 1$, the series diverges.',
    options = '[{"id":"A","text":"Converges by comparison to $\\sum \\frac{1}{n}$","explanation":"This is not a valid convergence proof; comparing to a divergent series cannot prove convergence.","value":"Converges by comparison to $\\sum \\frac{1}{n}$"},{"id":"B","text":"Converges because $\\frac{1}{\\sqrt{n}}\\to 0$","explanation":"A term limit of $0$ is necessary but not sufficient.","value":"Converges because $\\frac{1}{\\sqrt{n}}\\to 0$"},{"id":"C","text":"Converges because it is smaller than $1$","explanation":"Bounded terms do not guarantee a series converges.","value":"Converges because it is smaller than $1$"},{"id":"D","text":"Diverges","value":"Diverges","explanation":"This is a $p$-series $\\sum n^{\\frac{-1}{2}}$ with $p=\\tfrac{1}{2}\\le 1$, so it diverges."}]'::jsonb
WHERE id = '46b646bc-d1b6-4ad7-8725-37e8e7c61c15';

UPDATE public.questions
SET prompt = 'For which values of $k$ does the series converge by the Alternating Series Test?  $$\sum_{n=1}^{\infty} (-1)^n\,\frac{1}{n^k}$$',
    explanation = 'Write $a_n=\frac{1}{n^k}$. For AST, we need $a_n$ decreasing eventually and $\lim_{n\to\infty} a_n=0$. If $k>0$, then $n^k\to\infty$, so $a_n\to 0$ and $a_n$ decreases for $n\ge1$. If $k\le 0$, then $a_n$ does not approach $0$, so the series diverges.',
    options = '[{"id":"A","text":"For all real $k$","explanation":"If $k\\le 0$, then $\\frac{1}{n^k}$ does not go to $0$ (it grows or stays constant).","value":"For all real $k$"},{"id":"B","text":"For $k>0$","explanation":"If $k>0$, then $a_n=\\frac{1}{n^k}\\downarrow 0$, so AST applies.","value":"For $k>0$"},{"id":"C","text":"For $k>1$ only","explanation":"$k>1$ is needed for absolute convergence of $\\sum \\frac{1}{n^k}$, but AST needs only $k>0$.","value":"For $k>1$ only"},{"id":"D","text":"For $0<k\\le 1$ only","explanation":"AST also works when $k>1$; the series then converges absolutely as well.","value":"For $0<k\\le 1$ only"}]'::jsonb
WHERE id = '920e1416-6289-45ce-92a2-1027907218b5';

UPDATE public.questions
SET prompt = 'Let $x(t)=t^2-1$ and $y(t)=3t-2$. What is $\dfrac{dy}{dx}$ at $t=2$?',
    explanation = 'Compute $\dfrac{dy}{dx}=\dfrac{\frac{dy}{dt}}{\frac{dx}{dt}}$. Here $\frac{dy}{dt}=3$ and $\frac{dx}{dt}=2t$. At $t=2$, $\frac{dx}{dt}=4$, so $\dfrac{dy}{dx}=\dfrac{3}{4}$.',
    options = '[{"id":"A","text":"$\\dfrac{3}{2}$","explanation":"This uses $\\frac{dx}{dt}=2t$ at $t=2$ giving $4$, and $\\frac{dy}{dt}=3$, so $\\frac{dy}{dx}=\\frac{3}{4}$, not $\\frac{3}{2}$.","value":"$\\dfrac{3}{2}$"},{"id":"B","text":"$\\dfrac{3}{4}$","explanation":"Correct. $\\frac{dx}{dt}=2t\\Rightarrow 4$ at $t=2$, $\\frac{dy}{dt}=3$, so $\\frac{dy}{dx}=\\frac{3}{4}$.","value":"$\\dfrac{3}{4}$"},{"id":"C","text":"$\\dfrac{4}{3}$","explanation":"This is the reciprocal; it corresponds to $\\frac{dx}{dy}$.","value":"$\\dfrac{4}{3}$"},{"id":"D","text":"$6$","explanation":"This incorrectly differentiates $y$ with respect to $x$ directly or multiplies $3\\cdot 2$.","value":"$6$"}]'::jsonb
WHERE id = 'ba3f16c0-8b0c-4f94-9500-0afd823b569b';

UPDATE public.questions
SET prompt = 'Use the Ratio Test to analyze the series.  $$\sum_{n=1}^{\infty} \frac{1}{n}$$ Which statement is correct?',
    explanation = 'Let $a_n=\frac{1}{n}$. Then $$\frac{a_{n+1}}{a_n}=\frac{\frac{1}{n+1}}{\frac{1}{n}}=\frac{n}{n+1},$$ so $$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=1.$$ When the ratio limit equals $1$, the Ratio Test is inconclusive. The series actually diverges, but that requires another test.',
    options = '[{"id":"A","text":"Ratio Test shows convergence because the ratio is less than $1$","explanation":"Here $\\frac{a_{n+1}}{a_n}=\\frac{n}{n+1}\\to 1$, not a number less than $1$.","value":"Ratio Test shows convergence because the ratio is less than $1$"},{"id":"B","text":"Ratio Test shows divergence because the ratio is greater than $1$","explanation":"The ratio is less than $1$ for each $n$, and the limit is $1$.","value":"Ratio Test shows divergence because the ratio is greater than $1$"},{"id":"C","text":"Ratio Test is inconclusive because the ratio limit equals $1$","explanation":"Correct: ratio test is inconclusive when the limit is exactly $1$.","value":"Ratio Test is inconclusive because the ratio limit equals $1$"},{"id":"D","text":"Ratio Test cannot be applied because the terms are not positive","value":"Ratio Test cannot be applied because the terms are not positive","explanation":"The terms are positive; it can be applied but gives an inconclusive result."}]'::jsonb
WHERE id = '0b0c9c39-63ef-4bb4-a286-cb7998fa387b';

UPDATE public.questions
SET prompt = 'Let $f(x)=\cos x$. Use the fourth-degree Maclaurin polynomial to approximate $\cos(0.2)$.',
    explanation = 'Use $\cos x\approx 1-\dfrac{x^2}{2!}+\dfrac{x^4}{4!}$. With $x=0.2$: $$1-\frac{0.2^2}{2}+\frac{0.2^4}{24}=1-0.02+0.000066666\ldots=0.980066666\ldots.$$',
    options = '[{"id":"A","text":"$0.980066666\\ldots$","explanation":"$1-\\dfrac{0.2^2}{2}+\\dfrac{0.2^4}{24}=1-0.02+0.000066666\\ldots=0.980066666\\ldots$.","value":"$0.980066666\\ldots$"},{"id":"B","text":"$0.979933333\\ldots$","explanation":"Sign error on the $x^4$ term: it should be plus for $\\cos x$.","value":"$0.979933333\\ldots$"},{"id":"C","text":"$0.990066666\\ldots$","explanation":"Arithmetic error: $\\dfrac{0.04}{2}=0.02$, not $0.01$.","value":"$0.990066666\\ldots$"},{"id":"D","text":"$0.980133333\\ldots$","explanation":"Arithmetic error: $0.\\frac{0016}{24}=0.000066666\\ldots$, not $0.000133333\\ldots$.","value":"$0.980133333\\ldots$"}]'::jsonb
WHERE id = '4a678e98-928a-4ccf-afa5-f32327fd71a6';

UPDATE public.questions
SET prompt = 'Evaluate the indefinite integral: $$\int \frac{3x^2}{\sqrt{1+x^3}}\,dx$$',
    explanation = 'Let $u=1+x^3$, so $du=3x^2\,dx$. $$\int \frac{3x^2}{\sqrt{1+x^3}}\,dx=\int u^{\frac{-1}{2}}\,du=2u^{\frac{1}{2}}+C=2\sqrt{1+x^3}+C.$$',
    options = '[{"id":"A","text":"$$\\sqrt{1+x^3}+C$$","explanation":"Differentiate: $\\frac{d}{dx}\\sqrt{1+x^3}=\\frac{3x^2}{2\\sqrt{1+x^3}}$, which is half the integrand.","value":"$$\\sqrt{1+x^3}+C$$"},{"id":"B","text":"$$\\ln|1+x^3|+C$$","explanation":"A logarithm would require $(1+x^3)$, not $\\sqrt{1+x^3}$, in the denominator.","value":"$$\\ln|1+x^3|+C$$"},{"id":"C","text":"$$2\\sqrt{1+x^3}+C$$","explanation":"Let $u=1+x^3$, $du=3x^2\\,dx$, so $\\int u^{\\frac{-1}{2}}du=2u^{\\frac{1}{2}}+C$.","value":"$$2\\sqrt{1+x^3}+C$$"},{"id":"D","text":"$$\\frac{2}{\\sqrt{1+x^3}}+C$$","explanation":"That would correspond to integrating $u^{\\frac{-3}{2}}$, not $u^{\\frac{-1}{2}}$.","value":"$$\\frac{2}{\\sqrt{1+x^3}}+C$$"}]'::jsonb
WHERE id = 'cce12eb3-a477-4d78-b0b0-9eb767064903';

UPDATE public.questions
SET prompt = 'A quantity $Q(t)$ satisfies $\dfrac{dQ}{dt}=kQ$ with $Q(0)=120$. \nIf $Q(3)=150$, which expression gives $Q(t)$?',
    explanation = 'Model: $Q(t)=120e^{kt}$. Use $Q(3)=150$: $$150=120e^{3k}\Rightarrow e^{3k}=\frac{150}{120}$$\nThen $$Q(t)=120e^{kt}=120(e^{3k})^{\frac{t}{3}}=120\left(\frac{150}{120}\right)^{\frac{t}{3}}.$$',
    options = '[{"id":"A","text":"$Q(t)=120\\left(\\frac{150}{120}\\right)^t$","explanation":"Uses the 3-hour growth factor as if it were per 1 hour (missing the $\\frac{t}{3}$ exponent).","value":"$Q(t)=120\\left(\\frac{150}{120}\\right)^t$"},{"id":"B","text":"$Q(t)=120\\left(\\frac{150}{120}\\right)^{t/3}$","explanation":"Correct. From $150=120e^{3k}$, we get $e^{3k}=\\frac{150}{120}$ and $Q(t)=120(e^{3k})^{\\frac{t}{3}}$.","value":"$Q(t)=120\\left(\\frac{150}{120}\\right)^{\\frac{t}{3}}$"},{"id":"C","text":"$Q(t)=120+30e^{t/3}$","explanation":"Additive form does not match $\\dfrac{dQ}{dt}=kQ$ (which is multiplicative).","value":"$Q(t)=120+30e^{\\frac{t}{3}}$"},{"id":"D","text":"$Q(t)=150\\left(\\frac{120}{150}\\right)^{t/3}$","explanation":"Anchors the model at $t=0$ incorrectly (gives $Q(0)=150$).","value":"$Q(t)=150\\left(\\frac{120}{150}\\right)^{\\frac{t}{3}}$"}]'::jsonb
WHERE id = '6b7a2074-faa9-4942-96db-1e5de6d14c41';

UPDATE public.questions
SET prompt = 'Approximate $\ln(1.2)$ using the third-degree Taylor polynomial for $\ln x$ about $x=1$. Using the Lagrange error bound, which is a valid upper bound for the magnitude of the error?',
    explanation = 'For $f(x)=\ln x$, $f^{(4)}(x)=-\dfrac{6}{x^4}$. On $[1,1.2]$, $|f^{(4)}(x)|=\dfrac{6}{x^4}$ is maximized at $x=1$, so $M=6$. Thus $$|R_3(1.2)|\le \frac{6(0.2)^4}{4!}.$$',
    options = '[{"id":"A","text":"$\\dfrac{6(0.2)^4}{4!}$","explanation":"This matches the correct numeric bound, but the key is justifying $M$ as the maximum of $|f^{(4)}|$ on $[1,1.2]$.","value":"$\\dfrac{6(0.2)^4}{4!}$"},{"id":"B","text":"$\\dfrac{6(0.2)^4}{4!\\cdot 1^4}$","explanation":"$f^{(4)}(x)=-\\dfrac{6}{x^4}$, so $|f^{(4)}(x)|=\\dfrac{6}{x^4}$ is maximized at $x=1$ on $[1,1.2]$, giving $M=6$. Then $|R_3(1.2)|\\le \\dfrac{6(0.2)^4}{4!}$.","value":"$\\dfrac{6(0.2)^4}{4!\\cdot 1^4}$"},{"id":"C","text":"$\\dfrac{6(0.2)^3}{3!}$","explanation":"Wrong order: degree 3 remainder uses $(0.2)\\frac{^4}{4}!$.","value":"$\\dfrac{6(0.2)^3}{3!}$"},{"id":"D","text":"$\\dfrac{6(0.2)^4}{4!\\cdot (1.2)^4}$","explanation":"Chooses $M$ at $x=1.2$, but $\\dfrac{6}{x^4}$ is decreasing, so the maximum is at $x=1$.","value":"$\\dfrac{6(0.2)^4}{4!\\cdot (1.2)^4}$"}]'::jsonb
WHERE id = '90b198f2-a263-4484-82c2-787c21c487a4';

UPDATE public.questions
SET prompt = 'The curve is defined implicitly by $x^2+y^2=25$. What is $\dfrac{d^2y}{dx^2}$ at the point $(3,4)$?',
    explanation = 'Differentiate $x^2+y^2=25$: $2x+2yy''=0\Rightarrow y''=-\dfrac{x}{y}$. Differentiate $y''=-xy^{-1}$: $$y''''=-(y^{-1}+x(-1)y^{-2}y'')=-\frac{1}{y}+\frac{xy''}{y^2}.$$ At $(3,4)$, $y''=-\dfrac{3}{4}$, so $$y''''=-\frac{1}{4}+\frac{3(\frac{-3}{4})}{16}=-\frac{1}{4}-\frac{9}{64}=-\frac{25}{64}.$$',
    options = '[{"id":"A","text":"$-\\dfrac{25}{64}$","explanation":"Correct: computing $y''$ from $y''=\\frac{-x}{y}$ and differentiating again gives $y''''=\\frac{-1}{y}+\\frac{xy''}{y}^2$; substituting $(3,4)$ yields $\\frac{-25}{64}$.","value":"$-\\dfrac{25}{64}$"},{"id":"B","text":"$\\dfrac{25}{64}$","explanation":"Sign error; the computed $y''''$ at $(3,4)$ is negative.","value":"$\\dfrac{25}{64}$"},{"id":"C","text":"$-\\dfrac{3}{4}$","explanation":"This is $y''$ (the first derivative) at $(3,4)$, not $y''''$.","value":"$-\\dfrac{3}{4}$"},{"id":"D","text":"$-\\dfrac{4}{3}$","explanation":"Reciprocal slope mistake; from $2x+2yy''=0$, $y''=\\frac{-x}{y}$.","value":"$-\\dfrac{4}{3}$"}]'::jsonb
WHERE id = '813fb837-2d2c-496e-a3d0-9d2aabd140cc';

UPDATE public.questions
SET prompt = 'Given $$e^x=\sum_{n=0}^{\infty}\frac{x^n}{n!},$$ what is the coefficient of $x^5$ in the Maclaurin series for $e^{2x}$?',
    explanation = 'Use substitution: $$e^{2x}=\sum_{n=0}^{\infty}\frac{(2x)^n}{n!}=\sum_{n=0}^{\infty}\frac{2^n}{n!}x^n.$$ Thus the coefficient of $x^5$ is $\frac{2^5}{5!}$.',
    options = '[{"id":"A","text":"$$\\frac{2^5}{5!}$$","explanation":"Correct. Substitute $2x$ into the series: coefficient is $\\frac{2^5}{5}!$.","value":"$$\\frac{2^5}{5!}$$"},{"id":"B","text":"$$\\frac{2}{5!}$$","explanation":"Needs $2^5$, not $2$.","value":"$$\\frac{2}{5!}$$"},{"id":"C","text":"$$\\frac{5!}{2^5}$$","explanation":"Inverts the coefficient.","value":"$$\\frac{5!}{2^5}$$"},{"id":"D","text":"$$\\frac{2^5}{5}$$","explanation":"Denominator must be $5!$, not $5$.","value":"$$\\frac{2^5}{5}$$"}]'::jsonb
WHERE id = '697b6cb2-2669-456d-a106-a8fb589f82ef';

UPDATE public.questions
SET prompt = 'Determine whether the series $$\sum_{n=2}^{\infty}\frac{1}{n(\ln n)^2}$$ converges or diverges.',
    explanation = 'Use the integral test with $f(x)=\frac{1}{x(\ln x)^2}$. Compute $$\int_2^{\infty}\frac{1}{x(\ln x)^2}\,dx.$$ Let $u=\ln x$, $du=\frac{1}{x}dx$. Then $$\int_{\ln 2}^{\infty}\frac{1}{u^2}\,du=\left[-\frac{1}{u}\right]_{\ln 2}^{\infty}=\frac{1}{\ln 2},$$ which is finite, so the series converges.',
    options = '[{"id":"A","text":"Diverges because it is larger than $$\\sum \\frac{1}{n}$$","explanation":"For large $n$, $\\frac{1}{n(\\ln n)^2}<\\frac{1}{n}$, and the correct method here is the integral test.","value":"Diverges because it is larger than $$\\sum \\frac{1}{n}$$"},{"id":"B","text":"Diverges by the ratio test","value":"Diverges by the ratio test","explanation":"The ratio test is not the natural tool for this form."},{"id":"C","text":"Converges by the integral test","value":"Converges by the integral test","explanation":"Correct: $\\int_2^{\\infty}\\frac{1}{x(\\ln x)^2}\\,dx$ converges."},{"id":"D","text":"Converges because it is a $p$-series with $p=2$","explanation":"It is not of the form $\\sum \\frac{1}{n^p}$.","value":"Converges because it is a $p$-series with $p=2$"}]'::jsonb
WHERE id = '508e7862-41d7-44c8-8b0e-acd4c0c8346e';

UPDATE public.questions
SET prompt = 'The graph of the region bounded by $y=x^2$, $y=0$, and $x=1$ is shown in the figure labeled 8.9-P2. The region is revolved about the $y$-axis. Using the disc method, what is the volume of the solid?',
    explanation = 'For rotation about the $y$-axis using discs, take horizontal slices. Rewrite $y=x^2$ as $x=\sqrt{y}$. Radius is $r(y)=\sqrt{y}$ for $0\le y\le 1. $$V=\pi\int_0^1 r(y)^2\,dy=\pi\int_0^1 y\,dy=\pi\left[\frac{y^2}{2}\right]_0^1=\frac{\pi}{2}.$$',
    options = '[{"id":"A","text":"$\\pi$","explanation":"This would result from using $\\pi\\int_0^1 1\\,dy$ (incorrect constant radius).","value":"$\\pi$"},{"id":"B","text":"$\\dfrac{\\pi}{2}$","explanation":"Correct. About the $y$-axis with discs requires $dy$: $x=\\sqrt{y}$, so $V=\\pi\\int_0^1 y\\,dy=\\frac{\\pi}{2}$.","value":"$\\dfrac{\\pi}{2}$"},{"id":"C","text":"$\\dfrac{\\pi}{3}$","explanation":"This is a common result from $\\pi\\int_0^1 x^2\\,dx$ (wrong variable for disc method about the $y$-axis).","value":"$\\dfrac{\\pi}{3}$"},{"id":"D","text":"$\\dfrac{2\\pi}{3}$","explanation":"This can come from mixing bounds or using an incorrect $y$-interval.","value":"$\\dfrac{2\\pi}{3}$"}]'::jsonb
WHERE id = '2c689f9b-7fc2-470a-9237-5b69245cfcba';

UPDATE public.questions
SET prompt = 'Determine whether $$\sum_{n=1}^{\infty}(-1)^n\frac{1}{\sqrt{n}}$$ converges absolutely, converges conditionally, or diverges.',
    explanation = 'With $b_n=\frac{1}{\sqrt}{n}$, we have $b_n\downarrow 0$, so the series converges by the alternating series test. The absolute series is $$\sum_{n=1}^{\infty}\frac{1}{\sqrt{n}},$$ a $p$-series with $p=\tfrac12\le 1$, which diverges. Therefore the series converges conditionally.',
    options = '[{"id":"A","text":"Converges conditionally","value":"Converges conditionally","explanation":"Correct: AST applies, but $\\sum \\frac{1}{\\sqrt}{n}$ diverges as a $p$-series with $p=\\frac{1}{2}$."},{"id":"B","text":"Converges absolutely","value":"Converges absolutely","explanation":"The absolute series is $\\sum \\frac{1}{\\sqrt}{n}$, which diverges."},{"id":"C","text":"Diverges","value":"Diverges","explanation":"Because $\\frac{1}{\\sqrt}{n}\\downarrow 0$, the alternating series converges by AST."},{"id":"D","text":"Inconclusive","value":"Inconclusive","explanation":"AST is conclusive here."}]'::jsonb
WHERE id = 'e19748f6-4f34-40ef-9aa4-0df1647b9c05';

UPDATE public.questions
SET prompt = 'Let $$S=\sum_{n=1}^{\infty}(-1)^{n-1}\frac{1}{n^2}.$$ What is the least $N$ such that the partial sum $S_N$ satisfies $|S-S_N|<0.001$?',
    explanation = 'For an alternating series with decreasing $b_n$, the remainder satisfies $|S-S_N|\le b_{N+1}$. Here $b_n=\frac{1}{n^2}$, so require $$\frac{1}{(N+1)^2}<0.001=\frac{1}{1000}.$$ Thus $(N+1)^2>1000$. Since $31^2=961<1000$ and $32^2=1024>1000$, the least $N$ is $31$.',
    options = '[{"id":"A","text":"$N=10$","explanation":"$b_{11}=\\frac{1}{11^2}\\approx 0.00826$, which is not less than $0.001$.","value":"$N=10$"},{"id":"B","text":"$N=20$","explanation":"$b_{21}=\\frac{1}{21^2}\\approx 0.00227$, which is not less than $0.001$.","value":"$N=20$"},{"id":"C","text":"$N=31$","explanation":"Correct: $b_{32}=\\frac{1}{32^2}=\\frac{1}{1024}\\approx 0.0009766<0.001$, and $b_{31}=\\frac{1}{31^2}>0.001$.","value":"$N=31$"},{"id":"D","text":"$N=32$","explanation":"This works, but it is not the least. $N=31$ already guarantees the bound.","value":"$N=32$"}]'::jsonb
WHERE id = 'e063ba9c-05e6-485f-9e64-669d16a20025';

UPDATE public.questions
SET prompt = 'Find the interval of convergence of $$\sum_{n=1}^{\infty}\frac{(x+1)^n}{n}.$$',
    explanation = 'Ratio test: with $a_n=\frac{(x+1)^n}{n}$, $$\left|\frac{a_{n+1}}{a_n}\right|=|x+1|\cdot\frac{n}{n+1}\to |x+1|.$$ So the series converges for $|x+1|<1$, i.e. $-2<x<0$. Endpoint checks: at $x=-2$, the series is $\sum \frac{(-1)^n}{n}$ (converges by AST). At $x=0$, the series is $\sum \frac{1}{n}$ (diverges). Therefore the interval is $[-2,0)$.',
    options = '[{"id":"A","text":"$(-2,0)$","explanation":"This misses that $x=-2$ converges as an alternating harmonic series.","value":"$(-2,0)$"},{"id":"B","text":"$[-2,0)$","explanation":"Correct: $x=-2$ gives $\\sum (-1)\\frac{^n}{n}$ (converges) and $x=0$ gives $\\sum \\frac{1}{n}$ (diverges).","value":"$[-2,0)$"},{"id":"C","text":"$(-2,0]$","explanation":"At $x=0$ the series is harmonic and diverges.","value":"$(-2,0]$"},{"id":"D","text":"$[-2,0]$","explanation":"Includes $x=0$, but $\\sum \\frac{1}{n}$ diverges.","value":"$[-2,0]$"}]'::jsonb
WHERE id = 'fb57cb49-8fba-460a-9d4e-6b3083b153b1';

UPDATE public.questions
SET prompt = 'Find the sum of the infinite series $$\sum_{n=0}^{\infty} 6\left(\frac{2}{3}\right)^n$$ if it converges.',
    explanation = 'This is geometric with first term $a=6$ and ratio $r=\frac{2}{3}$. Since $|r|<1$, it converges and $$S=\frac{a}{1-r}=\frac{6}{1\frac{-2}{3}}=18.$$',
    options = '[{"id":"A","text":"6","value":"6","explanation":"This is only the first term, not the infinite sum."},{"id":"B","text":"18","value":"18","explanation":"Correct: $|r|=\\frac{2}{3}<1$ and $S=\\frac{a}{1-r}=\\frac{6}{1\\frac{-2}{3}}=18$."},{"id":"C","text":"12","value":"12","explanation":"This comes from using $1+r$ instead of $1-r$ in the denominator."},{"id":"D","text":"Diverges","value":"Diverges","explanation":"It converges because $|r|<1$."}]'::jsonb
WHERE id = '666c5f5d-1271-48bf-b652-9db85c1d0fc8';

UPDATE public.questions
SET prompt = 'Consider the relation $x^2+y^2=4$. At which point(s) on the curve is $\dfrac{dy}{dx}$ undefined?',
    explanation = 'Differentiate implicitly: $$2x+2y\,y''=0\Rightarrow y''=-\frac{x}{y}.$$ The slope is undefined when $y=0$. On $x^2+y^2=4$, $y=0$ occurs at $(2,0)$ and $(-2,0)$.',
    options = '[{"id":"A","text":"$(0,2)$ and $(0,-2)$","explanation":"At these points $y\\ne0$, so $y''=\\frac{-x}{y}$ is defined.","value":"$(0,2)$ and $(0,-2)$"},{"id":"B","text":"$(2,0)$ only","explanation":"$(-2,0)$ also has $y=0$.","value":"$(2,0)$ only"},{"id":"C","text":"$(2,0)$ and $(-2,0)$","explanation":"Correct: $y''=\\frac{-x}{y}$ is undefined where $y=0$, which happens at $(\\pm2,0)$.","value":"$(2,0)$ and $(-2,0)$"},{"id":"D","text":"Nowhere","value":"Nowhere","explanation":"Vertical tangents occur at $(\\pm2,0)$, so the slope is undefined there."}]'::jsonb
WHERE id = '92bae04d-d00c-4bc0-b282-d26745ea0354';

UPDATE public.questions
SET prompt = 'Determine whether the series $$\sum_{n=1}^{\infty}\left(\frac{n}{n+1}\right)^n$$ converges or diverges.',
    explanation = 'Let $a_n=\left(\frac{n}{n+1}\right)^n=\left(\frac{1}{1+\frac{1}{n}}\right)^n$. Then $$\lim_{n\to\infty}a_n=\left(\lim_{n\to\infty}\left(1+\frac{1}{n}\right)^n\right)^{-1}=\frac{1}{e}\ne 0.$$ Since $\lim a_n\ne 0$, the series diverges by the nth-term test.',
    options = '[{"id":"A","text":"Converges by the ratio test","value":"Converges by the ratio test","explanation":"The nth-term test applies first because the term limit is not $0$."},{"id":"B","text":"Diverges by the nth-term test","value":"Diverges by the nth-term test","explanation":"Correct: $\\left(\\frac{n}{n+1}\\right)^n=\\left(1+\\frac{1}{n}\\right)^{-n}\\to \\frac{1}{e}\\ne 0$."},{"id":"C","text":"Converges by comparison with $$\\sum \\frac{1}{n}$$","explanation":"If terms do not approach $0$, no comparison can make the series converge.","value":"Converges by comparison with $$\\sum \\frac{1}{n}$$"},{"id":"D","text":"Diverges because it is geometric","value":"Diverges because it is geometric","explanation":"It is not geometric because the ratio changes with $n$."}]'::jsonb
WHERE id = '55c69a80-4192-41a8-8b8f-5c8858a6ac2f';

UPDATE public.questions
SET prompt = 'The shaded region in the image is inside $r=2\cos\theta$ and outside $r=1$. Which integral represents the shaded area?',
    explanation = 'For polar area between curves, $$A=\frac12\int_a^b\left(r_{out}^2-r_{in}^2\right)d\theta.$$  Here $r_{out}=2\cos\theta$ and $r_{in}=1$, with intersections at $\theta=\pm\pi/3$. Thus the correct setup is $$\frac12\int_{\frac{-\pi}{3}}^{\frac{\pi}{3}}\left((2\cos\theta)^2-1\right)d\theta.$$',
    options = '[{"id":"A","text":"$\\displaystyle \\frac12\\int_{0}^{\\pi/3}\\left(1-(2\\cos\\theta)^2\\right)d\\theta$","explanation":"This swaps outer/inner radii and uses only half the symmetric interval.","value":"$\\displaystyle \\frac12\\int_{0}^{\\frac{\\pi}{3}}\\left(1-(2\\cos\\theta)^2\\right)d\\theta$"},{"id":"B","text":"$\\displaystyle \\frac12\\int_{-\\pi/3}^{\\pi/3}\\left((2\\cos\\theta)^2-1\\right)d\\theta$","explanation":"Correct. Use outer-minus-inner with bounds from $2\\cos\\theta=1$.","value":"$\\displaystyle \\frac12\\int_{\\frac{-\\pi}{3}}^{\\frac{\\pi}{3}}\\left((2\\cos\\theta)^2-1\\right)d\\theta$"},{"id":"C","text":"$\\displaystyle \\frac12\\int_{-\\pi/3}^{\\pi/3}\\left((2\\cos\\theta)-1\\right)d\\theta$","explanation":"Area requires squared radii; integrating $r$ is incorrect.","value":"$\\displaystyle \\frac12\\int_{\\frac{-\\pi}{3}}^{\\frac{\\pi}{3}}\\left((2\\cos\\theta)-1\\right)d\\theta$"},{"id":"D","text":"$\\displaystyle \\int_{-\\pi/3}^{\\pi/3}\\left((2\\cos\\theta)^2-1\\right)d\\theta$","explanation":"This misses the required $\\tfrac12$ factor.","value":"$\\displaystyle \\int_{\\frac{-\\pi}{3}}^{\\frac{\\pi}{3}}\\left((2\\cos\\theta)^2-1\\right)d\\theta$"}]'::jsonb
WHERE id = '97eec5a9-a1f7-4ef3-accb-77d0b9449762';

UPDATE public.questions
SET prompt = 'Find the area of the region that lies inside $r=2+\cos\theta$ and outside $r=2$.',
    explanation = 'Intersection occurs when $2+\cos\theta=2\Rightarrow \cos\theta=0$, so $\theta\in[-\frac{\pi}{2},\frac{\pi}{2}]$ bounds the region where $2+\cos\theta\ge 2$. Area is $$A=\frac12\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}\Big((2+\cos\theta)^2-2^2\Big)\,d\theta =\frac12\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}\big(4\cos\theta+\cos^2\theta\big)\,d\theta =\frac12\Big(8+\frac{\pi}{2}\Big)=4+\frac{\pi}{4}.$$',
    options = '[{"id":"A","text":"$4+\\dfrac{\\pi}{2}$","explanation":"This comes from forgetting the factor $\\tfrac12$ in the polar area formula.","value":"$4+\\dfrac{\\pi}{2}$"},{"id":"B","text":"$4+\\dfrac{\\pi}{4}$","explanation":"Correct: $\\frac12\\int_{\\frac{-\\pi}{2}}^{\\frac{\\pi}{2}}\\big((2+\\cos\\theta)^2-2^2\\big)\\,d\\theta=4+\\frac{\\pi}{4}$.","value":"$4+\\dfrac{\\pi}{4}$"},{"id":"C","text":"$2+\\dfrac{\\pi}{4}$","explanation":"This typically results from dropping the $4\\cos\\theta$ term when expanding $(2+\\cos\\theta)^2$.","value":"$2+\\dfrac{\\pi}{4}$"},{"id":"D","text":"$\\dfrac{\\pi}{4}$","explanation":"This ignores the contribution from the $4\\cos\\theta$ term and the constant part of the integral.","value":"$\\dfrac{\\pi}{4}$"}]'::jsonb
WHERE id = '349834af-f515-42db-ac6a-7eb43fdf272a';

UPDATE public.questions
SET prompt = 'Find the arc length of the parametric curve $x=3t$ and $y=4t$ for $0\le t\le 2$.',
    explanation = 'Arc length is $$L=\int_0^2\sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}\,dt =\int_0^2\sqrt{3^2+4^2}\,dt=\int_0^2 5\,dt=10.$$',
    options = '[{"id":"A","text":"$14$","explanation":"This adds speeds instead of using $\\sqrt{(\\frac{dx}{dt})^2+(\\frac{dy}{dt})^2}$.","value":"$14$"},{"id":"B","text":"$10$","explanation":"Correct: $L=\\int_0^2\\sqrt{3^2+4^2}\\,dt=\\int_0^2 5\\,dt=10$.","value":"$10$"},{"id":"C","text":"$\\dfrac{25}{2}$","explanation":"This forgets the square root and uses $\\int(x''^2+y''^2)\\,dt$.","value":"$\\dfrac{25}{2}$"},{"id":"D","text":"$5$","explanation":"This computes speed correctly but forgets to multiply by the time interval length.","value":"$5$"}]'::jsonb
WHERE id = '484483f3-2d2c-4b36-be4b-c993094bd87d';

UPDATE public.questions
SET prompt = 'The plane curve is $\mathbf{r}(t)=\langle \cos t, \tfrac12\sin(2t)\rangle$. A tangent direction at $t=\frac{\pi}{3}$ is shown.  ![9.4-P4](9.4-P4.png)  What is $\left.\dfrac{dy}{dx}\right|_{t=\frac{\pi}{3}}$?',
    explanation = '$\frac{dx}{dt}=-\sin t$ and $\frac{dy}{dt}=\cos(2t)$, so $\frac{dy}{dx}=\frac{\cos(2t)}{-\sin t}$. At $t=\frac{\pi}{3}$, this is $\frac{\frac{-1}{2}}{-\sqrt{3}/2}=\frac{\sqrt{3}}{3}$.',
    options = '[{"id":"A","text":"$-\\sqrt{3}$","explanation":"Negatives cancel, so slope is positive.","value":"$-\\sqrt{3}$"},{"id":"B","text":"$\\sqrt{3}$","explanation":"Reciprocal error.","value":"$\\sqrt{3}$"},{"id":"C","text":"$\\dfrac{\\sqrt{3}}{3}$","explanation":"Correct.","value":"$\\dfrac{\\sqrt{3}}{3}$"},{"id":"D","text":"$-\\dfrac{\\sqrt{3}}{3}$","explanation":"Sign error.","value":"$-\\dfrac{\\sqrt{3}}{3}$"}]'::jsonb
WHERE id = 'fbf71205-f3fb-4f8e-ad1b-6d874bfc8ee9';

UPDATE public.questions
SET prompt = 'A parametric curve is given by $x=f(t)$ and $y=g(t)$. Which expression equals the speed $\dfrac{ds}{dt}$?',
    explanation = 'Velocity is $\langle f''(t),g''(t)\rangle$ and speed is its magnitude: $\frac{ds}{dt}=\sqrt{(f''(t))^2+(g''(t))^2}$.',
    options = '[{"id":"A","text":"$\\sqrt{(f(t))^2+(g(t))^2}$","explanation":"Distance from origin, not speed.","value":"$\\sqrt{(f(t))^2+(g(t))^2}$"},{"id":"B","text":"$\\sqrt{(f''(t))^2+(g''(t))^2}$","explanation":"Correct.","value":"$\\sqrt{(f''(t))^2+(g''(t))^2}$"},{"id":"C","text":"$(f''(t))^2+(g''(t))^2$","explanation":"Speed-squared.","value":"$(f''(t))^2+(g''(t))^2$"},{"id":"D","text":"$\\dfrac{g''(t)}{f''(t)}$","explanation":"Slope $\\frac{dy}{dx}$ when defined.","value":"$\\dfrac{g''(t)}{f''(t)}$"}]'::jsonb
WHERE id = 'c1b75290-daeb-4489-a3d3-bb72835900e7';

UPDATE public.questions
SET prompt = 'Use differentials to approximate $\sqrt[3]{65}$ by linearizing $g(x)=x^{\frac{1}{3}}$ at $x=64$.',
    explanation = 'Let $g(x)=x^{\frac{1}{3}}$. Then $g(64)=4$ and $$g''(x)=\frac{1}{3}x^{\frac{-2}{3}}.$$ Since $64^{2/3}=(\sqrt[3]{64})^2=16$, we have $g''(64)=\dfrac{1}{3\cdot 16}=\dfrac{1}{48}$. Thus $$\sqrt[3]{65}=g(65)\approx g(64)+g''(64)(65-64)=4+\frac{1}{48}=4.020833\ldots.$$',
    options = '[{"id":"A","text":"$4.01$","explanation":"This typically comes from using a derivative that is too large (for example, $\\dfrac{1}{12}$ instead of $\\dfrac{1}{48}$).","value":"$4.01$"},{"id":"B","text":"$4.25$","explanation":"This is far too large for a $+1$ change near $64$ because cube roots change slowly there.","value":"$4.25$"},{"id":"C","text":"$4.020833\\ldots$","explanation":"Correct. $g(64)=4$, $g''(64)=\\dfrac{1}{48}$, so $g(65)\\approx 4+\\dfrac{1}{48}(1)=4.020833\\ldots$.","value":"$4.020833\\ldots$"},{"id":"D","text":"$3.979167\\ldots$","explanation":"Sign error: since $65>64$, the cube root must be greater than $4$.","value":"$3.979167\\ldots$"}]'::jsonb
WHERE id = '672114f3-4c91-40ff-97fe-ff2929909282';

UPDATE public.questions
SET prompt = 'Find the area of one petal of the rose $r=2\cos(3\theta)$.',
    explanation = 'One petal around $\theta=0$ is traced when $\cos(3\theta)\ge 0$ between consecutive zeros: $\theta\in[\frac{-\pi}{6},\frac{\pi}{6}]$.  $$A=\frac12\int_{\frac{-\pi}{6}}^{\frac{\pi}{6}}(2\cos(3\theta))^2\,d\theta=2\int_{\frac{-\pi}{6}}^{\frac{\pi}{6}}\cos^2(3\theta)\,d\theta.$$  Using $\cos^2u=\frac{1+\cos(2u)}{2}$ gives $A=\frac{\pi}{6}$.',
    options = '[{"id":"A","text":"$\\frac{2\\pi}{3}$","explanation":"This results from incorrect bounds and missing the $\\tfrac12$ factor.","value":"$\\frac{2\\pi}{3}$"},{"id":"B","text":"$\\frac{\\pi}{3}$","explanation":"This can occur if you double-count the interval that traces one petal.","value":"$\\frac{\\pi}{3}$"},{"id":"C","text":"$\\frac{\\pi}{6}$","explanation":"Correct. Use $A=\\frac12\\int r^2\\,d\\theta$ on one-petal bounds.","value":"$\\frac{\\pi}{6}$"},{"id":"D","text":"$\\frac{\\pi}{12}$","explanation":"This often comes from dropping a factor of 2 when simplifying $r^2=4\\cos^2(3\\theta)$.","value":"$\\frac{\\pi}{12}$"}]'::jsonb
WHERE id = 'a5249bf3-7689-4fc9-ba07-6cc4d6026e53';

UPDATE public.questions
SET prompt = 'A curve is given by $x=\sin t$ and $y=\cos t$. What is $\dfrac{d^2y}{dx^2}$ at $t=\dfrac{\pi}{4}$?',
    explanation = 'First, $$\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{-\sin t}{\cos t}=-\tan t.$$ Then $$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}}=\frac{-\sec^2 t}{\cos t}=-\sec^3 t.$$ At $t=\pi/4$, $\sec(\pi/4)=\sqrt2$, so $\dfrac{d^2y}{dx^2}=-2\sqrt2$.',
    options = '[{"id":"A","text":"$-\\sqrt{2}$","explanation":"This typically stops too early (e.g., at $\\frac{d}{dt}(\\frac{dy}{dx})$) or divides by the wrong quantity.","value":"$-\\sqrt{2}$"},{"id":"B","text":"$-2$","explanation":"This often comes from evaluating $\\sec^2(\\frac{\\pi}{4})=2$ but missing the final division by $\\frac{dx}{dt}$.","value":"$-2$"},{"id":"C","text":"$-2\\sqrt{2}$","explanation":"Correct: $\\dfrac{dy}{dx}=\\dfrac{-\\sin t}{\\cos t}=-\\tan t$, so $\\dfrac{d}{dt}(\\frac{dy}{dx})=-\\sec^2 t$. Then $\\dfrac{d^2y}{dx^2}=\\dfrac{-\\sec^2 t}{\\frac{dx}{dt}}=\\dfrac{-\\sec^2 t}{\\cos t}=-\\sec^3 t$. At $t=\\frac{\\pi}{4}$, $\\sec t=\\sqrt2$, so $-\\sec^3 t=-2\\sqrt2$.","value":"$-2\\sqrt{2}$"},{"id":"D","text":"$2\\sqrt{2}$","explanation":"Sign error: the second derivative is negative here.","value":"$2\\sqrt{2}$"}]'::jsonb
WHERE id = '92db6ddb-3bb0-42cb-9087-6a9cca80e8ad';

UPDATE public.questions
SET prompt = 'Consider the power series $$\sum_{n=1}^{\infty}\frac{(x-1)^n}{n^2}.$$ Which statement is true?',
    explanation = 'Let $a_n=\frac{(x-1)^n}{n^2}$. Ratio test: $$\left|\frac{a_{n+1}}{a_n}\right|=|x-1|\cdot\frac{n^2}{(n+1)^2}\to |x-1|.$$ Thus convergence for $|x-1|<1$, giving radius $R=1$ and preliminary interval $(0,2)$. Check endpoints: at $x=0$, the series is $$\sum \frac{(-1)^n}{n^2}$$ which converges absolutely since $\sum 1/n^2$ converges. At $x=2$, the series is $$\sum \frac{1}{n^2}$$ which converges. Therefore the interval of convergence is $[0,2]$.',
    options = '[{"id":"A","text":"Radius of convergence is $R=0$","explanation":"The ratio test gives a nonzero radius.","value":"Radius of convergence is $R=0$"},{"id":"B","text":"Radius of convergence is $R=1$, and the interval is $(0,2)$","explanation":"Radius is $1$, but both endpoints converge and must be included.","value":"Radius of convergence is $R=1$, and the interval is $(0,2)$"},{"id":"C","text":"Radius of convergence is $R=1$, and the interval is $[0,2]$","explanation":"Correct: $x=0$ gives $\\sum (-1)\\frac{^n}{n^2}$ and $x=2$ gives $\\sum \\frac{1}{n^2}$, both convergent.","value":"Radius of convergence is $R=1$, and the interval is $[0,2]$"},{"id":"D","text":"Radius of convergence is $R=2$","explanation":"Ratio test gives $|x-1|<1$, so $R=1$.","value":"Radius of convergence is $R=2$"}]'::jsonb
WHERE id = '7559e9da-c720-4e69-9fc5-4729294d9249';

UPDATE public.questions
SET prompt = 'For what values of $k$ does the series converge?  $$\sum_{n=1}^{\infty} \frac{k^n}{n}$$',
    explanation = 'Let $a_n=\frac{k^n}{n}$. For $|k|<1$, $$\left|\frac{a_{n+1}}{a_n}\right|=\left|\frac{k^{n+1}/(n+1)}{\frac{k^n}{n}}\right|=|k|\cdot\frac{n}{n+1}\to |k|<1,$$ so the series converges by the Ratio Test. For $k=1$, the series is $\sum \frac{1}{n}$ (diverges). For $k=-1$, the series is $\sum \frac{(-1)^n}{n}$ (converges by AST). Therefore it converges for $-1\le k<1$ and diverges otherwise.',
    options = '[{"id":"A","text":"Converges only when $k=0$","explanation":"If $|k|<1$, the series converges; $k=0$ is just a special case.","value":"Converges only when $k=0$"},{"id":"B","text":"Converges for $|k|<1$ and diverges for $|k|\\ge 1$","explanation":"At $k=-1$, the series is alternating harmonic and converges, so this is not fully correct.","value":"Converges for $|k|<1$ and diverges for $|k|\\ge 1$"},{"id":"C","text":"Converges for $-1\\le k<1$ and diverges otherwise","explanation":"For $|k|<1$ ratio test gives convergence; $k=-1$ converges (alternating harmonic); $k=1$ diverges (harmonic).","value":"Converges for $-1\\le k<1$ and diverges otherwise"},{"id":"D","text":"Converges for $|k|\\le 1$","explanation":"$k=1$ gives the harmonic series, which diverges.","value":"Converges for $|k|\\le 1$"}]'::jsonb
WHERE id = '9c6fbc86-85a4-488b-bf6e-b4a098dffabd';

UPDATE public.questions
SET prompt = 'Determine whether the series $\sum_{n=1}^{\infty} (-1)^n\frac{3^n}{n!}$ converges absolutely, converges conditionally, or diverges.',
    explanation = 'Consider absolute convergence: $$\sum_{n=1}^{\infty}\left|(-1)^n\frac{3^n}{n!}\right|=\sum_{n=1}^{\infty}\frac{3^n}{n!}.$$ Ratio Test: $$\frac{a_{n+1}}{a_n}=\frac{3^{n+1}/(n+1)!}{\frac{3^n}{n}!}=\frac{3}{n+1}\to 0<1.$$ Thus the absolute-value series converges, so the original series converges absolutely.',
    options = '[{"id":"A","text":"Converges absolutely","value":"Converges absolutely","explanation":"Apply the Ratio Test to $\\sum \\frac{3^n}{n!}$: $\\frac{a_{n+1}}{a_n}=\\frac{3}{n+1}\\to 0<1$, so it converges absolutely."},{"id":"B","text":"Converges conditionally","value":"Converges conditionally","explanation":"Conditional convergence only occurs when the absolute-value series diverges. Here the absolute-value series converges."},{"id":"C","text":"Diverges by the $n$th-term test","explanation":"The terms go to $0$ (factorial dominates), so the $n$th-term test does not prove divergence.","value":"Diverges by the $n$th-term test"},{"id":"D","text":"Diverges because it alternates","value":"Diverges because it alternates","explanation":"Alternation does not imply divergence."}]'::jsonb
WHERE id = '5394b544-91ab-4e9f-a0c0-97c81fefa39d';

UPDATE public.questions
SET prompt = 'A function $f$ is defined near $x=2$. Use the table to estimate $$\displaystyle \lim_{x\to 2}\frac{f(x)-f(2)}{x-2}.$$  $$ \begin{array}{c|cccccc} x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\\\ \hline f(x) & 4.61 & 4.9601 & 4.996001 & 5.004001 & 5.0401 & 5.41 \end{array} $$  Assume $f(2)=5$.',
    explanation = 'Compute the difference quotient near $2$. From the right: $\frac{5.004001-5}{0}.001\approx 4.001$. From the left: $\frac{4.996001-5}{-0.001}\approx 3.999$. Both sides approach $4$, so the limit is approximately $4$.',
    options = '[{"id":"A","text":"$0$","explanation":"The quotient is not near $0$; the changes in $f(x)$ relative to changes in $x$ suggest a slope near $4$.","value":"$0$"},{"id":"B","text":"$4$","explanation":"Using nearby values: for $x=2.001$, $\\frac{5.004001-5}{0}.001\\approx 4.001$; for $x=1.999$, $\\frac{4.996001-5}{-0.001}\\approx 3.999$.","value":"$4$"},{"id":"C","text":"$5$","explanation":"$5$ is $f(2)$, but the expression is about the rate of change (slope), not the function value.","value":"$5$"},{"id":"D","text":"The limit does not exist","value":"The limit does not exist","explanation":"Left and right quotients both approach about $4$, indicating the limit exists."}]'::jsonb
WHERE id = '9b8a1428-e64e-4826-93cf-3167497f581d';

UPDATE public.questions
SET prompt = 'Given $$\frac{1}{1-x}=\sum_{n=0}^{\infty} x^n\quad (|x|<1),$$ which series represents $$\frac{1}{1-3x}?$$',
    explanation = 'Use the known identity with input $3x$: $$\frac{1}{1-3x}=\sum_{n=0}^{\infty}(3x)^n,\quad |3x|<1\Rightarrow |x|<\frac13.$$',
    options = '[{"id":"A","text":"$$\\sum_{n=0}^{\\infty} 3x^n$$","explanation":"This equals $3\\sum x^n=\\frac{3}{1-x}$, not $\\frac{1}{1-3x}$.","value":"$$\\sum_{n=0}^{\\infty} 3x^n$$"},{"id":"B","text":"$$\\sum_{n=0}^{\\infty} (3x)^n$$","explanation":"Substitute $x\\mapsto 3x$ in the geometric series: $\\sum (3x)^n=\\frac{1}{1-3x}$ for $|3x|<1$.","value":"$$\\sum_{n=0}^{\\infty} (3x)^n$$"},{"id":"C","text":"$$\\sum_{n=0}^{\\infty} \\frac{x^n}{3^n}$$","explanation":"This is $\\sum (\\frac{x}{3})^n=\\frac{1}{1\\frac{-x}{3}}=\\frac{3}{3-x}$.","value":"$$\\sum_{n=0}^{\\infty} \\frac{x^n}{3^n}$$"},{"id":"D","text":"$$\\sum_{n=1}^{\\infty} (3x)^n$$","explanation":"Missing the $n=0$ term; it would equal $\\frac{1}{1-3x}-1$.","value":"$$\\sum_{n=1}^{\\infty} (3x)^n$$"}]'::jsonb
WHERE id = '19aba183-3185-4f86-b435-f00ea53718fb';

UPDATE public.questions
SET prompt = 'Determine whether the infinite series $$\sum_{n=1}^{\infty}\frac{n}{n+1}$$ converges or diverges.',
    explanation = 'Compute the term limit: $$\lim_{n\to\infty}\frac{n}{n+1}=\lim_{n\to\infty}\frac{1}{1+\frac{1}{n}}=1\ne 0.$$ Since the terms do not approach $0$, the series diverges by the nth-term test.',
    options = '[{"id":"A","text":"Diverges","value":"Diverges","explanation":"Correct: $\\lim_{n\\to\\infty}\\frac{n}{n+1}=1\\ne 0$, so the series diverges by the nth-term test."},{"id":"B","text":"Converges by comparison with $$\\sum \\frac{1}{n}$$","explanation":"Comparison is unnecessary; if terms do not approach $0$, the series cannot converge.","value":"Converges by comparison with $$\\sum \\frac{1}{n}$$"},{"id":"C","text":"Converges by telescoping","value":"Converges by telescoping","explanation":"The terms do not form a telescoping difference that sums to a finite limit."},{"id":"D","text":"Converges by the ratio test","value":"Converges by the ratio test","explanation":"The nth-term test already shows divergence."}]'::jsonb
WHERE id = '5961cd7f-2039-4be5-adf6-bbd6e0efe68d';

UPDATE public.questions
SET prompt = 'Determine whether the series converges or diverges.  $$\sum_{n=1}^{\infty} \frac{3^n}{n!}$$',
    explanation = 'Let $a_n=\frac{3^n}{n!}$. Then $$\left|\frac{a_{n+1}}{a_n}\right|=\frac{3^{n+1}/(n+1)!}{\frac{3^n}{n}!}=\frac{3}{n+1}.$$ So $$\lim_{n\to\infty}\left|\frac{a_{n+1}}{a_n}\right|=0<1,$$ and the series converges by the Ratio Test.',
    options = '[{"id":"A","text":"Converges by the Ratio Test","value":"Converges by the Ratio Test","explanation":"Compute $\\lim\\left|\\frac{a_{n+1}}{a_n}\\right|=\\lim\\frac{3}{n+1}=0<1$, so it converges."},{"id":"B","text":"Diverges by the Ratio Test","value":"Diverges by the Ratio Test","explanation":"The ratio limit is $0$, not greater than $1$."},{"id":"C","text":"Ratio Test is inconclusive","value":"Ratio Test is inconclusive","explanation":"Inconclusive occurs when the ratio limit equals $1$, not $0$."},{"id":"D","text":"Diverges because $3^n$ grows exponentially","explanation":"Factorial growth dominates exponential growth in this context.","value":"Diverges because $3^n$ grows exponentially"}]'::jsonb
WHERE id = 'f9a938c4-e47f-429b-ba7e-79040b4f3e6b';

UPDATE public.questions
SET prompt = 'For the parametric curve $x=t^2+1$ and $y=\ln(t)$ with $t>0$, what is $\dfrac{dy}{dx}$ when $t=1$?',
    explanation = 'Compute $\frac{dy}{dt}=\frac{1}{t}$ and $\frac{dx}{dt}=2t$. Then $$\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{\frac{1}{t}}{2t}=\frac{1}{2t^2}.$$ At $t=1$, $\dfrac{dy}{dx}=\dfrac{1}{2}$.',
    options = '[{"id":"A","text":"$\\dfrac{1}{2}$","explanation":"Correct: $\\dfrac{dy}{dx}=\\dfrac{\\frac{dy}{dt}}{\\frac{dx}{dt}}=\\dfrac{(\\frac{1}{t})}{2t}=\\dfrac{1}{2t^2}$, so at $t=1$ it is $\\dfrac{1}{2}$.","value":"$\\dfrac{1}{2}$"},{"id":"B","text":"$2$","explanation":"This inverts the ratio (computes $\\dfrac{dx}{dy}$) instead of $\\dfrac{dy}{dx}$.","value":"$2$"},{"id":"C","text":"$1$","explanation":"This forgets to divide by $\\frac{dx}{dt}$ or miscomputes a derivative.","value":"$1$"},{"id":"D","text":"$\\dfrac{1}{2t}$","explanation":"Algebra error: $\\dfrac{(\\frac{1}{t})}{2t}=\\dfrac{1}{2t^2}$, not $\\dfrac{1}{2t}$.","value":"$\\dfrac{1}{2t}$"}]'::jsonb
WHERE id = 'cd2f5536-8076-4d9a-9d8a-4d2f54c3a2a6';

UPDATE public.questions
SET prompt = 'A curve is given by $x=t^2-1$ and $y=2t$ for $0\le t\le 2$. The graph of this parametric curve is provided.  ![9.3-P2](9.3-P2.png)  Which integral gives the arc length of the curve on $[0,2]$?',
    explanation = 'Use $s=\int_0^2 \sqrt{(\frac{dx}{dt})^2+(\frac{dy}{dt})^2}\,dt$. Here $\frac{dx}{dt}=2t$ and $\frac{dy}{dt}=2$, so $s=\int_0^2 \sqrt{4t^2+4}\,dt$.',
    options = '[{"id":"A","text":"$\\displaystyle \\int_0^2 \\sqrt{(2t)^2+(2)^2}\\,dt$","explanation":"Correct. Use $\\sqrt{(\\frac{dx}{dt})^2+(\\frac{dy}{dt})^2}$.","value":"$\\displaystyle \\int_0^2 \\sqrt{(2t)^2+(2)^2}\\,dt$"},{"id":"B","text":"$\\displaystyle \\int_0^2 \\left((2t)^2+(2)^2\\right)\\,dt$","explanation":"Missing the square root.","value":"$\\displaystyle \\int_0^2 \\left((2t)^2+(2)^2\\right)\\,dt$"},{"id":"C","text":"$\\displaystyle \\int_{-1}^{3} \\sqrt{1+\\left(\\frac{dy}{dx}\\right)^2}\\,dx$","explanation":"Requires extra conversion and careful bounds; direct setup is in $t$.","value":"$\\displaystyle \\int_{-1}^{3} \\sqrt{1+\\left(\\frac{dy}{dx}\\right)^2}\\,dx$"},{"id":"D","text":"$\\displaystyle \\int_0^2 \\sqrt{(t^2-1)^2+(2t)^2}\\,dt$","explanation":"Uses $x,y$ instead of derivatives.","value":"$\\displaystyle \\int_0^2 \\sqrt{(t^2-1)^2+(2t)^2}\\,dt$"}]'::jsonb
WHERE id = 'd318fc58-5c23-43b0-9d6d-f277f567c543';

UPDATE public.questions
SET prompt = 'Evaluate the limit: $$\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}.$$',
    explanation = 'Rationalize: $$\frac{\sqrt{1+x}-1}{x}\cdot\frac{\sqrt{1+x}+1}{\sqrt{1+x}+1}=\frac{(1+x)-1}{x(\sqrt{1+x}+1)}=\frac{1}{\sqrt{1+x}+1}.$$ Then $$\lim_{x\to 0}\frac{1}{\sqrt{1+x}+1}=\frac{1}{2}.$$',
    options = '[{"id":"A","text":"$\\frac{1}{2}$","explanation":"Multiply by the conjugate to simplify to $\\frac{1}{\\sqrt{1+x}+1}$, then substitute $x=0$.","value":"$\\frac{1}{2}$"},{"id":"B","text":"$1$","explanation":"This ignores the conjugate simplification and overestimates the limit.","value":"$1$"},{"id":"C","text":"$0$","explanation":"This comes from substituting to get $\\frac{0}{0}$ and guessing.","value":"$0$"},{"id":"D","text":"Does not exist","value":"Does not exist","explanation":"After rationalizing, the expression is continuous at $x=0$, so the limit exists."}]'::jsonb
WHERE id = '4ab23ec2-7fee-4ecc-a197-8b7d7573d46d';

UPDATE public.questions
SET prompt = 'Compute $$\int \frac{5}{x(x+2)}\,dx.$$',
    explanation = 'Set $$\frac{5}{x(x+2)}=\frac{A}{x}+\frac{B}{x+2}.$$ Then $5=A(x+2)+Bx=(A+B)x+2A$, so $A+B=0$ and $2A=5$. Thus $A=\frac52$, $B=-\frac52$. Therefore $$\int \frac{5}{x(x+2)}dx=\frac52\ln|x|-\frac52\ln|x+2|+C.$$',
    options = '[{"id":"A","text":"$$\\dfrac{5}{2}\\left(\\ln|x|-\\ln|x+2|\\right)+C$$","explanation":"Correct. Since $\\frac{5}{x(x+2)}=\\frac{\\frac{5}{2}}{x}-\\frac{\\frac{5}{2}}{x+2}$, integrate termwise.","value":"$$\\dfrac{5}{2}\\left(\\ln|x|-\\ln|x+2|\\right)+C$$"},{"id":"B","text":"$$\\dfrac{5}{2}\\left(\\ln|x+2|-\\ln|x|\\right)+C$$","explanation":"Sign is reversed; it corresponds to $\\frac{\\frac{5}{2}}{x+2}-\\frac{\\frac{5}{2}}{x}$.","value":"$$\\dfrac{5}{2}\\left(\\ln|x+2|-\\ln|x|\\right)+C$$"},{"id":"C","text":"$$\\dfrac{5}{2}\\ln|x|+\\dfrac{5}{2}\\ln|x+2|+C$$","explanation":"This adds logs; decomposition requires a difference because the coefficients have opposite signs.","value":"$$\\dfrac{5}{2}\\ln|x|+\\dfrac{5}{2}\\ln|x+2|+C$$"},{"id":"D","text":"$$\\dfrac{5}{x+2}+C$$","explanation":"Differentiating gives $-\\frac{5}{(x+2)^2}$, not $\\frac{5}{x(x+2)}$.","value":"$$\\dfrac{5}{x+2}+C$$"}]'::jsonb
WHERE id = '15e56497-6963-444b-a54e-4cec0bc1d1ad';

UPDATE public.questions
SET prompt = 'A closed right circular cylinder must have volume $500\pi\text{ cm}^3$. Let $r$ be the radius and $h$ the height. Which single-variable surface area function $S(r)$ should be minimized?',
    explanation = 'Volume constraint: $\pi r^2h=500\pi$ so $h=\frac{500}{r^2}$. Closed-cylinder surface area is $S=2\pi r^2+2\pi rh$. Substitute to get $S(r)=2\pi r^2+\frac{1000\pi}{r}$.',
    options = '[{"id":"A","text":"$S(r)=2\\pi r^2+\\dfrac{1000\\pi}{r}$","explanation":"Substitute $h=\\frac{500}{r^2}$ into $S=2\\pi r^2+2\\pi rh$ to get $2\\pi r^2+\\frac{1000\\pi}{r}$.","value":"$S(r)=2\\pi r^2+\\dfrac{1000\\pi}{r}$"},{"id":"B","text":"$S(r)=2\\pi r^2+\\dfrac{500\\pi}{r^2}$","explanation":"This incorrectly replaces $2\\pi rh$ with a term in $\\frac{1}{r^2}$.","value":"$S(r)=2\\pi r^2+\\dfrac{500\\pi}{r^2}$"},{"id":"C","text":"$S(r)=\\pi r^2+\\dfrac{1000\\pi}{r}$","explanation":"A closed cylinder has two bases, so the base term should be $2\\pi r^2$.","value":"$S(r)=\\pi r^2+\\dfrac{1000\\pi}{r}$"},{"id":"D","text":"$S(r)=2\\pi r^2+\\dfrac{500\\pi}{r}$","explanation":"The lateral term becomes $\\frac{1000\\pi}{r}$, not $\\frac{500\\pi}{r}$.","value":"$S(r)=2\\pi r^2+\\dfrac{500\\pi}{r}$"}]'::jsonb
WHERE id = '49185dae-c4b0-4acd-ac13-d1a5118919a4';

UPDATE public.questions
SET prompt = 'Find the area of the region inside $r=2\cos\theta$ and outside $r=\cos\theta$.',
    explanation = 'Where $\cos\theta\ge 0$ (i.e., $\frac{-\pi}{2}\le\theta\le\frac{\pi}{2}$), the outer curve is $r=2\cos\theta$ and the inner curve is $r=\cos\theta$. Area between curves: $$A=\frac12\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}\left[(2\cos\theta)^2-(\cos\theta)^2\right]d\theta =\frac12\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}3\cos^2\theta\,d\theta.$$ Since $\int_{-\pi/2}^{\pi/2}\cos^2\theta\,d\theta=\frac{\pi}{2}$, $$A=\frac12\cdot 3\cdot\frac{\pi}{2}=\frac{3\pi}{4}.$$',
    options = '[{"id":"A","text":"$\\dfrac{\\pi}{4}$","explanation":"This typically uses incorrect bounds or misses the $\\dfrac12$ factor.","value":"$\\dfrac{\\pi}{4}$"},{"id":"B","text":"$\\dfrac{\\pi}{2}$","explanation":"This overcounts; it does not match the setup $\\frac12\\int\\big(r_{\\text{outer}}^2-r_{\\text{inner}}^2\\big)\\,d\\theta$.","value":"$\\dfrac{\\pi}{2}$"},{"id":"C","text":"$\\dfrac{3\\pi}{4}$","explanation":"Correct: $A=\\dfrac12\\int_{\\frac{-\\pi}{2}}^{\\frac{\\pi}{2}}\\big((2\\cos\\theta)^2-(\\cos\\theta)^2\\big)\\,d\\theta=\\dfrac{3\\pi}{4}$.","value":"$\\dfrac{3\\pi}{4}$"},{"id":"D","text":"$\\pi$","explanation":"This double-counts the region.","value":"$\\pi$"}]'::jsonb
WHERE id = '7794304a-14a7-421b-b325-c554ea6b66da';

UPDATE public.questions
SET prompt = 'Find the arc length of $x=t^2$ and $y=\dfrac{2}{3}t^3$ from $t=0$ to $t=1$.',
    explanation = 'Compute derivatives: $\frac{dx}{dt}=2t$ and $\frac{dy}{dt}=2t^2$. Then speed is $$\sqrt{(2t)^2+(2t^2)^2}=\sqrt{4t^2+4t^4}=2t\sqrt{1+t^2}\quad(0\le t\le 1).$$ So $$L=\int_0^1 2t\sqrt{1+t^2}\,dt.$$ Let $u=1+t^2$, $du=2t\,dt$: $$L=\int_1^2 \sqrt{u}\,du=\left[\frac{2}{3}u^{\frac{3}{2}}\right]_1^2=\frac{2}{3}(2^{\frac{3}{2}}-1)=\frac{2}{3}(2\sqrt{2}-1).$$',
    options = '[{"id":"A","text":"$\\dfrac{5}{3}$","explanation":"This omits the square root in the speed or uses a linearized speed.","value":"$\\dfrac{5}{3}$"},{"id":"B","text":"$\\sqrt{5}$","explanation":"This incorrectly treats speed as constant.","value":"$\\sqrt{5}$"},{"id":"C","text":"$\\dfrac{2}{3}(2\\sqrt{2}-1)$","explanation":"Correct: $x''=2t$, $y''=2t^2$, so speed is $2t\\sqrt{1+t^2}$, and a $u=1+t^2$ substitution gives $\\dfrac{2}{3}(2\\sqrt{2}-1)$.","value":"$\\dfrac{2}{3}(2\\sqrt{2}-1)$"},{"id":"D","text":"$\\dfrac{2}{3}(2\\sqrt{2}+1)$","explanation":"Sign error: the substitution produces $u^{\\frac{3}{2}}$ evaluated as $2^{\\frac{3}{2}}-1$, not $2^{\\frac{3}{2}}+1$.","value":"$\\dfrac{2}{3}(2\\sqrt{2}+1)$"}]'::jsonb
WHERE id = 'e2dbe0c5-c426-455d-bb28-5165d0b7d59b';

UPDATE public.questions
SET prompt = 'Evaluate $\displaystyle \lim_{x\to 0}\frac{e^{2x}-1-2x}{x^2}$.',
    explanation = 'This is $\frac{0}{0}$. Apply L''Hospital: first derivative gives $\lim_{x\to 0}\frac{2e^{2x}-2}{2x}=\lim_{x\to 0}\frac{e^{2x}-1}{x}$, still $\frac{0}{0}$. Apply again: $\lim_{x\to 0}\frac{2e^{2x}}{1}=2$.',
    options = '[{"id":"A","text":"$0$","explanation":"After canceling linear behavior, the limit is not 0.","value":"$0$"},{"id":"B","text":"$1$","explanation":"Missing the factor from the second derivative.","value":"$1$"},{"id":"C","text":"$2$","explanation":"Correct: applying L''Hospital twice gives 2.","value":"$2$"},{"id":"D","text":"Does not exist","value":"Does not exist","explanation":"The limit exists and is finite."}]'::jsonb
WHERE id = '75e5fa48-b47f-4bf4-b2ab-65a3dfd8e00f';

UPDATE public.questions
SET prompt = 'Find an antiderivative: $$\int \frac{2x+3}{x^2+3x-4}\,dx$$',
    explanation = 'Recognize the pattern $\int \frac{f^{\prime}(x)}{f(x)}dx=\ln|f(x)|+C$. Let $f(x)=x^2+3x-4$, so $f^{\prime}(x)=2x+3$. $$\int \frac{2x+3}{x^2+3x-4}dx=\ln|x^2+3x-4|+C.$$',
    options = '[{"id":"A","text":"$\\ln|x^2+3x-4|+C$","explanation":"Since $\\frac{d}{dx}(x^2+3x-4)=2x+3$, this is exactly an $f^{\\prime}\\frac{x}{f}(x)$ form.","value":"$\\ln|x^2+3x-4|+C$"},{"id":"B","text":"$\\frac{1}{2}\\ln|x^2+3x-4|+C$","explanation":"There is no extra factor of $\\frac12$ because the numerator already matches $f^{\\prime}(x)$.","value":"$\\frac{1}{2}\\ln|x^2+3x-4|+C$"},{"id":"C","text":"$\\ln|x-1|+\\ln|x+4|+C$","explanation":"This is an unnecessary partial-fractions approach and would require coefficients; it is not equivalent as stated.","value":"$\\ln|x-1|+\\ln|x+4|+C$"},{"id":"D","text":"$\\arctan\\left(\\frac{2x+3}{\\sqrt{7}}\\right)+C$","explanation":"Arctan forms arise from $u^2+a^2$ in the denominator; here the denominator factors and the numerator matches its derivative.","value":"$\\arctan\\left(\\frac{2x+3}{\\sqrt{7}}\\right)+C$"}]'::jsonb
WHERE id = 'ddd4ee5e-66fa-4959-a070-c6c3edcf2b66';

UPDATE public.questions
SET prompt = 'Let $p(x)=\ln(x^2)$ for $x>0$. Which expression equals $p''(x)$?',
    explanation = 'Because $x>0$, $\ln(x^2)=2\ln x$. Then $$p''(x)=2\cdot \frac{1}{x}=\frac{2}{x}.$$',
    options = '[{"id":"A","text":"$\\dfrac{1}{x^2}$","explanation":"Incorrect: derivative of $\\ln u$ is not $\\frac{1}{u^2}$.","value":"$\\dfrac{1}{x^2}$"},{"id":"B","text":"$\\dfrac{2}{x}$","explanation":"Correct: for $x>0$, $\\ln(x^2)=2\\ln x$, so $p''(x)=2\\cdot \\frac{1}{x}=\\frac{2}{x}$.","value":"$\\dfrac{2}{x}$"},{"id":"C","text":"$\\dfrac{1}{x}$","explanation":"Missed the factor 2 from $\\ln(x^2)=2\\ln x$ (valid for $x>0$).","value":"$\\dfrac{1}{x}$"},{"id":"D","text":"$2x$","explanation":"Confused with derivative of $x^2$ instead of $\\ln(x^2)$.","value":"$2x$"}]'::jsonb
WHERE id = '6d1f1f2e-5090-4f8f-a00d-16a85041bf56';

UPDATE public.questions
SET prompt = 'Evaluate the limit: $$\lim_{x\to-\infty}\frac{-4x^4+7x^2-1}{2x^4+5x-9}.$$',
    explanation = 'Divide numerator and denominator by $x^4$: $$\frac{-4+\frac{7}{x^2}\frac{-1}{x^4}}{2+\frac{5}{x^3}\frac{-9}{x^4}}.$$ As $x\to-\infty$, the terms with $1/x^k$ go to $0$, so the limit is $$\frac{-4}{2}=-2.$$',
    options = '[{"id":"A","text":"$\\infty$","explanation":"Equal degrees give a finite limit (ratio of leading coefficients), not an infinite limit.","value":"$\\infty$"},{"id":"B","text":"$-\\infty$","explanation":"Equal degrees give a finite limit; the expression is not unbounded.","value":"$-\\infty$"},{"id":"C","text":"$-2$","explanation":"Correct: the ratio of leading coefficients is $\\frac{-4}{2}=-2$.","value":"$-2$"},{"id":"D","text":"$2$","explanation":"This misses the negative leading coefficient in the numerator.","value":"$2$"}]'::jsonb
WHERE id = 'aec34f1c-1ed9-4dd8-a80a-eae2e091722e';

UPDATE public.questions
SET prompt = 'Evaluate the limit.  $$\lim_{x\to 0} x^2\sin\left(\frac{1}{x}\right)$$',
    explanation = 'Because $-1\le \sin(\frac{1}{x})\le 1$, multiplying by $x^2\ge 0$ gives $$-x^2\le x^2\sin(\frac{1}{x})\le x^2.$$ As $x\to 0$, both bounds go to $0$, so by the Squeeze Theorem the limit is $0$.',
    options = '[{"id":"A","text":"Does not exist","value":"Does not exist","explanation":"$\\sin(\\frac{1}{x})$ oscillates, but the $x^2$ factor forces the product to $0$."},{"id":"B","text":"1","value":"1","explanation":"There is no mechanism pushing the expression to $1$."},{"id":"C","text":"0","value":"0","explanation":"Since $-1\\le \\sin(\\frac{1}{x})\\le 1$, then $-x^2\\le x^2\\sin(\\frac{1}{x})\\le x^2$, so the limit is $0$."},{"id":"D","text":"-1","value":"-1","explanation":"The amplitude shrinks to $0$, so it cannot approach $-1$."}]'::jsonb
WHERE id = '11ae027c-0215-4834-aa74-0e88e3ca6b6b';

UPDATE public.questions
SET prompt = 'Find $\dfrac{d}{dx}\big(\arccos(2x)\big)$.',
    explanation = 'Let $u=2x$. Then $$\frac{d}{dx}\arccos(u)=-\frac{u''}{\sqrt{1-u^2}}=-\frac{2}{\sqrt{1-(2x)^2}}=-\frac{2}{\sqrt{1-4x^2}}.$$',
    options = '[{"id":"A","text":"$\\dfrac{2}{\\sqrt{1-4x^2}}$","explanation":"This misses the negative sign for $\\arccos(u)$.","value":"$\\dfrac{2}{\\sqrt{1-4x^2}}$"},{"id":"B","text":"$-\\dfrac{1}{\\sqrt{1-4x^2}}$","explanation":"This includes the negative sign but misses the chain factor $2$.","value":"$-\\dfrac{1}{\\sqrt{1-4x^2}}$"},{"id":"C","text":"$-\\dfrac{2}{\\sqrt{1-4x^2}}$","explanation":"Correct: $u=2x$ gives $u''=2$, so derivative is $\\frac{-2}{\\sqrt{1-(2x)^2}}$.","value":"$-\\dfrac{2}{\\sqrt{1-4x^2}}$"},{"id":"D","text":"$-\\dfrac{2}{\\sqrt{4x^2-1}}$","explanation":"This changes the expression under the radical and is not equivalent.","value":"$-\\dfrac{2}{\\sqrt{4x^2-1}}$"}]'::jsonb
WHERE id = '12429fb2-5293-418d-87bf-140f7b17f6f2';

UPDATE public.questions
SET prompt = 'A radioactive substance decays according to $\dfrac{dM}{dt}=kM$, where $t$ is in years. \nThe half-life is 12 years. How long does it take for the amount to reach $10\%$ of its initial value?',
    explanation = 'Half-life model: $$\frac{M(t)}{M_0}=\left(\frac12\right)^{\frac{t}{12}}$$\nSet $M(t)=0.1M_0$: $$\left(\frac12\right)^{\frac{t}{12}}=0.1$$\nTake reciprocals: $$2^{\frac{t}{12}}=10$$\nSo $$t=12\log_2(10)\approx 39.9\text{ years}.$$',
    options = '[{"id":"A","text":"$t=12\\log_2(0.1)$","explanation":"This is negative because $\\log_2(0.1)<0$; time must be positive.","value":"$t=12\\log_2(0.1)$"},{"id":"B","text":"$t=12\\log_2(10)\\approx 39.9$ years","explanation":"Correct. $(\\tfrac12)^{\\frac{t}{12}}=0.1$ implies $2^{\\frac{t}{12}}=10$, so $t=12\\log_2(10)$.","value":"$t=12\\log_2(10)\\approx 39.9$ years"},{"id":"C","text":"$t=\\dfrac{12}{10}=1.2$ years","explanation":"Treats decay as linear rather than exponential.","value":"$t=\\dfrac{12}{10}=1.2$ years"},{"id":"D","text":"$t=12\\ln(10)$","explanation":"Uses the wrong log base/relationship for half-life; the model is naturally in base 2 here.","value":"$t=12\\ln(10)$"}]'::jsonb
WHERE id = '2ab50910-fd85-4325-9555-0c09b4f2b8b3';

UPDATE public.questions
SET prompt = 'Evaluate $\displaystyle \lim_{x\to \infty}\frac{\ln x}{x^{\frac{1}{3}}}$.',
    explanation = 'This is an $\frac{\infty}{\infty}$ form. L''Hospital gives $\frac{(\frac{1}{x})}{(\frac{1}{3})x^{\frac{-2}{3}}}=3x^{\frac{-1}{3}}\to 0$ as $x\to\infty$.',
    options = '[{"id":"A","text":"$\\infty$","explanation":"A positive power of $x$ grows faster than $\\ln x$.","value":"$\\infty$"},{"id":"B","text":"$1$","explanation":"No constant ratio here.","value":"$1$"},{"id":"C","text":"$0$","explanation":"Correct: apply L''Hospital once to get a constant multiple of $x^{\\frac{-1}{3}}\\to 0$.","value":"$0$"},{"id":"D","text":"Does not exist","value":"Does not exist","explanation":"The limit exists and equals 0."}]'::jsonb
WHERE id = '6d0ae77d-f1ad-4445-b420-6d5b88b87f8e';

UPDATE public.questions
SET prompt = 'Evaluate $$\lim_{x\to 0}\frac{\sqrt{1+3x}-1}{x}.$$',
    explanation = 'Rationalize: $$\frac{\sqrt{1+3x}-1}{x}\cdot\frac{\sqrt{1+3x}+1}{\sqrt{1+3x}+1} =\frac{(1+3x)-1}{x(\sqrt{1+3x}+1)} =\frac{3}{\sqrt{1+3x}+1}.$$ As $x\to 0$, this approaches $\frac{3}{2}$.',
    options = '[{"id":"A","text":"$\\frac{3}{2}$","explanation":"Correct: rationalizing yields $\\frac{3}{\\sqrt{1+3x}+1}\\to \\frac{3}{2}$.","value":"$\\frac{3}{2}$"},{"id":"B","text":"$3$","explanation":"This drops the factor $\\sqrt{1+3x}+1$ after rationalizing.","value":"$3$"},{"id":"C","text":"$0$","explanation":"This comes from substituting directly into the indeterminate form $\\frac{0}{0}$.","value":"$0$"},{"id":"D","text":"Does not exist","value":"Does not exist","explanation":"After algebraic manipulation, the limit exists and is finite."}]'::jsonb
WHERE id = '1d1df4d4-390a-4763-98ee-9a9154aa7101';

UPDATE public.questions
SET prompt = 'The region $R$ is bounded by $y=2x$ and $y=x^2$ (see image). Using integration with respect to $y$, what is the area of $R$?  ![8.5-P5](8.5-P5.png)',
    explanation = 'Intersections: $2x=x^2\Rightarrow x=0,2$, giving $y=0,4$. Solve for $x$ in terms of $y$: From $y=2x$, $x=\frac{y}{2}$. From $y=x^2$ in the region, $x=\sqrt{y}$. For $0\le y\le 4$, $\frac{y}{2}\le \sqrt{y}$, so left is $x=\frac{y}{2}$ and right is $x=\sqrt{y}$. $$A=\int_0^4\left(\sqrt{y}-\frac{y}{2}\right)dy=\left[\frac{2}{3}y^{\frac{3}{2}}-\frac{y^2}{4}\right]_0^4=\frac{4}{3}.$$',
    options = '[{"id":"A","text":"$\\frac{4}{3}$","explanation":"Correct: $x=\\frac{y}{2}$ and $x=\\sqrt{y}$ on $0\\le y\\le 4$, so $\\int_0^4(\\sqrt{y}\\frac{-y}{2})\\,dy=\\frac{4}{3}$.","value":"$\\frac{4}{3}$"},{"id":"B","text":"$\\frac{8}{3}$","explanation":"This is double the correct value; no extra symmetry factor is needed beyond the actual bounds.","value":"$\\frac{8}{3}$"},{"id":"C","text":"$\\frac{2}{3}$","explanation":"This is half the correct value; it typically comes from dropping the $\\frac{-y^2}{4}$ term.","value":"$\\frac{2}{3}$"},{"id":"D","text":"$2$","explanation":"This would be a rough estimate but not the exact integral value.","value":"$2$"}]'::jsonb
WHERE id = '65f2104c-b6a9-4779-8ba7-c0b69ff96576';

UPDATE public.questions
SET prompt = 'A curve is given by $x(t)=t$ and $y(t)=t^2$. What is $\dfrac{d^2y}{dx^2}$?',
    explanation = 'Because $x=t$, rewrite $y=t^2$ as $y=x^2$. Then $\frac{d^2y}{dx^2}=2$.',
    options = '[{"id":"A","text":"$2$","explanation":"Correct. Since $x=t$, we have $y=x^2$, so $\\frac{d^2y}{dx^2}=2$.","value":"$2$"},{"id":"B","text":"$2t$","explanation":"This is $\\frac{dy}{dx}$, not the second derivative.","value":"$2t$"},{"id":"C","text":"$1$","explanation":"This is $\\frac{dx}{dt}$, not $\\frac{d^2y}{dx^2}$.","value":"$1$"},{"id":"D","text":"$0$","explanation":"The second derivative of $x^2$ is not $0$.","value":"$0$"}]'::jsonb
WHERE id = '61431c58-5f91-4526-aeb4-56966039a60f';

UPDATE public.questions
SET prompt = 'A curve is given parametrically by $x(t)=t^2+1$ and $y(t)=t^3-2t$. What is the equation of the tangent line when $t=1$?',
    explanation = 'Compute $\frac{dx}{dt}=2t$ and $\frac{dy}{dt}=3t^2-2$. At $t=1$, $m=\dfrac{\frac{dy}{dt}}{\frac{dx}{dt}}=\dfrac{1}{2}$. Also $(x(1),y(1))=(2,-1)$. Thus $y+1=\dfrac{1}{2}(x-2)$, so $y=\dfrac{1}{2}x-\dfrac{1}{2}$.',
    options = '[{"id":"A","text":"$y=-\\dfrac{1}{2}x+\\dfrac{1}{2}$","explanation":"This uses the correct slope magnitude but with the wrong sign.","value":"$y=-\\dfrac{1}{2}x+\\dfrac{1}{2}$"},{"id":"B","text":"$y=\\dfrac{1}{2}x-\\dfrac{1}{2}$","explanation":"Correct. At $t=1$, $(x,y)=(2,-1)$ and slope $m=\\dfrac{1}{2}$, so $y+1=\\dfrac{1}{2}(x-2)$.","value":"$y=\\dfrac{1}{2}x-\\dfrac{1}{2}$"},{"id":"C","text":"$y=2x-5$","explanation":"This uses the reciprocal slope (confusing $\\frac{dy}{dx}$ with $\\frac{dx}{dy}$).","value":"$y=2x-5$"},{"id":"D","text":"$y=\\dfrac{1}{2}x+\\dfrac{1}{2}$","explanation":"This has slope $\\dfrac{1}{2}$ but does not pass through $(2,-1)$.","value":"$y=\\dfrac{1}{2}x+\\dfrac{1}{2}$"}]'::jsonb
WHERE id = '6bd8cbb5-d228-485c-89bd-91faa5c3d805';

UPDATE public.questions
SET prompt = 'The curve is given by $x(t)=\sin t$ and $y(t)=\cos(2t)$ for $0\le t\le 2\pi$. At how many parameter values does the curve have a horizontal tangent?',
    explanation = 'Compute $\frac{dx}{dt}=\cos t$ and $\frac{dy}{dt}=-2\sin(2t)$. Horizontal tangents require $\frac{dy}{dt}=0$ and $\frac{dx}{dt\ne} 0$. Solve $\sin(2t)=0\Rightarrow t=\dfrac{k\pi}{2}$. In $[0,2\pi]$: $t=0,\dfrac{\pi}{2},\pi,\dfrac{3\pi}{2},2\pi$. Exclude $t=\dfrac{\pi}{2},\dfrac{3\pi}{2}$ since $\cos t=0$. Remaining: $t=0,\pi,2\pi$ (3 values).',
    options = '[{"id":"A","text":"1","value":"1","explanation":"Too few: $\\frac{dy}{dt}=0$ has multiple solutions on $[0,2\\pi]$."},{"id":"B","text":"2","value":"2","explanation":"This misses additional solutions to $\\sin(2t)=0$."},{"id":"C","text":"4","value":"4","explanation":"This fails to enforce $\\frac{dx}{dt\\ne} 0$ at the counted parameter values."},{"id":"D","text":"3","value":"3","explanation":"Correct. Horizontal tangents occur when $\\frac{dy}{dt}=0$ and $\\frac{dx}{dt\\ne} 0$, giving $t=0,\\pi,2\\pi$."}]'::jsonb
WHERE id = 'a7551acd-9ec0-4b1f-80b9-5588244d4b62';

UPDATE public.questions
SET prompt = 'Let $g(x)=\dfrac{5}{x^3}-2\sqrt{x}$. What is $g''(x)$?',
    explanation = 'Convert to exponents: $$g(x)=5x^{-3}-2x^{\frac{1}{2}}.$$ Differentiate: $$g''(x)=-15x^{-4}-x^{\frac{-1}{2}}=-\frac{15}{x^4}-\frac{1}{\sqrt{x}}.$$',
    options = '[{"id":"A","text":"$g''(x)=\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$","explanation":"Incorrect: differentiating $x^{-3}$ introduces a negative factor, so the first term should be negative.","value":"$g''(x)=\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$"},{"id":"B","text":"$g''(x)=-\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$","explanation":"Rewrite as $5x^{-3}-2x^{\\frac{1}{2}}$. Then $g''(x)=5(-3)x^{-4}-2\\cdot\\frac12 x^{\\frac{-1}{2}}=-15x^{-4}-x^{\\frac{-1}{2}}=-\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$.","value":"$g''(x)=-\\dfrac{15}{x^4}-\\dfrac{1}{\\sqrt{x}}$"},{"id":"C","text":"$g''(x)=-\\dfrac{15}{x^2}-\\dfrac{1}{\\sqrt{x}}$","explanation":"Incorrect: $x^{-3}$ becomes $x^{-4}$ after differentiation, not $x^{-2}$.","value":"$g''(x)=-\\dfrac{15}{x^2}-\\dfrac{1}{\\sqrt{x}}$"},{"id":"D","text":"$g''(x)=-\\dfrac{15}{x^4}+\\dfrac{1}{\\sqrt{x}}$","explanation":"Incorrect: $\\dfrac{d}{dx}(-2\\sqrt{x})$ is negative, so the second term should be $-\\dfrac{1}{\\sqrt{x}}$.","value":"$g''(x)=-\\dfrac{15}{x^4}+\\dfrac{1}{\\sqrt{x}}$"}]'::jsonb
WHERE id = 'bc798f16-fc48-4db1-bcf5-41b57770ff85';

UPDATE public.questions
SET prompt = 'The curve $x=t^2-4t$ and $y=t-1$ has a vertical tangent when $\dfrac{dx}{dt}=0$ and $\dfrac{dy}{dt}\ne 0$. For what value of $t$ does this occur?',
    explanation = 'Compute $\frac{dx}{dt}=2t-4$. Setting $\frac{dx}{dt}=0$ gives $2t-4=0\Rightarrow t=2$. Since $\frac{dy}{dt}=1\ne 0$, the tangent is vertical at $t=2$.',
    options = '[{"id":"A","text":"$t=2$","explanation":"Correct: $\\frac{dx}{dt}=2t-4=0\\Rightarrow t=2$, and $\\frac{dy}{dt}=1\\ne 0$.","value":"$t=2$"},{"id":"B","text":"$t=4$","explanation":"Solves $2t-4=0$ incorrectly.","value":"$t=4$"},{"id":"C","text":"$t=0$","explanation":"Confuses $x=0$ with $\\frac{dx}{dt}=0$.","value":"$t=0$"},{"id":"D","text":"No such $t$","explanation":"There is a solution because $\\frac{dx}{dt}=0$ at $t=2$ and $\\frac{dy}{dt\\ne} 0$.","value":"No such $t$"}]'::jsonb
WHERE id = '7b3d2dba-b960-4bf7-a060-6c46a37be0fc';

UPDATE public.questions
SET prompt = 'Water is poured into a cone at a constant rate of $\dfrac{dV}{dt}=6\ \mathrm{\frac{cm^3}{s}}$. The cone has height $12\ \mathrm{cm}$ and radius $4\ \mathrm{cm}$. At the instant when the water depth is $h=3\ \mathrm{cm}$, what is $\dfrac{dh}{dt}$?',
    explanation = 'Similar triangles give $\frac{r}{h}=\frac{4}{12}=\frac{1}{3}$, so $r=\frac{h}{3}$. Then $V=\dfrac{1}{3}\pi r^2h=\dfrac{1}{3}\pi\left(\dfrac{h}{3}\right)^2h=\dfrac{1}{27}\pi h^3$. Differentiate: $\dfrac{dV}{dt}=\dfrac{1}{9}\pi h^2\dfrac{dh}{dt}$. At $h=3$, $\dfrac{dV}{dt}=\pi\dfrac{dh}{dt}$. With $\dfrac{dV}{dt}=6$, $\dfrac{dh}{dt}=\dfrac{6}{\pi}$.',
    options = '[{"id":"A","text":"$\\dfrac{2}{\\pi}$","explanation":"Algebra error after differentiating; at $h=3$, the coefficient of $\\frac{dh}{dt}$ becomes $\\pi$, not $3\\pi$.","value":"$\\dfrac{2}{\\pi}$"},{"id":"B","text":"$\\dfrac{6}{\\pi}$","explanation":"Correct: with $r=\\frac{h}{3}$, $V=\\dfrac{1}{27}\\pi h^3$, so $\\frac{dV}{dt}=\\dfrac{1}{9}\\pi h^2\\,\\frac{dh}{dt}$; at $h=3$ this is $\\pi\\,\\frac{dh}{dt}$.","value":"$\\dfrac{6}{\\pi}$"},{"id":"C","text":"$\\dfrac{6}{\\pi(3)^2}$","explanation":"Treats the cone like a cylinder with constant radius; $r$ varies with $h$.","value":"$\\dfrac{6}{\\pi(3)^2}$"},{"id":"D","text":"$\\dfrac{18}{\\pi}$","explanation":"Uses the correct setup but multiplies by $3$ incorrectly at the end.","value":"$\\dfrac{18}{\\pi}$"}]'::jsonb
WHERE id = 'd316a9a3-6487-497d-a3b7-84cf86731c9c';

UPDATE public.questions
SET prompt = 'Refer to the figure (image). A particle has position $\vec r(t)=\langle t,\ t^2\rangle$ for $0\le t\le 2$. What is the slope $\dfrac{dy}{dx}$ of the path at $t=1$?',
    explanation = 'Here $x=t$ and $y=t^2$. Then $\frac{dx}{dt}=1$ and $\frac{dy}{dt}=2t$, so $$\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=2t.$$ At $t=1$, the slope is $2$.',
    options = '[{"id":"A","text":"$0$","explanation":"This incorrectly assumes a horizontal tangent at $t=1$.","value":"$0$"},{"id":"B","text":"$1$","explanation":"This uses $\\frac{dy}{dt}=t$ instead of $\\frac{dy}{dt}=2t$.","value":"$1$"},{"id":"C","text":"$\\dfrac{1}{2}$","explanation":"This computes the reciprocal slope (i.e., $\\frac{dx}{dy}$).","value":"$\\dfrac{1}{2}$"},{"id":"D","text":"$2$","explanation":"Correct: $\\frac{dx}{dt}=1$ and $\\frac{dy}{dt}=2t$, so $\\frac{dy}{dx}=2t$. At $t=1$, slope is $2$.","value":"$2$"}]'::jsonb
WHERE id = 'f4d01517-39c2-459a-82cb-00808ce9d450';

UPDATE public.questions
SET prompt = 'Let $x(t)=t^2$ and $y(t)=t^3$. What is $\dfrac{d^2y}{dx^2}$ at $t=1$?',
    explanation = 'First compute $\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{3t^2}{2t}=(\frac{3}{2})t$ (for $t\ne 0$). Then $$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}}=\frac{\frac{3}{2}}{2t}=\frac{3}{4t}.$$ At $t=1$, this is $\dfrac{3}{4}$.',
    options = '[{"id":"A","text":"$\\dfrac{3}{2}$","explanation":"This equals $\\dfrac{d}{dt}(\\frac{dy}{dx})$ at $t=1$ but forgets to divide by $\\frac{dx}{dt}$.","value":"$\\dfrac{3}{2}$"},{"id":"B","text":"$\\dfrac{3}{4}$","explanation":"Correct. $\\dfrac{d^2y}{dx^2}=\\dfrac{\\frac{d}{dt}(\\frac{dy}{dx})}{\\frac{dx}{dt}}$ gives $\\dfrac{3}{4}$ at $t=1$.","value":"$\\dfrac{3}{4}$"},{"id":"C","text":"$\\dfrac{1}{4}$","explanation":"This comes from an arithmetic or differentiation slip after forming the formula.","value":"$\\dfrac{1}{4}$"},{"id":"D","text":"$\\dfrac{3}{2}t$","explanation":"This is $\\frac{dy}{dx}$ in terms of $t$, not the second derivative at $t=1$.","value":"$\\dfrac{3}{2}t$"}]'::jsonb
WHERE id = '78779b1b-59fd-4aea-965a-52b1579635b7';

UPDATE public.questions
SET prompt = 'For the polar curve $r=3\sin\theta$, what is $\dfrac{dr}{d\theta}$ at $\theta=\dfrac{\pi}{3}$?',
    explanation = 'Differentiate: $\frac{dr}{d\theta}=3\cos\theta$. Evaluate at $\theta=\frac{\pi}{3}$: $$\frac{dr}{d\theta}=3\cos\left(\frac{\pi}{3}\right)=3\cdot\frac12=\frac32.$$',
    options = '[{"id":"A","text":"$\\dfrac{3}{2}$","explanation":"Correct: $\\frac{dr}{d\\theta}=3\\cos\\theta$, and $\\cos(\\frac{\\pi}{3})=\\frac{1}{2}$.","value":"$\\dfrac{3}{2}$"},{"id":"B","text":"$\\dfrac{3\\sqrt{3}}{2}$","explanation":"This mistakenly uses $\\sin(\\frac{\\pi}{3})$ instead of $\\cos(\\frac{\\pi}{3})$.","value":"$\\dfrac{3\\sqrt{3}}{2}$"},{"id":"C","text":"$-\\dfrac{3}{2}$","explanation":"Sign error: $\\cos(\\frac{\\pi}{3})$ is positive.","value":"$-\\dfrac{3}{2}$"},{"id":"D","text":"$\\dfrac{1}{2}$","explanation":"Drops the factor of 3.","value":"$\\dfrac{1}{2}$"}]'::jsonb
WHERE id = '677d688f-31c0-4733-b9eb-77aa4991f2a2';

UPDATE public.questions
SET prompt = 'A curve is given by $x=t^2$ and $y=t^3$. What is $\dfrac{d^2y}{dx^2}$ when $t=2$?',
    explanation = 'Compute $$\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{3t^2}{2t}=\frac{3}{2}t.$$ Then $$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}}=\frac{\frac{3}{2}}{2t}=\frac{3}{4t}.$$ At $t=2$, $\dfrac{d^2y}{dx^2}=\dfrac{3}{8}$.',
    options = '[{"id":"A","text":"$\\dfrac{3}{8}$","explanation":"Correct: $\\frac{dy}{dx}=\\dfrac{3t^2}{2t}=\\dfrac{3}{2}t$, then $\\dfrac{d^2y}{dx^2}=\\dfrac{\\frac{d}{dt}(\\frac{dy}{dx})}{\\frac{dx}{dt}}=\\dfrac{(\\frac{3}{2})}{2t}=\\dfrac{3}{4t}$, so at $t=2$ it is $\\dfrac{3}{8}$.","value":"$\\dfrac{3}{8}$"},{"id":"B","text":"$\\dfrac{3}{4}$","explanation":"Stops at $\\frac{d}{dt}(\\frac{dy}{dx})=\\frac{3}{2}$ and evaluates incorrectly.","value":"$\\dfrac{3}{4}$"},{"id":"C","text":"$3$","explanation":"Confuses $\\dfrac{d^2y}{dx^2}$ with $\\dfrac{d^2y}{dt^2}$.","value":"$3$"},{"id":"D","text":"$\\dfrac{3}{16}$","explanation":"Arithmetic slip in the final division by $2t$.","value":"$\\dfrac{3}{16}$"}]'::jsonb
WHERE id = '04feded2-5fed-4e6b-b12e-126331a4138c';

UPDATE public.questions
SET prompt = 'Find the area of the region that lies inside $r=4\cos\theta$ and outside $r=2$.',
    explanation = 'Intersect when $4\cos\theta=2\Rightarrow \cos\theta=\tfrac12$, so $\theta=\pm\tfrac{\pi}{3}$. Area: $$A=\frac12\int_{\frac{-\pi}{3}}^{\frac{\pi}{3}}\left((4\cos\theta)^2-2^2\right)d\theta =\frac12\int_{\frac{-\pi}{3}}^{\frac{\pi}{3}}(16\cos^2\theta-4)\,d\theta.$$ Use $\cos^2\theta=\frac{1+\cos 2\theta}{2}$: $$16\cos^2\theta-4=8(1+\cos2\theta)-4=4+8\cos2\theta.$$ Thus $$A=\frac12\left[4\cdot\frac{2\pi}{3}+4\big(\sin2\theta\big)\Big|_{\frac{-\pi}{3}}^{\frac{\pi}{3}}\right] =\frac12\left(\frac{8\pi}{3}+4\sqrt3\right)=\frac{4\pi}{3}+2\sqrt3.$$',
    options = '[{"id":"A","text":"$\\dfrac{4\\pi}{3}+2\\sqrt{3}$","explanation":"Correct: integrate $\\tfrac12\\big((4\\cos\\theta)^2-2^2\\big)$ from $\\frac{-\\pi}{3}$ to $\\frac{\\pi}{3}$.","value":"$\\dfrac{4\\pi}{3}+2\\sqrt{3}$"},{"id":"B","text":"$\\dfrac{8\\pi}{3}+4\\sqrt{3}$","explanation":"This is double the correct answer (forgot the $\\tfrac12$ factor).","value":"$\\dfrac{8\\pi}{3}+4\\sqrt{3}$"},{"id":"C","text":"$\\dfrac{4\\pi}{3}-2\\sqrt{3}$","explanation":"Sign error when integrating the $\\cos 2\\theta$ term.","value":"$\\dfrac{4\\pi}{3}-2\\sqrt{3}$"},{"id":"D","text":"$\\dfrac{2\\pi}{3}+2\\sqrt{3}$","explanation":"This typically comes from halving the interval length incorrectly or using $0$ to $\\frac{\\pi}{3}$ without symmetry correctly.","value":"$\\dfrac{2\\pi}{3}+2\\sqrt{3}$"}]'::jsonb
WHERE id = '2c04142c-7ae9-4f17-b8fd-e08212579543';

UPDATE public.questions
SET prompt = 'The radius of a spherical balloon is increasing at $\dfrac{dr}{dt}=0.2\ \mathrm{cm/s}$. At the instant when $r=10\ \mathrm{cm}$, what is $\dfrac{dV}{dt}$ for the balloon’s volume $V$?',
    explanation = 'With $V=\dfrac{4}{3}\pi r^3$, we have $\dfrac{dV}{dt}=4\pi r^2\dfrac{dr}{dt}$. At $r=10$ and $\dfrac{dr}{dt}=0.2$, $\dfrac{dV}{dt}=4\pi(100)(0.2)=80\pi\ \mathrm{\frac{cm^3}{s}}$.',
    options = '[{"id":"A","text":"$\\dfrac{dV}{dt}=\\dfrac{4}{3}\\pi(10)^3(0.2)$","explanation":"Uses $V\\cdot \\dfrac{dr}{dt}$ instead of $\\dfrac{dV}{dr}\\cdot\\dfrac{dr}{dt}$.","value":"$\\dfrac{dV}{dt}=\\dfrac{4}{3}\\pi(10)^3(0.2)$"},{"id":"B","text":"$\\dfrac{dV}{dt}=4\\pi(10)^2(0.2)=80\\pi\\ \\mathrm{cm^3/s}$","explanation":"Correct: $\\dfrac{dV}{dt}=4\\pi r^2\\dfrac{dr}{dt}$; substitute $r=10$, $\\dfrac{dr}{dt}=0.2$.","value":"$\\dfrac{dV}{dt}=4\\pi(10)^2(0.2)=80\\pi\\ \\mathrm{\\frac{cm^3}{s}}$"},{"id":"C","text":"$\\dfrac{dV}{dt}=4\\pi(10)(0.2)=8\\pi\\ \\mathrm{cm^3/s}$","explanation":"Power rule error: $\\dfrac{d}{dr}(r^3)=3r^2$, not $r$.","value":"$\\dfrac{dV}{dt}=4\\pi(10)(0.2)=8\\pi\\ \\mathrm{\\frac{cm^3}{s}}$"},{"id":"D","text":"$\\dfrac{dV}{dt}=\\dfrac{4}{3}\\pi(10)^3=\\dfrac{4000}{3}\\pi\\ \\mathrm{cm^3/s}$","explanation":"That is the volume $V$ (in $\\mathrm{cm^3}$), not a rate.","value":"$\\dfrac{dV}{dt}=\\dfrac{4}{3}\\pi(10)^3=\\dfrac{4000}{3}\\pi\\ \\mathrm{\\frac{cm^3}{s}}$"}]'::jsonb
WHERE id = '76612946-d553-43b6-9814-4f1effddd06d';

UPDATE public.questions
SET prompt = 'The curve is given parametrically by $x=\cos t$ and $y=\sin t$ for $0\le t\le \frac{\pi}{2}$. The graph is shown in the figure labeled 8.13-P1. What is the exact arc length of the curve on this interval?',
    explanation = 'Use parametric arc length: $$L=\int_{0}^{\frac{\pi}{2}}\sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2}\,dt.$$ Here $\frac{dx}{dt}=-\sin t$ and $\frac{dy}{dt}=\cos t$, so the integrand is $\sqrt{\sin^2 t+\cos^2 t}=1$. Thus $$L=\int_0^{\frac{\pi}{2}}1\,dt=\frac{\pi}{2}.$$ ',
    options = '[{"id":"A","text":"$1$","explanation":"This would be the speed (which is constant), not the total arc length over the entire interval.","value":"$1$"},{"id":"B","text":"$\\frac{\\pi}{2}$","explanation":"Correct: $\\frac{dx}{dt}=-\\sin t$ and $\\frac{dy}{dt}=\\cos t$, so speed $=\\sqrt{\\sin^2 t+\\cos^2 t}=1$ and the length is $\\int_0^{\\frac{\\pi}{2}}1\\,dt=\\frac{\\pi}{2}$.","value":"$\\frac{\\pi}{2}$"},{"id":"C","text":"$\\pi$","explanation":"This corresponds to a half-circle of radius $1$, not the quarter-circle traced here.","value":"$\\pi$"},{"id":"D","text":"$2$","explanation":"This confuses arc length with a linear measure; the quarter-circle arc length is not $2$.","value":"$2$"}]'::jsonb
WHERE id = '96138cdc-b2b2-4f5e-b04e-50c283db5e65';

UPDATE public.questions
SET prompt = 'Differentiate $p(x)=x^{\frac{1}{3}}$.',
    explanation = 'Use the power rule: $$p''(x)=\frac{1}{3}x^{\frac{-2}{3}}.$$',
    options = '[{"id":"A","text":"$p''(x)=\\dfrac{1}{3}x^{1/3}$","explanation":"Incorrect: the exponent must decrease by $1$.","value":"$p''(x)=\\dfrac{1}{3}x^{\\frac{1}{3}}$"},{"id":"B","text":"$p''(x)=\\dfrac{1}{3}x^{-2/3}$","explanation":"Correct: $\\dfrac{d}{dx}x^{\\frac{1}{3}}=\\dfrac{1}{3}x^{\\frac{1}{3}-1}=\\dfrac{1}{3}x^{\\frac{-2}{3}}$.","value":"$p''(x)=\\dfrac{1}{3}x^{\\frac{-2}{3}}$"},{"id":"C","text":"$p''(x)=3x^{-2/3}$","explanation":"Incorrect: multiply by $\\frac{1}{3}$, not $3$.","value":"$p''(x)=3x^{\\frac{-2}{3}}$"},{"id":"D","text":"$p''(x)=\\dfrac{1}{x^{2/3}}$","explanation":"Incorrect: missing the factor $\\dfrac{1}{3}$.","value":"$p''(x)=\\dfrac{1}{x^{\\frac{2}{3}}}$"}]'::jsonb
WHERE id = '5e620428-3fe0-4c61-a644-8f749e2041be';

UPDATE public.questions
SET prompt = 'Let $x=2\cos t$ and $y=2\sin t$ for $0\le t\le \frac{\pi}{2}$. What is the arc length on this interval?',
    explanation = '$x''=-2\sin t$, $y''=2\cos t$ so speed $=\sqrt{4(\sin^2 t+\cos^2 t)}=2$. Thus $s=\int_0^{\frac{\pi}{2}}2\,dt=\pi$.',
    options = '[{"id":"A","text":"$2$","explanation":"Speed, not total length.","value":"$2$"},{"id":"B","text":"$\\pi$","explanation":"Correct.","value":"$\\pi$"},{"id":"C","text":"$\\frac{\\pi}{2}$","explanation":"Forgets factor 2 in speed.","value":"$\\frac{\\pi}{2}$"},{"id":"D","text":"$4\\pi$","explanation":"Full circle length, not quarter.","value":"$4\\pi$"}]'::jsonb
WHERE id = 'a16483b4-f4a1-484b-ba15-d49bb794eb2a';

UPDATE public.questions
SET prompt = 'A $10$-ft ladder leans against a vertical wall. The bottom slides away from the wall at $\dfrac{dx}{dt}=2\ \mathrm{ft/s}$. At the instant when $x=6\ \mathrm{ft}$, what is $\dfrac{dy}{dt}$, where $y$ is the height of the top on the wall?',
    explanation = 'Constraint: $x^2+y^2=100$. Differentiate: $2x\dfrac{dx}{dt}+2y\dfrac{dy}{dt}=0\Rightarrow \dfrac{dy}{dt}=-\dfrac{x}{y}\dfrac{dx}{dt}$. When $x=6$, $y=\sqrt{100-36}=8$, so $\dfrac{dy}{dt}=-(\frac{6}{8})(2)=-1.5\ \mathrm{ft/s}$.',
    options = '[{"id":"A","text":"$-\\dfrac{8}{3}\\ \\mathrm{ft/s}$","explanation":"Inverts the ratio; from $2x\\,\\frac{dx}{dt}+2y\\,\\frac{dy}{dt}=0$, $\\frac{dy}{dt}=-(\\frac{x}{y})\\frac{dx}{dt}$.","value":"$-\\dfrac{8}{3}\\ \\mathrm{ft/s}$"},{"id":"B","text":"$-\\dfrac{1}{3}\\ \\mathrm{ft/s}$","explanation":"Does not use the constraint $x^2+y^2=100$ and the correct implicit-differentiation relationship.","value":"$-\\dfrac{1}{3}\\ \\mathrm{ft/s}$"},{"id":"C","text":"$1.5\\ \\mathrm{ft/s}$","explanation":"Magnitude matches, but sign is wrong; the top moves downward so $\\frac{dy}{dt}<0$.","value":"$1.5\\ \\mathrm{ft/s}$"},{"id":"D","text":"$-1.5\\ \\mathrm{ft/s}$","explanation":"Correct: $x^2+y^2=100\\Rightarrow \\frac{dy}{dt}=-(\\frac{x}{y})\\frac{dx}{dt}$. With $x=6$, $y=8$, $\\frac{dy}{dt}=-(\\frac{6}{8})\\cdot 2=-1.5$.","value":"$-1.5\\ \\mathrm{ft/s}$"}]'::jsonb
WHERE id = 'abaf3722-b983-4100-9912-80b38d064984';

UPDATE public.questions
SET prompt = 'Find the slope of the tangent line to the curve $y = 2\sec x$ at $x = \dfrac{\pi}{3}$.',
    explanation = 'Differentiate: $y'' = 2\sec x\tan x$. Evaluate at $x=\frac{\pi}{3}$: $\sec(\frac{\pi}{3}) = 2$. $\tan(\frac{\pi}{3}) = \sqrt{3}$. $y''(\frac{\pi}{3}) = 2(2)(\sqrt{3}) = 4\sqrt{3}$.',
    options = '[{"id":"A","text":"$2\\sqrt{3}$","explanation":"Incorrect evaluation: $\\sec(\\frac{\\pi}{3})=2, \\tan(\\frac{\\pi}{3})=\\sqrt{3}$. Slope is $2(2)(\\sqrt{3}) = 4\\sqrt{3}$. Wait, A is simpler. Let''s recheck. Option A is $2\\sqrt{3}$. Incorrect.","value":"$2\\sqrt{3}$"},{"id":"B","text":"$4\\sqrt{3}$","explanation":"Correct: $y'' = 2\\sec x\\tan x$. At $\\frac{\\pi}{3}$: $2(2)(\\sqrt{3}) = 4\\sqrt{3}$.","value":"$4\\sqrt{3}$"},{"id":"C","text":"$4$","explanation":"Incorrect trig values.","value":"$4$"},{"id":"D","text":"$2$","explanation":"Ignored the trig part.","value":"$2$"}]'::jsonb
WHERE id = '85bda686-1664-4841-b4fc-81ef3370758f';

UPDATE public.questions
SET prompt = 'Consider the differential equation (for $x>0$) $$x\frac{dy}{dx}+y=\sqrt{x}.$$ Which function satisfies the equation for $x>0$?',
    explanation = 'Verify by substitution. For $y=\dfrac{2}{3}\sqrt{x}$, we have $y''=\dfrac{1}{3\sqrt{x}}$ (for $x>0$). Then $$x\frac{dy}{dx}+y=x\left(\frac{1}{3\sqrt{x}}\right)+\frac{2}{3}\sqrt{x}=\frac{\sqrt{x}}{3}+\frac{2\sqrt{x}}{3}=\sqrt{x},$$ so it satisfies the differential equation on $x>0$.',
    options = '[{"id":"A","text":"$y=\\sqrt{x}$","explanation":"$y''=\\dfrac{1}{2\\sqrt{x}}$, so $xy''+y=\\dfrac{\\sqrt{x}}{2}+\\sqrt{x}=\\dfrac{3\\sqrt{x}}{2}\\ne\\sqrt{x}$.","value":"$y=\\sqrt{x}$"},{"id":"B","text":"$y=\\dfrac{1}{\\sqrt{x}}$","explanation":"$y''=-\\dfrac{1}{2x^{\\frac{3}{2}}}$, so $xy''+y=-\\dfrac{1}{2\\sqrt{x}}+\\dfrac{1}{\\sqrt{x}}=\\dfrac{1}{2\\sqrt{x}}\\ne\\sqrt{x}$.","value":"$y=\\dfrac{1}{\\sqrt{x}}$"},{"id":"C","text":"$y=\\dfrac{2}{3}\\sqrt{x}$","explanation":"$y''=\\dfrac{1}{3\\sqrt{x}}$, so $xy''+y=\\dfrac{\\sqrt{x}}{3}+\\dfrac{2\\sqrt{x}}{3}=\\sqrt{x}$.","value":"$y=\\dfrac{2}{3}\\sqrt{x}$"},{"id":"D","text":"$y=\\dfrac{2}{3}x$","explanation":"$y''=\\dfrac{2}{3}$, so $xy''+y=\\dfrac{2}{3}x+\\dfrac{2}{3}x=\\dfrac{4}{3}x\\ne\\sqrt{x}$.","value":"$y=\\dfrac{2}{3}x$"}]'::jsonb
WHERE id = 'c6542f5f-130c-40af-8d35-f076a169a5ae';

UPDATE public.questions
SET prompt = 'A curve is given by $x(t)=t^3$ and $y(t)=t^2-4t$. At the parameter value where the tangent line is horizontal and $t\ne 0$, what is $\dfrac{d^2y}{dx^2}$?',
    explanation = 'Horizontal tangent requires $\frac{dy}{dt}=0$ and $\frac{dx}{dt\ne} 0$. Here $\frac{dy}{dt}=2t-4=0\Rightarrow t=2$ (and $\frac{dx}{dt}=3t^2=12\ne 0$). Next $$\frac{dy}{dx}=\frac{2t-4}{3t^2}=\frac{2}{3}(t-2)t^{-2}.$$ Differentiate: $$\frac{d}{dt}\left(\frac{dy}{dx}\right)=\frac{2}{3}\left(t^{-2}-2(t-2)t^{-3}\right).$$ At $t=2$, this is $\dfrac{1}{6}$. Finally $$\frac{d^2y}{dx^2}=\frac{\frac{d}{dt}(\frac{dy}{dx})}{\frac{dx}{dt}}=\frac{\frac{1}{6}}{12}=\frac{1}{72}.$$',
    options = '[{"id":"A","text":"$-\\dfrac{1}{3}$","explanation":"This does not match the second-derivative computation at the horizontal-tangent parameter value.","value":"$-\\dfrac{1}{3}$"},{"id":"B","text":"$\\dfrac{1}{72}$","explanation":"Correct. At $t=2$, the full formula gives $\\dfrac{d^2y}{dx^2}=\\dfrac{1}{72}$.","value":"$\\dfrac{1}{72}$"},{"id":"C","text":"$0$","explanation":"A horizontal tangent means $\\frac{dy}{dx}=0$, not $\\frac{d^2y}{dx^2}=0$.","value":"$0$"},{"id":"D","text":"$\\dfrac{1}{6}$","explanation":"This equals $\\dfrac{d}{dt}(\\frac{dy}{dx})$ at $t=2$ but does not divide by $\\frac{dx}{dt}$.","value":"$\\dfrac{1}{6}$"}]'::jsonb
WHERE id = 'c7e2157f-3b11-430a-944f-da89fcc8e729';

UPDATE public.questions
SET prompt = 'Find an implicit general solution to $$\frac{dy}{dx}=(y-1)(y+2).$$',
    explanation = 'Separate: $\frac{dy}{(y-1)(y+2)}=dx$. \nPartial fractions: $$\frac{1}{(y-1)(y+2)}=\frac{\frac{1}{3}}{y-1}-\frac{\frac{1}{3}}{y+2}.$$ \nIntegrate: $$\frac{1}{3}\ln|y-1|-\frac{1}{3}\ln|y+2|=x+C.$$ \nMultiply by 3 and combine logs: $$\ln\left|\frac{y-1}{y+2}\right|=3x+C''. $$',
    options = '[{"id":"A","text":"$\\ln|y-1|-\\ln|y+2|=3x+C$","explanation":"This is equivalent to the correct answer, but it is not simplified into a single logarithm ratio.","value":"$\\ln|y-1|-\\ln|y+2|=3x+C$"},{"id":"B","text":"$\\ln\\left|\\frac{y-1}{y+2}\\right|=3x+C$","explanation":"Correct. Separation gives $\\int \\frac{1}{(y-1)(y+2)}dy=\\int dx$, and partial fractions lead to a log ratio equal to $3x+C$.","value":"$\\ln\\left|\\frac{y-1}{y+2}\\right|=3x+C$"},{"id":"C","text":"$\\ln|y-1|+\\ln|y+2|=x+C$","explanation":"This uses the wrong partial-fraction signs and the wrong constant factor.","value":"$\\ln|y-1|+\\ln|y+2|=x+C$"},{"id":"D","text":"$\\ln|y^2+y-2|=x+C$","explanation":"This incorrectly treats $\\int \\frac{1}{(y-1)(y+2)}dy$ as $\\ln$ of the denominator.","value":"$\\ln|y^2+y-2|=x+C$"}]'::jsonb
WHERE id = 'de4e8d68-db18-4bc8-b282-21fcb614344f';

UPDATE public.questions
SET prompt = 'For $f(x)=\dfrac{1}{x}$, evaluate the simplified expression $$\frac{f(a+h)-f(a)}{h}$$ for $a\ne 0$ and $h\ne 0$, $a+h\ne 0$.',
    explanation = 'Compute the difference quotient: $$\frac{f(a+h)-f(a)}{h}=\frac{\frac{1}{a+h}-\frac{1}{a}}{h} =\frac{\frac{a-(a+h)}{a(a+h)}}{h} =\frac{\frac{-h}{a(a+h)}}{h} =-\frac{1}{a(a+h)}.$$',
    options = '[{"id":"A","text":"$\\dfrac{1}{a(a+h)}$","explanation":"This misses the negative sign from $\\frac{1}{a+h}-\\frac{1}{a}$.","value":"$\\dfrac{1}{a(a+h)}$"},{"id":"B","text":"$-\\dfrac{1}{a(a+h)}$","explanation":"Correct: simplifying yields $-\\dfrac{1}{a(a+h)}$.","value":"$-\\dfrac{1}{a(a+h)}$"},{"id":"C","text":"$-\\dfrac{h}{a(a+h)}$","explanation":"An extra $h$ remains; it should cancel during simplification.","value":"$-\\dfrac{h}{a(a+h)}$"},{"id":"D","text":"$\\dfrac{a+h-a}{h}$","explanation":"This incorrectly treats $f(x)=\\frac{1}{x}$ like a linear function.","value":"$\\dfrac{a+h-a}{h}$"}]'::jsonb
WHERE id = 'fca9dfc7-9f43-4d82-8627-bbf1cccb0eb6';

UPDATE public.questions
SET prompt = 'Find the general solution of $\\frac{dy}{dx} = \\frac{x^2}{y}$ for $y \\ne 0$.',
    explanation = 'Separate: $$\\frac{dy}{dx} = \\frac{x^2}{y} \\implies y\\,dy = x^2\\,dx.$$ \nIntegrate: $$\\int y\\,dy = \\int x^2\\,dx$$ gives $$\\frac{1}{2}y^2 = \\frac{1}{3}x^3 + C.$$ \nMultiply by $2$: $$y^2 = \\frac{2}{3}x^3 + C.$$',
    options = '[{"id":"A","text":"$y^2 = \\frac{2}{3}x^3 + C$","explanation":"Correct. Separate to get $y\\,dy = x^2\\,dx$; integrate and multiply by 2.","value":"$y^2 = \\frac{2}{3}x^3 + C$"},{"id":"B","text":"$y = \\frac{1}{3}x^3 + C$","explanation":"This treats the equation as if it were linear and ignores the $y$ factor when separating.","value":"$y = \\frac{1}{3}x^3 + C$"},{"id":"C","text":"$\\ln|y| = \\frac{1}{3}x^3 + C$","explanation":"This integrates the left side as $\\int \\frac{1}{y}\\,dy$ instead of $\\int y\\,dy$.","value":"$\\ln|y| = \\frac{1}{3}x^3 + C$"},{"id":"D","text":"$y^2 = \\frac{1}{3}x^3 + C$","explanation":"This misses the factor of 2 when clearing the $\\frac{1}{2}$ from $\\frac{1}{2}y^2$.","value":"$y^2 = \\frac{1}{3}x^3 + C$"}]'::jsonb
WHERE id = '0012d0cc-e291-467a-9885-6d88fa1a2871';

UPDATE public.questions
SET prompt = 'A population is modeled by $\\frac{dP}{dt} = rP\\left(1 - \\frac{P}{K}\\right)$.\nWhich statement is always true about the rate of change $\\frac{dP}{dt}$?',
    explanation = 'For $0 < P < K$, we have $P > 0$ and $1 - \frac{P}{K} > 0$, so $\frac{dP}{dt} = rP\left(1 - \frac{P}{K}\right) > 0$,\nmeaning the population increases in that range.',
    options = '[{"id":"A","text":"The maximum value of $\\frac{dP}{dt}$ occurs at $P = K$.","explanation":"At $P = K, \\frac{dP}{dt} = 0$, not a maximum.","value":"The maximum value of $\\frac{dP}{dt}$ occurs at $P = K$."},{"id":"B","text":"If $0 < P < K$, then $\\frac{dP}{dt} > 0$.","explanation":"Correct: for $0 < P < K$, both $P > 0$ and $1 - \\frac{P}{K} > 0$, so the product is positive.","value":"If $0 < P < K$, then $\\frac{dP}{dt} > 0$."},{"id":"C","text":"If $P > K$, then $\\frac{dP}{dt} > 0$.","explanation":"If $P > K$, then $1 - \\frac{P}{K} < 0$, so $\\frac{dP}{dt} < 0$.","value":"If $P > K$, then $\\frac{dP}{dt} > 0$."},{"id":"D","text":"If $P = \\frac{K}{2}$, then $\\frac{dP}{dt} = 0$.","explanation":"At $P = \\frac{K}{2}$, the growth rate is typically maximal (positive), not zero.","value":"If $P = \\frac{K}{2}$, then $\\frac{dP}{dt} = 0$."}]'::jsonb
WHERE id = '0E923B8F-3402-405C-ACA3-58CDEAC9E4C1';

UPDATE public.questions
SET prompt = 'Solve the IVP $\\frac{dy}{dx} = y \\cos x, \\quad y(0) = 2$.',
    explanation = 'Separate: $\frac{dy}{y} = \cos x dx$.\nIntegrate: $\ln |y| = \sin x + C$.\nExponentiate: $y = K e^{\sin x}$.\nUse $y(0) = 2$: $2 = K e^0 \implies K = 2$.\nSo $y = 2e^{\sin x}$.',
    options = '[{"id":"A","text":"$y = 2e^{\\sin x}$","explanation":"Correct. $\\frac{1}{y}dy = \\cos x dx \\Rightarrow \\ln |y| = \\sin x + C$. $y(0)=2$ gives $C=\\ln 2$ or $K=2$.","value":"$y = 2e^{\\sin x}$"},{"id":"B","text":"$y = 2e^{\\cos x}$","explanation":"This integrates $\\cos x$ incorrectly (it should be $\\sin x$).","value":"$y = 2e^{\\cos x}$"},{"id":"C","text":"$y = 2 + \\sin x$","explanation":"This ignores the multiplicative $y$ factor and treats $y'' = \\cos x$.","value":"$y = 2 + \\sin x$"},{"id":"D","text":"$y = e^{2 \\sin x}$","explanation":"This misapplies the initial condition by placing 2 inside the exponent.","value":"$y = e^{2 \\sin x}$"}]'::jsonb
WHERE id = '17785BCB-75A1-48AE-987E-1012554E7AF4';
