import { createClient } from '@supabase/supabase-js';
const supabase = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

async function run() {
  const { data, error } = await supabase.rpc('get_total_unread_count', { user_uuid: 'b0e01476-b6fb-40c2-9e95-2c8e31de3ab2' }); 
  console.log("Error:", error);
}
run();
