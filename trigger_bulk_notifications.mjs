import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
// We MUST use the service role key to execute this RPC without RLS restrictions

if (!supabaseUrl) {
    console.error("Missing config!");
    process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceKey || process.env.SUPABASE_ANON_KEY);

async function triggerBulkNotifications() {
    console.log('Triggering generate_daily_notifications_bulk...');

    const { error } = await supabase.rpc('generate_daily_notifications_bulk');

    if (error) {
        console.error('Error triggering RPC:', error.message);
    } else {
        console.log('Successfully triggered bulk notifications.');
    }
}

triggerBulkNotifications();
