import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function get() {
  const { data, error } = await supabase.from('user_profiles').select('id, is_pro').limit(5);
  console.log(data);
}
get();
