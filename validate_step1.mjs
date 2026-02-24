import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep1() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 1 VERIFICATION TEST");
    console.log("=========================================");

    // 1. Fetch a real user ID to satisfy Foreign Key constraints
    console.log("Fetching a valid user_id for testing...");
    const { data: users, error: userErr } = await supabase
        .from('user_profiles')
        .select('id')
        .limit(1);

    if (userErr || !users || users.length === 0) {
        console.error("❌ Failed to find a real user for testing:", userErr);
        return;
    }
    const testUserId = users[0].id;
    console.log(`Found valid user_id: ${testUserId}`);

    console.log(`\nCalling RPC: generate_practice_recommendations`);
    console.log(`Params: mode='adaptive', topic_id='Both_Limits', section_id=null, limit=5`);

    const { data: result, error: rpcError } = await supabase.rpc('generate_practice_recommendations', {
        p_user_id: testUserId,
        p_mode: 'adaptive',
        p_topic_id: 'Both_Limits',
        p_limit: 5,
        p_exclude_question_ids: []
    });

    if (rpcError) {
        console.error("❌ RPC Execution Failed:", rpcError);
        return;
    }

    console.log(`\n✅ RPC Success! Returned ${result?.length || 0} recommendations.`);
    if (result && result.length > 0) {
        console.log("Sample Data Output:");
        console.log(JSON.stringify(result[0], null, 2));
    }

    console.log("\nVerifying Database Insertion (public.recommendations table)...");
    const { data: dbData, error: dbError } = await supabase
        .from('recommendations')
        .select('*')
        .eq('user_id', testUserId);

    if (dbError) {
        console.error("❌ DB Verification Failed:", dbError);
        return;
    }

    console.log(`✅ DB Verification Success! Found ${dbData?.length || 0} records for test user.`);
    if (dbData && dbData.length > 0) {
        console.log("1st Record written to Database:");
        console.log(JSON.stringify(dbData[0], null, 2));

        // Clean up the mock test
        await supabase.from('recommendations').delete().eq('user_id', testUserId);
        console.log("\n🧹 Cleaned up test database records.");
    }
}

testStep1();
