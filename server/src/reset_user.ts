import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(__dirname, '../../server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || '';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function clearUserData() {
    const email = 'newmao6120@gmail.com';
    const password = 'CzLjc6120!';

    const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
        email,
        password
    });

    if (authError || !authData.user) return console.error('Error logging in:', authError);
    const userId = authData.user.id;

    const tables = [
        'question_attempts',
        'user_section_progress',
        'unit_mastery',
        'user_stats',
        'course_progress',
        'activities'
    ];

    for (const table of tables) {
        console.log(`Clearing ${table}...`);
        const { error } = await supabase
            .from(table)
            .delete()
            .eq('user_id', userId);

        if (error) {
            console.error(`Error clearing ${table}:`, error);
        } else {
            console.log(`✅ Cleared ${table}`);
        }
    }

    console.log(`Resetting user_profiles stats...`);
    const { error: profileError } = await supabase
        .from('user_profiles')
        .update({
            problems_solved: 0,
            study_hours: [0, 0, 0, 0, 0, 0, 0],
            percentile: 0
        })
        .eq('id', userId);

    if (profileError) console.error('Error resetting user_profiles:', profileError);
    else console.log('✅ Reset user_profiles');
}

clearUserData().catch(console.error);
