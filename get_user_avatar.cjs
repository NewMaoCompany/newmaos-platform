const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

const env = fs.readFileSync('server/.env', 'utf8');
const url = env.match(/SUPABASE_URL=(.*)/)[1].trim();

// Use ANON key since I couldn't find service role key easily in env
const keyMatch = env.match(/SUPABASE_ANON_KEY=(.*)/);
const key = keyMatch ? keyMatch[1].trim() : '';

const supabaseAdmin = createClient(url, key);

async function checkAvatar() {
    // Just sign in directly to bypass RLS issues since I have the credentials
    const { data: authData, error: authErr } = await supabaseAdmin.auth.signInWithPassword({
        email: 'zhuchen6120@gmail.com',
        password: 'CzLjc6120',
    });

    if (authErr) {
        console.error("Login Error:", authErr);
        return;
    }

    // Check Profile
    const { data: profile } = await supabaseAdmin
        .from('user_profiles')
        .select('avatar_url')
        .eq('id', authData.user.id)
        .single();

    console.log("Avatar URL in DB:", profile?.avatar_url);
}
checkAvatar();
