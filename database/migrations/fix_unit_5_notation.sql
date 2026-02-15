-- Batch fix for Unit 5 Function Notation (Plain f -> $f$)

-- Standardize notation for U5.4-P2
UPDATE public.questions
SET
    prompt = $txt$Let $f(x)=x^3-3x^2+2$. Which statement about local extrema is correct?$txt$,
    latex = $txt$Let $f(x)=x^3-3x^2+2$. Which statement about local extrema is correct?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "Local max at $x=0$ and local min at $x=2$.", "type": "text", "explanation": "Correct: $f'$ changes + to - at $0$ (max) and - to + at $2$ (min)."},
          {"id": "B", "label": "B", "value": "Local min at $x=0$ and local max at $x=2$.", "type": "text", "explanation": "Incorrect: it reverses the sign-change conclusions."},
          {"id": "C", "label": "C", "value": "Local maxima at both $x=0$ and $x=2$.", "type": "text", "explanation": "Incorrect: a max needs + to -; at $x=2$ it is - to + (min)."},
          {"id": "D", "label": "D", "value": "No local extrema occur.", "type": "text", "explanation": "Incorrect: sign changes at both critical points indicate local extrema."}
        ]$txt$,
    explanation = $txt$$f\'$(x)=3x^2-6x=3x(x-2). The sign of $f'$ is positive on $(-\\infty,0)$, negative on $(0,2)$, and positive on $(2,\\infty)$. So $f$ has a local maximum at $x=0$ and a local minimum at $x=2$.$txt$,
    updated_at = NOW()
WHERE title = 'U5.4-P2';


-- Standardize notation for U5.6-P1
UPDATE public.questions
SET
    prompt = $txt$A twice-differentiable function $f$ satisfies $f''(x)>0$ on $(1,4)$. Which statement is true on $(1,4)$?$txt$,
    latex = $txt$A twice-differentiable function $f$ satisfies $f''(x)>0$ on $(1,4)$. Which statement is true on $(1,4)$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$f$ is increasing.", "type": "text", "explanation": "Incorrect: concavity does not determine whether $f$ is increasing."},
          {"id": "B", "label": "B", "value": "$f$ is decreasing.", "type": "text", "explanation": "Incorrect: concavity does not determine whether $f$ is decreasing."},
          {"id": "C", "label": "C", "value": "$f$ is concave up.", "type": "text", "explanation": "Correct: $f''(x)>0$ implies concave up."},
          {"id": "D", "label": "D", "value": "$f$ has a local maximum.", "type": "text", "explanation": "Incorrect: concavity alone does not guarantee a local maximum."}
        ]$txt$,
    explanation = $txt$$f\'\'$(x)>0 means the graph of $f$ is concave up (the slope $f'$ is increasing). It does not by itself force $f$ to be increasing or decreasing.$txt$,
    updated_at = NOW()
WHERE title = 'U5.6-P1';


-- Standardize notation for U5.7-P2
UPDATE public.questions
SET
    prompt = $txt$Let $f(x)=x^4-4x^2$. Which statement is correct about the critical point $x=0$?$txt$,
    latex = $txt$Let $f(x)=x^4-4x^2$. Which statement is correct about the critical point $x=0$?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$x=0$ is a local maximum of $f$.", "type": "text", "explanation": "Correct: $f''(0)<0$ implies a local maximum at $x=0$."},
          {"id": "B", "label": "B", "value": "$x=0$ is a local minimum of $f$.", "type": "text", "explanation": "Incorrect: a local minimum would require $f''(0)>0$."},
          {"id": "C", "label": "C", "value": "The second derivative test is inconclusive at $x=0$.", "type": "text", "explanation": "Incorrect: inconclusive happens when $f''(0)=0$ or does not exist."},
          {"id": "D", "label": "D", "value": "$x=0$ is not a critical point of $f$.", "type": "text", "explanation": "Incorrect: $f'(0)=0$, so it is a critical point."}
        ]$txt$,
    explanation = $txt$$f\'$(x)=4x^3-8x=4x(x^2-2), so $x=0$ is a critical point. $f''(x)=12x^2-8$, so $f''(0)=-8<0$. Therefore $x=0$ is a local maximum by the second derivative test.$txt$,
    updated_at = NOW()
WHERE title = 'U5.7-P2';


-- Standardize notation for U5.8-P1
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f$.

On which interval is $f$ increasing?$txt$,
    latex = $txt$Refer to the provided graph of $f$.

On which interval is $f$ increasing?$txt$,
    options = $txt$[
          {"id": "A", "label": "A", "value": "$(-2,0)$", "type": "text", "explanation": "Incorrect: the graph is falling on $(-2,0)$."},
          {"id": "B", "label": "B", "value": "$(0,2)$", "type": "text", "explanation": "Correct: the graph rises on $(0,2)$."},
          {"id": "C", "label": "C", "value": "$(2,4)$", "type": "text", "explanation": "Incorrect: the graph falls on $(2,4)$."},
          {"id": "D", "label": "D", "value": "$f$ is increasing on all of $(-2,4)$", "type": "text", "explanation": "Incorrect: the graph changes direction, so it is not increasing everywhere."}
        ]$txt$,
    explanation = $txt$$f$ is increasing where the graph of $f$ rises as $x$ increases (positive slope). From the graph, $f$ rises between $x=0$ and $x=2$, while it decreases on the other listed intervals.$txt$,
    updated_at = NOW()
WHERE title = 'U5.8-P1';


-- Standardize notation for U5-UT-Q12
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
    explanation = $txt$$f$ increases where $f'(x)$ is positive. From the graph, $f'(x)>0$ on $(-2,-1)$ and $(2,4)$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q12';


-- Standardize notation for U5-UT-Q14
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
    explanation = $txt$$f\'$(c)=0 indicates a critical point. $f''(c)>0$ indicates concave up, supporting a local minimum at $c$ (second derivative test).$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q14';


-- Standardize notation for U5-UT-Q12
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
    explanation = $txt$$f$ increases where $f'(x)$ is positive. From the graph, $f'(x)>0$ on $(-2,-1)$ and $(2,4)$.$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q12';


-- Standardize notation for U5-UT-Q14
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
    explanation = $txt$$f\'$(c)=0 indicates a critical point. $f''(c)>0$ indicates concave up, supporting a local minimum at $c$ (second derivative test).$txt$,
    updated_at = NOW()
WHERE title = 'U5-UT-Q14';
