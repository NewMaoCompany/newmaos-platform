require('dotenv').config({ path: './.env' });
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

async function run() {
  console.log("Fetching algorithmic sessions...");
  const { data: prog, error: err1 } = await supabase
    .from('user_section_progress')
    .select('user_id, entity_type, data')
    .eq('entity_type', 'algorithmic');
    
  if (err1) { console.error(err1); return; }
  console.log(`Found ${prog.length} algorithmic sessions.`);
  let totalErrors = 0;
  prog.forEach(p => {
    if (p.data && p.data.currentIncorrectIds && p.data.currentIncorrectIds.length > 0) {
       totalErrors++;
       console.log(`- User: ${p.user_id}, Topic: ${p.data.sessionTopic}, Errors length: ${typeof p.data.currentIncorrectIds === 'string' ? p.data.currentIncorrectIds.length : p.data.currentIncorrectIds.length}`);
       console.log(`  Data:`, JSON.stringify(p.data.currentIncorrectIds));
    }
  });
  console.log(`Total sessions with errors: ${totalErrors}`);

  console.log("\nFetching notifications...");
  const { data: notifs, error: err2 } = await supabase
    .from('notifications')
    .select('*')
    .order('created_at', { ascending: false });
    
  if (err2) { console.error(err2); return; }
  console.log(`Found ${notifs.length} total notifications.`);
  notifs.slice(0, 10).forEach(n => console.log(`- [${n.user_id}] ${n.text} (unread: ${n.unread})`));
}

run();
