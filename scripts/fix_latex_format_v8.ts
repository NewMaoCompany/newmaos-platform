
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Input: v7 (still has literal \n which breaks KaTeX)
// Output: v8
const inputPath = path.resolve(__dirname, '../questions_export_fixed_v7.json');
const outputPath = path.resolve(__dirname, '../questions_export_fixed_v8.json');

// Replaces literal "\n" with " " (space)
// We need to be careful not to break "\nabla".
// So we use regex again but correct this time.

// In JS Regex:
// To match a literal backslash, we need "\\".
// To match 'n', we need "n".
// So regex is /\\n/g.
// BUT we want to avoid \nabla etc.
// So /\\n(?![a-zA-Z])/g
//
// In v7 script, I used /\\n(?![a-zA-Z])/g.
// It SHOULD have worked for "literal backslash followed by n".
//
// Let's debug why it didn't work.
// Maybe the file content is actually "\\n" (double backslash n)?
// If od -c shows \   n, it means single backslash.
//
// Hypothesis: The `fixText` function in v7 was correct regex-wise, but maybe
// `JSON.parse` consumed the backslash?
//
// If JSON has "\n", parse gives newline char.
// If JSON has "\\n", parse gives "\n" string.
//
// If the file content shows "\n", then it is parsed as Newlime Char.
//
// So we should replace NEWLINE CHAR with space.
// Regex for newline char is /\n/g.

function fixText(text: string): string {
    if (!text) return text;
    // Replace actual newline characters with space
    return text.replace(/\n/g, ' ');
}

function processQuestions() {
    console.log('Reading questions (v7)...');
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
                    ['value', 'text', 'latex', 'content', 'explanation'].forEach(k => {
                        if (newOpt[k] && typeof newOpt[k] === 'string') newOpt[k] = fixText(newOpt[k]);
                    });
                    return newOpt;
                }
                return opt;
            });
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
