import fs from 'fs';

const data = JSON.parse(fs.readFileSync('extracted_tags.json', 'utf-8'));

// Define ~100 Core Calculus Skills (Broad Buckets)
const skillBuckets = {
    'Limits & Continuity': ['limit', 'l\'hopital', 'continuity', 'asymptote', 'squeeze', 'ivt'],
    'Derivative Rules': ['power rule', 'product rule', 'quotient rule', 'chain rule', 'implicit', 'inverse', 'logarithmic', 'exponential'],
    'Applications of Derivatives': ['tangent', 'normal line', 'velocity', 'acceleration', 'position', 'particle motion', 'related rate', 'optimization', 'linear approximation'],
    'Derivative Analysis': ['increasing', 'decreasing', 'concavity', 'inflection', 'first derivative test', 'second derivative test', 'extrema', 'extreme value', 'evt', 'mvt', 'mean value'],
    'Integration Basics': ['riemann', 'trapezoidal', 'antiderivative', 'integral property', 'indefinite', 'definite', 'accumulation'],
    'Integration Techniques': ['u-sub', 'substitution', 'by parts', 'partial fraction', 'long division', 'completing the square', 'improper'],
    'FTC & Advanced Integration': ['ftc', 'fundamental theorem', 'area function', 'average value', 'net change'],
    'Differential Equations': ['slope field', 'euler', 'separable', 'logistic', 'growth', 'decay'],
    'Applications of Integration': ['area between', 'volume', 'cross section', 'disk', 'washer', 'shell', 'arc length'],
    'Parametric & Polar': ['parametric', 'polar', 'vector', 'speed'],
    'Series Basics': ['sequence', 'geometric', 'harmonic', 'telescoping', 'p-series', 'alternating', 'integral test', 'comparison'],
    'Series Convergence': ['ratio test', 'root test', 'radius of convergence', 'interval of convergence', 'absolute convergence', 'conditional convergence'],
    'Taylor Series': ['taylor', 'maclaurin', 'lagrange', 'error bound', 'power series']
};

// Define ~50 Core Error Categories
const errorBuckets = {
    'Sign/Negative Error': ['sign', 'negative', 'negatives'],
    'Arithmetic/Algebra Slip': ['arithmetic', 'algebra', 'calculation', 'fraction', 'simplify', 'simplification'],
    'Trig Error': ['trig', 'sine', 'cosine', 'pi', 'angle'],
    'Chain Rule Missing/Error': ['chain rule', 'inner derivative', 'u-sub du'],
    'Derivative Rule Confusion': ['product rule', 'quotient rule', 'power rule', 'derivative', 'antiderivative instead'],
    'Integration Mistake': ['+ c', 'constant c', 'bounds', 'limit of integration', 'swap bounds', 'integration by parts', 'u-sub bounds', 'u-substitution'],
    'Conceptual Limit/Continuity': ['limit doesn', 'infinity', 'ivt', 'squeeze'],
    'Extrema/Points of Inflection': ['inflection', 'concavity', 'extrema', 'critical point', 'sign chart', 'first derivative test', 'second derivative test'],
    'Particle Motion/Physics': ['speed vs velocity', 'distance vs displacement', 'acceleration', 'initial condition'],
    'Series Convergence Errors': ['ratio test', 'interval', 'radius', 'alternating', 'error bound', 'taylor'],
    'Formula/Notation Error': ['formula', 'notation', 'dx', 'setup', 'equation']
};

function assignBucket(name, buckets, fallbackName) {
    const lowerName = name.toLowerCase();
    for (const [bucket, keywords] of Object.entries(buckets)) {
        if (keywords.some(k => lowerName.includes(k))) {
            return bucket;
        }
    }
    return fallbackName; // default
}

let sql = `
-- ============================================================
-- Ultimate Manual Clustering Script
-- Goal: Aggressively group 1400+ tags into ~20 broad categories
-- ============================================================

`;

const generatedSkillClusters = new Set();
const generatedErrorClusters = new Set();

sql += `-- 1. Define Skill Clusters\n`;
const skillCategoryMapping = {};
data.skills.forEach(s => {
    const bucket = assignBucket(s.name, skillBuckets, 'Other Concepts');
    const clusterId = 'c_skill_' + bucket.toLowerCase().replace(/[^a-z0-9]/g, '_');

    if (!generatedSkillClusters.has(clusterId)) {
        sql += `INSERT INTO public.skill_clusters (id, name, category, description) VALUES ('${clusterId}', '${bucket}', 'Aggregated Group', 'Manual aggregation for ${bucket}') ON CONFLICT (id) DO NOTHING;\n`;
        generatedSkillClusters.add(clusterId);
    }
    skillCategoryMapping[s.id] = clusterId;
});

sql += `\n-- 2. Define Error Clusters\n`;
const errorCategoryMapping = {};
data.errors.forEach(e => {
    const bucket = assignBucket(e.name, errorBuckets, 'Other Concepts');
    const clusterId = 'c_err_' + bucket.toLowerCase().replace(/[^a-z0-9]/g, '_');

    if (!generatedErrorClusters.has(clusterId)) {
        sql += `INSERT INTO public.error_tag_clusters (id, name, category, default_severity, description) VALUES ('${clusterId}', '${bucket}', 'Aggregated Group', 3, 'Manual aggregation for ${bucket}') ON CONFLICT (id) DO NOTHING;\n`;
        generatedErrorClusters.add(clusterId);
    }
    errorCategoryMapping[e.id] = clusterId;
});

// Since doing 2000 individual UPDATE statements is slow, we use a giant CASE WHEN.
sql += `\n-- 3. Bulk Update Skills\nUPDATE public.skills SET cluster_id = CASE id\n`;
for (const [id, clusterId] of Object.entries(skillCategoryMapping)) {
    sql += `  WHEN '${id.replace(/'/g, "''")}' THEN '${clusterId}'\n`;
}
sql += `  ELSE cluster_id END;\n`;

sql += `\n-- 4. Bulk Update Error Tags\nUPDATE public.error_tags SET cluster_id = CASE id\n`;
for (const [id, clusterId] of Object.entries(errorCategoryMapping)) {
    sql += `  WHEN '${id.replace(/'/g, "''")}' THEN '${clusterId}'\n`;
}
sql += `  ELSE cluster_id END;\n`;

fs.writeFileSync('database/migrations/super_cluster.sql', sql);
console.log('Generated database/migrations/super_cluster.sql!');
