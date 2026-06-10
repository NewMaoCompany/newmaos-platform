require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);
async function test() {
    const { data, error } = await supabase.rpc('get_user_badges', { p_user_id: '00000000-0000-0000-0000-000000000000' });
    console.log("RPC get_user_badges:", error ? error : data);
}
test();
