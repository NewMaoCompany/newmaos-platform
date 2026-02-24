/**
 * Universal fix script for any unit (3-10).
 * Usage: node scripts/fix_unit_N.mjs <unit_number> [--dry-run]
 * 
 * Fixes: option labels, micro_expl keys/objects/count/alignment,
 *        prompt deserialization, representation_type, answer distribution,
 *        Correct/Incorrect label alignment.
 * 
 * Also detects: duplicate option content (warns but does not auto-fix).
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const UNIT = parseInt(process.argv[2]);
if (!UNIT || UNIT < 1 || UNIT > 10) { console.error('Usage: node fix_unit_N.mjs <unit 1-10> [--dry-run]'); process.exit(1); }
const DRY_RUN = process.argv.includes('--dry-run');
const labels = ['A', 'B', 'C', 'D'];

console.log(`\n${'#'.repeat(60)}`);
console.log(`# UNIT ${UNIT} ${DRY_RUN ? '(DRY RUN)' : '(LIVE)'}`);
console.log(`${'#'.repeat(60)}\n`);

// ---- FETCH ----
const { data: rawData, error } = await sb
    .from('questions').select('*').like('title', `${UNIT}.%`).order('title');
if (error || !rawData) { console.error('Fetch failed:', error?.message); process.exit(1); }
rawData.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
console.log(`Fetched: ${rawData.length} questions`);

// ---- ANALYZE ----
const chapters = new Set();
rawData.forEach(q => { const m = q.title.match(new RegExp(`^${UNIT}\\.(\\d+)`)); if (m) chapters.add(parseInt(m[1])); });
const maxCh = Math.max(...[...chapters].filter(c => c > 0), 0);
console.log(`Chapters: ${[...chapters].sort((a, b) => a - b).join(', ')} (max=${maxCh})`);

// Current distribution
const dist = { A: 0, B: 0, C: 0, D: 0 };
rawData.forEach(q => { if (dist[q.correct_option_id] !== undefined) dist[q.correct_option_id]++; });
console.log(`Current dist: ${JSON.stringify(dist)}`);

// Course types
const courses = new Set(rawData.map(q => q.course));
console.log(`Courses: ${[...courses].join(', ')}`);

// Detect issues
let preIssues = 0;
let dupWarnings = [];
for (const q of rawData) {
    const opts = q.options || [];
    // Duplicate option content detection
    const contents = opts.map(o => (o.value || o.text || '').trim().toLowerCase());
    const seen = new Set();
    for (let i = 0; i < contents.length; i++) {
        if (contents[i] && seen.has(contents[i])) {
            dupWarnings.push(`${q.title}: duplicate option content "${contents[i].substring(0, 40)}"`);
        }
        seen.add(contents[i]);
    }
}
if (dupWarnings.length) {
    console.log(`\n⚠️ DUPLICATE OPTION WARNINGS (${dupWarnings.length}):`);
    dupWarnings.forEach(w => console.log(`  ${w}`));
}

// ---- FIX + SHUFFLE ----
function simpleHash(str) {
    let h = 0;
    for (let i = 0; i < str.length; i++) h = ((h << 5) - h + str.charCodeAt(i)) | 0;
    return Math.abs(h);
}

// Group by chapter
const chapterGroups = {};
for (const q of rawData) {
    const m = q.title.match(new RegExp(`^${UNIT}\\.(\\d+)`));
    const ch = m ? m[1] : '0';
    if (!chapterGroups[ch]) chapterGroups[ch] = [];
    chapterGroups[ch].push(q);
}

// Plan target labels
const targetDist = { A: 0, B: 0, C: 0, D: 0 };
for (const [ch, questions] of Object.entries(chapterGroups).sort((a, b) => parseInt(a[0]) - parseInt(b[0]))) {
    questions.sort((a, b) => simpleHash(a.id) - simpleHash(b.id));
    const n = questions.length;
    const chLabels = [];
    for (let i = 0; i < n; i++) {
        const sorted = labels.slice().sort((a, b) => targetDist[a] - targetDist[b]);
        chLabels.push(sorted[0]);
        targetDist[sorted[0]]++;
    }
    for (let i = chLabels.length - 1; i > 0; i--) {
        const j = simpleHash(questions[i].id + ch + UNIT) % (i + 1);
        [chLabels[i], chLabels[j]] = [chLabels[j], chLabels[i]];
    }
    questions.forEach((q, i) => { q._targetLabel = chLabels[i]; });
}
console.log(`Target dist: ${JSON.stringify(targetDist)}\n`);

let updateCount = 0, errorCount = 0, skipCount = 0;

for (const q of rawData) {
    const fixes = [];
    let prompt = q.prompt;
    let repType = q.representation_type;
    let options = q.options.map(o => ({ ...o }));
    let correctId = q.correct_option_id;
    let microExpl = q.micro_explanations ? JSON.parse(JSON.stringify(q.micro_explanations)) : {};

    // Fix 1: Prompt deserialization
    if (typeof prompt === 'string' && prompt.trim().startsWith('[')) {
        try { const p = JSON.parse(prompt); if (Array.isArray(p)) { prompt = p; fixes.push('PROMPT'); } } catch { }
    }

    // Fix 2: ME numeric keys → letter keys
    const meKeys = Object.keys(microExpl);
    if (meKeys.length > 0 && meKeys.every(k => /^\d+$/.test(k))) {
        const newME = {};
        meKeys.sort((a, b) => parseInt(a) - parseInt(b)).forEach((k, i) => { if (i < 4) newME[labels[i]] = microExpl[k]; });
        microExpl = newME;
        fixes.push('ME_KEYS');
    }

    // Fix 3: ME objects → strings
    for (const label of labels) {
        if (microExpl[label] && typeof microExpl[label] === 'object' && microExpl[label] !== null) {
            microExpl[label] = microExpl[label].text || microExpl[label].explanation || JSON.stringify(microExpl[label]);
            fixes.push('ME_OBJ');
        }
    }

    // Fix 4: Missing MEs
    for (const label of labels) {
        if (!microExpl[label]) {
            microExpl[label] = 'Review this option carefully and compare with the correct answer.';
            fixes.push(`ME_ADD_${label}`);
        }
    }

    // Fix 5: representation_type
    if (q.prompt_type === 'image' && repType === 'symbolic') { repType = 'graph'; fixes.push('REP'); }

    // Fix 6: Option labels
    let labelFixed = false;
    options.forEach((o, i) => {
        if (!o.label || o.label === 'undefined' || o.label === '') { o.label = labels[i]; o.id = labels[i]; labelFixed = true; }
    });
    if (labelFixed) fixes.push('LABELS');

    // Fix 7: Shuffle correct answer
    const target = q._targetLabel;
    if (target && target !== correctId) {
        const correctIdx = options.findIndex(o => (o.label || o.id) === correctId);
        const targetIdx = labels.indexOf(target);
        if (correctIdx !== -1 && targetIdx !== -1 && correctIdx !== targetIdx) {
            // Check for duplicate content - skip shuffle if options are identical
            const cContent = (options[correctIdx].value || options[correctIdx].text || '').trim();
            const tContent = (options[targetIdx].value || options[targetIdx].text || '').trim();
            if (cContent === tContent && cContent !== '') {
                // Skip shuffle for duplicate content options
                fixes.push(`SKIP_SHUFFLE(dup)`);
            } else {
                const temp = { ...options[correctIdx] };
                options[correctIdx] = { ...options[targetIdx] };
                options[targetIdx] = temp;
                options[correctIdx].label = labels[correctIdx]; options[correctIdx].id = labels[correctIdx];
                options[targetIdx].label = target; options[targetIdx].id = target;
                const tempME = microExpl[labels[correctIdx]];
                microExpl[labels[correctIdx]] = microExpl[target];
                microExpl[target] = tempME;
                correctId = target;
                fixes.push(`SHUF_${q.correct_option_id}->${target}`);
            }
        }
    }

    // Fix 8: Correct/Incorrect ME label alignment
    let currentCorrectMELabel = null;
    for (const label of labels) {
        if (String(microExpl[label] || '').toLowerCase().startsWith('correct')) { currentCorrectMELabel = label; break; }
    }
    if (currentCorrectMELabel && currentCorrectMELabel !== correctId) {
        const temp = microExpl[currentCorrectMELabel];
        microExpl[currentCorrectMELabel] = microExpl[correctId];
        microExpl[correctId] = temp;
        fixes.push('ME_ALIGN');
    }

    if (fixes.length === 0) { skipCount++; continue; }

    const update = { prompt, representation_type: repType, options, correct_option_id: correctId, micro_explanations: microExpl };

    if (!DRY_RUN) {
        const { error: e } = await sb.from('questions').update(update).eq('id', q.id);
        if (e) { console.error(`❌ ${q.title}: ${e.message}`); errorCount++; }
        else { updateCount++; }
    } else { updateCount++; }
}

console.log(`\n${DRY_RUN ? '[DRY] ' : ''}Updated: ${updateCount}, Skipped: ${skipCount}, Errors: ${errorCount}`);

// ---- VERIFY ----
if (!DRY_RUN) {
    console.log('\n--- VERIFICATION ---');
    const { data: vData } = await sb.from('questions').select('*').like('title', `${UNIT}.%`).order('title');
    vData.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
    const vDist = { A: 0, B: 0, C: 0, D: 0 };
    vData.forEach(q => vDist[q.correct_option_id]++);
    console.log(`Dist: ${JSON.stringify(vDist)}`);

    let vIssues = 0;
    for (const q of vData) {
        const me = q.micro_explanations || {};
        for (let i = 0; i < q.options.length; i++) {
            if (!q.options[i].label || q.options[i].label === 'undefined') { vIssues++; console.log(`  ⚠️ ${q.title}: opt ${i} no label`); }
        }
        if (Object.keys(me).length < 4) { vIssues++; console.log(`  ⚠️ ${q.title}: ${Object.keys(me).length} MEs`); }
        for (const label of labels) {
            const t = String(me[label] || '');
            if (label === q.correct_option_id && t.toLowerCase().startsWith('incorrect')) { vIssues++; console.log(`  ⚠️ ${q.title}: correct ${label} says Incorrect`); }
            if (label !== q.correct_option_id && t.toLowerCase().startsWith('correct')) { vIssues++; console.log(`  ⚠️ ${q.title}: wrong ${label} says Correct`); }
        }
        if (!(q.options || []).find(o => o.label === q.correct_option_id)) { vIssues++; console.log(`  ⚠️ ${q.title}: correct not in opts`); }
        for (const opt of (q.options || [])) {
            if (!(opt.value || opt.text || '').trim()) { vIssues++; console.log(`  ⚠️ ${q.title}: opt ${opt.label} empty`); }
        }
    }

    // Images
    const imgs = vData.filter(q => q.prompt_type === 'image');
    const imgOk = imgs.filter(q => String(q.prompt).includes('https://'));
    const imgBad = imgs.filter(q => !String(q.prompt).includes('https://'));
    if (imgBad.length) { console.log(`Images: ${imgOk.length} ok, ${imgBad.length} missing`); imgBad.forEach(q => console.log(`  ❌ ${q.title}`)); }

    // Duplicates (warning only)
    let dupCount = 0;
    for (const q of vData) {
        const contents = q.options.map(o => (o.value || o.text || '').trim().toLowerCase());
        if (new Set(contents).size < contents.filter(c => c).length) dupCount++;
    }

    // Per-chapter dist
    const vCh = {};
    vData.forEach(q => { const m = q.title.match(new RegExp(`^${UNIT}\\.(\\d+)`)); const ch = m ? m[1] : '?'; if (!vCh[ch]) vCh[ch] = { A: 0, B: 0, C: 0, D: 0, t: 0 }; vCh[ch][q.correct_option_id]++; vCh[ch].t++; });
    Object.entries(vCh).sort((a, b) => parseInt(a[0]) - parseInt(b[0])).forEach(([ch, d]) => {
        console.log(`  Ch${ch.padStart(2)}: A=${d.A} B=${d.B} C=${d.C} D=${d.D} (${d.t})`);
    });

    console.log(`\nIssues: ${vIssues} | Dup warnings: ${dupCount}`);
    console.log(vIssues === 0 ? '✅ PASS' : `❌ ${vIssues} ISSUES`);
}
