import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
  // Get badge data for the AB user
  const { data, error } = await supabase.rpc('get_user_badges', { p_user_id: 'e3b285f1-1cf3-4e1b-986a-4d2872f2dc1a' });
  console.log('badge data:', JSON.stringify(data, null, 2));
  console.log('error:', error);
  
  // Also check last_analysis_view_time
  const { data: profile } = await supabase.from('user_profiles').select('last_analysis_view_time, last_practice_rec_view_time').eq('id', 'e3b285f1-1cf3-4e1b-986a-4d2872f2dc1a').single();
  console.log('profile times:', JSON.stringify(profile, null, 2));
}
test();
