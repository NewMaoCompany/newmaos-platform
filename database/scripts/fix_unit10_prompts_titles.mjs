/**
 * Fix Unit 10 Questions:
 * 1. Remove embedded options (A/B/C/D) from prompt text
 * 2. Add spaces to titles
 * 3. Delete old U10.1-P4 question
 */
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'https://xzpjlnkirboevkjzitcx.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODUyNzU2NiwiZXhwIjoyMDg0MTAzNTY2fQ.8Ucl0sH8m0ZW6HFxnkNAXtWmdzFfLpJ-Fw22oNpTU2I'
);

// Clean prompts: question stem ONLY, no embedded A/B/C/D options
const UPDATES = [
  {
    id: '0f3b5c8a-7e1f-4b67-bc66-2d1b76a7b2e1',
    title: 'U10 C10.1 Q1 - Definition Series Convergence By Partial Sums',
    prompt: 'Let $\\sum_{n=1}^{\\infty} a_n$ be an infinite series with partial sums $s_k=\\sum_{n=1}^{k} a_n$. Which statement correctly defines when $\\sum_{n=1}^{\\infty} a_n$ converges?',
  },
  {
    id: '2a0f7f4d-6dd0-4c8a-9fb6-5b2d4d6b7a9a',
    title: 'U10 C10.1 Q2 - Sum From Explicit Partial Sum Limit',
    prompt: 'An infinite series $\\sum_{n=1}^{\\infty} a_n$ has partial sums\n$$s_k=5-\\frac{2}{k+1}.$$\nWhich statement is true?',
  },
  {
    id: '7b6f6f2a-0c5b-44b0-9b4b-7c4a76f1b2c7',
    title: 'U10 C10.1 Q3 - Divergence From Oscillating Partial Sums',
    prompt: 'A series $\\sum_{n=1}^{\\infty} a_n$ has partial sums $s_k$ given by\n$$s_k=\\begin{cases}2 & \\text{if $k$ is even}\\\\ 1 & \\text{if $k$ is odd.}\\end{cases}$$\nWhich is true?',
  },
  {
    id: 'c9b8f1e1-3c11-4a54-9b9f-41a1c4c0b6d0',
    title: 'U10 C10.1 Q4 - Identify Term Vs Partial Sum',
    prompt: 'Let $a_n=\\frac{1}{n^2}$ and $s_n=\\sum_{k=1}^{n} a_k$. Which statement is correct?',
  },
  {
    id: '5f0d8a2b-1f8b-4cc6-8c59-9c61a8b6a9f3',
    title: 'U10 C10.1 Q5 - Find Nth Term From Partial Sums Difference',
    prompt: 'A series has partial sums $s_n=\\sum_{k=1}^{n} a_k$ given by\n$$s_n=\\frac{n}{n+2}.$$\nWhat is $a_n$ for $n\\ge2$?',
  },
  {
    id: 'a7d9a6d4-62aa-4f75-9a61-5d6ed5c3d1c4',
    title: 'U10 C10.2 Q6 - Infinite Geometric Sum Basic',
    prompt: 'Evaluate the infinite series\n$$\\sum_{n=0}^{\\infty} 3\\left(\\frac{1}{4}\\right)^n.$$',
  },
  {
    id: 'e1a7c8f5-3e57-4f2a-9b2e-3b9bca8b5d0e',
    title: 'U10 C10.2 Q7 - Parameter Range For Geometric Convergence',
    prompt: 'For which values of $k$ does the series\n$$\\sum_{n=1}^{\\infty} k\\left(\\frac{k}{3}\\right)^{n-1}$$\nconverge?',
  },
  {
    id: '3b2c9f3a-9c79-4cda-9b13-9a3cf6b5dce1',
    title: 'U10 C10.2 Q8 - Repeating Decimal To Fraction Geometric',
    prompt: 'Write $0.\\overline{36}$ as a fraction in simplest form.',
  },
  {
    id: '8a8b9a2a-2f7d-4c1a-9b5a-7ed2d5c8a1f9',
    title: 'U10 C10.2 Q9 - Infinite Geometric Index Shift Exact Sum',
    prompt: 'Evaluate\n$$\\sum_{n=2}^{\\infty} 5\\left(\\frac{2}{3}\\right)^n.$$',
  },
  {
    id: '1d6c4f5b-3f2b-4b4f-8bb7-9f2a3c4d5e6f',
    title: 'U10 C10.2 Q10 - Finite Geometric Sum Formula',
    prompt: 'Compute the finite sum\n$$\\sum_{n=0}^{3} 5\\cdot 2^n.$$',
  },
];

const OLD_P4_ID = 'b4d2bc8b-4579-4990-b6e7-764f7e9ebbe3';

async function main() {
  console.log('🔧 Fixing Unit 10 questions...\n');

  // 1. Delete old U10.1-P4
  console.log('🗑️  Deleting old U10.1-P4...');
  // Clean relationships first
  for (const table of ['question_skills', 'question_error_patterns', 'question_versions', 'user_question_state', 'recommendations', 'question_attempts']) {
    await supabase.from(table).delete().eq('question_id', OLD_P4_ID);
  }
  const { error: delErr } = await supabase.from('questions').delete().eq('id', OLD_P4_ID);
  console.log(delErr ? `  ⚠️ ${delErr.message}` : '  ✅ Deleted');

  // 2. Update prompts & titles
  console.log('\n📝 Updating prompts (remove options) & titles (add spaces)...');
  for (const u of UPDATES) {
    const { error } = await supabase
      .from('questions')
      .update({ prompt: u.prompt, title: u.title, updated_at: new Date().toISOString() })
      .eq('id', u.id);
    console.log(error ? `  ❌ ${u.title}: ${error.message}` : `  ✅ ${u.title}`);
  }

  // 3. Verify
  console.log('\n🔍 Verifying...');
  const { data } = await supabase
    .from('questions')
    .select('id, title, prompt')
    .in('id', UPDATES.map(u => u.id))
    .order('sub_topic_id')
    .order('difficulty');

  data?.forEach(q => {
    const hasOptions = /\nA\.\s/.test(q.prompt);
    console.log(`  ${hasOptions ? '❌ STILL HAS OPTIONS' : '✅'} ${q.title}`);
    console.log(`     Prompt preview: ${q.prompt.substring(0, 80)}...`);
  });

  // Check P4 deleted
  const { data: p4 } = await supabase.from('questions').select('id').eq('id', OLD_P4_ID);
  console.log(`\n  ${p4?.length === 0 ? '✅' : '❌'} Old P4 question ${p4?.length === 0 ? 'deleted' : 'still exists'}`);

  console.log('\n🎉 Done!');
}

main().catch(console.error);
