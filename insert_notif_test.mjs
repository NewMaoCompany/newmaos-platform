import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const supabase = createClient(supabaseUrl, serviceKey);

async function run() {
    const { data: users } = await supabase.from('users').select('id').limit(1);
    if (!users || users.length === 0) { console.log('No user found'); return; }
    
    const { data, error } = await supabase.from('notifications').insert({
        user_id: users[0].id,
        text: 'System verified notification ' + new Date().toLocaleTimeString(),
        type: 'system',
        link: '/dashboard',
        unread: true
    }).select();
    
    console.log(error ? 'Error: ' + error.message : 'Inserted Notification: ' + JSON.stringify(data));
}
run();
