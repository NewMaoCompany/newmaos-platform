import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve('./server/.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

if (!supabaseUrl || !serviceKey) {
    console.error("Missing config in ./server/.env");
    process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceKey);

async function check() {
    const { data, error } = await supabase.rpc('execute_sql', {
        sql_query: `
      SELECT event_object_table, trigger_name, event_manipulation, action_statement
      FROM information_schema.triggers
      WHERE event_object_table = 'message_reactions';
    `
    });

    if (error) {
        console.error("Error with RPC, trying simple select if possible:", error.message);
    } else {
        console.log("Triggers on message_reactions:", data);
    }
}

check();
