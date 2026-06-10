import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function check() {
  const { data, error } = await supabase.rpc('run_sql', { query: "SELECT pg_get_functiondef(oid) FROM pg_proc WHERE proname = 'get_user_badges';" });
  if (error) console.error(error);
  else console.log(data);
}
check();
