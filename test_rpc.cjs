require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function test() {
    const { data: recs, error } = await supabase.rpc('generate_practice_recommendations', {
        p_user_id: '1e3fcb05-8e3d-4c38-afcc-408a2879fcfd', // Let's try to query it
        p_mode: 'practice',
        p_topic_id: 'Both_Limits',
        p_section_id: '1.1',
        p_limit: 10
    });
    console.log('Error:', error);
    console.log('Recommendations length:', recs ? recs.length : 0);
    console.log('Recommendations:', recs);
}
test();
