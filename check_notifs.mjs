import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://xzpjlnkirboevkjzitcx.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY; 

// I will just use the anon key if service role is not available, but I need to bypass RLS if using anon key? 
// No, let's just use the server's service role key.
SUPABASE_URL=https://xzpjlnkirboevkjzitcx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI
# SUPABASE_SERVICE_KEY is optional but recommended for admin tasks. Using Anon key may limits functionality.
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

async function check() {
  const { data: users } = await supabase.from('users').select('id, name').ilike('name', 'Newmao6120');
  if (!users || users.length === 0) {
    console.log("User not found");
    return;
  }
  const user = users[0];
  console.log("User:", user);
  
  const { data: notifs } = await supabase.from('notifications').select('*').eq('user_id', user.id).order('created_at', { ascending: false }).limit(20);
  console.log("Recent notifications:", notifs);
}
check();
