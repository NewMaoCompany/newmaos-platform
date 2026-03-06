import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_ANON_KEY || '';
const supabase = createClient(supabaseUrl, serviceKey);

async function run() {
    console.log("Signing in...");
    const { data: { session }, error: signInError } = await supabase.auth.signInWithPassword({
        email: 'newmao6120@gmail.com',
        password: 'password123'
    });
    
    if (signInError) {
        console.error("SignIn Error:", signInError.message);
        return;
    }
    
    const userId = session.user.id;
    console.log("User ID:", userId);
    
    const syncData = {
        name: "NewMaoS.com",
        avatar_url: "https://test-avatar.com/image.png",
        bio: "Test Bio",
        avatar_color: "blue",
        show_name: true,
        show_email: false,
        show_bio: true,
        equipped_title_id: null,
        email_notifications: true,
        sound_effects: true,
        selected_prestige_level: 1,
        show_prestige: true
    };
    
    console.log("Attempting to update profile via Client RLS directly...");
    const { data, error } = await supabase.from('user_profiles').update(syncData).eq('id', userId);
    
    if (error) {
        console.error("Update failed! Error:", JSON.stringify(error, null, 2));
    } else {
        console.log("Update succeeded!");
    }
}
run();
