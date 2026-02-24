import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

// Use strict path to .env
dotenv.config({ path: path.resolve('../.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !serviceKey) { console.error("Missing config:", process.env.VITE_SUPABASE_URL); process.exit(1); }

const sclient = createClient(supabaseUrl, serviceKey);

async function check() {
  const { data: d2, error } = await sclient.from('pending_points').select('*').limit(20);
  console.log("Pending points (Service):", d2);
  if (error) console.log("Error:", error.message);
}

check();
