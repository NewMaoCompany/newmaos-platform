const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

const env = fs.readFileSync('server/.env', 'utf8');
const url = env.match(/SUPABASE_URL=(.*)/)[1].trim();
const key = env.match(/SUPABASE_ANON_KEY=(.*)/)[1].trim();

const supabase = createClient(url, key);

async function check() {
    // Log in as the test user
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
        email: 'zhuchen6120@gmail.com',
        password: 'CzLjc6120',
    });
    if (authErr) {
        console.error("Login failed:", authErr);
        return;
    }

    // Query attempts
    const { data, error } = await supabase
        .from('question_attempts')
        .select('*')
        .order('created_at', { ascending: false })
        .limit(10);

    if (error) {
        console.error("Query failed:", error);
    } else {
        console.log(`Found ${data.length} attempts for test user.`);
        console.log("Recent attempts:", data);
    }
}
check();
