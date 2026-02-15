-- Insert Unit 7 Questions, Skills, and Error Tags
-- Corrected: 
-- 1. `topic` column changed to 'Both_DiffEq' (ID instead of name) to match frontend filter.
-- 2. `type` changed to 'MCQ' (uppercase) to satisfy check constraint.
-- 3. Added `course` ('Both') and `topic_id` ('Both_DiffEq') columns.
-- 4. Used DELETE + INSERT pattern for questions to avoid unique constraint errors on title.
-- 5. Removed `explanation_type` column (does not exist).
-- 6. Corrected Skills schema (id, name, unit) and ErrorTags schema (id, name, unit, category, severity).

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. Ensure Skills Exist (Idempotent Insert)
    INSERT INTO public.skills (id, name, unit) VALUES
        ('model_from_context_rate', 'Model from Context (Rate)', 'Unit7_DiffEq'),
        ('\\interpret_in_context', 'Interpret in Context', 'Unit7_DiffEq'),
        ('identify_initial_condition', 'Identify Initial Condition', 'Unit7_DiffEq'),
        ('evaluate_derivative_at_point', 'Evaluate Derivative at Point', 'Unit7_DiffEq'),
        ('verify_by_substitution', 'Verify by Substitution', 'Unit7_DiffEq'),
        ('implicit_to_explicit', 'Implicit to Explicit', 'Unit7_DiffEq'),
        ('solve_for_constant_using_ic', 'Solve for Constant with IC', 'Unit7_DiffEq'),
        ('slope_field_construct', 'Construct Slope Field', 'Unit7_DiffEq'),
        ('slope_field_solution_curve', 'Slope Field Solution Curve', 'Unit7_DiffEq'),
        ('equilibrium_solutions', 'Equilibrium Solutions', 'Unit7_DiffEq'),
        ('qualitative_behavior', 'Qualitative Behavior', 'Unit7_DiffEq')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. Ensure Error Tags Exist (Idempotent Insert)
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('sign_error_in_rate', 'Sign Error in Rate', 'Interpretation', 3, 'Unit7_DiffEq'),
        ('wrong_dependency_in_model', 'Model Dependency Error', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('units_mismatch_or_ignored', 'Units Mismatch', 'Context', 3, 'Unit7_DiffEq'),
        ('initial_condition_misread', 'Initial Condition Error', 'Procedural', 1, 'Unit7_DiffEq'),
        ('derivative_computation_error', 'Derivative Error', 'Procedural', 5, 'Unit7_DiffEq'),
        ('substitution_error_in_verification', 'Substitution Error', 'Procedural', 3, 'Unit7_DiffEq'),
        ('verification_not_global', 'Global Verification Error', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('constant_solve_error_with_ic', 'Constant Solution Error', 'Algebra', 3, 'Unit7_DiffEq'),
        ('slope_field_axis_mixup', 'Slope Field Axis Mixup', 'Visual', 3, 'Unit7_DiffEq'),
        ('confuse_slope_with_yvalue', '\frac{Slope}{Value} Confusion', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('invert_derivative', 'Inverted Derivative', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('solution_curve_not_tangent', 'Tangency Error', 'Visual', 3, 'Unit7_DiffEq'),
        ('equilibrium_missed', 'Missed Equilibrium', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('wrong_k_interpretation', 'Incorrent Constant Interpretation', 'Interpretation', 3, 'Unit7_DiffEq')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Clean up existing questions (Avoid ON CONFLICT error on title)
    DELETE FROM public.questions WHERE title IN (
        'U7.1-P1', 'U7.1-P2', 'U7.1-P3', 'U7.1-P4', 'U7.1-P5',
        'U7.2-P1', 'U7.2-P2', 'U7.2-P3', 'U7.2-P4', 'U7.2-P5',
        'U7.3-P1', 'U7.3-P2', 'U7.3-P3', 'U7.3-P4', 'U7.3-P5',
        'U7.4-P1', 'U7.4-P2', 'U7.4-P3', 'U7.4-P4', 'U7.4-P5'
    );

    -- 4. Insert Questions with correct TOPIC ('Both_DiffEq') and TYPE ('MCQ')
    -- U7.1-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.1-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.1', '7.1', 2, 'MCQ',
        'A quantity $y(t)$ is decreasing at a rate proportional to its current value. Which differential equation models this situation for some constant $k>0$?', 'text', false,
        'model_from_context_rate', ARRAY['model_from_context_rate', '\\interpret_in_context'], ARRAY['sign_error_in_rate', 'wrong_dependency_in_model'],
        '[
            {"id": "A", "value": "$\\frac{dy}{dt}=ky$", "explanation": "Wrong sign: this gives growth when $y>0$."},
            {"id": "B", "value": "$\\frac{dy}{dt}=-ky$", "explanation": "Correct: proportional to $y$ and negative for decay."},
            {"id": "C", "value": "$\\frac{dy}{dt}=-k$", "explanation": "Constant-rate change is not proportional to $y$."},
            {"id": "D", "value": "$\\frac{dy}{dt}=\\frac{k}{y}$", "explanation": "Inverse dependence is not proportional to $y$."}
        ]'::jsonb, 'B',
        '“Proportional to $y$” gives $\\frac{dy}{dt}=Cy$, and “decreasing” requires $C<0$, so $\\frac{dy}{dt}=-ky$ with $k>0$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.1-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.1-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.1', '7.1', 3, 'MCQ',
        'Use the rate table in file $u7_7_1_rate_table.png$. Which differential equation best matches the data?', 'image', false,
        'model_from_context_rate', ARRAY['model_from_context_rate', '\\interpret_in_context'], ARRAY['wrong_dependency_in_model', 'units_mismatch_or_ignored'],
        '[
            {"id": "A", "value": "$\\frac{dy}{dt}=y$", "explanation": "Too large: if $y=9$, this predicts $\\frac{dy}{dt}=9$, not $3$."},
            {"id": "B", "value": "$\\frac{dy}{dt}=\\sqrt{y}$", "explanation": "Correct: $\\sqrt{4}=2$, $\\sqrt{9}=3$, $\\sqrt{16}=4$."},
            {"id": "C", "value": "$\\frac{dy}{dt}=\\frac{1}{2}y$", "explanation": "If $y=16$, this predicts $8$, not $4$."},
            {"id": "D", "value": "$\\frac{dy}{dt}=\\frac{1}{\\sqrt{y}}$", "explanation": "If $y=4$, this predicts $\\frac{1}{2}$, not $2$."}
        ]'::jsonb, 'B',
        'From the table, when $y=4,9,16$, the rates are $2,3,4$, which match $\\sqrt{y}$ exactly.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_1_rate_table.png'
    );

    -- U7.1-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.1-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.1', '7.1', 2, 'MCQ',
        'A \\tank contains $30$ gallons of water at time $t=0$ minutes. Which is the correct initial condition?', 'text', false,
        'identify_initial_condition', ARRAY['identify_initial_condition', '\\interpret_in_context'], ARRAY['initial_condition_misread', 'units_mismatch_or_ignored'],
        '[
            {"id": "A", "value": "$y(30)=0$", "explanation": "Swaps the input and output values."},
            {"id": "B", "value": "$y(0)=30$", "explanation": "Correct: at $t=0$, the amount is $30$."},
            {"id": "C", "value": "$y(30)=30$", "explanation": "Uses $t=30$ instead of $t=0$."},
            {"id": "D", "value": "$y''(0)=30$", "explanation": "This gives a starting rate, not the starting amount."}
        ]'::jsonb, 'B',
        'An initial condition gives the starting value of the function: $y(0)=30$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.1-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.1-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.1', '7.1', 3, 'MCQ',
        'A population $y(t)$ satisfies $\\frac{dy}{dt}=-0.2y$. If $y(5)=100$, what is $\\frac{dy}{dt}$ at $t=5$?', 'text', false,
        'evaluate_derivative_at_point', ARRAY['evaluate_derivative_at_point', '\\interpret_in_context'], ARRAY['sign_error_in_rate', 'units_mismatch_or_ignored'],
        '[
            {"id": "A", "value": "$-20$", "explanation": "Correct: multiply $-0.2$ by $100$."},
            {"id": "B", "value": "$-0.2$", "explanation": "This is the coefficient, not the derivative value."},
            {"id": "C", "value": "$20$", "explanation": "Wrong sign: the model is decreasing."},
            {"id": "D", "value": "$0.2$", "explanation": "Wrong: uses the coefficient and wrong sign."}
        ]'::jsonb, 'A',
        'Substitute $y=100$ \\into $\\frac{dy}{dt}=-0.2y$: $\\frac{dy}{dt}=-0.2(100)=-20$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.1-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.1-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.1', '7.1', 3, 'MCQ',
        'A model is $\\frac{dP}{dt}=0.3P$, where $P$ is measured in thousands of people and $t$ is measured in days. What are the units of $0.3$?', 'text', false,
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'model_from_context_rate'], ARRAY['units_mismatch_or_ignored', 'wrong_k_interpretation'],
        '[
            {"id": "A", "value": "thousands of people", "explanation": "That would make the right side have units “thousands$^2$ per day.”"},
            {"id": "B", "value": "days", "explanation": "A time unit alone cannot balance the equation."},
            {"id": "C", "value": "per day", "explanation": "Correct: it must convert thousands to thousands per day."},
            {"id": "D", "value": "thousands of people per day", "explanation": "That would make the right side “thousands$^2$ per day.”"}
        ]'::jsonb, 'C',
        'Since $\\frac{dP}{dt}$ has units “thousands per day” and $P$ has units “thousands,” the constant must have units “per day.”',
        NOW(), NOW(), 'published', 1
    );

    -- U7.2-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.2-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.2', '7.2', 2, 'MCQ',
        'Which function is a solution to $\\frac{dy}{dx}=2x$?', 'text', false,
        'verify_by_substitution', ARRAY['verify_by_substitution', 'evaluate_derivative_at_point'], ARRAY['derivative_computation_error', 'substitution_error_in_verification'],
        '[
            {"id": "A", "value": "$y=x^2+3$", "explanation": "Correct: $\\frac{d}{dx}(x^2+3)=2x$."},
            {"id": "B", "value": "$y=2x+3$", "explanation": "Derivative is $2$, not $2x$."},
            {"id": "C", "value": "$y=\\frac{1}{x^2}$", "explanation": "Derivative is $-\\frac{2}{x^3}$, not $2x$."},
            {"id": "D", "value": "$y=e^{2x}$", "explanation": "Derivative is $2e^{2x}$, not $2x$."}
        ]'::jsonb, 'A',
        'Differentiate: if $y=x^2+3$, then $y''=2x$, which matches the differential equation.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.2-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.2-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.2', '7.2', 3, 'MCQ',
        'Which function satisfies both $\\frac{dy}{dx}=y$ and the initial condition $y(0)=3$?', 'text', false,
        'verify_by_substitution', ARRAY['verify_by_substitution', 'identify_initial_condition'], ARRAY['initial_condition_misread', 'substitution_error_in_verification'],
        '[
            {"id": "A", "value": "$y=3e^{x}$", "explanation": "Correct: matches the DE and the initial value."},
            {"id": "B", "value": "$y=e^{3x}$", "explanation": "Gives $y(0)=1$, not $3$."},
            {"id": "C", "value": "$y=3x$", "explanation": "Has $y''=3$, which is not equal to $y$ for all $x$."},
            {"id": "D", "value": "$y=3e^{-x}$", "explanation": "Has $y''=-3e^{-x}$, which is $-y$, not $y$."}
        ]'::jsonb, 'A',
        'For $y=3e^{x}$, we have $y''=3e^{x}=y$ and $y(0)=3e^{0}=3$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.2-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.2-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.2', '7.2', 4, 'MCQ',
        'Consider the differential equation $\\frac{dy}{dx}=-\\frac{x}{y}$ for $y\\neq 0$. Is the implicit relation $x^2+y^2=25$ a solution on any \\interval where $y\\neq 0$?', 'text', false,
        'verify_by_substitution', ARRAY['verify_by_substitution', 'implicit_to_explicit'], ARRAY['derivative_computation_error', 'verification_not_global'],
        '[
            {"id": "A", "value": "Yes, because differentiating gives $2x+2y\\frac{dy}{dx}=0$, so $\\frac{dy}{dx}=-\\frac{x}{y}$.", "explanation": "Correct: the identity holds for all valid points with $y\\neq 0$."},
            {"id": "B", "value": "Yes, but only at the point $\\\left(0,5\\right)$.", "explanation": "Verification must hold on an interval, not just one point."},
            {"id": "C", "value": "No, because the derivative should be $\\frac{dy}{dx}=\\frac{x}{y}$.", "explanation": "Sign error from solving $2x+2y\\frac{dy}{dx}=0$ incorrectly."},
            {"id": "D", "value": "No, because $x^2+y^2=25$ is not an explicit function.", "explanation": "A solution can be implicit; it still can satisfy the DE."}
        ]'::jsonb, 'A',
        'Implicitly differentiating $x^2+y^2=25$ gives $2x+2y\\frac{dy}{dx}=0$, so $\\frac{dy}{dx}=-\\frac{x}{y}$, matching the DE wherever $y\\neq 0$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.2-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.2-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.2', '7.2', 3, 'MCQ',
        'To verify that a function $y=f(x)$ is a solution to a differential equation on an \\interval, what must be shown?', 'text', false,
        'verify_by_substitution', ARRAY['verify_by_substitution', '\\interpret_in_context'], ARRAY['verification_not_global', 'substitution_error_in_verification'],
        '[
            {"id": "A", "value": "The equation is true at one convenient point.", "explanation": "Checking one point is not enough for a differential equation solution."},
            {"id": "B", "value": "After computing $f''(x)$ and substituting, the equation holds for all $x$ in the \\interval where both sides are defined.", "explanation": "Correct: it must hold for all valid $x$ in the interval."},
            {"id": "C", "value": "The function is increasing everywhere on the \\interval.", "explanation": "Monotonicity is not the definition of a solution."},
            {"id": "D", "value": "The function can be written in explicit form.", "explanation": "Solutions can be implicit; explicit form is not required."}
        ]'::jsonb, 'B',
        'Verification requires an identity: differentiate and substitute so the DE holds for every $x$ in the domain \\interval, not just one point.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.2-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.2-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.2', '7.2', 4, 'MCQ',
        'A family of solutions to $\\frac{dy}{dx}=2xy$ is $y=Ce^{x^2}$. Which value of $C$ makes the solution satisfy $y(1)=e^3$?', 'text', false,
        'solve_for_constant_using_ic', ARRAY['solve_for_constant_using_ic', 'verify_by_substitution'], ARRAY['constant_solve_error_with_ic', 'initial_condition_misread'],
        '[
            {"id": "A", "value": "$C=e^2$", "explanation": "Correct: $Ce=e^3$ gives $C=e^2$."},
            {"id": "B", "value": "$C=e^3$", "explanation": "Would make $y(1)=e^4$, not $e^3$."},
            {"id": "C", "value": "$C=e$", "explanation": "Would make $y(1)=e^2$, not $e^3$."},
            {"id": "D", "value": "$C=1$", "explanation": "Would make $y(1)=e$, not $e^3$."}
        ]'::jsonb, 'A',
        'Substitute $x=1$ \\into $y=Ce^{x^2}$: $e^3=Ce^{1}$, so $C=\\frac{e^3}{e}=e^2$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.3-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.3-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.3', '7.3', 2, 'MCQ',
        'For the differential equation $\\frac{dy}{dx}=x-y$, what is the slope at the point $\\left(2,1\\right)$?', 'text', false,
        'slope_field_construct', ARRAY['slope_field_construct', 'evaluate_derivative_at_point'], ARRAY['slope_field_axis_mixup', 'confuse_slope_with_yvalue'],
        '[
            {"id": "A", "value": "$-1$", "explanation": "This is $1-2$, which swaps $x$ and $y$."},
            {"id": "B", "value": "$0$", "explanation": "Slope is $0$ only when $x=y$."},
            {"id": "C", "value": "$1$", "explanation": "Correct: $2-1=1$."},
            {"id": "D", "value": "$3$", "explanation": "Incorrect arithmetic for $2-1$."}
        ]'::jsonb, 'C',
        'Substitute $x=2$ and $y=1$ \\into $x-y$: $2-1=1$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.3-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.3-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.3', '7.3', 3, 'MCQ',
        'Use the slope field in file $u7_7_3_slopefield_A.png$. Along which line do the direction segments appear horizontal (slope $0$) most consistently?', 'image', false,
        'slope_field_construct', ARRAY['slope_field_construct', '\\interpret_in_context'], ARRAY['confuse_slope_with_yvalue', 'invert_derivative'],
        '[
            {"id": "A", "value": "$y=x$", "explanation": "Correct: $x-y=0$ on $y=x$."},
            {"id": "B", "value": "$y=-x$", "explanation": "This would correspond to $x+y=0$, not $x-y=0$."},
            {"id": "C", "value": "$x=0$", "explanation": "Slope is $-y$ on $x=0$, not always $0$."},
            {"id": "D", "value": "$y=0$", "explanation": "Slope is $x$ on $y=0$, not always $0$."}
        ]'::jsonb, 'A',
        'For $\\frac{dy}{dx}=x-y$, slope $0$ occurs when $x-y=0$, i.e., $y=x$. The slope field shows horizontal segments along that diagonal.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_3_slopefield_A.png'
    );

    -- U7.3-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.3-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.3', '7.3', 3, 'MCQ',
        'A slope field for $\\frac{dy}{dx}=f(x,y)$ is made by drawing short line segments. At the point $\\left(x_0,y_0\\right)$, what should the slope of the segment be?', 'text', false,
        'slope_field_construct', ARRAY['slope_field_construct', 'evaluate_derivative_at_point'], ARRAY['slope_field_axis_mixup', 'invert_derivative'],
        '[
            {"id": "A", "value": "$f\\\!\\\left(y_0,x_0\\right)$", "explanation": "Swaps inputs; slope uses $x$ then $y$."},
            {"id": "B", "value": "$\\frac{1}{f\\\!\\\left(x_0,y_0\\right)}$", "explanation": "This flips rise/run and is not generally correct."},
            {"id": "C", "value": "$f\\\!\\\left(x_0,y_0\\right)$", "explanation": "Correct: slope equals $f\\!\\left(x_0,y_0\\right)$."},
            {"id": "D", "value": "$y_0$", "explanation": "Slope is not the same as the $y$-value."}
        ]'::jsonb, 'C',
        'By definition, the slope at $\\left(x_0,y_0\\right)$ is $\\frac{dy}{dx}=f\\!\\left(x_0,y_0\\right)$, so the segment should have that slope.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.3-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.3-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.3', '7.3', 4, 'MCQ',
        'Use the slope field in file $u7_7_3_slopefield_A.png$. A solution curve passes through $\\left(0,2\\right)$. Which statement must be true at that point?', 'image', false,
        'slope_field_solution_curve', ARRAY['slope_field_solution_curve', 'identify_initial_condition'], ARRAY['solution_curve_not_tangent', 'initial_condition_misread'],
        '[
            {"id": "A", "value": "The curve’s \\tangent slope equals $f\\\!\\\left(0,2\\right)$.", "explanation": "Correct: solution curves are tangent to the slope field."},
            {"id": "B", "value": "The curve must be horizontal because $x=0$.", "explanation": "Slope depends on $x$ and $y$, not just $x=0$."},
            {"id": "C", "value": "The curve must pass through the origin next.", "explanation": "Nothing in a slope field forces passing through the origin."},
            {"id": "D", "value": "The curve’s $y$-value must equal the slope there.", "explanation": "Slope is $\\frac{dy}{dx}$, not the $y$-value."}
        ]'::jsonb, 'A',
        'A solution curve is \\tangent to the direction segment at every point, so its slope at $\\left(0,2\\right)$ must equal $f\\!\\left(0,2\\right)$.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_3_slopefield_A.png'
    );

    -- U7.3-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.3-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.3', '7.3', 3, 'MCQ',
        'For the autonomous differential equation $\\frac{dy}{dx}=y(1-y)$, which values of $y$ give equilibrium solutions?', 'text', false,
        'equilibrium_solutions', ARRAY['equilibrium_solutions', 'slope_field_construct'], ARRAY['equilibrium_missed', 'confuse_slope_with_yvalue'],
        '[
            {"id": "A", "value": "$y=0$ and $y=1$", "explanation": "Correct: both make the right side $0$."},
            {"id": "B", "value": "$y=-1$ and $y=1$", "explanation": "$y=-1$ gives $(-1)(2)\\neq 0$."},
            {"id": "C", "value": "$y=0$ only", "explanation": "Misses the factor $(1-y)=0$ at $y=1$."},
            {"id": "D", "value": "No equilibria because the equation depends on $y$", "explanation": "Depending on $y$ does not prevent equilibria."}
        ]'::jsonb, 'A',
        'Equilibria occur when $\\frac{dy}{dx}=0$. Solve $y(1-y)=0$ to get $y=0$ or $y=1$.',
        NOW(), NOW(), 'published', 1
    );

    -- U7.4-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.4-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.4', '7.4', 3, 'MCQ',
        'Use the slope field in file $u7_7_4_slopefield_B.png$ for $\\frac{dy}{dx}=y(1-y)$. If a solution starts with $0<y<1$, what happens to $y$ as $x$ increases?', 'image', false,
        'qualitative_behavior', ARRAY['qualitative_behavior', 'equilibrium_solutions'], ARRAY['equilibrium_missed', 'solution_curve_not_tangent'],
        '[
            {"id": "A", "value": "$y$ decreases toward $0$", "explanation": "For $0<y<1$, slopes are positive, not negative."},
            {"id": "B", "value": "$y$ increases toward $1$", "explanation": "Correct: solutions move upward toward $y=1$."},
            {"id": "C", "value": "$y$ stays constant for all $x$", "explanation": "Only equilibria ($y=0$ or $y=1$) are constant solutions."},
            {"id": "D", "value": "$y$ increases without bound", "explanation": "Growth slows near $y=1$ and levels off at the carrying level."}
        ]'::jsonb, 'B',
        'When $0<y<1$, $y(1-y)>0$, so slopes are positive and solutions rise toward the equilibrium $y=1$.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_4_slopefield_B.png'
    );

    -- U7.4-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.4-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.4', '7.4', 4, 'MCQ',
        'Use the slope field in file $u7_7_3_slopefield_A.png$. A solution passes through $\\left(1,3\\right)$. Which description best matches the slope of the solution at that point?', 'image', false,
        'slope_field_solution_curve', ARRAY['slope_field_solution_curve', 'identify_initial_condition', 'evaluate_derivative_at_point'], ARRAY['solution_curve_not_tangent', 'initial_condition_misread'],
        '[
            {"id": "A", "value": "Positive, because $x-y>0$", "explanation": "Here $1-3<0$, so slope is not positive."},
            {"id": "B", "value": "Negative, because $x-y<0$", "explanation": "Correct: $1-3=-2<0$ gives a negative slope."},
            {"id": "C", "value": "Zero, because $x=y$", "explanation": "Slope is $0$ only when $x=y$; here $1\\neq 3$."},
            {"id": "D", "value": "Undefined, because slope fields do not give slopes", "explanation": "Slope fields show slopes at each point by direction segments."}
        ]'::jsonb, 'B',
        'For $\\frac{dy}{dx}=x-y$, at $\\left(1,3\\right)$ the slope is $1-3=-2$, which is negative.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_3_slopefield_A.png'
    );

    -- U7.4-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.4-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.4', '7.4', 4, 'MCQ',
        'Use the slope field in file $u7_7_4_slopefield_B.png$ for $\\frac{dy}{dx}=y(1-y)$. Which statement about equilibria and stability is correct?', 'image', false,
        'equilibrium_solutions', ARRAY['equilibrium_solutions', 'qualitative_behavior'], ARRAY['equilibrium_missed', 'solution_curve_not_tangent'],
        '[
            {"id": "A", "value": "$y=0$ and $y=1$ are equilibria, and $y=1$ is stable (attracting).", "explanation": "Correct: $y=1$ attracts nearby solutions."},
            {"id": "B", "value": "$y=0$ and $y=1$ are equilibria, and both are unstable.", "explanation": "The slope directions near $y=1$ point toward it, not away."},
            {"id": "C", "value": "Only $y=0$ is an equilibrium.", "explanation": "Misses the equilibrium at $y=1$ where $y(1-y)=0$."},
            {"id": "D", "value": "$y=1$ is not an equilibrium because the slope changes with $x$.", "explanation": "This DE is autonomous (depends on $y$), and $y=1$ is an equilibrium."}
        ]'::jsonb, 'A',
        'Equilibria occur at $y=0$ and $y=1$. For $0<y<1$, slopes are positive, and for $y>1$ slopes are negative, so solutions move toward $y=1$, making it stable.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_4_slopefield_B.png'
    );

    -- U7.4-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.4-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.4', '7.4', 3, 'MCQ',
        'Suppose a slope field shows positive slopes in a region of the plane. What does that tell you about solution curves passing through that region (locally)?', 'text', false,
        'qualitative_behavior', ARRAY['qualitative_behavior', '\\interpret_in_context'], ARRAY['confuse_slope_with_yvalue', 'slope_field_axis_mixup'],
        '[
            {"id": "A", "value": "They must be decreasing there.", "explanation": "Decreasing would require negative slopes."},
            {"id": "B", "value": "They must be increasing there.", "explanation": "Correct: positive slopes imply locally increasing solution curves."},
            {"id": "C", "value": "They must have $y>0$ there.", "explanation": "Slope sign does not directly determine whether $y$ is positive."},
            {"id": "D", "value": "They must be horizontal there.", "explanation": "Horizontal would require slope $0$."}
        ]'::jsonb, 'B',
        'Positive slope means $\\frac{dy}{dx}>0$, so solution curves rise as $x$ increases (locally increasing).',
        NOW(), NOW(), 'published', 1
    );

    -- U7.4-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, sub_topic_id, section_id, difficulty, type, 
        prompt, prompt_type, calculator_allowed, 
        primary_skill_id, skill_tags, error_tags,
        options, correct_option_id,
        explanation,
        created_at, updated_at, status, version,
        notes
    ) VALUES (
        'U7.4-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.4', '7.4', 5, 'MCQ',
        'Use the slope field in file $u7_7_4_slopefield_B.png$ for $\\frac{dy}{dx}=y(1-y)$. A solution has initial condition $y(0)=2$. Which long-term behavior is most consistent with the slope field?', 'image', false,
        'slope_field_solution_curve', ARRAY['slope_field_solution_curve', 'qualitative_behavior', 'equilibrium_solutions'], ARRAY['solution_curve_not_tangent', 'equilibrium_missed'],
        '[
            {"id": "A", "value": "It increases without bound.", "explanation": "For $y>1$, slopes are negative, so it does not increase."},
            {"id": "B", "value": "It decreases toward $y=1$.", "explanation": "Correct: it moves down toward $y=1$."},
            {"id": "C", "value": "It stays at $y=2$ for all $x$.", "explanation": "Only equilibrium solutions stay constant; $y=2$ is not an equilibrium."},
            {"id": "D", "value": "It decreases toward $y=0$.", "explanation": "The field indicates $y=1$ is the attracting level, not $y=0$ for this start."}
        ]'::jsonb, 'B',
        'If $y>1$, then $y(1-y)<0$, so slopes are negative and solutions move downward toward the stable equilibrium $y=1$.',
        NOW(), NOW(), 'published', 1,
        'Uses image file: u7_7_4_slopefield_B.png'
    );

END $$;
