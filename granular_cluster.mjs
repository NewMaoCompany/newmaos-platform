import fs from 'fs';

const data = JSON.parse(fs.readFileSync('live_tags_clean.json', 'utf-8'));

// Stopwords to ignore
const stopWords = new Set(['and', 'of', 'in', 'the', 'to', 'from', 'with', 'a', 'an', 'on', 'for', 'by', 'is', 'at', 'basic', 'error', 'mistake', 'slip', 'wrong', 'e', 'sk', 'use', 'using', 'find', 'finding']);

function extractKeywords(name, isError) {
    let clean = name.toLowerCase().replace(/[^a-z0-9 ]/g, ' ');
    let words = clean.split(/\s+/).filter(w => w.length > 2 && !stopWords.has(w));

    if (isError) {
        // Many errors start with "e " or end with "error". Already filtered by stopWords.
    }

    // Return the first 2 meaningful words as the cluster key
    if (words.length >= 2) {
        return words.slice(0, 2).join(' ');
    } else if (words.length === 1) {
        return words[0];
    } else {
        return 'general_concept';
    }
}

// Capitalize helper
function toTitleCase(str) {
    return str.replace(
        /\w\S*/g,
        function (txt) {
            return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
        }
    );
}

const skillClustersMap = {}; // key -> [items]
data.skills.forEach(s => {
    let key = extractKeywords(s.name, false);

    // Manual adjustments for too broad keys or known overlaps
    if (key.includes('deriv')) key = 'derivatives ' + (key.split(' ')[1] || 'general');
    if (key.includes('integr')) key = 'integrals ' + (key.split(' ')[1] || 'general');
    if (key.includes('limit')) key = 'limits ' + (key.split(' ')[1] || 'general');
    if (key === 'general_concept') key = 'mixed review';

    if (!skillClustersMap[key]) skillClustersMap[key] = [];
    skillClustersMap[key].push(s);
});

const errorClustersMap = {};
data.errors.forEach(e => {
    let key = extractKeywords(e.name, true);

    if (key.includes('sign') || key.includes('negativ')) key = 'sign negatives';
    if (key.includes('arith') || key.includes('calcul')) key = 'arithmetic calculation';
    if (key.includes('algebra')) key = 'algebra algebraic';
    if (key === 'general_concept') key = 'general conceptual failure';

    if (!errorClustersMap[key]) errorClustersMap[key] = [];
    errorClustersMap[key].push(e);
});

// Force small clusters into 'Miscellaneous' if they are size 1, to prevent singletons but keep granularity high
function optimizeClusters(map, prefix) {
    const optimized = { 'Miscellaneous Concepts': [] };
    for (const [key, items] of Object.entries(map)) {
        if (items.length <= 1) {
            optimized['Miscellaneous Concepts'].push(...items);
        } else {
            optimized[toTitleCase(key)] = items;
        }
    }
    if (optimized['Miscellaneous Concepts'].length === 0) {
        delete optimized['Miscellaneous Concepts'];
    }
    return optimized;
}

const finalSkills = optimizeClusters(skillClustersMap, 'c_skill_');
const finalErrors = optimizeClusters(errorClustersMap, 'c_err_');

console.log(`Generated ${Object.keys(finalSkills).length} Skill Clusters.`);
console.log(`Generated ${Object.keys(finalErrors).length} Error Clusters.`);

// Generate SQL
let sql = '-- ============================================================\n';
sql += '-- Granular Auto-Clustering Script (~100 clusters each)\n';
sql += '-- ============================================================\n\n';

sql += '-- 1. Skill Clusters\n';
for (const [clusterName, items] of Object.entries(finalSkills)) {
    const clusterId = ('c_skill_' + clusterName.toLowerCase().replace(/[^a-z0-9]/g, '_')).substring(0, 50);
    sql += `INSERT INTO public.skill_clusters (id, name, category, description) VALUES ('${clusterId}', '${clusterName.replace(/'/g, "''")}', 'Calculus Concept', 'Automatically grouped concepts spanning ${items.length} tags.') ON CONFLICT (id) DO NOTHING;\n`;

    for (const item of items) {
        sql += `UPDATE public.skills SET cluster_id = '${clusterId}' WHERE id = '${item.id.replace(/'/g, "''")}';\n`;
    }
}

sql += '\n-- 2. Error Clusters\n';
for (const [clusterName, items] of Object.entries(finalErrors)) {
    const clusterId = ('c_err_' + clusterName.toLowerCase().replace(/[^a-z0-9]/g, '_')).substring(0, 50);
    sql += `INSERT INTO public.error_tag_clusters (id, name, category, default_severity, description) VALUES ('${clusterId}', '${clusterName.replace(/'/g, "''")}', 'Diagnostic Category', 3, 'Automatically grouped errors spanning ${items.length} tags.') ON CONFLICT (id) DO NOTHING;\n`;

    for (const item of items) {
        sql += `UPDATE public.error_tags SET cluster_id = '${clusterId}' WHERE id = '${item.id.replace(/'/g, "''")}';\n`;
    }
}

fs.writeFileSync('database/migrations/granular_cluster.sql', sql);
console.log('Saved to database/migrations/granular_cluster.sql');
