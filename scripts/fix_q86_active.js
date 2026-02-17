
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function fixQuestion86() {
    console.log('Fixing Question 86...');

    // Corrected data with proper LaTeX delimiters
    const prompt = 'Let $f(x)=|x-2|$. Which statement best describes $f$ at $x=2$?';
    const explanation = 'The graph of $f(x)=|x-2|$ has a sharp corner (cusp) at $x=2$. The function is continuous everywhere, but the one-sided derivatives differ at $x=2$: the left derivative is $-1$ and the right derivative is $1$. Since these are not equal, $f\'(2)$ does not exist.';
    const options = [
        { "id": "A", "text": "Discontinuous at $x=2$.", "value": "Discontinuous at $x=2$.", "explanation": "The absolute value function is continuous everywhere; there is no break or hole at $x=2$." },
        { "id": "B", "text": "Continuous and differentiable at $x=2$.", "value": "Continuous and differentiable at $x=2$.", "explanation": "There is a sharp corner at $x=2$, so the derivative does not exist there." },
        { "id": "C", "text": "Continuous but not differentiable at $x=2$.", "value": "Continuous but not differentiable at $x=2$.", "explanation": "Correct. The left limit of the derivative is $-1$ and the right limit is $1$. Since they differ, $f$ is not differentiable at $x=2$." },
        { "id": "D", "text": "Differentiable but not continuous at $x=2$.", "value": "Differentiable but not continuous at $x=2$.", "explanation": "Impossible: differentiability implies continuity." }
    ];

    const { data, error } = await supabase
        .from('questions')
        .update({ prompt, explanation, options })
        .eq('id', '1d9802c3-0bb0-4ee2-b28b-e4c3f9d62d74')
        .select();

    if (error) {
        console.error('Error updating question:', error);
    } else {
        console.log('Successfully updated question 86:', JSON.stringify(data, null, 2));
    }
}

fixQuestion86();
