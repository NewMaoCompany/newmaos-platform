const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const env = fs.readFileSync('server/.env', 'utf8');
const url = env.match(/SUPABASE_URL=(.*)/)[1].trim();
const rootEnv = fs.readFileSync('.env', 'utf8');
const key = rootEnv.match(/SUPABASE_SERVICE_ROLE_KEY=(.*)/)[1].trim();

const supabaseAdmin = createClient(url, key);

async function check() {
    const { data: users } = await supabaseAdmin.auth.admin.listUsers();
    const user = users.users.find(u => u.email === 'newmao6120@gmail.com');
    if (!user) { console.log('not found'); return; }
    
    const { data: profile } = await supabaseAdmin
        .from('user_profiles')
        .select('is_creator, subscription_tier')
        .eq('id', user.id)
        .single();
        
    console.log("Profile:", profile);
}
check();
