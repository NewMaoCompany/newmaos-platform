import pkg from 'pg';
const { Client } = pkg;

async function checkRLS() {
    const client = new Client({
        connectionString: "postgresql://postgres.xzpjlnkirboevkjzitcx:Supabase2025%40ap@aws-0-us-east-1.pooler.supabase.com:6543/postgres?sslmode=disable",
        ssl: false
    });
    try {
        await client.connect();
        const res = await client.query(`
            SELECT policyname, permissive, roles, cmd, qual, with_check 
            FROM pg_policies 
            WHERE tablename = 'user_profiles';
        `);
        console.log("Policies:", res.rows);
    } catch (e: any) {
        console.error("Error:", e.message);
    } finally {
        await client.end();
    }
}

checkRLS();
