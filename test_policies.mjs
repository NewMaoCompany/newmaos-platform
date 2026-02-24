import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;
// Need service key for pg_policies if public cannot read it. 
// Can we read pg_policies via RPC? Probably not if not exposed.
// Let's just create a new file to read it.
