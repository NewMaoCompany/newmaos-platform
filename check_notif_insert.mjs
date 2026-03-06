import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_ANON_KEY || ''; // Use ANON KEY to test RLS
const supabase = createClient(supabaseUrl, serviceKey);

async function run() {
    // Need a user token to properly test RLS Insert
    const { data: { session }, error: signInError } = await supabase.auth.signInWithPassword({
        email: 'newmao6120@gmail.com', // Replace with a test user if possible, or just check policies via service role
        password: 'password123' // Won't work without correct pwd
    });

    const { data: policies } = await supabase.from('pg_policies').select('*').eq('tablename', 'notifications');
    console.log("Policies for notifications table:");
    console.log(policies);
}
run();
