/**
 * Download ALL image-based question images for visual verification.
 * Saves to scripts/math_review/images/ with filenames matching question titles.
 */
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const outDir = 'scripts/math_review/images';
fs.mkdirSync(outDir, { recursive: true });

// Fetch all image questions
const allQuestions = [];
for (let u = 1; u <= 10; u++) {
    const { data } = await sb.from('questions').select('title, prompt, correct_option_id, options, explanation, micro_explanations')
        .like('title', u + '.%')
        .eq('prompt_type', 'image')
        .order('title');
    if (data) allQuestions.push(...data);
}
allQuestions.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
console.log('Total image questions:', allQuestions.length);

let downloaded = 0, failed = 0;
const manifest = [];

for (const q of allQuestions) {
    const p = String(q.prompt);
    let url = '', textPart = '';

    if (p.trim().startsWith('[')) {
        try {
            const arr = JSON.parse(p);
            url = arr.find(x => typeof x === 'string' && x.startsWith('http')) || '';
            textPart = arr.filter(x => typeof x === 'string' && !x.startsWith('http')).join(' ');
        } catch { textPart = p; }
    } else {
        const m = p.match(/https?:\/\/[^\s"'\]]+/);
        url = m ? m[0] : '';
        textPart = p.replace(/https?:\/\/[^\s"'\]]+/g, '').trim();
    }

    const co = q.options.find(o => o.label === q.correct_option_id);
    const correctContent = co ? (co.value || co.text || '') : 'N/A';
    const fname = q.title.replace(/[^a-zA-Z0-9.-]/g, '_') + '.png';

    if (url) {
        try {
            const res = await fetch(url);
            if (res.ok) {
                const buf = Buffer.from(await res.arrayBuffer());
                fs.writeFileSync(path.join(outDir, fname), buf);
                downloaded++;
            } else {
                console.log(q.title + ': HTTP ' + res.status);
                failed++;
            }
        } catch (e) {
            console.log(q.title + ': Error ' + e.message);
            failed++;
        }
    } else {
        console.log(q.title + ': No URL');
        failed++;
    }

    manifest.push({
        title: q.title,
        file: fname,
        text: textPart.substring(0, 200),
        correct: q.correct_option_id + ': ' + correctContent.substring(0, 80),
        explanation: (q.explanation || '').substring(0, 250),
        options: q.options.map(o => o.label + ': ' + (o.value || o.text || '').substring(0, 60)).join(' | '),
    });
}

fs.writeFileSync('scripts/math_review/image_manifest.json', JSON.stringify(manifest, null, 2));
console.log('\nDownloaded: ' + downloaded + ', Failed: ' + failed);
console.log('Manifest saved with ' + manifest.length + ' entries');
