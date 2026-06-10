import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

// Test what criteria RPC uses for analysis badge
async function test() {
  const userId = 'e3b285f1-1cf3-4e1b-986a-4d2872f2dc1a';
  
  // Check recent points_ledger activity
  const { data: ledger } = await supabase.from('points_ledger')
    .select('created_at, amount, description')
    .eq('user_id', userId)
    .order('created_at', { ascending: false })
    .limit(5);
  console.log('recent ledger:', JSON.stringify(ledger, null, 2));

  // Check recent section progress 
  const { data: progress } = await supabase.from('user_section_progress')
    .select('updated_at, section_id, status')
    .eq('user_id', userId)
    .order('updated_at', { ascending: false })
    .limit(5);
  console.log('recent progress:', JSON.stringify(progress, null, 2));
}
test();
