
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Input: v3 (which has `\\` in file -> `\` in memory)
// Output: v4 (which has `\\\\\\\\` in file -> `\\\\` in memory? or `\\\\` -> `\\`?)
// Target: I want `\\\\` in JSON file (which is `\\` in memory).
// Current v3 has `\\\\` in file? Let's assume based on `od -c` output.
// v3 `od -c`: `\   \   \   \` -> 4 backslashes.
// Wait, `od -c` prints escaped chars?
// `\` is 0x5c.
// `od -c` output: `   \   \   \   \`
// That means 4 bytes of 0x5c.
// That means the file contains `\\\\`.
// JSON parse `\\\\` -> `\\` in memory.
// So v3 HAS `\\` in memory.
// And it failed.

// So maybe I need `\` in memory?
// If v3 failed with `\\` in memory.
// Then I need `\` (1 backslash) or `\\\` (3)?
// Wait, `console.log` showed `\\frac`.
// This usually means `\\` in memory.

// Let's look at `questions_export.json` (original) again.
// grep output was 4719 lines with `\\\\`.
// The original file had `\\\\` (4 backslashes).
// And it was broken (too many?).
// Wait, the original screenshot from user showed `d f r a c`?
// No, the original complaint was "format incorrect".
// The latest screenshot (after v3 fix) shows `d f r a c`.
// If v3 has `\\` in memory, and it renders `d f r a c`, then `\\` is being consumed.

// If `\\` is consumed to `\`, and `\` is consumed to nothing?
// `\\frac` -> `\frac` -> `frac`?
// This implies TWO levels of unescaping.
// 1. JSON parse (`\\\\` file -> `\\` memory).
// 2. JS String (already done).
// 3. `ReactMarkdown` or `remark-math`?
// If I need `\frac` effectively.
// And `\\` -> `\frac` -> fail.
// Maybe I need `\\\\` (4 backslashes in memory)?
// `\\\\` -> `\\` -> `\`?
// Let's try 4 backslashes in memory (which is 8 in file).

const inputPath = path.resolve(__dirname, '../questions_export_fixed_v3.json');
const outputPath = path.resolve(__dirname, '../questions_export_fixed_v4.json');

// Regex: One or more backslashes
const BAD_LATEX_REGEX = /\\+(?=[a-zA-Z0-9{},:;!%&#_\|\^])/g;

// Target: 4 backslashes in memory (\\\\)
// JSON file: \\\\\\\\
const REPLACEMENT = "\\\\\\\\";

function fixText(text: string): string {
    if (!text) return text;
    return text.replace(BAD_LATEX_REGEX, REPLACEMENT);
}

function processQuestions() {
    console.log('Reading questions (v3)...');
    const raw = fs.readFileSync(inputPath, 'utf-8');
    const questions = JSON.parse(raw);

    // DEBUG
    if (questions.length > 0) {
        console.log('DEBUG: First Prompt (v3):', questions[0].prompt);
    }

    let fixedCount = 0;
    const fixedQuestions = questions.map((q: any) => {
        let changed = false;
        const fields = ['prompt', 'latex', 'explanation'];
        for (const field of fields) {
            if (q[field] && typeof q[field] === 'string') {
                const original = q[field];
                const fixed = fixText(original);
                if (original !== fixed) {
                    q[field] = fixed;
                    changed = true;
                }
            }
        }
        // ... (options/micro omitted for brevity, assumed consistent)
        // I'll copy the full logic to be safe
        if (q.options && Array.isArray(q.options)) {
            const newOptions = q.options.map((opt: any) => {
                if (typeof opt === 'string') return fixText(opt);
                if (typeof opt === 'object') {
                    const newOpt = { ...opt };
                    ['value', 'text', 'latex', 'content'].forEach(k => {
                        if (newOpt[k] && typeof newOpt[k] === 'string') newOpt[k] = fixText(newOpt[k]);
                    });
                    return newOpt;
                }
                return opt;
            });
            q.options = newOptions;
        }
        if (q.micro_explanations && typeof q.micro_explanations === 'object') {
            const newMicro = { ...q.micro_explanations };
            Object.keys(newMicro).forEach(key => {
                if (typeof newMicro[key] === 'string') newMicro[key] = fixText(newMicro[key]);
            });
            q.micro_explanations = newMicro;
        }

        fixedCount++; // Always count as processed
        return q;
    });

    // DEBUG
    if (fixedQuestions.length > 0) {
        console.log('DEBUG: First Prompt (v4):', fixedQuestions[0].prompt);
    }

    console.log(`Processed ${fixedQuestions.length} questions.`);
    fs.writeFileSync(outputPath, JSON.stringify(fixedQuestions, null, 2));
    console.log(`Written to ${outputPath}`);
}

processQuestions();
