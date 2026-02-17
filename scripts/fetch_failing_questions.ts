
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL || 'https://xzpjlnkirboevkjzitcx.supabase.co';
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase URL or Key');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

const failingIds = [
    '42aacaf5-0631-49b3-ae54-46805526a3ac',
    '45053b2f-bb1a-40db-ba92-8b4cb8d8b544',
    '995d20ab-7ad4-4fc2-aa05-06031445ebb2',
    '9b8a1428-e64e-4826-93cf-3167497f581d',
    'c256c221-d33b-437e-b5b9-e9e5f9cfa85a',
    'd938642b-9344-4467-ab9b-72853a0f6845',
    'f625c885-89ec-4710-97bd-12c5b697f4be'
];

import fs from 'fs';

async function fetchFailures() {
    const { data, error } = await supabase
        .from('questions')
        .select('id, prompt, explanation')
        .in('id', failingIds);

    if (error) {
        console.error('Error fetching questions:', error);
        return;
    }

    fs.writeFileSync('failing_questions.json', JSON.stringify(data, null, 2));
    console.log('Written to failing_questions.json');
}

fetchFailures();
