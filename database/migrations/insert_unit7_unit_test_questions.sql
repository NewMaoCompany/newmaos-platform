-- Insert Unit 7 Unit Test Questions (U7-UT-Q1 to U7-UT-Q20)
-- 
-- Includes:
-- 1. Skills and Error Tags for Unit 7 (Ensuring existence)
-- 2. Questions U7-UT-Q1 to U7-UT-Q20
-- 3. Ensures correct `topic` ('Both_DiffEq'), `course` (Both), and `type` ('MCQ')
-- 4. Uses `representation_type` = 'symbolic' to comply with constraints.
-- 5. Uses `section_id` = 'unit_test' to match frontend expectation.

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('model_from_context_rate', 'Model Rate from Context', 'Unit7_DiffEq'),
        ('\\interpret_in_context', 'Interpret in Context', 'Unit_General'),
        ('estimate_parameter_from_data', 'Estimate Parameter from Data', 'Unit7_DiffEq'),
        ('exponential_de_model', 'Exponential DE Model', 'Unit7_DiffEq'),
        ('identify_initial_condition', 'Identify Initial Condition', 'Unit7_DiffEq'),
        ('evaluate_derivative_at_point', 'Evaluate Derivative at Point', 'Unit2_Derivatives'),
        ('separate_variables', 'Separation of Variables', 'Unit7_DiffEq'),
        ('\\integrate_both_sides', 'Integrate Both Sides', 'Unit7_DiffEq'),
        ('solve_for_constant_using_ic', 'Solve for Constant using IC', 'Unit7_DiffEq'),
        ('implicit_to_explicit', 'Implicit to Explicit', 'Unit3_Composite'),
        ('verify_by_substitution', 'Verify by Substitution', 'Unit7_DiffEq'),
        ('slope_field_solution_curve', 'Slope Field Solution Curve', 'Unit7_DiffEq'),
        ('slope_field_construct', 'Construct Slope Field', 'Unit7_DiffEq'),
        ('equilibrium_solutions', 'Equilibrium Solutions', 'Unit7_DiffEq'),
        ('qualitative_behavior', 'Qualitative Behavior', 'Unit7_DiffEq')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('sign_error_in_rate', 'Sign Error in Rate', 'Interpretation', 3, 'Unit7_DiffEq'),
        ('wrong_dependency_in_model', 'Wrong Dependency in Model', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('units_mismatch_or_ignored', 'Units \frac{Mismatch}{Ignored}', 'Interpretation', 2, 'Unit7_DiffEq'),
        ('wrong_k_interpretation', 'Wrong Interpretation of k', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('parameter_from_data_error', 'Parameter Estimation Error', 'Data', 3, 'Unit7_DiffEq'),
        ('initial_condition_misread', 'Initial Condition Misread', 'Interpretation', 2, 'Unit7_DiffEq'),
        ('variables_not_fully_separated', 'Variables Not Fully Separated', 'Algebra', 3, 'Unit7_DiffEq'),
        ('algebra_error_during_separation', 'Separation Algebra Error', 'Algebra', 3, 'Unit7_DiffEq'),
        ('antiderivative_error', 'Antiderivative Error', 'Procedural', 3, 'Unit7_DiffEq'),
        ('missing_abs_in_log', 'Missing Absolute Value in Log', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('constant_solve_error_with_ic', 'Error Solving C with IC', 'Algebra', 3, 'Unit7_DiffEq'),
        ('missing_constant_of_integration', 'Missing +C', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('implicit_to_explicit_algebra_error', 'Implicit -> Explicit Error', 'Algebra', 3, 'Unit7_DiffEq'),
        ('derivative_computation_error', 'Derivative Computation Error', 'Calculation', 3, 'Unit7_DiffEq'),
        ('substitution_error_in_verification', 'Substitution Error', 'Algebra', 3, 'Unit7_DiffEq'),
        ('solution_curve_not_tangent', 'Curve Not Tangent to Field', 'Visual', 3, 'Unit7_DiffEq'),
        ('slope_field_axis_mixup', 'Slope Field Axis Mixup', 'Visual', 3, 'Unit7_DiffEq'),
        ('invert_derivative', 'Inverted Derivative', 'Conceptual', 3, 'Unit7_DiffEq'),
        ('equilibrium_missed', 'Equilibrium Solutions Missed', 'Analysis', 3, 'Unit7_DiffEq'),
        ('lost_solution_dividing_by_expression', 'Lost Solution', 'Analysis', 5, 'Unit7_DiffEq'),
        ('confuse_slope_with_yvalue', 'Confuse Slope with Y-Value', 'Visual', 3, 'Unit7_DiffEq')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U7-UT-Q1', 'U7-UT-Q2', 'U7-UT-Q3', 'U7-UT-Q4', 'U7-UT-Q5',
        'U7-UT-Q6', 'U7-UT-Q7', 'U7-UT-Q8', 'U7-UT-Q9', 'U7-UT-Q10',
        'U7-UT-Q11', 'U7-UT-Q12', 'U7-UT-Q13', 'U7-UT-Q14', 'U7-UT-Q15',
        'U7-UT-Q16', 'U7-UT-Q17', 'U7-UT-Q18', 'U7-UT-Q19', 'U7-UT-Q20'
    );

    -- 4. Insert Questions

    -- U7-UT-Q1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q1', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'A radioactive sample decays at a rate proportional to the amount present. Which differential equation model is appropriate?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{dA}{dt}=kA$ with $k>0$", "explanation": "Wrong sign; this would increase when $A>0$."},
            {"id": "B", "value": "$\\frac{dA}{dt}=-kA$ with $k>0$", "explanation": "Correct: negative proportional rate gives decay."},
            {"id": "C", "value": "$\\frac{dA}{dt}=k$ with $k>0$", "explanation": "Not proportional to $A$."},
            {"id": "D", "value": "$\\frac{dA}{dt}=\\frac{k}{A}$ with $k>0$", "explanation": "Inverse dependence is not proportional to the amount present."}
        ]'::jsonb, 'B',
        '“Decays” means $A$ decreases when $A>0$, so the rate must be negative and proportional to $A$: $\\frac{dA}{dt}=-kA$.',
        'model_from_context_rate', ARRAY['model_from_context_rate', '\\interpret_in_context'], ARRAY['sign_error_in_rate', 'wrong_dependency_in_model'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q2', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'In the model $\\frac{dy}{dt}=ky$, time $t$ is measured in hours. What are the units of $k$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "hours", "explanation": "Would make $ky$ have units $y\\cdot\\text{hours}$."},
            {"id": "B", "value": "$\\frac{1}{\\text{hours}}$", "explanation": "Correct: $k$ is a per-hour rate constant."},
            {"id": "C", "value": "same units as $y$", "explanation": "Would make $ky$ have units $y^2$."},
            {"id": "D", "value": "unitless", "explanation": "Unitless $k$ would not match $\\frac{dy}{dt}$ units."}
        ]'::jsonb, 'B',
        '$\\frac{dy}{dt}$ has units $\\frac{y}{\\text{hours}}$ while $ky$ has units $k\\cdot y$, so $k$ must have units $\\frac{1}{\\text{hours}}$.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'exponential_de_model'], ARRAY['units_mismatch_or_ignored', 'wrong_k_interpretation'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q3', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'A quantity satisfies $\\frac{dy}{dt}=ky$ and doubles in $5$ hours. What is $k$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$k=\\frac{\\ln 2}{5}$", "explanation": "Correct: $e^{5k}=2$."},
            {"id": "B", "value": "$k=\\frac{2}{5}$", "explanation": "Treats growth as linear."},
            {"id": "C", "value": "$k=\\ln 2$", "explanation": "Forgets to divide by $5$ hours."},
            {"id": "D", "value": "$k=-\\frac{\\ln 2}{5}$", "explanation": "Wrong sign; doubling indicates growth."}
        ]'::jsonb, 'A',
        'For $y(t)=y(0)e^{kt}$, doubling gives $2=e^{5k}$ so $k=\\frac{\\\\\\\\ln 2}{5}$.',
        'estimate_parameter_from_data', ARRAY['estimate_parameter_from_data', 'exponential_de_model'], ARRAY['parameter_from_data_error', 'wrong_k_interpretation'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q4', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 3,
        'Use the table in file $u7_7_14_decay_table.png$. Which initial condition is directly supported by the data?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$A(80)=0$", "explanation": "Swaps input and output."},
            {"id": "B", "value": "$A(0)=80$", "explanation": "Correct: read directly from the $t=0$ row."},
            {"id": "C", "value": "$A''(0)=80$", "explanation": "The table gives $A(t)$, not $A''(t)$."},
            {"id": "D", "value": "$A''(2)=64$", "explanation": "The table does not list derivative values."}
        ]'::jsonb, 'B',
        'The first row of the table gives $A(0)=80$ grams.',
        'identify_initial_condition', ARRAY['identify_initial_condition', '\\interpret_in_context'], ARRAY['initial_condition_misread', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_14_decay_table.png'
    );

    -- U7-UT-Q5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q5', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'For $\\frac{dy}{dt}=t^2-y$, what is $\\frac{dy}{dt}$ at the point $(t,y)=(1,3)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$-2$", "explanation": "Correct: $1-3=-2$."},
            {"id": "B", "value": "$-1$", "explanation": "Arithmetic error."},
            {"id": "C", "value": "$2$", "explanation": "Drops the negative sign."},
            {"id": "D", "value": "$4$", "explanation": "Adds instead of subtracting."}
        ]'::jsonb, 'A',
        'Substitute $t=1$ and $y=3$: $\\frac{dy}{dt}=1^2-3=-2$.',
        'evaluate_derivative_at_point', ARRAY['evaluate_derivative_at_point', '\\interpret_in_context'], ARRAY['sign_error_in_rate', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q6
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q6', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Which is the best first move to solve $\\frac{dy}{dx}=xy$ by separation of variables?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Write $\\frac{1}{y}\\\,dy=x\\\,dx$", "explanation": "Correct: variables are separated with $y$ on the left and $x$ on the right."},
            {"id": "B", "value": "Write $\\frac{1}{x}\\\,dx=y\\\,dy$", "explanation": "Mixes up which variable to isolate."},
            {"id": "C", "value": "Write $y\\\,dy=x\\\,dx$", "explanation": "Does not fully separate because $y$ is still on the left but not isolated properly for the given DE."},
            {"id": "D", "value": "Write $\\ln y=x^2$ immediately", "explanation": "You must separate and integrate first."}
        ]'::jsonb, 'A',
        'Divide both sides by $y$ (for $y\\neq 0$) to get $\\frac{1}{y}\\,dy=x\\,dx$ before \\integrating.',
        'separate_variables', ARRAY['separate_variables', '\\interpret_in_context'], ARRAY['variables_not_fully_separated', 'algebra_error_during_separation'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q7
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q7', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'After separating variables for $\\frac{dy}{dx}=xy$ as $\\frac{1}{y}\\,dy=x\\,dx$, which \\integrated equation is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\ln|y|=\\frac{x^2}{2}+C$", "explanation": "Correct: includes $\\\\\\\\ln|y|$, $\\frac{x^2}{2}$, and $+C$."},
            {"id": "B", "value": "$\\ln y=\\frac{x^2}{2}$", "explanation": "Missing $|\\cdot|$ and missing $+C$."},
            {"id": "C", "value": "$\\frac{1}{y}=\\frac{x^2}{2}+C$", "explanation": "Incorrect antiderivative of $\\frac{1}{y}$."},
            {"id": "D", "value": "$\\ln|y|=x^2+C$", "explanation": "Incorrect antiderivative of $x$ (should be $\\frac{x^2}{2}$)."}
        ]'::jsonb, 'A',
        '$\\int \\frac{1}{y}\\,dy=\\\\\\\\ln|y|$ and $\\int x\\,dx=\\frac{x^2}{2}$, plus a constant $C$.',
        '\\integrate_both_sides', ARRAY['\\integrate_both_sides', 'separate_variables'], ARRAY['antiderivative_error', 'missing_abs_in_log'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q8
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q8', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'A separated-and-\\integrated solution to a DE is $\\\\\\\\ln|y|=\\frac{x^2}{2}+C$. If $y(0)=2$, what is $C$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$C=\\ln 2$", "explanation": "Correct: $C=\\\\\\\\ln 2$."},
            {"id": "B", "value": "$C=2$", "explanation": "Confuses $\\\\\\\\ln 2$ with $2$."},
            {"id": "C", "value": "$C=\\frac{\\ln 2}{2}$", "explanation": "Unjustified division by $2$."},
            {"id": "D", "value": "$C=-\\ln 2$", "explanation": "Wrong sign."}
        ]'::jsonb, 'A',
        'Plug in $x=0$ and $y=2$: $\\\\\\\\ln|2|=0+C$, so $C=\\\\\\\\ln 2$.',
        'solve_for_constant_using_ic', ARRAY['solve_for_constant_using_ic', '\\integrate_both_sides'], ARRAY['constant_solve_error_with_ic', 'missing_constant_of_integration'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q9
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q9', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'If $\\\\\\\\ln|y|=\\frac{x^2}{2}+C$, which explicit form is correct (for nonzero $y$)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y=C+\\frac{x^2}{2}$", "explanation": "That treats $\\\\\\\\ln|y|$ like a linear expression in $y$."},
            {"id": "B", "value": "$y=e^{\\frac{x^2}{2}+C}$", "explanation": "Not simplified to the standard constant-multiplied form."},
            {"id": "C", "value": "$y=Ce^{\\frac{x^2}{2}}$", "explanation": "Correct: combines constants into a single multiplicative constant."},
            {"id": "D", "value": "$y=\\frac{x^2}{2e^C}$", "explanation": "Algebra is incorrect after exponentiating."}
        ]'::jsonb, 'C',
        'Exponentiate: $|y|=e^{\\frac{x^2}{2}+C}=e^C e^{\\frac{x^2}{2}}$. Absorb $e^C$ \\into a new constant $C$, giving $y=Ce^{\\frac{x^2}{2}}$.',
        'implicit_to_explicit', ARRAY['implicit_to_explicit', '\\integrate_both_sides'], ARRAY['implicit_to_explicit_algebra_error', 'missing_abs_in_log'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q10
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q10', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Verify whether $y=Ce^{\\frac{x^2}{2}}$ is a solution to $\\frac{dy}{dx}=xy$. Which statement is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$y''=Ce^{\\frac{x^2}{2}}$ so it does not match $xy$.", "explanation": "Misses the chain rule factor $x$."},
            {"id": "B", "value": "$y''=xCe^{\\frac{x^2}{2}}=xy$, so it is a solution.", "explanation": "Correct: chain rule gives $y''=xy$."},
            {"id": "C", "value": "$y''=\\frac{x^2}{2}Ce^{\\frac{x^2}{2}}$, so it is not a solution.", "explanation": "Multiplies by the inside instead of differentiating it."},
            {"id": "D", "value": "You cannot verify because $C$ is unknown.", "explanation": "Verification works symbolically for any constant $C$."}
        ]'::jsonb, 'B',
        'Differentiate: $y''=Ce^{\\frac{x^2}{2}}\\cdot x=xCe^{\\frac{x^2}{2}}=xy$, so it satisfies the DE for all $x$.',
        'verify_by_substitution', ARRAY['verify_by_substitution', 'evaluate_derivative_at_point'], ARRAY['derivative_computation_error', 'substitution_error_in_verification'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q11
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q11', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'In file $u7_7_11_slopefield_candidates.png$ for $\\frac{dy}{dx}=x-y$, which labeled curve matches the initial condition $y(0)=1$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "Curve A", "explanation": "Correct: passes through $(0,1)$ and follows the direction field."},
            {"id": "B", "value": "Curve B", "explanation": "Has a different $y$-value at $x=0$."},
            {"id": "C", "value": "Curve C", "explanation": "Has a different $y$-value at $x=0$."},
            {"id": "D", "value": "All three curves", "explanation": "Different initial conditions produce different solution curves."}
        ]'::jsonb, 'A',
        'The point $(0,1)$ is marked, and Curve A is the one that passes through it while remaining \\tangent to the slope field.',
        'slope_field_solution_curve', ARRAY['slope_field_solution_curve', 'identify_initial_condition'], ARRAY['solution_curve_not_tangent', 'initial_condition_misread'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_11_slopefield_candidates.png'
    );

    -- U7-UT-Q12
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q12', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 3,
        'Use file $u7_7_11_slopefield_candidates.png$ for $\\frac{dy}{dx}=x-y$. What is the slope at the point $(1,0)$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$-1$", "explanation": "Uses $y-x$ or flips the subtraction."},
            {"id": "B", "value": "$0$", "explanation": "Slope is not zero here because $x\\neq y$."},
            {"id": "C", "value": "$1$", "explanation": "Correct: $1-0=1$."},
            {"id": "D", "value": "$2$", "explanation": "Adds instead of subtracting."}
        ]'::jsonb, 'C',
        'Compute $x-y=1-0=1$.',
        'slope_field_construct', ARRAY['slope_field_construct', 'evaluate_derivative_at_point'], ARRAY['slope_field_axis_mixup', 'invert_derivative'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_11_slopefield_candidates.png'
    );

    -- U7-UT-Q13
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q13', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'In file $u7_7_13_slopefield_xy_candidates.png$ for $\\frac{dy}{dx}=xy$, which labeled curve matches $y(0)=1$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "Curve A", "explanation": "Starts at a different $y$-value when $x=0$."},
            {"id": "B", "value": "Curve B", "explanation": "Correct: passes through $(0,1)$ and is tangent to the field."},
            {"id": "C", "value": "Curve C", "explanation": "Starts at a different $y$-value when $x=0$."},
            {"id": "D", "value": "All three curves", "explanation": "Different initial conditions give different curves."}
        ]'::jsonb, 'B',
        'The point $(0,1)$ is marked, and Curve B passes through it while following the direction segments.',
        'slope_field_solution_curve', ARRAY['slope_field_solution_curve', 'identify_initial_condition'], ARRAY['solution_curve_not_tangent', 'initial_condition_misread'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_13_slopefield_xy_candidates.png'
    );

    -- U7-UT-Q14
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q14', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'For the \\\\\\\\logistic differential equation $\\frac{dP}{dt}=kP\\left(1-\\frac{P}{K}\\right)$ with $k>0$ and $K>0$, which equilibrium solutions are always present?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$P=0$ only", "explanation": "Misses the equilibrium at $P=K$."},
            {"id": "B", "value": "$P=K$ only", "explanation": "Misses the equilibrium at $P=0$."},
            {"id": "C", "value": "$P=0$ and $P=K$", "explanation": "Correct: both factors can make the rate zero."},
            {"id": "D", "value": "No equilibria", "explanation": "Equilibria exist when the rate can be zero."}
        ]'::jsonb, 'C',
        'Set $\\frac{dP}{dt}=0$: either $P=0$ or $1-\\frac{P}{K}=0$ giving $P=K$.',
        'equilibrium_solutions', ARRAY['equilibrium_solutions', 'qualitative_behavior'], ARRAY['equilibrium_missed', 'lost_solution_dividing_by_expression'],
        NOW(), NOW(), 'published', 1
    );

    -- U7-UT-Q15
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q15', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'Use the sign chart in file $u7_7_9_logistic_sign_table.png$ for $\\frac{dP}{dt}=0.2P\\left(1-\\frac{P}{500}\\right)$. Which equilibrium is stable for nearby positive populations?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$P=0$ only", "explanation": "Near $0$ (positive), the rate is positive, so solutions move away from $0$."},
            {"id": "B", "value": "$P=500$ only", "explanation": "Correct: the flow is toward $500$ from both sides."},
            {"id": "C", "value": "Both $P=0$ and $P=500$", "explanation": "$P=0$ is not attracting for positive initial values here."},
            {"id": "D", "value": "Neither is stable", "explanation": "The sign pattern shows $500$ is attracting."}
        ]'::jsonb, 'B',
        'For $0<P<500$, $\\frac{dP}{dt}>0$ (moves up); for $P>500$, $\\frac{dP}{dt}<0$ (moves down). Both move toward $500$.',
        'equilibrium_solutions', ARRAY['equilibrium_solutions', '\\interpret_in_context'], ARRAY['equilibrium_missed', 'confuse_slope_with_yvalue'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_9_logistic_sign_table.png'
    );

    -- U7-UT-Q16
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q16', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 3,
        'Use the graph in file $u7_7_9_logistic_curve.png$. Which statement best describes the long-term behavior of $y(t)$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$y(t)$ increases without bound.", "explanation": "Logistic-type growth levels off."},
            {"id": "B", "value": "$y(t)$ approaches a horizontal asymptote (levels off).", "explanation": "Correct: the graph approaches a constant level."},
            {"id": "C", "value": "$y(t)$ oscillates around a constant value.", "explanation": "No oscillation is shown."},
            {"id": "D", "value": "$y(t)$ decreases to $0$.", "explanation": "The graph is increasing, not decreasing."}
        ]'::jsonb, 'B',
        'The curve rises and then levels off toward a constant value, indicating approach to a carrying capacity.',
        'qualitative_behavior', ARRAY['qualitative_behavior', '\\interpret_in_context'], ARRAY['wrong_k_interpretation', 'confuse_slope_with_yvalue'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_9_logistic_curve.png'
    );

    -- U7-UT-Q17
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q17', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'Use the data in file $u7_7_14_decay_table.png$. Assume $A(t)$ follows $\\frac{dA}{dt}=kA$. Which value of $k$ is most consistent with the table?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$k=\\frac{\\ln(0.8)}{2}$", "explanation": "Correct: uses exponential ratio and divides by $2$ hours."},
            {"id": "B", "value": "$k=\\frac{0.8}{2}$", "explanation": "Uses a linear change idea instead of exponential."},
            {"id": "C", "value": "$k=\\ln(0.8)$", "explanation": "Forgets to divide by the time interval."},
            {"id": "D", "value": "$k=-\\frac{\\ln(0.8)}{2}$", "explanation": "Wrong sign; since $0.8<1$, $k$ must be negative."}
        ]'::jsonb, 'A',
        'From $t=0$ to $t=2$, the ratio is $\\frac{64}{80}=0.8$. With $A(t)=A(0)e^{kt}$, $0.8=e^{2k}$ so $k=\\frac{\\\\\\\\ln(0.8)}{2}$.',
        'estimate_parameter_from_data', ARRAY['estimate_parameter_from_data', 'exponential_de_model'], ARRAY['parameter_from_data_error', 'wrong_k_interpretation'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_14_decay_table.png'
    );

    -- U7-UT-Q18
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q18', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'Use the Euler-method table in file $u7_ut_euler_table.png$ for $\\frac{dy}{dx}=x+y$ with $y(0)=1$ and step size $h=0.5$. What is the Euler approximation for $y(1)$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$1.5$", "explanation": "That is the value after the first step at $x=0.5$."},
            {"id": "B", "value": "$2.0$", "explanation": "Not consistent with the computed updates in the table."},
            {"id": "C", "value": "$2.5$", "explanation": "Correct: after two steps the table gives $y(1)\\approx 2.5$."},
            {"id": "D", "value": "$3.0$", "explanation": "Overestimates relative to the listed Euler updates."}
        ]'::jsonb, 'C',
        'The table shows two steps from $x=0$ to $x=1.0$, and the final value is $y_2=2.5$.',
        '\\interpret_in_context', ARRAY['\\interpret_in_context', 'qualitative_behavior'], ARRAY['units_mismatch_or_ignored', 'parameter_from_data_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_ut_euler_table.png'
    );

    -- U7-UT-Q19
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U7-UT-Q19', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', true, 4,
        'Use the data in file $u7_7_12_pop_table.png$. The population is leveling off. Which statement is most reasonable about the rate of change $\\frac{dP}{dt}$ at later times?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{dP}{dt}$ stays constant and positive.", "explanation": "A constant positive rate would not level off."},
            {"id": "B", "value": "$\\frac{dP}{dt}$ is still positive but getting closer to $0$.", "explanation": "Correct: growth continues but slows as it approaches a limit."},
            {"id": "C", "value": "$\\frac{dP}{dt}$ must be negative.", "explanation": "The table shows increasing values, not decreasing."},
            {"id": "D", "value": "$\\frac{dP}{dt}$ must be exactly $0$ for all later times.", "explanation": "A leveling trend does not imply the rate is identically zero immediately."}
        ]'::jsonb, 'B',
        'Leveling off suggests the population is still increasing but more slowly, so $\\frac{dP}{dt}>0$ while decreasing toward $0$.',
        'qualitative_behavior', ARRAY['qualitative_behavior', '\\interpret_in_context'], ARRAY['wrong_k_interpretation', 'units_mismatch_or_ignored'],
        NOW(), NOW(), 'published', 1, 'Uses image file: u7_7_12_pop_table.png'
    );

    -- U7-UT-Q20
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U7-UT-Q20', 'Both', 'Both_DiffEq', 'Both_DiffEq', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'A cup of coffee cools at a rate proportional to the difference between its temperature $T(t)$ and the room temperature $T_r$ (a constant). Which differential equation best models this situation?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{dT}{dt}=k(T-T_r)$ with $k>0$", "explanation": "Wrong sign: if $T>T_r$ this would make $\\frac{dT}{dt}>0$."},
            {"id": "B", "value": "$\\frac{dT}{dt}=-k(T-T_r)$ with $k>0$", "explanation": "Correct: negative sign makes the temperature move toward $T_r$."},
            {"id": "C", "value": "$\\frac{dT}{dt}=kT_r$ with $k>0$", "explanation": "Does not depend on the temperature difference."},
            {"id": "D", "value": "$\\frac{dT}{dt}=-kT$ with $k>0$", "explanation": "Forgets the room temperature shift $T_r$."}
        ]'::jsonb, 'B',
        'Cooling means if $T>T_r$ then $\\frac{dT}{dt}<0$, so the model must be $\\frac{dT}{dt}=-k(T-T_r)$ with $k>0$.',
        'model_from_context_rate', ARRAY['model_from_context_rate', '\\interpret_in_context'], ARRAY['wrong_dependency_in_model', 'sign_error_in_rate'],
        NOW(), NOW(), 'published', 1
    );

END $$;
