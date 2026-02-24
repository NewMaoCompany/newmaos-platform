import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const ID = 'a5266a5e-801e-42eb-b4a8-035d81680c60';

// First get current prompt
const { data: q, error: qe } = await sb.from('questions').select('id, prompt').eq('id', ID).single();
console.log('Query result:', q ? 'found' : 'not found', qe?.message || '');

// Upload image
const buf = fs.readFileSync('Unit8/8.0-UT-Q12.png');
const storagePath = 'mixed_content/' + Date.now() + '_8.0-UT-Q12.png';
const { error: ue } = await sb.storage.from('images').upload(storagePath, buf, { contentType: 'image/png', upsert: true });
if (ue) { console.error('Upload failed:', ue.message); process.exit(1); }
const { data: { publicUrl } } = sb.storage.from('images').getPublicUrl(storagePath);
console.log('Uploaded:', publicUrl);

// Build prompt array
let arr;
if (q) {
    arr = Array.isArray(q.prompt) ? [...q.prompt] : [q.prompt || ''];
    arr = arr.filter(item => typeof item === 'string' && !item.startsWith('http'));
} else {
    arr = [''];
}
arr.push(publicUrl);

// Update by ID directly
const { error: updE } = await sb.from('questions').update({ prompt: arr, prompt_type: 'image' }).eq('id', ID);
console.log(updE ? 'FAIL: ' + updE.message : 'OK: updated ' + ID);
