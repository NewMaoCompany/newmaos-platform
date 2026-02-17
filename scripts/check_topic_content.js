
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

// Load env vars
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials in .env.local');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkTopicContent() {
    console.log('Checking topic_content for BC_Series...');

    const { data, error } = await supabase
        .from('topic_content')
        .select('*')
        .eq('id', 'Both_Composite')
        .single();

    if (error) {
        console.error('Error fetching topic_content:', error);
        return;
    }

    if (!data) {
        console.log('No topic_content found for BC_Series.');
        return;
    }

    console.log('Topic Content:', JSON.stringify(data, null, 2));

    if (data.sub_topics && Array.isArray(data.sub_topics)) {
        console.log(`sub_topics count: ${data.sub_topics.length}`);
        const ratioTest = data.sub_topics.find(s => s.id === '10.8' || s.title?.includes('Ratio Test'));
        if (ratioTest) {
            console.log('Found Ratio Test in sub_topics:', JSON.stringify(ratioTest, null, 2));
            console.log('Has description_2?', !!ratioTest.description_2);
        } else {
            console.log('Ratio Test NOT found in sub_topics array.');
        }
    } else {
        console.log('sub_topics is missing or not an array.');
    }
}

checkTopicContent();
