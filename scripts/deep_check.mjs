import { createClient } from '@supabase/supabase-js';
const sb = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

// Deep look at problematic questions
const titles = ['2.3-P5', '6.14-P1', '10.13-P5', '9.9-P5', '1.0-UT-Q9'];
for (const t of titles) {
    const { data: q } = await sb.from('questions').select('*').eq('title', t).single();
    if (!q) continue;
    console.log('='.repeat(60));
    console.log(t);
    console.log('Prompt:', String(q.prompt).substring(0, 200));
    console.log('Correct:', q.correct_option_id);
    console.log('Options:');
    q.options.forEach(o => console.log('  ' + o.label + ':', JSON.stringify(o.value || o.text || '')));
    console.log('Explanation:', (q.explanation || '').substring(0, 300));
    console.log('Micro:', JSON.stringify(q.micro_explanations, null, 2));
    console.log();
}
