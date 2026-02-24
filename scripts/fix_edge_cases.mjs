/**
 * Fix remaining edge cases:
 * 1. 1.0-UT-Q5: micro_explanations are objects, need to extract .text
 * 2. 1.9-P3: option D needs real explanation, options need label fixes
 * 3. Check all options have proper labels
 */
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const labels = ['A', 'B', 'C', 'D'];

// ---- Fix 1: 1.0-UT-Q5 micro_explanations ----
console.log('=== Fixing 1.0-UT-Q5 ===');
const { data: q5 } = await sb.from('questions').select('*').eq('title', '1.0-UT-Q5').single();

if (q5) {
    const me = q5.micro_explanations;
    const newME = {};
    for (const label of labels) {
        const val = me[label];
        if (val && typeof val === 'object' && val.text) {
            newME[label] = val.text;
        } else if (typeof val === 'string') {
            newME[label] = val;
        } else {
            newME[label] = 'Review this option.';
        }
    }

    // Q5: lim(x→-1) [3/(x+2) + 2x/(x²+3)] = 3/(1) + (-2)/(4) = 3 - 0.5 = 5/2
    // Correct: A (5/2)
    // The MEs from original data describe continuity conditions, which don't match this limit question
    // Let's write proper explanations
    const properME = {
        A: 'Correct. Substituting $x=-1$: $\\frac{3}{-1+2}+\\frac{2(-1)}{(-1)^2+3}=3-\\frac{1}{2}=\\frac{5}{2}$.',
        B: 'Incorrect. $\\frac{5}{4}$ comes from an arithmetic error, likely $\\frac{3}{2}-\\frac{1}{4}$.',
        C: 'Incorrect. $\\frac{1}{2}$ results from computing only the second term and ignoring the first.',
        D: 'Incorrect. The limit exists because both denominators are nonzero at $x=-1$.'
    };

    const { error } = await sb.from('questions').update({ micro_explanations: properME }).eq('id', q5.id);
    console.log(error ? `❌ ${error.message}` : '✅ Fixed');
}

// ---- Fix 2: 1.9-P3 ----
console.log('\n=== Fixing 1.9-P3 ===');
const { data: q93 } = await sb.from('questions').select('*').eq('title', '1.9-P3').single();

if (q93) {
    // Q: From a table, one-sided limits are 2 and -1, so limit DNE
    // Correct: D (limit does not exist)
    const properME = {
        A: 'Incorrect. $2$ is only the left-hand approach value from the table. The limit requires both sides to agree.',
        B: 'Incorrect. $-1$ is only the right-hand approach value. The two-sided limit needs matching one-sided limits.',
        C: 'Incorrect. $g(1)=2$ may be the function value, but it does not determine whether the limit exists.',
        D: 'Correct. The left-hand limit ($2$) and right-hand limit ($-1$) are different, so $\\lim_{x\\to 1} g(x)$ does not exist.'
    };

    // Also fix options labels (they have undefined labels)
    const opts = q93.options.map((o, i) => ({
        ...o,
        id: labels[i],
        label: labels[i]
    }));

    const { error } = await sb.from('questions').update({
        micro_explanations: properME,
        options: opts
    }).eq('id', q93.id);
    console.log(error ? `❌ ${error.message}` : '✅ Fixed');
}

// ---- Fix 3: Check ALL questions for undefined option labels ----
console.log('\n=== Checking all option labels ===');
const { data: all } = await sb.from('questions').select('id, title, options').like('title', '1.%');

let labelFixes = 0;
for (const q of all) {
    let needsFix = false;
    const opts = q.options.map((o, i) => {
        if (!o.label || o.label === 'undefined') {
            needsFix = true;
            return { ...o, id: labels[i], label: labels[i] };
        }
        return o;
    });

    if (needsFix) {
        const { error } = await sb.from('questions').update({ options: opts }).eq('id', q.id);
        console.log(`  ${q.title}: ${error ? '❌ ' + error.message : '✅ labels fixed'}`);
        labelFixes++;
    }
}

console.log(`\nLabel fixes applied: ${labelFixes}`);
