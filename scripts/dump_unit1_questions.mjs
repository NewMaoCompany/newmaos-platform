/**
 * Dump all Unit 1 questions from Supabase for analysis
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

// Fetch ALL Unit 1 questions - titles start with "1."
const { data, error } = await sb
    .from('questions')
    .select('*')
    .like('title', '1.%')
    .order('title', { ascending: true });

if (error) {
    console.error('Error:', error.message);
    process.exit(1);
}

console.log(`Found ${data.length} Unit 1 questions`);

// Write full data
fs.writeFileSync('scripts/unit1_questions_dump.json', JSON.stringify(data, null, 2));
console.log('Full dump written to scripts/unit1_questions_dump.json');

// Print summary
const columns = Object.keys(data[0] || {});
console.log('\n=== SCHEMA (columns) ===');
columns.forEach(col => {
    const sample = data[0][col];
    const type = Array.isArray(sample) ? 'array' : typeof sample;
    console.log(`  ${col}: ${type} (sample: ${JSON.stringify(sample)?.substring(0, 80)})`);
});

// Analyze issues
console.log('\n=== ANALYSIS ===');

let issues = [];

for (const q of data) {
    const prefix = `[${q.title}]`;

    // 1. Check correctOptionId matches an option
    if (q.options && Array.isArray(q.options)) {
        const optIds = q.options.map(o => o.id || o.label);
        const optLabels = q.options.map(o => o.label);
        if (q.correct_option_id && !optIds.includes(q.correct_option_id) && !optLabels.includes(q.correct_option_id)) {
            issues.push(`${prefix} correctOptionId "${q.correct_option_id}" not found in options (ids: ${optIds.join(',')})`);
        }

        // 2. Check options have content
        for (let i = 0; i < q.options.length; i++) {
            const opt = q.options[i];
            const content = opt.value || opt.text || '';
            if (!content.trim()) {
                issues.push(`${prefix} Option ${opt.label || opt.id || i} has no content`);
            }
        }

        // 3. Check micro_explanations match correct option
        if (q.micro_explanations) {
            const correctId = q.correct_option_id;
            const correctExpl = q.micro_explanations[correctId];
            if (!correctExpl) {
                // Check if any key matches
                const keys = Object.keys(q.micro_explanations);
                issues.push(`${prefix} micro_explanations missing key for correct answer "${correctId}" (keys: ${keys.join(',')})`);
            }
        }

        // 4. Check option explanations for incorrect options should explain why wrong
        // This is harder to validate automatically

    } else {
        issues.push(`${prefix} has no options or options is not an array`);
    }

    // 5. Check prompt
    const prompt = q.prompt;
    if (!prompt || (typeof prompt === 'string' && !prompt.trim()) || (Array.isArray(prompt) && prompt.length === 0)) {
        issues.push(`${prefix} has empty prompt`);
    }

    // 6. Check prompt_type vs actual content
    if (q.prompt_type === 'image' && Array.isArray(prompt)) {
        const hasImage = prompt.some(p => typeof p === 'string' && p.startsWith('http'));
        if (!hasImage) {
            issues.push(`${prefix} prompt_type is "image" but no URL in prompt array`);
        }
    }

    // 7. Check primary_skill_id
    if (!q.primary_skill_id) {
        issues.push(`${prefix} missing primary_skill_id`);
    }

    // 8. Check difficulty range
    if (q.difficulty !== null && (q.difficulty < 1 || q.difficulty > 5)) {
        issues.push(`${prefix} difficulty out of range: ${q.difficulty}`);
    }

    // 9. Check explanation
    if (!q.explanation || (typeof q.explanation === 'string' && !q.explanation.trim())) {
        issues.push(`${prefix} missing explanation`);
    }

    // 10. Check status
    if (q.status !== 'published') {
        issues.push(`${prefix} status is "${q.status}" (not published)`);
    }

    // 11. Check course
    if (!q.course) {
        issues.push(`${prefix} missing course`);
    }

    // 12. Check type
    if (!q.type) {
        issues.push(`${prefix} missing type`);
    }

    // 13. Check correct_option_id is a valid label (A-D)
    if (q.correct_option_id && !['A', 'B', 'C', 'D'].includes(q.correct_option_id)) {
        // Check if it's a UUID or other format
        if (q.correct_option_id.length > 4) {
            issues.push(`${prefix} correct_option_id is not a label but "${q.correct_option_id.substring(0, 20)}..."`);
        }
    }

    // 14. Check representation_type
    if (!q.representation_type) {
        issues.push(`${prefix} missing representation_type`);
    }

    // 15. Check reasoning_level
    if (!q.reasoning_level) {
        issues.push(`${prefix} missing reasoning_level`);
    }
}

console.log(`\nFound ${issues.length} issues:`);
issues.forEach((issue, i) => console.log(`  ${i + 1}. ${issue}`));

// Write issues to file
fs.writeFileSync('scripts/unit1_issues.txt', issues.join('\n'));
