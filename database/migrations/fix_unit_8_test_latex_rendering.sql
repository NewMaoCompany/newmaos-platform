-- Comprehensive Fix for Unit 8 Test LaTeX Rendering (Version 5 - JSON Escaped & E'...' Syntax)
-- Addresses corrupted text, incorrect integral notation, and professional math mode formatting.
-- Uses E'...' syntax with quadruple backslashes for JSON fields and double backslashes for text fields.

-- Q1: Average Value of f(x) = x^2-1
UPDATE public.questions SET
    prompt = E'Let $f(x) = x^2-1$. What is the average value of $f$ on $[0,2]$?',
    explanation = E'Average value is $\\frac{1}{2-0} \\int_0^2 (x^2-1) \\, dx = \\frac{1}{2} \\left[\\frac{x^3}{3}-x\\right]_0^2 = \\frac{1}{3}$.',
    options = E'[{"id": "A", "value": "$\\\\frac{1}{3}$"}, {"id": "B", "value": "$\\\\frac{2}{3}$"}, {"id": "C", "value": "$\\\\frac{4}{3}$"}, {"id": "D", "value": "$\\\\frac{1}{6}$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q1' AND topic_id = 'Both_AppIntegration';

-- Q2: Average Value from Table (Trapezoidal Rule)
UPDATE public.questions SET
    prompt = E'A table of $f(x)$ values on $[0,4]$ is shown. Using the trapezoidal rule with $\\Delta x = 1$, approximate the average value of $f$ on $[0,4]$.',
    explanation = E'Trapezoidal approximation: $\\frac{1}{2}[f_0+2f_1+2f_2+2f_3+f_4] = \\frac{1}{2}[2+5+3+6+2] = 9$. Average value is $\\frac{1}{4} \\cdot 9 = 2.25$.',
    options = E'[{"id": "A", "value": "2.25"}, {"id": "B", "value": "2.00"}, {"id": "C", "value": "2.50"}, {"id": "D", "value": "9.00"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q2' AND topic_id = 'Both_AppIntegration';

-- Q3: Average Value Interpretation (Power Output)
UPDATE public.questions SET
    prompt = E'A function $P(t)$ gives power output (in kilowatts) over $0 \\le t \\le 6$ hours. Which statement best describes the meaning of the average value of $P$ on $[0,6]$?',
    explanation = E'Average value represents a constant output whose rectangle area matches the total area under $P(t)$ over the interval.',
    options = E'[{"id": "A", "value": "The constant power level that would produce the same total energy over 6 hours."}, {"id": "B", "value": "The total energy produced over 6 hours."}, {"id": "C", "value": "The maximum power output during the 6 hours."}, {"id": "D", "value": "The time when the power output is increasing fastest."}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q3' AND topic_id = 'Both_AppIntegration';

-- Q4: Total Distance from Velocity Graph
UPDATE public.questions SET
    prompt = E'The velocity graph $v(t)$ is shown for $0 \\le t \\le 4$. What is the total distance traveled on $[0,4]$?',
    explanation = E'Total distance is $\\int_0^4 |v(t)| \\, dt$. From $0$ to $1.5$ area is $\\frac{1}{2}(1.5)(3) = 2.25$. From $1.5$ to $2$ area is $\\frac{1}{2}(0.5)(1) = 0.25$. From $2$ to $4$ area is $|-1| \\cdot 2 = 2$. Total $= 4.5$.',
    options = E'[{"id": "A", "value": "4.5"}, {"id": "B", "value": "1.5"}, {"id": "C", "value": "0.5"}, {"id": "D", "value": "3.5"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q4' AND topic_id = 'Both_AppIntegration';

-- Q5: Position from Velocity and Initial Condition
UPDATE public.questions SET
    prompt = E'A particle has velocity $v(t) = 2t-1$ and position $s(0) = 5$. What is $s(3)$?',
    explanation = E'$s(3) = s(0) + \\int_0^3 (2t-1) \\, dt = 5 + [t^2-t]_0^3 = 5 + (9-3) = 11$.',
    options = E'[{"id": "A", "value": "11"}, {"id": "B", "value": "9"}, {"id": "C", "value": "6"}, {"id": "D", "value": "14"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q5' AND topic_id = 'Both_AppIntegration';

-- Q6: Accumulation from Rate Table (Trapezoidal)
UPDATE public.questions SET
    prompt = E'A tank\'\'s net flow rate is $r(t)$ (L/hr). A table of $r(t)$ values is shown for $0 \\le t \\le 4$. Using the trapezoidal rule with $\\Delta t = 1$, approximate the net change in volume over $[0,4]$.',
    explanation = E'Trapezoids: $\\frac{1}{2}[5+2(3)+2(-1)+2(2)+4] = \\frac{1}{2}(17) = 8.5$ liters.',
    options = E'[{"id": "A", "value": "8.5 L"}, {"id": "B", "value": "17 L"}, {"id": "C", "value": "9.0 L"}, {"id": "D", "value": "6.5 L"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q6' AND topic_id = 'Both_AppIntegration';

-- Q7: Net vs Total Change Accumulated (r(t))
UPDATE public.questions SET
    prompt = E'A rate function $r(t)$ can be positive or negative. Which expression represents the total amount of change accumulated over $[a,b]$, regardless of direction?',
    explanation = E'Net change is $\\int_a^b r(t) \\, dt$. Total change ignores direction and uses $\\int_a^b |r(t)| \\, dt$.',
    options = E'[{"id": "A", "value": "$\\\\int_a^b r(t) \\\\, dt$"}, {"id": "B", "value": "$\\\\int_a^b |r(t)| \\\\, dt$"}, {"id": "C", "value": "$|\\\\int_a^b r(t) \\\\, dt|$"}, {"id": "D", "value": "$\\\\int_a^b r(t)^2 \\\\, dt$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q7' AND topic_id = 'Both_AppIntegration';

-- Q8: Area Between Curves (4-x^2 and x)
UPDATE public.questions SET
    prompt = E'The region between $y = 4-x^2$ and $y=x$ is shown. Which integral gives the area of the shaded region (with respect to $x$)?',
    explanation = E'Area with $dx$ uses top-minus-bottom: $(4-x^2)-x$, with bounds at the intersection points solving $4-x^2=x$.',
    options = E'[{"id": "A", "value": "$\\\\int_{(-1-\\\\sqrt{17})/2}^{(-1+\\\\sqrt{17})/2} ((4-x^2)-x) \\\\, dx$"}, {"id": "B", "value": "$\\\\int_{(-1-\\\\sqrt{17})/2}^{(-1+\\\\sqrt{17})/2} (x-(4-x^2)) \\\\, dx$"}, {"id": "C", "value": "$\\\\int_{-1}^{2} ((4-x^2)-x) \\\\, dx$"}, {"id": "D", "value": "$|\\\\int_{(-1-\\\\sqrt{17})/2}^{(-1+\\\\sqrt{17})/2} ((4-x^2)-x) \\\\, dx|$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q8' AND topic_id = 'Both_AppIntegration';

-- Q9: Area Between Curves (dy) (x=y^2 and x=2-y)
UPDATE public.questions SET
    prompt = E'The region is bounded by $x=y^2$ and $x=2-y$. Which integral gives the area of the region (with respect to $y$)?',
    explanation = E'With $dy$, use right-minus-left. Intersections solve $y^2 = 2-y$ giving $y=-2,1$. Right curve is $x=2-y$ and left curve is $x=y^2$.',
    options = E'[{"id": "A", "value": "$\\\\int_{-2}^{1} ((2-y)-y^2) \\\\, dy$"}, {"id": "B", "value": "$\\\\int_{-2}^{1} (y^2-(2-y)) \\\\, dy$"}, {"id": "C", "value": "$\\\\int_{0}^{2} ((2-y)-y^2) \\\\, dy$"}, {"id": "D", "value": "$\\\\int_{-2}^{1} ((2-y)^2-(y^2)^2) \\\\, dy$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q9' AND topic_id = 'Both_AppIntegration';

-- Q10: Area for sin(x) on [0, 2pi]
UPDATE public.questions SET
    prompt = E'Which expression equals the area between $y = \\sin(x)$ and the $x$-axis on $[0,2\\pi]$?',
    explanation = E'Area requires absolute value/splitting when the function changes sign. $\\sin(x)$ is positive on $[0,\\pi]$ and negative on $[\\pi,2\\pi]$.',
    options = E'[{"id": "A", "value": "$\\\\int_0^{2\\\\pi} \\\\sin(x) \\\\, dx$"}, {"id": "B", "value": "$\\\\int_0^\\\\pi \\\\sin(x) \\\\, dx - \\\\int_\\\\pi^{2\\\\pi} \\\\sin(x) \\\\, dx$"}, {"id": "C", "value": "$\\\\int_0^{2\\\\pi} \\\\sin^2(x) \\\\, dx$"}, {"id": "D", "value": "$|\\\\int_0^{2\\\\pi} \\\\sin(x) \\\\, dx|$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q10' AND topic_id = 'Both_AppIntegration';

-- Q11: Cross-Section Area Function (Square)
UPDATE public.questions SET
    prompt = E'A base region is bounded by $y=x$ and $y=2$ for $0 \\le x \\le 2$. Cross-sections perpendicular to the $x$-axis are squares. What is the correct area function $A(x)$?',
    explanation = E'The side length is the vertical distance top-minus-bottom: $2-x$. Square area is $(2-x)^2$.',
    options = E'[{"id": "A", "value": "$(2-x)^2$"}, {"id": "B", "value": "$(2+x)$"}, {"id": "C", "value": "$2-x$"}, {"id": "D", "value": "$\\\\pi(2-x)^2$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q11' AND topic_id = 'Both_AppIntegration';

-- Q12: Cross-Section Volume (Square)
UPDATE public.questions SET
    prompt = E'The base region $R$ is shown between $y=x$ and $y=2$ for $0 \\le x \\le 2$. Cross-sections perpendicular to the $x$-axis are squares. What is the volume?',
    explanation = E'Side length is $2-x$, so $A(x) = (2-x)^2$. Volume $= \\int_0^2 (2-x)^2 \\, dx = \\frac{8}{3}$.',
    options = E'[{"id": "A", "value": "$\\\\frac{8}{3}$"}, {"id": "B", "value": "4"}, {"id": "C", "value": "$\\\\frac{16}{3}$"}, {"id": "D", "value": "$\\\\frac{8\\\\pi}{3}$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q12' AND topic_id = 'Both_AppIntegration';

-- Q13: Cross-Section Volume (Semicircle)
UPDATE public.questions SET
    prompt = E'The base region is bounded by $y=x$ and $y=2$ on $0 \\le x \\le 2$. Cross-sections perpendicular to the $x$-axis are semicircles with diameter equal to the vertical distance in the base. What is the volume?',
    explanation = E'Diameter is $s = 2-x$, so radius $r = \\frac{2-x}{2}$. Area is $\\frac{1}{2}\\pi r^2 = \\frac{\\pi}{8}(2-x)^2$. Volume $= \\frac{\\pi}{8} \\int_0^2 (2-x)^2 \\, dx = \\frac{\\pi}{8} \\cdot \\frac{8}{3} = \\frac{\\pi}{3}$.',
    options = E'[{"id": "A", "value": "$\\\\frac{\\\\pi}{3}$"}, {"id": "B", "value": "$\\\\frac{2\\\\pi}{3}$"}, {"id": "C", "value": "$\\\\frac{\\\\pi}{6}$"}, {"id": "D", "value": "$\\\\frac{8\\\\pi}{3}$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q13' AND topic_id = 'Both_AppIntegration';

-- Q14: Volume by Disk Method (sqrt(x))
UPDATE public.questions SET
    prompt = E'The region under $y = \\sqrt{x}$ from $x=0$ to $x=4$ is revolved about the $x$-axis. What is the volume?',
    explanation = E'Disk method: $V = \\pi \\int_0^4 (\\sqrt{x})^2 \\, dx = \\pi \\int_0^4 x \\, dx = \\pi [\\frac{x^2}{2}]_0^4 = 8\\pi$.',
    options = E'[{"id": "A", "value": "$8\\\\pi$"}, {"id": "B", "value": "$4\\\\pi$"}, {"id": "C", "value": "$16\\\\pi$"}, {"id": "D", "value": "$\\\\frac{16\\\\pi}{3}$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q14' AND topic_id = 'Both_AppIntegration';

-- Q15: Volume by Washer Method (Shifted Axis)
UPDATE public.questions SET
    prompt = E'The region $x^2 \\le y \\le 4$ for $-2 \\le x \\le 2$ is shown and is revolved about $y=1$. Which integral gives the volume using washers?',
    explanation = E'About $y=1$, outer radius is $R = 4-1=3$ and inner radius is $r = x^2-1$. Volume is $\\pi \\int_{-2}^2 (3^2 - (x^2-1)^2) \\, dx$.',
    options = E'[{"id": "A", "value": "$\\\\pi \\\\int_{-2}^2 (3^2 - (x^2-1)^2) \\\\, dx$"}, {"id": "B", "value": "$\\\\pi \\\\int_{-2}^2 (4-x^2)^2 \\\\, dx$"}, {"id": "C", "value": "$\\\\pi \\\\int_{-2}^2 (3 - (x^2-1)) \\\\, dx$"}, {"id": "D", "value": "$\\\\int_{-2}^2 (3^2 - (x^2-1)^2) \\\\, dx$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q15' AND topic_id = 'Both_AppIntegration';

-- Q16: Volume by Disk Method (y-axis)
UPDATE public.questions SET
    prompt = E'The region bounded by $y = x^2$, $y = 4$, and the $y$-axis is revolved about the $y$-axis. Which integral gives the volume using disks (with respect to $y$)?',
    explanation = E'At height $y$, the radius is $x = \\sqrt{y}$. Volume is $\\pi \\int_0^4 (\\sqrt{y})^2 \\, dy = \\pi \\int_0^4 y \\, dy$.',
    options = E'[{"id": "A", "value": "$\\\\pi \\\\int_0^4 y \\\\, dy$"}, {"id": "B", "value": "$\\\\pi \\\\int_0^2 (x^2)^2 \\\\, dx$"}, {"id": "C", "value": "$\\\\pi \\\\int_0^4 \\\\sqrt{y} \\\\, dy$"}, {"id": "D", "value": "$\\\\int_0^4 y \\\\, dy$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q16' AND topic_id = 'Both_AppIntegration';

-- Q17: Radius Distance to Shifted Axis
UPDATE public.questions SET
    prompt = E'A region is revolved about the line $y=1$. If a boundary curve is $y=x^2$, which expression correctly gives the distance from the curve to the axis (a radius) at a given $x$?',
    explanation = E'Distance is $|y_{curve} - y_{axis}| = |x^2 - 1|$.',
    options = E'[{"id": "A", "value": "$|x^2-1|$"}, {"id": "B", "value": "$x^2+1$"}, {"id": "C", "value": "$1-x$"}, {"id": "D", "value": "$x-1$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q17' AND topic_id = 'Both_AppIntegration';

-- Q18: Arc Length Formula (ln(x+1))
UPDATE public.questions SET
    prompt = E'The curve $y = \\ln(x+1)$ on $0 \\le x \\le 3$ is shown. Which integral gives the arc length of the curve on this interval?',
    explanation = E'For $y = \\ln(x+1)$, $dy/dx = \\frac{1}{x+1}$. Arc Length is $\\int_0^3 \\sqrt{1 + (\\frac{1}{x+1})^2} \\, dx$.',
    options = E'[{"id": "A", "value": "$\\\\int_0^3 \\\\sqrt{1 + (\\\\frac{1}{x+1})^2} \\\\, dx$"}, {"id": "B", "value": "$\\\\int_0^3 (1 + \\\\frac{1}{x+1}) \\\\, dx$"}, {"id": "C", "value": "$\\\\int_0^3 \\\\sqrt{1 + \\\\frac{1}{x+1}} \\\\, dx$"}, {"id": "D", "value": "$\\\\int_0^3 (1 + (\\\\frac{1}{x+1})^2) \\\\, dx$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q18' AND topic_id = 'Both_AppIntegration';

-- Q19: Arc Length Integrand (sin x)
UPDATE public.questions SET
    prompt = E'Which integrand is used to compute the arc length of $y = \\sin(x)$ on an interval (with respect to $x$)?',
    explanation = E'For $y = \\sin(x)$, $dy/dx = \\cos(x)$. Integrand is $\\sqrt{1 + (\\cos x)^2}$.',
    options = E'[{"id": "A", "value": "$\\\\sqrt{1 + \\\\cos^2 x}$"}, {"id": "B", "value": "$\\\\sqrt{1 + \\\\sin^2 x}$"}, {"id": "C", "value": "$1 + \\\\cos x$"}, {"id": "D", "value": "$1 + \\\\cos^2 x$"}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q19' AND topic_id = 'Both_AppIntegration';

-- Q20: Units Interpretation (Water Flow Rate)
UPDATE public.questions SET
    prompt = E'A function $r(t)$ gives a water flow rate in gallons per hour. Which statement best describes the meaning and units of $\\int_2^5 r(t) \\, dt$?',
    explanation = E'Integrating rate (gallons/hr) over time (hr) gives net change in amount (gallons).',
    options = E'[{"id": "A", "value": "It gives the total gallons added between $t=2$ and $t=5$ (units: gallons)."}, {"id": "B", "value": "It gives the average flow rate between $t=2$ and $t=5$ (units: gallons per hour)."}, {"id": "C", "value": "It gives the flow rate at $t=5$ (units: gallons per hour)."}, {"id": "D", "value": "It gives the time elapsed from $t=2$ to $t=5$ (units: hours)."}]'::jsonb,
    updated_at = NOW()
WHERE title = 'U8-UT-Q20' AND topic_id = 'Both_AppIntegration';
