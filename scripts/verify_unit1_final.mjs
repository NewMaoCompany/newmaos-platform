/**
 * Final verification: re-dump and re-analyze all Unit 1 questions
 */
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const labels = ['A', 'B', 'C', 'D'];

const { data, error } = await sb
    .from('questions')
    .select('*')
    .like('title', '1.%')
    .order('title', { ascending: true });

if (error) { console.error('Error:', error.message); process.exit(1); }
console.log(`Fetched ${data.length} questions\n`);

let issues = 0;

// 1. Correct answer distribution
const dist = { A: 0, B: 0, C: 0, D: 0 };
data.forEach(q => dist[q.correct_option_id]++);
console.log('Correct answer distribution:', JSON.stringify(dist));
if (dist.A !== 25 || dist.B !== 25 || dist.C !== 25 || dist.D !== 25) {
    console.log('  ⚠️ Not perfectly uniform!');
    issues++;
} else {
    console.log('  ✅ Perfect 25/25/25/25');
}

// 2. Prompt format
let promptStringIssues = 0;
let promptArrayCount = 0;
for (const q of data) {
    if (typeof q.prompt === 'string' && q.prompt.trim().startsWith('[')) {
        try { JSON.parse(q.prompt); promptStringIssues++; } catch { }
    }
    if (Array.isArray(q.prompt)) promptArrayCount++;
}
console.log(`\nPrompt format: ${promptArrayCount} arrays, ${data.length - promptArrayCount} strings`);
if (promptStringIssues > 0) {
    console.log(`  ⚠️ ${promptStringIssues} still double-serialized`);
    issues += promptStringIssues;
} else {
    console.log('  ✅ No double-serialization');
}

// 3. micro_explanations
let meIssues = 0;
for (const q of data) {
    const me = q.micro_explanations || {};
    const keys = Object.keys(me);

    // Check numeric keys
    if (keys.some(k => /^\d+$/.test(k))) {
        console.log(`  ⚠️ ${q.title}: numeric micro_explanation keys`);
        meIssues++;
    }

    // Check count
    if (keys.length < 4) {
        console.log(`  ⚠️ ${q.title}: only ${keys.length} micro_explanations`);
        meIssues++;
    }

    // Check correct answer has explanation
    if (!me[q.correct_option_id]) {
        console.log(`  ⚠️ ${q.title}: no micro_explanation for correct answer ${q.correct_option_id}`);
        meIssues++;
    }
}
console.log(`\nmicro_explanations: ${meIssues === 0 ? '✅ All valid' : '⚠️ ' + meIssues + ' issues'}`);
issues += meIssues;

// 4. representation_type consistency
let repIssues = 0;
for (const q of data) {
    if (q.prompt_type === 'image' && q.representation_type !== 'graph' && q.representation_type !== 'mixed') {
        console.log(`  ⚠️ ${q.title}: prompt_type=image but rep_type=${q.representation_type}`);
        repIssues++;
    }
}
console.log(`\nrepresentation_type: ${repIssues === 0 ? '✅ All consistent' : '⚠️ ' + repIssues + ' mismatches'}`);
issues += repIssues;

// 5. Options integrity
let optIssues = 0;
for (const q of data) {
    if (q.options.length !== 4) { optIssues++; continue; }

    // Check labels are A,B,C,D
    const optLabels = q.options.map(o => o.label || o.id);
    for (let i = 0; i < 4; i++) {
        if (optLabels[i] !== labels[i]) {
            console.log(`  ⚠️ ${q.title}: option ${i} label is "${optLabels[i]}" instead of "${labels[i]}"`);
            optIssues++;
        }
    }

    // Check all options have content
    for (const opt of q.options) {
        const content = opt.value || opt.text || '';
        if (!content.trim()) {
            console.log(`  ⚠️ ${q.title}: option ${opt.label} has no content`);
            optIssues++;
        }
    }

    // Check correct_option_id exists
    const correctOpt = q.options.find(o => o.label === q.correct_option_id || o.id === q.correct_option_id);
    if (!correctOpt) {
        console.log(`  ⚠️ ${q.title}: correct_option_id "${q.correct_option_id}" not matched`);
        optIssues++;
    }
}
console.log(`\nOptions integrity: ${optIssues === 0 ? '✅ All valid' : '⚠️ ' + optIssues + ' issues'}`);
issues += optIssues;

// 6. Per-chapter distribution
console.log('\n=== Per-chapter correct answer distribution ===');
const chapters = {};
data.forEach(q => {
    const m = q.title.match(/^1\.(\d+)/);
    const ch = m ? m[1] : '?';
    if (!chapters[ch]) chapters[ch] = { A: 0, B: 0, C: 0, D: 0, total: 0 };
    chapters[ch][q.correct_option_id]++;
    chapters[ch].total++;
});
Object.entries(chapters).sort((a, b) => parseInt(a[0]) - parseInt(b[0])).forEach(([ch, d]) => {
    console.log(`  Ch ${ch.padStart(2)}: A=${d.A} B=${d.B} C=${d.C} D=${d.D} (total=${d.total})`);
});

console.log(`\n${'='.repeat(40)}`);
console.log(`TOTAL ISSUES: ${issues}`);
console.log(issues === 0 ? '🎉 ALL CHECKS PASSED!' : `⚠️ ${issues} issues remain`);
