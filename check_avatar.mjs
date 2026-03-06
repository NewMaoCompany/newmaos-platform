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
    console.log("Checking the user_profile avatar...");
    const { data: profile } = await supabase.from('user_profiles').select('id, name, avatar_url').eq('name', 'NewMaoS.com');
    console.log(profile);

    console.log("\nChecking the avatars bucket files...");
    if (profile && profile.length > 0) {
        const { data: files } = await supabase.storage.from('avatars').list(profile[0].id);
        console.log("Files in user folder:", files);
    }
}
run();
