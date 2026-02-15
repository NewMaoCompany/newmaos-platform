-- Restore Unit 1.3 and 1.4 Questions
BEGIN;

DELETE FROM questions WHERE title = 'C3Q1_LeftHandLimitAt2';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C3Q1_LeftHandLimitAt2', 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 2^-} f(x)$.', 'image', 'MCQ', 'Level2', 2, 'AP_Calculus_BC', 'Both_Limits', 'U1_C3_Q1', '1.3', 'SK_READ_LIMIT_FROM_GRAPH', '{SK_ONE_SIDED_LIMIT}', '{SK_READ_LIMIT_FROM_GRAPH,SK_ONE_SIDED_LIMIT}', '{ERR_MISREAD_OPEN_CLOSED_DOT,ERR_CONFUSE_LIMIT_WITH_VALUE,ERR_IGNORE_ONE_SIDED}', '[{"id": "A", "explanation": "Approaching $x=2$ from the left follows the left linear branch, which approaches $y=3$ at the open circle.", "value": "$3$", "label": "A"}, {"id": "B", "explanation": "$4$ is the function value shown by the filled point at $x=2$, not the left-hand limit.", "value": "$4$", "label": "B"}, {"id": "C", "explanation": "A one-sided limit can exist even if the two-sided limit fails; from the left the values approach a single number.", "value": "The limit does not exist", "label": "C"}, {"id": "D", "explanation": "$2$ confuses the $x$-value being approached with the $y$-value of the limit.", "value": "$2$", "label": "D"}]'::jsonb, 'A', 'As $x\to 2^-$, the graph follows the left branch. The $y$-values approach $3$ (the open circle at $(2,3)$). Therefore, $\lim_{x\to 2^-} f(x)=3$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C3Q2_TwoSidedLimitJumpAt1';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C3Q2_TwoSidedLimitJumpAt1', 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 1} f(x)$.', 'image', 'MCQ', 'Level3', 3, 'AP_Calculus_BC', 'Both_Limits', 'U1_C3_Q2', '1.3', 'SK_READ_LIMIT_FROM_GRAPH', '{SK_LIMIT_DNE_FROM_GRAPH}', '{SK_READ_LIMIT_FROM_GRAPH,SK_LIMIT_DNE_FROM_GRAPH}', '{ERR_ASSUME_TWO_SIDED_EXISTS,ERR_CONFUSE_LIMIT_WITH_VALUE,ERR_MISREAD_OPEN_CLOSED_DOT}', '[{"id": "A", "explanation": "$1$ matches the right-hand approach (and the filled point), but the left-hand approach is different.", "value": "$1$", "label": "A"}, {"id": "B", "explanation": "$3$ matches the left-hand approach (open circle), but the right-hand approach is different.", "value": "$3$", "label": "B"}, {"id": "C", "explanation": "Left-hand and right-hand limits are different ($3$ from the left and $1$ from the right), so the two-sided limit does not exist.", "value": "The limit does not exist", "label": "C"}, {"id": "D", "explanation": "$2$ is not approached from either side; it results from averaging or guessing.", "value": "$2$", "label": "D"}]'::jsonb, 'C', 'From the left, $f(x)$ approaches $3$ (open circle at $(1,3)$). From the right, $f(x)$ approaches $1$ (horizontal segment). Since $\lim_{x\to 1^-} f(x)\neq \lim_{x\to 1^+} f(x)$, $\lim_{x\to 1} f(x)$ does not exist.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C3Q3_InfiniteLimitAt0Plus';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C3Q3_InfiniteLimitAt0Plus', 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 0^+} f(x)$.', 'image', 'MCQ', 'Level4', 3, 'AP_Calculus_BC', 'Both_Limits', 'U1_C3_Q3', '1.3', 'SK_INFINITE_LIMIT_FROM_GRAPH', '{SK_ONE_SIDED_LIMIT}', '{SK_INFINITE_LIMIT_FROM_GRAPH,SK_ONE_SIDED_LIMIT}', '{ERR_SIGN_ERROR_INFINITY,ERR_IGNORE_ONE_SIDED,ERR_ASSUME_ASYMPTOTE_MEANS_DNE_ALWAYS}', '[{"id": "A", "explanation": "The branch shown for $x>0$ rises upward as $x\\to 0^+$, not downward.", "value": "$-\\infty$", "label": "A"}, {"id": "B", "explanation": "As $x\\to 0^+$, the graph increases without bound, so the one-sided limit is $\\infty$.", "value": "$\\infty$", "label": "B"}, {"id": "C", "explanation": "The $x$-axis is not being approached; the $y$-values grow large.", "value": "$0$", "label": "C"}, {"id": "D", "explanation": "An infinite limit is a valid limit description; here the behavior is unbounded in a single direction.", "value": "The limit does not exist", "label": "D"}]'::jsonb, 'B', 'Near $x=0$ on the right, the graph shoots upward without bound. Therefore, $\lim_{x\to 0^+} f(x)=\infty$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C3Q4_RemovableDiscontinuityAtMinus1';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C3Q4_RemovableDiscontinuityAtMinus1', 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to -1} f(x)$.', 'image', 'MCQ', 'Level2', 2, 'AP_Calculus_BC', 'Both_Limits', 'U1_C3_Q4', '1.3', 'SK_READ_LIMIT_FROM_GRAPH', '{SK_LIMIT_EXISTS_GRAPHICALLY}', '{SK_READ_LIMIT_FROM_GRAPH,SK_LIMIT_EXISTS_GRAPHICALLY}', '{ERR_CONFUSE_HOLE_WITH_DNE,ERR_CONFUSE_LIMIT_WITH_VALUE,ERR_MISREAD_OPEN_CLOSED_DOT}', '[{"id": "A", "explanation": "A hole does not prevent a limit from existing; the surrounding values can still approach one number.", "value": "The limit does not exist", "label": "A"}, {"id": "B", "explanation": "$-1$ is the $x$-value being approached, not the $y$-value of the limit.", "value": "$-1$", "label": "B"}, {"id": "C", "explanation": "Near $x=-1$, the graph lies on the horizontal line $y=1$ with a hole at $(-1,1)$, so the limit is $1$.", "value": "$1$", "label": "C"}, {"id": "D", "explanation": "The graph is not approaching $y=0$ near $x=-1$.", "value": "$0$", "label": "D"}]'::jsonb, 'C', 'Approaching $x=-1$ from either side, the graph stays at $y=1$. Even though there is a hole at $(-1,1)$, the approaching value is $1$, so $\lim_{x\to -1} f(x)=1$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C3Q5_RightHandLimitAt0';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C3Q5_RightHandLimitAt0', 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 0^+} f(x)$.', 'image', 'MCQ', 'Level1', 1, 'AP_Calculus_BC', 'Both_Limits', 'U1_C3_Q5', '1.3', 'SK_ONE_SIDED_LIMIT', '{SK_READ_LIMIT_FROM_GRAPH}', '{SK_ONE_SIDED_LIMIT,SK_READ_LIMIT_FROM_GRAPH}', '{ERR_ASSUME_TWO_SIDED_REQUIRED,ERR_IGNORE_DOMAIN_ENDPOINT,ERR_IGNORE_ONE_SIDED}', '[{"id": "A", "explanation": "At $x=0$, the graph begins at $y=0$, not $1$.", "value": "$1$", "label": "A"}, {"id": "B", "explanation": "As $x\\to 0^+$ along the curve, $y\\to 0$.", "value": "$0$", "label": "B"}, {"id": "C", "explanation": "A right-hand limit can exist even if there is no left side shown.", "value": "The limit does not exist", "label": "C"}, {"id": "D", "explanation": "The curve does not blow up near $x=0$; it approaches $0$.", "value": "$\\infty$", "label": "D"}]'::jsonb, 'B', 'The graph is defined for $x\ge 0$ and approaches the point $(0,0)$ from the right. Therefore, $\lim_{x\to 0^+} f(x)=0$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C4Q1_TableLimitApproaches6';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C4Q1_TableLimitApproaches6', 'A function $f$ is defined near $x=3$. Use the table to estimate $\displaystyle \lim_{x\to 3} f(x)$.

$$
\begin{array}{c|cccccc}
x & 2.9 & 2.99 & 2.999 & 3.001 & 3.01 & 3.1\\ \hline
f(x) & 5.7 & 5.97 & 5.997 & 6.003 & 6.03 & 6.3
\end{array}
$$', 'text', 'MCQ', 'Level2', 2, 'AP_Calculus_BC', 'Both_Limits', 'U1_C4_Q1', '1.4', 'SK_ESTIMATE_LIMIT_FROM_TABLE', '{}', '{SK_ESTIMATE_LIMIT_FROM_TABLE}', '{ERR_USE_NEAREST_VALUE_ONLY,ERR_CONFUSE_LIMIT_WITH_VALUE,ERR_IGNORE_BOTH_SIDES_TABLE}', '[{"id": "A", "explanation": "This is just one value from the left side; the limit should reflect values from both sides approaching the same number.", "value": "$5.997$", "label": "A"}, {"id": "B", "explanation": "Values approach $6$ from both sides: $5.997$ (left) and $6.003$ (right) get closer to $6$ as $x$ nears $3$.", "value": "$6$", "label": "B"}, {"id": "C", "explanation": "This is just one value from the right side; it is not the best estimate of the limiting value.", "value": "$6.003$", "label": "C"}, {"id": "D", "explanation": "Both sides trend toward the same value, so the limit exists.", "value": "The limit does not exist", "label": "D"}]'::jsonb, 'B', 'As $x$ approaches $3$ from the left, $f(x)$ moves from $5.97$ to $5.997$. From the right, it moves from $6.03$ to $6.003$. These values cluster around $6$, so $\lim_{x\to 3} f(x)\approx 6$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C4Q2_TableTwoSidedLimitDNE';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C4Q2_TableTwoSidedLimitDNE', 'Use the table to determine $\displaystyle \lim_{x\to 2} f(x)$.

$$
\begin{array}{c|cccccc}
x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\ \hline
f(x) & -1.1 & -1.01 & -1.001 & 3.001 & 3.01 & 3.1
\end{array}
$$', 'text', 'MCQ', 'Level3', 3, 'AP_Calculus_BC', 'Both_Limits', 'U1_C4_Q2', '1.4', 'SK_ESTIMATE_LIMIT_FROM_TABLE', '{SK_LIMIT_DNE_FROM_TABLE}', '{SK_ESTIMATE_LIMIT_FROM_TABLE,SK_LIMIT_DNE_FROM_TABLE}', '{ERR_IGNORE_BOTH_SIDES_TABLE,ERR_AVERAGE_TWO_SIDES,ERR_ASSUME_TWO_SIDED_EXISTS}', '[{"id": "A", "explanation": "This is an average of the one-sided behaviors, but limits are not found by averaging.", "value": "$1$", "label": "A"}, {"id": "B", "explanation": "This matches the left-hand trend, but the right-hand trend approaches a different value.", "value": "$-1$", "label": "B"}, {"id": "C", "explanation": "This matches the right-hand trend, but the left-hand trend approaches a different value.", "value": "$3$", "label": "C"}, {"id": "D", "explanation": "Left-hand values approach $-1$ while right-hand values approach $3$, so the two-sided limit does not exist.", "value": "The limit does not exist", "label": "D"}]'::jsonb, 'D', 'From the left of $2$, $f(x)$ approaches $-1$ (e.g., $-1.001$). From the right of $2$, $f(x)$ approaches $3$ (e.g., $3.001$). Since the one-sided limits are unequal, $\lim_{x\to 2} f(x)$ does not exist.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C4Q3_TableInfiniteLimit';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C4Q3_TableInfiniteLimit', 'Use the table to evaluate the limit.

$$
\begin{array}{c|cccccc}
x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\ \hline
f(x) & 10 & 100 & 1000 & 1000 & 100 & 10
\end{array}
$$

Find $\displaystyle \lim_{x\to 0} f(x)$.', 'text', 'MCQ', 'Level4', 3, 'AP_Calculus_BC', 'Both_Limits', 'U1_C4_Q3', '1.4', 'SK_INFINITE_LIMIT_FROM_TABLE', '{SK_LIMIT_NOTATION_INFINITE}', '{SK_INFINITE_LIMIT_FROM_TABLE,SK_LIMIT_NOTATION_INFINITE}', '{ERR_WRITE_DNE_INSTEAD_OF_INFINITY,ERR_SIGN_ERROR_INFINITY,ERR_ASSUME_ALWAYS_FINITE}', '[{"id": "A", "explanation": "The values grow larger as $x$ gets closer to $0$, not smaller.", "value": "$0$", "label": "A"}, {"id": "B", "explanation": "All listed function values are positive and increasing in magnitude near $0$, so the trend is not toward $-\\infty$.", "value": "$-\\infty$", "label": "B"}, {"id": "C", "explanation": "As $x$ approaches $0$ from both sides, $f(x)$ increases without bound, indicating an infinite limit of $\\infty$.", "value": "$\\infty$", "label": "C"}, {"id": "D", "explanation": "Here the function grows without bound in the same direction on both sides, so describing the limit as $\\infty$ is appropriate.", "value": "The limit does not exist", "label": "D"}]'::jsonb, 'C', 'When $x$ is closer to $0$ (e.g., $\pm 0.001$), $f(x)$ is much larger (1000) than when $x$ is farther (e.g., $\pm 0.1$ gives 10). The values increase without bound as $x\to 0$, so $\lim_{x\to 0} f(x)=\infty$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C4Q4_DifferenceQuotientFromTable';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C4Q4_DifferenceQuotientFromTable', 'A function $f$ is defined near $x=2$. Use the table to estimate
$$\displaystyle \lim_{x\to 2}\frac{f(x)-f(2)}{x-2}.$$

$$
\begin{array}{c|cccccc}
x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\ \hline
f(x) & 4.61 & 4.9601 & 4.996001 & 5.004001 & 5.0401 & 5.41
\end{array}
$$

Assume $f(2)=5$.', 'text', 'MCQ', 'Level3', 3, 'AP_Calculus_BC', 'Both_Limits', 'U1_C4_Q4', '1.4', 'SK_ESTIMATE_LIMIT_FROM_TABLE', '{SK_AVERAGE_RATE_LIMIT}', '{SK_ESTIMATE_LIMIT_FROM_TABLE,SK_AVERAGE_RATE_LIMIT}', '{ERR_SUBSTITUTE_POINT_VALUE,ERR_MIX_UP_DIFFERENCE_QUOTIENT,ERR_USE_NEAREST_VALUE_ONLY}', '[{"id": "A", "explanation": "The quotient is not near $0$; the changes in $f(x)$ relative to changes in $x$ suggest a slope near $4$.", "value": "$0$", "label": "A"}, {"id": "B", "explanation": "Using nearby values: for $x=2.001$, $(5.004001-5)/0.001\\approx 4.001$; for $x=1.999$, $(4.996001-5)/(-0.001)\\approx 3.999$.", "value": "$4$", "label": "B"}, {"id": "C", "explanation": "$5$ is $f(2)$, but the expression is about the rate of change (slope), not the function value.", "value": "$5$", "label": "C"}, {"id": "D", "explanation": "Left and right quotients both approach about $4$, indicating the limit exists.", "value": "The limit does not exist", "label": "D"}]'::jsonb, 'B', 'Compute the difference quotient near $2$. From the right: $(5.004001-5)/0.001\approx 4.001$. From the left: $(4.996001-5)/(-0.001)\approx 3.999$. Both sides approach $4$, so the limit is approximately $4$.', 0, 'published', 1);

DELETE FROM questions WHERE title = 'C4Q5_TableOscillationDNE';
INSERT INTO questions (title, prompt, prompt_type, type, difficulty, reasoning_level, course, topic, sub_topic_id, section_id, primary_skill_id, supporting_skill_ids, skill_tags, error_tags, options, correct_option_id, explanation, tolerance, status, version) VALUES ('C4Q5_TableOscillationDNE', 'Use the table to determine $\displaystyle \lim_{x\to 0} f(x)$.

$$
\begin{array}{c|cccccc}
x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\ \hline
f(x) & 1 & -1 & 1 & -1 & 1 & -1
\end{array}
$$', 'text', 'MCQ', 'Level5', 4, 'AP_Calculus_BC', 'Both_Limits', 'U1_C4_Q5', '1.4', 'SK_LIMIT_DNE_FROM_TABLE', '{SK_ESTIMATE_LIMIT_FROM_TABLE}', '{SK_LIMIT_DNE_FROM_TABLE,SK_ESTIMATE_LIMIT_FROM_TABLE}', '{ERR_USE_NEAREST_VALUE_ONLY,ERR_ASSUME_PATTERN_CONTINUES_TO_LIMIT,ERR_IGNORE_OSCILLATION}', '[{"id": "A", "explanation": "Averaging the two values is not justified; the function values do not trend toward $0$.", "value": "$0$", "label": "A"}, {"id": "B", "explanation": "Values near $0$ are sometimes $1$ and sometimes $-1$; there is no single value approached.", "value": "$1$", "label": "B"}, {"id": "C", "explanation": "Values near $0$ are sometimes $-1$ and sometimes $1$; there is no single value approached.", "value": "$-1$", "label": "C"}, {"id": "D", "explanation": "The function values oscillate between $1$ and $-1$ near $0$, so they do not approach a single number.", "value": "The limit does not exist", "label": "D"}]'::jsonb, 'D', 'As $x$ gets closer to $0$, the outputs keep switching between $1$ and $-1$. Since the values do not settle on a single number, $\lim_{x\to 0} f(x)$ does not exist.', 0, 'published', 1);

COMMIT;
