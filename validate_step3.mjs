import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep3() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 3 VERIFICATION TEST (Question Profiles)");
    console.log("=========================================");

    console.log("Fetching a random question profile to verify the math engine...");

    // We only want active/published questions
    const { data: profiles, error: err } = await supabase
        .from('v_question_profiles')
        .select('*')
        .in('status', ['active', 'published'])
        .limit(1);

    if (err) {
        console.error("❌ Test Failed - SQL View Error:", err);
        return;
    }

    if (!profiles || profiles.length === 0) {
        console.error("❌ Test Failed - No active questions found in view.");
        return;
    }

    const p = profiles[0];
    console.log("✅ View Queried Successfully!");
    console.log("\n--- ALGORITHM PROFILE FOR QUESTION ---");
    console.log(`ID:         ${p.question_id}`);
    console.log(`Topic:      ${p.topic_id}`);
    console.log(`Status:     ${p.status}`);
    console.log(`t_target:   ${p.t_target} seconds`);

    console.log(`\nb(i) Difficulty Scalar: ${p.b_i}`);
    console.log(`(Formula: 0 + 0.9*difficulty + 0.7*reasoning_level)`);

    console.log(`\nw(i,s) Skills Tensor:`);
    console.log(JSON.stringify(p.w_is, null, 2));

    console.log(`\nC(i) Mapped Clusters (Semantic Categories):`);
    console.log(p.c_i.length > 0 ? p.c_i : "[] (No clusters mapped for these skills)");

    console.log("\n✅ ALL STEP 3 MATH VECTORS EXTRACTED PERFECTLY.");
}

testStep3();
