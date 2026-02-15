-- Insert Unit 7 Part 2 Questions (7.5 - 7.9)
-- REMOVED 7.10 (Does not exist in frontend config)
-- Updated 7.9 to course='BC' (BC Only).
-- FIXED: representation_type set to 'symbolic' (was 'text'/'table'/'graph' causing constraint error)
-- Includes:
-- 1. Skills and Error Tags for Part 2
-- 2. Questions U7.5-P1 to U7.9-P5
-- 3. Ensures correct `topic` ('Both_DiffEq'), `course` (\frac{BC}{Both}), and `type` ('MCQ')

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills for Unit 7 Part 2
    INSERT INTO public.skills (id, name, unit) VALUES
        ('separate_variables', 'Separation of Variables', 'Unit7_DiffEq'),
        ('\\integrate_both_sides', 'Integrate Both Sides', 'Unit7_DiffEq'),
        ('exponential_de_model', 'Exponential DE Model', 'Unit7_DiffEq'),
        ('estimate_parameter_from_data', 'Estimate Parameter from Data', 'Unit7_DiffEq')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags for Unit 7 Part 2
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('variables_not_fully_separated', 'Variables Not Fully Separated', 'Algebra', 3, 'Unit7_DiffEq'),
        ('algebra_error_during_separation', 'Separation Algebra Error', 'Algebra', 3, 'Unit7_DiffEq'),
        ('antiderivative_error', 'Antiderivative Error', 'Procedural', 3, 'Unit7_DiffEq'),
        ('missing_constant_of_integration', 'Missing +C', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('implicit_to_explicit_algebra_error', 'Implicit -> Explicit Error', 'Algebra', 3, 'Unit7_DiffEq'),
        ('missing_abs_in_log', 'Missing Absolute Value in Log', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('lost_solution_dividing_by_expression', 'Lost Solution', 'Analysis', 5, 'Unit7_DiffEq'),
        ('parameter_from_data_error', 'Parameter Estimation Error', 'Data', 3, 'Unit7_DiffEq')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions to avoid collision
    DELETE FROM public.questions WHERE title IN (
        'U7.5-P1', 'U7.5-P2', 'U7.5-P3', 'U7.5-P4', 'U7.5-P5',
        'U7.6-P1', 'U7.6-P2', 'U7.6-P3', 'U7.6-P4', 'U7.6-P5',
        'U7.7-P1', 'U7.7-P2', 'U7.7-P3', 'U7.7-P4', 'U7.7-P5',
        'U7.8-P1', 'U7.8-P2', 'U7.8-P3', 'U7.8-P4', 'U7.8-P5',
        'U7.9-P1', 'U7.9-P2', 'U7.9-P3', 'U7.9-P4', 'U7.9-P5'
        -- REMOVED 7.10
    );

    -- 4. Insert Questions

    -- U7.5-P1 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.5-P1', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.5', '7.5', 'MCQ', true, 3,
        'Use Euler’s method with step size $h=0.5$ to approximate $y(0.5)$ for $\\frac{dy}{dt}=t+y$ with $y(0)=1$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1.25$", "explanation": "Uses an incorrect slope or step size."},
            {"id": "B", "value": "$1.50$", "explanation": "Correct: $1+0.5\\cdot 1=1.5$."},
            {"id": "C", "value": "$1.75$", "explanation": "Over-updates using the next slope too early."},
            {"id": "D", "value": "$2.00$", "explanation": "Treats the slope like $t+y=2$ at $t=0$ (wrong)."}
        ]'::jsonb, 'B',
        'Euler step: $y_1=y_0+h f(t_0,y_0)=1+0.5(0+1)=1.5$.',
        'evaluate_derivative_at_point', ARRAY['evaluate_derivative_at_point', 'identify_initial_condition'], ARRAY['initial_condition_misread', 'derivative_computation_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.5-P2 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.5-P2', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.5', '7.5', 'MCQ', true, 3,
        'Use the Euler table in file $u7_7_5_euler_table_A.png$ (step size $h=1$) for $\\frac{dy}{dt}=t-y$. What value completes the table entry for $y_2$ (the approximation at $t=2$)?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$-1$", "explanation": "Sign mistake when computing $f(1,0)$ or updating $y$."},
            {"id": "B", "value": "$0$", "explanation": "Stops after one step and forgets the second update."},
            {"id": "C", "value": "$1$", "explanation": "Correct: $0+1\\cdot 1=1$."},
            {"id": "D", "value": "$2$", "explanation": "Treats $y_2$ as $t_2$ instead of the $y$-value."}
        ]'::jsonb, 'C',
        'From the table, $y_1=0$ at $t_1=1$. Then $f(1,0)=1-0=1$, so $y_2=y_1+1\\cdot 1=1$.',
        'evaluate_derivative_at_point', ARRAY['evaluate_derivative_at_point', '\\interpret_in_context'], ARRAY['derivative_computation_error', 'sign_error_in_rate'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_5_euler_table_A.png'
    );

    -- U7.5-P3 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.5-P3', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.5', '7.5', 'MCQ', false, 2,
        'Euler’s method updates a solution from $t_n$ to $t_{n+1}$ by using which idea?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "A \\secant line through two known solution points", "explanation": "Euler uses a slope from the differential equation at one point, not a secant slope."},
            {"id": "B", "value": "A \\tangent-line (local linear) approximation using the slope at $\\\left(t_n,y_n\\right)$", "explanation": "Correct: it uses the slope at $\\left(t_n,y_n\\right)$."},
            {"id": "C", "value": "An exact antiderivative found by separation of variables", "explanation": "Euler is numerical; it does not require an exact integral."},
            {"id": "D", "value": "A slope field that forces the curve to be horizontal", "explanation": "A slope field does not force horizontal motion everywhere."}
        ]'::jsonb, 'B',
        'Euler’s method uses the slope $\\frac{dy}{dt}=f(t,y)$ at the current point to step forward with a \\tangent-line approximation.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'evaluate_derivative_at_point'], ARRAY['verification_not_global', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.5-P4 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.5-P4', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.5', '7.5', 'MCQ', false, 3,
        'For Euler’s method on the same differential equation and time \\interval, which change usually makes the approximation more accurate?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Use a larger step size $h$", "explanation": "Larger $h$ usually increases the error per step."},
            {"id": "B", "value": "Use a smaller step size $h$", "explanation": "Correct: smaller $h$ typically improves accuracy."},
            {"id": "C", "value": "Replace $\\frac{dy}{dt}$ with $\\frac{dt}{dy}$", "explanation": "Flipping derivatives changes the model and is not Euler’s method."},
            {"id": "D", "value": "Ignore the initial condition", "explanation": "Euler’s method needs a starting value to generate approximations."}
        ]'::jsonb, 'B',
        'Smaller step sizes reduce local linearization error, so the numerical approximation is typically closer to the true solution.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'qualitative_behavior'], ARRAY['units_mismatch_or_ignored', 'parameter_from_data_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.5-P5 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.5-P5', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.5', '7.5', 'MCQ', true, 3,
        'Use the Euler steps shown in file $u7_7_5_euler_table_B.png$ for $\\frac{dy}{dt}=-0.4y$ with $y(0)=50$ and $h=1$. What is the Euler approximation for $y(2)$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$18$", "explanation": "Correct: the second Euler update gives $18$."},
            {"id": "B", "value": "$20$", "explanation": "Common arithmetic slip from $30-12$."},
            {"id": "C", "value": "$30$", "explanation": "This is $y_1$, not $y_2$."},
            {"id": "D", "value": "$50$", "explanation": "This is the initial value $y_0$."}
        ]'::jsonb, 'A',
        'From the table: $y_1=30$ and then $y_2=18$, so the approximation at $t=2$ is $18$.',
        'identify_initial_condition', ARRAY['identify_initial_condition', 'evaluate_derivative_at_point'], ARRAY['initial_condition_misread', 'sign_error_in_rate'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_5_euler_table_B.png'
    );

    -- U7.6-P1 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.6-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.6', '7.6', 'MCQ', false, 3,
        'Which is an equivalent separated form of $\\frac{dy}{dx}=\\frac{x^2}{y}$ (assuming $y\\neq 0$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y\\\,dy=x^2\\\,dx$", "explanation": "Correct: all $y$ terms are with $dy$ and all $x$ terms with $dx$."},
            {"id": "B", "value": "$\\frac{1}{y}\\\,dy=x^2\\\,dx$", "explanation": "Keeps $y$ in the denominator on the left incorrectly after moving terms."},
            {"id": "C", "value": "$y\\\,dy=\\frac{1}{x^2}\\\,dx$", "explanation": "Inverts $x^2$ incorrectly."},
            {"id": "D", "value": "$dy=xy\\\,dx$", "explanation": "Does not match the original equation."}
        ]'::jsonb, 'A',
        'Multiply both sides by $y\\,dx$ to separate: $y\\,dy=x^2\\,dx$.',
        'separate_variables', ARRAY['separate_variables', '\\integrate_both_sides'], ARRAY['variables_not_fully_separated', 'algebra_error_during_separation'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.6-P2 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.6-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.6', '7.6', 'MCQ', false, 4,
        'Find a general solution to $\\frac{dy}{dx}=3xy$ for $y>0$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=Ce^{\\frac{3}{2}x^2}$", "explanation": "Correct: exponent comes from integrating $3x$."},
            {"id": "B", "value": "$y=Ce^{3x}$", "explanation": "Uses $3x$ instead of $\\frac{3}{2}x^2$ in the exponent."},
            {"id": "C", "value": "$y=\\frac{3}{2}x^2+C$", "explanation": "Treats $y''$ like $y$ and integrates incorrectly."},
            {"id": "D", "value": "$y=Cx^3$", "explanation": "Not consistent with exponential growth in $x^2$."}
        ]'::jsonb, 'A',
        'Separate: $\\frac{1}{y}dy=3x\\,dx$. Integrate: $\\\\\\\\ln y=\\frac{3}{2}x^2+C$, so $y=Ce^{\\frac{3}{2}x^2}$ for $y>0$.',
        '\\integrate_both_sides', ARRAY['\\integrate_both_sides', 'separate_variables'], ARRAY['antiderivative_error', 'missing_constant_of_integration'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.6-P3 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.6-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.6', '7.6', 'MCQ', false, 3,
        'A differential equation is $\\frac{dy}{dx}=\\frac{1}{y}$ (with $y\\neq 0$). Which implicit relation is a correct general solution?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{2}y^2=x+C$", "explanation": "Correct: integrates to $\\frac{1}{2}y^2=x+C$."},
            {"id": "B", "value": "$y=\\ln|x|+C$", "explanation": "Integrates the wrong variable; $y$ is not $\\\\\\\\ln|x|$ here."},
            {"id": "C", "value": "$\\ln|y|=x+C$", "explanation": "Would correspond to $\\frac{dy}{dx}=y$, not $\\frac{1}{y}$."},
            {"id": "D", "value": "$y^2=\\frac{1}{x}+C$", "explanation": "Incorrect antiderivative of $1$ and wrong algebra."}
        ]'::jsonb, 'A',
        'Separate: $y\\,dy=dx$. Integrate: $\\int y\\,dy=\\int 1\\,dx$ gives $\\frac{1}{2}y^2=x+C$.',
        '\\integrate_both_sides', ARRAY['\\integrate_both_sides', 'separate_variables'], ARRAY['antiderivative_error', 'missing_constant_of_integration'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.6-P4 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.6-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.6', '7.6', 'MCQ', false, 3,
        'If $\\\\\\\\ln|y|=x^2+C$, which explicit form is equivalent for $y\\neq 0$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=Ce^{x^2}$", "explanation": "Correct: exponentiating produces a multiplicative constant."},
            {"id": "B", "value": "$y=x^2+C$", "explanation": "Does not undo the logarithm correctly."},
            {"id": "C", "value": "$y=\\ln|x^2|+C$", "explanation": "Changes the inside of the logarithm and the variable."},
            {"id": "D", "value": "$y=e^{x^2}+C$", "explanation": "Adds the constant after exponentiating instead of multiplying."}
        ]'::jsonb, 'A',
        'Exponentiate: $|y|=e^{x^2+C}=e^C e^{x^2}$. Let $C$ be any nonzero constant (positive or negative), giving $y=Ce^{x^2}$.',
        'implicit_to_explicit', ARRAY['implicit_to_explicit', '\\integrate_both_sides'], ARRAY['implicit_to_explicit_algebra_error', 'missing_abs_in_log'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.6-P5 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.6-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.6', '7.6', 'MCQ', false, 4,
        'Consider $\\frac{dy}{dx}=y(y-1)$. If you separate variables by dividing both sides by $y(y-1)$, which constant solution(s) could be lost and must be checked separately?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=0$ only", "explanation": "Misses the equilibrium at $y=1$."},
            {"id": "B", "value": "$y=1$ only", "explanation": "Misses the equilibrium at $y=0$."},
            {"id": "C", "value": "$y=0$ and $y=1$", "explanation": "Correct: both make the right side $0$ and can be lost by division."},
            {"id": "D", "value": "No constant solutions are possible", "explanation": "This DE has equilibria where $\\frac{dy}{dx}=0$."}
        ]'::jsonb, 'C',
        'Equilibria occur when $y(y-1)=0$, so $y=0$ and $y=1$ are constant solutions. Dividing by $y(y-1)$ would divide by zero at those solutions, so they must be included separately.',
        'equilibrium_solutions', ARRAY['equilibrium_solutions', 'separate_variables'], ARRAY['lost_solution_dividing_by_expression', 'equilibrium_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.7-P1 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.7-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.7', '7.7', 'MCQ', false, 4,
        'A general solution to $\\frac{dy}{dx}=2y$ is $y=Ce^{2x}$. If $y(0)=5$, what is the particular solution?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=5e^{2x}$", "explanation": "Correct: $C=5$ from the initial condition."},
            {"id": "B", "value": "$y=e^{10x}$", "explanation": "Wrong: changes the exponent instead of the constant."},
            {"id": "C", "value": "$y=Ce^{2x}+5$", "explanation": "Wrong: solutions scale by a constant, not add one."},
            {"id": "D", "value": "$y=5e^{-2x}$", "explanation": "Wrong sign in the exponent (would satisfy $y''=-2y$)."}
        ]'::jsonb, 'A',
        'Use $y(0)=5$: $5=Ce^{0}$ so $C=5$, giving $y=5e^{2x}$.',
        'solve_for_constant_using_ic', ARRAY['solve_for_constant_using_ic', '\\integrate_both_sides'], ARRAY['constant_solve_error_with_ic', 'missing_constant_of_integration'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.7-P2 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.7-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.7', '7.7', 'MCQ', false, 4,
        'Solve the initial value problem $\\frac{dy}{dx}=\\frac{x}{y}$ with $y(0)=2$ and $y>0$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=\\sqrt{x^2+4}$", "explanation": "Correct: satisfies the DE and $y(0)=2$."},
            {"id": "B", "value": "$y=\\sqrt{x^2-4}$", "explanation": "Gives $y(0)=\\sqrt{-4}$, not real."},
            {"id": "C", "value": "$y=x+2$", "explanation": "Would imply $y''=1$, not $\\frac{x}{y}$ for all $x$."},
            {"id": "D", "value": "$y=2e^{x}$", "explanation": "Solves $y''=y$, not $y''=\\frac{x}{y}$."}
        ]'::jsonb, 'A',
        'Separate: $y\\,dy=x\\,dx$. Integrate: $\\frac{1}{2}y^2=\\frac{1}{2}x^2+C$, so $y^2=x^2+C''$. Use $y(0)=2$ to get $4=C''$, hence $y=\\sqrt{x^2+4}$ (\\\\\\\\since $y>0$).',
        'separate_variables', ARRAY['separate_variables', 'identify_initial_condition'], ARRAY['variables_not_fully_separated', 'initial_condition_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.7-P3 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.7-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.7', '7.7', 'MCQ', false, 5,
        'An implicit solution to a differential equation is $\\\\\\\\ln|y|=x+C$. If $y(1)=-2$, which explicit solution is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=-2e^{x-1}$", "explanation": "Correct: matches $y(1)=-2$ and keeps the sign negative."},
            {"id": "B", "value": "$y=2e^{x-1}$", "explanation": "Wrong sign: would give $y(1)=2$."},
            {"id": "C", "value": "$y=-2e^{1-x}$", "explanation": "Wrong exponent direction: gives $y(1)=-2$ but does not match $|y|=Ae^{x}$ for all $x$."},
            {"id": "D", "value": "$y=\\ln|x| -2$", "explanation": "Does not undo the logarithm and is not an exponential form."}
        ]'::jsonb, 'A',
        'Exponentiate: $|y|=e^{x+C}=Ae^{x}$. With $y(1)=-2$, we have $|y(1)|=2=Ae^{1}$ so $A=2e^{-1}$. Since $y$ is negative at $x=1$, choose $y=-Ae^{x}=-2e^{x-1}$.',
        'solve_for_constant_using_ic', ARRAY['solve_for_constant_using_ic', 'implicit_to_explicit'], ARRAY['constant_solve_error_with_ic', 'implicit_to_explicit_algebra_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.7-P4 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.7-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.7', '7.7', 'MCQ', false, 4,
        'Solve the initial value problem $\\frac{dy}{dx}=\\frac{2}{x}y$ for $x>0$ with $y(1)=3$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=3x^2$", "explanation": "Correct: gives $y=Cx^2$ and matches $y(1)=3$."},
            {"id": "B", "value": "$y=3x$", "explanation": "Would correspond to $\\frac{dy}{dx}=\\frac{1}{x}y$."},
            {"id": "C", "value": "$y=3e^{2x}$", "explanation": "Solves $y''=2y$, not $y''=\\frac{2}{x}y$."},
            {"id": "D", "value": "$y=\\frac{3}{x^2}$", "explanation": "Wrong power; would satisfy $\\frac{dy}{dx}=-\\frac{2}{x}y$."}
        ]'::jsonb, 'A',
        'Separate: $\\frac{1}{y}dy=\\frac{2}{x}dx$. Integrate: $\\\\\\\\ln|y|=2\\\\\\\\ln x+C=\\\\\\\\ln(x^2)+C$, so $y=Cx^2$. Use $y(1)=3$ to get $C=3$, hence $y=3x^2$.',
        '\\integrate_both_sides', ARRAY['\\integrate_both_sides', 'solve_for_constant_using_ic'], ARRAY['antiderivative_error', 'constant_solve_error_with_ic'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.7-P5 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.7-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.7', '7.7', 'MCQ', false, 3,
        'A cooling liquid has temperature $T(t)$ (in $^\\circ\\!\\!F$) at time $t$ (in minutes). The statement “at $t=10$ minutes, the temperature is $80^\\circ\\!\\!F$” corresponds to which condition?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$T(80)=10$", "explanation": "Swaps input and output."},
            {"id": "B", "value": "$T(10)=80$", "explanation": "Correct: temperature at $t=10$ is $80$."},
            {"id": "C", "value": "$T''(10)=80$", "explanation": "This would be a rate of change at $t=10$."},
            {"id": "D", "value": "$T''(80)=10$", "explanation": "Mixes time and temperature in the derivative statement."}
        ]'::jsonb, 'B',
        'The input is time and the output is temperature, so the condition is $T(10)=80$.',
        'identify_initial_condition', ARRAY['identify_initial_condition', '\\interpret_in_context'], ARRAY['initial_condition_misread', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.8-P1 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.8-P1', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.8', '7.8', 'MCQ', false, 3,
        'A quantity $y(t)$ satisfies $\\frac{dy}{dt}=ky$ with $k<0$. Which statement is true if $y(0)>0$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y(t)$ increases for all $t$.", "explanation": "That would require $k>0$ when $y>0$."},
            {"id": "B", "value": "$y(t)$ decreases for all $t$.", "explanation": "Correct: negative rate implies decreasing."},
            {"id": "C", "value": "$y(t)$ is constant for all $t$.", "explanation": "Only if $k=0$."},
            {"id": "D", "value": "$y(t)$ must become negative.", "explanation": "Decay can approach $0$ without becoming negative."}
        ]'::jsonb, 'B',
        'If $k<0$ and $y>0$, then $\\frac{dy}{dt}=ky<0$, so $y(t)$ decreases (exponential decay).',
        'exponential_de_model', ARRAY['exponential_de_model', '\\interpret_in_context'], ARRAY['wrong_k_interpretation', 'sign_error_in_rate'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.8-P2 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.8-P2', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.8', '7.8', 'MCQ', true, 4,
        'Use the data table in file $u7_7_8_data_table.png$. Assume $P(t)$ follows $\\frac{dP}{dt}=kP$. Which value of $k$ is most consistent with the data?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$k=\\frac{\\ln(1.25)}{3}$", "explanation": "Correct: uses the exponential ratio relationship."},
            {"id": "B", "value": "$k=\\frac{1.25}{3}$", "explanation": "Uses a linear rate instead of an exponential rate."},
            {"id": "C", "value": "$k=\\ln(1.25)$", "explanation": "Forgets to divide by the time interval $3$."},
            {"id": "D", "value": "$k=-\\frac{\\ln(1.25)}{3}$", "explanation": "Wrong sign: the data show growth, not decay."}
        ]'::jsonb, 'A',
        'From $t=0$ to $t=3$, the ratio is $\\frac{150}{120}=1.25$. For $P(t)=P(0)e^{kt}$, $1.25=e^{3k}$ so $k=\\frac{\\\\\\\\ln(1.25)}{3}$.',
        'estimate_parameter_from_data', ARRAY['estimate_parameter_from_data', 'exponential_de_model'], ARRAY['parameter_from_data_error', 'wrong_k_interpretation'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_8_data_table.png'
    );

    -- U7.8-P3 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.8-P3', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.8', '7.8', 'MCQ', false, 4,
        'A quantity satisfies $\\frac{dy}{dt}=ky$ and $y(0)=12$. If $y(5)=24$, what is the value of $k$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$k=\\frac{\\ln 2}{5}$", "explanation": "Correct: uses $e^{5k}=2$."},
            {"id": "B", "value": "$k=\\frac{2}{5}$", "explanation": "Treats growth as linear doubling."},
            {"id": "C", "value": "$k=\\ln 2$", "explanation": "Forgets to divide by $5$."},
            {"id": "D", "value": "$k=-\\frac{\\ln 2}{5}$", "explanation": "Wrong sign: the quantity increases from $12$ to $24$."}
        ]'::jsonb, 'A',
        'With $y(t)=12e^{kt}$, the condition $24=12e^{5k}$ gives $2=e^{5k}$, so $k=\\frac{\\\\\\\\ln 2}{5}$.',
        'exponential_de_model', ARRAY['exponential_de_model', 'solve_for_constant_using_ic'], ARRAY['wrong_k_interpretation', 'constant_solve_error_with_ic'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.8-P4 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.8-P4', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.8', '7.8', 'MCQ', true, 3,
        'Use the graph in file $u7_7_8_exp_graph.png$. The model shown is exponential growth. Which statement best matches the meaning of a larger positive $k$ in $\\frac{dP}{dt}=kP$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "The quantity grows faster because the relative growth rate is larger.", "explanation": "Correct: larger $k$ increases the growth rate at every value of $P$."},
            {"id": "B", "value": "The initial value $P(0)$ becomes larger.", "explanation": "$P(0)$ is set by the initial condition, not by $k$."},
            {"id": "C", "value": "The quantity must eventually become linear.", "explanation": "Exponential models remain exponential, not linear."},
            {"id": "D", "value": "The growth changes from exponential to \\\\\\\\logistic.", "explanation": "Changing $k$ does not change the model type to logistic."}
        ]'::jsonb, 'A',
        'In $\\frac{dP}{dt}=kP$, the constant $k$ is the relative growth rate; larger positive $k$ means steeper exponential increase.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'estimate_parameter_from_data'], ARRAY['wrong_k_interpretation', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_8_exp_graph.png'
    );

    -- U7.8-P5 (Both)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.8-P5', 'Both', 'Both_DiffEq', 'Both_DiffEq', '7.8', '7.8', 'MCQ', false, 3,
        'A bacteria culture grows at a rate proportional to its current size. Which expression best represents the instantaneous rate of change of the population $P(t)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{dP}{dt}=kP$ with $k>0$", "explanation": "Correct: proportional-to-current-value growth model."},
            {"id": "B", "value": "$\\frac{dP}{dt}=k$ with $k>0$", "explanation": "Constant growth rate is linear, not proportional."},
            {"id": "C", "value": "$\\frac{dP}{dt}=\\frac{k}{P}$ with $k>0$", "explanation": "Inverse dependence is not proportional to $P$."},
            {"id": "D", "value": "$\\frac{dP}{dt}=-kP$ with $k>0$", "explanation": "Negative sign would model decay, not growth."}
        ]'::jsonb, 'A',
        '“Proportional to $P$” means $\\frac{dP}{dt}=kP$, and growth requires $k>0$.',
        'model_from_context_rate', ARRAY['model_from_context_rate', 'units_mismatch_or_ignored'], ARRAY['wrong_dependency_in_model', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.9-P1 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.9-P1', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.9', '7.9', 'MCQ', true, 3,
        'Use the sign chart in file $u7_7_9_logistic_sign_table.png$ for $\\frac{dP}{dt}=0.2P\\left(1-\\frac{P}{500}\\right)$. Which statement is correct?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "If $P(0)=600$, then $P(t)$ increases toward $500$.", "explanation": "For $P>500$, the rate is negative, so it does not increase."},
            {"id": "B", "value": "If $P(0)=600$, then $P(t)$ decreases toward $500$.", "explanation": "Correct: negative rate for $P>500$ drives $P$ downward toward $500$."},
            {"id": "C", "value": "If $P(0)=200$, then $P(t)$ decreases toward $0$.", "explanation": "For $0<P<500$, the rate is positive, so it increases, not decreases."},
            {"id": "D", "value": "There are no equilibrium solutions because the model is not linear.", "explanation": "Equilibria occur where $\\frac{dP}{dt}=0$, regardless of linearity."}
        ]'::jsonb, 'B',
        'For $P>500$, $\\left(1-\\frac{P}{500}\\right)<0$, so $\\frac{dP}{dt}<0$ and the population decreases toward the equilibrium $P=500$.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'equilibrium_solutions'], ARRAY['wrong_k_interpretation', 'equilibrium_missed'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_9_logistic_sign_table.png'
    );

    -- U7.9-P2 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.9-P2', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.9', '7.9', 'MCQ', true, 3,
        'Use the graph in file $u7_7_9_logistic_curve.png$. Which statement best describes the long-term behavior of $y(t)$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$y(t)$ increases without bound.", "explanation": "Logistic-type growth levels off rather than growing unbounded."},
            {"id": "B", "value": "$y(t)$ approaches a horizontal asymptote (levels off).", "explanation": "Correct: the graph clearly approaches a constant level."},
            {"id": "C", "value": "$y(t)$ oscillates around a constant value.", "explanation": "No oscillations are shown."},
            {"id": "D", "value": "$y(t)$ decreases to $0$.", "explanation": "The curve is increasing and leveling off, not decreasing."}
        ]'::jsonb, 'B',
        'The curve rises quickly at first and then levels off toward a constant value, indicating approach to a carrying capacity.',
        'qualitative_behavior', ARRAY['qualitative_behavior', '\\interpret_in_context'], ARRAY['confuse_slope_with_yvalue', 'wrong_k_interpretation'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_9_logistic_curve.png'
    );

    -- U7.9-P3 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.9-P3', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.9', '7.9', 'MCQ', false, 4,
        'A population $P(t)$ grows but slows down as it approaches a maximum sustainable size $K$. Which differential equation best models this situation?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{dP}{dt}=kP$ with $k>0$", "explanation": "Exponential growth does not include a carrying capacity."},
            {"id": "B", "value": "$\\frac{dP}{dt}=k$ with $k>0$", "explanation": "Constant rate gives linear growth, not leveling off."},
            {"id": "C", "value": "$\\frac{dP}{dt}=kP\\\left(1-\\frac{P}{K}\\right)$ with $k>0$", "explanation": "Correct: growth slows when $P$ is near $K$."},
            {"id": "D", "value": "$\\frac{dP}{dt}=-kP$ with $k>0$", "explanation": "This models decay, not growth."}
        ]'::jsonb, 'C',
        'The \\\\\\\\logistic model $\\frac{dP}{dt}=kP\\left(1-\\frac{P}{K}\\right)$ includes slowdown as $P$ approaches $K$.',
        'model_from_context_rate', ARRAY['model_from_context_rate', 'units_mismatch_or_ignored'], ARRAY['wrong_dependency_in_model', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1
    );

    -- U7.9-P4 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7.9-P4', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.9', '7.9', 'MCQ', true, 4,
        'Use the graph in file $u7_7_9_logistic_curve.png$. Suppose this graph represents the solution to a \\\\\\\\logistic model. Which initial condition is most consistent with the graph?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$y(0)$ is close to $0$", "explanation": "Correct: starts far below the limiting value and rises toward it."},
            {"id": "B", "value": "$y(0)$ is close to the carrying capacity", "explanation": "If it started near carrying capacity, it would begin nearly flat."},
            {"id": "C", "value": "$y(0)$ is negative", "explanation": "The graph shows positive values throughout."},
            {"id": "D", "value": "$y(0)$ is larger than the carrying capacity", "explanation": "Starting above carrying capacity would typically decrease toward it."}
        ]'::jsonb, 'A',
        'The curve starts well below the leveling-off value and increases toward it, so the initial value is relatively small compared to the carrying capacity.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'identify_initial_condition'], ARRAY['initial_condition_misread', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_9_logistic_curve.png'
    );

    -- U7.9-P5 (BC Only)
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7.9-P5', 'BC', 'Both_DiffEq', 'Both_DiffEq', '7.9', '7.9', 'MCQ', false, 5,
        'For the \\\\\\\\logistic differential equation $\\frac{dP}{dt}=kP\\left(1-\\frac{P}{K}\\right)$ with $k>0$ and $K>0$, which equilibrium solution(s) are always present?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$P=0$ only", "explanation": "Misses the factor $1-\\frac{P}{K}=0$ at $P=K$."},
            {"id": "B", "value": "$P=K$ only", "explanation": "Misses $P=0$, which makes the right side zero."},
            {"id": "C", "value": "$P=0$ and $P=K$", "explanation": "Correct: both are roots of the right-hand side."},
            {"id": "D", "value": "No equilibria because $P$ changes with $t$", "explanation": "Equilibria are constant solutions where the rate is zero."}
        ]'::jsonb, 'C',
        'Equilibria occur when $\\frac{dP}{dt}=0$. This happens when $P=0$ or when $1-\\frac{P}{K}=0$, i.e., $P=K$.',
        'equilibrium_solutions', ARRAY['equilibrium_solutions', 'qualitative_behavior'], ARRAY['equilibrium_missed', 'lost_solution_dividing_by_expression'],
        NOW(), NOW(), 'published', 1
    );

END $$;
