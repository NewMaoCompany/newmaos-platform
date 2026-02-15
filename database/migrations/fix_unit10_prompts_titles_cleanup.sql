-- ============================================================
-- Fix Unit 10 Q1-Q10: Remove options from prompts, add spaces to titles,
-- delete old U10.1-P4 question
-- Run in Supabase SQL Editor
-- ============================================================
BEGIN;

-- ============================================================
-- 1. Delete old U10.1-P4 question (b4d2bc8b...)
-- ============================================================
DELETE FROM public.question_skills         WHERE question_id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
DELETE FROM public.question_error_patterns WHERE question_id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
DELETE FROM public.question_versions       WHERE question_id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
DELETE FROM public.user_question_state     WHERE question_id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
DELETE FROM public.recommendations         WHERE question_id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
DELETE FROM public.question_attempts       WHERE question_id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
DELETE FROM public.questions               WHERE id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';

-- ============================================================
-- 2. Fix prompts (remove embedded A/B/C/D) & titles (add spaces)
-- ============================================================

-- Q1
UPDATE public.questions SET
  title = 'U10 C10.1 Q1 - Definition Series Convergence By Partial Sums',
  prompt = E'Let $\\sum_{n=1}^{\\infty} a_n$ be an infinite series with partial sums $s_k=\\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\\sum_{n=1}^{\\infty} a_n$ converges?',
  updated_at = now()
WHERE id = '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1';

-- Q2
UPDATE public.questions SET
  title = 'U10 C10.1 Q2 - Sum From Explicit Partial Sum Limit',
  prompt = E'An infinite series $\\sum_{n=1}^{\\infty} a_n$ has partial sums\n$$s_k=5-\\frac{2}{k+1}.$$\nWhich statement is true?',
  updated_at = now()
WHERE id = '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a';

-- Q3
UPDATE public.questions SET
  title = 'U10 C10.1 Q3 - Divergence From Oscillating Partial Sums',
  prompt = E'A series $\\sum_{n=1}^{\\infty} a_n$ has partial sums $s_k$ given by\n$$s_k=\\begin{cases}2 & \\text{if $k$ is even}\\\\ 1 & \\text{if $k$ is odd.}\\end{cases}$$\nWhich is true?',
  updated_at = now()
WHERE id = '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7';

-- Q4
UPDATE public.questions SET
  title = 'U10 C10.1 Q4 - Identify Term Vs Partial Sum',
  prompt = E'Let $a_n=\\frac{1}{n^2}$ and $s_n=\\sum_{k=1}^{n} a_k$. Which statement is correct?',
  updated_at = now()
WHERE id = 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0';

-- Q5
UPDATE public.questions SET
  title = 'U10 C10.1 Q5 - Find Nth Term From Partial Sums Difference',
  prompt = E'A series has partial sums $s_n=\\sum_{k=1}^{n} a_k$ given by\n$$s_n=\\frac{n}{n+2}.$$\nWhat is $a_n$ for $n\\ge2$?',
  updated_at = now()
WHERE id = '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3';

-- Q6
UPDATE public.questions SET
  title = 'U10 C10.2 Q6 - Infinite Geometric Sum Basic',
  prompt = E'Evaluate the infinite series\n$$\\sum_{n=0}^{\\infty} 3\\left(\\frac{1}{4}\\right)^n.$$',
  updated_at = now()
WHERE id = 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4';

-- Q7
UPDATE public.questions SET
  title = 'U10 C10.2 Q7 - Parameter Range For Geometric Convergence',
  prompt = E'For which values of $k$ does the series\n$$\\sum_{n=1}^{\\infty} k\\left(\\frac{k}{3}\\right)^{n-1}$$\nconverge?',
  updated_at = now()
WHERE id = 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e';

-- Q8
UPDATE public.questions SET
  title = 'U10 C10.2 Q8 - Repeating Decimal To Fraction Geometric',
  prompt = E'Write $0.\\overline{36}$ as a fraction in simplest form.',
  updated_at = now()
WHERE id = '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1';

-- Q9
UPDATE public.questions SET
  title = 'U10 C10.2 Q9 - Infinite Geometric Index Shift Exact Sum',
  prompt = E'Evaluate\n$$\\sum_{n=2}^{\\infty} 5\\left(\\frac{2}{3}\\right)^n.$$',
  updated_at = now()
WHERE id = '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9';

-- Q10
UPDATE public.questions SET
  title = 'U10 C10.2 Q10 - Finite Geometric Sum Formula',
  prompt = E'Compute the finite sum\n$$\\sum_{n=0}^{3} 5\\cdot 2^n.$$',
  updated_at = now()
WHERE id = '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f';

COMMIT;

-- Verify
SELECT id, title, left(prompt, 80) AS prompt_preview
FROM public.questions
WHERE id IN (
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1','2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7','c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3','a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e','3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9','1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f'
)
ORDER BY sub_topic_id, difficulty;

-- Confirm P4 deleted
SELECT count(*) AS p4_remaining FROM public.questions WHERE id = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';
