
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';

// Fix for __dirname in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load environment variables
const envPath = path.resolve(__dirname, '../.env.local');
if (fs.existsSync(envPath)) {
    dotenv.config({ path: envPath });
} else {
    // Fallback to .env
    dotenv.config({ path: path.resolve(__dirname, '../.env') });
}

// Hardcoded fallback if env load fails (retrieved from .env.local previously)
const supabaseUrl = process.env.VITE_SUPABASE_URL || "https://xzpjlnkirboevkjzitcx.supabase.co";
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI";

const supabase = createClient(supabaseUrl, supabaseKey);

async function exportQuestions() {
    console.log('Starting export of `questions` table...');
    console.log(`Connecting to: ${supabaseUrl}`);

    const allQuestions = [];
    let page = 0;
    const pageSize = 1000;
    let hasMore = true;

    while (hasMore) {
        console.log(`Fetching page ${page + 1}...`);
        const { data, error, count } = await supabase
            .from('questions')
            .select('*', { count: 'exact' })
            .range(page * pageSize, (page + 1) * pageSize - 1)
            .order('id', { ascending: true });

        if (error) {
            console.error('Error fetching questions:', error);
            process.exit(1);
        }

        if (data && data.length > 0) {
            allQuestions.push(...data);
            console.log(`Fetched ${data.length} records.`);
            if (data.length < pageSize) {
                hasMore = false;
            } else {
                page++;
            }
        } else {
            hasMore = false;
        }
    }

    const outputPath = path.resolve(__dirname, '../questions_export.json');
    fs.writeFileSync(outputPath, JSON.stringify(allQuestions, null, 2));

    console.log(`Export complete!`);
    console.log(`Total records: ${allQuestions.length}`);
    console.log(`File saved to: ${outputPath}`);
}

exportQuestions();
