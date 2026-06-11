import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY);

async function run() {
    // try to fetch a row from pending_points
    const { data, error } = await supabase.from('pending_points').select('*').limit(5);
    console.log("Pending points sample:", data);
}
run();
