/**
 * Deep dive into specific issues found in Unit 1
 */
import fs from 'fs';

const data = JSON.parse(fs.readFileSync('scripts/unit1_questions_dump.json', 'utf8'));
data.sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));

// ========================================
// DEEP DIVE 1: prompt_type="image" but no URL
// These may be questions that SHOULD have images but images are stored differently
// ========================================
console.log('=== DEEP DIVE 1: prompt_type="image" without image URL ===\n');

const imageNoUrl = data.filter(q => q.prompt_type === 'image');
for (const q of imageNoUrl) {
    const prompt = q.prompt;
    let promptStr;
    if (Array.isArray(prompt)) {
        promptStr = JSON.stringify(prompt).substring(0, 200);
    } else {
        promptStr = String(prompt).substring(0, 200);
    }
    const hasUrl = Array.isArray(prompt)
        ? prompt.some(p => typeof p === 'string' && p.startsWith('http'))
        : typeof prompt === 'string' && prompt.startsWith('http');

    console.log(`${q.title}: hasUrl=${hasUrl}, rep_type=${q.representation_type}`);
    console.log(`  prompt: ${promptStr}`);
    console.log();
}

// ========================================
// DEEP DIVE 2: micro_explanations with numeric keys
// ========================================
console.log('\n=== DEEP DIVE 2: micro_explanations details ===\n');

const meIssues = data.filter(q => {
    const me = q.micro_explanations;
    if (!me) return false;
    const keys = Object.keys(me);
    return keys.some(k => /^\d+$/.test(k));
});

for (const q of meIssues) {
    console.log(`${q.title}: correct=${q.correct_option_id}`);
    console.log(`  micro_explanations keys: ${Object.keys(q.micro_explanations).join(', ')}`);
    Object.entries(q.micro_explanations).forEach(([k, v]) => {
        console.log(`    [${k}]: ${String(v).substring(0, 100)}`);
    });
    console.log(`  options: ${q.options.map(o => `${o.label || o.id}="${(o.value || o.text || '').substring(0, 30)}"`).join(', ')}`);
    console.log();
}

// ========================================
// DEEP DIVE 3: Check correct_option_id alignment with answer content
// For each question: is the correct answer logically sound?
// ========================================
console.log('\n=== DEEP DIVE 3: Correct answer content ===\n');

for (const q of data) {
    const correctId = q.correct_option_id;
    const correctOpt = q.options.find(o => o.id === correctId || o.label === correctId);
    const correctContent = correctOpt ? (correctOpt.value || correctOpt.text || '') : 'NOT FOUND';

    // Just print each question's correct answer for review
    if (!correctOpt) {
        console.log(`!!! ${q.title}: correct_option_id="${correctId}" NOT FOUND in options`);
    }
}

// ========================================
// DEEP DIVE 4: Skill tag consistency
// ========================================
console.log('\n=== DEEP DIVE 4: Skill consistency ===\n');

const skillMap = {};
for (const q of data) {
    const primary = q.primary_skill_id;
    if (primary) {
        if (!skillMap[primary]) skillMap[primary] = [];
        skillMap[primary].push(q.title);
    }
}

console.log('Primary skills used in Unit 1:');
Object.entries(skillMap).sort((a, b) => b[1].length - a[1].length).forEach(([skill, titles]) => {
    console.log(`  ${skill}: ${titles.length} questions (${titles.slice(0, 5).join(', ')}${titles.length > 5 ? '...' : ''})`);
});

// ========================================
// DEEP DIVE 5: Chapter/Section mapping
// ========================================
console.log('\n=== DEEP DIVE 5: Topic/Section mapping ===\n');

const sectionMap = {};
for (const q of data) {
    const key = `${q.topic_id || q.topic} / ${q.section_id || q.sub_topic_id}`;
    if (!sectionMap[key]) sectionMap[key] = [];
    sectionMap[key].push(q.title);
}

Object.entries(sectionMap).sort().forEach(([key, titles]) => {
    console.log(`  ${key}: ${titles.length} questions`);
    console.log(`    (${titles.join(', ')})`);
});

// ========================================
// DEEP DIVE 6: Check for questions with prompt_type="image" but no actual image uploaded
// These are questions that NEED images but don't have them yet
// ========================================
console.log('\n=== DEEP DIVE 6: Questions that need images but have none ===\n');

const needsImage = data.filter(q => {
    if (q.prompt_type !== 'image') return false;
    const prompt = q.prompt;
    if (Array.isArray(prompt)) {
        return !prompt.some(p => typeof p === 'string' && p.startsWith('http'));
    }
    return true;
});

console.log(`${needsImage.length} questions have prompt_type="image" but no uploaded image:`);
needsImage.forEach(q => {
    console.log(`  ${q.title} (rep_type: ${q.representation_type})`);
});

// ========================================
// DEEP DIVE 7: Verify option explanations are meaningful
// ========================================
console.log('\n=== DEEP DIVE 7: Option explanation coverage ===\n');

let noExplCount = 0;
let partialExplCount = 0;
for (const q of data) {
    const me = q.micro_explanations || {};
    const keys = Object.keys(me);

    // Check if each option has an explanation either inline or in micro_explanations
    let hasAll = true;
    for (const opt of q.options) {
        const label = opt.label || opt.id;
        const hasInline = opt.explanation && opt.explanation.trim();
        const hasMicro = me[label] && String(me[label]).trim();
        const hasNumeric = me[String(q.options.indexOf(opt))] && String(me[String(q.options.indexOf(opt))]).trim();
        if (!hasInline && !hasMicro && !hasNumeric) {
            hasAll = false;
        }
    }
    if (!hasAll) {
        partialExplCount++;
    }
}
console.log(`${partialExplCount} questions have incomplete per-option explanations`);
