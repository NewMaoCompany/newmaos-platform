import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep7() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 7 VERIFICATION (End-to-End Orchestrator)");
    console.log("=========================================");

    const { data: users, error: userErr } = await supabase
        .from('user_profiles')
        .select('id')
        .limit(1);

    if (userErr || !users || users.length === 0) return console.error("❌ Need user:", userErr);
    const testUserId = users[0].id;
    console.log(`User selected: ${testUserId}`);

    // Call the heavy orchestrator
    console.log(`\n▶️ Generating Final Practice Recommendations for [ADAPTIVE] Mode...`);
    const start = performance.now();
    const { data: recs, error: recErr } = await supabase.rpc('generate_practice_recommendations', {
        p_user_id: testUserId,
        p_mode: 'adaptive',
        p_topic_id: 'Both_Limits',
        p_limit: 3
    });
    const end = performance.now();

    if (recErr) {
        console.error("❌ RPC Execution Failed:", recErr);
    } else {
        console.log(`✅ Success! End-to-End Orchestration Latency: ${(end - start).toFixed(2)}ms`);
        console.log(`Returned Top ${recs?.length || 0} successfully generated recommendations.`);

        if (recs && recs.length > 0) {
            console.log("\n🥇 TOP RECOMMENDED QUESTION:");
            const c1 = recs[0];
            // Handle Postgres sometimes returning JSON as string in RPC calls
            const detailStr = typeof c1.reason_detail === 'string' ? JSON.parse(c1.reason_detail) : c1.reason_detail;
            console.log(`- Recommendation ID: ${c1.id}`);
            console.log(`- Question ID:       ${c1.question_id}`);
            console.log(`- Priority (Score):  ${c1.priority}`);
            console.log(`- Base Reason:       ${c1.reason}`);
            console.log(`- Dynamic UI Text:   ${detailStr.why_text}`);

            console.log(`\n📋 Final Stored reason_detail Payload:`);
            console.log(JSON.stringify(detailStr, null, 2));
        }

        // Verify it was actually written to the DB
        console.log("\n▶️ Cross-checking database persistence...");
        const { data, count, error: countErr } = await supabase
            .from('recommendations')
            .select('*', { count: 'exact' })
            .eq('user_id', testUserId)
            .eq('mode', 'adaptive');

        if (countErr) {
            console.error("❌ Database query failed:", countErr);
        } else {
            console.log(`✅ DB Confirmed: Found ${count} pending recommendations in the table.`);
        }
    }

    console.log("\n✅ STEP 7 END-TO-END TESTS COMPLETED.");
}

testStep7();
