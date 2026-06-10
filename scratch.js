import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

async function check() {
  const res = await fetch(`${process.env.VITE_SUPABASE_URL}/rest/v1/pg_policies?select=*&tablename=eq.user_profiles`, {
    headers: {
      'apikey': process.env.VITE_SUPABASE_ANON_KEY,
      'Authorization': `Bearer ${process.env.VITE_SUPABASE_ANON_KEY}`
    }
  });
  const data = await res.json();
  console.log(JSON.stringify(data, null, 2));
}

check();
