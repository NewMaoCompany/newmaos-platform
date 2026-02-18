
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl!, supabaseAnonKey!);

async function checkSchema() {
    try {
        console.log('Checking questions table sample...');
        const { data, error } = await supabase
            .from('questions')
            .select('*')
            .limit(1);

        if (error) {
            console.error('Error:', error.message);
            return;
        }

        if (data && data.length > 0) {
            const first = data[0];
            console.log('Columns found in first row:');
            Object.keys(first).forEach(key => {
                console.log(` - ${key}: ${typeof first[key]} (Sample: ${String(first[key]).substring(0, 30)})`);
            });
        } else {
            console.log('No data found in questions table.');
        }
    } catch (e: any) {
        console.error('Fatal error:', e.message);
    }
}

checkSchema();
