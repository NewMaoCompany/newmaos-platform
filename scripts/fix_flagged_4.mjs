/**
 * Fix the 4 flagged questions:
 * 1. 2.3-P5: Truncated options → reconstruct from explanation
 * 2. 6.14-P1: B=C duplicate → change C to a different distractor
 * 3. 10.13-P5: A=D duplicate → change A to [-1,3)
 * 4. 1.0-UT-Q9: Explanation "Option D" → "Option B"
 */
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

// ═══════════════════════════════════════════
// FIX 1: 2.3-P5 — Truncated options
// Prompt: symmetric difference quotient, s(4)=18.2, s(4.05)=18.7, s(3.95)=17.6
// Correct computation: (18.7-17.6)/(2×0.05) = 1.1/0.1 = 11 m/s
// ═══════════════════════════════════════════
console.log('=== Fix 1: 2.3-P5 ===');
{
    const { data: q } = await sb.from('questions').select('*').eq('title', '2.3-P5').single();
    if (q) {
        const newOptions = [
            { id: 'A', label: 'A', value: '$10\\ \\text{m/s}$' },
            { id: 'B', label: 'B', value: '$5.5\\ \\text{m/s}$' },
            { id: 'C', label: 'C', value: '$11\\ \\text{m/s}$' },
            { id: 'D', label: 'D', value: '$22\\ \\text{m/s}$' },
        ];
        const newME = {
            A: 'Incorrect. $10$ comes from using only one side: $(18.7-18.2)/0.05=10$, which is a one-sided difference quotient, not symmetric.',
            B: 'Incorrect. $5.5$ likely comes from dividing the numerator by $0.2$ instead of $0.10$.',
            C: 'Correct. Symmetric difference quotient: $\\frac{s(4.05)-s(3.95)}{2(0.05)}=\\frac{18.7-17.6}{0.10}=11$ m/s.',
            D: 'Incorrect. $22$ comes from using $\\frac{1.1}{0.05}$ instead of dividing by $2h=0.10$.',
        };
        const { error } = await sb.from('questions').update({
            options: newOptions,
            correct_option_id: 'C',
            micro_explanations: newME,
        }).eq('id', q.id);
        console.log(error ? '❌ ' + error.message : '✅ Fixed');
    }
}

// ═══════════════════════════════════════════
// FIX 2: 6.14-P1 — B and C are identical
// ∫(x²+1)/(x-1)dx = x²/2 + x + 2ln|x-1| + C  (correct = B)
// Change C to a plausible wrong answer
// ═══════════════════════════════════════════
console.log('=== Fix 2: 6.14-P1 ===');
{
    const { data: q } = await sb.from('questions').select('*').eq('title', '6.14-P1').single();
    if (q) {
        // Keep A, B, D as they are. Change C.
        // A = x²/2 + ln|x-1| + C  (missing the +x and coefficient 2)
        // B = x²/2 + x + 2ln|x-1| + C  (CORRECT)
        // D = x²/2 + x + ln|x-1| + C  (coefficient 1 instead of 2)
        // New C: x²/2 + 2x + ln|x-1| + C  (wrong coefficient on x and on ln)
        const opts = q.options.map(o => ({ ...o }));
        opts[2] = { id: 'C', label: 'C', value: '$\\frac{x^2}{2}+2x+\\ln|x-1|+C$' };
        const newME = { ...q.micro_explanations };
        newME['C'] = 'Incorrect. The long division yields remainder $2$, so the coefficient of $\\ln|x-1|$ should be $2$, and the linear term is $x$, not $2x$.';
        const { error } = await sb.from('questions').update({
            options: opts,
            micro_explanations: newME,
        }).eq('id', q.id);
        console.log(error ? '❌ ' + error.message : '✅ Fixed');
    }
}

// ═══════════════════════════════════════════
// FIX 3: 10.13-P5 — A and D are identical $$(-1,3)$$
// Series: Σ n(x-1)^n/2^n, ratio test → |x-1|<2 → -1<x<3
// Endpoints: x=3 → Σn diverges, x=-1 → Σn(-1)^n diverges
// So interval = (-1,3) = open both ends  (correct = D)
// Change A to [-1,3) (wrong: includes left endpoint)
// ═══════════════════════════════════════════
console.log('=== Fix 3: 10.13-P5 ===');
{
    const { data: q } = await sb.from('questions').select('*').eq('title', '10.13-P5').single();
    if (q) {
        const opts = q.options.map(o => ({ ...o }));
        opts[0] = { id: 'A', label: 'A', value: '$$[-1,3)$$' };
        const newME = { ...q.micro_explanations };
        newME['A'] = 'Incorrect. At $x=-1$, the series becomes $\\sum n(-1)^n$, whose terms do not approach $0$, so the series diverges. The left endpoint should be excluded.';
        const { error } = await sb.from('questions').update({
            options: opts,
            micro_explanations: newME,
        }).eq('id', q.id);
        console.log(error ? '❌ ' + error.message : '✅ Fixed');
    }
}

// ═══════════════════════════════════════════
// FIX 4: 1.0-UT-Q9 — Explanation says "Option D" but correct is B
// ═══════════════════════════════════════════
console.log('=== Fix 4: 1.0-UT-Q9 ===');
{
    const { data: q } = await sb.from('questions').select('*').eq('title', '1.0-UT-Q9').single();
    if (q) {
        const newExpl = q.explanation.replace('Option D satisfies this.', 'Option B satisfies this.');
        const { error } = await sb.from('questions').update({ explanation: newExpl }).eq('id', q.id);
        console.log(error ? '❌ ' + error.message : '✅ Fixed');
    }
}

// ═══════════════════════════════════════════
// VERIFY
// ═══════════════════════════════════════════
console.log('\n=== VERIFY ===');
for (const t of ['2.3-P5', '6.14-P1', '10.13-P5', '1.0-UT-Q9']) {
    const { data: q } = await sb.from('questions').select('title, correct_option_id, options, explanation').eq('title', t).single();
    console.log(t + ' (correct=' + q.correct_option_id + '):');
    q.options.forEach(o => console.log('  ' + o.label + ': ' + (o.value || o.text || '').substring(0, 60)));
    if (t === '1.0-UT-Q9') console.log('  EXPL: ' + q.explanation.substring(0, 150));
    console.log();
}
