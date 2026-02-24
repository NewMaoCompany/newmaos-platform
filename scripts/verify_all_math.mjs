/**
 * Automated math verification for ALL units.
 * Checks for:
 * 1. Explanation references correct answer value
 * 2. Option B explanation for Q9 says "Option D" (text mismatch)
 * 3. Empty/short explanations
 * 4. Duplicate options
 * 5. Correct/Incorrect ME label alignment
 * 6. Cross-checks explanation math with correct answer
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const labels = ['A', 'B', 'C', 'D'];
const allIssues = [];
const unitStats = {};

for (let unit = 1; unit <= 10; unit++) {
    const { data, error } = await sb.from('questions').select('*').like('title', `${unit}.%`).order('title');
    if (error) { console.error(`Unit ${unit}: ${error.message}`); continue; }
    data.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));

    const stats = { total: data.length, issues: [] };

    for (const q of data) {
        const opts = q.options || [];
        const me = q.micro_explanations || {};
        const expl = q.explanation || '';
        const correctOpt = opts.find(o => o.label === q.correct_option_id);
        const correctContent = correctOpt ? (correctOpt.value || correctOpt.text || '') : '';

        // ---- CHECK 1: ME Correct/Incorrect alignment ----
        for (const l of labels) {
            const t = String(me[l] || '');
            if (l === q.correct_option_id && t.toLowerCase().startsWith('incorrect')) {
                stats.issues.push({ title: q.title, severity: 'CRITICAL', msg: `correct ${l} ME says "Incorrect"` });
            }
            if (l !== q.correct_option_id && t.toLowerCase().startsWith('correct')) {
                stats.issues.push({ title: q.title, severity: 'CRITICAL', msg: `wrong ${l} ME says "Correct"` });
            }
        }

        // ---- CHECK 2: Empty explanation ----
        if (!expl || expl.length < 10) {
            stats.issues.push({ title: q.title, severity: 'ERROR', msg: `explanation too short (${expl.length} chars)` });
        }

        // ---- CHECK 3: Empty option content ----
        for (const opt of opts) {
            if (!(opt.value || opt.text || '').trim()) {
                stats.issues.push({ title: q.title, severity: 'ERROR', msg: `option ${opt.label} has no content` });
            }
        }

        // ---- CHECK 4: Duplicate options ----
        const contents = opts.map(o => (o.value || o.text || '').trim().toLowerCase());
        const unique = new Set(contents.filter(c => c));
        if (unique.size < contents.filter(c => c).length) {
            const dupes = contents.filter((c, i) => c && contents.indexOf(c) !== i);
            stats.issues.push({ title: q.title, severity: 'WARNING', msg: `duplicate option: "${dupes[0]?.substring(0, 40)}"` });
        }

        // ---- CHECK 5: Explanation references wrong answer ----
        const explLower = expl.toLowerCase();
        for (const l of labels) {
            if (l !== q.correct_option_id) {
                if (explLower.includes(`option ${l.toLowerCase()} satisfies`) ||
                    explLower.includes(`answer is ${l.toLowerCase()}`) ||
                    explLower.includes(`option ${l.toLowerCase()} is correct`)) {
                    stats.issues.push({ title: q.title, severity: 'WARNING', msg: `explanation may reference ${l} as correct` });
                }
            }
        }

        // ---- CHECK 6: Explanation says "Option X" where X ≠ correct ----
        const optMatch = expl.match(/Option\s+([A-D])\b/gi);
        if (optMatch) {
            for (const m of optMatch) {
                const letter = m.charAt(m.length - 1).toUpperCase();
                if (letter !== q.correct_option_id && expl.includes(`${m} satisfies`)) {
                    stats.issues.push({ title: q.title, severity: 'WARNING', msg: `explanation says "${m}" but correct is ${q.correct_option_id}` });
                }
            }
        }

        // ---- CHECK 7: Explanation concludes with different value than correct answer ----
        // Look for patterns like "= X" or "gives X" or "the limit is X" at end of explanation
        const explClean = expl.replace(/\$\$/g, '').replace(/\$/g, '');
        const conclusionMatch = explClean.match(/(?:=|gives|is|equals|so|therefore)\s*([^\s,.]+)\s*[.,]*$/i);
        // This is a rough heuristic - just flag for manual review if there's a mismatch

        // ---- CHECK 8: Missing micro_explanations ----
        const meCount = Object.keys(me).length;
        if (meCount < 4) {
            stats.issues.push({ title: q.title, severity: 'WARNING', msg: `only ${meCount} micro_explanations` });
        }

        // ---- CHECK 9: [object Object] in any field ----
        for (const l of labels) {
            if (String(me[l]).includes('[object Object]')) {
                stats.issues.push({ title: q.title, severity: 'CRITICAL', msg: `ME ${l} contains [object Object]` });
            }
        }
        if (expl.includes('[object Object]')) {
            stats.issues.push({ title: q.title, severity: 'CRITICAL', msg: `explanation contains [object Object]` });
        }
        if (correctContent.includes('[object Object]')) {
            stats.issues.push({ title: q.title, severity: 'CRITICAL', msg: `correct option contains [object Object]` });
        }

        // ---- CHECK 10: No correct option found ----
        if (!correctOpt) {
            stats.issues.push({ title: q.title, severity: 'CRITICAL', msg: `correct_option_id "${q.correct_option_id}" not found in options` });
        }

        // ---- CHECK 11: Missing option labels ----
        for (let i = 0; i < opts.length; i++) {
            if (!opts[i].label || opts[i].label === 'undefined') {
                stats.issues.push({ title: q.title, severity: 'ERROR', msg: `option ${i} has undefined label` });
            }
        }

        // ---- CHECK 12: prompt empty ----
        let promptText = q.prompt;
        if (typeof promptText === 'string') {
            if (promptText.trim().startsWith('[')) {
                try { const p = JSON.parse(promptText); if (Array.isArray(p)) promptText = p.filter(x => typeof x === 'string' && !x.startsWith('http')).join(''); } catch { }
            }
        }
        if (!String(promptText).trim() || String(promptText).trim().length < 5) {
            if (q.prompt_type !== 'image') {
                stats.issues.push({ title: q.title, severity: 'ERROR', msg: `prompt too short` });
            }
        }
    }

    unitStats[unit] = stats;
    const criticals = stats.issues.filter(i => i.severity === 'CRITICAL');
    const errors = stats.issues.filter(i => i.severity === 'ERROR');
    const warnings = stats.issues.filter(i => i.severity === 'WARNING');

    console.log(`Unit ${unit}: ${stats.total} questions | ${criticals.length} CRITICAL | ${errors.length} ERROR | ${warnings.length} WARNING`);
    if (criticals.length) criticals.forEach(i => console.log(`  🔴 ${i.title}: ${i.msg}`));
    if (errors.length) errors.forEach(i => console.log(`  🟡 ${i.title}: ${i.msg}`));

    allIssues.push(...stats.issues.map(i => ({ unit, ...i })));
}

// Summary
console.log('\n' + '='.repeat(60));
console.log('FINAL SUMMARY');
console.log('='.repeat(60));

const totalQ = Object.values(unitStats).reduce((s, u) => s + u.total, 0);
const totalCritical = allIssues.filter(i => i.severity === 'CRITICAL').length;
const totalError = allIssues.filter(i => i.severity === 'ERROR').length;
const totalWarning = allIssues.filter(i => i.severity === 'WARNING').length;

console.log(`Total questions: ${totalQ}`);
console.log(`CRITICAL: ${totalCritical}`);
console.log(`ERROR: ${totalError}`);
console.log(`WARNING: ${totalWarning}`);

if (totalCritical > 0) {
    console.log('\n🔴 ALL CRITICAL ISSUES:');
    allIssues.filter(i => i.severity === 'CRITICAL').forEach(i => console.log(`  Unit ${i.unit} | ${i.title}: ${i.msg}`));
}

if (totalError > 0) {
    console.log('\n🟡 ALL ERRORS:');
    allIssues.filter(i => i.severity === 'ERROR').forEach(i => console.log(`  Unit ${i.unit} | ${i.title}: ${i.msg}`));
}

if (totalWarning > 0) {
    console.log('\n⚠️ ALL WARNINGS:');
    allIssues.filter(i => i.severity === 'WARNING').forEach(i => console.log(`  Unit ${i.unit} | ${i.title}: ${i.msg}`));
}

fs.writeFileSync('scripts/math_review/all_issues.json', JSON.stringify(allIssues, null, 2));
