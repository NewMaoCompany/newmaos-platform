import fs from 'fs';
import path from 'path';

const envPath = path.resolve('.env.local');
const envContent = fs.readFileSync(envPath, 'utf8');
const envVars = {};
envContent.split('\n').forEach(line => {
    if (line.trim() && !line.startsWith('#')) {
        const [key, ...valueParts] = line.split('=');
        let val = valueParts.join('=').trim();
        if (val.startsWith('"') && val.endsWith('"')) {
            val = val.slice(1, -1);
        }
        envVars[key.trim()] = val;
    }
});

const SUPABASE_URL = envVars.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = envVars.VITE_SUPABASE_ANON_KEY;

async function check() {
    console.log("URL", SUPABASE_URL);

    console.log("Triggering bulk generation RPC...");
    const rpcRes = await fetch(`${SUPABASE_URL}/rest/v1/rpc/generate_daily_notifications_bulk`, {
        method: 'POST',
        headers: {
            'apikey': SUPABASE_ANON_KEY,
            'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
            'Content-Type': 'application/json'
        }
    });

    if (!rpcRes.ok) {
        console.error("Failed to call RPC", await rpcRes.text());
    } else {
        console.log("RPC called successfully.");
    }

    console.log("Fetching notifications...");
    const notifRes = await fetch(`${SUPABASE_URL}/rest/v1/notifications`, {
        headers: {
            'apikey': SUPABASE_ANON_KEY,
            'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
        }
    });

    if (!notifRes.ok) {
        console.error("Failed to fetch notifications", await notifRes.text());
        return;
    }

    const notifications = await notifRes.json();
    console.log(`Found ${notifications.length} notifications total.`);

    notifications.forEach(n => {
        console.log(`- Type: ${n.type}, Message: ${n.message}`);
    });
}

check();
