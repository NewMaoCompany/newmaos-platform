
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Input: v5 (has fixed prompt/explanation, but broken options.explanation)
// Output: v6
const inputPath = path.resolve(__dirname, '../questions_export_fixed_v5.json');
const outputPath = path.resolve(__dirname, '../questions_export_fixed_v6.json');

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
    console.log('Reading questions (v5)...');
    const raw = fs.readFileSync(inputPath, 'utf-8');
    const questions = JSON.parse(raw);

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
                    // Added 'explanation' to the list of fields to fix
                    ['value', 'text', 'latex', 'content', 'explanation'].forEach(k => {
                        if (newOpt[k] && typeof newOpt[k] === 'string') newOpt[k] = fixText(newOpt[k]);
                    });
                    return newOpt;
                }
                return opt;
            });
            // Check if options actually changed (deep compare or just always update)
            // Simpler to just update
            if (JSON.stringify(newOptions) !== JSON.stringify(q.options)) {
                q.options = newOptions;
                changed = true;
            }
        }

        if (q.micro_explanations && typeof q.micro_explanations === 'object') {
            const newMicro = { ...q.micro_explanations };
            let microChanged = false;
            Object.keys(newMicro).forEach(key => {
                if (typeof newMicro[key] === 'string') {
                    const original = newMicro[key];
                    const fixed = fixText(original);
                    if (original !== fixed) {
                        newMicro[key] = fixed;
                        microChanged = true;
                    }
                }
            });
            if (microChanged) {
                q.micro_explanations = newMicro;
                changed = true;
            }
        }

        if (changed) fixedCount++;
        return q;
    });

    console.log(`Fixed ${fixedCount} questions.`);
    fs.writeFileSync(outputPath, JSON.stringify(fixedQuestions, null, 2));
    console.log(`Written to ${outputPath}`);
}

processQuestions();
