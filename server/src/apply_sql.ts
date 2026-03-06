import pkg from 'pg';
const { Client } = pkg;
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function applySql() {
    console.log("Connecting to Supabase Direct Port [Object Config]...");
    const client = new Client({
        host: 'db.xzpjlnkirboevkjzitcx.supabase.co',
        port: 5432,
        database: 'postgres',
        user: 'postgres',
        password: 'Supabase2025@ap',
        ssl: { rejectUnauthorized: false }
    });
    try {
        await client.connect();
        console.log("Connected to Supabase DB via pg.");

        // Read the SQL script
        const sqlPath = path.resolve(__dirname, '../../database/migrations/step5_candidate_generation.sql');
        console.log("Reading SQL file:", sqlPath);
        const sqlContent = fs.readFileSync(sqlPath, 'utf8');

        console.log("Applying SQL block (length:", sqlContent.length, "bytes)...");
        await client.query(sqlContent);
        console.log("SQL successfully applied! The recommendation logic has been updated.");
    } catch (e: any) {
        console.error("Error applying SQL:", e.message);
    } finally {
        await client.end();
    }
}

applySql();
