/**
 * Upsert Unit 10 Questions (10.1 & 10.2) - New IDs
 * 
 * This script:
 * 1. Ensures dependencies (skills, error_tags, topic_content) exist
 * 2. Deletes old question relationships and old questions (by old IDs)
 * 3. Upserts 10 new questions with new IDs
 * 4. Recreates question_skills and question_error_patterns
 */

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://xzpjlnkirboevkjzitcx.supabase.co';
const SUPABASE_SERVICE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODUyNzU2NiwiZXhwIjoyMDg0MTAzNTY2fQ.8Ucl0sH8m0ZW6HFxnkNAXtWmdzFfLpJ-Fw22oNpTU2I';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// ============================================================
// Old IDs (from unit10_relational_questions.sql) to clean up
// ============================================================
const OLD_IDS = [
  'c4fcc3e6-5d54-46bf-8cce-de473e19ebd6', // Q1
  'f6e6fd46-cd9a-44ad-9f8a-4fc135e1112b', // Q2
  '506b994f-5fb3-41c3-8391-c58357ae20a1', // Q3
  '3c5a61e7-88f5-46f0-80a5-f8526569ec11', // Q4
  '2ed209be-7a0d-473b-b3b8-3f254cf47513', // Q5
  '8c2ddb77-9a6b-4212-aec1-fb9c0f558733', // Q6
  '5e169ee0-6316-4280-a797-5682e5a61493', // Q7
  '6a8211d0-14d6-4294-8ac3-2065b42cecad', // Q8
  '217aa340-4ef3-437a-8ea1-12a6554c40e8', // Q9
  'cc5c3e35-bda4-45f7-b7e4-f7b2c30e6ecf', // Q10
];

// ============================================================
// New IDs
// ============================================================
const NEW_IDS = [
  '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', // Q1
  '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', // Q2
  '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', // Q3
  'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', // Q4
  '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', // Q5
  'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', // Q6
  'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', // Q7
  '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', // Q8
  '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', // Q9
  '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', // Q10
];

const ALL_IDS = [...OLD_IDS, ...NEW_IDS];

// ============================================================
// Dependencies
// ============================================================
const SKILLS = [
  { id: 'sequence_and_series_definitions', name: 'Sequence and Series Definitions', unit: 'BC_Series' },
  { id: 'partial_sum_reasoning', name: 'Partial Sum Reasoning', unit: 'BC_Series' },
  { id: 'algebraic_simplification', name: 'Algebraic Simplification', unit: 'BC_Series' },
  { id: 'sigma_notation_manipulation', name: 'Sigma Notation Manipulation', unit: 'BC_Series' },
  { id: 'geometric_series_computation', name: 'Geometric Series Computation', unit: 'BC_Series' },
  { id: 'modeling_with_series', name: 'Modeling with Series', unit: 'BC_Series' },
];

const ERROR_TAGS = [
  { id: 'confuse_sequence_vs_series', name: 'Confuse sequence vs series', unit: 'BC_Series', severity: 1, category: 'General' },
  { id: 'assume_limit_exists_implies_series_converges', name: 'Assume limit exists implies series converges', unit: 'BC_Series', severity: 1, category: 'General' },
  { id: 'treat_divergent_series_as_having_sum', name: 'Treat divergent series as having sum', unit: 'BC_Series', severity: 1, category: 'General' },
  { id: 'use_wrong_first_term_index', name: 'Use wrong first term index', unit: 'BC_Series', severity: 1, category: 'General' },
  { id: 'misidentify_geometric_ratio', name: 'Misidentify geometric ratio', unit: 'BC_Series', severity: 1, category: 'General' },
  { id: 'ignore_domain_of_r', name: 'Ignore domain of r', unit: 'BC_Series', severity: 1, category: 'General' },
];

// ============================================================
// 10 New Questions
// ============================================================
const QUESTIONS = [
  {
    id: '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.1', type: 'MCQ',
    calculator_allowed: false, difficulty: 1, target_time_seconds: 120,
    skill_tags: ['sequence_and_series_definitions', 'partial_sum_reasoning'],
    error_tags: ['confuse_sequence_vs_series', 'assume_limit_exists_implies_series_converges'],
    prompt: 'Let $\\sum_{n=1}^{\\infty} a_n$ be an infinite series with partial sums $s_k=\\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\\sum_{n=1}^{\\infty} a_n$ converges?\n\nA. The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite.\nB. The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite.\nC. The series converges if and only if $a_n$ is decreasing for all $n$.\nD. The series converges if and only if $a_n>0$ for all $n$.',
    latex: null,
    options: [
      { id: 'A', value: 'The series converges if and only if $\\lim_{k\\to\\infty} s_k$ exists and is finite.' },
      { id: 'B', value: 'The series converges if and only if $\\lim_{n\\to\\infty} a_n$ exists and is finite.' },
      { id: 'C', value: 'The series converges if and only if $a_n$ is decreasing for all $n$.' },
      { id: 'D', value: 'The series converges if and only if $a_n>0$ for all $n$.' }
    ],
    correct_option_id: 'A', tolerance: null,
    explanation: 'By definition, $\\sum_{n=1}^{\\infty} a_n$ converges exactly when the partial sums $s_k=\\sum_{n=1}^{k} a_n$ approach a finite limit, i.e., $\\lim_{k\\to\\infty} s_k$ exists and is finite.',
    micro_explanations: {
      A: 'Correct. Convergence of a series is defined by the convergence of its sequence of partial sums.',
      B: 'Incorrect. Even if $\\lim a_n$ exists (and even if it equals 0), the series may still diverge.',
      C: 'Incorrect. Decreasing terms do not guarantee convergence (e.g., $\\sum 1/n$).',
      D: 'Incorrect. Many positive-term series diverge; positivity is not a defining condition.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 1, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.1',
    source: 'self', source_year: null,
    notes: 'Definition check: convergence of series via limit of partial sums.',
    weight_primary: 0.85, weight_supporting: 0.15,
    title: 'U10C10.1-Q1-DefinitionSeriesConvergenceByPartialSums',
    prompt_type: 'text',
    primary_skill_id: 'sequence_and_series_definitions',
    supporting_skill_ids: ['partial_sum_reasoning'],
  },
  {
    id: '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.1', type: 'MCQ',
    calculator_allowed: false, difficulty: 2, target_time_seconds: 120,
    skill_tags: ['partial_sum_reasoning', 'algebraic_simplification'],
    error_tags: ['treat_divergent_series_as_having_sum', 'assume_limit_exists_implies_series_converges'],
    prompt: 'An infinite series $\\sum_{n=1}^{\\infty} a_n$ has partial sums\n$$s_k=5-\\frac{2}{k+1}.$$\nWhich statement is true?\n\nA. The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$.\nB. The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist.\nC. The series converges and its sum is $5$.\nD. The series converges and its sum is $3$.',
    latex: null,
    options: [
      { id: 'A', value: 'The series diverges because $\\lim_{k\\to\\infty} s_k=\\infty$.' },
      { id: 'B', value: 'The series diverges because $\\lim_{k\\to\\infty} s_k$ does not exist.' },
      { id: 'C', value: 'The series converges and its sum is $5$.' },
      { id: 'D', value: 'The series converges and its sum is $3$.' }
    ],
    correct_option_id: 'C', tolerance: null,
    explanation: 'A series converges to $S$ when $\\lim_{k\\to\\infty} s_k=S$. Here $s_k=5-\\frac{2}{k+1}\\to 5$, so the series converges and its sum is $5$.',
    micro_explanations: {
      A: 'Incorrect. $s_k$ approaches a finite value.',
      B: 'Incorrect. The limit exists because $\\frac{2}{k+1}\\to 0$.',
      C: 'Correct. $\\lim_{k\\to\\infty}\\left(5-\\frac{2}{k+1}\\right)=5$.',
      D: 'Incorrect. The limit of the partial sums is $5$, not $3$.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 2, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.1',
    source: 'self', source_year: null,
    notes: 'Given $s_k$, series sum is $\\lim s_k$ if finite.',
    weight_primary: 0.80, weight_supporting: 0.20,
    title: 'U10C10.1-Q2-SumFromExplicitPartialSumLimit',
    prompt_type: 'text',
    primary_skill_id: 'partial_sum_reasoning',
    supporting_skill_ids: ['algebraic_simplification'],
  },
  {
    id: '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.1', type: 'MCQ',
    calculator_allowed: false, difficulty: 3, target_time_seconds: 180,
    skill_tags: ['partial_sum_reasoning', 'sequence_and_series_definitions'],
    error_tags: ['treat_divergent_series_as_having_sum', 'assume_limit_exists_implies_series_converges'],
    prompt: 'A series $\\sum_{n=1}^{\\infty} a_n$ has partial sums $s_k$ given by\n$$s_k=\\begin{cases}2 & \\text{if $k$ is even}\\\\ 1 & \\text{if $k$ is odd.}\\end{cases}$$\nWhich is true?\n\nA. The series converges to $\\frac{3}{2}$.\nB. The series converges to $2$.\nC. The series converges to $1$.\nD. The series diverges.',
    latex: null,
    options: [
      { id: 'A', value: 'The series converges to $\\frac{3}{2}$.' },
      { id: 'B', value: 'The series converges to $2$.' },
      { id: 'C', value: 'The series converges to $1$.' },
      { id: 'D', value: 'The series diverges.' }
    ],
    correct_option_id: 'D', tolerance: null,
    explanation: 'Convergence requires $\\lim_{k\\to\\infty} s_k$ to exist. Since $s_k$ alternates between 1 and 2, the limit does not exist, so the series diverges.',
    micro_explanations: {
      A: 'Incorrect. Partial sums must approach a single value; alternating values do not converge.',
      B: 'Incorrect. Odd partial sums stay at 1, so the limit cannot be 2.',
      C: 'Incorrect. Even partial sums stay at 2, so the limit cannot be 1.',
      D: 'Correct. The sequence $s_k$ has no limit, so the series diverges.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 3, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.1',
    source: 'self', source_year: null,
    notes: 'Oscillation means no limit for $s_k$.',
    weight_primary: 0.85, weight_supporting: 0.15,
    title: 'U10C10.1-Q3-DivergenceFromOscillatingPartialSums',
    prompt_type: 'text',
    primary_skill_id: 'partial_sum_reasoning',
    supporting_skill_ids: ['sequence_and_series_definitions'],
  },
  {
    id: 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.1', type: 'MCQ',
    calculator_allowed: false, difficulty: 2, target_time_seconds: 120,
    skill_tags: ['sequence_and_series_definitions', 'sigma_notation_manipulation'],
    error_tags: ['confuse_sequence_vs_series', 'use_wrong_first_term_index'],
    prompt: 'Let $a_n=\\frac{1}{n^2}$ and $s_n=\\sum_{k=1}^{n} a_k$. Which statement is correct?\n\nA. $a_n$ is the $n$th partial sum of the series.\nB. $s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$.\nC. $\\sum_{n=1}^{\\infty} a_n$ is a sequence.\nD. $\\lim_{n\\to\\infty} s_n$ equals $a_n$.',
    latex: null,
    options: [
      { id: 'A', value: '$a_n$ is the $n$th partial sum of the series.' },
      { id: 'B', value: '$s_n$ is the $n$th partial sum of the series $\\sum_{n=1}^{\\infty} a_n$.' },
      { id: 'C', value: '$\\sum_{n=1}^{\\infty} a_n$ is a sequence.' },
      { id: 'D', value: '$\\lim_{n\\to\\infty} s_n$ equals $a_n$.' }
    ],
    correct_option_id: 'B', tolerance: null,
    explanation: 'A term is $a_n$. The $n$th partial sum is $s_n=\\sum_{k=1}^{n} a_k$. The infinite series is $\\sum_{n=1}^{\\infty} a_n$. Only statement B matches these definitions.',
    micro_explanations: {
      A: 'Incorrect. $a_n$ is a term of the sequence, not a partial sum.',
      B: 'Correct. $s_n=\\sum_{k=1}^{n} a_k$ is exactly the $n$th partial sum.',
      C: 'Incorrect. It denotes an infinite sum (a series), not a sequence.',
      D: 'Incorrect. If $\\lim s_n$ exists, it is the series sum; $a_n$ is a single term.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 2, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.1',
    source: 'self', source_year: null,
    notes: 'Clarify roles of $a_n$, $\\sum a_n$, and $s_n$.',
    weight_primary: 0.90, weight_supporting: 0.10,
    title: 'U10C10.1-Q4-IdentifyTermVsPartialSum',
    prompt_type: 'text',
    primary_skill_id: 'sequence_and_series_definitions',
    supporting_skill_ids: ['sigma_notation_manipulation'],
  },
  {
    id: '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.1', type: 'MCQ',
    calculator_allowed: false, difficulty: 4, target_time_seconds: 240,
    skill_tags: ['sigma_notation_manipulation', 'partial_sum_reasoning'],
    error_tags: ['use_wrong_first_term_index', 'confuse_sequence_vs_series'],
    prompt: 'A series has partial sums $s_n=\\sum_{k=1}^{n} a_k$ given by\n$$s_n=\\frac{n}{n+2}.$$\nWhat is $a_n$ for $n\\ge2$?\n\nA. $a_n=\\frac{2}{(n+1)(n+2)}$\nB. $a_n=\\frac{2}{n(n+2)}$\nC. $a_n=\\frac{1}{n+2}$\nD. $a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$',
    latex: null,
    options: [
      { id: 'A', value: '$a_n=\\frac{2}{(n+1)(n+2)}$' },
      { id: 'B', value: '$a_n=\\frac{2}{n(n+2)}$' },
      { id: 'C', value: '$a_n=\\frac{1}{n+2}$' },
      { id: 'D', value: '$a_n=\\frac{1}{n+1}-\\frac{1}{n+2}$' }
    ],
    correct_option_id: 'A', tolerance: null,
    explanation: 'For $n\\ge2$, $a_n=s_n-s_{n-1}$.\n$$a_n=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{n(n+1)-(n-1)(n+2)}{(n+2)(n+1)}=\\frac{2}{(n+1)(n+2)}.$$',
    micro_explanations: {
      A: 'Correct. $a_n=s_n-s_{n-1}=\\frac{n}{n+2}-\\frac{n-1}{n+1}=\\frac{2}{(n+1)(n+2)}$.',
      B: 'Incorrect. This does not match the difference $\\frac{n}{n+2}-\\frac{n-1}{n+1}$.',
      C: 'Incorrect. $a_n$ is a difference of consecutive partial sums, not $s_n$ itself.',
      D: 'Incorrect. This equals $\\frac{1}{(n+1)(n+2)}$, missing a factor of 2.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 4, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.1',
    source: 'self', source_year: null,
    notes: 'Use $a_n=s_n-s_{n-1}$ for $n\\ge2$.',
    weight_primary: 0.60, weight_supporting: 0.40,
    title: 'U10C10.1-Q5-FindNthTermFromPartialSumsDifference',
    prompt_type: 'text',
    primary_skill_id: 'sigma_notation_manipulation',
    supporting_skill_ids: ['partial_sum_reasoning'],
  },
  {
    id: 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.2', type: 'MCQ',
    calculator_allowed: false, difficulty: 1, target_time_seconds: 120,
    skill_tags: ['geometric_series_computation', 'algebraic_simplification'],
    error_tags: ['misidentify_geometric_ratio', 'treat_divergent_series_as_having_sum'],
    prompt: 'Evaluate the infinite series\n$$\\sum_{n=0}^{\\infty} 3\\left(\\frac{1}{4}\\right)^n.$$\n\nA. $\\frac{3}{4}$\nB. $4$\nC. $\\frac{12}{5}$\nD. Diverges',
    latex: null,
    options: [
      { id: 'A', value: '$\\frac{3}{4}$' },
      { id: 'B', value: '$4$' },
      { id: 'C', value: '$\\frac{12}{5}$' },
      { id: 'D', value: 'Diverges' }
    ],
    correct_option_id: 'B', tolerance: null,
    explanation: 'This is geometric with first term $a=3$ and ratio $r=\\frac14$. Because $|r|<1$, it converges and\n$$\\sum_{n=0}^{\\infty} ar^n=\\frac{a}{1-r}=\\frac{3}{1-\\frac14}=4.$$',
    micro_explanations: {
      A: 'Incorrect. $\\frac{3}{4}$ is $ar$ (not the sum).',
      B: 'Correct. $a=3$, $r=\\frac14$, so sum $=\\frac{3}{1-\\frac14}=4$.',
      C: 'Incorrect. This can come from using an incorrect denominator such as $1+r$.',
      D: 'Incorrect. Since $|r|<1$, the geometric series converges.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 1, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.2',
    source: 'self', source_year: null,
    notes: 'Infinite geometric sum $a/(1-r)$ when $|r|<1$.',
    weight_primary: 0.90, weight_supporting: 0.10,
    title: 'U10C10.2-Q6-InfiniteGeometricSumBasic',
    prompt_type: 'text',
    primary_skill_id: 'geometric_series_computation',
    supporting_skill_ids: ['algebraic_simplification'],
  },
  {
    id: 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.2', type: 'MCQ',
    calculator_allowed: false, difficulty: 3, target_time_seconds: 180,
    skill_tags: ['geometric_series_computation', 'sequence_and_series_definitions'],
    error_tags: ['ignore_domain_of_r', 'misidentify_geometric_ratio'],
    prompt: 'For which values of $k$ does the series\n$$\\sum_{n=1}^{\\infty} k\\left(\\frac{k}{3}\\right)^{n-1}$$\nconverge?\n\nA. All real $k$\nB. $|k|<3$\nC. $|k|\\le 3$\nD. $|k|>3$',
    latex: null,
    options: [
      { id: 'A', value: 'All real $k$' },
      { id: 'B', value: '$|k|<3$' },
      { id: 'C', value: '$|k|\\le 3$' },
      { id: 'D', value: '$|k|>3$' }
    ],
    correct_option_id: 'B', tolerance: null,
    explanation: 'At $n=1$ the term is $k$, and the common ratio is $r=\\frac{k}{3}$. An infinite geometric series converges iff $|r|<1$.\nThus $\\left|\\frac{k}{3}\\right|<1\\Rightarrow |k|<3$.',
    micro_explanations: {
      A: 'Incorrect. Convergence depends on the common ratio $r=\\frac{k}{3}$.',
      B: 'Correct. The series is geometric with ratio $r=\\frac{k}{3}$, so it converges iff $|r|<1$, i.e. $|k|<3$.',
      C: 'Incorrect. If $|k|=3$, then $|r|=1$ and the geometric series does not converge.',
      D: 'Incorrect. If $|k|>3$, then $|r|>1$ and the terms do not approach 0.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 3, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.2',
    source: 'self', source_year: null,
    notes: 'Use $|r|<1$ with $r=k/3$.',
    weight_primary: 0.75, weight_supporting: 0.25,
    title: 'U10C10.2-Q7-ParameterRangeForGeometricConvergence',
    prompt_type: 'text',
    primary_skill_id: 'geometric_series_computation',
    supporting_skill_ids: ['sequence_and_series_definitions'],
  },
  {
    id: '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.2', type: 'MCQ',
    calculator_allowed: false, difficulty: 2, target_time_seconds: 180,
    skill_tags: ['modeling_with_series', 'geometric_series_computation'],
    error_tags: ['misidentify_geometric_ratio', 'use_wrong_first_term_index'],
    prompt: 'Write $0.\\overline{36}$ as a fraction in simplest form.\n\nA. $\\frac{9}{25}$\nB. $\\frac{12}{25}$\nC. $\\frac{4}{11}$\nD. $\\frac{36}{99}$',
    latex: null,
    options: [
      { id: 'A', value: '$\\frac{9}{25}$' },
      { id: 'B', value: '$\\frac{12}{25}$' },
      { id: 'C', value: '$\\frac{4}{11}$' },
      { id: 'D', value: '$\\frac{36}{99}$' }
    ],
    correct_option_id: 'C', tolerance: null,
    explanation: 'Interpret as a geometric series:\n$$0.\\overline{36}=0.36+0.0036+0.000036+\\cdots$$\nThis has $a=0.36$ and $r=0.01$, so\n$$\\frac{a}{1-r}=\\frac{0.36}{0.99}=\\frac{36}{99}=\\frac{4}{11}.$$',
    micro_explanations: {
      A: 'Incorrect. $\\frac{9}{25}=0.36$ (terminating), not $0.\\overline{36}$.',
      B: 'Incorrect. $\\frac{12}{25}=0.48$.',
      C: 'Correct. $0.\\overline{36}=\\frac{36}{99}=\\frac{4}{11}$.',
      D: 'Incorrect. This equals the value but is not simplified.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 2, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.2',
    source: 'self', source_year: null,
    notes: 'Represent repeating decimal as infinite geometric series.',
    weight_primary: 0.60, weight_supporting: 0.40,
    title: 'U10C10.2-Q8-RepeatingDecimalToFractionGeometric',
    prompt_type: 'text',
    primary_skill_id: 'modeling_with_series',
    supporting_skill_ids: ['geometric_series_computation'],
  },
  {
    id: '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.2', type: 'MCQ',
    calculator_allowed: false, difficulty: 4, target_time_seconds: 240,
    skill_tags: ['geometric_series_computation', 'sigma_notation_manipulation'],
    error_tags: ['use_wrong_first_term_index', 'misidentify_geometric_ratio'],
    prompt: 'Evaluate\n$$\\sum_{n=2}^{\\infty} 5\\left(\\frac{2}{3}\\right)^n.$$\n\nA. $\\frac{20}{3}$\nB. $\\frac{10}{3}$\nC. $\\frac{20}{9}$\nD. Diverges',
    latex: null,
    options: [
      { id: 'A', value: '$\\frac{20}{3}$' },
      { id: 'B', value: '$\\frac{10}{3}$' },
      { id: 'C', value: '$\\frac{20}{9}$' },
      { id: 'D', value: 'Diverges' }
    ],
    correct_option_id: 'A', tolerance: null,
    explanation: 'Factor out 5 and identify the first term at $n=2$:\n$$\\sum_{n=2}^{\\infty} 5\\left(\\frac{2}{3}\\right)^n = 5\\sum_{n=2}^{\\infty}\\left(\\frac{2}{3}\\right)^n.$$\nFirst term is $\\left(\\frac{2}{3}\\right)^2=\\frac{4}{9}$, ratio is $\\frac{2}{3}$, so\n$$5\\cdot\\frac{\\frac{4}{9}}{1-\\frac{2}{3}}=5\\cdot\\frac{\\frac{4}{9}}{\\frac{1}{3}}=5\\cdot\\frac{4}{3}=\\frac{20}{3}.$$',
    micro_explanations: {
      A: 'Correct. It is geometric with first term $5\\left(\\frac{2}{3}\\right)^2=\\frac{20}{9}$ and ratio $\\frac{2}{3}$, so sum $=\\frac{\\frac{20}{9}}{1-\\frac{2}{3}}=\\frac{20}{3}$.',
      B: 'Incorrect. This often comes from using $5\\left(\\frac{2}{3}\\right)^1$ as the first term or dropping a factor of 2.',
      C: 'Incorrect. $\\frac{20}{9}$ is the first term (at $n=2$), not the sum to infinity.',
      D: 'Incorrect. Since $\\left|\\frac{2}{3}\\right|<1$, the geometric series converges.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 4, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.2',
    source: 'self', source_year: null,
    notes: 'Starts at $n=2$: first term must be evaluated at $n=2$.',
    weight_primary: 0.70, weight_supporting: 0.30,
    title: 'U10C10.2-Q9-InfiniteGeometricIndexShiftExactSum',
    prompt_type: 'text',
    primary_skill_id: 'geometric_series_computation',
    supporting_skill_ids: ['sigma_notation_manipulation'],
  },
  {
    id: '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f',
    course: 'BC', topic: 'BC_Series', sub_topic_id: '10.2', type: 'MCQ',
    calculator_allowed: false, difficulty: 2, target_time_seconds: 180,
    skill_tags: ['geometric_series_computation', 'algebraic_simplification'],
    error_tags: ['misidentify_geometric_ratio', 'use_wrong_first_term_index'],
    prompt: 'Compute the finite sum\n$$\\sum_{n=0}^{3} 5\\cdot 2^n.$$\n\nA. $35$\nB. $40$\nC. $45$\nD. $75$',
    latex: null,
    options: [
      { id: 'A', value: '$35$' },
      { id: 'B', value: '$40$' },
      { id: 'C', value: '$45$' },
      { id: 'D', value: '$75$' }
    ],
    correct_option_id: 'D', tolerance: null,
    explanation: 'This is a finite geometric sum with first term $5$ and ratio $2$:\n$$\\sum_{n=0}^{3} 5\\cdot 2^n = 5\\sum_{n=0}^{3}2^n = 5\\cdot\\frac{2^{4}-1}{2-1}=5(16-1)=75.$$',
    micro_explanations: {
      A: 'Incorrect. That is $5(1+2+4)=35$, missing the $n=3$ term.',
      B: 'Incorrect. That would be the last term $5\\cdot 2^3$ only.',
      C: 'Incorrect. This can come from adding $5+10+30$ (skipping a term).',
      D: 'Correct. $5(1+2+4+8)=5\\cdot 15=75$, or $5\\cdot\\frac{2^4-1}{2-1}=75$.'
    },
    recommendation_reasons: [],
    created_at: '2026-02-06T23:00:00+00:00', updated_at: '2026-02-06T23:00:00+00:00',
    status: 'published', version: 1, reasoning_level: 2, mastery_weight: 1.0,
    representation_type: 'symbolic', topic_id: 'BC_Series', section_id: '10.2',
    source: 'self', source_year: null,
    notes: 'Finite geometric sum with $n$ starting at 0.',
    weight_primary: 0.80, weight_supporting: 0.20,
    title: 'U10C10.2-Q10-FiniteGeometricSumFormula',
    prompt_type: 'text',
    primary_skill_id: 'geometric_series_computation',
    supporting_skill_ids: ['algebraic_simplification'],
  },
];

// ============================================================
// Question Skills mapping (new IDs)
// ============================================================
const QUESTION_SKILLS = [
  // Q1
  { question_id: '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', skill_id: 'sequence_and_series_definitions', weight: 0.85, role: 'primary' },
  { question_id: '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', skill_id: 'partial_sum_reasoning', weight: 0.15, role: 'supporting' },
  // Q2
  { question_id: '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', skill_id: 'partial_sum_reasoning', weight: 0.80, role: 'primary' },
  { question_id: '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', skill_id: 'algebraic_simplification', weight: 0.20, role: 'supporting' },
  // Q3
  { question_id: '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', skill_id: 'partial_sum_reasoning', weight: 0.85, role: 'primary' },
  { question_id: '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', skill_id: 'sequence_and_series_definitions', weight: 0.15, role: 'supporting' },
  // Q4
  { question_id: 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', skill_id: 'sequence_and_series_definitions', weight: 0.90, role: 'primary' },
  { question_id: 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', skill_id: 'sigma_notation_manipulation', weight: 0.10, role: 'supporting' },
  // Q5
  { question_id: '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', skill_id: 'sigma_notation_manipulation', weight: 0.60, role: 'primary' },
  { question_id: '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', skill_id: 'partial_sum_reasoning', weight: 0.40, role: 'supporting' },
  // Q6
  { question_id: 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', skill_id: 'geometric_series_computation', weight: 0.90, role: 'primary' },
  { question_id: 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', skill_id: 'algebraic_simplification', weight: 0.10, role: 'supporting' },
  // Q7
  { question_id: 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', skill_id: 'geometric_series_computation', weight: 0.75, role: 'primary' },
  { question_id: 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', skill_id: 'sequence_and_series_definitions', weight: 0.25, role: 'supporting' },
  // Q8
  { question_id: '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', skill_id: 'modeling_with_series', weight: 0.60, role: 'primary' },
  { question_id: '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', skill_id: 'geometric_series_computation', weight: 0.40, role: 'supporting' },
  // Q9
  { question_id: '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', skill_id: 'geometric_series_computation', weight: 0.70, role: 'primary' },
  { question_id: '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', skill_id: 'sigma_notation_manipulation', weight: 0.30, role: 'supporting' },
  // Q10
  { question_id: '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', skill_id: 'geometric_series_computation', weight: 0.80, role: 'primary' },
  { question_id: '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', skill_id: 'algebraic_simplification', weight: 0.20, role: 'supporting' },
];

// ============================================================
// Question Error Patterns mapping (new IDs)
// ============================================================
const QUESTION_ERROR_PATTERNS = [
  // Q1
  { question_id: '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', error_tag_id: 'confuse_sequence_vs_series' },
  { question_id: '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1', error_tag_id: 'assume_limit_exists_implies_series_converges' },
  // Q2
  { question_id: '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', error_tag_id: 'treat_divergent_series_as_having_sum' },
  { question_id: '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a', error_tag_id: 'assume_limit_exists_implies_series_converges' },
  // Q3
  { question_id: '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', error_tag_id: 'treat_divergent_series_as_having_sum' },
  { question_id: '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7', error_tag_id: 'assume_limit_exists_implies_series_converges' },
  // Q4
  { question_id: 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', error_tag_id: 'confuse_sequence_vs_series' },
  { question_id: 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0', error_tag_id: 'use_wrong_first_term_index' },
  // Q5
  { question_id: '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', error_tag_id: 'use_wrong_first_term_index' },
  { question_id: '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3', error_tag_id: 'confuse_sequence_vs_series' },
  // Q6
  { question_id: 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', error_tag_id: 'misidentify_geometric_ratio' },
  { question_id: 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4', error_tag_id: 'treat_divergent_series_as_having_sum' },
  // Q7
  { question_id: 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', error_tag_id: 'ignore_domain_of_r' },
  { question_id: 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e', error_tag_id: 'misidentify_geometric_ratio' },
  // Q8
  { question_id: '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', error_tag_id: 'misidentify_geometric_ratio' },
  { question_id: '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1', error_tag_id: 'use_wrong_first_term_index' },
  // Q9
  { question_id: '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', error_tag_id: 'use_wrong_first_term_index' },
  { question_id: '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9', error_tag_id: 'misidentify_geometric_ratio' },
  // Q10
  { question_id: '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', error_tag_id: 'misidentify_geometric_ratio' },
  { question_id: '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f', error_tag_id: 'use_wrong_first_term_index' },
];


// ============================================================
// MAIN
// ============================================================
async function main() {
  console.log('🚀 Starting Unit 10 Questions Upsert (New IDs)...\n');

  // ---- Step 0: Ensure topic_content exists ----
  console.log('📦 Step 0: Ensuring topic_content BC_Series exists...');
  const { error: tcErr } = await supabase
    .from('topic_content')
    .upsert({ id: 'BC_Series', title: 'Infinite Sequences and Series', description: 'Unit 10: Infinite Sequences and Series' }, { onConflict: 'id' });
  if (tcErr) console.error('  ⚠️ topic_content error:', tcErr.message);
  else console.log('  ✅ topic_content OK');

  // ---- Step 1: Ensure skills exist ----
  console.log('\n📦 Step 1: Ensuring skills exist...');
  for (const skill of SKILLS) {
    const { error } = await supabase.from('skills').upsert(skill, { onConflict: 'id' });
    if (error) console.error(`  ⚠️ Skill ${skill.id}: ${error.message}`);
    else console.log(`  ✅ Skill: ${skill.id}`);
  }

  // ---- Step 2: Ensure error_tags exist ----
  console.log('\n📦 Step 2: Ensuring error_tags exist...');
  for (const tag of ERROR_TAGS) {
    const { error } = await supabase.from('error_tags').upsert(tag, { onConflict: 'id' });
    if (error) console.error(`  ⚠️ Error tag ${tag.id}: ${error.message}`);
    else console.log(`  ✅ Error tag: ${tag.id}`);
  }

  // ---- Step 3: Clean up old relationships for ALL IDs (old + new) ----
  console.log('\n🧹 Step 3: Cleaning up old relationships...');

  // Delete question_skills for all IDs
  const { error: delSkillsErr } = await supabase
    .from('question_skills')
    .delete()
    .in('question_id', ALL_IDS);
  console.log(`  ${delSkillsErr ? '⚠️' : '✅'} question_skills cleanup${delSkillsErr ? ': ' + delSkillsErr.message : ''}`);

  // Delete question_error_patterns for all IDs
  const { error: delPatternsErr } = await supabase
    .from('question_error_patterns')
    .delete()
    .in('question_id', ALL_IDS);
  console.log(`  ${delPatternsErr ? '⚠️' : '✅'} question_error_patterns cleanup${delPatternsErr ? ': ' + delPatternsErr.message : ''}`);

  // Delete question_versions for all IDs
  const { error: delVersionsErr } = await supabase
    .from('question_versions')
    .delete()
    .in('question_id', ALL_IDS);
  console.log(`  ${delVersionsErr ? '⚠️' : '✅'} question_versions cleanup${delVersionsErr ? ': ' + delVersionsErr.message : ''}`);

  // Delete user_question_state for all IDs
  const { error: delStateErr } = await supabase
    .from('user_question_state')
    .delete()
    .in('question_id', ALL_IDS);
  console.log(`  ${delStateErr ? '⚠️' : '✅'} user_question_state cleanup${delStateErr ? ': ' + delStateErr.message : ''}`);

  // Delete recommendations for all IDs
  const { error: delRecsErr } = await supabase
    .from('recommendations')
    .delete()
    .in('question_id', ALL_IDS);
  console.log(`  ${delRecsErr ? '⚠️' : '✅'} recommendations cleanup${delRecsErr ? ': ' + delRecsErr.message : ''}`);

  // Delete question_attempts for all IDs (needed before question delete)
  const { error: delAttemptsErr } = await supabase
    .from('question_attempts')
    .delete()
    .in('question_id', ALL_IDS);
  console.log(`  ${delAttemptsErr ? '⚠️' : '✅'} question_attempts cleanup${delAttemptsErr ? ': ' + delAttemptsErr.message : ''}`);

  // ---- Step 4: Delete old questions (old IDs) ----
  console.log('\n🗑️ Step 4: Deleting old questions (old IDs)...');
  const { error: delOldErr, count: delOldCount } = await supabase
    .from('questions')
    .delete()
    .in('id', OLD_IDS);
  console.log(`  ${delOldErr ? '⚠️' : '✅'} Old questions deleted${delOldErr ? ': ' + delOldErr.message : ''}`);

  // Also delete if new IDs already exist (for clean re-run)
  const { error: delNewErr } = await supabase
    .from('questions')
    .delete()
    .in('id', NEW_IDS);
  console.log(`  ${delNewErr ? '⚠️' : '✅'} Pre-existing new IDs cleaned${delNewErr ? ': ' + delNewErr.message : ''}`);

  // ---- Step 5: Insert new questions ----
  console.log('\n📝 Step 5: Inserting 10 new questions...');
  const { data: insertedData, error: insertErr } = await supabase
    .from('questions')
    .insert(QUESTIONS)
    .select('id, title');

  if (insertErr) {
    console.error('  ❌ Insert error:', insertErr.message);
    // Try one by one
    console.log('  🔄 Trying one-by-one insert...');
    for (const q of QUESTIONS) {
      const { error: singleErr } = await supabase.from('questions').insert(q);
      if (singleErr) {
        console.error(`    ❌ ${q.title}: ${singleErr.message}`);
      } else {
        console.log(`    ✅ ${q.title}`);
      }
    }
  } else {
    console.log(`  ✅ ${insertedData?.length || 0} questions inserted successfully`);
    insertedData?.forEach(q => console.log(`    • ${q.title}`));
  }

  // ---- Step 6: Insert question_skills ----
  console.log('\n🔗 Step 6: Inserting question_skills...');
  const { error: skillsErr } = await supabase
    .from('question_skills')
    .insert(QUESTION_SKILLS);
  if (skillsErr) {
    console.error('  ❌ question_skills error:', skillsErr.message);
    // Try one by one
    for (const qs of QUESTION_SKILLS) {
      const { error } = await supabase.from('question_skills').insert(qs);
      if (error) console.error(`    ❌ ${qs.question_id} + ${qs.skill_id}: ${error.message}`);
    }
  } else {
    console.log(`  ✅ ${QUESTION_SKILLS.length} question_skills inserted`);
  }

  // ---- Step 7: Insert question_error_patterns ----
  console.log('\n🔗 Step 7: Inserting question_error_patterns...');
  const { error: patternsErr } = await supabase
    .from('question_error_patterns')
    .insert(QUESTION_ERROR_PATTERNS);
  if (patternsErr) {
    console.error('  ❌ question_error_patterns error:', patternsErr.message);
    // Try one by one
    for (const qe of QUESTION_ERROR_PATTERNS) {
      const { error } = await supabase.from('question_error_patterns').insert(qe);
      if (error) console.error(`    ❌ ${qe.question_id} + ${qe.error_tag_id}: ${error.message}`);
    }
  } else {
    console.log(`  ✅ ${QUESTION_ERROR_PATTERNS.length} question_error_patterns inserted`);
  }

  // ---- Step 8: Verify ----
  console.log('\n🔍 Step 8: Verifying...');
  const { data: verifyData, error: verifyErr } = await supabase
    .from('questions')
    .select('id, title, sub_topic_id, difficulty, status')
    .in('id', NEW_IDS)
    .order('sub_topic_id')
    .order('difficulty');

  if (verifyErr) {
    console.error('  ❌ Verify error:', verifyErr.message);
  } else {
    console.log(`  ✅ Found ${verifyData?.length || 0} questions in DB:`);
    verifyData?.forEach(q => {
      console.log(`    [${q.sub_topic_id}] D${q.difficulty} ${q.status} - ${q.title}`);
    });
  }

  // Verify skills
  const { data: skillsVerify } = await supabase
    .from('question_skills')
    .select('question_id, skill_id, role, weight')
    .in('question_id', NEW_IDS);
  console.log(`  ✅ ${skillsVerify?.length || 0} question_skills records`);

  // Verify error patterns
  const { data: patternsVerify } = await supabase
    .from('question_error_patterns')
    .select('question_id, error_tag_id')
    .in('question_id', NEW_IDS);
  console.log(`  ✅ ${patternsVerify?.length || 0} question_error_patterns records`);

  console.log('\n🎉 Done!');
}

main().catch(console.error);
