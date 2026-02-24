import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);
async function run() {
  const { data: q1, error: e1 } = await supabase.from('points_history').select('id').limit(1);
  console.log('points_history:', e1 ? e1.message : 'EXISTS');
  const { data: q2, error: e2 } = await supabase.from('user_points').select('id').limit(1);
  console.log('user_points:', e2 ? e2.message : 'EXISTS');
  const { data: q3, error: e3 } = await supabase.from('point_events').select('id').limit(1);
  console.log('point_events:', e3 ? e3.message : 'EXISTS');
  const { data: q4, error: e4 } = await supabase.from('points_ledger').select('id').limit(1);
  console.log('points_ledger:', e4 ? e4.message : 'EXISTS');
}
run();
