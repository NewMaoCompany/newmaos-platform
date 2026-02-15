-- Fix for U4.3-P1: Corrupted prompt text and option formatting
-- Issue 1: Prompt "cost (in dollars)" corrupted to "cost (()".
-- Issue 2: Option values like "\$3.20" rendering with red backslash.

UPDATE public.questions
SET
    prompt = $txt$Let $C(t)$ be the cost (in dollars) to produce $t$ items. If $C'(50)=3.2$, what is the best interpretation?$txt$,
    latex = $txt$Let $C(t)$ be the cost (in dollars) to produce $t$ items. If $C'(50)=3.2$, what is the best interpretation?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "The cost to produce 50 items is $3.20.", "type": "text", "explanation": "This confuses a derivative with the function value."},
      {"id": "B", "label": "B", "value": "At 50 items, the cost is increasing at about $3.20 per additional item.", "type": "text", "explanation": "Correct: marginal cost at 50 items is about $3.20 per item."},
      {"id": "C", "label": "C", "value": "The average cost per item for the first 50 items is $3.20.", "type": "text", "explanation": "That describes average cost, not the derivative at 50."},
      {"id": "D", "label": "D", "value": "Producing one more item decreases cost by $3.20.", "type": "text", "explanation": "A positive derivative means cost is increasing, not decreasing."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U4.3-P1';
