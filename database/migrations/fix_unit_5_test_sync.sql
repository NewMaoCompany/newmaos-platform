-- Sync Unit 5 Test Questions from Seed File (Corrected)
-- Fixing JSON syntax error by correctly extracting options field.


UPDATE public.questions
SET
    prompt = $txt$A function $f$ is continuous on $[1,5]$ and differentiable on $(1,5)$. Which statement is guaranteed by the Mean Value Theorem?$txt$,
    latex = $txt$A function $f$ is continuous on $[1,5]$ and differentiable on $(1,5)$. Which statement is guaranteed by the Mean Value Theorem?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "There exists $c$ in $(1,5)$ such that $f(c)$ equals the average of $f(1)$ and $f(5)$.", "type": "text", "explanation": "Incorrect: That is an average-value statement, not MVT."},
          {"id": "B", "label": "B", "value": "There exists $c$ in $(1,5)$ such that the tangent slope at $c$ equals the secant slope from $1$ to $5$.", "type": "text", "explanation": "Correct: derivative at $c$ matches the secant slope."},
          {"id": "C", "label": "C", "value": "There exists $c$ in $(1,5)$ such that $f(c)$ is a maximum value on $[1,5]$.", "type": "text", "explanation": "Incorrect: That is EVT-related, not MVT."},
          {"id": "D", "label": "D", "value": "There exists $c$ in $(1,5)$ such that $f'(c)$ equals 0.", "type": "text", "explanation": "Incorrect: Not guaranteed; MVT does not force a horizontal tangent."}
        ]$txt$,
    explanation = $txt$MVT states that when $f$ is continuous on a closed interval and differentiable on the open interval, there exists a point where the derivative equals the average rate of change over the interval.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q01';


UPDATE public.questions
SET
    prompt = $txt$Which is a sufficient condition to guarantee that a continuous function $f$ attains both an absolute maximum and an absolute minimum?$txt$,
    latex = $txt$Which is a sufficient condition to guarantee that a continuous function $f$ attains both an absolute maximum and an absolute minimum?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ is differentiable on an open interval $(a,b)$.", "type": "text", "explanation": "Incorrect: Differentiability on an open interval does not guarantee absolute extrema."},
          {"id": "B", "label": "B", "value": "$f$ is continuous on a closed interval $[a,b]$.", "type": "text", "explanation": "Correct: continuity on a closed interval triggers EVT."},
          {"id": "C", "label": "C", "value": "$f$ is continuous on $(a,b)$ only.", "type": "text", "explanation": "Incorrect: Open intervals can fail to attain extrema."},
          {"id": "D", "label": "D", "value": "$f$ is differentiable on $[a,b]$.", "type": "text", "explanation": "Incorrect: Differentiability is stronger than continuity, but the key is closed interval; the option is ambiguous and not the standard sufficient condition stated."}
        ]$txt$,
    explanation = $txt$The Extreme Value Theorem guarantees absolute extrema when $f$ is continuous on a closed interval.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q02';


UPDATE public.questions
SET
    prompt = $txt$Which list includes all possible x-values that can be critical points of $f$ on an interval?$txt$,
    latex = $txt$Which list includes all possible x-values that can be critical points of $f$ on an interval?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "Only where $f(x)=0$.", "type": "text", "explanation": "Incorrect: Zeros of $f$ are not necessarily critical points."},
          {"id": "B", "label": "B", "value": "Only where $f'(x)=0$.", "type": "text", "explanation": "Incorrect: Misses points where $f'$ does not exist."},
          {"id": "C", "label": "C", "value": "Where $f'(x)=0$ or where $f'(x)$ does not exist, provided $f$ exists.", "type": "text", "explanation": "Correct: Definition of critical points."},
          {"id": "D", "label": "D", "value": "Where $f$ is continuous.", "type": "text", "explanation": "Incorrect: Continuity alone does not determine critical points."}
        ]$txt$,
    explanation = $txt$Critical points occur where the derivative is zero or undefined (as long as the function is defined there).$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q03';


UPDATE public.questions
SET
    prompt = $txt$Use the provided graph of $f$ on $[0,6]$. Which statement is correct about the absolute extrema on $[0,6]$?$txt$,
    latex = $txt$Use the provided graph of $f$ on $[0,6]$. Which statement is correct about the absolute extrema on $[0,6]$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "The absolute maximum occurs at an endpoint only.", "type": "text", "explanation": "Incorrect: Not guaranteed; maximum can be interior."},
          {"id": "B", "label": "B", "value": "The absolute minimum occurs at an endpoint only.", "type": "text", "explanation": "Incorrect: Not guaranteed; minimum can be interior."},
          {"id": "C", "label": "C", "value": "To find absolute extrema, compare endpoints and interior critical points.", "type": "text", "explanation": "Correct: Correct candidates-test procedure."},
          {"id": "D", "label": "D", "value": "Absolute extrema cannot occur where $f'$ does not exist.", "type": "text", "explanation": "Incorrect: They can occur at points where $f'$ is undefined (if $f$ is defined)."}
        ]$txt$,
    explanation = $txt$Candidates test: evaluate $f$ at endpoints and all critical points in the interval, then compare values to decide absolute max/min.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q04';


UPDATE public.questions
SET
    prompt = $txt$Suppose $f'(x) < 0$ for all $x$ in $(2,7)$. What can be concluded about $f$ on $(2,7)$?$txt$,
    latex = $txt$Suppose $f'(x) < 0$ for all $x$ in $(2,7)$. What can be concluded about $f$ on $(2,7)$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ is increasing on $(2,7)$.", "type": "text", "explanation": "Incorrect: Sign logic is reversed."},
          {"id": "B", "label": "B", "value": "$f$ is decreasing on $(2,7)$.", "type": "text", "explanation": "Correct: $f$ decreases when $f'$ is negative."},
          {"id": "C", "label": "C", "value": "$f$ has a local maximum at every $x$ in $(2,7)$.", "type": "text", "explanation": "Incorrect: Local maxima require a sign change, not constant negativity."},
          {"id": "D", "label": "D", "value": "$f$ must have an inflection point in $(2,7)$.", "type": "text", "explanation": "Incorrect: Inflection concerns the second derivative, not the sign of $f'$."}
        ]$txt$,
    explanation = $txt$A negative derivative means the function is decreasing on that interval.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q05';


UPDATE public.questions
SET
    prompt = $txt$At $x=3$, $f'(x)$ changes from positive to negative. What must be true about $f$ at $x=3$?$txt$,
    latex = $txt$At $x=3$, $f'(x)$ changes from positive to negative. What must be true about $f$ at $x=3$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local minimum at $x=3$.", "type": "text", "explanation": "Incorrect: A local minimum would require negative to positive change."},
          {"id": "B", "label": "B", "value": "$f$ has a local maximum at $x=3$.", "type": "text", "explanation": "Correct: + to - indicates a local maximum."},
          {"id": "C", "label": "C", "value": "$f$ has an inflection point at $x=3$.", "type": "text", "explanation": "Incorrect: Inflection is about concavity change, not $f'$ sign change."},
          {"id": "D", "label": "D", "value": "$f$ has no extremum at $x=3$.", "type": "text", "explanation": "Incorrect: A sign change indicates an extremum."}
        ]$txt$,
    explanation = $txt$First derivative test: $f$ increases then decreases, so there is a local maximum at the transition point.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q06';


UPDATE public.questions
SET
    prompt = $txt$Use the provided temperature table. What is the average rate of change of temperature from $t=0$ to $t=6$ minutes, in degrees per minute?$txt$,
    latex = $txt$Use the provided temperature table. What is the average rate of change of temperature from $t=0$ to $t=6$ minutes, in degrees per minute?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "2.5", "type": "text", "explanation": "Correct: Correct computation from the endpoints of the interval."},
          {"id": "B", "label": "B", "value": "2.0", "type": "text", "explanation": "Incorrect: Arithmetic error."},
          {"id": "C", "label": "C", "value": "15.0", "type": "text", "explanation": "Incorrect: That is the total change, not per minute."},
          {"id": "D", "label": "D", "value": "0.4", "type": "text", "explanation": "Incorrect: Uses the reciprocal."}
        ]$txt$,
    explanation = $txt$Average rate = $(T(6)-T(0)) / (6-0) = (83-68)/6 = 15/6 = 2.5$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q07';


UPDATE public.questions
SET
    prompt = $txt$Assume the temperature function $T(t)$ is continuous on $[0,6]$ and differentiable on $(0,6)$. Using your result from the average rate of change on $[0,6]$, what does MVT guarantee?$txt$,
    latex = $txt$Assume the temperature function $T(t)$ is continuous on $[0,6]$ and differentiable on $(0,6)$. Using your result from the average rate of change on $[0,6]$, what does MVT guarantee?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "There exists $c$ in $(0,6)$ such that $T(c)$ equals the average of $T(0)$ and $T(6)$.", "type": "text", "explanation": "Incorrect: That is not what MVT states."},
          {"id": "B", "label": "B", "value": "There exists $c$ in $(0,6)$ such that $T'(c)$ equals the average rate of change on $[0,6]$.", "type": "text", "explanation": "Correct: Correct MVT conclusion."},
          {"id": "C", "label": "C", "value": "There exists $c$ in $(0,6)$ such that $T'(c)=0$.", "type": "text", "explanation": "Incorrect: Not guaranteed by MVT."},
          {"id": "D", "label": "D", "value": "There exists $c$ in $(0,6)$ such that $T$ has an absolute maximum at $c$.", "type": "text", "explanation": "Incorrect: That is not guaranteed by MVT."}
        ]$txt$,
    explanation = $txt$MVT guarantees an instantaneous rate (derivative) matching the average rate over the interval.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q08';


UPDATE public.questions
SET
    prompt = $txt$Which statement correctly distinguishes a local maximum from an absolute maximum?$txt$,
    latex = $txt$Which statement correctly distinguishes a local maximum from an absolute maximum?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "A local maximum must occur at an endpoint; an absolute maximum cannot.", "type": "text", "explanation": "Incorrect: Endpoints are not required for local maxima."},
          {"id": "B", "label": "B", "value": "A local maximum is the greatest value on the entire interval; an absolute maximum is greatest only nearby.", "type": "text", "explanation": "Incorrect: Definitions are reversed."},
          {"id": "C", "label": "C", "value": "A local maximum is greatest in some neighborhood; an absolute maximum is greatest on the whole domain/interval considered.", "type": "text", "explanation": "Correct: Correct distinction."},
          {"id": "D", "label": "D", "value": "Local and absolute maxima are always the same.", "type": "text", "explanation": "Incorrect: They can differ."}
        ]$txt$,
    explanation = $txt$Local concerns a neighborhood; absolute concerns the entire interval/domain being studied.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q09';


UPDATE public.questions
SET
    prompt = $txt$If $f''(x) > 0$ for all $x$ in $(a,b)$, what is true about $f$ on $(a,b)$?$txt$,
    latex = $txt$If $f''(x) > 0$ for all $x$ in $(a,b)$, what is true about $f$ on $(a,b)$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ is concave down on $(a,b)$.", "type": "text", "explanation": "Incorrect: Concave down corresponds to $f''<0$."},
          {"id": "B", "label": "B", "value": "$f$ is concave up on $(a,b)$.", "type": "text", "explanation": "Correct: Correct concavity interpretation."},
          {"id": "C", "label": "C", "value": "$f$ is decreasing on $(a,b)$.", "type": "text", "explanation": "Incorrect: Decreasing depends on $f'$, not $f''$."},
          {"id": "D", "label": "D", "value": "$f$ has a local maximum in $(a,b)$.", "type": "text", "explanation": "Incorrect: Not guaranteed by concavity alone."}
        ]$txt$,
    explanation = $txt$Positive second derivative indicates concave up.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q10';


UPDATE public.questions
SET
    prompt = $txt$Which condition is necessary for $x=c$ to be an inflection point of $f$?$txt$,
    latex = $txt$Which condition is necessary for $x=c$ to be an inflection point of $f$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f(c)=0$", "type": "text", "explanation": "Incorrect: Zeros do not determine inflection."},
          {"id": "B", "label": "B", "value": "$f'(c)=0$", "type": "text", "explanation": "Incorrect: $f'(c)=0$ is not required."},
          {"id": "C", "label": "C", "value": "The concavity of $f$ changes at $x=c$.", "type": "text", "explanation": "Correct: Correct defining condition."},
          {"id": "D", "label": "D", "value": "$f$ is increasing at $x=c$.", "type": "text", "explanation": "Incorrect: Increasing/decreasing is separate from concavity."}
        ]$txt$,
    explanation = $txt$An inflection point requires a change in concavity across $c$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q11';


UPDATE public.questions
SET
    prompt = $txt$The provided graph is $f'(x)$. On which interval is $f$ increasing?$txt$,
    latex = $txt$The provided graph is $f'(x)$. On which interval is $f$ increasing?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$(-2,-1)$ only", "type": "text", "explanation": "Incorrect: Misses the positive region to the right of 2."},
          {"id": "B", "label": "B", "value": "$(-1,2)$ only", "type": "text", "explanation": "Incorrect: On $(-1,2)$, the graph is below the x-axis (negative)."},
          {"id": "C", "label": "C", "value": "$(-2,-1)$ and $(2,4)$", "type": "text", "explanation": "Correct: both intervals where $f'(x)>0$."},
          {"id": "D", "label": "D", "value": "$(2,4)$ only", "type": "text", "explanation": "Incorrect: Misses the positive region left of -1."}
        ]$txt$,
    explanation = $txt$f increases where $f'(x)$ is positive. From the graph, $f'(x)>0$ on $(-2,-1)$ and $(2,4)$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q12';


UPDATE public.questions
SET
    prompt = $txt$At $x=2$, $f'(2)=0$ and $f''(2)<0$. What conclusion is supported by the second derivative test?$txt$,
    latex = $txt$At $x=2$, $f'(2)=0$ and $f''(2)<0$. What conclusion is supported by the second derivative test?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ has a local minimum at $x=2$.", "type": "text", "explanation": "Incorrect: A local minimum would require $f''(2)>0$."},
          {"id": "B", "label": "B", "value": "$f$ has a local maximum at $x=2$.", "type": "text", "explanation": "Correct: Correct second derivative test result."},
          {"id": "C", "label": "C", "value": "$f$ has an inflection point at $x=2$.", "type": "text", "explanation": "Incorrect: Inflection requires concavity change, not just concave down."},
          {"id": "D", "label": "D", "value": "No conclusion can be drawn even with these facts.", "type": "text", "explanation": "Incorrect: Here the test applies and gives a conclusion."}
        ]$txt$,
    explanation = $txt$If $f'(c)=0$ and $f''(c)<0$, then $f$ is concave down at $c$ and has a local maximum there.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q13';


UPDATE public.questions
SET
    prompt = $txt$At $x=c$, suppose $f'(c)=0$ and $f''(c)>0$. Which statement is most accurate?$txt$,
    latex = $txt$At $x=c$, suppose $f'(c)=0$ and $f''(c)>0$. Which statement is most accurate?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ must have an absolute minimum at $x=c$.", "type": "text", "explanation": "Incorrect: Absolute is not guaranteed from local information."},
          {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=c$.", "type": "text", "explanation": "Correct: Correct local-minimum conclusion."},
          {"id": "C", "label": "C", "value": "$f$ has a local maximum at $x=c$.", "type": "text", "explanation": "Incorrect: Would require $f''(c)<0$ for a local maximum."},
          {"id": "D", "label": "D", "value": "$f$ is decreasing at $x=c$.", "type": "text", "explanation": "Incorrect: $f'(c)=0$ means not decreasing/increasing at that instant."}
        ]$txt$,
    explanation = $txt$f'(c)=0 indicates a critical point. $f''(c)>0$ indicates concave up, supporting a local minimum at $c$ (second derivative test).$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q14';


UPDATE public.questions
SET
    prompt = $txt$If $f$ has a horizontal tangent at $x=1$ and is increasing immediately to the left of 1 and decreasing immediately to the right of 1, what must be true about $f'(x)$ near $x=1$?$txt$,
    latex = $txt$If $f$ has a horizontal tangent at $x=1$ and is increasing immediately to the left of 1 and decreasing immediately to the right of 1, what must be true about $f'(x)$ near $x=1$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f'(1)=0$ and $f'$ changes from negative to positive at $x=1$.", "type": "text", "explanation": "Incorrect: Negative to positive would indicate a local minimum."},
          {"id": "B", "label": "B", "value": "$f'(1)=0$ and $f'$ changes from positive to negative at $x=1$.", "type": "text", "explanation": "Correct: Correct sign change for a local maximum."},
          {"id": "C", "label": "C", "value": "$f'(1)$ is undefined.", "type": "text", "explanation": "Incorrect: A horizontal tangent indicates a defined derivative there."},
          {"id": "D", "label": "D", "value": "$f'(x)$ is negative on both sides of $x=1$.", "type": "text", "explanation": "Incorrect: That would mean decreasing on both sides, not increasing then decreasing."}
        ]$txt$,
    explanation = $txt$Increasing then decreasing with a horizontal tangent indicates a local maximum, so $f'$ goes from positive to negative and $f'(1)=0$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q15';


UPDATE public.questions
SET
    prompt = $txt$In an optimization problem, which is the best first step?$txt$,
    latex = $txt$In an optimization problem, which is the best first step?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "Differentiate immediately.", "type": "text", "explanation": "Incorrect: You cannot differentiate before you have an objective function."},
          {"id": "B", "label": "B", "value": "Define variables clearly and write the quantity to be optimized in terms of those variables.", "type": "text", "explanation": "Correct: Correct modeling-first approach."},
          {"id": "C", "label": "C", "value": "Plug in endpoints first.", "type": "text", "explanation": "Incorrect: Endpoints are checked later (after the function/domain are set)."},
          {"id": "D", "label": "D", "value": "Set the second derivative equal to zero.", "type": "text", "explanation": "Incorrect: That is not the standard starting step and may not apply."}
        ]$txt$,
    explanation = $txt$Optimization starts with clear variables and an objective function; calculus comes after the model is built.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q16';


UPDATE public.questions
SET
    prompt = $txt$A rectangle has perimeter $40$. Which area is the greatest possible?$txt$,
    latex = $txt$A rectangle has perimeter $40$. Which area is the greatest possible?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "50", "type": "text", "explanation": "Incorrect: Too small; not the maximum for perimeter 40."},
          {"id": "B", "label": "B", "value": "80", "type": "text", "explanation": "Incorrect: Too small; square gives larger area."},
          {"id": "C", "label": "C", "value": "100", "type": "text", "explanation": "Correct: square 10 by 10."},
          {"id": "D", "label": "D", "value": "120", "type": "text", "explanation": "Incorrect: Not possible with perimeter 40."}
        ]$txt$,
    explanation = $txt$With fixed perimeter, area is maximized by a square. Side length 10 gives area 100.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q17';


UPDATE public.questions
SET
    prompt = $txt$The provided graph is $f''(x)$. At which x-value does $f$ have an inflection point?$txt$,
    latex = $txt$The provided graph is $f''(x)$. At which x-value does $f$ have an inflection point?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$x = 1$ only", "type": "text", "explanation": "Incorrect: Misses the second sign-change crossing."},
          {"id": "B", "label": "B", "value": "$x = 1$ and $x = 4$", "type": "text", "explanation": "Correct: both zero-crossings with sign change."},
          {"id": "C", "label": "C", "value": "$x = 2$ and $x = 5$", "type": "text", "explanation": "Incorrect: Those values do not match the sign-change crossings shown."},
          {"id": "D", "label": "D", "value": "No inflection points because $f''$ is shown, not $f$.", "type": "text", "explanation": "Incorrect: $f''$ is exactly what you use to detect concavity change."}
        ]$txt$,
    explanation = $txt$Inflection points occur where concavity changes, which corresponds to $f''$ crossing 0 with a sign change. From the graph, sign changes occur at $x=1$ and $x=4$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q18';


UPDATE public.questions
SET
    prompt = $txt$For the implicit relation $x^2 + x y + y^2 = 7$, which expression correctly gives $\frac{dy}{dx}$?$txt$,
    latex = $txt$For the implicit relation $x^2 + x y + y^2 = 7$, which expression correctly gives $\frac{dy}{dx}$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Correct: Correct collection of dy/dx terms."},
          {"id": "B", "label": "B", "value": "$\\frac{dy}{dx} = -\\frac{2x + y}{2x + y}$", "type": "text", "explanation": "Incorrect: Would force dy/dx=-1 always, which is not true."},
          {"id": "C", "label": "C", "value": "$\\frac{dy}{dx} = \\frac{2x + y}{x + 2y}$", "type": "text", "explanation": "Incorrect: Sign error."},
          {"id": "D", "label": "D", "value": "$\\frac{dy}{dx} = -\\frac{2x + 1}{1 + 2y}$", "type": "text", "explanation": "Incorrect: Breaks the product differentiation structure."}
        ]$txt$,
    explanation = $txt$Implicit differentiation leads to $(x+2y)\frac{dy}{dx} = -(2x+y)$, so $\frac{dy}{dx} = -\frac{2x+y}{x+2y}$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q19';


UPDATE public.questions
SET
    prompt = $txt$For the circle $x^2 + y^2 = 9$, what is true about the tangent line at the point $(3,0)$?$txt$,
    latex = $txt$For the circle $x^2 + y^2 = 9$, what is true about the tangent line at the point $(3,0)$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "The tangent is horizontal.", "type": "text", "explanation": "Incorrect: Top/bottom points have horizontal tangents, not (3,0)."},
          {"id": "B", "label": "B", "value": "The tangent is vertical.", "type": "text", "explanation": "Correct: Rightmost point gives a vertical tangent."},
          {"id": "C", "label": "C", "value": "The tangent has slope 1.", "type": "text", "explanation": "Incorrect: Not consistent with the geometry of the circle at that point."},
          {"id": "D", "label": "D", "value": "No tangent exists because the curve is implicit.", "type": "text", "explanation": "Incorrect: Implicit curves can be smooth and have tangents."}
        ]$txt$,
    explanation = $txt$At the rightmost point of a circle, the tangent line is vertical.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q20';
