-- ============================================================
-- Unit 10 Section 10.1 & 10.2 — 10 Questions (New IDs)
-- Run directly in Supabase SQL Editor
-- ============================================================
BEGIN;

-- ============================================================
-- Step 0: Ensure topic_content
-- ============================================================
INSERT INTO public.topic_content (id, title, description)
VALUES ('BC_Series', 'Infinite Sequences and Series', 'Unit 10: Infinite Sequences and Series')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- Step 1: Ensure skills
-- ============================================================
INSERT INTO public.skills (id, name, unit) VALUES
  ('sequence_and_series_definitions', 'Sequence and Series Definitions', 'BC_Series'),
  ('partial_sum_reasoning',           'Partial Sum Reasoning',           'BC_Series'),
  ('algebraic_simplification',        'Algebraic Simplification',        'BC_Series'),
  ('sigma_notation_manipulation',     'Sigma Notation Manipulation',     'BC_Series'),
  ('geometric_series_computation',    'Geometric Series Computation',    'BC_Series'),
  ('modeling_with_series',            'Modeling with Series',            'BC_Series')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- Step 2: Ensure error_tags
-- ============================================================
INSERT INTO public.error_tags (id, name, unit, severity, category) VALUES
  ('confuse_sequence_vs_series',                    'Confuse sequence vs series',                    'BC_Series', 1, 'General'),
  ('assume_limit_exists_implies_series_converges',  'Assume limit exists implies series converges',  'BC_Series', 1, 'General'),
  ('treat_divergent_series_as_having_sum',          'Treat divergent series as having sum',          'BC_Series', 1, 'General'),
  ('use_wrong_first_term_index',                    'Use wrong first term index',                    'BC_Series', 1, 'General'),
  ('misidentify_geometric_ratio',                   'Misidentify geometric ratio',                   'BC_Series', 1, 'General'),
  ('ignore_domain_of_r',                            'Ignore domain of r',                            'BC_Series', 1, 'General')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- Step 3: Clean up OLD IDs (from previous relational SQL)
--         and NEW IDs (for idempotent re-run)
-- ============================================================
DELETE FROM public.question_skills         WHERE question_id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf',
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.question_error_patterns WHERE question_id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf',
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.question_versions       WHERE question_id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf',
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.user_question_state     WHERE question_id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf',
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.recommendations         WHERE question_id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf',
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

DELETE FROM public.question_attempts       WHERE question_id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf',
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

-- Delete OLD questions
DELETE FROM public.questions WHERE id IN (
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6','f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b',
  '506b994f-5fb3-41c3-8391-c58357ae20a1','3c5a61e7-88f5-46f0-80a5-f8526569ec11',
  '2ed209be-7a0d-473b-b3b8-3f254cf47513','8c2ddb77-9a6b-4212-aec1-fb9c0f558733',
  '5e169ee0-6316-4280-a797-5682e5a61493','6a8211d0-14d6-4294-8ac3-2065b42cecad',
  '217aa340-4ef3-437a-8ea1-12a6554c40e8','cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf'
);

-- Delete NEW questions too (for idempotent re-run)
DELETE FROM public.questions WHERE id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
);

-- ============================================================
-- Step 4: Insert 10 new questions
-- ============================================================

-- Q1 – Section 10.1, Difficulty 1
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
  'BC', 'BC_Series', '10.1', 'MCQ', false, 1, 120,
  ARRAY['sequence_and_series_definitions','partial_sum_reasoning'],
  ARRAY['confuse_sequence_vs_series','assume_limit_exists_implies_series_converges'],
  E'Let $\\sum_{n=1}^{\\infty} a_n$ be an infinite series with partial sums $s_k=\\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\\sum_{n=1}^{\\infty} a_n$ converges?\n\nA. The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite.\nB. The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite.\nC. The series converges if and only if $a_n$ is decreasing for all $n$.\nD. The series converges if and only if $a_n>0$ for all $n$.',
  NULL,
  '[{"id":"A","value":"The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite."},{"id":"B","value":"The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite."},{"id":"C","value":"The series converges if and only if $a_n$ is decreasing for all $n$."},{"id":"D","value":"The series converges if and only if $a_n>0$ for all $n$."}]'::jsonb,
  'A', NULL,
  E'By definition, $\\sum_{n=1}^{\\infty} a_n$ converges exactly when the partial sums $s_k=\\sum_{n=1}^{k} a_n$ approach a finite limit, i.e., $\\lim_{k\\to\\infty} s_k$ exists and is finite.',
  '{"A":"Correct. Convergence of a series is defined by the convergence of its sequence of partial sums.","B":"Incorrect. Even if $\\lim a_n$ exists (and even if it equals 0), the series may still diverge.","C":"Incorrect. Decreasing terms do not guarantee convergence (e.g., $\\sum 1/n$).","D":"Incorrect. Many positive-term series diverge; positivity is not a defining condition."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 1, 1.00, 'symbolic', 'BC_Series', '10.1',
  'self', NULL,
  'Definition check: convergence of series via limit of partial sums.',
  0.85, 0.15,
  'U10C10.1-Q1-DefinitionSeriesConvergenceByPartialSums',
  'text', 'sequence_and_series_definitions', ARRAY['partial_sum_reasoning']
);

-- Q2 – Section 10.1, Difficulty 2
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  'BC', 'BC_Series', '10.1', 'MCQ', false, 2, 120,
  ARRAY['partial_sum_reasoning','algebraic_simplification'],
  ARRAY['treat_divergent_series_as_having_sum','assume_limit_exists_implies_series_converges'],
  E'An infinite series $\\sum_{n=1}^{\\infty} a_n$ has partial sums\n$$s_k=5-\\frac{2}{k+1}.$$\nWhich statement is true?\n\nA. The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$.\nB. The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist.\nC. The series converges and its sum is $5$.\nD. The series converges and its sum is $3$.',
  NULL,
  '[{"id":"A","value":"The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$."},{"id":"B","value":"The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist."},{"id":"C","value":"The series converges and its sum is $5$."},{"id":"D","value":"The series converges and its sum is $3$."}]'::jsonb,
  'C', NULL,
  E'A series converges to $S$ when $\\lim_{k\\to\\infty} s_k=S$. Here $s_k=5-\\frac{2}{k+1}\\to 5$, so the series converges and its sum is $5$.',
  '{"A":"Incorrect. $s_k$ approaches a finite value.","B":"Incorrect. The limit exists because $\\frac{2}{k+1}\\to 0$.","C":"Correct. $\\lim_{k\\to\\infty}\\left(5-\\frac{2}{k+1}\\right)=5$.","D":"Incorrect. The limit of the partial sums is $5$, not $3$."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 2, 1.00, 'symbolic', 'BC_Series', '10.1',
  'self', NULL,
  E'Given $s_k$, series sum is $\\lim s_k$ if finite.',
  0.80, 0.20,
  'U10C10.1-Q2-SumFromExplicitPartialSumLimit',
  'text', 'partial_sum_reasoning', ARRAY['algebraic_simplification']
);

-- Q3 – Section 10.1, Difficulty 3
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
  'BC', 'BC_Series', '10.1', 'MCQ', false, 3, 180,
  ARRAY['partial_sum_reasoning','sequence_and_series_definitions'],
  ARRAY['treat_divergent_series_as_having_sum','assume_limit_exists_implies_series_converges'],
  E'A series $\\sum_{n=1}^{\\infty} a_n$ has partial sums $s_k$ given by\n$$s_k=\\begin{cases}2 & \\text{if $k$ is even}\\\\ 1 & \\text{if $k$ is odd.}\\end{cases}$$\nWhich is true?\n\nA. The series converges to $\\frac{3}{2}$.\nB. The series converges to $2$.\nC. The series converges to $1$.\nD. The series diverges.',
  NULL,
  '[{"id":"A","value":"The series converges to $\\frac{3}{2}$."},{"id":"B","value":"The series converges to $2$."},{"id":"C","value":"The series converges to $1$."},{"id":"D","value":"The series diverges."}]'::jsonb,
  'D', NULL,
  E'Convergence requires $\\lim_{k\\to\\infty} s_k$ to exist. Since $s_k$ alternates between 1 and 2, the limit does not exist, so the series diverges.',
  '{"A":"Incorrect. Partial sums must approach a single value; alternating values do not converge.","B":"Incorrect. Odd partial sums stay at 1, so the limit cannot be 2.","C":"Incorrect. Even partial sums stay at 2, so the limit cannot be 1.","D":"Correct. The sequence $s_k$ has no limit, so the series diverges."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 3, 1.00, 'symbolic', 'BC_Series', '10.1',
  'self', NULL,
  E'Oscillation means no limit for $s_k$.',
  0.85, 0.15,
  'U10C10.1-Q3-DivergenceFromOscillatingPartialSums',
  'text', 'partial_sum_reasoning', ARRAY['sequence_and_series_definitions']
);

-- Q4 – Section 10.1, Difficulty 2
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  'BC', 'BC_Series', '10.1', 'MCQ', false, 2, 120,
  ARRAY['sequence_and_series_definitions','sigma_notation_manipulation'],
  ARRAY['confuse_sequence_vs_series','use_wrong_first_term_index'],
  E'Let $a_n=\\frac{1}{n^2}$ and $s_n=\\sum_{k=1}^{n} a_k$. Which statement is correct?\n\nA. $a_n$ is the $n$th partial sum of the series.\nB. $s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$.\nC. $\\sum_{n=1}^{\\infty} a_n$ is a sequence.\nD. $\\lim_{n\\to\\infty} s_n$ equals $a_n$.',
  NULL,
  '[{"id":"A","value":"$a_n$ is the $n$th partial sum of the series."},{"id":"B","value":"$s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$."},{"id":"C","value":"$\\sum_{n=1}^{\\infty} a_n$ is a sequence."},{"id":"D","value":"$\\lim_{n\\to\\infty} s_n$ equals $a_n$."}]'::jsonb,
  'B', NULL,
  E'A term is $a_n$. The $n$th partial sum is $s_n=\\sum_{k=1}^{n} a_k$. The infinite series is $\\sum_{n=1}^{\\infty} a_n$. Only statement B matches these definitions.',
  '{"A":"Incorrect. $a_n$ is a term of the sequence, not a partial sum.","B":"Correct. $s_n=\\sum_{k=1}^{n} a_k$ is exactly the $n$th partial sum.","C":"Incorrect. It denotes an infinite sum (a series), not a sequence.","D":"Incorrect. If $\\lim s_n$ exists, it is the series sum; $a_n$ is a single term."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 2, 1.00, 'symbolic', 'BC_Series', '10.1',
  'self', NULL,
  E'Clarify roles of $a_n$, $\\sum a_n$, and $s_n$.',
  0.90, 0.10,
  'U10C10.1-Q4-IdentifyTermVsPartialSum',
  'text', 'sequence_and_series_definitions', ARRAY['sigma_notation_manipulation']
);

-- Q5 – Section 10.1, Difficulty 4
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
  'BC', 'BC_Series', '10.1', 'MCQ', false, 4, 240,
  ARRAY['sigma_notation_manipulation','partial_sum_reasoning'],
  ARRAY['use_wrong_first_term_index','confuse_sequence_vs_series'],
  E'A series has partial sums $s_n=\\sum_{k=1}^{n} a_k$ given by\n$$s_n=\\frac{n}{n+2}.$$\nWhat is $a_n$ for $n\\ge2$?\n\nA. $a_n=\\frac{2}{(n+1)(n+2)}$\nB. $a_n=\\frac{2}{n(n+2)}$\nC. $a_n=\\frac{1}{n+2}$\nD. $a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$',
  NULL,
  '[{"id":"A","value":"$a_n=\\frac{2}{(n+1)(n+2)}$"},{"id":"B","value":"$a_n=\\frac{2}{n(n+2)}$"},{"id":"C","value":"$a_n=\\frac{1}{n+2}$"},{"id":"D","value":"$a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$"}]'::jsonb,
  'A', NULL,
  E'For $n\\ge2$, $a_n=s_n-s_{n-1}$.\n$$a_n=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{n(n+1)-(n-1)(n+2)}{(n+2)(n+1)}=\\frac{2}{(n+1)(n+2)}.$$',
  '{"A":"Correct. $a_n=s_n-s_{n-1}=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{2}{(n+1)(n+2)}$.","B":"Incorrect. This does not match the difference $\\frac{n}{n+2}-\\frac{n-1}{n+1}$.","C":"Incorrect. $a_n$ is a difference of consecutive partial sums, not $s_n$ itself.","D":"Incorrect. This equals $\\frac{1}{(n+1)(n+2)}$, missing a factor of 2."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 4, 1.00, 'symbolic', 'BC_Series', '10.1',
  'self', NULL,
  E'Use $a_n=s_n-s_{n-1}$ for $n\\ge2$.',
  0.60, 0.40,
  'U10C10.1-Q5-FindNthTermFromPartialSumsDifference',
  'text', 'sigma_notation_manipulation', ARRAY['partial_sum_reasoning']
);

-- Q6 – Section 10.2, Difficulty 1
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'BC', 'BC_Series', '10.2', 'MCQ', false, 1, 120,
  ARRAY['geometric_series_computation','algebraic_simplification'],
  ARRAY['misidentify_geometric_ratio','treat_divergent_series_as_having_sum'],
  E'Evaluate the infinite series\n$$\\sum_{n=0}^{\\infty} 3\\left(\\frac{1}{4}\\right)^n.$$\n\nA. $\\frac{3}{4}$\nB. $4$\nC. $\\frac{12}{5}$\nD. Diverges',
  NULL,
  '[{"id":"A","value":"$\\frac{3}{4}$"},{"id":"B","value":"$4$"},{"id":"C","value":"$\\frac{12}{5}$"},{"id":"D","value":"Diverges"}]'::jsonb,
  'B', NULL,
  E'This is geometric with first term $a=3$ and ratio $r=\\frac14$. Because $|r|<1$, it converges and\n$$\\sum_{n=0}^{\\infty} ar^n=\\frac{a}{1-r}=\\frac{3}{1-\\frac14}=4.$$',
  '{"A":"Incorrect. $\\frac{3}{4}$ is $ar$ (not the sum).","B":"Correct. $a=3$, $r=\\frac14$, so sum $=\\frac{3}{1-\\frac14}=4$.","C":"Incorrect. This can come from using an incorrect denominator such as $1+r$.","D":"Incorrect. Since $|r|<1$, the geometric series converges."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 1, 1.00, 'symbolic', 'BC_Series', '10.2',
  'self', NULL,
  E'Infinite geometric sum $a/(1-r)$ when $|r|<1$.',
  0.90, 0.10,
  'U10C10.2-Q6-InfiniteGeometricSumBasic',
  'text', 'geometric_series_computation', ARRAY['algebraic_simplification']
);

-- Q7 – Section 10.2, Difficulty 3
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
  'BC', 'BC_Series', '10.2', 'MCQ', false, 3, 180,
  ARRAY['geometric_series_computation','sequence_and_series_definitions'],
  ARRAY['ignore_domain_of_r','misidentify_geometric_ratio'],
  E'For which values of $k$ does the series\n$$\\sum_{n=1}^{\\infty} k\\left(\\frac{k}{3}\\right)^{n-1}$$\nconverge?\n\nA. All real $k$\nB. $|k|<3$\nC. $|k|\\le 3$\nD. $|k|>3$',
  NULL,
  '[{"id":"A","value":"All real $k$"},{"id":"B","value":"$|k|<3$"},{"id":"C","value":"$|k|\\le 3$"},{"id":"D","value":"$|k|>3$"}]'::jsonb,
  'B', NULL,
  E'At $n=1$ the term is $k$, and the common ratio is $r=\\frac{k}{3}$. An infinite geometric series converges iff $|r|<1$.\nThus $\\left|\\frac{k}{3}\\right|<1\\Rightarrow |k|<3$.',
  '{"A":"Incorrect. Convergence depends on the common ratio $r=\\frac{k}{3}$.","B":"Correct. The series is geometric with ratio $r=\\frac{k}{3}$, so it converges iff $|r|<1$, i.e. $|k|<3$.","C":"Incorrect. If $|k|=3$, then $|r|=1$ and the geometric series does not converge.","D":"Incorrect. If $|k|>3$, then $|r|>1$ and the terms do not approach 0."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 3, 1.00, 'symbolic', 'BC_Series', '10.2',
  'self', NULL,
  'Use $|r|<1$ with $r=k/3$.',
  0.75, 0.25,
  'U10C10.2-Q7-ParameterRangeForGeometricConvergence',
  'text', 'geometric_series_computation', ARRAY['sequence_and_series_definitions']
);

-- Q8 – Section 10.2, Difficulty 2
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  'BC', 'BC_Series', '10.2', 'MCQ', false, 2, 180,
  ARRAY['modeling_with_series','geometric_series_computation'],
  ARRAY['misidentify_geometric_ratio','use_wrong_first_term_index'],
  E'Write $0.\\overline{36}$ as a fraction in simplest form.\n\nA. $\\frac{9}{25}$\nB. $\\frac{12}{25}$\nC. $\\frac{4}{11}$\nD. $\\frac{36}{99}$',
  NULL,
  '[{"id":"A","value":"$\\frac{9}{25}$"},{"id":"B","value":"$\\frac{12}{25}$"},{"id":"C","value":"$\\frac{4}{11}$"},{"id":"D","value":"$\\frac{36}{99}$"}]'::jsonb,
  'C', NULL,
  E'Interpret as a geometric series:\n$$0.\\overline{36}=0.36+0.0036+0.000036+\\cdots$$\nThis has $a=0.36$ and $r=0.01$, so\n$$\\frac{a}{1-r}=\\frac{0.36}{0.99}=\\frac{36}{99}=\\frac{4}{11}.$$',
  '{"A":"Incorrect. $\\frac{9}{25}=0.36$ (terminating), not $0.\\overline{36}$.","B":"Incorrect. $\\frac{12}{25}=0.48$.","C":"Correct. $0.\\overline{36}=\\frac{36}{99}=\\frac{4}{11}$.","D":"Incorrect. This equals the value but is not simplified."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 2, 1.00, 'symbolic', 'BC_Series', '10.2',
  'self', NULL,
  'Represent repeating decimal as infinite geometric series.',
  0.60, 0.40,
  'U10C10.2-Q8-RepeatingDecimalToFractionGeometric',
  'text', 'modeling_with_series', ARRAY['geometric_series_computation']
);

-- Q9 – Section 10.2, Difficulty 4
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
  'BC', 'BC_Series', '10.2', 'MCQ', false, 4, 240,
  ARRAY['geometric_series_computation','sigma_notation_manipulation'],
  ARRAY['use_wrong_first_term_index','misidentify_geometric_ratio'],
  E'Evaluate\n$$\\sum_{n=2}^{\\infty} 5\\left(\\frac{2}{3}\\right)^n.$$\n\nA. $\\frac{20}{3}$\nB. $\\frac{10}{3}$\nC. $\\frac{20}{9}$\nD. Diverges',
  NULL,
  '[{"id":"A","value":"$\\frac{20}{3}$"},{"id":"B","value":"$\\frac{10}{3}$"},{"id":"C","value":"$\\frac{20}{9}$"},{"id":"D","value":"Diverges"}]'::jsonb,
  'A', NULL,
  E'Factor out 5 and identify the first term at $n=2$:\n$$\\sum_{n=2}^{\\infty} 5\\left(\\frac{2}{3}\\right)^n = 5\\sum_{n=2}^{\\infty}\\left(\\frac{2}{3}\\right)^n.$$\nFirst term is $\\left(\\frac{2}{3}\\right)^2=\\frac{4}{9}$, ratio is $\\frac{2}{3}$, so\n$$5\\cdot\\frac{\\frac{4}{9}}{1-\\frac{2}{3}}=5\\cdot\\frac{\\frac{4}{9}}{\\frac{1}{3}}=5\\cdot\\frac{4}{3}=\\frac{20}{3}.$$',
  '{"A":"Correct. It is geometric with first term $5\\left(\\frac{2}{3}\\right)^2=\\frac{20}{9}$ and ratio $\\frac{2}{3}$, so sum $=\\frac{\\frac{20}{9}}{1-\\frac{2}{3}}=\\frac{20}{3}$.","B":"Incorrect. This often comes from using $5\\left(\\frac{2}{3}\\right)^1$ as the first term or dropping a factor of 2.","C":"Incorrect. $\\frac{20}{9}$ is the first term (at $n=2$), not the sum to infinity.","D":"Incorrect. Since $\\left|\\frac{2}{3}\\right|<1$, the geometric series converges."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 4, 1.00, 'symbolic', 'BC_Series', '10.2',
  'self', NULL,
  E'Starts at $n=2$: first term must be evaluated at $n=2$.',
  0.70, 0.30,
  'U10C10.2-Q9-InfiniteGeometricIndexShiftExactSum',
  'text', 'geometric_series_computation', ARRAY['sigma_notation_manipulation']
);

-- Q10 – Section 10.2, Difficulty 2
INSERT INTO public.questions (
  id, course, topic, sub_topic_id, type, calculator_allowed, difficulty,
  target_time_seconds, skill_tags, error_tags, prompt, latex, options,
  correct_option_id, tolerance, explanation, micro_explanations,
  recommendation_reasons, created_by, created_at, updated_at, status, version,
  reasoning_level, mastery_weight, representation_type, topic_id, section_id,
  source, source_year, notes, weight_primary, weight_supporting, title,
  prompt_type, primary_skill_id, supporting_skill_ids
) VALUES (
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f',
  'BC', 'BC_Series', '10.2', 'MCQ', false, 2, 180,
  ARRAY['geometric_series_computation','algebraic_simplification'],
  ARRAY['misidentify_geometric_ratio','use_wrong_first_term_index'],
  E'Compute the finite sum\n$$\\sum_{n=0}^{3} 5\\cdot 2^n.$$\n\nA. $35$\nB. $40$\nC. $45$\nD. $75$',
  NULL,
  '[{"id":"A","value":"$35$"},{"id":"B","value":"$40$"},{"id":"C","value":"$45$"},{"id":"D","value":"$75$"}]'::jsonb,
  'D', NULL,
  E'This is a finite geometric sum with first term $5$ and ratio $2$:\n$$\\sum_{n=0}^{3} 5\\cdot 2^n = 5\\sum_{n=0}^{3}2^n = 5\\cdot\\frac{2^{4}-1}{2-1}=5(16-1)=75.$$',
  '{"A":"Incorrect. That is $5(1+2+4)=35$, missing the $n=3$ term.","B":"Incorrect. That would be the last term $5\\cdot 2^3$ only.","C":"Incorrect. This can come from adding $5+10+30$ (skipping a term).","D":"Correct. $5(1+2+4+8)=5\\cdot 15=75$, or $5\\cdot\\frac{2^4-1}{2-1}=75$."}'::jsonb,
  ARRAY[]::text[], NULL, '2026-02-06 23:00:00+00', '2026-02-06 23:00:00+00',
  'published', 1, 2, 1.00, 'symbolic', 'BC_Series', '10.2',
  'self', NULL,
  'Finite geometric sum with $n$ starting at 0.',
  0.80, 0.20,
  'U10C10.2-Q10-FiniteGeometricSumFormula',
  'text', 'geometric_series_computation', ARRAY['algebraic_simplification']
);

-- ============================================================
-- Step 5: Insert question_skills (20 rows: 2 per question)
-- ============================================================
INSERT INTO public.question_skills (question_id, skill_id, weight, role) VALUES
  -- Q1
  ('0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', 'sequence_and_series_definitions', 0.85, 'primary'),
  ('0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', 'partial_sum_reasoning',           0.15, 'supporting'),
  -- Q2
  ('2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', 'partial_sum_reasoning',           0.80, 'primary'),
  ('2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', 'algebraic_simplification',        0.20, 'supporting'),
  -- Q3
  ('7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', 'partial_sum_reasoning',           0.85, 'primary'),
  ('7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', 'sequence_and_series_definitions', 0.15, 'supporting'),
  -- Q4
  ('c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', 'sequence_and_series_definitions', 0.90, 'primary'),
  ('c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', 'sigma_notation_manipulation',     0.10, 'supporting'),
  -- Q5
  ('5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', 'sigma_notation_manipulation',     0.60, 'primary'),
  ('5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', 'partial_sum_reasoning',           0.40, 'supporting'),
  -- Q6
  ('a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', 'geometric_series_computation',    0.90, 'primary'),
  ('a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', 'algebraic_simplification',        0.10, 'supporting'),
  -- Q7
  ('e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', 'geometric_series_computation',    0.75, 'primary'),
  ('e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', 'sequence_and_series_definitions', 0.25, 'supporting'),
  -- Q8
  ('3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', 'modeling_with_series',            0.60, 'primary'),
  ('3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', 'geometric_series_computation',    0.40, 'supporting'),
  -- Q9
  ('8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', 'geometric_series_computation',    0.70, 'primary'),
  ('8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', 'sigma_notation_manipulation',     0.30, 'supporting'),
  -- Q10
  ('1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', 'geometric_series_computation',    0.80, 'primary'),
  ('1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', 'algebraic_simplification',        0.20, 'supporting');

-- ============================================================
-- Step 6: Insert question_error_patterns (20 rows: 2 per question)
-- ============================================================
INSERT INTO public.question_error_patterns (question_id, error_tag_id) VALUES
  -- Q1
  ('0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', 'confuse_sequence_vs_series'),
  ('0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', 'assume_limit_exists_implies_series_converges'),
  -- Q2
  ('2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', 'treat_divergent_series_as_having_sum'),
  ('2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', 'assume_limit_exists_implies_series_converges'),
  -- Q3
  ('7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', 'treat_divergent_series_as_having_sum'),
  ('7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', 'assume_limit_exists_implies_series_converges'),
  -- Q4
  ('c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', 'confuse_sequence_vs_series'),
  ('c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', 'use_wrong_first_term_index'),
  -- Q5
  ('5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', 'use_wrong_first_term_index'),
  ('5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', 'confuse_sequence_vs_series'),
  -- Q6
  ('a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', 'misidentify_geometric_ratio'),
  ('a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', 'treat_divergent_series_as_having_sum'),
  -- Q7
  ('e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', 'ignore_domain_of_r'),
  ('e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', 'misidentify_geometric_ratio'),
  -- Q8
  ('3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', 'misidentify_geometric_ratio'),
  ('3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', 'use_wrong_first_term_index'),
  -- Q9
  ('8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', 'use_wrong_first_term_index'),
  ('8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', 'misidentify_geometric_ratio'),
  -- Q10
  ('1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', 'misidentify_geometric_ratio'),
  ('1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', 'use_wrong_first_term_index');

COMMIT;

-- ============================================================
-- Verify
-- ============================================================
SELECT id, sub_topic_id, difficulty, status, title
FROM public.questions
WHERE id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
)
ORDER BY sub_topic_id, difficulty;
