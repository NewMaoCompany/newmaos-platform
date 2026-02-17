import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase URL or Key');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// Common LaTeX commands that might appear without a backslash
const suspectKeywords = [
    'frac', 'sqrt', 'sin', 'cos', 'tan', 'lim', 'sum', 'int', 'infty',
    'left', 'right', 'ln', 'log', 'pi', 'theta'
];

// Regex to find these keywords NOT preceded by a backslash or a letter (to avoid matching 'fraction' or 'cosine')
// We want to find distinct 'frac', 'sqrt' etc. that are missing the backslash.
// However, 'frac' usually appears immediately after something.
// A safe check is: look for "frac" that is NOT preceded by "\"
// But we must allow "fraction" (which has frac).
// So we want `(?<!\\)frac` but JS lookbehind support varies.
// Let's use a simpler approach: match regex and check.

async function scanForMissingBackslashes() {
    console.log('Fetching all questions...');

    // Page metadata to know where we are
    const { count } = await supabase.from('questions').select('*', { count: 'exact', head: true });
    console.log(`Total questions: ${count}`);

    const { data: questions, error } = await supabase
        .from('questions')
        .select('*')
        .order('id');

    if (error) {
        console.error('Error fetching questions:', error);
        return;
    }

    const issues: any[] = [];

    for (const q of questions) {
        const brokenFields: string[] = [];

        // Helper to check text
        const check = (text: string, context: string) => {
            if (!text) return;
            // Scan for each keyword
            for (const kw of suspectKeywords) {
                // Regex: 
                // 1. Not preceded by \
                // 2. Contains the keyword
                // 3. Keyword not followed by alphabetical chars (so 'fraction' is ignored for 'frac')
                // Actually 'frac' is almost always followed by '{' or number. 'fraction' is followed by 't'.

                // Construct regex dynamically
                // We want to find "frac" where:
                // - Preceding char is NOT '\'
                // - Following char is NOT a letter (unless it's part of the command like 'sinn' which is bad but 'sin' is good)
                // - BUT: 'frac' implies 'fraction'. If we have 'fraction', 'frac' matches.
                // WE ONLY CARE IF IT LOOKS LIKE MATH.
                // 'frac' appearing in "This fraction is..." is fine.
                // 'frac12' is bad. 'frac{1}{2}' is bad.

                // Let's look for "frac" followed by "{" or digit or space, NOT followed by "tion" (approx).

                let regex;
                if (kw === 'frac') {
                    regex = /(?<!\\)frac[^{a-zA-Z]*[{0-9]/g; // frac followed by { or digit, possibly spaces, NOT preceded by backslash
                    // JS lookbehind support is good in Node 18+.
                    // If it fails we can do standard match and check index.
                } else if (kw === 'sqrt') {
                    regex = /(?<!\\)sqrt/g;
                } else {
                    // For others like 'sin', 'cos', they might be text words.
                    // 'sin' is okay in "using", "single". 'cos' in "cost".
                    // So we only care if they look like math context: e.g. "sin(x)", "sin x", "sin \theta".
                    // This is hard to perfect.
                    // Let's focus on 'frac' and 'sqrt' and 'sum' 'int' 'lim' first as they are most obvious.
                    if (['sin', 'cos', 'tan', 'ln', 'log'].includes(kw)) continue; // skip ambiguous ones for now
                    regex = new RegExp(`(?<!\\\\)${kw}`, 'g');
                }

                try {
                    if (regex.test(text)) {
                        // Double check it's not a false positive like "fraction" for "frac" if regex was loose
                        if (kw === 'frac' && text.includes('fraction')) {
                            // potential false positive, but our regex expects { or digit after frac
                        }
                        brokenFields.push(`${context}: found '${kw}' without backslash`);
                        break; // Found one issue in this field, enough to flag
                    }
                } catch (e) {
                    // Fallback if lookbehind not supported
                    if (text.indexOf(kw) !== -1 && text.indexOf('\\' + kw) === -1) {
                        brokenFields.push(`${context}: matches '${kw}' (fallback check)`);
                        break;
                    }
                }
            }
        };

        check(q.prompt, 'Prompt');
        check(q.explanation, 'Explanation');

        if (Array.isArray(q.options)) {
            q.options.forEach((opt: any, idx: number) => {
                check(opt.value || opt.text, `Option ${idx}`);
                check(opt.explanation, `Option ${idx} Explanation`);
            });
        }

        if (brokenFields.length > 0) {
            issues.push({
                id: q.id,
                broken_fields: brokenFields,
                preview: q.prompt?.substring(0, 50) + '...'
            });
        }
    }

    console.log(`Found ${issues.length} questions with missing backslashes.`);
    fs.writeFileSync('missing_backslashes_report.json', JSON.stringify(issues, null, 2));
    console.log('Report saved to missing_backslashes_report.json');
}

scanForMissingBackslashes();
