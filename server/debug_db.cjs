require('dotenv').config({ path: '../.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error("Missing credentials:", { url: !!supabaseUrl, key: !!supabaseKey });
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
    console.log("Fetching user_section_progress...");
    const { data, error } = await supabase
        .from('user_section_progress')
        .select('user_id, entity_type, data')
        .eq('entity_type', 'algorithmic');

    if (error) {
        console.error("Error fetching progress:", error);
        return;
    }

    console.log(`Found ${data.length} algorithmic sessions.`);
    let count = 0;
    for (const p of data) {
        if (p.data && p.data.currentIncorrectIds) {
            count++;
            const arr = p.data.currentIncorrectIds;
            console.log(`User: ${p.user_id}, Topic: ${p.data.sessionTopic}, ArrType: ${Array.isArray(arr) ? 'Array' : typeof arr}, Length: ${arr.length}`);
            console.log('  Data:', JSON.stringify(arr));
        }
    }
    console.log(`Total sessions with incorrect IDs: ${count}`);

    const { data: notifs, error: err2 } = await supabase
        .from('notifications')
        .select('id, user_id, text, unread, created_at')
        .order('created_at', { ascending: false })
        .limit(5);

    if (err2) {
        console.error("Error fetching notifs:", err2);
        return;
    }
    console.log("\nRecent Notifications:");
    notifs.forEach(n => console.log(`- [${n.user_id}] ${n.text}`));
}

run();
