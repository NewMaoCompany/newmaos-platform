require('dotenv').config({ path: 'server/.env' });
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

async function main() {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: 'newmao6120@gmail.com', // The email from the screenshot
    password: 'CzLjc6120' // Assume this is the current test user's password
  });

  if (error) {
    console.error("Login failed:", error.message);
    return;
  }

  const { data: profile } = await supabase
    .from('user_profiles')
    .select('*')
    .eq('id', data.user.id)
    .single();

  console.log("=== DB RECORD ===");
  console.log(profile);
}

main();
