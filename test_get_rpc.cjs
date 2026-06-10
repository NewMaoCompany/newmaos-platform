require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
    const { data, error } = await supabase.rpc('get_function_def', { func_name: 'generate_practice_recommendations' });
    // Or I can just try to query it from pg_proc
}
test();
