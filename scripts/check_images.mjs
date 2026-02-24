import { createClient } from '@supabase/supabase-js';

const sb = createClient(
    'https://xzpjlnkirboevkjzitcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI'
);

const { data, error } = await sb
    .from('questions')
    .select('title, prompt, prompt_type')
    .like('title', '1.%')
    .order('title', { ascending: true });

if (error) { console.error(error.message); process.exit(1); }

console.log('=== Image Status for All Unit 1 Questions ===\n');

let withImage = 0, withoutImage = 0, needsImage = 0;

for (const q of data) {
    const p = q.prompt;
    const hasUrl = typeof p === 'string' && p.includes('https://');
    const isImageType = q.prompt_type === 'image';

    if (isImageType) {
        if (hasUrl) {
            withImage++;
        } else {
            console.log(`❌ ${q.title}: prompt_type=image but NO image URL!`);
            console.log(`   prompt: ${String(p).substring(0, 100)}`);
            needsImage++;
        }
    } else {
        withoutImage++;
    }
}

console.log(`\n✅ prompt_type=image WITH URL: ${withImage}`);
console.log(`📝 prompt_type=text (no image needed): ${withoutImage}`);
console.log(`❌ prompt_type=image WITHOUT URL: ${needsImage}`);
console.log(`Total: ${data.length}`);
