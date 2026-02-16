
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

// Load env from server/.env
dotenv.config({ path: path.resolve(process.cwd(), 'server/.env') });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function checkUser() {
    const email = 'newmao6120@gmail.com';
    console.log(`Checking user: ${email}`);

    const { data: { users }, error } = await supabase.auth.admin.listUsers();

    if (error) {
        console.error('Error listing users:', error);
        return;
    }

    const user = (users as any[]).find(u => u.email === email);

    if (user) {
        console.log('User found:', {
            id: user.id,
            email: user.email,
            email_confirmed_at: user.email_confirmed_at,
            last_sign_in_at: user.last_sign_in_at,
            created_at: user.created_at,
            app_metadata: user.app_metadata,
            user_metadata: user.user_metadata
        });
    } else {
        console.log('User NOT found.');
    }
}

checkUser();
