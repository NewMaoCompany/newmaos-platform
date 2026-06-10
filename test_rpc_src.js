import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

// Check the definition of get_user_badges
async function test() {
  const { data, error } = await supabase.rpc('get_function_def', { fname: 'get_user_badges' });
  console.log(data, error);
}
test();
