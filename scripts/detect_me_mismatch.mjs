/**
 * Detect micro_explanation mismatches:
 * Where the "Correct" text appears in a micro_explanation for the WRONG option
 */
import fs from 'fs';
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const { data, error } = await sb.from('questions').select('*').like('title', '1.%').order('title');
if (error) { console.error(error.message); process.exit(1); }

data.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));

const labels = ['A', 'B', 'C', 'D'];
let issues = [];

for (const q of data) {
    const me = q.micro_explanations || {};
    const correctId = q.correct_option_id;

    // Check 1: Does the correct option's micro_explanation say "Correct"?
    const correctME = String(me[correctId] || '');
    const correctMEHasCorrect = correctME.toLowerCase().startsWith('correct');

    // Check 2: Do any OTHER options' micro_explanations say "Correct"?
    const wrongCorrectLabels = [];
    for (const label of labels) {
        if (label === correctId) continue;
        const text = String(me[label] || '');
        if (text.toLowerCase().startsWith('correct')) {
            wrongCorrectLabels.push(label);
        }
    }

    // Check 3: Does correct option's ME say "Incorrect"?
    const correctMEHasIncorrect = correctME.toLowerCase().startsWith('incorrect');

    if (wrongCorrectLabels.length > 0 || correctMEHasIncorrect || !correctMEHasCorrect) {
        const issue = {
            title: q.title,
            correctId,
            problems: []
        };

        if (wrongCorrectLabels.length > 0) {
            issue.problems.push(`Micro_expl for ${wrongCorrectLabels.join(',')} says "Correct" but they are WRONG options`);
        }
        if (correctMEHasIncorrect) {
            issue.problems.push(`Micro_expl for correct answer ${correctId} says "Incorrect"!`);
        }
        if (!correctMEHasCorrect && correctME) {
            // Check if it's a substantive explanation (not just generic)
            issue.problems.push(`Micro_expl for correct answer ${correctId} doesn't start with "Correct" (starts with: "${correctME.substring(0, 50)}")`);
        }

        issues.push(issue);
    }
}

console.log(`\n=== MICRO_EXPLANATION MISMATCH REPORT ===\n`);
console.log(`Found ${issues.length} questions with potential micro_explanation issues:\n`);

for (const issue of issues) {
    console.log(`${issue.title} (correct=${issue.correctId}):`);
    issue.problems.forEach(p => console.log(`  ❌ ${p}`));
    console.log();
}

// Also check math correctness for key questions
console.log('\n=== MATH VERIFICATION (spot checks) ===\n');

const mathChecks = [
    { title: '1.0-UT-Q1', expected: '4', verify: '2(9)-15+1=4' },
    { title: '1.0-UT-Q2', expected: '4', verify: '(x-2)(x+2)/(x-2)=x+2, at x=2: 4' },
    { title: '1.0-UT-Q5', expected: '5/2', verify: '3/(−1+2)+2(−1)/(1+3)=3−1/2=5/2' },
    { title: '1.0-UT-Q6', expected: '1/2', verify: 'rationalize: 1/(√(1+x)+1), at x=0: 1/2' },
    { title: '1.0-UT-Q8', expected: '0', verify: 'squeeze: −x²≤x²sin(1/x)≤x²→0' },
    { title: '1.0-UT-Q15', expected: '3/2', verify: '(3x²-7)/(2x²+5x), divide by x², →3/2' },
    { title: '1.1-P1', expected: '6', verify: '(15-3)/2=6' },
    { title: '1.1-P3', expected: '1/6', verify: '1/(√9+3)=1/6' },
    { title: '1.1-P5', expected: '12', verify: '(2+h)³=8+12h+6h²+h³, limit=12' },
    { title: '1.2-P3', expected: '8', verify: 'lim(f(x)-3)=5 → lim f(x)=8' },
];

for (const check of mathChecks) {
    const q = data.find(d => d.title === check.title);
    if (!q) continue;
    const correctOpt = q.options.find(o => o.label === q.correct_option_id || o.id === q.correct_option_id);
    const correctContent = correctOpt ? (correctOpt.value || correctOpt.text || '') : 'NOT FOUND';
    const matches = correctContent.includes(check.expected);
    console.log(`${check.title}: correct=${q.correct_option_id}, content="${correctContent}", expected contains "${check.expected}" → ${matches ? '✅' : '❌'}`);
    if (!matches) console.log(`  Verify: ${check.verify}`);
}

console.log(`\nTotal micro_expl issues: ${issues.length}`);
fs.writeFileSync('scripts/micro_expl_issues.json', JSON.stringify(issues, null, 2));
