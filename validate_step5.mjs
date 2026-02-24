import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep5() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 5 VERIFICATION TEST (Candidate Generation)");
    console.log("=========================================");

    console.log("Fetching a valid user_id for testing...");
    const { data: users, error: userErr } = await supabase
        .from('user_profiles')
        .select('id')
        .limit(1);

    if (userErr || !users || users.length === 0) return console.error("❌ Need user:", userErr);
    const testUserId = users[0].id;
    console.log(`User selected: ${testUserId}`);

    // Test Adaptive Mode Selection
    console.log(`\n▶️ Generating Candidates for [ADAPTIVE] Mode (Topic: Both_Limits)...`);
    const startAd = performance.now();
    const { data: adData, error: adErr } = await supabase.rpc('get_recommendation_candidates', {
        p_user_id: testUserId,
        p_mode: 'adaptive',
        p_topic_id: 'Both_Limits',
        p_limit: 10
    });
    const endAd = performance.now();

    if (adErr) {
        console.error("❌ RPC Execution Failed:", adErr);
    } else {
        console.log(`✅ Success! Latency: ${(endAd - startAd).toFixed(2)}ms`);
        console.log(`Found ${adData?.length || 0} candidate questions.`);
        if (adData && adData.length > 0) {
            console.log("\nSample Candidate 1:");
            const c1 = adData[0];
            console.log(`- Question ID:    ${c1.question_id}`);
            console.log(`- Base Reason:    ${c1.reason}`);
            console.log(`- Clusters C(i):  ${c1.c_i}`);
            console.log(`- Penalty Score:  ${c1.cluster_penalty} (Repeats in last 10 attempts)`);
        }
    }

    // Test Review Mode Selection
    console.log(`\n▶️ Generating Candidates for [REVIEW] Mode (Topic: Both_Limits)...`);
    const startRev = performance.now();
    const { data: revData, error: revErr } = await supabase.rpc('get_recommendation_candidates', {
        p_user_id: testUserId,
        p_mode: 'review',
        p_topic_id: 'Both_Limits',
        p_limit: 10
    });
    const endRev = performance.now();

    if (revErr) {
        console.error("❌ RPC Execution Failed:", revErr);
    } else {
        console.log(`✅ Success! Latency: ${(endRev - startRev).toFixed(2)}ms`);
        console.log(`Found ${revData?.length || 0} candidate questions.`);
    }

    console.log("\n✅ STEP 5 CANDIDATE ENGINE TESTS COMPLETED.");
}

testStep5();
