
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Load env vars
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials in .env.local');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkSections() {
    console.log('Checking sections with "Ratio Test" in title...');

    const { data, error } = await supabase
        .from('sections')
        .select('id, title, description_2, topic_id')
        .ilike('title', '%Defining the Derivative%');

    if (error) {
        console.error('Error fetching sections:', error);
        return;
    }

    if (!data || data.length === 0) {
        console.log('No sections found matching "Ratio Test".');
        return;
    }

    console.log(`Found ${data.length} sections:`);
    data.forEach(section => {
        console.log('--------------------------------------------------');
        console.log(`ID: ${section.id}`);
        console.log(`Topic ID: ${section.topic_id}`);
        console.log(`Title: ${section.title}`);
        console.log(`Description 2: ${section.description_2 ? section.description_2.substring(0, 50) + '...' : 'NULL or EMPTY'}`);
        console.log('--------------------------------------------------');
    });
}

checkSections();
