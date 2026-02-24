require('dotenv').config({ path: 'server/.env' });
require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const url = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SERVICE_KEY;

if (!url || !key) {
    console.error("Missing SUPABASE env vars.");
    process.exit(1);
}

const supabaseAdmin = createClient(url, key);

async function check() {
    const { data: users, error: authErr } = await supabaseAdmin.auth.admin.listUsers();
    if (authErr) { console.error("auth error", authErr); return; }

    const user = users.users.find(u => u.email === 'newmao6120@gmail.com');
    if (!user) { console.log("no user"); return; }

    console.log("User ID:", user.id);

    const { data: tm } = await supabaseAdmin.from('topic_mastery').select('*').eq('user_id', user.id);
    console.log("topic_mastery rows:", tm?.length);
    console.log("topic_mastery data:", JSON.stringify(tm, null, 2));

    const { data: qa } = await supabaseAdmin.from('question_attempts').select('id, is_correct, question_id, created_at').eq('user_id', user.id).order('created_at', { ascending: false }).limit(20);
    console.log("question_attempts (last 20):", JSON.stringify(qa, null, 2));

    const { data: sm } = await supabaseAdmin.from('subtopic_mastery').select('*').eq('user_id', user.id);
    console.log("subtopic_mastery data:", JSON.stringify(sm, null, 2));
}
check();
