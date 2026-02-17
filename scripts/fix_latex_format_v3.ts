
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const inputPath = path.resolve(__dirname, '../questions_export.json'); // Start specific original? Or v2?
// Better to start from original to avoid compounding errors, or v2 is fine since regex handles "one or more".
// Let's use inputPath = questions_export.json (original) to be safe.
const outputPath = path.resolve(__dirname, '../questions_export_fixed_v3.json');

// Regex: One or more backslashes followed by char
const BAD_LATEX_REGEX = /\\+(?=[a-zA-Z0-9{},:;!%&#_\|\^])/g;

// Replacement: \ (1 backslash)
// In JS string literal: "\\" is one backslash char.
// We use "\\\\" to represent "\\" string? No.
// We want replacement string to be "\".
// So we need const rep = "\\"; -> Syntax error.
// We need const rep = "\\\\"; -> String value "\".
const REPLACEMENT = "\\\\";

function fixText(text: string): string {
    if (!text) return text;
    return text.replace(BAD_LATEX_REGEX, REPLACEMENT);
}

function processQuestions() {
    console.log('Reading questions...');
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
                if (typeof opt === 'string') {
                    const fixed = fixText(opt);
                    if (fixed !== opt) changed = true;
                    return fixed;
                }
                if (typeof opt === 'object') {
                    let optChanged = false;
                    const newOpt = { ...opt };
                    ['value', 'text', 'latex', 'content'].forEach(k => {
                        if (newOpt[k] && typeof newOpt[k] === 'string') {
                            const f = fixText(newOpt[k]);
                            if (f !== newOpt[k]) {
                                newOpt[k] = f;
                                optChanged = true;
                                changed = true;
                            }
                        }
                    });
                    if (optChanged) return newOpt;
                }
                return opt;
            });
            q.options = newOptions;
        }

        if (q.micro_explanations && typeof q.micro_explanations === 'object') {
            const newMicro = { ...q.micro_explanations };
            let microChanged = false;
            Object.keys(newMicro).forEach(key => {
                if (typeof newMicro[key] === 'string') {
                    const f = fixText(newMicro[key]);
                    if (f !== newMicro[key]) {
                        newMicro[key] = f;
                        microChanged = true;
                        changed = true;
                    }
                }
            });
            if (microChanged) q.micro_explanations = newMicro;
        }

        if (changed) fixedCount++;
        return q;
    });

    console.log(`Fixed ${fixedCount} questions.`);
    fs.writeFileSync(outputPath, JSON.stringify(fixedQuestions, null, 2));
    console.log(`Written to ${outputPath}`);
}

processQuestions();
