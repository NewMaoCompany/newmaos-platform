
require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function fetchAllData() {
    const tables = [
        'activities',
        'attempt_errors',
        'course_progress',
        'error_tags',
        'notifications',
        'question_attempts',
        'question_error_patterns',
        'question_skills',
        'question_versions',
        'questions',
        'recommendations',
        'sections',
        'skills',
        'topic_content',
        'unit_mastery',
        'user_profiles',
        'user_question_state',
        'user_section_progress',
        'user_skill_mastery',
        'user_stats',
        'verification_codes'
    ];

    const backup = {
        timestamp: new Date().toISOString(),
        data: {}
    };

    console.log('Starting full database backup...');

    for (const table of tables) {
        try {
            console.log(`Fetching table: ${table}...`);
            const { data, error } = await supabase.from(table).select('*');
            if (error) {
                console.warn(`Warning: Could not fetch ${table}:`, error.message);
                backup.data[table] = { error: error.message };
            } else {
                backup.data[table] = data;
                console.log(`Successfully fetched ${data.length} rows from ${table}.`);
            }
        } catch (e) {
            console.error(`Unexpected error fetching ${table}:`, e.message);
        }
    }

    const fileName = `supabase_full_backup_${new Date().toISOString().replace(/[:.]/g, '-')}.json`;
    fs.writeFileSync(fileName, JSON.stringify(backup, null, 2));
    console.log(`\nFull backup completed! Saved to ${fileName}`);
}

fetchAllData();
