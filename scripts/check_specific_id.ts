
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl!, supabaseAnonKey!);

async function checkSpecificQuestion() {
    const id = '823895ae-07e3-4688-918d-5645e90af096';
    console.log(`Checking ID: ${id}`);
    const { data, error } = await supabase
        .from('questions')
        .select('*')
        .eq('id', id)
        .single();

    if (error) {
        console.error(error);
        return;
    }

    console.log('Result:');
    console.log(` - ID: ${data.id}`);
    console.log(` - Title: [${data.title}] (Type: ${typeof data.title})`);
    console.log(` - Status: ${data.status}`);
    console.log(` - Topic ID: ${data.topic_id}`);
}

checkSpecificQuestion();
