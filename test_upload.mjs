import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_ANON_KEY || ''; // USE ANON KEY
const supabase = createClient(supabaseUrl, serviceKey);

async function run() {
    console.log("Signing in...");
    // Attempting sign-in with the user seen in screenshot
    const { data: { session }, error: signInError } = await supabase.auth.signInWithPassword({
        email: 'newmao6120@gmail.com',
        password: 'password123' // fallback
    });
    
    if (signInError) {
        console.log("SignIn Error:", signInError.message);
        return;
    }
    
    console.log("User ID:", session.user.id);
    
    // Attempt an upload
    const dummyContent = "dummy image data";
    const filePath = `${session.user.id}/test_avatar_${Date.now()}.txt`;
    
    console.log("Attempting to upload to:", filePath);
    const { data, error } = await supabase.storage.from('avatars').upload(filePath, dummyContent);
    
    if (error) {
        console.error("Upload failed! RLS Issue:", error.message);
    } else {
        console.log("Upload succeeded!", data);
    }
}
run();
