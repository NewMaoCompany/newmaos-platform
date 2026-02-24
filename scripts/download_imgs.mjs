import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
const sb = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

const titles = ['1.0-UT-Q10', '1.3-P1', '1.3-P2', '1.3-P4', '1.10-P3', '2.0-UT-Q3', '5.0-UT-Q3'];
for (const t of titles) {
    const { data: q } = await sb.from('questions').select('title, prompt').eq('title', t).single();
    if (!q) { console.log(t + ': not found'); continue; }
    const p = String(q.prompt);
    let url = '';
    if (p.trim().startsWith('[')) {
        try { const arr = JSON.parse(p); url = arr.find(x => typeof x === 'string' && x.startsWith('http')) || ''; } catch { }
    }
    if (!url) { const m = p.match(/https?:\/\/[^\s"'\]]+/); url = m ? m[0] : ''; }
    if (url) {
        const fname = t.replace(/[^a-zA-Z0-9.-]/g, '_') + '.png';
        try {
            const res = await fetch(url);
            if (res.ok) {
                const buf = Buffer.from(await res.arrayBuffer());
                fs.writeFileSync('scripts/math_review/' + fname, buf);
                console.log(t + ': OK ' + buf.length + ' bytes -> ' + fname);
            } else {
                console.log(t + ': HTTP ' + res.status);
            }
        } catch (e) { console.log(t + ': Error ' + e.message); }
    } else {
        console.log(t + ': No URL');
    }
}
