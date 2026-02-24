/**
 * Re-dump all Unit 1 questions from Supabase (latest data) for manual math review
 * Output in a human-readable format for systematic verification
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const { data, error } = await sb
    .from('questions')
    .select('*')
    .like('title', '1.%')
    .order('title', { ascending: true });

if (error) { console.error(error.message); process.exit(1); }

// Natural sort
data.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));

// Save raw JSON
fs.writeFileSync('scripts/unit1_latest_dump.json', JSON.stringify(data, null, 2));

// Generate human-readable report
let report = '';

for (const q of data) {
    const prompt = q.prompt;
    let promptText = '';
    let promptImage = '';

    if (typeof prompt === 'string') {
        const trimmed = prompt.trim();
        if (trimmed.startsWith('[')) {
            try {
                const parsed = JSON.parse(trimmed);
                if (Array.isArray(parsed)) {
                    for (const p of parsed) {
                        if (typeof p === 'string' && p.startsWith('http')) promptImage = p;
                        else promptText += p;
                    }
                }
            } catch {
                promptText = prompt;
            }
        } else {
            promptText = prompt;
        }
    } else if (Array.isArray(prompt)) {
        for (const p of prompt) {
            if (typeof p === 'string' && p.startsWith('http')) promptImage = p;
            else promptText += p;
        }
    }

    const opts = q.options || [];
    const me = q.micro_explanations || {};

    report += `\n${'='.repeat(80)}\n`;
    report += `## ${q.title}\n`;
    report += `ID: ${q.id}\n`;
    report += `Difficulty: ${q.difficulty} | Reasoning: ${q.reasoning_level} | Rep: ${q.representation_type}\n`;
    report += `Primary Skill: ${q.primary_skill_id}\n`;
    report += `Supporting Skills: ${(q.supporting_skill_ids || []).join(', ')}\n`;
    report += `Error Tags: ${(q.error_tags || []).join(', ')}\n`;
    report += `Correct Answer: ${q.correct_option_id}\n`;
    report += `\nPROMPT: ${promptText}\n`;
    if (promptImage) report += `IMAGE: ${promptImage.substring(0, 80)}...\n`;

    report += `\nOPTIONS:\n`;
    for (const opt of opts) {
        const label = opt.label || opt.id;
        const content = opt.value || opt.text || '';
        const isCorrect = label === q.correct_option_id ? ' ✓' : '';
        report += `  ${label}: ${content}${isCorrect}\n`;
    }

    report += `\nGENERAL EXPLANATION: ${(q.explanation || '').substring(0, 300)}\n`;

    report += `\nMICRO EXPLANATIONS:\n`;
    for (const label of ['A', 'B', 'C', 'D']) {
        const expl = me[label] ? String(me[label]).substring(0, 200) : '(none)';
        report += `  ${label}: ${expl}\n`;
    }
}

fs.writeFileSync('scripts/unit1_readable_report.txt', report);
console.log(`Generated readable report: ${data.length} questions`);
console.log('File: scripts/unit1_readable_report.txt');
