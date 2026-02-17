
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

const __dirname = path.dirname(new URL(import.meta.url).pathname);
// Try multiple paths
dotenv.config({ path: path.resolve(__dirname, '.env') });
dotenv.config({ path: path.resolve(__dirname, '../.env') });
dotenv.config({ path: path.resolve(process.cwd(), '.env') });
console.log('Loading env from:', path.resolve(__dirname, '../.env'));
console.log('VITE_SUPABASE_URL:', process.env.VITE_SUPABASE_URL ? 'FOUND' : 'MISSING');

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkChannels() {
    console.log('Checking channel counts...');

    const { data: allChannels, error } = await supabase
        .from('forum_channels')
        .select('category, name');

    if (error) {
        console.error('Error:', error);
        return;
    }

    const counts: Record<string, number> = {};
    const browsable: string[] = [];

    allChannels.forEach(c => {
        counts[c.category] = (counts[c.category] || 0) + 1;
        if (['User', 'Official', 'Custom'].includes(c.category)) {
            browsable.push(c.name);
        }
    });

    console.log('--- Channel Counts by Category ---');
    console.table(counts);

    console.log('--- Browsable Channels (User, Official, Custom) ---');
    console.log(`Total Browsable: ${browsable.length}`);
    console.log(browsable.join(', '));
}

checkChannels();
