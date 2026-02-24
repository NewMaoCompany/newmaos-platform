import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config({ path: 'server/.env' });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testStep8() {
    console.log("=========================================");
    console.log("🧪 RUNNING STEP 8 VERIFICATION (Closed-Loop Analytics)");
    console.log("=========================================");

    const { data: users, error: userErr } = await supabase
        .from('user_profiles')
        .select('id')
        .limit(1);

    if (userErr || !users || users.length === 0) return console.error("❌ Need user:", userErr);
    const testUserId = users[0].id;

    // Call the created Research view
    console.log(`\n▶️ Checking Research Calibration Pipeline (vw_research_prediction_calibration)...`);
    const { data: calibration, error: calErr } = await supabase
        .from('vw_research_prediction_calibration')
        .select('*')
        .limit(5);

    if (calErr) {
        // If it fails, maybe there's no data in attempts, that's fine, we check if the view is readable at all
        console.error("❌ View Execution Failed:", calErr);
    } else {
        console.log(`✅ Success! Analytical Pipeline is active and queryable.`);
        if (calibration && calibration.length > 0) {
            console.log("\n🔭 Daily Model Accuracy Calibration Report:");
            console.table(calibration);
        } else {
            console.log("⚠️ View is empty - needs user to do some attempts first.");
        }
    }

    // Call the Skill Analysis view
    console.log(`\n▶️ Checking Skill Tracking Pipeline (vw_research_skill_aggregation)...`);
    const { data: skillAgg, error: skillErr } = await supabase
        .from('vw_research_skill_aggregation')
        .select('*')
        .limit(5);

    if (skillErr) {
        console.error("❌ View Execution Failed:", skillErr);
    } else {
        console.log(`✅ Success! Global Skill Aggregation Pipeline is active and queryable.`);
        if (skillAgg && skillAgg.length > 0) {
            console.log("\n🔭 Cluster/Skill Aggregation Report (Top 5):");
            console.table(skillAgg);
        } else {
            console.log("⚠️ View is empty - needs user to do some attempts first.");
        }
    }

    console.log("\n✅ STEP 8 ANALYTICS SUITE TESTS COMPLETED.");
}

testStep8();
