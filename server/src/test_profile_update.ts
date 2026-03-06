import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.resolve(__dirname, '../../server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const anonKey = process.env.SUPABASE_ANON_KEY || '';

const client = createClient(supabaseUrl, anonKey);

async function testUpsert() {
    // Need to login to test RLS
    const { data, error: loginError } = await client.auth.signInWithPassword({
        email: 'newmao6120@gmail.com',
        password: 'CzLjc6120!'
    });

    if (loginError) {
        console.error('Login failed:', loginError);
        return;
    }

    console.log('Logged in as:', data.user.id);
    const userId = data.user.id;

    // Try to update avatar_url
    const testUrl = 'https://example.com/test-avatar.png';
    const { data: updateData, error: updateError } = await client
        .from('user_profiles')
        .update({ avatar_url: testUrl })
        .eq('id', userId)
        .select();

    if (updateError) {
        console.error('Update failed:', updateError.message);
    } else {
        console.log('Update success:', updateData);
    }

    // Try Upsert
    const { error: upsertError } = await client
        .from('user_profiles')
        .upsert({ id: userId, avatar_url: testUrl + '2' })
        .select();

    if (upsertError) {
        console.error('Upsert failed:', upsertError.message);
    } else {
        console.log('Upsert success!');
    }
}

testUpsert();
