import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc1ODA4ODIsImV4cCI6MjA1MzE1Njg4Mn0.sFdOFbyooLQXRA6I0x8n0pBSqdHjHnHsOJYcQLgSMpQ'
);

// Fetch ALL image-type questions (prompt_type = 'image' OR 'text_and_image')
const { data, error } = await sb
    .from('questions')
    .select('title, prompt, prompt_type, correct_option_id, options, explanation, micro_explanations')
    .or('prompt_type.eq.image,prompt_type.eq.text_and_image')
    .order('title');

if (error) { console.error(error); process.exit(1); }

console.log(`Total image questions: ${data.length}`);

// Build detailed verification data
const verifyData = data.map(q => {
    const opts = q.options || [];
    const correctOpt = opts.find(o => o.id === q.correct_option_id);

    // Extract image URL from prompt
    let imageUrl = '';
    let questionText = '';
    if (Array.isArray(q.prompt)) {
        questionText = q.prompt.find(p => typeof p === 'string' && !p.startsWith('http')) || '';
        imageUrl = q.prompt.find(p => typeof p === 'string' && p.startsWith('http')) || '';
    } else if (typeof q.prompt === 'string') {
        if (q.prompt.startsWith('http')) imageUrl = q.prompt;
        else questionText = q.prompt;
    }

    return {
        title: q.title,
        prompt_type: q.prompt_type,
        question: questionText,
        imageUrl,
        correct_id: q.correct_option_id,
        correct_text: correctOpt ? (correctOpt.text || correctOpt.value || '') : '???',
        correct_explanation: correctOpt ? (correctOpt.explanation || '') : '',
        explanation: q.explanation || '',
        options: opts.map(o => ({
            id: o.id,
            text: o.text || o.value || '',
            explanation: o.explanation || ''
        }))
    };
});

// Save to file
fs.writeFileSync(
    'scripts/math_review/all_image_questions.json',
    JSON.stringify(verifyData, null, 2)
);

// Print summary by unit
const units = {};
verifyData.forEach(q => {
    const u = q.title.split('.')[0];
    if (!units[u]) units[u] = [];
    units[u].push(q.title);
});

console.log('\n=== Distribution by Unit ===');
Object.keys(units).sort((a, b) => Number(a) - Number(b)).forEach(u => {
    console.log(`Unit ${u}: ${units[u].length} questions`);
    units[u].forEach(t => console.log(`  - ${t}`));
});

// Print each question's core info for quick review
console.log('\n=== Quick Review Data ===');
verifyData.forEach(q => {
    console.log(`\n--- ${q.title} ---`);
    console.log(`Q: ${q.question.substring(0, 100)}...`);
    console.log(`Correct: ${q.correct_id} → ${q.correct_text}`);
    q.options.forEach(o => {
        const marker = o.id === q.correct_id ? ' ✓' : '';
        console.log(`  ${o.id}: ${o.text}${marker}`);
    });
});
