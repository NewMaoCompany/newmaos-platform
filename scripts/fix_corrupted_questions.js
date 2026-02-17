
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

async function fixQuestions() {
    console.log('Starting batch fix for corrupted questions...');

    const updates = [
        {
            id: '408AED1B-0BF7-4B20-9168-CE3048175967', // Q186
            prompt: 'Let $h(x)=\\begin{cases} x\\sin\\left(\\frac{1}{x}\\right) & x\\ne 0 \\\\ 0 & x=0 \\end{cases}$. Which statement is true about $h$ at $x=0$?',
            explanation: 'Continuity: $|x \\sin(\\frac{1}{x})| \\le |x| \\to 0$, so $\\lim_{x\\to 0} h(x) = 0 = h(0)$. Differentiability: $h\'(0)=\\lim_{t\\to 0} \\sin(1/t)$ which does not exist. Hence continuous but not differentiable at $x=0$.',
            options: [
                { "id": "A", "text": "Not continuous at $x=0$", "explanation": "Because $|x \\sin(\\frac{1}{x})| \\le |x|$, the limit as $x\\to 0$ is $0$, so it is continuous." },
                { "id": "B", "text": "Continuous at $x=0$ but not differentiable at $x=0$", "explanation": "Correct: continuity holds by squeeze, but $h'(0)=\\lim_{t\\to 0}\\sin(1/t)$ does not exist." },
                { "id": "C", "text": "Differentiable at $x=0$ but not continuous at $x=0$", "explanation": "Differentiability implies continuity, so this cannot happen." },
                { "id": "D", "text": "Continuous and differentiable at $x=0$", "explanation": "Differentiability fails because the derivative limit oscillates and does not converge." }
            ]
        },
        {
            id: '4CF08AAD-480A-4EE7-8AD3-AA81DA9665A5', // Q225
            prompt: 'Use the graph (see image) to best estimate $f\'(2)$. The point $(2, f(2))$ is marked on the curve.',
            explanation: 'The derivative at a point is the slope of the tangent line. From the graph near $x=2$, the rise over run over a small interval (e.g., from $x=1.5$ to $x=2.5$) suggests an average slope close to $2$.',
            options: [
                { "id": "A", "text": "About $0.2$", "explanation": "Near $x=2$, the curve is increasing with a moderate slope, a little above 1; the best estimate is about 2." },
                { "id": "B", "text": "About $2$", "explanation": "This is far too small; the tangent at $x=2$ is noticeably steeper than $0.2$." },
                { "id": "C", "text": "About $1.2$", "explanation": "The function is increasing at $x=2$, so the derivative should be positive, not negative." },
                { "id": "D", "text": "About $6$", "explanation": "This overestimates the steepness; the tangent is not that steep at $x=2$." }
            ]
        },
        {
            id: '512E4EF2-CFB6-48AC-91DA-FAE6D237EA84', // Q239
            prompt: 'A function $f$ satisfies $f(3) = 10$, $f(3.1)=10.4$, and $f(2.9) = 9.7$. Using a symmetric difference quotient, estimate $f\'(3)$.',
            explanation: 'Use the symmetric difference quotient: $f\'(3) \\approx \\frac{f(3+h)-f(3-h)}{2h}$. Here $h=0.1$, so $f\'(3) \\approx \\frac{f(3.1)-f(2.9)}{0.2} = \\frac{10.4-9.7}{0.2} = \\frac{0.7}{0.2} = 3.5$.',
            options: [
                { "id": "A", "text": "$4.0$", "explanation": "This would correspond to a symmetric change of $0.8$ over $0.2$, but the actual symmetric change is $10.4-9.7=0.7$." },
                { "id": "B", "text": "$3.5$", "explanation": "Correct: $(10.4-9.7)/0.2 = 0.7/0.2 = 3.5$." },
                { "id": "C", "text": "$7.0$", "explanation": "This mistakenly divides by $0.1$ instead of the full symmetric width $0.2$." },
                { "id": "D", "text": "$3.0$", "explanation": "This mistakenly divides by $h$ again after already using the full symmetric interval." }
            ]
        },
        {
            id: '6C619343-3297-49F3-AE60-2E872BBBF542', // Q323
            prompt: 'An object\'s acceleration is constant at $a(t)=-3 \\text{ m/s}^2$, and its velocity at $t=0$ is $v(0)=12 \\text{ m/s}$. When does it first come to rest?',
            explanation: 'With constant acceleration, velocity is $v(t)=v(0)+at=12-3t$. Set $v(t)=0$: $12-3t=0 \\Rightarrow t=4 \\text{ s}$.',
            options: [
                { "id": "A", "text": "$t=3$ s", "explanation": "Would give $v(3)=12-9=3 \\ne 0$." },
                { "id": "B", "text": "$t=4$ s", "explanation": "Correct: $v(t)=12-3t$ hits 0 at $t=4$." },
                { "id": "C", "text": "$t=6$ s", "explanation": "Would correspond to a different constant acceleration." },
                { "id": "D", "text": "$t=12$ s", "explanation": "Confuses initial velocity value with time to stop." }
            ]
        },
        {
            id: '878D6F75-6746-419A-9DFD-5A10FAE3966F', // Q394
            prompt: 'A function $f$ has the graph shown (see image), with $f(0) = 1$. Which statement is true about $f$ at $x=0$?',
            explanation: 'From the graph, the two pieces meet at $x=0$, so $\\lim_{x\\to 0} f(x) = f(0)$ and $f$ is continuous. The one-sided slopes at $x=0$ do not match, so $f$ is not differentiable at $x=0$.',
            options: [
                { "id": "A", "text": "$f$ is differentiable at $x=0$", "explanation": "The graph has a corner at $x=0$, so it is not differentiable." },
                { "id": "B", "text": "$f$ is continuous but not differentiable at $x=0$", "explanation": "Correct: Both pieces meet at $x=0$ (continuous), but the left and right slopes differ (not differentiable)." },
                { "id": "C", "text": "$f$ is not continuous at $x=0$ but is differentiable at $x=0$", "explanation": "Differentiability implies continuity, so this cannot happen." },
                { "id": "D", "text": "$f$ is neither continuous nor differentiable at $x=0$", "explanation": "The pieces meet at $x=0$, so $f$ is continuous at $x=0$." }
            ]
        }
    ];

    for (const q of updates) {
        const { id, prompt, explanation, options } = q;
        console.log(`Updating Question ${id}...`);
        const { error } = await supabase
            .from('questions')
            .update({ prompt, explanation, options })
            .eq('id', id);

        if (error) {
            console.error(`Error updating ${id}:`, error);
        } else {
            console.log(`Success: ${id}`);
        }
    }
}

fixQuestions();
