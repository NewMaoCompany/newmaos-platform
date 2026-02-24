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
    const progRes = await fetch(`${SUPABASE_URL}/rest/v1/user_section_progress?select=user_id,entity_type,data`, {
        headers: {
            'apikey': SUPABASE_ANON_KEY,
            'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
        }
    });

    if (!progRes.ok) {
        console.error("Failed", await progRes.text());
        return;
    }

    const progress = await progRes.json();
    console.log(`Found ${progress.length} sessions total.`);
    
    progress.forEach(p => {
        const data = p.data || {};
        const it = data.currentIncorrectIds;
        console.log(`User: ${p.user_id}, EntityType: ${p.entity_type}, Topic: ${data.sessionTopic}, HasErrorArr: ${!!it}`);
        if (it) {
            console.log("  =>", JSON.stringify(it));
        }
    });
}
check();
