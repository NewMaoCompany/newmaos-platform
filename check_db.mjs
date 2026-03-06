import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_ANON_KEY || ''; // FALLBACK TO ANON KEY FOR DB QUERY

const supabase = createClient(supabaseUrl, serviceKey);

async function run() {
    console.log("Checking user_profiles...");
    const { data: profile } = await supabase.from('user_profiles').select('id, name, avatar_url, bio').eq('email', 'newmao6120@gmail.com');
    console.log(profile);
}
run();
