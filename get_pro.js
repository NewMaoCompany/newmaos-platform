import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function get() {
  const { data, error } = await supabase.from('user_profiles').select('is_pro').eq('id', "b55d71f0-0649-4ca1-ab0e-2bb06e7f286a").single();
  console.log(data);
}
get();
