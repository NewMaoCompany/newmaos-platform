import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config();

const supabase = createClient(
  process.env.VITE_SUPABASE_URL,
  process.env.VITE_SUPABASE_ANON_KEY
);

async function run() {
  console.log("Triggering bulk notifications RPC...");
  const { data, error } = await supabase.rpc('generate_daily_notifications_bulk');
  if (error) console.error("Error:", error);
  else console.log("Success:", data);
}
run();
