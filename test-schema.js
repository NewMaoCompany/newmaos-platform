import { createClient } from '@supabase/supabase-js';
const supabase = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

async function run() {
  const { data, error } = await supabase.from('user_profiles').select('*').limit(1);
  console.log("user_profiles columns:", data && data[0] ? Object.keys(data[0]) : error);
}
run();
