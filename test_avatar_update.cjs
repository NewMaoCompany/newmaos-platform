const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const env = fs.readFileSync('server/.env', 'utf8');
const url = env.match(/SUPABASE_URL=(.*)/)[1].trim();
const key = env.match(/SUPABASE_ANON_KEY=(.*)/)[1].trim();

const supabase = createClient(url, key);

async function testUpdate() {
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
        email: 'zhuchen6120@gmail.com',
        password: 'CzLjc6120',
    });
    
    if (authErr) {
        console.error("Login Error:", authErr);
        return;
    }
    
    console.log("Logged in. User ID:", authData.user.id);
    
    // Try to update avatar_url
    const testUrl = "https://example.com/test-avatar.png";
    const { data, error } = await supabase
        .from('user_profiles')
        .update({ avatar_url: testUrl })
        .eq('id', authData.user.id);
        
    if (error) {
        console.error("Update failed with RLS/DB Error:", error);
    } else {
        console.log("Update succeeded!");
        
        // Fetch to verify
        const { data: fetchProfile } = await supabase
            .from('user_profiles')
            .select('avatar_url')
            .eq('id', authData.user.id)
            .single();
            
        console.log("Verified DB value:", fetchProfile?.avatar_url);
    }
}
testUpdate();
