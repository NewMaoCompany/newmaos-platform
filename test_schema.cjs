require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
    // We can just try to insert a dummy row that we know will fail just to get the error message!
    // Or we can try to call award_points with a non-uuid source_id!
    const { data, error } = await supabase.rpc('award_points', {
        p_user_id: '00000000-0000-0000-0000-000000000000',
        p_amount: 5,
        p_type: 'practice_correct',
        p_source_id: 'Both_Limits', // NOT A UUID
        p_description: 'Test',
        p_idempotency_key: 'test_123'
    });
    console.log('Result:', data);
    console.log('Error:', error);
}
test();
