import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY);

async function run() {
    const { data, error } = await supabase.rpc('execute_sql', {
        sql: `SELECT conname, pg_get_constraintdef(c.oid)
              FROM pg_constraint c
              JOIN pg_namespace n ON n.oid = c.connamespace
              WHERE c.conrelid = 'public.pending_points'::regclass;`
    });
    console.log(data, error);
}
run();
