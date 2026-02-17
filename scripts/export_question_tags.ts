
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';

// Load env from server/.env
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const envPath = path.resolve(__dirname, '../server/.env');
dotenv.config({ path: envPath });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl) {
    console.error('Missing Supabase URL');
    process.exit(1);
}
if (!supabaseKey) {
    console.error('Missing Supabase Key');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function exportTags() {
    console.log('Fetching questions...');
    try {
        const { data, error } = await supabase
            .from('questions')
            .select('id, title, skill_tags, error_tags');

        if (error) {
            console.error('Error fetching questions:', error);
            return;
        }

        console.log(`Fetched ${data.length} questions.`);

        const outputPath = path.resolve(__dirname, '../exported_tags.json');
        fs.writeFileSync(outputPath, JSON.stringify(data, null, 2));
        console.log(`Exported tags to ${outputPath}`);
    } catch (err) {
        console.error('Unexpected error:', err);
    }
}

exportTags();
