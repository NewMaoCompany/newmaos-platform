
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';

// Load environment variables
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, '../.env.local') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseServiceKey = process.env.VITE_SUPABASE_ANON_KEY;
// NOTE using ANON key. If RLS blocks this, we will fail. 
// But we might be able to read. Updating requires Service Role or Auth.
// Since we don't have Service Role, we'll try Anon. 
// If it fails, we will generate a SQL script instead.

if (!supabaseUrl || !supabaseServiceKey) {
    console.error('Missing Supabase credentials in .env.local');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

// Regex to identify potential LaTeX that is NOT wrapped in $...$
// This is tricky. A simple heuristic is to look for common LaTeX commands
// that are likely to appear in math questions.
// We'll look for:
// 1. backslash followed by specific command (frac, lim, sum, int, alpha, etc.)
// 2. OR words like "lim_" "sum_" etc if backslash is missing (as seen in screenshot)
// 3. AND ensure they are NOT already inside $...$ or $$...$$

// Based on user screenshot: "lim_{hto0} frac{f(2)..." -> No backslashes!
// This suggests the content might have been stripped of backslashes or just raw text.
// Wait, the screenshot shows "lim_{h \to 0}". It MIGHT have backslashes but they aren't rendering.
// actually the user says "mathematical formula problem...".
// The screenshot shows "lim_{h \to 0}" but rendered as text.
// If it was just text "lim_{h \to 0}", it means backslashes ARE there (or at least the braces).
// If it was "lim_{h to 0}" (no backslash), it would look different.
// The presence of "_" and "{}" strongly implies it's intended to be LaTeX.

// Strategy:
// 1. Fetch all questions.
// 2. Iterate through prompt, explanation, and options.
// 3. Use a "smart" regex to find blocks that look like LaTeX but lack delimiters.
//    - Look for sequences containing `\`, `{`, `}`, `_`, `^`.
//    - If a chunk of text contains these but is NOT wrapped in $, wrap it.
//    - Handle the specific case in screenshot: `lim_{...} ...`

function fixContent(text: string): string {
    if (!text) return text;

    // Helper to check if text is likely math
    // Contains \, {, }, _, ^, or common functions like lim, sin, cos, tan, log, ln
    const isLikelyMath = (s: string) => {
        return /[\{\}\_\^]/.test(s) || /\b(lim|sin|cos|tan|log|ln|sum|int|frac|sqrt)\b/.test(s);
    };

    // If it's already wrapped in $, leave it alone (mostly)
    // We'll use a crude split by $ to avoid touching existing math
    const parts = text.split(/(\$[^$]+\$)/g);

    for (let i = 0; i < parts.length; i++) {
        // Even indices are OUTSIDE math mode
        if (i % 2 === 0) {
            let chunk = parts[i];

            // Heuristic 1: If the chunk contains latex-like structure matching specific patterns
            // Pattern: lim_{...} or frac{...}{...} or sqrt{...}
            // We'll replace them.
            // Be careful not to match English text.

            // Fix 1: "lim_..." -> "$lim_...$"
            // We capture the "lim_{...}" block.
            // This is hard with regex alone.
            // Let's look for known math logic that starts with a keyword and looks "mathy"

            // Case A: The ENTIRE chunk is basically math (common in options)
            // If the chunk is short and dense with math symbols, wrap the whole thing.
            if (chunk.trim().length > 0) {
                const mathDensity = (chunk.match(/[\d\w\{\}\_\^\\=\+\-\*\/]/g) || []).length / chunk.length;
                const hasKeywords = /\b(lim|frac|sqrt|sum|int)\b/.test(chunk);
                const hasStructure = /[\{\}\_\^]/.test(chunk);

                // Detailed fix for the specific screenshot case:
                // "lim_{h \to 0} frac{...}"
                // If we see "lim_", "frac", "sqrt", etc. followed by "{", it strongly suggests math.

                // Let's try to wrap specific distinct math expressions.
                // Regex for "something that starts with a keyword or backslash, contains math junk, until end or space"
                // This is risky.

                // Safer approach for the specific request:
                // The user's screenshot shows options that are PURE math but missing $.
                // So if a whole option looks like math, wrap it.
                if (hasKeywords && hasStructure) {
                    // It's likely math.
                    // If it is NOT surrounded by $, wrap it.
                    // Be careful if it's mixed text. 
                    // "Find lim_{x \to 0} f(x)." -> "Find $lim_{x \to 0} f(x)$."

                    // Regex replacement for `lim_...` sequence
                    // matches `lim` or `\lim` followed by `_` or whitespace
                    // extended to include following chars until a stop logic?

                    // Let's try a very specific fix for the reported issue first, which seems to be generic patterns in options.
                    // We will wrap sequences starting with `lim`, `frac`, `sqrt`, `sum`, `int` 
                    // AND containing `{}` 

                    // We can use a replacer function for keywords
                    chunk = chunk.replace(/(\\?(lim|frac|sqrt|sum|int|infty|alpha|beta|theta|pi|sigma|mu|lambda)[\s\S]*?)(?=\s|$|\.|,)/g, (match) => {
                        // Validate match is "mathy"
                        if (match.includes('{') || match.includes('_') || match.includes('^') || match.includes('\\')) {
                            // Check if already wrapped (double check)
                            return `$${match}$`;
                        }
                        return match;
                    });

                    // Also fix bare `f(x)` `g(x)` etc if they look like function calls with math
                    // chunk = chunk.replace(/\b[fgh]\([^)]+\)/g, (match) => `$${match}$`); // Too risky for normal text
                }
            }

            parts[i] = chunk;
        }
    }

    return parts.join('');
}

// Better Fix Function: specific to the user's screenshot
// The screenshot: "lim_{h \to 0} frac{f(2)..."
// This string has spaces. It's likely one continuous math block.
// If an option string matches this pattern, wrap the WHOLE thing.
function fixOption(opt: any): any {
    if (typeof opt !== 'string' && typeof opt !== 'object') return opt;

    let val = typeof opt === 'string' ? opt : (opt.value || opt.text || opt.content);
    if (!val) return opt;

    // Remove existing $ if they are malformed (e.g. at ends only?) No, assume if they exist they are good.
    // Check if it HAS $
    if (val.includes('$')) return opt; // Assume correct if any $ present

    // Check for LaTeX signatures
    const hasLatex = /\\(lim|frac|sqrt|sum|int|infty)/.test(val) ||
        /\b(lim|frac|sqrt|sum|int)_/.test(val) ||
        /\{.*?\}/.test(val) && /[\_\^]/.test(val);

    if (hasLatex) {
        val = `$${val.trim()}$`;
    }

    if (typeof opt === 'string') return val;
    if (typeof opt === 'object') {
        return { ...opt, value: val }; // Update value/text
    }
}

async function run() {
    console.log('Fetching questions...');
    const { data: questions, error } = await supabase
        .from('questions')
        .select('*');

    if (error || !questions) {
        console.error('Error fetching questions:', error);
        return;
    }

    console.log(`Found ${questions.length} questions. Processing...`);

    let updatedCount = 0;

    for (const q of questions) {
        let changed = false;
        let newPrompt = q.prompt;
        let newOptions = q.options;
        let newExplanation = q.explanation; // We can fix explanation too if needed

        // Fix Options (Primary Target)
        if (Array.isArray(q.options)) {
            const fixedOptions = q.options.map((opt: any) => fixOption(opt));

            if (JSON.stringify(fixedOptions) !== JSON.stringify(q.options)) {
                newOptions = fixedOptions;
                changed = true;
            }
        }

        // Fix Prompt (Secondary Target) - Be more careful here
        // If the prompt contains block math that isn't wrapped
        // For now, let's focus on OPTIONS as per screenshot, but safe-check logic applies
        // ... (Skip prompt auto-fix for now to avoid false positives in text, unless it's obviously a "math only" prompt)

        if (changed) {
            const { error: updateError } = await supabase
                .from('questions')
                .update({ options: newOptions })
                .eq('id', q.id);

            if (updateError) {
                console.error(`Failed to update question ${q.id}:`, updateError);
            } else {
                updatedCount++;
                // console.log(`Updated Question ${q.id}`);
            }
        }
    }

    console.log(`Finished! Updated ${updatedCount} questions.`);
}

run();
