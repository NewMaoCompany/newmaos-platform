import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const FILE = process.argv[2];
const TITLE = process.argv[3];

const buf = fs.readFileSync(FILE);
const storagePath = 'mixed_content/' + Date.now() + '_' + TITLE + '.png';
const { error: ue } = await sb.storage.from('images').upload(storagePath, buf, { contentType: 'image/png', upsert: true });
if (ue) { console.error('Upload failed:', ue.message); process.exit(1); }
const { data: { publicUrl } } = sb.storage.from('images').getPublicUrl(storagePath);
console.log('Uploaded:', publicUrl);

const { data: q, error: qe } = await sb.from('questions').select('id, prompt').eq('title', TITLE).single();
if (qe || !q) { console.error('Not found:', TITLE, qe?.message); process.exit(1); }

let arr = Array.isArray(q.prompt) ? [...q.prompt] : [q.prompt || ''];
arr = arr.filter(item => typeof item === 'string' && !item.startsWith('http'));
arr.push(publicUrl);

const { error: updE } = await sb.from('questions').update({ prompt: arr, prompt_type: 'image' }).eq('id', q.id);
console.log(updE ? 'FAIL: ' + updE.message : 'OK: ' + q.id + ' updated');
