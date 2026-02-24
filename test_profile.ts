import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: './server/.env' });

const supabaseUrl = process.env.VITE_SUPABASE_URL || '';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const supabaseAdmin = createClient(supabaseUrl, supabaseKey);

async function main() {
    console.log("URL:", supabaseUrl ? "Found" : "Miss", "Key:", supabaseKey ? "Found" : "Miss");
    const { data: listData, error: userErr } = await supabaseAdmin.auth.admin.listUsers();
    if (userErr) { console.error("List users err:", userErr); return; }
    const users = listData?.users || [];
    const user = users.find((u: any) => u.email === 'newmao6120@gmail.com');
    if (user) {
        const { data, error } = await supabaseAdmin.from('user_profiles').select('avatar_url').eq('id', user.id).single();
        console.log("DB Avatar URL:", data?.avatar_url);
        console.log("Error:", error?.message);
    }
}
main();
