
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const inputPath = path.resolve(__dirname, '../questions_export.json');
const outputPath = path.resolve(__dirname, '../questions_export_fixed_v2.json');

// Regex to match ANY number of backslashes followed by a letter or symbol
// We want to normalize to 3 backslashes (which is \\\\\\ in JSON file, \\\ in memory)
const BAD_LATEX_REGEX = /\\+(?=[a-zA-Z0-9{},:;!%&#_\|\^])/g;

// Replacement: \\\ (3 backslashes)
const REPLACEMENT = "\\\\\\";

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

        // Fields to fix
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

        // Fix options (JSON array of strings or objects)
        if (q.options && Array.isArray(q.options)) {
            const newOptions = q.options.map((opt: any) => {
                // If option is string
                if (typeof opt === 'string') {
                    const fixed = fixText(opt);
                    if (fixed !== opt) changed = true;
                    return fixed;
                }
                // If option is object
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

        // Fix micro_explanations 
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
