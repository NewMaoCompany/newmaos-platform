const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_SERVICE_ROLE_KEY);

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
