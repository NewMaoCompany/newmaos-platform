
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl!, supabaseAnonKey!);

async function findNullTitles() {
    console.log('Searching for questions with NULL or empty titles...');
    const { data: nullData, error: nullError } = await supabase
        .from('questions')
        .select('id, topic_id, notes, status')
        .is('title', null)
        .limit(10);

    const { data: emptyData, error: emptyError } = await supabase
        .from('questions')
        .select('id, topic_id, notes, status')
        .eq('title', '')
        .limit(10);

    if (nullError || emptyError) {
        console.error(nullError || emptyError);
        return;
    }

    console.log(`Found ${nullData.length} questions with NULL title.`);
    nullData.forEach(q => console.log(` - ID: ${q.id} | Topic: ${q.topic_id} | Status: ${q.status}`));

    console.log(`Found ${emptyData.length} questions with EMPTY title.`);
    emptyData.forEach(q => console.log(` - ID: ${q.id} | Topic: ${q.topic_id} | Status: ${q.status}`));
}

findNullTitles();
