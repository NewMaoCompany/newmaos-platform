/**
 * Fix micro_explanations: ensure that the micro_explanation 
 * for the correct_option_id says "Correct" and all others say "Incorrect"
 * 
 * Strategy:
 * - For each question, find which ME currently says "Correct" 
 * - If it's the WRONG key, swap its content with the correct key's content
 * - This ensures the substantive explanation follows the correct option
 */
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const DRY_RUN = process.argv.includes('--dry-run');
const labels = ['A', 'B', 'C', 'D'];

const { data, error } = await sb.from('questions').select('*').like('title', '1.%').order('title');
if (error) { console.error(error.message); process.exit(1); }
data.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));

let fixCount = 0, skipCount = 0, errorCount = 0;

for (const q of data) {
    const me = q.micro_explanations ? { ...q.micro_explanations } : {};
    const correctId = q.correct_option_id;
    const meKeys = Object.keys(me);
    if (meKeys.length < 4) continue;

    // Find which label currently has "Correct" in its ME
    let currentCorrectLabel = null;
    for (const label of labels) {
        const text = String(me[label] || '');
        if (text.toLowerCase().startsWith('correct')) {
            currentCorrectLabel = label;
            break;
        }
    }

    // Check if correct label's ME says "Incorrect"
    const correctME = String(me[correctId] || '');
    const correctMESaysIncorrect = correctME.toLowerCase().startsWith('incorrect');

    // If already aligned, skip
    if (currentCorrectLabel === correctId && !correctMESaysIncorrect) {
        skipCount++;
        continue;
    }

    // Need to fix: swap the ME content between currentCorrectLabel and correctId
    const newME = { ...me };

    if (currentCorrectLabel && currentCorrectLabel !== correctId) {
        // Swap the two micro_explanations
        const temp = newME[currentCorrectLabel];
        newME[currentCorrectLabel] = newME[correctId];
        newME[correctId] = temp;
    } else if (!currentCorrectLabel) {
        // No "Correct" label found anywhere - check if using substantive explanations
        // In this case, the ME is fine if it doesn't use Correct/Incorrect prefix system
        // But let's check if the correct answer's ME says "Incorrect" which is definitely wrong
        if (correctMESaysIncorrect) {
            // Find any other option ME that says "Correct" with object format
            let foundCorrectKey = null;
            for (const label of labels) {
                if (label === correctId) continue;
                const text = String(me[label] || '');
                if (text.toLowerCase().includes('correct') && !text.toLowerCase().includes('incorrect')) {
                    foundCorrectKey = label;
                    break;
                }
            }
            if (foundCorrectKey) {
                const temp = newME[foundCorrectKey];
                newME[foundCorrectKey] = newME[correctId];
                newME[correctId] = temp;
            }
        } else {
            // ME doesn't use Correct/Incorrect prefix - it's fine, these are substantive explanations
            skipCount++;
            continue;
        }
    }

    console.log(`${q.title}: fixing ME (correct=${correctId}, was_correct_label=${currentCorrectLabel})`);

    if (!DRY_RUN) {
        const { error: updErr } = await sb
            .from('questions')
            .update({ micro_explanations: newME })
            .eq('id', q.id);

        if (updErr) {
            console.error(`  ❌ ${updErr.message}`);
            errorCount++;
        } else {
            fixCount++;
        }
    } else {
        fixCount++;
    }
}

console.log(`\n${DRY_RUN ? '[DRY RUN] ' : ''}Fixed: ${fixCount}, Skipped: ${skipCount}, Errors: ${errorCount}`);
