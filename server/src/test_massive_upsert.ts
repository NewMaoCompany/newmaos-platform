import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, '../../server/.env') });

const client = createClient(process.env.SUPABASE_URL || '', process.env.SUPABASE_ANON_KEY || '');

async function testMassiveUpsert() {
    const { data: { session }, error: loginError } = await client.auth.signInWithPassword({
        email: 'newmao6120@gmail.com', password: 'CzLjc6120!'
    });
    if (loginError) return console.error(loginError);

    const syncData = {
        name: 'Newmaos',
        avatar_url: 'https://test.com/img.png',
        subscription_tier: 'pro',
        subscription_period_end: new Date().toISOString(),
        has_seen_pro_intro: true,
        bio: 'Hello',
        avatar_color: 'white',
        show_name: true,
        show_email: true,
        show_bio: true,
        show_prestige: true, // THIS MIGHT NOT EXIST
        equipped_title_id: 'some_id',
        email_notifications: true,
        sound_effects: true
    };

    const { error } = await client.from('user_profiles').upsert({ id: session.user.id, ...syncData });
    if (error) {
        console.error('UPSERT FAILED!!!', error.message);
    } else {
        console.log('UPSERT SUCCEEDED!');
    }
}
testMassiveUpsert();
