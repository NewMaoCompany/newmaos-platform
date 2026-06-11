import { createClient } from '@supabase/supabase-js';
const supabase = createClient('https://xzpjlnkirboevkjzitcx.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6cGpsbmtpcmJvZXZranppdGN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Mjc1NjYsImV4cCI6MjA4NDEwMzU2Nn0.rbHJO4vJ3fW86MweT3MgmFTeb_esWlDGZMdqMksHBkI');

async function run() {
  console.log("Subscribing...");
  supabase.channel('test_db_changes')
    .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'direct_messages' }, (payload) => {
      console.log("RECEIVED:", payload);
    })
    .subscribe((status) => {
      console.log("Status:", status);
    });
}
run();
// keep alive
setTimeout(() => {}, 5000);
