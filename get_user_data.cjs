require('dotenv').config({ path: '.env.local' });
require('dotenv').config({ path: 'server/.env' });
const { createClient } = require('@supabase/supabase-js');

const url = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SERVICE_KEY;

if (!url || !key) {
    console.log("Missing env vars", { url, key: !!key });
    process.exit(1);
}

const supabaseAdmin = createClient(url, key);

async function check() {
    const { data: users, error: authErr } = await supabaseAdmin.auth.admin.listUsers();
    if (authErr) { console.error("auth error", authErr); return; }

    const user = users.users.find(u => u.email === 'newmao6120@gmail.com');
    if (!user) { console.log("no user"); return; }

    const { data: profile } = await supabaseAdmin
        .from('user_profiles')
        .select('problems_solved')
        .eq('id', user.id)
        .single();

    console.log("Profile problems_solved:", profile?.problems_solved);

    const { data: qacount, error: qaErr } = await supabaseAdmin.from('question_attempts').select('id', { count: 'exact' }).eq('user_id', user.id);
    console.log("question_attempts count:", qacount?.length, qaErr ? qaErr.message : '');

    const { data: tm, error: tmErr } = await supabaseAdmin.from('topic_mastery').select('*').eq('user_id', user.id);
    console.log("topic_mastery length:", tm?.length, tmErr ? tmErr.message : '');

}
check();
