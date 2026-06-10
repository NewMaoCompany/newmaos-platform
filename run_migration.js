import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY);

async function run() {
  const sql = fs.readFileSync('./database/migrations/get_user_badges.sql', 'utf8');
  const { data, error } = await supabase.rpc('exec_sql', { query: sql });
  console.log(data, error);
}
run();
