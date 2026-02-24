import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep2() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 2 BENCHMARK VERIFICATION TEST");
    console.log("=========================================");

    // Fetch a real user to guarantee accurate test data
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
    console.log(`User selected: ${testUserId}`);

    // Test A) get_recent_attempts
    console.log(`\n▶️ Test A: get_recent_attempts(user_id, k=5)`);
    const startA = performance.now();
    const { data: resA, error: errA } = await supabase.rpc('get_recent_attempts', { p_user_id: testUserId, p_k: 5 });
    const endA = performance.now();

    if (errA) console.error("❌ Test A Failed:", errA);
    else {
        console.log(`✅ Success! Latency: ${(endA - startA).toFixed(2)}ms (Goal: < 200ms)`);
        console.log(`Returns ${resA?.length || 0} rows. Sample:`, resA && resA.length > 0 ? resA[0] : 'empty');
    }

    // Test B) get_recent_error_frequencies
    console.log(`\n▶️ Test B: get_recent_error_frequencies(user_id, days=7)`);
    const startB = performance.now();
    const { data: resB, error: errB } = await supabase.rpc('get_recent_error_frequencies', { p_user_id: testUserId, p_days: 7 });
    const endB = performance.now();

    if (errB) console.error("❌ Test B Failed:", errB);
    else {
        console.log(`✅ Success! Latency: ${(endB - startB).toFixed(2)}ms (Goal: < 200ms)`);
        console.log(`Returns ${resB?.length || 0} error buckets. Sample:`, resB && resB.length > 0 ? resB[0] : 'empty');
    }

    // Test C) get_normalized_skill_mastery
    console.log(`\n▶️ Test C: get_normalized_skill_mastery(user_id)`);
    const startC = performance.now();
    const { data: resC, error: errC } = await supabase.rpc('get_normalized_skill_mastery', { p_user_id: testUserId });
    const endC = performance.now();

    if (errC) console.error("❌ Test C Failed:", errC);
    else {
        console.log(`✅ Success! Latency: ${(endC - startC).toFixed(2)}ms (Goal: < 200ms)`);
        console.log(`Returns ${resC?.length || 0} normalized skills. Sample:`, resC && resC.length > 0 ? resC[0] : 'empty');
    }

    // Test Mapping Views
    console.log(`\n▶️ Test Mapping Views: v_skill_cluster_map & v_error_cluster_map`);
    const startV1 = performance.now();
    const { data: view1, error: ve1 } = await supabase.from('v_skill_cluster_map').select('*').limit(1);
    const endV1 = performance.now();

    const startV2 = performance.now();
    const { data: view2, error: ve2 } = await supabase.from('v_error_cluster_map').select('*').limit(1);
    const endV2 = performance.now();

    if (ve1 || ve2) console.error("❌ View Test Failed:", ve1 || ve2);
    else {
        console.log(`✅ v_skill_cluster_map Success! Latency: ${(endV1 - startV1).toFixed(2)}ms`);
        console.log(`✅ v_error_cluster_map Success! Latency: ${(endV2 - startV2).toFixed(2)}ms`);
    }
}

testStep2();
