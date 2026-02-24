import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function check() {
    console.log('Testing avatars bucket...');
    // 1. Try to list buckets
    const { data: buckets, error: bucketErr } = await supabase.storage.listBuckets();
    console.log('Buckets:', buckets?.map(b => b.name), 'Error:', bucketErr?.message);

    // 2. Try to list files in avatars
    const { data: files, error: fileErr } = await supabase.storage.from('avatars').list();
    console.log('Files in avatars:', files?.length, 'Error:', fileErr?.message);

    // 3. Try to upload a dummy file to avatars
    // We need to act as an authenticated user to test RLS accurately.
    // I will just try anon upload first.
    const dummyFile = new Blob(['test'], { type: 'text/plain' });
    const { data: upload, error: uploadErr } = await supabase.storage.from('avatars').upload('test.txt', dummyFile, { upsert: true });
    console.log('Upload result:', upload, 'Error:', uploadErr?.message);
}

check();
