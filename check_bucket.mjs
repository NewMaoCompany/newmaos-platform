import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: './server/.env' });

const supabaseUrl = process.env.VITE_SUPABASE_URL || '';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

if(!supabaseUrl || !supabaseKey) {
  console.log("Missing config");
  process.exit(1);
}

const supabaseAdmin = createClient(supabaseUrl, supabaseKey);

async function check() {
  const { data, error } = await supabaseAdmin.storage.getBucket('avatars');
  console.log("Bucket Check:", data ? "Exists" : "Not Found");
  if(error) console.log("Error:", error.message);
}
check();
