import pkg from 'pg';
const { Client } = pkg;
import { fileURLToPath } from 'url';

async function checkData() {
    const client = new Client({
        connectionString: "postgresql://postgres.xzpjlnkirboevkjzitcx:Supabase2025%40ap@aws-0-us-east-1.pooler.supabase.com:6543/postgres?sslmode=disable",
        ssl: false
    });
    try {
        await client.connect();
        const res = await client.query("SELECT email, name, avatar_url FROM auth.users u JOIN public.user_profiles p ON u.id = p.id WHERE email = 'newmao6120@gmail.com'");
        console.log(res.rows);
    } catch (e: any) {
        console.error("Error:", e.message);
    } finally {
        await client.end();
    }
}

checkData();
