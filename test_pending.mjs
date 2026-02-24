import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

// Use strict path to .env
dotenv.config({ path: path.resolve('./.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL || '';
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY || ''; // anon key

if (!supabaseUrl || !supabaseKey) { console.error("Missing config:", process.env.VITE_SUPABASE_URL); process.exit(1); }

const supabase = createClient(supabaseUrl, supabaseKey);

async function check() {
  const { data, error } = await supabase.from('pending_points').select('*').limit(5);
  console.log("Pending points (Anon):", data);
  if (error) console.log("Error (Anon):", error.message);
}

check();
