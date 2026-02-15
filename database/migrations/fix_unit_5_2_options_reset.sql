-- Fix for Unit 5.2 Options (Empty Options Issue)
-- Re-inserting options for U5.2-P1 to U5.2-P5 to ensure valid JSON

-- U5.2-P1
UPDATE public.questions
SET options = $txt$[
  {"id": "A", "label": "A", "value": "Mean Value Theorem", "type": "text", "explanation": "Incorrect: MVT guarantees a point where derivative matches average slope."},
  {"id": "B", "label": "B", "value": "Extreme Value Theorem", "type": "text", "explanation": "Correct: EVT guarantees existence of absolute extrema on a closed interval."},
  {"id": "C", "label": "C", "value": "Intermediate Value Theorem", "type": "text", "explanation": "Incorrect: IVT guarantees intermediate values, not extrema."},
  {"id": "D", "label": "D", "value": "Rolle’s Theorem", "type": "text", "explanation": "Incorrect: Rolle’s Theorem is a special case of MVT with equal endpoints."}
]$txt$,
updated_at = NOW()
WHERE title = 'U5.2-P1';

-- U5.2-P2
UPDATE public.questions
SET options = $txt$[
  {"id": "A", "label": "A", "value": "$f$ attains an absolute maximum on $(0,4)$.", "type": "text", "explanation": "Incorrect: a maximum may fail to occur if it would be at an endpoint not included."},
  {"id": "B", "label": "B", "value": "$f$ attains an absolute minimum on $(0,4)$.", "type": "text", "explanation": "Incorrect: same issue as for a maximum on an open interval."},
  {"id": "C", "label": "C", "value": "$f$ attains both an absolute maximum and absolute minimum on $(0,4)$.", "type": "text", "explanation": "Incorrect: EVT’s conclusion needs the closed-interval hypothesis."},
  {"id": "D", "label": "D", "value": "No absolute extrema are guaranteed by EVT from this information alone.", "type": "text", "explanation": "Correct: EVT cannot be applied without a closed interval."}
]$txt$,
updated_at = NOW()
WHERE title = 'U5.2-P2';

-- U5.2-P3
UPDATE public.questions
SET options = $txt$[
  {"id": "A", "label": "A", "value": "$x=-2$ only", "type": "text", "explanation": "Incorrect: $f(-2)=-2$ is not the maximum."},
  {"id": "B", "label": "B", "value": "$x=2$ only", "type": "text", "explanation": "Incorrect: $x=2$ is a max point, but not the only one."},
  {"id": "C", "label": "C", "value": "$x=-1$ only", "type": "text", "explanation": "Incorrect: $x=-1$ is a max point, but not the only one."},
  {"id": "D", "label": "D", "value": "$x=-1$ and $x=2$", "type": "text", "explanation": "Correct: both $x=-1$ and $x=2$ give the maximum value."}
]$txt$,
updated_at = NOW()
WHERE title = 'U5.2-P3';

-- U5.2-P4
UPDATE public.questions
SET options = $txt$[
  {"id": "A", "label": "A", "value": "Point A", "type": "text", "explanation": "Incorrect: A is an endpoint but not the lowest value shown."},
  {"id": "B", "label": "B", "value": "Point B", "type": "text", "explanation": "Incorrect: B is near a local high, not a minimum."},
  {"id": "C", "label": "C", "value": "Point C", "type": "text", "explanation": "Correct: C is the lowest point (absolute minimum) on $[0,4]$."},
  {"id": "D", "label": "D", "value": "Point D", "type": "text", "explanation": "Incorrect: D is an endpoint but higher than C."}
]$txt$,
updated_at = NOW()
WHERE title = 'U5.2-P4';

-- U5.2-P5
UPDATE public.questions
SET options = $txt$[
  {"id": "A", "label": "A", "value": "4", "type": "text", "explanation": "Incorrect: 4 is not the largest value shown."},
  {"id": "B", "label": "B", "value": "5", "type": "text", "explanation": "Correct: 5 is the largest candidate value."},
  {"id": "C", "label": "C", "value": "2", "type": "text", "explanation": "Incorrect: 2 is smaller than 5."},
  {"id": "D", "label": "D", "value": "1", "type": "text", "explanation": "Incorrect: 1 is smaller than 5."}
]$txt$,
updated_at = NOW()
WHERE title = 'U5.2-P5';
