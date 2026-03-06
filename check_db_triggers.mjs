import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

async function run() {
    const { data: users } = await supabase.from('users').select('id, email').limit(5);
    console.log("Users:", users);

    const { data: channels } = await supabase.from('forum_channels').select('id, name').ilike('name', 'general').limit(1);
    console.log("Channels:", channels);

    if (channels && channels.length > 0) {
        const { data: members } = await supabase.from('channel_members').select('user_id').eq('channel_id', channels[0].id);
        console.log(`Members in ${channels[0].name}:`, members?.length);
    }
}
run();
