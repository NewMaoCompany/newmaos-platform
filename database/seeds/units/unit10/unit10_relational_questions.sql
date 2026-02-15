-- Unit 10 Relational Update (Definitive Surgery)
BEGIN;
-- Step -1: Create missing Topic Content
INSERT INTO public.topic_content (id, title, description) VALUES ('BC_Series', 'Infinite Sequences and Series', 'Unit 10: Infinite Sequences and Series') ON CONFLICT (id) DO NOTHING;

-- Step 0: Create missing Skills
INSERT INTO public.skills (id, name, unit) VALUES ('sequence_and_series_definitions', 'Sequence and Series Definitions', 'BC_Series') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.skills (id, name, unit) VALUES ('partial_sum_reasoning', 'Partial Sum Reasoning', 'BC_Series') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.skills (id, name, unit) VALUES ('algebraic_simplification', 'Algebraic Simplification', 'BC_Series') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.skills (id, name, unit) VALUES ('sigma_notation_manipulation', 'Sigma Notation Manipulation', 'BC_Series') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.skills (id, name, unit) VALUES ('geometric_series_computation', 'Geometric Series Computation', 'BC_Series') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.skills (id, name, unit) VALUES ('modeling_with_series', 'Modeling with Series', 'BC_Series') ON CONFLICT (id) DO NOTHING;

-- Step 1: Create missing Error Tags
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES ('confuse_sequence_vs_series', 'Confuse sequence vs series', 'BC_Series', 1, 'General') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES ('assume_limit_exists_implies_series_converges', 'Assume limit exists implies series converges', 'BC_Series', 1, 'General') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES ('treat_divergent_series_as_having_sum', 'Treat divergent series as having sum', 'BC_Series', 1, 'General') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES ('use_wrong_first_term_index', 'Use wrong first term index', 'BC_Series', 1, 'General') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES ('misidentify_geometric_ratio', 'Misidentify geometric ratio', 'BC_Series', 1, 'General') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES ('ignore_domain_of_r', 'Ignore domain of r', 'BC_Series', 1, 'General') ON CONFLICT (id) DO NOTHING;

-- Step 2: Questions and Links
-- Processing: U10C10.1-Q1-DefinitionSeriesConvergenceByPartialSums
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = 'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.1-Q1-DefinitionSeriesConvergenceByPartialSums', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.1', sub_topic_id = '10.1', type = 'MCQ',
      calculator_allowed = false, difficulty = 1,
      target_time_seconds = 120, prompt = 'Let $\sum_{n=1}^{\infty} a_n$ be an infinite series with partial sums $s_k=\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\sum_{n=1}^{\infty} a_n$ converges?

A. The series converges if and only if $\lim_{k\to\infty} s_k$ exists and is finite.
B. The series converges if and only if $\lim_{n\to\infty} a_n$ exists and is finite.
C. The series converges if and only if $a_n$ is decreasing for all $n$.
D. The series converges if and only if $a_n>0$ for all $n$.',
      latex = 'Let $\sum_{n=1}^{\infty} a_n$ be an infinite series with partial sums $s_k=\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\sum_{n=1}^{\infty} a_n$ converges?

A. The series converges if and only if $\lim_{k\to\infty} s_k$ exists and is finite.
B. The series converges if and only if $\lim_{n\to\infty} a_n$ exists and is finite.
C. The series converges if and only if $a_n$ is decreasing for all $n$.
D. The series converges if and only if $a_n>0$ for all $n$.', options = '[{"id": "A", "text": "The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite."}, {"id": "B", "text": "The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite."}, {"id": "C", "text": "The series converges if and only if $a_n$ is decreasing for all $n$."}, {"id": "D", "text": "The series converges if and only if $a_n>0$ for all $n$."}]'::jsonb,
      correct_option_id = 'A', explanation = 'By definition, $\sum_{n=1}^{\infty} a_n$ converges exactly when the partial sums $s_k=\sum_{n=1}^{k} a_n$ approach a finite limit, i.e., $\lim_{k\to\infty} s_k$ exists and is finite.',
      micro_explanations = '{"A": "Correct. Convergence of a series is defined by the convergence of its sequence of partial sums.", "B": "Incorrect. Even if $\\lim a_n$ exists (and even if it equals 0), the series may still diverge.", "C": "Incorrect. Decreasing terms do not guarantee convergence (e.g., $\\sum 1/n$).", "D": "Incorrect. Many positive-term series diverge; positivity is not a defining condition."}'::jsonb, status = 'published',
      notes = 'Definition check: convergence of series via limit of partial sums.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.1-Q1-DefinitionSeriesConvergenceByPartialSums', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ',
      false, 1, 120,
      'text', 'symbolic', 'Let $\sum_{n=1}^{\infty} a_n$ be an infinite series with partial sums $s_k=\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\sum_{n=1}^{\infty} a_n$ converges?

A. The series converges if and only if $\lim_{k\to\infty} s_k$ exists and is finite.
B. The series converges if and only if $\lim_{n\to\infty} a_n$ exists and is finite.
C. The series converges if and only if $a_n$ is decreasing for all $n$.
D. The series converges if and only if $a_n>0$ for all $n$.', 'Let $\sum_{n=1}^{\infty} a_n$ be an infinite series with partial sums $s_k=\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\sum_{n=1}^{\infty} a_n$ converges?

A. The series converges if and only if $\lim_{k\to\infty} s_k$ exists and is finite.
B. The series converges if and only if $\lim_{n\to\infty} a_n$ exists and is finite.
C. The series converges if and only if $a_n$ is decreasing for all $n$.
D. The series converges if and only if $a_n>0$ for all $n$.',
      '[{"id": "A", "text": "The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite."}, {"id": "B", "text": "The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite."}, {"id": "C", "text": "The series converges if and only if $a_n$ is decreasing for all $n$."}, {"id": "D", "text": "The series converges if and only if $a_n>0$ for all $n$."}]'::jsonb, 'A', 0, 'By definition, $\sum_{n=1}^{\infty} a_n$ converges exactly when the partial sums $s_k=\sum_{n=1}^{k} a_n$ approach a finite limit, i.e., $\lim_{k\to\infty} s_k$ exists and is finite.',
      '{"A": "Correct. Convergence of a series is defined by the convergence of its sequence of partial sums.", "B": "Incorrect. Even if $\\lim a_n$ exists (and even if it equals 0), the series may still diverge.", "C": "Incorrect. Decreasing terms do not guarantee convergence (e.g., $\\sum 1/n$).", "D": "Incorrect. Many positive-term series diverge; positivity is not a defining condition."}'::jsonb, 'published', 1, 'self', 'Definition check: convergence of series via limit of partial sums.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sequence_and_series_definitions', 0.85, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'partial_sum_reasoning', 0.15, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'confuse_sequence_vs_series');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'assume_limit_exists_implies_series_converges');
END $Q$;

-- Processing: U10C10.1-Q2-SumFromExplicitPartialSumLimit
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = 'f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.1-Q2-SumFromExplicitPartialSumLimit', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.1', sub_topic_id = '10.1', type = 'MCQ',
      calculator_allowed = false, difficulty = 2,
      target_time_seconds = 120, prompt = 'An infinite series $\sum_{n=1}^{\infty} a_n$ has partial sums
$$s_k=5-\frac{2}{k+1}.$$
Which statement is true?

A. The series diverges because $\lim_{k\to\infty} s_k=\infty$.
B. The series diverges because $\lim_{k\to\infty} s_k$ does not exist.
C. The series converges and its sum is $5$.
D. The series converges and its sum is $3$.',
      latex = 'An infinite series $\sum_{n=1}^{\infty} a_n$ has partial sums
$$s_k=5-\frac{2}{k+1}.$$
Which statement is true?

A. The series diverges because $\lim_{k\to\infty} s_k=\infty$.
B. The series diverges because $\lim_{k\to\infty} s_k$ does not exist.
C. The series converges and its sum is $5$.
D. The series converges and its sum is $3$.', options = '[{"id": "A", "text": "The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$."}, {"id": "B", "text": "The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist."}, {"id": "C", "text": "The series converges and its sum is $5$."}, {"id": "D", "text": "The series converges and its sum is $3$."}]'::jsonb,
      correct_option_id = 'C', explanation = 'A series converges to $S$ when $\lim_{k\to\infty} s_k=S$. Here $s_k=5-\frac{2}{k+1}\to 5$, so the series converges and its sum is $5$.',
      micro_explanations = '{"A": "Incorrect. $s_k$ approaches a finite value.", "B": "Incorrect. The limit exists because $\\frac{2}{k+1}\\to 0$.", "C": "Correct. $\\lim_{k\\to\\infty} \\left(5-\\frac{2}{k+1}\\right)=5$.", "D": "Incorrect. The limit of the partial sums is $5$, not $3$."}'::jsonb, status = 'published',
      notes = 'Given $s_k$, series sum is $\lim s_k$ if finite.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.1-Q2-SumFromExplicitPartialSumLimit', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ',
      false, 2, 120,
      'text', 'symbolic', 'An infinite series $\sum_{n=1}^{\infty} a_n$ has partial sums
$$s_k=5-\frac{2}{k+1}.$$
Which statement is true?

A. The series diverges because $\lim_{k\to\infty} s_k=\infty$.
B. The series diverges because $\lim_{k\to\infty} s_k$ does not exist.
C. The series converges and its sum is $5$.
D. The series converges and its sum is $3$.', 'An infinite series $\sum_{n=1}^{\infty} a_n$ has partial sums
$$s_k=5-\frac{2}{k+1}.$$
Which statement is true?

A. The series diverges because $\lim_{k\to\infty} s_k=\infty$.
B. The series diverges because $\lim_{k\to\infty} s_k$ does not exist.
C. The series converges and its sum is $5$.
D. The series converges and its sum is $3$.',
      '[{"id": "A", "text": "The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$."}, {"id": "B", "text": "The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist."}, {"id": "C", "text": "The series converges and its sum is $5$."}, {"id": "D", "text": "The series converges and its sum is $3$."}]'::jsonb, 'C', 0, 'A series converges to $S$ when $\lim_{k\to\infty} s_k=S$. Here $s_k=5-\frac{2}{k+1}\to 5$, so the series converges and its sum is $5$.',
      '{"A": "Incorrect. $s_k$ approaches a finite value.", "B": "Incorrect. The limit exists because $\\frac{2}{k+1}\\to 0$.", "C": "Correct. $\\lim_{k\\to\\infty} \\left(5-\\frac{2}{k+1}\\right)=5$.", "D": "Incorrect. The limit of the partial sums is $5$, not $3$."}'::jsonb, 'published', 1, 'self', 'Given $s_k$, series sum is $\lim s_k$ if finite.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'partial_sum_reasoning', 0.8, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'algebraic_simplification', 0.2, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'treat_divergent_series_as_having_sum');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'assume_limit_exists_implies_series_converges');
END $Q$;

-- Processing: U10C10.1-Q3-DivergenceFromOscillatingPartialSums
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '506b994f-5fb3-41c3-8391-c58357ae20a1' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.1-Q3-DivergenceFromOscillatingPartialSums', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.1', sub_topic_id = '10.1', type = 'MCQ',
      calculator_allowed = false, difficulty = 3,
      target_time_seconds = 180, prompt = 'A series $\sum_{n=1}^{\infty} a_n$ has partial sums $s_k$ given by
$$s_k=\begin{cases}2 & \text{if $k$ is even}\ 1 & \text{if $k$ is odd.}\end{cases}$$
Which is true?

A. The series converges to $\frac{3}{2}$.
B. The series converges to $2$.
C. The series converges to $1$.
D. The series diverges.',
      latex = 'A series $\sum_{n=1}^{\infty} a_n$ has partial sums $s_k$ given by
$$s_k=\begin{cases}2 & \text{if $k$ is even}\ 1 & \text{if $k$ is odd.}\end{cases}$$
Which is true?

A. The series converges to $\frac{3}{2}$.
B. The series converges to $2$.
C. The series converges to $1$.
D. The series diverges.', options = '[{"id": "A", "text": "The series converges to $\\frac{3}{2}$."}, {"id": "B", "text": "The series converges to $2$."}, {"id": "C", "text": "The series converges to $1$."}, {"id": "D", "text": "The series diverges."}]'::jsonb,
      correct_option_id = 'D', explanation = 'Convergence requires $\lim_{k\to\infty} s_k$ to exist. Since $s_k$ alternates between 1 and 2, the limit does not exist, so the series diverges.',
      micro_explanations = '{"A": "Incorrect. Partial sums must approach a single value; alternating values do not converge.", "B": "Incorrect. Odd partial sums stay at 1, so the limit cannot be 2.", "C": "Incorrect. Even partial sums stay at 2, so the limit cannot be 1.", "D": "Correct. The sequence $s_k$ has no limit, so the series diverges."}'::jsonb, status = 'published',
      notes = 'Oscillation means no limit for $s_k$.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.1-Q3-DivergenceFromOscillatingPartialSums', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ',
      false, 3, 180,
      'text', 'symbolic', 'A series $\sum_{n=1}^{\infty} a_n$ has partial sums $s_k$ given by
$$s_k=\begin{cases}2 & \text{if $k$ is even}\ 1 & \text{if $k$ is odd.}\end{cases}$$
Which is true?

A. The series converges to $\frac{3}{2}$.
B. The series converges to $2$.
C. The series converges to $1$.
D. The series diverges.', 'A series $\sum_{n=1}^{\infty} a_n$ has partial sums $s_k$ given by
$$s_k=\begin{cases}2 & \text{if $k$ is even}\ 1 & \text{if $k$ is odd.}\end{cases}$$
Which is true?

A. The series converges to $\frac{3}{2}$.
B. The series converges to $2$.
C. The series converges to $1$.
D. The series diverges.',
      '[{"id": "A", "text": "The series converges to $\\frac{3}{2}$."}, {"id": "B", "text": "The series converges to $2$."}, {"id": "C", "text": "The series converges to $1$."}, {"id": "D", "text": "The series diverges."}]'::jsonb, 'D', 0, 'Convergence requires $\lim_{k\to\infty} s_k$ to exist. Since $s_k$ alternates between 1 and 2, the limit does not exist, so the series diverges.',
      '{"A": "Incorrect. Partial sums must approach a single value; alternating values do not converge.", "B": "Incorrect. Odd partial sums stay at 1, so the limit cannot be 2.", "C": "Incorrect. Even partial sums stay at 2, so the limit cannot be 1.", "D": "Correct. The sequence $s_k$ has no limit, so the series diverges."}'::jsonb, 'published', 1, 'self', 'Oscillation means no limit for $s_k$.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'partial_sum_reasoning', 0.85, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sequence_and_series_definitions', 0.15, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'treat_divergent_series_as_having_sum');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'assume_limit_exists_implies_series_converges');
END $Q$;

-- Processing: U10C10.1-Q4-IdentifyTermVsPartialSum
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '3c5a61e7-88f5-46f0-80a5-f8526569ec11' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.1-Q4-IdentifyTermVsPartialSum', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.1', sub_topic_id = '10.1', type = 'MCQ',
      calculator_allowed = false, difficulty = 2,
      target_time_seconds = 120, prompt = 'Let $a_n=\frac{1}{n^2}$ and $s_n=\sum_{k=1}^{n} a_k$. Which statement is correct?

A. $a_n$ is the $n$th partial sum of the series.
B. $s_n$ is the $n$th partial sum of the series $\sum_{n=1}^{\infty} a_n$.
C. $\sum_{n=1}^{\infty} a_n$ is a sequence.
D. $\lim_{n\to\infty} s_n$ equals $a_n$.',
      latex = 'Let $a_n=\frac{1}{n^2}$ and $s_n=\sum_{k=1}^{n} a_k$. Which statement is correct?

A. $a_n$ is the $n$th partial sum of the series.
B. $s_n$ is the $n$th partial sum of the series $\sum_{n=1}^{\infty} a_n$.
C. $\sum_{n=1}^{\infty} a_n$ is a sequence.
D. $\lim_{n\to\infty} s_n$ equals $a_n$.', options = '[{"id": "A", "text": "$a_n$ is the $n$th partial sum of the series."}, {"id": "B", "text": "$s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$."}, {"id": "C", "text": "$\\sum_{n=1}^{\\infty} a_n$ is a sequence."}, {"id": "D", "text": "$\\lim_{n\\to\\infty} s_n$ equals $a_n$."}]'::jsonb,
      correct_option_id = 'B', explanation = 'A term is $a_n$. The $n$th partial sum is $s_n=\sum_{k=1}^{n} a_k$. The infinite series is $\sum_{n=1}^{\infty} a_n$. Only statement B matches these definitions.',
      micro_explanations = '{"A": "Incorrect. $a_n$ is a term of the sequence, not a partial sum.", "B": "Correct. $s_n=\\sum_{k=1}^{n} a_k$ is exactly the $n$th partial sum.", "C": "Incorrect. It denotes an infinite sum (a series), not a sequence.", "D": "Incorrect. If $\\lim s_n$ exists, it is the series sum; $a_n$ is a single term."}'::jsonb, status = 'published',
      notes = 'Clarify roles of $a_n$, $\sum a_n$, and $s_n$.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.1-Q4-IdentifyTermVsPartialSum', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ',
      false, 2, 120,
      'text', 'symbolic', 'Let $a_n=\frac{1}{n^2}$ and $s_n=\sum_{k=1}^{n} a_k$. Which statement is correct?

A. $a_n$ is the $n$th partial sum of the series.
B. $s_n$ is the $n$th partial sum of the series $\sum_{n=1}^{\infty} a_n$.
C. $\sum_{n=1}^{\infty} a_n$ is a sequence.
D. $\lim_{n\to\infty} s_n$ equals $a_n$.', 'Let $a_n=\frac{1}{n^2}$ and $s_n=\sum_{k=1}^{n} a_k$. Which statement is correct?

A. $a_n$ is the $n$th partial sum of the series.
B. $s_n$ is the $n$th partial sum of the series $\sum_{n=1}^{\infty} a_n$.
C. $\sum_{n=1}^{\infty} a_n$ is a sequence.
D. $\lim_{n\to\infty} s_n$ equals $a_n$.',
      '[{"id": "A", "text": "$a_n$ is the $n$th partial sum of the series."}, {"id": "B", "text": "$s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$."}, {"id": "C", "text": "$\\sum_{n=1}^{\\infty} a_n$ is a sequence."}, {"id": "D", "text": "$\\lim_{n\\to\\infty} s_n$ equals $a_n$."}]'::jsonb, 'B', 0, 'A term is $a_n$. The $n$th partial sum is $s_n=\sum_{k=1}^{n} a_k$. The infinite series is $\sum_{n=1}^{\infty} a_n$. Only statement B matches these definitions.',
      '{"A": "Incorrect. $a_n$ is a term of the sequence, not a partial sum.", "B": "Correct. $s_n=\\sum_{k=1}^{n} a_k$ is exactly the $n$th partial sum.", "C": "Incorrect. It denotes an infinite sum (a series), not a sequence.", "D": "Incorrect. If $\\lim s_n$ exists, it is the series sum; $a_n$ is a single term."}'::jsonb, 'published', 1, 'self', 'Clarify roles of $a_n$, $\sum a_n$, and $s_n$.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sequence_and_series_definitions', 0.9, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sigma_notation_manipulation', 0.1, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'confuse_sequence_vs_series');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'use_wrong_first_term_index');
END $Q$;

-- Processing: U10C10.1-Q5-FindNthTermFromPartialSumsDifference
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '2ed209be-7a0d-473b-b3b8-3f254cf47513' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.1-Q5-FindNthTermFromPartialSumsDifference', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.1', sub_topic_id = '10.1', type = 'MCQ',
      calculator_allowed = false, difficulty = 4,
      target_time_seconds = 240, prompt = 'A series has partial sums $s_n=\sum_{k=1}^{n} a_k$ given by
$$s_n=\frac{n}{n+2}.$$
What is $a_n$ for $n\ge2$?

A. $a_n=\frac{2}{(n+1)(n+2)}$
B. $a_n=\frac{2}{n(n+2)}$
C. $a_n=\frac{1}{n+2}$
D. $a_n=\frac{1}{n+1}-\frac{1}{n+2}$',
      latex = 'A series has partial sums $s_n=\sum_{k=1}^{n} a_k$ given by
$$s_n=\frac{n}{n+2}.$$
What is $a_n$ for $n\ge2$?

A. $a_n=\frac{2}{(n+1)(n+2)}$
B. $a_n=\frac{2}{n(n+2)}$
C. $a_n=\frac{1}{n+2}$
D. $a_n=\frac{1}{n+1}-\frac{1}{n+2}$', options = '[{"id": "A", "text": "$a_n=\\frac{2}{(n+1)(n+2)}$"}, {"id": "B", "text": "$a_n=\\frac{2}{n(n+2)}$"}, {"id": "C", "text": "$a_n=\\frac{1}{n+2}$"}, {"id": "D", "text": "$a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$"}]'::jsonb,
      correct_option_id = 'A', explanation = 'For $n\ge2$, $a_n=s_n-s_{n-1}$.
$$a_n=\frac{n}{n+2}-\frac{n-1}{n+1}=\frac{n(n+1)-(n-1)(n+2)}{(n+2)(n+1)}=\frac{2}{(n+1)(n+2)}.$$',
      micro_explanations = '{"A": "Correct. $a_n=s_n-s_{n-1}=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{2}{(n+1)(n+2)}$.", "B": "Incorrect. This does not match the difference $\\frac{n}{n+2}-\\frac{n-1}{n+1}$.", "C": "Incorrect. $a_n$ is a difference of consecutive partial sums, not $s_n$ itself.", "D": "Incorrect. This equals $\\frac{1}{(n+1)(n+2)}$, missing a factor of 2."}'::jsonb, status = 'published',
      notes = 'Use $a_n=s_n-s_{n-1}$ for $n\ge2$.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.1-Q5-FindNthTermFromPartialSumsDifference', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ',
      false, 4, 240,
      'text', 'symbolic', 'A series has partial sums $s_n=\sum_{k=1}^{n} a_k$ given by
$$s_n=\frac{n}{n+2}.$$
What is $a_n$ for $n\ge2$?

A. $a_n=\frac{2}{(n+1)(n+2)}$
B. $a_n=\frac{2}{n(n+2)}$
C. $a_n=\frac{1}{n+2}$
D. $a_n=\frac{1}{n+1}-\frac{1}{n+2}$', 'A series has partial sums $s_n=\sum_{k=1}^{n} a_k$ given by
$$s_n=\frac{n}{n+2}.$$
What is $a_n$ for $n\ge2$?

A. $a_n=\frac{2}{(n+1)(n+2)}$
B. $a_n=\frac{2}{n(n+2)}$
C. $a_n=\frac{1}{n+2}$
D. $a_n=\frac{1}{n+1}-\frac{1}{n+2}$',
      '[{"id": "A", "text": "$a_n=\\frac{2}{(n+1)(n+2)}$"}, {"id": "B", "text": "$a_n=\\frac{2}{n(n+2)}$"}, {"id": "C", "text": "$a_n=\\frac{1}{n+2}$"}, {"id": "D", "text": "$a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$"}]'::jsonb, 'A', 0, 'For $n\ge2$, $a_n=s_n-s_{n-1}$.
$$a_n=\frac{n}{n+2}-\frac{n-1}{n+1}=\frac{n(n+1)-(n-1)(n+2)}{(n+2)(n+1)}=\frac{2}{(n+1)(n+2)}.$$',
      '{"A": "Correct. $a_n=s_n-s_{n-1}=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{2}{(n+1)(n+2)}$.", "B": "Incorrect. This does not match the difference $\\frac{n}{n+2}-\\frac{n-1}{n+1}$.", "C": "Incorrect. $a_n$ is a difference of consecutive partial sums, not $s_n$ itself.", "D": "Incorrect. This equals $\\frac{1}{(n+1)(n+2)}$, missing a factor of 2."}'::jsonb, 'published', 1, 'self', 'Use $a_n=s_n-s_{n-1}$ for $n\ge2$.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sigma_notation_manipulation', 0.6, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'partial_sum_reasoning', 0.4, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'use_wrong_first_term_index');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'confuse_sequence_vs_series');
END $Q$;

-- Processing: U10C10.2-Q6-InfiniteGeometricSumBasic
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '8c2ddb77-9a6b-4212-aec1-fb9c0f558733' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.2-Q6-InfiniteGeometricSumBasic', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.2', sub_topic_id = '10.2', type = 'MCQ',
      calculator_allowed = false, difficulty = 1,
      target_time_seconds = 120, prompt = 'Evaluate the infinite series
$$\sum_{n=0}^{\infty} 3\left(\frac{1}{4}\right)^n.$$

A. $\frac{3}{4}$
B. $4$
C. $\frac{12}{5}$
D. Diverges',
      latex = 'Evaluate the infinite series
$$\sum_{n=0}^{\infty} 3\left(\frac{1}{4}\right)^n.$$

A. $\frac{3}{4}$
B. $4$
C. $\frac{12}{5}$
D. Diverges', options = '[{"id": "A", "text": "$\\frac{3}{4}$"}, {"id": "B", "text": "$4$"}, {"id": "C", "text": "$\\frac{12}{5}$"}, {"id": "D", "text": "Diverges"}]'::jsonb,
      correct_option_id = 'B', explanation = 'This is geometric with first term $a=3$ and ratio $r=\frac14$. Because $|r|<1$, it converges and
$$\sum_{n=0}^{\infty} ar^n=\frac{a}{1-r}=\frac{3}{1-\frac14}=4.$$',
      micro_explanations = '{"A": "Incorrect. $\\frac{3}{4}$ is $ar$ (not the sum).", "B": "Correct. $a=3$, $r=\\frac14$, so sum $=\\frac{3}{1-\\frac14}=4$.", "C": "Incorrect. This can come from using an incorrect denominator such as $1+r$.", "D": "Incorrect. Since $|r|<1$, the geometric series converges."}'::jsonb, status = 'published',
      notes = 'Infinite geometric sum $a/(1-r)$ when $|r|<1$.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.2-Q6-InfiniteGeometricSumBasic', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ',
      false, 1, 120,
      'text', 'symbolic', 'Evaluate the infinite series
$$\sum_{n=0}^{\infty} 3\left(\frac{1}{4}\right)^n.$$

A. $\frac{3}{4}$
B. $4$
C. $\frac{12}{5}$
D. Diverges', 'Evaluate the infinite series
$$\sum_{n=0}^{\infty} 3\left(\frac{1}{4}\right)^n.$$

A. $\frac{3}{4}$
B. $4$
C. $\frac{12}{5}$
D. Diverges',
      '[{"id": "A", "text": "$\\frac{3}{4}$"}, {"id": "B", "text": "$4$"}, {"id": "C", "text": "$\\frac{12}{5}$"}, {"id": "D", "text": "Diverges"}]'::jsonb, 'B', 0, 'This is geometric with first term $a=3$ and ratio $r=\frac14$. Because $|r|<1$, it converges and
$$\sum_{n=0}^{\infty} ar^n=\frac{a}{1-r}=\frac{3}{1-\frac14}=4.$$',
      '{"A": "Incorrect. $\\frac{3}{4}$ is $ar$ (not the sum).", "B": "Correct. $a=3$, $r=\\frac14$, so sum $=\\frac{3}{1-\\frac14}=4$.", "C": "Incorrect. This can come from using an incorrect denominator such as $1+r$.", "D": "Incorrect. Since $|r|<1$, the geometric series converges."}'::jsonb, 'published', 1, 'self', 'Infinite geometric sum $a/(1-r)$ when $|r|<1$.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'geometric_series_computation', 0.9, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'algebraic_simplification', 0.1, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'misidentify_geometric_ratio');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'treat_divergent_series_as_having_sum');
END $Q$;

-- Processing: U10C10.2-Q7-ParameterRangeForGeometricConvergence
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '5e169ee0-6316-4280-a797-5682e5a61493' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.2-Q7-ParameterRangeForGeometricConvergence', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.2', sub_topic_id = '10.2', type = 'MCQ',
      calculator_allowed = false, difficulty = 3,
      target_time_seconds = 180, prompt = 'For which values of $k$ does the series
$$\sum_{n=1}^{\infty} k\left(\frac{k}{3}\right)^{n-1}$$
converge?

A. All real $k$
B. $|k|<3$
C. $|k|\le 3$
D. $|k|>3$',
      latex = 'For which values of $k$ does the series
$$\sum_{n=1}^{\infty} k\left(\frac{k}{3}\right)^{n-1}$$
converge?

A. All real $k$
B. $|k|<3$
C. $|k|\le 3$
D. $|k|>3$', options = '[{"id": "A", "text": "All real $k$"}, {"id": "B", "text": "$|k|<3$"}, {"id": "C", "text": "$|k|\\le 3$"}, {"id": "D", "text": "$|k|>3$"}]'::jsonb,
      correct_option_id = 'B', explanation = 'At $n=1$ the term is $k$, and the common ratio is $r=\frac{k}{3}$. An infinite geometric series converges iff $|r|<1$.
Thus $\left|\frac{k}{3}\right|<1\Rightarrow |k|<3$.',
      micro_explanations = '{"A": "Incorrect. Convergence depends on the common ratio $r=\\frac{k}{3}$.", "B": "Correct. The series is geometric with ratio $r=\\frac{k}{3}$, so it converges iff $|r|<1$, i.e. $|k|<3$.", "C": "Incorrect. If $|k|=3$, then $|r|=1$ and the geometric series does not converge.", "D": "Incorrect. If $|k|>3$, then $|r|>1$ and the terms do not approach 0."}'::jsonb, status = 'published',
      notes = 'Use $|r|<1$ with $r=k/3$.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.2-Q7-ParameterRangeForGeometricConvergence', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ',
      false, 3, 180,
      'text', 'symbolic', 'For which values of $k$ does the series
$$\sum_{n=1}^{\infty} k\left(\frac{k}{3}\right)^{n-1}$$
converge?

A. All real $k$
B. $|k|<3$
C. $|k|\le 3$
D. $|k|>3$', 'For which values of $k$ does the series
$$\sum_{n=1}^{\infty} k\left(\frac{k}{3}\right)^{n-1}$$
converge?

A. All real $k$
B. $|k|<3$
C. $|k|\le 3$
D. $|k|>3$',
      '[{"id": "A", "text": "All real $k$"}, {"id": "B", "text": "$|k|<3$"}, {"id": "C", "text": "$|k|\\le 3$"}, {"id": "D", "text": "$|k|>3$"}]'::jsonb, 'B', 0, 'At $n=1$ the term is $k$, and the common ratio is $r=\frac{k}{3}$. An infinite geometric series converges iff $|r|<1$.
Thus $\left|\frac{k}{3}\right|<1\Rightarrow |k|<3$.',
      '{"A": "Incorrect. Convergence depends on the common ratio $r=\\frac{k}{3}$.", "B": "Correct. The series is geometric with ratio $r=\\frac{k}{3}$, so it converges iff $|r|<1$, i.e. $|k|<3$.", "C": "Incorrect. If $|k|=3$, then $|r|=1$ and the geometric series does not converge.", "D": "Incorrect. If $|k|>3$, then $|r|>1$ and the terms do not approach 0."}'::jsonb, 'published', 1, 'self', 'Use $|r|<1$ with $r=k/3$.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'geometric_series_computation', 0.75, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sequence_and_series_definitions', 0.25, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'ignore_domain_of_r');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'misidentify_geometric_ratio');
END $Q$;

-- Processing: U10C10.2-Q8-RepeatingDecimalToFractionGeometric
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '6a8211d0-14d6-4294-8ac3-2065b42cecad' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.2-Q8-RepeatingDecimalToFractionGeometric', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.2', sub_topic_id = '10.2', type = 'MCQ',
      calculator_allowed = false, difficulty = 2,
      target_time_seconds = 180, prompt = 'Write $0.\overline{36}$ as a fraction in simplest form.

A. $\frac{9}{25}$
B. $\frac{12}{25}$
C. $\frac{4}{11}$
D. $\frac{36}{99}$',
      latex = 'Write $0.\overline{36}$ as a fraction in simplest form.

A. $\frac{9}{25}$
B. $\frac{12}{25}$
C. $\frac{4}{11}$
D. $\frac{36}{99}$', options = '[{"id": "A", "text": "$\\frac{9}{25}$"}, {"id": "B", "text": "$\\frac{12}{25}$"}, {"id": "C", "text": "$\\frac{4}{11}$"}, {"id": "D", "text": "$\\frac{36}{99}$"}]'::jsonb,
      correct_option_id = 'C', explanation = 'Interpret as a geometric series:
$$0.\overline{36}=0.36+0.0036+0.000036+\cdots$$
This has $a=0.36$ and $r=0.01$, so
$$\frac{a}{1-r}=\frac{0.36}{0.99}=\frac{36}{99}=\frac{4}{11}.$$',
      micro_explanations = '{"A": "Incorrect. $\\frac{9}{25}=0.36$ (terminating), not $0.\\overline{36}$.", "B": "Incorrect. $\\frac{12}{25}=0.48$.", "C": "Correct. $0.\\overline{36}=\\frac{36}{99}=\\frac{4}{11}$.", "D": "Incorrect. This equals the value but is not simplified."}'::jsonb, status = 'published',
      notes = 'Represent repeating decimal as infinite geometric series.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.2-Q8-RepeatingDecimalToFractionGeometric', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ',
      false, 2, 180,
      'text', 'symbolic', 'Write $0.\overline{36}$ as a fraction in simplest form.

A. $\frac{9}{25}$
B. $\frac{12}{25}$
C. $\frac{4}{11}$
D. $\frac{36}{99}$', 'Write $0.\overline{36}$ as a fraction in simplest form.

A. $\frac{9}{25}$
B. $\frac{12}{25}$
C. $\frac{4}{11}$
D. $\frac{36}{99}$',
      '[{"id": "A", "text": "$\\frac{9}{25}$"}, {"id": "B", "text": "$\\frac{12}{25}$"}, {"id": "C", "text": "$\\frac{4}{11}$"}, {"id": "D", "text": "$\\frac{36}{99}$"}]'::jsonb, 'C', 0, 'Interpret as a geometric series:
$$0.\overline{36}=0.36+0.0036+0.000036+\cdots$$
This has $a=0.36$ and $r=0.01$, so
$$\frac{a}{1-r}=\frac{0.36}{0.99}=\frac{36}{99}=\frac{4}{11}.$$',
      '{"A": "Incorrect. $\\frac{9}{25}=0.36$ (terminating), not $0.\\overline{36}$.", "B": "Incorrect. $\\frac{12}{25}=0.48$.", "C": "Correct. $0.\\overline{36}=\\frac{36}{99}=\\frac{4}{11}$.", "D": "Incorrect. This equals the value but is not simplified."}'::jsonb, 'published', 1, 'self', 'Represent repeating decimal as infinite geometric series.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'modeling_with_series', 0.6, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'geometric_series_computation', 0.4, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'misidentify_geometric_ratio');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'use_wrong_first_term_index');
END $Q$;

-- Processing: U10C10.2-Q9-InfiniteGeometricIndexShiftExactSum
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = '217aa340-4ef3-437a-8ea1-12a6554c40e8' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.2-Q9-InfiniteGeometricIndexShiftExactSum', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.2', sub_topic_id = '10.2', type = 'MCQ',
      calculator_allowed = false, difficulty = 4,
      target_time_seconds = 240, prompt = 'Evaluate
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n.$$

A. $\frac{20}{3}$
B. $\frac{10}{3}$
C. $\frac{20}{9}$
D. Diverges',
      latex = 'Evaluate
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n.$$

A. $\frac{20}{3}$
B. $\frac{10}{3}$
C. $\frac{20}{9}$
D. Diverges', options = '[{"id": "A", "text": "$\\frac{20}{3}$"}, {"id": "B", "text": "$\\frac{10}{3}$"}, {"id": "C", "text": "$\\frac{20}{9}$"}, {"id": "D", "text": "Diverges"}]'::jsonb,
      correct_option_id = 'A', explanation = 'Factor out 5 and identify the first term at $n=2$:
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n = 5\sum_{n=2}^{\infty}\left(\frac{2}{3}\right)^n.$$
First term is $\left(\frac{2}{3}\right)^2=\frac{4}{9}$, ratio is $\frac{2}{3}$, so
$$5\cdot\frac{\frac{4}{9}}{1-\frac{2}{3}}=5\cdot\frac{\frac{4}{9}}{\frac{1}{3}}=5\cdot\frac{4}{3}=\frac{20}{3}.$$',
      micro_explanations = '{"A": "Correct. It is geometric with first term $5\\left(\\frac{2}{3}\\right)^2=\\frac{20}{9}$ and ratio $\\frac{2}{3}$, so sum $=\\frac{\\frac{20}{9}}{1-\\frac{2}{3}}=\\frac{20}{3}$.", "B": "Incorrect. This often comes from using $5\\left(\\frac{2}{3}\\right)^1$ as the first term or dropping a factor of 2.", "C": "Incorrect. $\\frac{20}{9}$ is the first term (at $n=2$), not the sum to infinity.", "D": "Incorrect. Since $\\left|\\frac{2}{3}\\right|<1$, the geometric series converges."}'::jsonb, status = 'published',
      notes = 'Starts at $n=2$: first term must be evaluated at $n=2$.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.2-Q9-InfiniteGeometricIndexShiftExactSum', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ',
      false, 4, 240,
      'text', 'symbolic', 'Evaluate
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n.$$

A. $\frac{20}{3}$
B. $\frac{10}{3}$
C. $\frac{20}{9}$
D. Diverges', 'Evaluate
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n.$$

A. $\frac{20}{3}$
B. $\frac{10}{3}$
C. $\frac{20}{9}$
D. Diverges',
      '[{"id": "A", "text": "$\\frac{20}{3}$"}, {"id": "B", "text": "$\\frac{10}{3}$"}, {"id": "C", "text": "$\\frac{20}{9}$"}, {"id": "D", "text": "Diverges"}]'::jsonb, 'A', 0, 'Factor out 5 and identify the first term at $n=2$:
$$\sum_{n=2}^{\infty} 5\left(\frac{2}{3}\right)^n = 5\sum_{n=2}^{\infty}\left(\frac{2}{3}\right)^n.$$
First term is $\left(\frac{2}{3}\right)^2=\frac{4}{9}$, ratio is $\frac{2}{3}$, so
$$5\cdot\frac{\frac{4}{9}}{1-\frac{2}{3}}=5\cdot\frac{\frac{4}{9}}{\frac{1}{3}}=5\cdot\frac{4}{3}=\frac{20}{3}.$$',
      '{"A": "Correct. It is geometric with first term $5\\left(\\frac{2}{3}\\right)^2=\\frac{20}{9}$ and ratio $\\frac{2}{3}$, so sum $=\\frac{\\frac{20}{9}}{1-\\frac{2}{3}}=\\frac{20}{3}$.", "B": "Incorrect. This often comes from using $5\\left(\\frac{2}{3}\\right)^1$ as the first term or dropping a factor of 2.", "C": "Incorrect. $\\frac{20}{9}$ is the first term (at $n=2$), not the sum to infinity.", "D": "Incorrect. Since $\\left|\\frac{2}{3}\\right|<1$, the geometric series converges."}'::jsonb, 'published', 1, 'self', 'Starts at $n=2$: first term must be evaluated at $n=2$.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'geometric_series_computation', 0.7, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'sigma_notation_manipulation', 0.3, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'use_wrong_first_term_index');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'misidentify_geometric_ratio');
END $Q$;

-- Processing: U10C10.2-Q10-FiniteGeometricSumFormula
DO $Q$
DECLARE q_id uuid;
BEGIN
  SELECT id INTO q_id FROM public.questions WHERE id = 'cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf' LIMIT 1;
  IF q_id IS NOT NULL THEN
    UPDATE public.questions SET
      title = 'U10C10.2-Q10-FiniteGeometricSumFormula', course = 'BC', topic = 'BC_Series', topic_id = 'BC_Series',
      section_id = '10.2', sub_topic_id = '10.2', type = 'MCQ',
      calculator_allowed = false, difficulty = 2,
      target_time_seconds = 180, prompt = 'Compute the finite sum
$$\sum_{n=0}^{3} 5\cdot 2^n.$$

A. $35$
B. $40$
C. $45$
D. $75$',
      latex = 'Compute the finite sum
$$\sum_{n=0}^{3} 5\cdot 2^n.$$

A. $35$
B. $40$
C. $45$
D. $75$', options = '[{"id": "A", "text": "$35$"}, {"id": "B", "text": "$40$"}, {"id": "C", "text": "$45$"}, {"id": "D", "text": "$75$"}]'::jsonb,
      correct_option_id = 'D', explanation = 'This is a finite geometric sum with first term $5$ and ratio $2$:
$$\sum_{n=0}^{3} 5\cdot 2^n = 5\sum_{n=0}^{3}2^n = 5\cdot\frac{2^{4}-1}{2-1}=5(16-1)=75.$$',
      micro_explanations = '{"A": "Incorrect. That is $5(1+2+4)=35$, missing the $n=3$ term.", "B": "Incorrect. That would be the last term $5\\cdot 2^3$ only.", "C": "Incorrect. This can come from adding $5+10+30$ (skipping a term).", "D": "Correct. $5(1+2+4+8)=5\\cdot 15=75$, or $5\\cdot\\frac{2^4-1}{2-1}=75$."}'::jsonb, status = 'published',
      notes = 'Finite geometric sum with $n$ starting at 0.', updated_at = now()
    WHERE id = q_id;
  ELSE
    INSERT INTO public.questions (
      title, course, topic, topic_id, section_id, sub_topic_id, type,
      calculator_allowed, difficulty, target_time_seconds,
      prompt_type, representation_type, prompt, latex,
      options, correct_option_id, tolerance, explanation,
      micro_explanations, status, version, source, notes
    ) VALUES (
      'U10C10.2-Q10-FiniteGeometricSumFormula', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ',
      false, 2, 180,
      'text', 'symbolic', 'Compute the finite sum
$$\sum_{n=0}^{3} 5\cdot 2^n.$$

A. $35$
B. $40$
C. $45$
D. $75$', 'Compute the finite sum
$$\sum_{n=0}^{3} 5\cdot 2^n.$$

A. $35$
B. $40$
C. $45$
D. $75$',
      '[{"id": "A", "text": "$35$"}, {"id": "B", "text": "$40$"}, {"id": "C", "text": "$45$"}, {"id": "D", "text": "$75$"}]'::jsonb, 'D', 0, 'This is a finite geometric sum with first term $5$ and ratio $2$:
$$\sum_{n=0}^{3} 5\cdot 2^n = 5\sum_{n=0}^{3}2^n = 5\cdot\frac{2^{4}-1}{2-1}=5(16-1)=75.$$',
      '{"A": "Incorrect. That is $5(1+2+4)=35$, missing the $n=3$ term.", "B": "Incorrect. That would be the last term $5\\cdot 2^3$ only.", "C": "Incorrect. This can come from adding $5+10+30$ (skipping a term).", "D": "Correct. $5(1+2+4+8)=5\\cdot 15=75$, or $5\\cdot\\frac{2^4-1}{2-1}=75$."}'::jsonb, 'published', 1, 'self', 'Finite geometric sum with $n$ starting at 0.'
    ) RETURNING id INTO q_id;
  END IF;
  DELETE FROM public.question_skills WHERE question_id = q_id;
  DELETE FROM public.question_error_patterns WHERE question_id = q_id;
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'geometric_series_computation', 0.8, 'primary');
  INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES (q_id, 'algebraic_simplification', 0.2, 'supporting');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'misidentify_geometric_ratio');
  INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES (q_id, 'use_wrong_first_term_index');
END $Q$;

COMMIT;