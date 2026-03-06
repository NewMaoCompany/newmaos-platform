import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(__dirname, '../../server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || '';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function checkDashboardQuery() {
    const email = 'newmao6120@gmail.com';
    const password = 'CzLjc6120!';

    const { data: authData } = await supabase.auth.signInWithPassword({ email, password });
    if (!authData.user) return console.log("Login failed");

    const userId = authData.user.id;

    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const { data, error } = await supabase
        .from('question_attempts')
        .select('question_id, is_correct, time_spent_seconds, created_at')
        .eq('user_id', userId)
        .gte('created_at', startOfDay.toISOString());

    console.log("Error:", error);
    console.log("Data length:", data?.length);
    console.log("Dashboard fetch data:", data);
}

checkDashboardQuery();
