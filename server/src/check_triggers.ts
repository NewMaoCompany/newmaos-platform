import pkg from 'pg';
const { Client } = pkg;

async function checkTriggers() {
    const client = new Client({
        connectionString: process.env.SUPABASE_DB_URL,
        ssl: false
    });
    try {
        await client.connect();
        const res = await client.query(`
            SELECT event_object_schema, event_object_table, trigger_name, action_statement
            FROM information_schema.triggers
            WHERE event_object_table IN ('users', 'user_profiles');
        `);
        console.log("Triggers:", res.rows);
    } catch (e: any) {
        console.error("Error:", e.message);
    } finally {
        await client.end();
    }
}

checkTriggers();
