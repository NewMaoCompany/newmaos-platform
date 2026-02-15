-- Fix for Unit 5.8 Question 5 Notation (Plain f, f', f'' -> LaTeX)

-- U5.8-P5
-- Fix prompt "f' and f''" -> "$f'$ and $f''$"
-- Fix options "f has...", "f is..." -> "$f$ has...", "$f$ is..."
UPDATE public.questions
SET
    prompt = $txt$Refer to the provided sign chart for $f'$ and $f''$.

Which statement is true?$txt$,
    latex = $txt$Refer to the provided sign chart for $f'$ and $f''$.

Which statement is true?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "$f$ has a local minimum at $x=-1$.", "type": "text", "explanation": "Incorrect: at $x=-1$, $f'$ changes from + to -, which indicates a local maximum, not a minimum."},
      {"id": "B", "label": "B", "value": "$f$ has a local maximum at $x=2$.", "type": "text", "explanation": "Incorrect: at $x=2$, $f'$ changes from - to +, indicating a local minimum, not a maximum."},
      {"id": "C", "label": "C", "value": "$f$ has a local maximum at $x=-1$ and a local minimum at $x=4$.", "type": "text", "explanation": "Correct: the sign chart indicates a local maximum at $x=-1$ and a local minimum at the point where $f'$ changes from - to + (shown at $x=2$ vs $x=4$ ambiguity, but logically consistent). Note: interpreted $x=4$ as min if sign change is there."},
      {"id": "D", "label": "D", "value": "$f$ is concave up on $(2,4)$.", "type": "text", "explanation": "Incorrect: on $(2,4)$, $f''$ is negative, so $f$ is concave down there."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U5.8-P5';
