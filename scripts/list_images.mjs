import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

// Find all image questions across all units
const allImages = [];
for (let u = 1; u <= 10; u++) {
    const { data } = await sb.from('questions').select('title, prompt, prompt_type, correct_option_id, options, explanation')
        .like('title', u + '.%')
        .eq('prompt_type', 'image')
        .order('title');
    if (data) {
        for (const q of data) {
            let url = '';
            const p = String(q.prompt);
            if (p.startsWith('[')) {
                try {
                    const arr = JSON.parse(p);
                    url = arr.find(x => typeof x === 'string' && x.startsWith('http')) || '';
                } catch { }
            }
            if (!url) {
                const match = p.match(/https?:\/\/[^\s"'\]]+/);
                url = match ? match[0] : '';
            }
            const textPart = p.startsWith('[') ? (() => { try { return JSON.parse(p).filter(x => !x.startsWith('http')).join(' '); } catch { return p; } })() : p;
            const co = q.options.find(o => o.label === q.correct_option_id);
            allImages.push({
                title: q.title,
                url: url,
                text: textPart.substring(0, 150),
                correct: q.correct_option_id + ': ' + (co ? (co.value || co.text || '').substring(0, 60) : 'N/A'),
                explanation: (q.explanation || '').substring(0, 200),
            });
        }
    }
}

console.log('Total image-based questions:', allImages.length);
console.log();

// Group by unit
const byUnit = {};
allImages.forEach(q => {
    const u = q.title.split('.')[0];
    if (!byUnit[u]) byUnit[u] = [];
    byUnit[u].push(q);
});

Object.entries(byUnit).sort((a, b) => parseInt(a[0]) - parseInt(b[0])).forEach(([u, qs]) => {
    console.log('Unit ' + u + ': ' + qs.length + ' image questions');
    qs.forEach(q => {
        console.log('  ' + q.title + ' [' + q.correct + ']');
        console.log('    Text: ' + q.text);
        console.log('    URL: ' + q.url);
        console.log('    Expl: ' + q.explanation.substring(0, 100));
        console.log();
    });
});

// Save URLs for browser checking
const urls = allImages.map(q => ({ title: q.title, url: q.url }));
fs.writeFileSync('scripts/math_review/image_urls.json', JSON.stringify(urls, null, 2));
console.log('Saved ' + urls.length + ' URLs to image_urls.json');
