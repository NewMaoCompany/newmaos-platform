
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Try resolving to project root then server/.env
const envPath = '/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/server/.env';
console.log('Loading .env from:', envPath);
dotenv.config({ path: envPath });

console.log('SUPABASE_URL:', process.env.SUPABASE_URL ? 'Loaded' : 'Missing');
console.log('SUPABASE_SERVICE_ROLE_KEY:', process.env.SUPABASE_SERVICE_ROLE_KEY ? 'Loaded' : 'Missing');

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
// Check if we have at least one key, prefer service role

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkTitles() {
    console.log('Checking Unit 7 Questions...');

    // Fetch questions from Unit 7 via sub_topic_id
    const { data: questions, error } = await supabase
        .from('questions')
        .select('id, title, topic, sub_topic_id')
        .like('sub_topic_id', '7.%')
        .limit(20);

    if (error) {
        console.error('Error fetching questions:', error);
        return;
    }

    console.log(`Found ${questions.length} recent questions.`);
    questions.forEach(q => {
        console.log(`[${q.id.slice(0, 8)}...] Topic: ${q.topic} | SubTopic: ${q.sub_topic_id} | Title: "${q.title}"`);
    });
}

checkTitles();
