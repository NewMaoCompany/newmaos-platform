const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const env = fs.readFileSync('server/.env', 'utf8');
const url = env.match(/SUPABASE_URL=(.*)/)[1].trim();
const key = env.match(/SUPABASE_ANON_KEY=(.*)/)[1].trim();

const supabase = createClient(url, key);

async function test() {
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
        email: 'newmao6120@gmail.com',
        password: 'CzLjc6120',
    });
    
    if (authErr) {
        console.error("Login Error:", authErr.message);
        return;
    }
    
    console.log("Logged in. Submitting 10 attempts to trigger limit...");
    let successCount = 0;
    
    for (let i = 1; i <= 10; i++) {
        // Find existing questions to make it realistic
        const { data: qData } = await supabase.from('questions').select('id, correct_option_id').limit(1).range(i, i);
        const qId = qData?.[0]?.id || `test-q-${i}`;
        const optId = qData?.[0]?.correct_option_id || `opt-${i}`;

        const { data, error } = await supabase.rpc('submit_attempt', {
            p_question_id: qId,
            p_is_correct: true,
            p_selected_option_id: optId,
            p_time_spent_seconds: 15,
            p_error_tags: [] // Passing empty array now succeeds
        });
        
        if (error) {
            console.log(`Failed at attempt ${i}:`, error.message);
        } else {
            console.log(`Attempt ${i} successful:`, data);
            successCount++;
        }
    }
    
    console.log(`Successfully completed ${successCount} attempts.`);
    
    // Check daily limit via RPC
    const { data: limitCheck } = await supabase.rpc('check_daily_practice_limit');
    console.log("Daily limit check result:", limitCheck);
}
test();
