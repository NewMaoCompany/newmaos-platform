/**
 * Deep analysis of Unit 1 questions - comprehensive checks
 */
import fs from 'fs';

const data = JSON.parse(fs.readFileSync('scripts/unit1_questions_dump.json', 'utf8'));
console.log(`Analyzing ${data.length} questions\n`);

// Sort by title
data.sort((a, b) => {
    // Natural sort: 1.0-UT-Q1 < 1.0-UT-Q2 < 1.1-P1 < 1.1-P2 etc.
    return a.title.localeCompare(b.title, undefined, { numeric: true });
});

let allIssues = [];

// ========================================
// CHECK 1: Title coverage - are all expected titles present?
// ========================================
console.log('=== CHECK 1: TITLE COVERAGE ===');
const existingTitles = new Set(data.map(q => q.title));

// Expected: 1.0-UT-Q1 to 1.0-UT-Q20 (20 unit test questions)
// 1.1-P1 to 1.16-P5 (16 chapters * 5 practice = 80 questions)
// Total expected: 100
const expectedTitles = [];
for (let i = 1; i <= 20; i++) expectedTitles.push(`1.0-UT-Q${i}`);
for (let ch = 1; ch <= 16; ch++) {
    for (let p = 1; p <= 5; p++) expectedTitles.push(`1.${ch}-P${p}`);
}

const missing = expectedTitles.filter(t => !existingTitles.has(t));
const extra = [...existingTitles].filter(t => !expectedTitles.includes(t));
console.log(`Expected: ${expectedTitles.length}, Found: ${data.length}`);
if (missing.length) {
    console.log(`MISSING (${missing.length}):`, missing.join(', '));
    missing.forEach(t => allIssues.push({ title: t, category: 'MISSING', detail: `Title "${t}" not found in DB` }));
}
if (extra.length) {
    console.log(`EXTRA (${extra.length}):`, extra.join(', '));
}

// ========================================
// CHECK 2: Detailed per-question analysis
// ========================================
console.log('\n=== CHECK 2: PER-QUESTION ANALYSIS ===');

for (const q of data) {
    const t = q.title;
    const opts = q.options || [];

    // --- 2a: correct_option_id validity ---
    const correctId = q.correct_option_id;
    const optionIds = opts.map(o => o.id);
    const optionLabels = opts.map(o => o.label);

    if (!correctId) {
        allIssues.push({ title: t, category: 'CORRECT_ANSWER', detail: 'Missing correct_option_id' });
    } else if (!optionIds.includes(correctId) && !optionLabels.includes(correctId)) {
        allIssues.push({ title: t, category: 'CORRECT_ANSWER', detail: `correct_option_id "${correctId}" not in options (ids: ${optionIds.join(',')})` });
    }

    // --- 2b: micro_explanations key format ---
    const me = q.micro_explanations;
    if (me) {
        const keys = Object.keys(me);
        const isNumericKeys = keys.every(k => /^\d+$/.test(k));
        const isLabelKeys = keys.every(k => ['A', 'B', 'C', 'D'].includes(k));

        if (isNumericKeys && !isLabelKeys) {
            allIssues.push({ title: t, category: 'MICRO_EXPL_KEYS', detail: `micro_explanations uses numeric keys (${keys.join(',')}) instead of labels (A,B,C,D)` });
        }

        // Check if correct answer has explanation
        if (!me[correctId]) {
            // Try to find by matching
            if (isNumericKeys) {
                // Keys are 0,1,2,3 - need to map to A,B,C,D
                const correctIdx = ['A', 'B', 'C', 'D'].indexOf(correctId);
                if (correctIdx >= 0 && me[String(correctIdx)]) {
                    // Has explanation but under numeric key
                } else {
                    allIssues.push({ title: t, category: 'MICRO_EXPL_MISMATCH', detail: `No micro_explanation for correct answer "${correctId}"` });
                }
            }
        }

        // Check if number of explanations matches number of options
        if (keys.length !== opts.length) {
            allIssues.push({ title: t, category: 'MICRO_EXPL_COUNT', detail: `${keys.length} micro_explanations but ${opts.length} options` });
        }
    } else {
        allIssues.push({ title: t, category: 'MICRO_EXPL_MISSING', detail: 'No micro_explanations at all' });
    }

    // --- 2c: Options content check ---
    for (let i = 0; i < opts.length; i++) {
        const opt = opts[i];
        const content = opt.value || opt.text || '';
        if (!content.trim()) {
            allIssues.push({ title: t, category: 'OPTION_EMPTY', detail: `Option ${opt.label || opt.id || i} has no content (text/value)` });
        }

        // Check option has explanation
        if (!opt.explanation || !opt.explanation.trim()) {
            // Check in micro_explanations instead
            const key = opt.label || opt.id;
            if (!me || !me[key]) {
                // Not a critical issue if micro_explanations exist with numeric keys
            }
        }
    }

    // --- 2d: Prompt validation ---
    const prompt = q.prompt;
    if (Array.isArray(prompt)) {
        const textParts = prompt.filter(p => typeof p === 'string' && !p.startsWith('http'));
        if (textParts.length === 0 || textParts.every(p => !p.trim())) {
            allIssues.push({ title: t, category: 'PROMPT_NO_TEXT', detail: 'Prompt array has no text content (only image URL)' });
        }
    } else if (typeof prompt === 'string' && !prompt.trim()) {
        allIssues.push({ title: t, category: 'PROMPT_EMPTY', detail: 'Prompt is an empty string' });
    }

    // --- 2e: prompt_type consistency ---
    if (q.prompt_type === 'image') {
        const hasImage = Array.isArray(prompt)
            ? prompt.some(p => typeof p === 'string' && p.startsWith('http'))
            : (typeof prompt === 'string' && prompt.startsWith('http'));
        if (!hasImage) {
            allIssues.push({ title: t, category: 'PROMPT_TYPE_MISMATCH', detail: 'prompt_type is "image" but no image URL in prompt' });
        }
    } else if (q.prompt_type === 'text') {
        if (Array.isArray(prompt) && prompt.some(p => typeof p === 'string' && p.startsWith('http'))) {
            allIssues.push({ title: t, category: 'PROMPT_TYPE_MISMATCH', detail: 'prompt_type is "text" but prompt contains image URL' });
        }
    }

    // --- 2f: Skill tags validation ---
    if (!q.primary_skill_id) {
        allIssues.push({ title: t, category: 'SKILL_MISSING', detail: 'Missing primary_skill_id' });
    }

    // Check skill_tags array matches primary + supporting
    const expectedSkills = [q.primary_skill_id, ...(q.supporting_skill_ids || [])].filter(Boolean);
    const actualSkills = q.skill_tags || [];

    // --- 2g: Topic/Section consistency ---
    // Unit 1 should have topic_id matching "Both_Limits" or similar
    // section_id should match the chapter
    const titleMatch = t.match(/^1\.(\d+)/);
    if (titleMatch) {
        const chNum = parseInt(titleMatch[1]);
        if (chNum === 0) {
            // Unit test
            if (q.section_id !== 'unit_test' && q.sub_topic_id !== 'unit_test') {
                allIssues.push({ title: t, category: 'SECTION_MISMATCH', detail: `Unit test question has section_id="${q.section_id}" / sub_topic_id="${q.sub_topic_id}" instead of "unit_test"` });
            }
        }
    }

    // --- 2h: Missing explanation ---
    if (!q.explanation || (typeof q.explanation === 'string' && !q.explanation.trim())) {
        allIssues.push({ title: t, category: 'EXPLANATION_MISSING', detail: 'Missing general explanation' });
    }

    // --- 2i: Difficulty consistency ---
    if (q.difficulty === null || q.difficulty === undefined) {
        allIssues.push({ title: t, category: 'DIFFICULTY_MISSING', detail: 'Missing difficulty' });
    }

    // --- 2j: Number of options ---
    if (opts.length !== 4) {
        allIssues.push({ title: t, category: 'OPTION_COUNT', detail: `Has ${opts.length} options instead of 4` });
    }

    // --- 2k: Duplicate option content ---
    const optContents = opts.map(o => (o.value || o.text || '').trim().toLowerCase());
    const uniqueContents = new Set(optContents);
    if (uniqueContents.size < optContents.length && uniqueContents.size > 0) {
        allIssues.push({ title: t, category: 'OPTION_DUPLICATE', detail: `Duplicate option content detected` });
    }

    // --- 2l: representation_type check ---
    const validRepTypes = ['symbolic', 'graphical', 'numerical', 'verbal', 'mixed'];
    if (q.representation_type && !validRepTypes.includes(q.representation_type)) {
        allIssues.push({ title: t, category: 'REP_TYPE_INVALID', detail: `Invalid representation_type: "${q.representation_type}"` });
    }

    // --- 2m: Image in prompt but representation_type not graphical ---
    if (q.prompt_type === 'image' && q.representation_type !== 'graphical' && q.representation_type !== 'mixed') {
        allIssues.push({ title: t, category: 'REP_TYPE_MISMATCH', detail: `Has image but representation_type is "${q.representation_type}" (expected "graphical" or "mixed")` });
    }
}

// ========================================
// SUMMARY
// ========================================
console.log('\n=== ISSUE SUMMARY ===');
const categories = {};
allIssues.forEach(issue => {
    if (!categories[issue.category]) categories[issue.category] = [];
    categories[issue.category].push(issue);
});

Object.keys(categories).sort().forEach(cat => {
    const items = categories[cat];
    console.log(`\n[${cat}] (${items.length} issues):`);
    items.forEach(item => console.log(`  - ${item.title}: ${item.detail}`));
});

console.log(`\n\nTOTAL: ${allIssues.length} issues across ${Object.keys(categories).length} categories`);

// Write full report
fs.writeFileSync('scripts/unit1_analysis_report.json', JSON.stringify({ total: allIssues.length, categories, issues: allIssues }, null, 2));
console.log('\nFull report saved to scripts/unit1_analysis_report.json');
