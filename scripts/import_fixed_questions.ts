
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load env
const envPath = path.resolve(__dirname, '../.env.local');
if (fs.existsSync(envPath)) {
    dotenv.config({ path: envPath });
} else {
    dotenv.config({ path: path.resolve(__dirname, '../.env') });
}

const supabaseUrl = process.env.VITE_SUPABASE_URL || "https://xzpjlnkirboevkjzitcx.supabase.co";
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI";

const supabase = createClient(supabaseUrl, supabaseKey);







const inputPath = path.resolve(__dirname, '../questions_export_fixed_v8.json');

async function importQuestions() {
    console.log('Reading fixed questions...');
    const raw = fs.readFileSync(inputPath, 'utf-8');
    const questions = JSON.parse(raw);

    console.log(`Ready to import ${questions.length} questions.`);

    // Batch size
    const BATCH_SIZE = 50;

    for (let i = 0; i < questions.length; i += BATCH_SIZE) {
        const batch = questions.slice(i, i + BATCH_SIZE);
        console.log(`Importing batch ${i} - ${i + batch.length}...`);

        const { error } = await supabase
            .from('questions')
            .upsert(batch, { onConflict: 'id' });

        if (error) {
            console.error('Error upserting batch:', error);
            // Process.exit(1)? No, continue? 
            // Better to stop and verify.
            process.exit(1);
        }
    }

    console.log('Import complete!');
}

importQuestions();
