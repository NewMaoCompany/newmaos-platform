import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, serviceKey);

async function checkNotifs() {
    // get the user id for newmao6120@gmail.com
    const { data: users, error: err } = await supabase.from('user_profiles').select('id, name').limit(5);
    console.log("Users:", users);

    const { data: notifs, error } = await supabase.from('notifications').select('*').limit(10);

    if (error) {
        console.error('Error:', error);
    } else {
        console.log('Recent Notifications:', notifs);
    }
}

checkNotifs();
