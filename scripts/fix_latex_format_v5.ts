
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Input: v3 (which has 2 backslashes in memory)
// Target: 1 backslash in memory.
// JSON file: \\
// JS String: "\\"
const inputPath = path.resolve(__dirname, '../questions_export_fixed_v3.json');
const outputPath = path.resolve(__dirname, '../questions_export_fixed_v5.json');

// Regex: One or more backslashes
const BAD_LATEX_REGEX = /\\+(?=[a-zA-Z0-9{},:;!%&#_\|\^])/g;

// Target: 1 backslash in memory (\)
// JS String literal for one backslash is "\\"
const REPLACEMENT = "\\";

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
        console.log('DEBUG: First Prompt (v3 value):', questions[0].prompt);
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

        if (changed) fixedCount++;
        return q;
    });

    // DEBUG
    if (fixedQuestions.length > 0) {
        console.log('DEBUG: First Prompt (v5 value):', fixedQuestions[0].prompt);
    }

    console.log(`Fixed ${fixedCount} questions.`);
    fs.writeFileSync(outputPath, JSON.stringify(fixedQuestions, null, 2));
    console.log(`Written to ${outputPath}`);
}

processQuestions();
