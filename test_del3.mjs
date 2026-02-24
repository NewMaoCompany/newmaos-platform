import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function run() {
  const t3 = await supabase.from('points_history').select('id').limit(1);
  const t4 = await supabase.from('user_points').select('id').limit(1);
  console.log('points_history:', t3.error?.message || 'exists');
  console.log('user_points:', t4.error?.message || 'exists');
}
run();
