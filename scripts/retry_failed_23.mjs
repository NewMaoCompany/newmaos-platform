/**
 * Retry: Fix the 23 questions that failed due to representation_type constraint.
 * These need: prompt deserialization + representation_type change to 'graph'
 * Also apply any pending answer shuffle changes for these questions.
 */
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const labels = ['A', 'B', 'C', 'D'];

// These 23 titles failed - fetch their current state (which was NOT updated)
const failedTitles = [
    '1.0-UT-Q10', '1.0-UT-Q18', '1.0-UT-Q4',
    '1.10-P1', '1.10-P3',
    '1.11-P2',
    '1.12-P3',
    '1.15-P2', '1.15-P3',
    '1.16-P3', '1.16-P5',
    '1.3-P1', '1.3-P2', '1.3-P3', '1.3-P4', '1.3-P5',
    '1.5-P2',
    '1.6-P5',
    '1.7-P1',
    '1.8-P2', '1.8-P3',
    '1.9-P1', '1.9-P4'
];

// Target answers for these questions (from the dry-run plan)
const targetAnswers = {
    '1.0-UT-Q10': null, // No shuffle, just fix prompt + rep_type
    '1.0-UT-Q18': 'D',  // B->D
    '1.0-UT-Q4': 'D',   // C->D
    '1.10-P1': 'B',     // D->B
    '1.10-P3': 'A',     // C->A
    '1.11-P2': null,    // Just fix
    '1.12-P3': 'C',     // D->C
    '1.15-P2': 'B',     // A->B
    '1.15-P3': 'C',     // D->C
    '1.16-P3': 'C',     // A->C
    '1.16-P5': 'D',     // C->D
    '1.3-P1': 'C',      // A->C
    '1.3-P2': 'A',      // C->A
    '1.3-P3': 'C',      // B->C
    '1.3-P4': 'B',      // C->B
    '1.3-P5': 'D',      // B->D
    '1.5-P2': 'A',      // B->A
    '1.6-P5': 'C',      // B->C
    '1.7-P1': 'C',      // A->C
    '1.8-P2': 'A',      // B->A
    '1.8-P3': 'B',      // D->B
    '1.9-P1': null,     // Just fix
    '1.9-P4': null,     // Just fix
};

let success = 0, fail = 0;

for (const title of failedTitles) {
    const { data: q, error: qErr } = await sb
        .from('questions')
        .select('*')
        .eq('title', title)
        .single();

    if (qErr || !q) {
        console.error(`Failed to fetch ${title}: ${qErr?.message}`);
        fail++;
        continue;
    }

    let prompt = q.prompt;
    let options = q.options.map(o => ({ ...o }));
    let correctId = q.correct_option_id;
    let microExpl = q.micro_explanations ? { ...q.micro_explanations } : {};
    const fixes = [];

    // Fix 1: Deserialize prompt
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

    // Fix 2: Shuffle answer if needed
    const target = targetAnswers[title];
    if (target && target !== correctId) {
        const currentIdx = options.findIndex(o => o.label === correctId || o.id === correctId);
        const targetIdx = labels.indexOf(target);

        if (currentIdx !== -1 && targetIdx !== -1) {
            // Swap options
            const temp = { ...options[currentIdx] };
            options[currentIdx] = { ...options[targetIdx] };
            options[targetIdx] = temp;

            // Update labels
            options[currentIdx].label = labels[currentIdx];
            options[currentIdx].id = labels[currentIdx];
            options[targetIdx].label = target;
            options[targetIdx].id = target;

            // Swap micro_explanations
            const currentLabel = labels[currentIdx];
            const tempME = microExpl[currentLabel];
            microExpl[currentLabel] = microExpl[target];
            microExpl[target] = tempME;

            correctId = target;
            fixes.push(`SHUFFLED_${q.correct_option_id}->${target}`);
        }
    }

    const update = {
        prompt,
        representation_type: 'graph',
        options,
        correct_option_id: correctId,
        micro_explanations: microExpl,
    };

    fixes.push('REP_TYPE->graph');

    const { error: updErr } = await sb.from('questions').update(update).eq('id', q.id);

    if (updErr) {
        console.error(`❌ ${title}: ${updErr.message}`);
        fail++;
    } else {
        console.log(`✅ ${title}: ${fixes.join(', ')}`);
        success++;
    }
}

console.log(`\nDone: ✅ ${success} | ❌ ${fail}`);
