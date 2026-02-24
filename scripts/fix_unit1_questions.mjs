/**
 * Comprehensive fix script for Unit 1 questions
 * 
 * Fixes:
 * 1. Prompt double-serialization (string → array)
 * 2. micro_explanations numeric keys → letter keys (A,B,C,D)
 * 3. Missing micro_explanations (add 4th for 3-key entries)
 * 4. representation_type: symbolic → graphical for image questions
 * 5. Uniform distribution of correct answers (shuffle options to balance A/B/C/D)
 * 
 * After shuffling, micro_explanations and option.explanation are updated accordingly.
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const DRY_RUN = process.argv.includes('--dry-run');
const labels = ['A', 'B', 'C', 'D'];

// ---- STEP 1: Fetch all Unit 1 questions ----
const { data: rawData, error } = await sb
    .from('questions')
    .select('*')
    .like('title', '1.%')
    .order('title', { ascending: true });

if (error || !rawData) {
    console.error('Fetch failed:', error?.message);
    process.exit(1);
}

console.log(`Fetched ${rawData.length} questions\n`);

// ---- STEP 2: Analyze current correct answer distribution ----
const currentDist = { A: 0, B: 0, C: 0, D: 0 };
rawData.forEach(q => currentDist[q.correct_option_id]++);
console.log('Current distribution:', JSON.stringify(currentDist));

// ---- STEP 3: Plan target distribution (25 each for 100 questions) ----
// Shuffle all questions to randomize, then assign correct answers cyclically
// But we need to be smart: only shuffle when needed, and keep content correct

// First: fix all data issues, THEN redistribute correct answers
const fixedData = rawData.map(q => {
    const fixes = [];
    let prompt = q.prompt;
    let promptType = q.prompt_type;
    let repType = q.representation_type;
    let microExpl = q.micro_explanations ? { ...q.micro_explanations } : {};
    let options = q.options ? q.options.map(o => ({ ...o })) : [];
    let correctId = q.correct_option_id;

    // ---- FIX 1: Double-serialized prompt ----
    if (typeof prompt === 'string') {
        const trimmed = prompt.trim();
        if (trimmed.startsWith('[')) {
            try {
                const parsed = JSON.parse(trimmed);
                if (Array.isArray(parsed)) {
                    prompt = parsed;
                    fixes.push('PROMPT_DESERIALIZED');
                }
            } catch { }
        }
    }

    // ---- FIX 2: micro_explanations numeric keys → letter keys ----
    const meKeys = Object.keys(microExpl);
    const isNumeric = meKeys.length > 0 && meKeys.every(k => /^\d+$/.test(k));
    if (isNumeric) {
        const newME = {};
        meKeys.sort((a, b) => parseInt(a) - parseInt(b)).forEach((k, i) => {
            if (i < 4) newME[labels[i]] = microExpl[k];
        });
        microExpl = newME;
        fixes.push('MICRO_EXPL_KEYS_FIXED');
    }

    // ---- FIX 3: Missing micro_explanations ----
    const meLabels = Object.keys(microExpl);
    if (meLabels.length < 4 && meLabels.length > 0) {
        for (const label of labels) {
            if (!microExpl[label]) {
                // Generate a generic explanation for the missing option
                const opt = options.find(o => o.label === label || o.id === label);
                const optContent = opt ? (opt.value || opt.text || '') : '';
                microExpl[label] = `Review this option carefully and compare with the correct answer.`;
                fixes.push(`MICRO_EXPL_ADDED_${label}`);
            }
        }
    }

    // ---- FIX 4: representation_type for image questions ----
    if (promptType === 'image' && repType === 'symbolic') {
        repType = 'graph';
        fixes.push('REP_TYPE_FIXED');
    }

    return {
        ...q,
        prompt,
        prompt_type: promptType,
        representation_type: repType,
        micro_explanations: microExpl,
        options,
        correct_option_id: correctId,
        _fixes: fixes,
    };
});

// ---- STEP 4: Redistribute correct answers for uniform distribution ----
// Sort questions in a deterministic but shuffled way using their title hash
function simpleHash(str) {
    let h = 0;
    for (let i = 0; i < str.length; i++) h = ((h << 5) - h + str.charCodeAt(i)) | 0;
    return Math.abs(h);
}

// Group by chapter to ensure per-chapter balance too (each chapter has 5 questions → ~1-2 of each label)
const chapters = {};
for (const q of fixedData) {
    const m = q.title.match(/^1\.(\d+)/);
    const ch = m ? m[1] : '0';
    if (!chapters[ch]) chapters[ch] = [];
    chapters[ch].push(q);
}

// For each chapter, assign labels as evenly as possible
const targetDist = { A: 0, B: 0, C: 0, D: 0 };
const shuffledLabels = [];

for (const [ch, questions] of Object.entries(chapters).sort((a, b) => parseInt(a[0]) - parseInt(b[0]))) {
    // Shuffle questions within chapter based on hash
    questions.sort((a, b) => simpleHash(a.id) - simpleHash(b.id));

    // Determine target labels for this chapter
    const n = questions.length;
    const chLabels = [];
    // Fill as evenly as possible
    for (let i = 0; i < n; i++) {
        // Pick the label with the lowest global count
        const sorted = labels.slice().sort((a, b) => targetDist[a] - targetDist[b]);
        chLabels.push(sorted[0]);
        targetDist[sorted[0]]++;
    }

    // Shuffle chapter labels randomly using seeded approach
    for (let i = chLabels.length - 1; i > 0; i--) {
        const j = simpleHash(questions[i].id + ch) % (i + 1);
        [chLabels[i], chLabels[j]] = [chLabels[j], chLabels[i]];
    }

    // Apply label assignments
    questions.forEach((q, i) => {
        q._targetLabel = chLabels[i];
    });
}

console.log('Target distribution:', JSON.stringify(targetDist));

// ---- STEP 5: Shuffle options to match target labels ----
for (const q of fixedData) {
    const target = q._targetLabel;
    const current = q.correct_option_id;

    if (target === current) {
        // No change needed
        continue;
    }

    // Find the correct option and the option currently in the target position
    const correctIdx = q.options.findIndex(o => o.label === current || o.id === current);
    const targetIdx = labels.indexOf(target);

    if (correctIdx === -1 || targetIdx === -1) continue;

    // Swap options
    const opts = q.options;
    const temp = { ...opts[correctIdx] };
    opts[correctIdx] = { ...opts[targetIdx] };
    opts[targetIdx] = temp;

    // Update labels
    opts[correctIdx].label = labels[correctIdx];
    opts[correctIdx].id = labels[correctIdx];
    opts[targetIdx].label = target;
    opts[targetIdx].id = target;

    // Update micro_explanations: swap the corresponding keys
    const me = q.micro_explanations;
    const currentLabel = labels[correctIdx];
    const targetLabel = target;
    const tempME = me[currentLabel];
    me[currentLabel] = me[targetLabel];
    me[targetLabel] = tempME;

    // Update correct_option_id
    q.correct_option_id = target;
    q._fixes.push(`ANSWER_SHUFFLED_${current}->${target}`);
}

// ---- STEP 6: Verify final distribution ----
const finalDist = { A: 0, B: 0, C: 0, D: 0 };
fixedData.forEach(q => finalDist[q.correct_option_id]++);
console.log('Final distribution:', JSON.stringify(finalDist));

// ---- STEP 7: Write updates to DB ----
let updateCount = 0;
let errorCount = 0;

for (const q of fixedData) {
    if (q._fixes.length === 0) continue;

    const update = {
        prompt: q.prompt,
        prompt_type: q.prompt_type,
        representation_type: q.representation_type,
        micro_explanations: q.micro_explanations,
        options: q.options,
        correct_option_id: q.correct_option_id,
    };

    console.log(`${q.title}: ${q._fixes.join(', ')}`);

    if (!DRY_RUN) {
        const { error: updErr } = await sb
            .from('questions')
            .update(update)
            .eq('id', q.id);

        if (updErr) {
            console.error(`  ❌ Update failed: ${updErr.message}`);
            errorCount++;
        } else {
            updateCount++;
        }
    } else {
        updateCount++;
    }
}

console.log(`\n${DRY_RUN ? '[DRY RUN] ' : ''}Updated: ${updateCount}, Errors: ${errorCount}`);

// ---- STEP 8: Final validation -----
console.log('\n=== FINAL VALIDATION ===');
let validationIssues = 0;

for (const q of fixedData) {
    // Check correct_option_id in options
    const correctOpt = q.options.find(o => o.label === q.correct_option_id || o.id === q.correct_option_id);
    if (!correctOpt) {
        console.log(`❌ ${q.title}: correct_option_id "${q.correct_option_id}" not found in options`);
        validationIssues++;
    }

    // Check micro_explanations has all 4 keys
    const meKeys = Object.keys(q.micro_explanations || {});
    if (meKeys.length < 4) {
        console.log(`⚠️ ${q.title}: only ${meKeys.length} micro_explanations (keys: ${meKeys.join(',')})`);
        validationIssues++;
    }

    // Check all options have content
    for (const opt of q.options) {
        if (!(opt.value || opt.text || '').trim()) {
            console.log(`❌ ${q.title}: Option ${opt.label} has no content`);
            validationIssues++;
        }
    }

    // Check prompt is not double-serialized
    if (typeof q.prompt === 'string' && q.prompt.trim().startsWith('[')) {
        try {
            JSON.parse(q.prompt);
            console.log(`⚠️ ${q.title}: prompt is still a JSON string`);
            validationIssues++;
        } catch { }
    }
}

console.log(`\nValidation issues: ${validationIssues}`);
if (validationIssues === 0) {
    console.log('✅ All validations passed!');
}
