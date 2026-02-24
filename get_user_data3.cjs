require('dotenv').config({ path: 'server/.env' });
require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const url = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SERVICE_KEY;

const supabaseAdmin = createClient(url, key);

async function check() {
    const { data: users } = await supabaseAdmin.auth.admin.listUsers();
    const user = users.users.find(u => u.email === 'newmao6120@gmail.com');

    // Check user_section_progress
    const { data: usp } = await supabaseAdmin.from('user_section_progress').select('*').eq('user_id', user.id);
    console.log("user_section_progress:", JSON.stringify(usp, null, 2));

    // Check RPC unit progress
    const { data: rpcScore } = await supabaseAdmin.rpc('get_unit_progress_stats', { p_user_id: user.id, p_topic_id: 'Limits' });
    console.log("get_unit_progress_stats (Limits):", rpcScore);

    // Check RPC unit progress 2
    const { data: rpc2 } = await supabaseAdmin.rpc('get_unit_progress_stats', { p_user_id: user.id, p_topic_id: 'Differentiation_Definition' });
    console.log("get_unit_progress_stats (Diff):", rpc2);
}
check();
