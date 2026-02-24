require('dotenv').config({ path: 'server/.env' });
require('dotenv').config({ path: '.env', override: true });
const { createClient } = require('@supabase/supabase-js');

const url = process.env.SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SERVICE_KEY;
if (!url || !key) {
    console.error("Missing SUPABASE env vars.");
    process.exit(1);
}

const supabaseAdmin = createClient(url, key);

async function check() {
    const { data: users, error: authErr } = await supabaseAdmin.auth.admin.listUsers();
    if (authErr) { console.error(authErr); return; }

    const user = users.users.find(u => u.email === 'newmao6120@gmail.com');
    if (!user) { console.log('user not found'); return; }

    const { data: profile } = await supabaseAdmin
        .from('user_profiles')
        .select('*')
        .eq('id', user.id)
        .single();

    console.log("Profile problems_solved:", profile?.problems_solved);

    // See if `unit_mastery` exists
    const { data: unitMastery, error: uErr } = await supabaseAdmin.from('unit_mastery').select('*').limit(5);
    console.log("unit_mastery error (if any):", uErr?.message);
    console.log("unit_mastery count:", unitMastery?.length);

    // Check topic_mastery
    const { data: topicMastery, error: tErr } = await supabaseAdmin.from('topic_mastery').select('*').eq('user_id', user.id);
    console.log("topic_mastery count:", topicMastery?.length);
    if (topicMastery?.length) console.log("Topic mastery data:", topicMastery.map(t => `${t.topic_id}: ${t.mastery_score}`));
}
check();
