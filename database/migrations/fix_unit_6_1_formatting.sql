-- Fix Unit 6.1 Formatting Issues (P1, P4, P5)

-- U6.1-P1 (User Q2/Q1)
-- Fix "equals (()) - (initialamount)" -> "equals (final amount) - (initial amount)"
-- Format list I, II, III with double newlines for proper spacing
UPDATE public.questions
SET
    prompt = $txt$A tank’s water level changes according to a rate $r(t)$ that is sometimes positive and sometimes negative. Which statement is always true?

I. Net change over a time interval equals $(\text{final amount}) - (\text{initial amount})$.

II. Total change over a time interval ignores whether the rate is positive or negative.

III. If the net change is 0, then the total change must be 0.$txt$,
    latex = $txt$A tank’s water level changes according to a rate $r(t)$ that is sometimes positive and sometimes negative. Which statement is always true?

I. Net change over a time interval equals $(\text{final amount}) - (\text{initial amount})$.

II. Total change over a time interval ignores whether the rate is positive or negative.

III. If the net change is 0, then the total change must be 0.$txt$,
    updated_at = NOW()
WHERE title = 'U6.1-P1';

-- U6.1-P4 (User Q5)
-- Fix "equally spaced \times t (())" -> "equally spaced times t (in minutes)"
UPDATE public.questions
SET
    prompt = $txt$Refer to Table U6 6.1-P4. The table gives values of a rate $r(t)$ in meters per minute at equally spaced times $t$ (in minutes). Use the trapezoidal rule on each 1-minute subinterval to approximate the net change from $t = 0$ to $t = 5$ minutes.$txt$,
    latex = $txt$Refer to Table U6 6.1-P4. The table gives values of a rate $r(t)$ in meters per minute at equally spaced times $t$ (in minutes). Use the trapezoidal rule on each 1-minute subinterval to approximate the net change from $t = 0$ to $t = 5$ minutes.$txt$,
    updated_at = NOW()
WHERE title = 'U6.1-P4';

-- U6.1-P5 (User Q3/Q4)
-- Fix italicized "(meaning ...)" -> plain text "(meaning ...)"
-- Move options from Prompt to Options field
UPDATE public.questions
SET
    prompt = $txt$Over a time interval, the signed area above the $t$-axis under a rate graph is 10 units and the signed area below the $t$-axis is 4 units (meaning 4 units of negative area). Which is correct?$txt$,
    latex = $txt$Over a time interval, the signed area above the $t$-axis under a rate graph is 10 units and the signed area below the $t$-axis is 4 units (meaning 4 units of negative area). Which is correct?$txt$,
    options = $txt$[
      {"id": "A", "label": "A", "value": "Net change is 6 units, total change is 14 units.", "type": "text", "explanation": "Correct: net subtracts, total adds magnitudes."},
      {"id": "B", "label": "B", "value": "Net change is 14 units, total change is 6 units.", "type": "text", "explanation": "Swaps net and total ideas."},
      {"id": "C", "label": "C", "value": "Net change is 10 units, total change is 4 units.", "type": "text", "explanation": "Treats the two regions as separate outputs rather than combining them appropriately."},
      {"id": "D", "label": "D", "value": "Net change is 0 units, total change is 14 units.", "type": "text", "explanation": "Net would be 0 only if the positive and negative magnitudes matched."}
    ]$txt$,
    updated_at = NOW()
WHERE title = 'U6.1-P5';
