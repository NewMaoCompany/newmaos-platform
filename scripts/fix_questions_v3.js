
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function fixQuestionsV3() {
    console.log('Starting Batch Fix V3 (3 Persistent Questions)...');

    // Use DOUBLE ESCAPED backslashes for text to ensure they survive DB storage
    // We want the DB to store: ... x \ne 1 \\ 3 ...
    // So in JS string we might need: ... x \\ne 1 \\\\ 3 ... 

    // Note: In previous attempts, "x^2-1, & x\\ne 1 \\\\ 3" resulted in "x \ne 1 \ 3" (single backslash).
    // This implies that one level of escaping was consumed.
    // So we will try 4 backslashes in the JS string for the newline, which usually means 8 if we wants literal...
    // Wait. In JS: '\\\\' = 2 backslashes. If we send '\\\\' to Supabase, it sends 2 backslashes.
    // If Supabase/Postgres is treating it as an escape, it might turn 2 into 1.
    // So let's try sending 4 backslashes: '\\\\\\\\' (8 in code source, 4 in string).

    // Actually, let's look at the "good" questions. e.g. Q103.
    // Q103 fix had: "prompt = '... x=1.0$ and $x=2.0$ ...'"
    // It didn't have piecewise.

    // Let's try to be very explicit with the cases environment.
    // We want: \begin{cases} ... \\ ... \end{cases}
    // JS String: "\\begin{cases} ... \\\\ ... \\end{cases}" -> Sends \begin... \\ ... \end...
    // If that resulted in single \, then we need "\\\\\\\\" in JS string -> \\\\ sent -> \\ stored?

    const updates = [
        // 1. Q703 (EDE9CE0C)
        {
            id: 'ede9ce0c-1d22-49d6-a995-208f49ef89c3',
            prompt: 'Let $f(x)=\\begin{cases} x^2-1, & x \\ne 1 \\\\\\\\ 3, & x=1 \\end{cases}$. Which statement is true about continuity at $x=1$?',
            explanation: '$\\lim_{x\\to 1} (x^2-1) = 0$. But $f(1)=3$. Since limit (0) $\\ne$ value (3), $f$ is not continuous at $x=1$.',
            options: [
                { "id": "A", "text": "Continuous because limits exist", "explanation": "Limit exists (0) but does not equal function value (3)." },
                { "id": "B", "text": "Not continuous because limit does not exist", "explanation": "Limit exists and is 0." },
                { "id": "C", "text": "Not continuous because $f(1)$ is undefined", "explanation": "$f(1)=3$ is defined." },
                { "id": "D", "text": "Not continuous because $\\lim_{x\\to 1}f(x) \\ne f(1)$", "explanation": "Correct: $0 \\ne 3$." }
            ]
        },
        // 2. Q717 (F1BBD9AF)
        {
            id: 'f1bbd9af-c033-45d5-82bc-b45fff0e4248',
            prompt: 'Choose $a$ so that $f(x)=\\begin{cases} ax+1, & x<1 \\\\\\\\ x^2, & x\\ge 1 \\end{cases}$ is continuous at $x=1$. What is $a$?',
            explanation: 'Left limit: $\\lim_{x\\to 1^-}(ax+1) = a+1$. Right limit/value: $\\lim_{x\\to 1^+}(x^2)=1$. continuity $\\implies a+1=1 \\implies a=0$.',
            options: [
                { "id": "A", "text": "$a=1$", "explanation": "Would give left limit 2, right limit 1." },
                { "id": "B", "text": "$a=0$", "explanation": "Correct: $0(1)+1 = 1$, matches $1^2=1$." },
                { "id": "C", "text": "$a=-1$", "explanation": "Left limit 0, right limit 1." },
                { "id": "D", "text": "No such $a$ exists", "explanation": "We can solve $a+1=1$." }
            ]
        },
        // 3. Q730 (F60E26B6) - NEW
        {
            id: 'f60e26b6-b238-4d1c-9540-5174ebd4f98f',
            prompt: 'Choose $k$ so that $h(x)=\\begin{cases} kx+2, & x\\le 2 \\\\\\\\ x^2-2, & x>2 \\end{cases}$ is continuous for all real $x$. What is $k$?',
            explanation: 'The only possible discontinuity is at the split point $x=2$. Continuity requires $h(2) = \\lim_{x\\to 2^+} (x^2-2)$. Since $h(2) = 2k+2$ and the right-hand value is $2^2-2=2$, set $2k+2=2$, giving $k=0$.',
            options: [
                { "id": "A", "text": "$k=0$", "explanation": "Correct: continuity at $x=2$ requires $2k+2 = 2^2-2=2$, so $k=0$." },
                { "id": "B", "text": "$k=1$", "explanation": "Then $h(2)=4$ while the right-hand limit is 2." },
                { "id": "C", "text": "$k=-1$", "explanation": "Then $h(2)=0$ while the right-hand limit is 2." },
                { "id": "D", "text": "$k=2$", "explanation": "Then $h(2)=6$ while the right-hand limit is 2." }
            ]
        }
    ];

    for (const q of updates) {
        console.log(`Updating Question ${q.id} with strong escapes...`);
        const { error } = await supabase
            .from('questions')
            .update({
                prompt: q.prompt,
                explanation: q.explanation,
                options: q.options
            })
            .eq('id', q.id);

        if (error) {
            console.error(`Error updating ${q.id}:`, error);
        } else {
            console.log(`Success: ${q.id}`);
        }
    }
}

fixQuestionsV3();
