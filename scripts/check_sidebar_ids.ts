
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load env from server directory
const envPath = '/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/server/.env';
console.log('Loading .env from:', envPath);
dotenv.config({ path: envPath });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkIds() {
    console.log('Checking Specific IDs from Screenshot...');

    // IDs from Step 3903 screenshot (Unit 1.7)
    // 65790...
    // 7e5e4...
    // 8a284...
    // d5394...
    // ef4f0...

    const prefixes = ['65790', '7e5e4', '8a284', 'd5394', 'ef4f0'];

    for (const prefix of prefixes) {
        const { data, error } = await supabase
            .from('questions')
            .select('id, title, topic, sub_topic_id')
            .like('id', `${prefix}%`)
            .limit(1);

        if (data && data.length > 0) {
            console.log(`[${prefix}...] Found: ID=${data[0].id} | Title=${JSON.stringify(data[0].title)}`);
        } else {
            console.log(`[${prefix}...] Not Found in DB`);
        }
    }
}

checkIds();
