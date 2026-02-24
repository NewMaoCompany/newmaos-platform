import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: './server/.env' });

const supabaseUrl = process.env.VITE_SUPABASE_URL || '';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const supabaseAdmin = createClient(supabaseUrl, supabaseKey);

async function checkAttempts() {
    console.log("URL:", supabaseUrl ? "Found" : "Miss", "Key:", supabaseKey ? "Found" : "Miss");
    const { data: users, error: err } = await supabaseAdmin.auth.admin.listUsers();
    const user = users?.users?.find((u: any) => u.email === 'zhuchen6120@gmail.com');
    if (!user) {
        console.log("Test user not found");
        return;
    }

    // Check QA attempts
    const { data, error } = await supabaseAdmin
        .from('question_attempts')
        .select('id, question_id, is_correct, created_at')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

    console.log(`User ${user.email} has ${data?.length || 0} attempts.`);
    console.log(data?.slice(0, 5));
}

checkAttempts();
