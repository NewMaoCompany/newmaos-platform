import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function run() {
  const t1 = await supabase.from('point_transactions').select('id').limit(1);
  const t2 = await supabase.from('pending_points').select('id').limit(1);
  console.log('point_tx:', t1.error?.message || 'exists');
  console.log('pending_pts:', t2.error?.message || 'exists');
}
run();
