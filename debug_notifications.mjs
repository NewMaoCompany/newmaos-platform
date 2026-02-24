import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

const supabase = createClient(
    process.env.VITE_SUPABASE_URL,
    process.env.SUPABASE_SERVICE_ROLE_KEY
);

async function check() {
    const { data: users, error: uErr } = await supabase
        .from('users')
        .select('id, email')
        .ilike('email', 'newmao6120@gmail.com');

    console.log('Test users:', users);

    if (users?.length) {
        for (const u of users) {
            const { data: progress } = await supabase
                .from('section_progress')
                .select('data, user_id, entity_type')
                .eq('user_id', u.id)
                .eq('entity_type', 'algorithmic')
                .not('data->currentIncorrectIds', 'is', null);

            console.log(`Progress for ${u.email}:`, progress?.length, 'sessions');
            if (progress) {
                progress.forEach(p => {
                    if (p.data && p.data.currentIncorrectIds) {
                        console.log(`  - Topic: ${p.data.sessionTopic}, currentIncorrectIds length:`, Array.isArray(p.data.currentIncorrectIds) ? p.data.currentIncorrectIds.length : typeof p.data.currentIncorrectIds);
                    } else {
                        console.log(`  - Topic: ${p.data?.sessionTopic}, NO currentIncorrectIds property.`);
                    }
                })
            }
        }
    }
}

check();
