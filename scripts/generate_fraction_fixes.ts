
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL || 'https://xzpjlnkirboevkjzitcx.supabase.co';
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase URL or Key');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

interface Suspect {
    id: string;
    matches: string[];
}

const suspects: Suspect[] = JSON.parse(fs.readFileSync('fraction_suspects.json', 'utf8'));
const suspectIds = suspects.map(s => s.id);

function cleanLaTeX(text: string): string {
    if (!text) return text;
    let newText = text;

    // Helper to replace only if not already part of a command
    // We iterate through parts of the string that are math mode `$...$`

    return newText.replace(/\$([^$]+)\$/g, (match, mathContent) => {
        let converted = mathContent;

        // 1. Calculus terms: dy/dx, etc.
        converted = converted.replace(/([d\u2202][a-zA-Z0-9\\]+)\/([d\u2202][a-zA-Z0-9\\]+)/g, '\\frac{$1}{$2}');

        // 2. Complex grouping: (a+b)/(c+d) -> \frac{a+b}{c+d}
        converted = converted.replace(/\(([^)]+)\)\/\(([^)]+)\)/g, '\\frac{$1}{$2}');

        // 3. Mixed grouping: (a+b)/c -> \frac{a+b}{c}
        converted = converted.replace(/\(([^)]+)\)\/([a-zA-Z0-9\\]+)/g, '\\frac{$1}{$2}');

        // 4. Mixed grouping: a/(b+c) -> \frac{a}{b+c}
        converted = converted.replace(/([a-zA-Z0-9\\]+)\/\(([^)]+)\)/g, '\\frac{$1}{$2}');

        // 5. Simple fractions: 1/2, x/y, \pi/4
        // We capture: (negative sign optional)(number or command or char) / (number or command or char)
        // regex: (-?\\?[\w]+)\/(-?\\?[\w]+)
        // Note: this captures \pi but also \frac if we aren't careful. 
        // We exclude \frac by ensuring the slash isn't preceded by }? No, \frac{}{} doesn't have slash.
        // We exclude if it matches units?

        converted = converted.replace(/(-?\\?[\w\^]+)\/(-?\\?[\w\^]+)/g, (m, num, den) => {
            // Check for units
            const units = ['m', 's', 'ft', 'min', 'hr', 'kg', 'g', 'lb', 'in', 'cm', 'L', 'mol'];
            const cleanNum = num.replace(/\\/g, '');
            const cleanDen = den.replace(/\\/g, '');

            // Identify if it looks like a unit (e.g. m/s) and avoid frac if so? 
            // Actually, usually units in math mode like $3 m/s$ should remain $3 m/s$ or $3 \text{m/s}$.
            // If we have $1/2$, we want \frac{1}{2}.

            if (units.includes(cleanNum) && units.includes(cleanDen)) {
                return m; // Keep as m/s
            }
            if (cleanNum === 'text' || cleanDen === 'text') return m; // Avoid \text{...}

            return `\\frac{${num}}{${den}}`;
        });

        return `$${converted}$`;
    });
}

async function generateFixes() {
    console.log(`Fetching details for ${suspectIds.length} questions...`);

    const { data: questions, error } = await supabase
        .from('questions')
        .select('*')
        .in('id', suspectIds);

    if (error) {
        console.error(error);
        return;
    }

    let sql = `-- Fix Horizontal Fractions for ${questions.length} Questions\n`;

    let fixedCount = 0;

    for (const q of questions) {
        let changed = false;

        const originalPrompt = q.prompt;
        const fixedPrompt = cleanLaTeX(originalPrompt);
        if (fixedPrompt !== originalPrompt) changed = true;

        const originalExplanation = q.explanation;
        const fixedExplanation = cleanLaTeX(originalExplanation);
        if (fixedExplanation !== originalExplanation) changed = true;

        // Options (JSONB)
        // We'll regenerate the whole options array string
        let fixedOptions = q.options;
        if (Array.isArray(q.options)) {
            fixedOptions = q.options.map((opt: any) => {
                const newVal = cleanLaTeX(opt.value || opt.text || '');
                const newExpl = cleanLaTeX(opt.explanation || '');
                if (newVal !== (opt.value || opt.text)) changed = true;
                if (newExpl !== opt.explanation) changed = true;

                return {
                    ...opt,
                    value: newVal, // Ensure we use 'value' key as per schema preference
                    explanation: newExpl
                };
            });
        }

        if (changed) {
            // Escape single quotes for SQL
            const safePrompt = fixedPrompt.replace(/'/g, "''");
            const safeExplanation = fixedExplanation ? fixedExplanation.replace(/'/g, "''") : '';
            const safeOptions = JSON.stringify(fixedOptions).replace(/'/g, "''");

            sql += `
UPDATE public.questions
SET prompt = '${safePrompt}',
    explanation = '${safeExplanation}',
    options = '${safeOptions}'::jsonb
WHERE id = '${q.id}';
`;
            fixedCount++;
        }
    }

    fs.writeFileSync('database/fix_fractions.sql', sql);
    console.log(`Generated SQL for ${fixedCount} questions in database/fix_fractions.sql`);
}

generateFixes();
