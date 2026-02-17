
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

async function fixQuestion103() {
    console.log('Fixing Question 103...');

    const prompt = 'A graph (see image) shows $y=f(x)$ and a symmetric secant line through the points at $x=1.0$ and $x=2.0$. Which value is the best estimate of $f\'(1.5)$ using this symmetric secant?';

    const explanation = 'A symmetric secant about $x=a$ uses points $a-h$ and $a+h$: $$f\'(a) \\approx \\frac{f(a+h)-f(a-h)}{2h}$$ Here $a=1.5$ and the points are $1.0$ and $2.0$ (so $h=0.5$). Thus, $$f\'(1.5) \\approx \\frac{f(2.0)-f(1.0)}{2.0-1.0} = \\frac{f(2.0)-f(1.0)}{1.0}$$';

    const options = [
        {
            "id": "A",
            "text": "The slope of the secant from $x=1.0$ to $x=1.5$ only",
            "value": "The slope of the secant from $x=1.0$ to $x=1.5$ only",
            "explanation": "This is one-sided, not symmetric about $x=1.5$."
        },
        {
            "id": "B",
            "text": "\\frac{f(2.0) - f(1.0)}{2.0 - 1.0}",
            "value": "\\frac{f(2.0) - f(1.0)}{2.0 - 1.0}",
            "explanation": "Correct: this is the symmetric secant slope and estimates the tangent slope at the midpoint."
        },
        {
            "id": "C",
            "text": "\\frac{f(2.0) - f(1.5)}{2.0 - 1.5}",
            "value": "\\frac{f(2.0) - f(1.5)}{2.0 - 1.5}",
            "explanation": "Uses only the right half-interval, not symmetric."
        },
        {
            "id": "D",
            "text": "\\frac{f(1.5) - f(1.0)}{2.0 - 1.0}",
            "value": "\\frac{f(1.5) - f(1.0)}{2.0 - 1.0}",
            "explanation": "Mismatches a half-interval numerator with a full-interval denominator."
        }
    ];

    const { data, error } = await supabase
        .from('questions')
        .update({ prompt, explanation, options })
        .eq('id', '22333f09-d3e6-4f04-b4ba-a6781c1cb98c')
        .select();

    if (error) {
        console.error('Error updating question:', error);
    } else {
        console.log('Successfully updated question 103:', JSON.stringify(data, null, 2));
    }
}

fixQuestion103();
