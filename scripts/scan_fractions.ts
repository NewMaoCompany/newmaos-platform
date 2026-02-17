
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL || 'https://xzpjlnkirboevkjzitcx.supabase.co';
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase URL or Key');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function scanForFractions() {
    console.log('Fetching all questions...');

    // We fetch all columns to check prompt, explanation, and options
    const { data: questions, error } = await supabase
        .from('questions')
        .select('*');

    if (error) {
        console.error('Error fetching questions:', error);
        return;
    }

    console.log(`Scanned ${questions.length} questions.`);

    const suspects: any[] = [];
    const regex = /\$[^$]*\/[^$]*\$/g; // Simple regex: looks for / inside $...$

    for (const q of questions) {
        let found = false;
        const matches: string[] = [];

        // Check Prompt
        if (q.prompt && regex.test(q.prompt)) {
            found = true;
            matches.push('PROMPT: ' + q.prompt.match(regex)?.join(', '));
        }

        // Check Explanation
        if (q.explanation && regex.test(q.explanation)) {
            found = true;
            matches.push('EXPLANATION: ' + q.explanation.match(regex)?.join(', '));
        }

        // Check Options
        if (Array.isArray(q.options)) {
            q.options.forEach((opt: any) => {
                const val = opt.value || opt.text || '';
                if (regex.test(val)) {
                    found = true;
                    matches.push(`OPTION: ${val.match(regex)?.join(', ')}`);
                }
                if (opt.explanation && regex.test(opt.explanation)) {
                    found = true;
                    matches.push(`OPT_EXPL: ${opt.explanation.match(regex)?.join(', ')}`);
                }
            });
        }

        if (found) {
            suspects.push({
                id: q.id,
                matches
            });
        }
    }

    console.log(`Found ${suspects.length} questions with horizontal fractions.`);
    fs.writeFileSync('fraction_suspects.json', JSON.stringify(suspects, null, 2));
    console.log('Report saved to fraction_suspects.json');
}

scanForFractions();
