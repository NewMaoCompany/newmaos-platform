import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function run() {
  const { data: user } = await supabase.from('user_profiles').select('id').eq('name', 'newmao6120').single();
  
  if (user) {
    const { error: err1 } = await supabase.from('user_section_progress').delete().eq('user_id', user.id);
    console.log('user_section_progress del:', err1?.message || 'ok');
  }
}
run();
