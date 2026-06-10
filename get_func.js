import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

async function get() {
  const res = await fetch(`${process.env.VITE_SUPABASE_URL}/rest/v1/rpc/get_user_badges`, {
    method: 'POST',
    headers: {
      'apikey': process.env.VITE_SUPABASE_ANON_KEY,
      'Authorization': `Bearer ${process.env.VITE_SUPABASE_ANON_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ p_user_id: "b55d71f0-0649-4ca1-ab0e-2bb06e7f286a" })
  });
  const data = await res.json();
  console.log(data);
}
get();
