import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep6() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 6 VERIFICATION TEST (Master Scoring)");
    console.log("=========================================");

    const { data: users, error: userErr } = await supabase
        .from('user_profiles')
        .select('id')
        .limit(1);

    if (userErr || !users || users.length === 0) return console.error("❌ Need user:", userErr);
    const testUserId = users[0].id;
    console.log(`User selected: ${testUserId}`);

    // Call the heavy scoring engine directly
    console.log(`\n▶️ Generating Ranked Scoreboard for [ADAPTIVE] Mode...`);
    const startAd = performance.now();
    const { data: adData, error: adErr } = await supabase.rpc('score_and_rank_candidates', {
        p_user_id: testUserId,
        p_mode: 'adaptive',
        p_topic_id: 'Both_Limits',
        p_limit: 5
    });
    const endAd = performance.now();

    if (adErr) {
        console.error("❌ RPC Execution Failed:", adErr);
    } else {
        console.log(`✅ Success! Heavy Engine Latency: ${(endAd - startAd).toFixed(2)}ms`);
        console.log(`Returned Top ${adData?.length || 0} highest-scoring questions.`);
        if (adData && adData.length > 0) {
            console.log("\n🥇 TOP RANKED QUESTION DETAILS:");
            const c1 = adData[0];
            console.log(`Question ID: ${c1.question_id}`);
            console.log(`Reason:      ${c1.reason}`);
            console.log(`Final Score: ${(c1.score * 100).toFixed(2)}/100`);
            console.log(`Explanation (reason_detail):`);
            console.log(JSON.stringify(c1.reason_detail, null, 2));
        }
    }

    console.log("\n✅ STEP 6 SCORING ENGINE TESTS COMPLETED.");
}

testStep6();
