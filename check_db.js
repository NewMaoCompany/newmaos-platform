require('dotenv').config({ path: require('path').resolve(__dirname, 'server/.env') });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

if (!serviceKey) {
  console.error("NO SUPABASE_SERVICE_ROLE_KEY found in .env");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceKey);

async function run() {
    console.log("Checking user_profiles...");
    const { data: profile } = await supabase.from('user_profiles').select('id, name, avatar_url').eq('name', 'NewMaoS.com');
    console.log(profile);
}
run();
