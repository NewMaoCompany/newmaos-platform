-- Fix for Unit 5.9 Notation Issues (Plain f -> LaTeX $f$)

-- U5.9-P1
-- "Refer to the provided graph of f" -> "$f$"
-- "f'(1)>0" -> "$f'(1)>0$" is already latex, but checking context.
-- Checking Explanation: "slopes increasing), so f'(1)>0" -> "$f'(1)>0$"
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f$ for U5.9-P1 (marked at $x=1$). At $x=1$, which combination of signs is most consistent with the graph?$txt$,
    latex = $txt$Refer to the provided graph of $f$ for U5.9-P1 (marked at $x=1$). At $x=1$, which combination of signs is most consistent with the graph?$txt$,
    explanation = $txt$At $x=1$ the graph is rising (positive slope) and bending upward (slopes increasing), so $f'(1)>0$ and $f''(1)>0$.$txt$,
    updated_at = NOW()
WHERE title = 'U5.9-P1';

-- U5.9-P2
-- "Refer to the provided graph of f'" -> "$f'$"
-- "How many local extrema does f have" -> "$f$"
-- Options: "sign change in f'" -> "$f'$", "zeros in f'" -> "$f'$", "extrema of f" -> "$f$"
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f'$ for U5.9-P2. How many local extrema does $f$ have on $(-3,4)$?$txt$,
    latex = $txt$Refer to the provided graph of $f'$ for U5.9-P2. How many local extrema does $f$ have on $(-3,4)$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "Incorrect: there is more than one sign change in $f'$."},
      {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Incorrect: there are three sign changes in $f'$."},
      {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "Correct: three sign-change zeros in $f'$ imply three local extrema of $f$."},
      {"id": "D", "label": "D", "value": "4", "type": "text", "explanation": "Incorrect: the graph shows three, not four, sign-change crossings."}
    ]$txt$,
    explanation = $txt$Local extrema of $f$ occur where $f'$ changes sign. From the graph, $f'$ crosses the x-axis with sign change three times, so $f$ has 3 local extrema on $(-3,4)$.$txt$,
    updated_at = NOW()
WHERE title = 'U5.9-P2';

-- U5.9-P3
-- "Refer to the provided graph of f''" -> "$f''$"
-- "How many inflection points does f have" -> "$f$"
-- Options: "sign change in f''" -> "$f''$"
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided graph of $f''$ for U5.9-P3. How many inflection points does $f$ have on $(-4,4)$?$txt$,
    latex = $txt$Refer to the provided graph of $f''$ for U5.9-P3. How many inflection points does $f$ have on $(-4,4)$?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "1", "type": "text", "explanation": "Incorrect: there is more than one sign change in $f''$."},
      {"id": "B", "label": "B", "value": "2", "type": "text", "explanation": "Incorrect: there are three sign changes in $f''$."},
      {"id": "C", "label": "C", "value": "3", "type": "text", "explanation": "Correct: three sign-change zeros in $f''$ give three inflection points."},
      {"id": "D", "label": "D", "value": "4", "type": "text", "explanation": "Incorrect: the graph shows three sign-change crossings, not four."}
    ]$txt$,
    explanation = $txt$Inflection points occur where concavity changes, i.e., where $f''$ changes sign. The graph of $f''$ crosses the x-axis with sign change three times, so $f$ has 3 inflection points on $(-4,4)$.$txt$,
    updated_at = NOW()
WHERE title = 'U5.9-P3';

-- U5.9-P4
-- Options: "f has a local...", "f'' changes sign", "f is increasing", "f'(x)<0", "f is decreasing" -> LaTeX
-- Note: Prompt is "Refer to... sign chart..." which is fine, but checking relevant text fields.
UPDATE public.questions
SET
    options = $txt$[
      {"id": "A", "label": "A", "value": "$f$ has a local maximum at $x=-1$.", "type": "text", "explanation": "Incorrect: $f'$ does not change sign at $x=-1$ in the chart, so no local extremum there."},
      {"id": "B", "label": "B", "value": "$f$ has a local minimum at $x=2$.", "type": "text", "explanation": "Incorrect: at $x=2$, $f'$ changes from + to -, indicating a local maximum, not a minimum."},
      {"id": "C", "label": "C", "value": "$f$ has an inflection point at $x=2$.", "type": "text", "explanation": "Correct: $f''$ changes sign at $x=2$, so $f$ has an inflection point at $x=2$."},
      {"id": "D", "label": "D", "value": "$f$ is increasing on $(2,4)$.", "type": "text", "explanation": "Incorrect: on $(2,4)$ the chart shows $f'(x)<0$, so $f$ is decreasing there."}
    ]$txt$,
    explanation = $txt$From the sign chart: $f''$ changes sign at $x=2$, so concavity changes there, giving an inflection point at $x=2$. Also $f'$ stays positive across $x=-1$ and changes from positive to negative at $x=2$, so $x=2$ is a local maximum, not a local minimum.$txt$,
    updated_at = NOW()
WHERE title = 'U5.9-P4';

-- U5.9-P5
-- Prompt: "interval where f is concave down" -> "$f$"
-- Options: "f' is increasing", "f' is decreasing", "f is increasing", "f has a local..." -> LaTeX
UPDATE public.questions
SET
    prompt = $txt$Which statement is always true on an interval where $f$ is concave down?$txt$,
    latex = $txt$Which statement is always true on an interval where $f$ is concave down?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$f'$ is increasing on the interval.", "type": "text", "explanation": "Incorrect: increasing $f'$ corresponds to concave up, not concave down."},
      {"id": "B", "label": "B", "value": "$f'$ is decreasing on the interval.", "type": "text", "explanation": "Correct: concave down implies decreasing slopes, so $f'$ decreases."},
      {"id": "C", "label": "C", "value": "$f$ is increasing on the interval.", "type": "text", "explanation": "Incorrect: concavity does not determine whether $f$ is increasing or decreasing."},
      {"id": "D", "label": "D", "value": "$f$ has a local maximum somewhere in the interval.", "type": "text", "explanation": "Incorrect: concavity alone does not guarantee a local maximum exists."}
    ]$txt$,
    explanation = $txt$Concave down means slopes are decreasing as $x$ increases, so $f'$ is decreasing on that interval.$txt$,
    updated_at = NOW()
WHERE title = 'U5.9-P5';
