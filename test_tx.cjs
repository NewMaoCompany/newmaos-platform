require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
    // 8093d5f5-f7dc-40ea-9bf8-c709e2cfb729
    // Wait, the user id might be different. Let's just select top 10 from points_transactions
    const { data } = await supabase.from('points_transactions').select('*').limit(10);
    console.log(data);
}
test();
