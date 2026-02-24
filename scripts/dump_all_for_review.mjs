/**
 * Dump ALL questions (Units 1-10) with full detail for mathematical verification.
 * Outputs per-unit files in scripts/math_review/
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

fs.mkdirSync('scripts/math_review', { recursive: true });

const allIssues = [];
let totalQ = 0;

for (let unit = 1; unit <= 10; unit++) {
    const { data, error } = await sb.from('questions').select('*').like('title', `${unit}.%`).order('title');
    if (error) { console.error(`Unit ${unit}: ${error.message}`); continue; }
    data.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
    totalQ += data.length;

    let report = `UNIT ${unit} MATHEMATICAL REVIEW (${data.length} questions)\n${'='.repeat(60)}\n`;

    for (const q of data) {
        let promptText = '', promptImage = '';
        if (typeof q.prompt === 'string') {
            const t = q.prompt.trim();
            if (t.startsWith('[')) {
                try { const p = JSON.parse(t); if (Array.isArray(p)) { for (const x of p) { if (typeof x === 'string' && x.startsWith('http')) promptImage = x; else promptText += x; } } } catch { promptText = q.prompt; }
            } else { promptText = q.prompt; }
        } else if (Array.isArray(q.prompt)) {
            for (const x of q.prompt) { if (typeof x === 'string' && x.startsWith('http')) promptImage = x; else promptText += x; }
        }

        const opts = q.options || [];
        const me = q.micro_explanations || {};
        const correctOpt = opts.find(o => o.label === q.correct_option_id);
        const correctContent = correctOpt ? (correctOpt.value || correctOpt.text || '') : 'N/A';
        const expl = q.explanation || '';

        report += `\n--- ${q.title} [${q.difficulty}/${q.reasoning_level}] [${q.course}] ---\n`;
        report += `PROMPT: ${promptText}\n`;
        if (promptImage) report += `IMAGE: ${promptImage.substring(0, 60)}...\n`;
        report += `CORRECT: ${q.correct_option_id} = "${correctContent}"\n`;
        for (const opt of opts) {
            const l = opt.label || opt.id;
            const c = opt.value || opt.text || '';
            report += `  ${l}${l === q.correct_option_id ? ' ✓' : ' '}: ${c}\n`;
        }
        report += `EXPLANATION: ${expl}\n`;
        report += `MICRO:\n`;
        for (const l of ['A', 'B', 'C', 'D']) {
            report += `  ${l}: ${String(me[l] || '(none)').substring(0, 150)}\n`;
        }

        // ---- Automated consistency checks ----
        const issues = [];

        // Check 1: Does explanation reference the correct answer value?
        const correctClean = correctContent.replace(/\$/g, '').replace(/\\text\{[^}]*\}/g, '').replace(/\\[a-z]+/g, '').replace(/[{}]/g, '').trim();
        if (correctClean && expl && correctClean.length > 1) {
            // Very basic check - does the explanation contain the answer value?
            const explClean = expl.replace(/\$/g, '').replace(/\\text\{[^}]*\}/g, '').replace(/\\[a-z]+/g, '').replace(/[{}]/g, '');
            // Skip this check for very short answers or "Does not exist" type
        }

        // Check 2: Does the correct option's ME say "Incorrect"?
        const correctME = String(me[q.correct_option_id] || '');
        if (correctME.toLowerCase().startsWith('incorrect')) {
            issues.push(`CRITICAL: correct answer ME says "Incorrect"`);
        }

        // Check 3: Does any wrong option's ME say "Correct"?
        for (const l of ['A', 'B', 'C', 'D']) {
            if (l !== q.correct_option_id && String(me[l] || '').toLowerCase().startsWith('correct')) {
                issues.push(`CRITICAL: wrong option ${l} ME says "Correct"`);
            }
        }

        // Check 4: Empty explanation
        if (!expl || expl.length < 10) issues.push(`WARNING: explanation too short or missing`);

        // Check 5: Explanation mentions wrong answer as correct
        // e.g., if explanation says "the answer is B" but correct is C
        const explLower = expl.toLowerCase();
        for (const l of ['A', 'B', 'C', 'D']) {
            if (l !== q.correct_option_id) {
                // Check for patterns like "answer is B", "option B is correct"
                const patterns = [`answer is ${l.toLowerCase()}`, `option ${l.toLowerCase()} is correct`, `${l.toLowerCase()}) is correct`];
                for (const p of patterns) {
                    if (explLower.includes(p)) issues.push(`WARNING: explanation may reference ${l} as correct`);
                }
            }
        }

        // Check 6: Duplicate options
        const optContents = opts.map(o => (o.value || o.text || '').trim());
        const uniqueContents = new Set(optContents.filter(c => c));
        if (uniqueContents.size < optContents.filter(c => c).length) {
            const dupes = optContents.filter((c, i) => c && optContents.indexOf(c) !== i);
            issues.push(`WARNING: duplicate option content: "${dupes[0]?.substring(0, 30)}"`);
        }

        // Check 7: Options with no content
        for (const opt of opts) {
            if (!(opt.value || opt.text || '').trim()) issues.push(`ERROR: option ${opt.label} has no content`);
        }

        // Check 8: Prompt is empty or extremely short
        if (!promptText || promptText.trim().length < 5) {
            if (!promptImage) issues.push(`ERROR: prompt is empty or too short`);
        }

        if (issues.length > 0) {
            report += `⚠️ ISSUES:\n`;
            issues.forEach(i => report += `  ${i}\n`);
            allIssues.push(...issues.map(i => `${q.title}: ${i}`));
        }
    }

    fs.writeFileSync(`scripts/math_review/unit${unit}.txt`, report);
    console.log(`Unit ${unit}: ${data.length} questions dumped`);
}

console.log(`\nTotal: ${totalQ} questions`);
console.log(`\nAll automated issues (${allIssues.length}):`);
allIssues.forEach(i => console.log(`  ${i}`));

// Save issues
fs.writeFileSync('scripts/math_review/auto_issues.json', JSON.stringify(allIssues, null, 2));
