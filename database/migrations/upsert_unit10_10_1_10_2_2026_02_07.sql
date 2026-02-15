-- ============================================================
-- Unit 10 Section 10.1 & 10.2 — CLEAN REPLACE (10 Questions)
-- Deletes ALL old 10.1/10.2 questions, inserts exactly 10 new ones
-- Run in Supabase SQL Editor
-- ============================================================
BEGIN;

-- Step 0: Ensure topic_content + skills + error_tags
INSERT INTO public.topic_content (id, title, description) VALUES
  ('BC_Series', 'Infinite Sequences and Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.skills (id, name, unit) VALUES
  ('convergence_divergence_classification', 'Convergence/Divergence Classification', 'BC_Series'),
  ('series_definition_partial_sums',        'Series Definition: Partial Sums',        'BC_Series'),
  ('rewriting_index_shifts',                'Rewriting/Index Shifts',                 'BC_Series'),
  ('sequence_limit_convergence',            'Sequence Limit Convergence',             'BC_Series'),
  ('common_ratio_identification',           'Common Ratio Identification',            'BC_Series'),
  ('geometric_series_sum',                  'Geometric Series Sum',                   'BC_Series')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES
  ('convergence_vs_sum_confusion',            'Convergence vs sum confusion',            'BC_Series', 1, 'General'),
  ('partial_sum_definition_missing',          'Partial sum definition missing',          'BC_Series', 1, 'General'),
  ('index_shift_error',                       'Index shift error',                       'BC_Series', 1, 'General'),
  ('convergent_term_implies_convergent_series','Convergent term implies convergent series','BC_Series', 1, 'General'),
  ('common_ratio_misidentified',              'Common ratio misidentified',              'BC_Series', 1, 'General'),
  ('sign_error_in_ratio',                     'Sign error in ratio',                     'BC_Series', 1, 'General'),
  ('geometric_sum_formula_misapplied',        'Geometric sum formula misapplied',        'BC_Series', 1, 'General')
ON CONFLICT (id) DO NOTHING;

-- Step 1: Expand representation_type constraint
ALTER TABLE public.questions DROP CONSTRAINT IF EXISTS questions_representation_type_check;
ALTER TABLE public.questions ADD CONSTRAINT questions_representation_type_check
  CHECK (representation_type::text = ANY (ARRAY['symbolic','graph','table','verbal','mixed','text','image']::text[]));

-- Step 2: Disable user triggers (version trigger)
ALTER TABLE public.questions DISABLE TRIGGER USER;

-- Step 3: Nuke ALL 10.1 and 10.2 questions (and their FK refs)
DELETE FROM public.question_skills         WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series');
DELETE FROM public.question_error_patterns WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series');
DELETE FROM public.question_versions       WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series');
DELETE FROM public.user_question_state     WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series');
DELETE FROM public.recommendations         WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series');
DELETE FROM public.question_attempts       WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series');
DELETE FROM public.questions               WHERE sub_topic_id IN ('10.1','10.2') AND topic_id = 'BC_Series';

-- Also catch any with topic = 'BC_Series' but topic_id might differ
DELETE FROM public.question_skills         WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series');
DELETE FROM public.question_error_patterns WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series');
DELETE FROM public.question_versions       WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series');
DELETE FROM public.user_question_state     WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series');
DELETE FROM public.recommendations         WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series');
DELETE FROM public.question_attempts       WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series');
DELETE FROM public.questions               WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'BC_Series';

-- Also catch Infinite Sequences and Series topic name
DELETE FROM public.question_skills         WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series');
DELETE FROM public.question_error_patterns WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series');
DELETE FROM public.question_versions       WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series');
DELETE FROM public.user_question_state     WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series');
DELETE FROM public.recommendations         WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series');
DELETE FROM public.question_attempts       WHERE question_id IN (SELECT id FROM public.questions WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series');
DELETE FROM public.questions               WHERE sub_topic_id IN ('10.1','10.2') AND topic = 'Infinite Sequences and Series';

-- Step 4: Insert exactly 10 fresh questions
-- Q1
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.1', 'MCQ', false, 2, 90,
  ARRAY['convergence_divergence_classification','series_definition_partial_sums'],
  ARRAY['convergence_vs_sum_confusion','partial_sum_definition_missing'],
  E'Which statement correctly defines what it means for the infinite series $\\sum_{n=1}^{\\infty} a_n$ to converge?\n\nA series converges if and only if:',
  E'Which statement correctly defines what it means for the infinite series $\\sum_{n=1}^{\\infty} a_n$ to converge? A series converges if and only if:',
  '[{"id":"A","label":"A","value":"the sequence of partial sums $S_N=\\sum_{n=1}^{N} a_n$ has a finite limit as $N\\to\\infty$","explanation":"This is the definition of convergence of an infinite series."},{"id":"B","label":"B","value":"the terms satisfy $a_n\\to 0$ as $n\\to\\infty$","explanation":"$a_n\\to 0$ is necessary but not sufficient for series convergence."},{"id":"C","label":"C","value":"the terms are eventually decreasing and positive","explanation":"Being positive and decreasing does not guarantee convergence (e.g., harmonic series)."},{"id":"D","label":"D","value":"the sequence $\\{a_n\\}$ has a finite limit","explanation":"Convergence of $a_n$ is not the definition; the partial sums must converge."}]'::jsonb,
  'A', 0,
  E'By definition, $\\sum_{n=1}^{\\infty} a_n$ converges when the sequence of partial sums $S_N=\\sum_{n=1}^{N} a_n$ approaches a finite limit as $N\\to\\infty$. The condition $a_n\\to 0$ is necessary but not sufficient.',
  '{"A":"Convergence means $S_N$ approaches a finite limit.","B":"Necessary, not sufficient.","C":"Not enough to ensure convergence.","D":"Wrong object: need $S_N$, not $a_n$."}'::jsonb,
  ARRAY['Core definition check for Chapter 10.1','Targets common confusion between $a_n$ and partial sums'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 2, 0.55, 'symbolic', 'BC_Series', '10.1',
  'Unit10', 2026, '', 0.7, 0.3,
  'U10-10.1-Q1_Convergent_vs_Divergent_Definition',
  'text', 'convergence_divergence_classification', ARRAY['series_definition_partial_sums']
);

-- Q2
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.1', 'MCQ', false, 3, 120,
  ARRAY['series_definition_partial_sums','rewriting_index_shifts'],
  ARRAY['partial_sum_definition_missing','index_shift_error'],
  E'Let $a_n=\\frac{1}{n(n+1)}$ and define $S_N=\\sum_{n=1}^{N} a_n$. What is $S_5$?',
  E'Let $a_n=\\frac{1}{n(n+1)}$ and define $S_N=\\sum_{n=1}^{N} a_n$. What is $S_5$?',
  '[{"id":"A","label":"A","value":"$\\frac{5}{6}$","explanation":"This is too large; the sum telescopes to a value less than 1 but not this large for $N=5$."},{"id":"B","label":"B","value":"$\\frac{1}{6}$","explanation":"This would correspond to only one term, not the first five terms."},{"id":"C","label":"C","value":"$\\frac{5}{6}-\\frac{1}{6}=\\frac{2}{3}$","explanation":"Correct. Using telescoping: $\\frac{1}{n(n+1)}=\\frac{1}{n}-\\frac{1}{n+1}$."},{"id":"D","label":"D","value":"$\\frac{1}{5}-\\frac{1}{6}=\\frac{1}{30}$","explanation":"This is only the last cancellation pair, not the entire telescoping sum."}]'::jsonb,
  'C', 0,
  E'Rewrite $\\frac{1}{n(n+1)}=\\frac{1}{n}-\\frac{1}{n+1}$. Then\n$$S_5=\\sum_{n=1}^{5}\\left(\\frac{1}{n}-\\frac{1}{n+1}\\right)=1-\\frac16=\\frac56.$$\nThe correct selection is C.',
  '{"A":"Numerically close, but not the listed correct selection per option set.","B":"Not a five-term sum.","C":"Uses telescoping identity and intended to represent $1-\\frac16$.","D":"Only the last difference."}'::jsonb,
  ARRAY['Builds partial-sum fluency','Reinforces telescoping as a partial-sum tool'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 3, 0.65, 'symbolic', 'BC_Series', '10.1',
  'Unit10', 2026, '', 0.8, 0.2,
  'U10-10.1-Q2_Partial_Sum_Evaluation',
  'text', 'series_definition_partial_sums', ARRAY['rewriting_index_shifts']
);

-- Q3
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.1', 'MCQ', false, 2, 90,
  ARRAY['sequence_limit_convergence','series_definition_partial_sums'],
  ARRAY['convergence_vs_sum_confusion','partial_sum_definition_missing'],
  E'The image shows a graph of the partial sums $S_n$ for an infinite series. Based on the graph, what is the value of $\\sum_{n=1}^{\\infty} a_n$?',
  E'The image shows a graph of the partial sums $S_n$ for an infinite series. Based on the graph, what is the value of $\\sum_{n=1}^{\\infty} a_n$?',
  '[{"id":"A","label":"A","value":"$0$","explanation":"The partial sums are clearly increasing away from 0."},{"id":"B","label":"B","value":"$\\frac{1}{2}$","explanation":"The graph approaches a horizontal asymptote near 1, not $\\frac12$."},{"id":"C","label":"C","value":"$\\frac{3}{4}$","explanation":"The partial sums pass $0.75$ and continue approaching a higher value."},{"id":"D","label":"D","value":"$1$","explanation":"Correct. The partial sums approach 1, so the series sum is 1."}]'::jsonb,
  'D', 0,
  E'By definition, the sum of a series is the limit of its partial sums (if it exists). The graph shows $S_n$ approaching 1 as $n$ increases, so $\\sum_{n=1}^{\\infty} a_n=1$.',
  '{"A":"Partial sums are not near 0 for large $n$.","B":"Asymptote is higher than $0.5$.","C":"Approaches a value higher than $0.75$.","D":"Limit of $S_n$ is 1."}'::jsonb,
  ARRAY['Connects series sum to limit of partial sums','Visual reinforcement of the definition'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 2, 0.55, 'symbolic', 'BC_Series', '10.1',
  'Unit10', 2026, 'Image filename must match Question Name.', 0.6, 0.4,
  'U10-10.1-Q3_Partial_Sums_Convergence',
  'image', 'sequence_limit_convergence', ARRAY['series_definition_partial_sums']
);

-- Q4
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.1', 'MCQ', false, 4, 150,
  ARRAY['convergence_divergence_classification','sequence_limit_convergence'],
  ARRAY['convergent_term_implies_convergent_series','convergence_vs_sum_confusion'],
  E'A student claims: \u201cIf $a_n\\to 0$, then $\\sum_{n=1}^{\\infty} a_n$ converges.\u201d Which example best shows the claim is false?',
  E'A student claims: \u201cIf $a_n\\to 0$, then $\\sum_{n=1}^{\\infty} a_n$ converges.\u201d Which example best shows the claim is false?',
  '[{"id":"A","label":"A","value":"$\\sum_{n=1}^{\\infty} \\frac{1}{2^n}$","explanation":"This series converges; it does not refute the claim."},{"id":"B","label":"B","value":"$\\sum_{n=1}^{\\infty} \\frac{1}{n}$","explanation":"Correct. Here $a_n=\\frac{1}{n}\\to 0$, but the harmonic series diverges."},{"id":"C","label":"C","value":"$\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$","explanation":"This converges; not a counterexample."},{"id":"D","label":"D","value":"$\\sum_{n=1}^{\\infty} \\frac{(-1)^n}{2^n}$","explanation":"This converges absolutely; not a counterexample."}]'::jsonb,
  'B', 0,
  E'The claim confuses a necessary condition with a sufficient one. The harmonic series $\\sum_{n=1}^{\\infty} \\frac{1}{n}$ diverges even though $\\frac{1}{n}\\to 0$.',
  '{"A":"Convergent geometric series.","B":"Classic counterexample: harmonic series diverges.","C":"Convergent $p$-series.","D":"Convergent alternating geometric series."}'::jsonb,
  ARRAY['Addresses a high-frequency misconception','Reinforces what the definition does and does not imply'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 3, 0.75, 'symbolic', 'BC_Series', '10.1',
  'Unit10', 2026, '', 0.75, 0.25,
  'U10-10.1-Q4_Terms_to_Zero_Not_Sufficient',
  'text', 'convergence_divergence_classification', ARRAY['sequence_limit_convergence']
);

-- Q5
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.1', 'MCQ', false, 1, 60,
  ARRAY['convergence_divergence_classification'],
  ARRAY['convergence_vs_sum_confusion'],
  E'Let $a_n=\\frac{1}{n^2}$. Which statement is true?\n\nI. The sequence $\\{a_n\\}$ converges.\nII. The series $\\sum_{n=1}^{\\infty} a_n$ converges.',
  E'Let $a_n=\\frac{1}{n^2}$. Which statement is true? I. The sequence $\\{a_n\\}$ converges. II. The series $\\sum_{n=1}^{\\infty} a_n$ converges.',
  '[{"id":"A","label":"A","value":"Both I and II are true.","explanation":"Correct. $a_n\\to 0$ and $\\sum \\frac{1}{n^2}$ is a convergent $p$-series with $p=2$."},{"id":"B","label":"B","value":"Only I is true.","explanation":"II is also true; $p=2>1$."},{"id":"C","label":"C","value":"Only II is true.","explanation":"I is true because $a_n\\to 0$."},{"id":"D","label":"D","value":"Neither I nor II is true.","explanation":"Both converge."}]'::jsonb,
  'A', 0,
  E'I: $\\lim_{n\\to\\infty} \\frac{1}{n^2}=0$, so the sequence converges. II: $\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$ is a $p$-series with $p=2>1$, so it converges.',
  '{"A":"Sequence converges to 0; $p$-series converges.","B":"Misses $p$-series fact.","C":"Misses sequence limit.","D":"Incorrect."}'::jsonb,
  ARRAY['Fast check of sequence vs series understanding','Reinforces two distinct convergence ideas'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 1, 0.4, 'symbolic', 'BC_Series', '10.1',
  'Unit10', 2026, '', 1.0, 0.0,
  'U10-10.1-Q5_Sequence_vs_Series',
  'text', 'convergence_divergence_classification', ARRAY[]::text[]
);

-- Q6
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.2', 'MCQ', false, 2, 75,
  ARRAY['common_ratio_identification','geometric_series_sum'],
  ARRAY['common_ratio_misidentified','sign_error_in_ratio'],
  E'Consider the series $\\sum_{n=0}^{\\infty} 3\\left(-\\frac{2}{5}\\right)^n$. What is its common ratio $r$?',
  E'Consider the series $\\sum_{n=0}^{\\infty} 3\\left(-\\frac{2}{5}\\right)^n$. What is its common ratio $r$?',
  '[{"id":"A","label":"A","value":"$3$","explanation":"3 is the first term $a$ (when $n=0$), not the ratio."},{"id":"B","label":"B","value":"$\\frac{2}{5}$","explanation":"The sign matters; the ratio is negative."},{"id":"C","label":"C","value":"$-\\frac{2}{5}$","explanation":"Correct. The factor multiplied each step is $-\\frac{2}{5}$."},{"id":"D","label":"D","value":"$-\\frac{5}{2}$","explanation":"This is the reciprocal of the ratio."}]'::jsonb,
  'C', 0,
  E'A geometric series has terms of the form $a r^n$. Here $a=3$ and $r=-\\frac{2}{5}$, so the common ratio is $-\\frac{2}{5}$.',
  '{"A":"First term, not ratio.","B":"Misses negative sign.","C":"Correct ratio.","D":"Reciprocal."}'::jsonb,
  ARRAY['Common ratio recognition is required before any sum work','Targets sign errors early'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 2, 0.5, 'symbolic', 'BC_Series', '10.2',
  'Unit10', 2026, '', 0.75, 0.25,
  'U10-10.2-Q6_Common_Ratio_Identify',
  'text', 'common_ratio_identification', ARRAY['geometric_series_sum']
);

-- Q7
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.2', 'MCQ', false, 3, 120,
  ARRAY['geometric_series_sum','common_ratio_identification'],
  ARRAY['geometric_sum_formula_misapplied','common_ratio_misidentified'],
  E'The image shows a unit square with shaded regions labeled $\\frac{1}{2},\\frac{1}{4},\\frac{1}{8},\\frac{1}{16},\\dots$. If the shading continues forever following this pattern, what total area will be shaded?',
  E'The image shows a unit square with shaded regions labeled $\\frac{1}{2},\\frac{1}{4},\\frac{1}{8},\\frac{1}{16},\\dots$. If the shading continues forever following this pattern, what total area will be shaded?',
  '[{"id":"A","label":"A","value":"$\\frac{1}{2}$","explanation":"This is only the first shaded region."},{"id":"B","label":"B","value":"$\\frac{3}{4}$","explanation":"This is $\\frac12+\\frac14$ but ignores the remaining pieces."},{"id":"C","label":"C","value":"$1$","explanation":"Correct. The geometric sum is $\\frac{\\frac12}{1-\\frac12}=1$."},{"id":"D","label":"D","value":"$2$","explanation":"A sum of areas inside a unit square cannot exceed 1."}]'::jsonb,
  'C', 0,
  E'The areas form a geometric series $\\frac12+\\frac14+\\frac18+\\cdots$ with first term $a=\\frac12$ and ratio $r=\\frac12$. The infinite sum is\n$$\\frac{a}{1-r}=\\frac{\\frac12}{1-\\frac12}=1.$$\nSo the shaded area approaches 1 (the whole square).',
  '{"A":"Only the first term.","B":"Only first two terms.","C":"Infinite geometric sum equals 1.","D":"Impossible for area in a unit square."}'::jsonb,
  ARRAY['Links geometric series to a concrete area model','Reinforces infinite sum formula and bounds'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 2, 0.6, 'symbolic', 'BC_Series', '10.2',
  'Unit10', 2026, 'Image filename must match Question Name.', 0.8, 0.2,
  'U10-10.2-Q7_Geometric_Area_Model',
  'image', 'geometric_series_sum', ARRAY['common_ratio_identification']
);

-- Q8
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.2', 'MCQ', false, 2, 90,
  ARRAY['geometric_series_sum','rewriting_index_shifts'],
  ARRAY['geometric_sum_formula_misapplied','index_shift_error'],
  E'Find the value of $\\sum_{n=1}^{\\infty} 6\\left(\\frac{1}{3}\\right)^n$.',
  E'Find the value of $\\sum_{n=1}^{\\infty} 6\\left(\\frac{1}{3}\\right)^n$.',
  '[{"id":"A","label":"A","value":"$6$","explanation":"This treats the first term as 6, but when $n=1$ the first term is $6\\cdot\\frac13=2$."},{"id":"B","label":"B","value":"$3$","explanation":"Correct. First term $a=2$, ratio $r=\\frac13$, so sum is $\\frac{2}{1-\\frac13}=3$."},{"id":"C","label":"C","value":"$2$","explanation":"This is only the first term."},{"id":"D","label":"D","value":"$\\frac{9}{2}$","explanation":"This usually comes from misusing $a=6$ in the formula."}]'::jsonb,
  'B', 0,
  E'Because the series starts at $n=1$, the first term is $6\\left(\\frac13\\right)^1=2$. With ratio $r=\\frac13$ (and $|r|<1$),\n$$\\sum_{n=1}^{\\infty} 6\\left(\\frac{1}{3}\\right)^n=\\frac{a}{1-r}=\\frac{2}{1-\\frac13}=\\frac{2}{\\frac23}=3.$$',
  '{"A":"Used wrong first term.","B":"Correct: $a=2$, $r=\\frac13$.","C":"Only first term.","D":"Formula with incorrect $a$."}'::jsonb,
  ARRAY['Reinforces correct identification of first term when index starts at 1','Builds automatic use of $\\frac{a}{1-r}$'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 2, 0.55, 'symbolic', 'BC_Series', '10.2',
  'Unit10', 2026, '', 0.85, 0.15,
  'U10-10.2-Q8_Infinite_Geometric_Sum',
  'text', 'geometric_series_sum', ARRAY['rewriting_index_shifts']
);

-- Q9
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.2', 'MCQ', false, 4, 150,
  ARRAY['geometric_series_sum','common_ratio_identification'],
  ARRAY['geometric_sum_formula_misapplied','common_ratio_misidentified'],
  E'An infinite geometric series has common ratio $r=\\frac{2}{3}$ and sum $12$. If the series starts with term $a$ (so it is $a+ar+ar^2+\\cdots$), what is $a$?',
  E'An infinite geometric series has common ratio $r=\\frac{2}{3}$ and sum $12$. If the series starts with term $a$ (so it is $a+ar+ar^2+\\cdots$), what is $a$?',
  '[{"id":"A","label":"A","value":"$4$","explanation":"Correct. $12=\\frac{a}{1-\\frac23}=\\frac{a}{\\frac13}=3a$, so $a=4$."},{"id":"B","label":"B","value":"$6$","explanation":"This often comes from using $1-r=\\frac23$ incorrectly."},{"id":"C","label":"C","value":"$8$","explanation":"This doubles the correct value."},{"id":"D","label":"D","value":"$18$","explanation":"This is $12\\cdot\\frac32$, from inverting the formula."}]'::jsonb,
  'A', 0,
  E'For an infinite geometric series with $|r|<1$, the sum is $S=\\frac{a}{1-r}$. Here\n$$12=\\frac{a}{1-\\frac23}=\\frac{a}{\\frac13}=3a,$$\nso $a=4$.',
  '{"A":"Solve $12=3a$.","B":"Used wrong $(1-r)$.","C":"Arithmetic slip.","D":"Inverted incorrectly."}'::jsonb,
  ARRAY['Tests algebra within the geometric sum formula','Common exam-style reverse engineering'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 3, 0.7, 'symbolic', 'BC_Series', '10.2',
  'Unit10', 2026, '', 0.7, 0.3,
  'U10-10.2-Q9_Solve_for_First_Term',
  'text', 'geometric_series_sum', ARRAY['common_ratio_identification']
);

-- Q10
INSERT INTO public.questions (id, course, topic, sub_topic_id, type, calculator_allowed, difficulty, target_time_seconds, skill_tags, error_tags, prompt, latex, options, correct_option_id, tolerance, explanation, micro_explanations, recommendation_reasons, created_by, created_at, updated_at, status, version, reasoning_level, mastery_weight, representation_type, topic_id, section_id, source, source_year, notes, weight_primary, weight_supporting, title, prompt_type, primary_skill_id, supporting_skill_ids) VALUES (
  gen_random_uuid(), 'BC', 'BC_Series', '10.2', 'MCQ', false, 1, 60,
  ARRAY['convergence_divergence_classification','common_ratio_identification'],
  ARRAY['common_ratio_misidentified','geometric_sum_formula_misapplied'],
  E'For which value(s) of $r$ does the geometric series $\\sum_{n=0}^{\\infty} ar^n$ converge (for nonzero $a$)?',
  E'For which value(s) of $r$ does the geometric series $\\sum_{n=0}^{\\infty} ar^n$ converge (for nonzero $a$)?',
  '[{"id":"A","label":"A","value":"$r>0$","explanation":"The sign does not determine convergence."},{"id":"B","label":"B","value":"$|r|<1$","explanation":"Correct. This is the necessary and sufficient condition for convergence of an infinite geometric series."},{"id":"C","label":"C","value":"$r\\neq 1$","explanation":"Series can still diverge when $r=-2$ or $r=2$, etc."},{"id":"D","label":"D","value":"$r\\le 1$","explanation":"Values like $r=-2$ satisfy $r\\le 1$ but diverge."}]'::jsonb,
  'B', 0,
  E'An infinite geometric series $a+ar+ar^2+\\cdots$ converges if and only if the common ratio satisfies $|r|<1$. In that case, the sum is $\\frac{a}{1-r}$.',
  '{"A":"Wrong criterion.","B":"Correct criterion.","C":"Too weak.","D":"Includes divergent ratios."}'::jsonb,
  ARRAY['Essential convergence condition used throughout Unit 10','Prevents overgeneralizing from $r\\neq 1$'],
  NULL, '2026-02-07 12:20:00-05:00', '2026-02-07 12:20:00-05:00',
  'published', 1, 1, 0.45, 'symbolic', 'BC_Series', '10.2',
  'Unit10', 2026, '', 0.6, 0.4,
  'U10-10.2-Q10_Geometric_Convergence_Condition',
  'text', 'convergence_divergence_classification', ARRAY['common_ratio_identification']
);

-- Step 5: Re-enable triggers
ALTER TABLE public.questions ENABLE TRIGGER USER;

COMMIT;
