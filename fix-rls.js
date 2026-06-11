import { createClient } from '@supabase/supabase-js';
const supabase = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

async function run() {
  // First, check the existing policies for forum_messages and direct_messages
  const { data, error } = await supabase.rpc('execute_sql', { sql: `
    SELECT tablename, policyname, permissive, roles, cmd, qual, with_check 
    FROM pg_policies 
    WHERE tablename IN ('forum_messages', 'direct_messages');
  ` });
  console.log("Policies:", data, error);
}
run();
