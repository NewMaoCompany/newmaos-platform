require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
    const { data, error } = await supabase.rpc('award_points', {
        p_user_id: '00000000-0000-0000-0000-000000000000',
        p_amount: 5,
        p_type: 'practice_correct',
        p_source_id: 'test', 
        p_description: 'Test',
        p_idempotency_key: 'test_123'
    });
    console.log('Result:', data);
    console.log('Error:', error);
}
test();
