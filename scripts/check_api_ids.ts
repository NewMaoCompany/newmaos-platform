
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl!, supabaseAnonKey!);

async function checkIdsFromApi() {
    const ids = [
        '0b0c9c39-e48d-4f81-a7a5-965306648da5',
        '19aba183-5847-4959-9988-87493a748293',
        '46b646bc-d1b6-4ad7-8725-37e8e7c61c15'
    ];

    console.log('Searching for API IDs in CURRENT DB (xzpjlnkirboevkjzitcx)...');

    const { data, error } = await supabase
        .from('questions')
        .select('id, title, status')
        .in('id', ids);

    if (error) {
        console.error(error);
        return;
    }

    if (data && data.length > 0) {
        console.log(`Found ${data.length} matches!`);
        data.forEach(q => console.log(` - Match: ID=${q.id} | Title=${q.title} | Status=${q.status}`));
    } else {
        console.log('No matches found. The API is definitely using a DIFFERENT database.');
    }
}

checkIdsFromApi();
