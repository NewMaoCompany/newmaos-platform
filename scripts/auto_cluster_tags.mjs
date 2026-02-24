import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Ensure it points perfectly to /server/.env
dotenv.config({ path: path.resolve(__dirname, '../server/.env') });

const supabaseUrl = process.env.SUPABASE_URL || '';
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY || '';

if (!supabaseUrl) {
    console.error("Missing config!");
    process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceKey);

// ==========================================
// Utility: Normalize Strings
// ==========================================
// Removes special characters, extra spaces, and converts to lowercase
// Examples:
// "Derivatives Basics (Unit 2)" => "derivatives basics unit 2"
// "DERIVATIVE_BASICS" => "derivative basics"
function normalizeString(str) {
    if (!str) return '';
    return str
        .toLowerCase()
        .replace(/[_]/g, ' ') // Convert underscores to spaces
        .replace(/[^a-z0-9 ]/g, '') // Remove all non-alphanumeric except spaces
        .replace(/\s+/g, ' ') // Collapse multiple spaces
        .trim();
}

// Generate an ID-safe version of a string
function slugify(str) {
    return normalizeString(str).replace(/\s+/g, '_');
}

// Compute string similarity (Jaccard similarity on words)
function similarity(str1, str2) {
    const set1 = new Set(str1.split(' '));
    const set2 = new Set(str2.split(' '));
    const intersection = new Set([...set1].filter(x => set2.has(x)));
    const union = new Set([...set1, ...set2]);
    return intersection.size / union.size;
}

// ==========================================
// Step 1: Cluster Skills
// ==========================================
async function clusterSkills() {
    console.log('⏳ Fetching all skills from database...');
    const { data: skills, error } = await supabase.from('skills').select('*');

    if (error || !skills) {
        console.error('❌ Error fetching skills:', error?.message);
        return;
    }

    console.log(`📊 Found ${skills.length} skills total.`);

    // Group by exact normalized name first
    const exactGroups = {};

    skills.forEach(skill => {
        // Prioritize name, fallback to ID if name is missing/weird
        const normName = normalizeString(skill.name || skill.id);

        if (!exactGroups[normName]) {
            exactGroups[normName] = [];
        }
        exactGroups[normName].push(skill);
    });

    const numDistinct = Object.keys(exactGroups).length;
    console.log(`🧠 Analyzed names: found ${numDistinct} conceptually distinct skills before fuzzy matching.`);

    // Now we create clusters for groups with > 1 element, OR single elements (to migrate everyone fully to clusters over time)
    // For safety, we will just create clusters for EVERYTHING and bind them. 

    let newClustersCreated = 0;
    let skillsUpdated = 0;

    for (const [normName, group] of Object.entries(exactGroups)) {
        // Generate a cluster ID based on the normalized name
        const clusterId = `cluster_skill_${slugify(normName).substring(0, 80)}`;

        // Use the best looking name from the group (longest/most capitalized usually better)
        const bestName = group.reduce((prev, current) =>
            (prev.name.length > current.name.length) ? prev : current
        ).name;

        // Unify the unit (just take the first one available)
        const category = group[0].unit || 'General';

        // 1. Upsert into skill_clusters
        const { error: clusterErr } = await supabase.from('skill_clusters').upsert({
            id: clusterId,
            name: bestName,
            category: category,
            description: `Auto-generated cluster for ${group.length} similar items.`,
        }, { onConflict: 'id' });

        if (clusterErr) {
            console.error(`❌ Failed to create cluster ${clusterId}:`, clusterErr.message);
            continue;
        }
        newClustersCreated++;

        // 2. Bind the existing skills to this cluster
        for (const skill of group) {
            if (skill.cluster_id !== clusterId) {
                const { error: updateErr } = await supabase.from('skills')
                    .update({ cluster_id: clusterId })
                    .eq('id', skill.id);

                if (updateErr) {
                    console.error(`❌ Failed to bind skill ${skill.id}:`, updateErr.message);
                } else {
                    skillsUpdated++;
                }
            }
        }
    }

    console.log(`✅ Skills Clustering Complete: Created ${newClustersCreated} clusters, automatically bound ${skillsUpdated} duplicate/existing skills.`);
}


// ==========================================
// Step 2: Cluster Error Tags
// ==========================================
async function clusterErrorTags() {
    console.log('⏳ Fetching all error_tags from database...');
    const { data: errors, error } = await supabase.from('error_tags').select('*');

    if (error || !errors) {
        console.error('❌ Error fetching error_tags:', error?.message);
        return;
    }

    console.log(`📊 Found ${errors.length} error tags total.`);

    // Group by exact normalized name
    const exactGroups = {};

    errors.forEach(err => {
        const normName = normalizeString(err.name || err.id);
        if (!exactGroups[normName]) {
            exactGroups[normName] = [];
        }
        exactGroups[normName].push(err);
    });

    let newClustersCreated = 0;
    let errorsUpdated = 0;

    for (const [normName, group] of Object.entries(exactGroups)) {
        const clusterId = `cluster_err_${slugify(normName).substring(0, 80)}`;
        const bestName = group[0].name || group[0].id;
        const category = group[0].category || 'General';
        const severity = group[0].severity || 3;

        // 1. Upsert into error_tag_clusters
        const { error: clusterErr } = await supabase.from('error_tag_clusters').upsert({
            id: clusterId,
            name: bestName,
            category: category,
            default_severity: severity,
            description: `Auto-generated cluster for ${group.length} similar errors.`,
        }, { onConflict: 'id' });

        if (clusterErr) {
            console.error(`❌ Failed to create cluster ${clusterId}:`, clusterErr.message);
            continue;
        }
        newClustersCreated++;

        // 2. Bind the existing error_tags to this cluster
        for (const err of group) {
            if (err.cluster_id !== clusterId) {
                const { error: updateErr } = await supabase.from('error_tags')
                    .update({ cluster_id: clusterId })
                    .eq('id', err.id);

                if (updateErr) {
                    console.error(`❌ Failed to bind error_tag ${err.id}:`, updateErr.message);
                } else {
                    errorsUpdated++;
                }
            }
        }
    }

    console.log(`✅ Error Tags Clustering Complete: Created ${newClustersCreated} clusters, automatically bound ${errorsUpdated} duplicate/existing errors.`);
}

// Run the suite
async function run() {
    console.log("=========================================");
    console.log("🚀 STARTING AUTO-CLUSTERING SCRIPT");
    console.log("=========================================");
    await clusterSkills();
    console.log("-----------------------------------------");
    await clusterErrorTags();
    console.log("=========================================");
    console.log("🎉 ALL DONE!");
}

run();
