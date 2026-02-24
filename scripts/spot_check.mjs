import { createClient } from '@supabase/supabase-js';
const sb = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

// Spot-check one question from each unit
const spotTitles = ['2.0-UT-Q1', '2.5-P2', '3.0-UT-Q1', '4.0-UT-Q1', '5.0-UT-Q1', '6.0-UT-Q1', '7.0-UT-Q1', '8.0-UT-Q1', '9.0-UT-Q1', '10.0-UT-Q1'];
for (const t of spotTitles) {
    const { data: q } = await sb.from('questions').select('title, correct_option_id, options, explanation').eq('title', t).single();
    if (!q) { console.log(t + ': NOT FOUND'); continue; }
    const co = q.options.find(o => o.label === q.correct_option_id);
    const cc = co ? (co.value || co.text || '') : 'N/A';
    console.log(t + ' [C=' + q.correct_option_id + ']: ' + cc.substring(0, 60));
    console.log('  EXPL: ' + (q.explanation || '').substring(0, 250));
    console.log();
}

// Duplicate details
console.log('=== DUPLICATE OPTION DETAILS ===\n');
for (const t of ['2.3-P5', '6.14-P1', '9.9-P5', '10.13-P5']) {
    const { data: q } = await sb.from('questions').select('title, correct_option_id, options').eq('title', t).single();
    if (!q) continue;
    console.log(t + ' (correct=' + q.correct_option_id + '):');
    q.options.forEach(o => console.log('  ' + o.label + ': ' + (o.value || o.text || '').substring(0, 80)));
    console.log();
}

// Check 1.0-UT-Q9 explanation text issue
const { data: q9 } = await sb.from('questions').select('title, correct_option_id, explanation').eq('title', '1.0-UT-Q9').single();
if (q9) {
    console.log('=== 1.0-UT-Q9 EXPLANATION TEXT ISSUE ===');
    console.log('Correct: ' + q9.correct_option_id);
    console.log('Explanation: ' + q9.explanation);
}
