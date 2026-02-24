import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep4() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 4 VERIFICATION TEST (Prediction Model)");
    console.log("=========================================");

    // 1. Fetch a real user
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

    // 2. Fetch a valid active question
    const { data: qs, error: qErr } = await supabase
        .from('questions')
        .select('id, topic_id')
        .in('status', ['active', 'published'])
        .limit(1);

    if (qErr || !qs || qs.length === 0) {
        console.error("❌ Failed to find a real question:", qErr);
        return;
    }
    const testQuestionId = qs[0].id;
    console.log(`Question selected: ${testQuestionId} (${qs[0].topic_id})`);

    // 3. Run the Predictive Model
    console.log(`\n▶️ Generating Prediction P(u,i) for User + Question...`);
    const start = performance.now();
    const { data: prediction, error: rpcErr } = await supabase.rpc('calculate_question_prediction', {
        p_user_id: testUserId,
        p_question_id: testQuestionId
    });
    const end = performance.now();

    if (rpcErr) {
        console.error("❌ RPC Execution Failed:", rpcErr);
        return;
    }

    console.log(`✅ Success! Engine Calculation Latency: ${(end - start).toFixed(2)}ms`);
    console.log("\n--- EXPLAINABLE ALGORITHM OUTPUT ---");
    console.log(`Target User: ${testUserId}`);
    console.log(`Target Question: ${testQuestionId}`);

    console.log(`\n🔥 Predicted Correctness [ P(u,i) ]: ${(prediction.p_ui * 100).toFixed(2)}%`);

    console.log(`\n📉 Top Contributing WEAK Skills (Explainability):`);
    console.log(JSON.stringify(prediction.top_contributing_skills, null, 2));

    console.log(`\n📉 Top Contributing WEAK Clusters (Explainability):`);
    console.log(JSON.stringify(prediction.top_contributing_clusters, null, 2));

    console.log("\n✅ STEP 4 PREDICTIVE ENGINE VERIFIED.");
}

testStep4();
