require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
    // 1. First get a valid user id by creating one or finding one.
    // I can't query users directly without a service role key.
    // Wait, let's login with dummy user to get user_id!
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
        email: 'test@newmaos.com', // I need a valid account
        password: 'password123'
    });
    if (authErr) {
        console.error('Auth error:', authErr.message);
        return;
    }
    const userId = authData.user.id;
    console.log('Logged in as', userId);
    
    // 2. Call award_points
    const { data, error } = await supabase.rpc('award_points', {
        p_user_id: userId,
        p_amount: 5,
        p_type: 'practice_correct',
        p_source_id: '05ccb10e-a841-48d9-a791-c116bd7ff035', // random uuid
        p_description: 'Correct Answer +5',
        p_idempotency_key: 'practice_05ccb10e-a841-48d9-a791-c116bd7ff035_2'
    });
    console.log('Award result:', data);
    console.log('Award error:', error);
}
test();
