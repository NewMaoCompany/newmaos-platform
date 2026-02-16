-- Update Unit 1 Limits Questions (Chapters 1.3 & 1.4)
BEGIN;

-- Updating C3Q1_LeftHandLimitAt2 (3e778fee-ed46-4ce9-9957-0f98aab05d85)
UPDATE public.questions SET
  prompt = 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 2^-} f(x)$.',
  latex = 'Find $\displaystyle \lim_{x\to 2^-} f(x)$.',
  options = '[{"id": "A", "text": "$3$", "explanation": "Approaching $x=2$ from the left follows the left linear branch, which approaches $y=3$ at the open circle."}, {"id": "B", "text": "$4$", "explanation": "$4$ is the function value shown by the filled point at $x=2$, not the left-hand limit."}, {"id": "C", "text": "The limit does not exist", "explanation": "A one-sided limit can exist even if the two-sided limit fails; from the left the values approach a single number."}, {"id": "D", "text": "$2$", "explanation": "$2$ confuses the $x$-value being approached with the $y$-value of the limit."}]'::jsonb,
  explanation = 'As $x\to 2^-$, the graph follows the left branch. The $y$-values approach $3$ (the open circle at $(2,3)$). Therefore, $\lim_{x\to 2^-} f(x)=3$.',
  micro_explanations = '{"A": "Left branch approaches $3$.", "B": "Filled point is $f(2)$, not the left limit.", "C": "One-sided limit exists here.", "D": "Limit is a $y$-value, not the $x$-value."}'::jsonb,
  skill_tags = ARRAY['sk_read_limit_from_graph', 'sk_one_sided_limit'],
  primary_skill_id = 'sk_read_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_one_sided_limit'],
error_tags = ARRAY['err_misread_open_closed_dot', 'err_confuse_limit_with_value', 'err_ignore_one_sided'],
  recommendation_reasons = ARRAY['Targets one-sided limit reading from a graph.', 'Reinforces open vs closed circle meaning.'],
  primary_skill_id = 'sk_read_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_one_sided_limit'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.3',
  difficulty = 2,
  target_time_seconds = 75,
  updated_at = NOW(),
  title = 'C3Q1_LeftHandLimitAt2',
  prompt_type = 'image',
  representation_type = 'symbolic'
WHERE id = '3e778fee-ed46-4ce9-9957-0f98aab05d85';

-- Updating C3Q2_TwoSidedLimitJumpAt1 (8a0ad35f-00a0-488e-875e-e3cc3be3279e)
UPDATE public.questions SET
  prompt = 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 1} f(x)$.',
  latex = 'Find $\displaystyle \lim_{x\to 1} f(x)$.',
  options = '[{"id": "A", "text": "$1$", "explanation": "$1$ matches the right-hand approach (and the filled point), but the left-hand approach is different."}, {"id": "B", "text": "$3$", "explanation": "$3$ matches the left-hand approach (open circle), but the right-hand approach is different."}, {"id": "C", "text": "The limit does not exist", "explanation": "Left-hand and right-hand limits are different ($3$ from the left and $1$ from the right), so the two-sided limit does not exist."}, {"id": "D", "text": "$2$", "explanation": "$2$ is not approached from either side; it results from averaging or guessing."}]'::jsonb,
  explanation = 'From the left, $f(x)$ approaches $3$ (open circle at $(1,3)$). From the right, $f(x)$ approaches $1$ (horizontal segment). Since $\lim_{x\to 1^-} f(x)\neq \lim_{x\to 1^+} f(x)$, $\lim_{x\to 1} f(x)$ does not exist.',
  micro_explanations = '{"A": "Only right-hand behavior.", "B": "Only left-hand behavior.", "C": "Mismatch of one-sided limits.", "D": "Not supported by the graph."}'::jsonb,
  skill_tags = ARRAY['sk_read_limit_from_graph', 'sk_limit_dne_from_graph'],
  primary_skill_id = 'sk_read_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_limit_dne_from_graph'],
error_tags = ARRAY['err_assume_two_sided_exists', 'err_confuse_limit_with_value', 'err_misread_open_closed_dot'],
  recommendation_reasons = ARRAY['Tests DNE via mismatch of one-sided limits.', 'Builds discipline: two-sided requires both sides match.'],
  primary_skill_id = 'sk_read_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_limit_dne_from_graph'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.3',
  difficulty = 3,
  target_time_seconds = 90,
  updated_at = NOW(),
  title = 'C3Q2_TwoSidedLimitJumpAt1',
  prompt_type = 'image',
  representation_type = 'symbolic'
WHERE id = '8a0ad35f-00a0-488e-875e-e3cc3be3279e';

-- Updating C3Q3_InfiniteLimitAt0Plus (ddab50a0-a3fc-4ea4-910d-0b38bf5de730)
UPDATE public.questions SET
  prompt = 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 0^+} f(x)$.',
  latex = 'Find $\displaystyle \lim_{x\to 0^+} f(x)$.',
  options = '[{"id": "A", "text": "$-\\infty$", "explanation": "The branch shown for $x>0$ rises upward as $x\\to 0^+$, not downward."}, {"id": "B", "text": "$\\infty$", "explanation": "As $x\\to 0^+$, the graph increases without bound, so the one-sided limit is $\\infty$."}, {"id": "C", "text": "$0$", "explanation": "The $x$-axis is not being approached; the $y$-values grow large."}, {"id": "D", "text": "The limit does not exist", "explanation": "An infinite limit is a valid limit description; here the behavior is unbounded in a single direction."}]'::jsonb,
  explanation = 'Near $x=0$ on the right, the graph shoots upward without bound. Therefore, $\lim_{x\to 0^+} f(x)=\infty$.',
  micro_explanations = '{"A": "Wrong sign: graph goes up.", "B": "Unbounded upward as $x\\to 0^+$.", "C": "Not approaching $y=0$.", "D": "Infinite limit is a type of limit."}'::jsonb,
  skill_tags = ARRAY['sk_infinite_limit_from_graph', 'sk_one_sided_limit'],
  primary_skill_id = 'sk_infinite_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_one_sided_limit'],
error_tags = ARRAY['err_sign_error_infinity', 'err_ignore_one_sided', 'err_assume_asymptote_means_dne_always'],
  recommendation_reasons = ARRAY['Reinforces interpreting vertical asymptote behavior.', 'Targets sign of infinity with one-sided approach.'],
  primary_skill_id = 'sk_infinite_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_one_sided_limit'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.3',
  difficulty = 4,
  target_time_seconds = 105,
  updated_at = NOW(),
  title = 'C3Q3_InfiniteLimitAt0Plus',
  prompt_type = 'image',
  representation_type = 'symbolic'
WHERE id = 'ddab50a0-a3fc-4ea4-910d-0b38bf5de730';

-- Updating C3Q4_RemovableDiscontinuityAtMinus1 (adc81ac2-cfc7-4e33-b3df-345b6e79ae16)
UPDATE public.questions SET
  prompt = 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to -1} f(x)$.',
  latex = 'Find $\displaystyle \lim_{x\to -1} f(x)$.',
  options = '[{"id": "A", "text": "The limit does not exist", "explanation": "A hole does not prevent a limit from existing; the surrounding values can still approach one number."}, {"id": "B", "text": "$-1$", "explanation": "$-1$ is the $x$-value being approached, not the $y$-value of the limit."}, {"id": "C", "text": "$1$", "explanation": "Near $x=-1$, the graph lies on the horizontal line $y=1$ with a hole at $(-1,1)$, so the limit is $1$."}, {"id": "D", "text": "$0$", "explanation": "The graph is not approaching $y=0$ near $x=-1$."}]'::jsonb,
  explanation = 'Approaching $x=-1$ from either side, the graph stays at $y=1$. Even though there is a hole at $(-1,1)$, the approaching value is $1$, so $\lim_{x\to -1} f(x)=1$.',
  micro_explanations = '{"A": "Hole \u2260 DNE.", "B": "Confuses $x$ with limit value.", "C": "Both sides approach $1$.", "D": "Not supported by the graph."}'::jsonb,
  skill_tags = ARRAY['sk_read_limit_from_graph', 'sk_limit_exists_graphically'],
  primary_skill_id = 'sk_read_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_limit_exists_graphically'],
error_tags = ARRAY['err_confuse_hole_with_dne', 'err_confuse_limit_with_value', 'err_misread_open_closed_dot'],
  recommendation_reasons = ARRAY['Differentiates limit existence from function value.', 'Targets removable discontinuity interpretation.'],
  primary_skill_id = 'sk_read_limit_from_graph',
  supporting_skill_ids = ARRAY['sk_limit_exists_graphically'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.3',
  difficulty = 2,
  target_time_seconds = 80,
  updated_at = NOW(),
  title = 'C3Q4_RemovableDiscontinuityAtMinus1',
  prompt_type = 'image',
  representation_type = 'symbolic'
WHERE id = 'adc81ac2-cfc7-4e33-b3df-345b6e79ae16';

-- Updating C3Q5_RightHandLimitAt0 (e432e2fb-7cd6-4257-bbb4-d503e8ca9056)
UPDATE public.questions SET
  prompt = 'Use the graph to evaluate the limit.

Find $\displaystyle \lim_{x\to 0^+} f(x)$.',
  latex = 'Find $\displaystyle \lim_{x\to 0^+} f(x)$.',
  options = '[{"id": "A", "text": "$1$", "explanation": "At $x=0$, the graph begins at $y=0$, not $1$."}, {"id": "B", "text": "$0$", "explanation": "As $x\\to 0^+$ along the curve, $y\\to 0$."}, {"id": "C", "text": "The limit does not exist", "explanation": "A right-hand limit can exist even if there is no left side shown."}, {"id": "D", "text": "$\\infty$", "explanation": "The curve does not blow up near $x=0$; it approaches $0$."}]'::jsonb,
  explanation = 'The graph is defined for $x\ge 0$ and approaches the point $(0,0)$ from the right. Therefore, $\lim_{x\to 0^+} f(x)=0$.',
  micro_explanations = '{"A": "Start point is at $0$.", "B": "Right-hand approach gives $0$.", "C": "One-sided limit is valid.", "D": "No unbounded behavior."}'::jsonb,
  skill_tags = ARRAY['sk_one_sided_limit', 'sk_read_limit_from_graph'],
  primary_skill_id = 'sk_one_sided_limit',
  supporting_skill_ids = ARRAY['sk_read_limit_from_graph'],
error_tags = ARRAY['err_assume_two_sided_required', 'err_ignore_domain_endpoint', 'err_ignore_one_sided'],
  recommendation_reasons = ARRAY['Builds comfort with endpoint/right-hand limits.', 'Reinforces meaning of $0^+$.'],
  primary_skill_id = 'sk_one_sided_limit',
  supporting_skill_ids = ARRAY['sk_read_limit_from_graph'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.3',
  difficulty = 1,
  target_time_seconds = 60,
  updated_at = NOW(),
  title = 'C3Q5_RightHandLimitAt0',
  prompt_type = 'image',
  representation_type = 'symbolic'
WHERE id = 'e432e2fb-7cd6-4257-bbb4-d503e8ca9056';

-- Updating C4Q1_TableLimitApproaches6 (f625c885-89ec-4710-97bd-12c5b697f4be)
UPDATE public.questions SET
  prompt = 'A function $f$ is defined near $x=3$. Use the table to estimate $\displaystyle \lim_{x\to 3} f(x)$.

$$
\begin{array}{c|cccccc}
x & 2.9 & 2.99 & 2.999 & 3.001 & 3.01 & 3.1\\ \hline
f(x) & 5.7 & 5.97 & 5.997 & 6.003 & 6.03 & 6.3
\end{array}
$$',
  latex = '$$\begin{array}{c|cccccc}x & 2.9 & 2.99 & 2.999 & 3.001 & 3.01 & 3.1\\ \hline f(x) & 5.7 & 5.97 & 5.997 & 6.003 & 6.03 & 6.3\end{array}$$',
  options = '[{"id": "A", "text": "$5.997$", "explanation": "This is just one value from the left side; the limit should reflect values from both sides approaching the same number."}, {"id": "B", "text": "$6$", "explanation": "Values approach $6$ from both sides: $5.997$ (left) and $6.003$ (right) get closer to $6$ as $x$ nears $3$."}, {"id": "C", "text": "$6.003$", "explanation": "This is just one value from the right side; it is not the best estimate of the limiting value."}, {"id": "D", "text": "The limit does not exist", "explanation": "Both sides trend toward the same value, so the limit exists."}]'::jsonb,
  explanation = 'As $x$ approaches $3$ from the left, $f(x)$ moves from $5.97$ to $5.997$. From the right, it moves from $6.03$ to $6.003$. These values cluster around $6$, so $\lim_{x\to 3} f(x)\approx 6$.',
  micro_explanations = '{"A": "Single left-side entry.", "B": "Both sides approach $6$.", "C": "Single right-side entry.", "D": "Trends indicate existence."}'::jsonb,
  skill_tags = ARRAY['sk_estimate_limit_from_table'],
  primary_skill_id = 'sk_estimate_limit_from_table',
  supporting_skill_ids = ARRAY[]::text[],
error_tags = ARRAY['err_use_nearest_value_only', 'err_confuse_limit_with_value', 'err_ignore_both_sides_table'],
  recommendation_reasons = ARRAY['Trains reading two-sided behavior from tables.', 'Counters the habit of picking one nearby entry.'],
  primary_skill_id = 'sk_estimate_limit_from_table',
  supporting_skill_ids = '{}',
  topic_id = 'Both_Limits',
  sub_topic_id = '1.4',
  difficulty = 2,
  target_time_seconds = 80,
  updated_at = NOW(),
  title = 'C4Q1_TableLimitApproaches6',
  prompt_type = 'text',
  representation_type = 'symbolic'
WHERE id = 'f625c885-89ec-4710-97bd-12c5b697f4be';

-- Updating C4Q2_TableTwoSidedLimitDNE (45053b2f-bb1a-40db-ba92-8b4cb8d8b544)
UPDATE public.questions SET
  prompt = 'Use the table to determine $\displaystyle \lim_{x\to 2} f(x)$.

$$
\begin{array}{c|cccccc}
x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\ \hline
f(x) & -1.1 & -1.01 & -1.001 & 3.001 & 3.01 & 3.1
\end{array}
$$',
  latex = '$$\begin{array}{c|cccccc}x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\ \hline f(x) & -1.1 & -1.01 & -1.001 & 3.001 & 3.01 & 3.1\end{array}$$',
  options = '[{"id": "A", "text": "$1$", "explanation": "This is an average of the one-sided behaviors, but limits are not found by averaging."}, {"id": "B", "text": "$-1$", "explanation": "This matches the left-hand trend, but the right-hand trend approaches a different value."}, {"id": "C", "text": "$3$", "explanation": "This matches the right-hand trend, but the left-hand trend approaches a different value."}, {"id": "D", "text": "The limit does not exist", "explanation": "Left-hand values approach $-1$ while right-hand values approach $3$, so the two-sided limit does not exist."}]'::jsonb,
  explanation = 'From the left of $2$, $f(x)$ approaches $-1$ (e.g., $-1.001$). From the right of $2$, $f(x)$ approaches $3$ (e.g., $3.001$). Since the one-sided limits are unequal, $\lim_{x\to 2} f(x)$ does not exist.',
  micro_explanations = '{"A": "Averaging is invalid for limits.", "B": "Only left-hand limit.", "C": "Only right-hand limit.", "D": "One-sided limits differ."}'::jsonb,
  skill_tags = ARRAY['sk_estimate_limit_from_table', 'sk_limit_dne_from_table'],
  primary_skill_id = 'sk_estimate_limit_from_table',
  supporting_skill_ids = ARRAY['sk_limit_dne_from_table'],
error_tags = ARRAY['err_ignore_both_sides_table', 'err_average_two_sides', 'err_assume_two_sided_exists'],
  recommendation_reasons = ARRAY['Directly tests DNE using left vs right trends in a table.', 'Targets the common averaging mistake.'],
  primary_skill_id = 'sk_estimate_limit_from_table',
  supporting_skill_ids = ARRAY['sk_limit_dne_from_table'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.4',
  difficulty = 3,
  target_time_seconds = 95,
  updated_at = NOW(),
  title = 'C4Q2_TableTwoSidedLimitDNE',
  prompt_type = 'text',
  representation_type = 'symbolic'
WHERE id = '45053b2f-bb1a-40db-ba92-8b4cb8d8b544';

-- Updating C4Q3_TableInfiniteLimit (42aacaf5-0631-49b3-ae54-46805526a3ac)
UPDATE public.questions SET
  prompt = 'Use the table to evaluate the limit.

$$
\begin{array}{c|cccccc}
x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\ \hline
f(x) & 10 & 100 & 1000 & 1000 & 100 & 10
\end{array}
$$

Find $\displaystyle \lim_{x\to 0} f(x)$.',
  latex = '$$\begin{array}{c|cccccc}x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\ \hline f(x) & 10 & 100 & 1000 & 1000 & 100 & 10\end{array}$$',
  options = '[{"id": "A", "text": "$0$", "explanation": "The values grow larger as $x$ gets closer to $0$, not smaller."}, {"id": "B", "text": "$-\\infty$", "explanation": "All listed function values are positive and increasing in magnitude near $0$, so the trend is not toward $-\\infty$."}, {"id": "C", "text": "$\\infty$", "explanation": "As $x$ approaches $0$ from both sides, $f(x)$ increases without bound, indicating an infinite limit of $\\infty$."}, {"id": "D", "text": "The limit does not exist", "explanation": "Here the function grows without bound in the same direction on both sides, so describing the limit as $\\infty$ is appropriate."}]'::jsonb,
  explanation = 'When $x$ is closer to $0$ (e.g., $\pm 0.001$), $f(x)$ is much larger (1000) than when $x$ is farther (e.g., $\pm 0.1$ gives 10). The values increase without bound as $x\to 0$, so $\lim_{x\to 0} f(x)=\infty$.',
  micro_explanations = '{"A": "Opposite trend.", "B": "Wrong sign.", "C": "Unbounded growth both sides.", "D": "Infinite limit is a valid description here."}'::jsonb,
  skill_tags = ARRAY['sk_infinite_limit_from_table', 'sk_limit_notation_infinite'],
  primary_skill_id = 'sk_infinite_limit_from_table',
  supporting_skill_ids = ARRAY['sk_limit_notation_infinite'],
error_tags = ARRAY['err_write_dne_instead_of_infinity', 'err_sign_error_infinity', 'err_assume_always_finite'],
  recommendation_reasons = ARRAY['Reinforces recognizing infinite limits from numerical data.', 'Targets the DNE vs $\infty$ misconception.'],
  primary_skill_id = 'sk_infinite_limit_from_table',
  supporting_skill_ids = ARRAY['sk_limit_notation_infinite'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.4',
  difficulty = 4,
  target_time_seconds = 110,
  updated_at = NOW(),
  title = 'C4Q3_TableInfiniteLimit',
  prompt_type = 'text',
  representation_type = 'symbolic'
WHERE id = '42aacaf5-0631-49b3-ae54-46805526a3ac';

-- Updating C4Q4_DifferenceQuotientFromTable (9b8a1428-e64e-4826-93cf-3167497f581d)
UPDATE public.questions SET
  prompt = 'A function $f$ is defined near $x=2$. Use the table to estimate
$$\displaystyle \lim_{x\to 2}\frac{f(x)-f(2)}{x-2}.$$

$$
\begin{array}{c|cccccc}
x & 1.9 & 1.99 & 1.999 & 2.001 & 2.01 & 2.1\\ \hline
f(x) & 4.61 & 4.9601 & 4.996001 & 5.004001 & 5.0401 & 5.41
\end{array}
$$

Assume $f(2)=5$.',
  latex = '$$\lim_{x\to 2}\frac{f(x)-f(2)}{x-2}$$ with $f(2)=5$.',
  options = '[{"id": "A", "text": "$0$", "explanation": "The quotient is not near $0$; the changes in $f(x)$ relative to changes in $x$ suggest a slope near $4$."}, {"id": "B", "text": "$4$", "explanation": "Using nearby values: for $x=2.001$, $(5.004001-5)/0.001\\approx 4.001$; for $x=1.999$, $(4.996001-5)/(-0.001)\\approx 3.999$."}, {"id": "C", "text": "$5$", "explanation": "$5$ is $f(2)$, but the expression is about the rate of change (slope), not the function value."}, {"id": "D", "text": "The limit does not exist", "explanation": "Left and right quotients both approach about $4$, indicating the limit exists."}]'::jsonb,
  explanation = 'Compute the difference quotient near $2$. From the right: $(5.004001-5)/0.001\approx 4.001$. From the left: $(4.996001-5)/(-0.001)\approx 3.999$. Both sides approach $4$, so the limit is approximately $4$.',
  micro_explanations = '{"A": "Slope is not near $0$.", "B": "Both sides approach $4$.", "C": "Confuses value with slope.", "D": "Trends show existence."}'::jsonb,
  skill_tags = ARRAY['sk_estimate_limit_from_table', 'sk_average_rate_limit'],
  primary_skill_id = 'sk_estimate_limit_from_table',
  supporting_skill_ids = ARRAY['sk_average_rate_limit'],
error_tags = ARRAY['err_substitute_point_value', 'err_mix_up_difference_quotient', 'err_use_nearest_value_only'],
  recommendation_reasons = ARRAY['Connects tabular estimation with the key limit form for instantaneous rate of change.', 'Trains correct setup using $f(2)$ and $(x-2)$.'],
  primary_skill_id = 'sk_estimate_limit_from_table',
  supporting_skill_ids = ARRAY['sk_average_rate_limit'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.4',
  difficulty = 3,
  target_time_seconds = 100,
  updated_at = NOW(),
  title = 'C4Q4_DifferenceQuotientFromTable',
  prompt_type = 'text',
  representation_type = 'symbolic'
WHERE id = '9b8a1428-e64e-4826-93cf-3167497f581d';

-- Updating C4Q5_TableOscillationDNE (995d20ab-7ad4-4fc2-aa05-06031445ebb2)
UPDATE public.questions SET
  prompt = 'Use the table to determine $\displaystyle \lim_{x\to 0} f(x)$.

$$
\begin{array}{c|cccccc}
x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\ \hline
f(x) & 1 & -1 & 1 & -1 & 1 & -1
\end{array}
$$',
  latex = '$$\begin{array}{c|cccccc}x & -0.1 & -0.01 & -0.001 & 0.001 & 0.01 & 0.1\\ \hline f(x) & 1 & -1 & 1 & -1 & 1 & -1\end{array}$$',
  options = '[{"id": "A", "text": "$0$", "explanation": "Averaging the two values is not justified; the function values do not trend toward $0$."}, {"id": "B", "text": "$1$", "explanation": "Values near $0$ are sometimes $1$ and sometimes $-1$; there is no single value approached."}, {"id": "C", "text": "$-1$", "explanation": "Values near $0$ are sometimes $-1$ and sometimes $1$; there is no single value approached."}, {"id": "D", "text": "The limit does not exist", "explanation": "The function values oscillate between $1$ and $-1$ near $0$, so they do not approach a single number."}]'::jsonb,
  explanation = 'As $x$ gets closer to $0$, the outputs keep switching between $1$ and $-1$. Since the values do not settle on a single number, $\lim_{x\to 0} f(x)$ does not exist.',
  micro_explanations = '{"A": "Averaging is not a limit rule.", "B": "Not consistently approaching $1$.", "C": "Not consistently approaching $-1$.", "D": "Oscillation prevents a limit."}'::jsonb,
  skill_tags = ARRAY['sk_limit_dne_from_table', 'sk_estimate_limit_from_table'],
  primary_skill_id = 'sk_limit_dne_from_table',
  supporting_skill_ids = ARRAY['sk_estimate_limit_from_table'],
error_tags = ARRAY['err_use_nearest_value_only', 'err_assume_pattern_continues_to_limit', 'err_ignore_oscillation'],
  recommendation_reasons = ARRAY['Tests a high-frequency misconception: ''nearby values'' can alternate and still fail to have a limit.', 'Builds recognition of oscillation as a DNE pattern.'],
  primary_skill_id = 'sk_limit_dne_from_table',
  supporting_skill_ids = ARRAY['sk_estimate_limit_from_table'],
  topic_id = 'Both_Limits',
  sub_topic_id = '1.4',
  difficulty = 5,
  target_time_seconds = 120,
  updated_at = NOW(),
  title = 'C4Q5_TableOscillationDNE',
  prompt_type = 'text',
  representation_type = 'symbolic'
WHERE id = '995d20ab-7ad4-4fc2-aa05-06031445ebb2';

COMMIT;
