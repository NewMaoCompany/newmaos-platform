
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function fixQuestions() {
    console.log('Starting batch fix for 10 corrupted questions...');

    const updates = [
        // 1. Q186
        {
            id: '408AED1B-0BF7-4B20-9168-CE3048175967',
            prompt: 'Let $h(x)=\\begin{cases} x\\sin\\left(\\frac{1}{x}\\right) & x\\ne 0 \\\\ 0 & x=0 \\end{cases}$. Which statement is true about $h$ at $x=0$?',
            explanation: 'Continuity: $|x \\sin(\\frac{1}{x})| \\le |x| \\to 0$, so $\\lim_{x\\to 0} h(x) = 0 = h(0)$. Differentiability: $h\'(0)=\\lim_{t\\to 0} \\sin(1/t)$ which does not exist. Hence continuous but not differentiable at $x=0$.',
            options: [
                { "id": "A", "text": "Not continuous at $x=0$", "explanation": "Because $|x \\sin(\\frac{1}{x})| \\le |x|$, the limit as $x\\to 0$ is $0$, so it is continuous." },
                { "id": "B", "text": "Continuous at $x=0$ but not differentiable at $x=0$", "explanation": "Correct: continuity holds by squeeze, but $h'(0)=\\lim_{t\\to 0}\\sin(1/t)$ does not exist." },
                { "id": "C", "text": "Differentiable at $x=0$ but not continuous at $x=0$", "explanation": "Differentiability implies continuity, so this cannot happen." },
                { "id": "D", "text": "Continuous and differentiable at $x=0$", "explanation": "Differentiability fails because the derivative limit oscillates and does not converge." }
            ]
        },
        // 2. Q225
        {
            id: '4CF08AAD-480A-4EE7-8AD3-AA81DA9665A5',
            prompt: 'Use the graph (see image) to best estimate $f\'(2)$. The point $(2, f(2))$ is marked on the curve.',
            explanation: 'The derivative at a point is the slope of the tangent line. From the graph near $x=2$, the rise over run over a small interval (e.g., from $x=1.5$ to $x=2.5$) suggests an average slope close to $2$.',
            options: [
                { "id": "A", "text": "About $0.2$", "explanation": "Near $x=2$, the curve is increasing with a moderate slope, a little above 1; the best estimate is about 2." },
                { "id": "B", "text": "About $2$", "explanation": "This is far too small; the tangent at $x=2$ is noticeably steeper than $0.2$." },
                { "id": "C", "text": "About $1.2$", "explanation": "The function is increasing at $x=2$, so the derivative should be positive, not negative." },
                { "id": "D", "text": "About $6$", "explanation": "This overestimates the steepness; the tangent is not that steep at $x=2$." }
            ]
        },
        // 3. Q239
        {
            id: '512E4EF2-CFB6-48AC-91DA-FAE6D237EA84',
            prompt: 'A function $f$ satisfies $f(3) = 10$, $f(3.1)=10.4$, and $f(2.9) = 9.7$. Using a symmetric difference quotient, estimate $f\'(3)$.',
            explanation: 'Use the symmetric difference quotient: $f\'(3) \\approx \\frac{f(3+h)-f(3-h)}{2h}$. Here $h=0.1$, so $f\'(3) \\approx \\frac{f(3.1)-f(2.9)}{0.2} = \\frac{10.4-9.7}{0.2} = \\frac{0.7}{0.2} = 3.5$.',
            options: [
                { "id": "A", "text": "$4.0$", "explanation": "This would correspond to a symmetric change of $0.8$ over $0.2$, but the actual symmetric change is $10.4-9.7=0.7$." },
                { "id": "B", "text": "$3.5$", "explanation": "Correct: $(10.4-9.7)/0.2 = 0.7/0.2 = 3.5$." },
                { "id": "C", "text": "$7.0$", "explanation": "This mistakenly divides by $0.1$ instead of the full symmetric width $0.2$." },
                { "id": "D", "text": "$3.0$", "explanation": "This mistakenly divides by $h$ again after already using the full symmetric interval." }
            ]
        },
        // 4. Q323
        {
            id: '6C619343-3297-49F3-AE60-2E872BBBF542',
            prompt: 'An object\'s acceleration is constant at $a(t)=-3 \\text{ m/s}^2$, and its velocity at $t=0$ is $v(0)=12 \\text{ m/s}$. When does it first come to rest?',
            explanation: 'With constant acceleration, velocity is $v(t)=v(0)+at=12-3t$. Set $v(t)=0$: $12-3t=0 \\Rightarrow t=4 \\text{ s}$.',
            options: [
                { "id": "A", "text": "$t=3$ s", "explanation": "Would give $v(3)=12-9=3 \\ne 0$." },
                { "id": "B", "text": "$t=4$ s", "explanation": "Correct: $v(t)=12-3t$ hits 0 at $t=4$." },
                { "id": "C", "text": "$t=6$ s", "explanation": "Would correspond to a different constant acceleration." },
                { "id": "D", "text": "$t=12$ s", "explanation": "Confuses initial velocity value with time to stop." }
            ]
        },
        // 5. Q394
        {
            id: '878D6F75-6746-419A-9DFD-5A10FAE3966F',
            prompt: 'A function $f$ has the graph shown (see image), with $f(0) = 1$. Which statement is true about $f$ at $x=0$?',
            explanation: 'From the graph, the two pieces meet at $x=0$, so $\\lim_{x\\to 0} f(x) = f(0)$ and $f$ is continuous. The one-sided slopes at $x=0$ do not match, so $f$ is not differentiable at $x=0$.',
            options: [
                { "id": "A", "text": "$f$ is differentiable at $x=0$", "explanation": "The graph has a corner at $x=0$, so it is not differentiable." },
                { "id": "B", "text": "$f$ is continuous but not differentiable at $x=0$", "explanation": "Correct: Both pieces meet at $x=0$ (continuous), but the left and right slopes differ (not differentiable)." },
                { "id": "C", "text": "$f$ is not continuous at $x=0$ but is differentiable at $x=0$", "explanation": "Differentiability implies continuity, so this cannot happen." },
                { "id": "D", "text": "$f$ is neither continuous nor differentiable at $x=0$", "explanation": "The pieces meet at $x=0$, so $f$ is continuous at $x=0$." }
            ]
        },
        // 6. Q398
        {
            id: '8819D62B-11AE-4131-9A73-F9060B516421',
            prompt: 'Which statement is always true for a function $f$ at $x=a$? I. If $f$ is differentiable at $x=a$, then $f$ is continuous at $x=a$. II. If $f$ is continuous at $x=a$, then $f$ is differentiable at $x=a$.',
            explanation: 'Differentiability at $x=a$ forces $\\lim_{x\\to 0}f(x)=f(a)$, so $f$ must be continuous at $x=a$. But continuity can occur without differentiability (e.g., corners).',
            options: [
                { "id": "A", "text": "I only", "explanation": "Correct. Differentiability implies continuity." },
                { "id": "B", "text": "II only", "explanation": "Continuity does not imply differentiability, so II is not always true." },
                { "id": "C", "text": "Both I and II", "explanation": "II fails for functions like $|x|$ at $x=0$." },
                { "id": "D", "text": "Neither I nor II", "explanation": "I is true, so this cannot be correct." }
            ]
        },
        // 7. Q482
        {
            id: 'A42F296D-1BA8-4E0B-A145-62988C59870C',
            prompt: 'Find the value of $k$ that makes $f$ continuous at $x=3$ if $f(x) = \\begin{cases} \\frac{x^2-9}{x-3}, & x \\ne 3 \\\\ k, & x=3 \\end{cases}$',
            explanation: 'For $x \\ne 3$, factor $x^2-9 = (x-3)(x+3)$, so $f(x) = x+3$. Thus $\\lim_{x\\to 3} f(x) = 6$. Continuity at $x=3$ requires $f(3)=k$ to equal this limit, so $k=6$.',
            options: [
                { "id": "A", "text": "$k=0$", "explanation": "This equals $\\lim_{x\\to 3}(x^2-9)$ if you forget to simplify the fraction first." },
                { "id": "B", "text": "$k=9$", "explanation": "This confuses the limit with $x^2$ evaluated at 3." },
                { "id": "C", "text": "$k$ cannot be chosen to make $f$ continuous at $x=3$", "explanation": "The discontinuity is removable; choosing $k$ equal to the limit makes $f$ continuous." },
                { "id": "D", "text": "$k=6$", "explanation": "Correct: for $x \\ne 3$, $\\frac{x^2-9}{x-3} = x+3$, so $\\lim_{x\\to 3} f(x) = 6$; set $k=6$." }
            ]
        },
        // 8. Q540
        {
            id: 'B508B1F0-B367-48A5-BAE0-60E817F1BD36',
            prompt: 'Consider the logistic differential equation $\\frac{dP}{dt} = P(6-P)$. Which statement about equilibrium solutions is correct?',
            explanation: 'Equilibrium solutions satisfy $\\frac{dP}{dt} = 0$. $P(6-P)=0 \\implies P=0$ or $P=6$.',
            options: [
                { "id": "A", "text": "The only equilibrium solution is $P=0$.", "explanation": "Set dP/dt = 0: both factors can be zero, giving P=0 and P=6." },
                { "id": "B", "text": "The only equilibrium solution is $P=6$.", "explanation": "There are two equilibria: P=0 and P=6." },
                { "id": "C", "text": "The equilibrium solutions are $P=0$ and $P=6$.", "explanation": "Correct: equilibria occur when $P(6-P)=0$, i.e., $P=0$ or $P=6$." },
                { "id": "D", "text": "There are no equilibrium solutions because $dP/dt$ depends on $P$.", "explanation": "Equilibria are constant solutions where $dP/dt = 0$ for that constant value of $P$." }
            ]
        },
        // 9. Q575
        {
            id: 'C47718C9-0FCE-43D6-B659-10083653AE99',
            prompt: 'Refer to the position graph. What is the cart\'s velocity at $t = 6$ seconds?',
            explanation: 'Velocity is the slope of the position graph. At $t=6$, the cart lies on the segment from $(5, 6)$ to $(7, 2)$, so $m = \\frac{2-6}{7-5} = -2$ m/s.',
            options: [
                { "id": "A", "text": "$-2$ m/s", "explanation": "Correct: slope on the segment from $(5, 6)$ to $(7, 2)$ is $\\frac{2-6}{7-5} = -2$." },
                { "id": "B", "text": "$2$ m/s", "explanation": "Correct magnitude but wrong sign." },
                { "id": "C", "text": "$-4$ m/s", "explanation": "Uses rise $-4$ but forgets to divide by run 2." },
                { "id": "D", "text": "$0$ m/s", "explanation": "Confuses the flat segment (earlier) with the segment containing $t=6$." }
            ]
        },
        // 10. Q596
        {
            id: 'CA6B2EDA-8919-4BFF-9DA7-84BDB3322CB2',
            prompt: 'Let $g(x)=\\sqrt{x}$. Which expression best estimates $g\'(9)$ using $h=0.01$?',
            explanation: 'A standard estimate uses $g\'(a)\\approx \\frac{g(a+h)-g(a)}{h}$. With $a=9$ and $h=0.01$, the correct setup is $\\frac{\\sqrt{9.01}-\\sqrt{9}}{0.01}$.',
            options: [
                { "id": "A", "text": "$\\frac{\\sqrt{9.01}-\\sqrt{9}}{0.01}$", "explanation": "Correct forward-difference quotient with h=0.01." },
                { "id": "B", "text": "$\\frac{\\sqrt{9}-\\sqrt{8.99}}{0.01}$", "explanation": "This is a backward difference, not the stated forward form." },
                { "id": "C", "text": "$\\frac{\\sqrt{9.01}-\\sqrt{8.99}}{0.01}$", "explanation": "If using symmetric points, you must divide by $2h = 0.02$, not 0.01." },
                { "id": "D", "text": "$\\frac{\\sqrt{9.01}-\\sqrt{9}}{9.01-9}$", "explanation": "This is equivalent to option A since 9.01-9=0.01." }
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
