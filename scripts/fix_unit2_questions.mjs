/**
 * Comprehensive analysis + fix for Unit 2 questions
 * Same pipeline as Unit 1: dump → analyze → fix → verify
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const labels = ['A', 'B', 'C', 'D'];
const DRY_RUN = process.argv.includes('--dry-run');

// ===================== STEP 1: FETCH =====================
const { data: rawData, error } = await sb
    .from('questions')
    .select('*')
    .like('title', '2.%')
    .order('title', { ascending: true });

if (error || !rawData) { console.error('Fetch failed:', error?.message); process.exit(1); }
rawData.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
console.log(`Fetched ${rawData.length} Unit 2 questions\n`);

fs.writeFileSync('scripts/unit2_questions_dump.json', JSON.stringify(rawData, null, 2));

// ===================== STEP 2: ANALYZE =====================
console.log('=== INITIAL ANALYSIS ===\n');

// 2a. Title coverage
const existingTitles = new Set(rawData.map(q => q.title));
const expectedTitles = [];
for (let i = 1; i <= 20; i++) expectedTitles.push(`2.0-UT-Q${i}`);

// Need to figure out how many chapters Unit 2 has. Check what we have:
const chapters = new Set();
rawData.forEach(q => {
    const m = q.title.match(/^2\.(\d+)/);
    if (m) chapters.add(parseInt(m[1]));
});
const sortedChapters = [...chapters].sort((a, b) => a - b);
const maxCh = Math.max(...sortedChapters.filter(c => c > 0));
console.log(`Chapters found: ${sortedChapters.join(', ')} (max non-UT: ${maxCh})`);

for (let ch = 1; ch <= maxCh; ch++) {
    for (let p = 1; p <= 5; p++) expectedTitles.push(`2.${ch}-P${p}`);
}

const missing = expectedTitles.filter(t => !existingTitles.has(t));
const extra = [...existingTitles].filter(t => !expectedTitles.includes(t));
console.log(`Expected: ${expectedTitles.length}, Found: ${rawData.length}`);
if (missing.length) console.log(`MISSING (${missing.length}): ${missing.join(', ')}`);
if (extra.length) console.log(`EXTRA (${extra.length}): ${extra.join(', ')}`);

// 2b. Current distribution
const currentDist = { A: 0, B: 0, C: 0, D: 0 };
rawData.forEach(q => { if (currentDist[q.correct_option_id] !== undefined) currentDist[q.correct_option_id]++; });
console.log(`\nCurrent distribution: ${JSON.stringify(currentDist)}`);

// 2c. Issues scan
let issues = [];
for (const q of rawData) {
    const t = q.title;
    const opts = q.options || [];
    const me = q.micro_explanations || {};
    const meKeys = Object.keys(me);

    // Option count
    if (opts.length !== 4) issues.push(`${t}: ${opts.length} options instead of 4`);

    // Option labels
    for (let i = 0; i < opts.length; i++) {
        if (!opts[i].label || opts[i].label === 'undefined') {
            issues.push(`${t}: option ${i} has undefined label`);
            break;
        }
    }

    // Option content
    for (const opt of opts) {
        if (!(opt.value || opt.text || '').trim()) issues.push(`${t}: option ${opt.label || opt.id} has no content`);
    }

    // correct_option_id
    if (!opts.find(o => o.label === q.correct_option_id || o.id === q.correct_option_id))
        issues.push(`${t}: correct_option_id "${q.correct_option_id}" not in options`);

    // micro_explanations format
    if (meKeys.some(k => /^\d+$/.test(k))) issues.push(`${t}: micro_explanations uses numeric keys`);
    if (meKeys.length < 4 && meKeys.length > 0) issues.push(`${t}: only ${meKeys.length} micro_explanations`);
    if (!me[q.correct_option_id]) {
        // Check if any value is an object
        const hasObjValues = Object.values(me).some(v => typeof v === 'object' && v !== null);
        if (hasObjValues) issues.push(`${t}: micro_explanations values are objects (not strings)`);
    }

    // Correct/Incorrect label mismatch
    for (const label of labels) {
        const text = String(me[label] || '');
        if (label === q.correct_option_id && text.toLowerCase().startsWith('incorrect'))
            issues.push(`${t}: correct answer ${label} ME says "Incorrect"!`);
        if (label !== q.correct_option_id && text.toLowerCase().startsWith('correct'))
            issues.push(`${t}: wrong answer ${label} ME says "Correct"!`);
    }

    // Prompt
    if (typeof q.prompt === 'string' && q.prompt.trim().startsWith('[')) {
        try { JSON.parse(q.prompt); issues.push(`${t}: prompt is double-serialized JSON string`); } catch { }
    }

    // prompt_type vs representation_type
    if (q.prompt_type === 'image' && q.representation_type === 'symbolic')
        issues.push(`${t}: prompt_type=image but rep_type=symbolic`);

    // Missing fields
    if (!q.primary_skill_id) issues.push(`${t}: missing primary_skill_id`);
    if (!q.explanation) issues.push(`${t}: missing explanation`);
    if (q.status !== 'published') issues.push(`${t}: status="${q.status}"`);
}

console.log(`\nIssues found: ${issues.length}`);
issues.forEach(i => console.log(`  ❌ ${i}`));

// ===================== STEP 3: FIX =====================
console.log('\n=== APPLYING FIXES ===\n');

function simpleHash(str) {
    let h = 0;
    for (let i = 0; i < str.length; i++) h = ((h << 5) - h + str.charCodeAt(i)) | 0;
    return Math.abs(h);
}

// Group by chapter for balanced distribution
const chapterGroups = {};
for (const q of rawData) {
    const m = q.title.match(/^2\.(\d+)/);
    const ch = m ? m[1] : '0';
    if (!chapterGroups[ch]) chapterGroups[ch] = [];
    chapterGroups[ch].push(q);
}

// Plan target labels for uniform distribution
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
        const j = simpleHash(questions[i].id + ch) % (i + 1);
        [chLabels[i], chLabels[j]] = [chLabels[j], chLabels[i]];
    }
    questions.forEach((q, i) => { q._targetLabel = chLabels[i]; });
}

console.log(`Target distribution: ${JSON.stringify(targetDist)}`);

let updateCount = 0, errorCount = 0;

for (const q of rawData) {
    const fixes = [];
    let prompt = q.prompt;
    let repType = q.representation_type;
    let options = q.options.map(o => ({ ...o }));
    let correctId = q.correct_option_id;
    let microExpl = q.micro_explanations ? { ...q.micro_explanations } : {};

    // Fix 1: Prompt deserialization
    if (typeof prompt === 'string' && prompt.trim().startsWith('[')) {
        try {
            const parsed = JSON.parse(prompt);
            if (Array.isArray(parsed)) { prompt = parsed; fixes.push('PROMPT_DESER'); }
        } catch { }
    }

    // Fix 2: micro_explanations numeric keys
    const meKeys = Object.keys(microExpl);
    if (meKeys.every(k => /^\d+$/.test(k)) && meKeys.length > 0) {
        const newME = {};
        meKeys.sort((a, b) => parseInt(a) - parseInt(b)).forEach((k, i) => {
            if (i < 4) newME[labels[i]] = microExpl[k];
        });
        microExpl = newME;
        fixes.push('ME_KEYS');
    }

    // Fix 3: micro_explanations objects → strings
    for (const label of labels) {
        if (microExpl[label] && typeof microExpl[label] === 'object' && microExpl[label].text) {
            microExpl[label] = microExpl[label].text;
            fixes.push('ME_OBJ');
        }
    }

    // Fix 4: Missing micro_explanations
    for (const label of labels) {
        if (!microExpl[label]) {
            microExpl[label] = 'Review this option carefully and compare with the correct answer.';
            fixes.push(`ME_ADD_${label}`);
        }
    }

    // Fix 5: representation_type
    if (q.prompt_type === 'image' && repType === 'symbolic') {
        repType = 'graph';
        fixes.push('REP_TYPE');
    }

    // Fix 6: Option labels
    let labelFixed = false;
    options.forEach((o, i) => {
        if (!o.label || o.label === 'undefined') {
            o.label = labels[i];
            o.id = labels[i];
            labelFixed = true;
        }
    });
    if (labelFixed) fixes.push('OPT_LABELS');

    // Fix 7: Shuffle correct answer to target
    const target = q._targetLabel;
    if (target && target !== correctId) {
        const correctIdx = options.findIndex(o => (o.label || o.id) === correctId);
        const targetIdx = labels.indexOf(target);

        if (correctIdx !== -1 && targetIdx !== -1 && correctIdx !== targetIdx) {
            // Swap options
            const temp = { ...options[correctIdx] };
            options[correctIdx] = { ...options[targetIdx] };
            options[targetIdx] = temp;

            // Update labels after swap
            options[correctIdx].label = labels[correctIdx];
            options[correctIdx].id = labels[correctIdx];
            options[targetIdx].label = target;
            options[targetIdx].id = target;

            // Swap ALL micro_explanations together
            const tempME = microExpl[labels[correctIdx]];
            microExpl[labels[correctIdx]] = microExpl[target];
            microExpl[target] = tempME;

            correctId = target;
            fixes.push(`SHUFFLE_${q.correct_option_id}->${target}`);
        }
    }

    // Fix 8: Correct/Incorrect label alignment
    // Find which ME currently says "Correct"
    let currentCorrectMELabel = null;
    for (const label of labels) {
        if (String(microExpl[label] || '').toLowerCase().startsWith('correct')) {
            currentCorrectMELabel = label;
            break;
        }
    }
    if (currentCorrectMELabel && currentCorrectMELabel !== correctId) {
        const temp = microExpl[currentCorrectMELabel];
        microExpl[currentCorrectMELabel] = microExpl[correctId];
        microExpl[correctId] = temp;
        fixes.push('ME_LABEL_FIX');
    }

    if (fixes.length === 0) continue;

    const update = {
        prompt,
        representation_type: repType,
        options,
        correct_option_id: correctId,
        micro_explanations: microExpl,
    };

    console.log(`${q.title}: ${fixes.join(', ')}`);

    if (!DRY_RUN) {
        const { error: updErr } = await sb.from('questions').update(update).eq('id', q.id);
        if (updErr) { console.error(`  ❌ ${updErr.message}`); errorCount++; }
        else updateCount++;
    } else {
        updateCount++;
    }
}

console.log(`\n${DRY_RUN ? '[DRY RUN] ' : ''}Updated: ${updateCount}, Errors: ${errorCount}`);

// ===================== STEP 4: VERIFY =====================
if (!DRY_RUN) {
    console.log('\n=== POST-FIX VERIFICATION ===\n');
    const { data: verifyData } = await sb.from('questions').select('*').like('title', '2.%').order('title');
    verifyData.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));

    // Distribution
    const vDist = { A: 0, B: 0, C: 0, D: 0 };
    verifyData.forEach(q => vDist[q.correct_option_id]++);
    console.log(`Distribution: ${JSON.stringify(vDist)}`);

    // Per-chapter
    const vChapters = {};
    verifyData.forEach(q => {
        const m = q.title.match(/^2\.(\d+)/);
        const ch = m ? m[1] : '?';
        if (!vChapters[ch]) vChapters[ch] = { A: 0, B: 0, C: 0, D: 0, total: 0 };
        vChapters[ch][q.correct_option_id]++;
        vChapters[ch].total++;
    });
    Object.entries(vChapters).sort((a, b) => parseInt(a[0]) - parseInt(b[0])).forEach(([ch, d]) => {
        console.log(`  Ch ${ch.padStart(2)}: A=${d.A} B=${d.B} C=${d.C} D=${d.D} (total=${d.total})`);
    });

    // Issues
    let vIssues = 0;
    for (const q of verifyData) {
        const me = q.micro_explanations || {};
        // Check labels
        for (let i = 0; i < q.options.length; i++) {
            if (!q.options[i].label || q.options[i].label === 'undefined') { vIssues++; console.log(`  ⚠️ ${q.title}: option ${i} undefined label`); }
        }
        // Check ME count
        if (Object.keys(me).length < 4) { vIssues++; console.log(`  ⚠️ ${q.title}: ${Object.keys(me).length} MEs`); }
        // Check ME correct/incorrect mismatch
        for (const label of labels) {
            const text = String(me[label] || '');
            if (label === q.correct_option_id && text.toLowerCase().startsWith('incorrect')) { vIssues++; console.log(`  ⚠️ ${q.title}: correct ${label} says Incorrect`); }
            if (label !== q.correct_option_id && text.toLowerCase().startsWith('correct')) { vIssues++; console.log(`  ⚠️ ${q.title}: wrong ${label} says Correct`); }
        }
        // Check options content
        for (const opt of q.options) {
            if (!(opt.value || opt.text || '').trim()) { vIssues++; console.log(`  ⚠️ ${q.title}: option ${opt.label} empty`); }
        }
        // Check correct_option_id in options
        if (!q.options.find(o => o.label === q.correct_option_id)) { vIssues++; console.log(`  ⚠️ ${q.title}: correct not in options`); }
    }

    // Images
    const imageQs = verifyData.filter(q => q.prompt_type === 'image');
    const imgWithUrl = imageQs.filter(q => String(q.prompt).includes('https://'));
    const imgNoUrl = imageQs.filter(q => !String(q.prompt).includes('https://'));
    console.log(`\nImages: ${imgWithUrl.length} with URL, ${imgNoUrl.length} without`);
    imgNoUrl.forEach(q => console.log(`  ❌ ${q.title}: no image URL`));

    console.log(`\nTotal verification issues: ${vIssues}`);
    console.log(vIssues === 0 ? '🎉 ALL CHECKS PASSED!' : `⚠️ ${vIssues} issues remain`);
}
