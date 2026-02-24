import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: './.env.local' });

if (!process.env.VITE_SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
  console.error("Missing keys:", { url: process.env.VITE_SUPABASE_URL, key: !!process.env.SUPABASE_SERVICE_ROLE_KEY });
  process.exit(1);
}

const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

async function check() {
  const { data, error } = await supabase
    .from('user_section_progress')
    .select('section_id, status, entity_type')
    .order('last_accessed_at', { ascending: false })
    .limit(10);

  if (error) {
    console.error("DB Error:", error);
    return;
  }

  console.log("Latest progress records:", JSON.stringify(data, null, 2));
}

check();
