-- Unit 7 Comprehensive Audit & LaTeX Repair
BEGIN;
INSERT INTO skills (id, name, unit) VALUES ('separate_variables', 'separate_variables', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('integrate_both_sides', 'integrate_both_sides', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('interpret_in_context', 'interpret_in_context', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('solve_for_constant_using_ic', 'solve_for_constant_using_ic', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('equilibrium_solutions', 'equilibrium_solutions', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('qualitative_behavior', 'qualitative_behavior', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('logistic_growth_model', 'logistic_growth_model', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('separate_variables_and_ic', 'separate_variables_and_ic', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('verify_by_substitution', 'verify_by_substitution', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('slope_field_interpretation', 'slope_field_interpretation', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('slope_field_solution_curve', 'slope_field_solution_curve', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('eulers_method_approximation', 'eulers_method_approximation', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('estimate_parameter_from_data', 'estimate_parameter_from_data', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('exponential_de_model', 'exponential_de_model', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('model_from_context_rate', 'model_from_context_rate', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('units_mismatch_or_ignored', 'units_mismatch_or_ignored', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('identify_initial_condition', 'identify_initial_condition', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('differential_equation_basics', 'differential_equation_basics', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('evaluate_derivative_at_point', 'evaluate_derivative_at_point', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('euler_step_size_modeling', 'euler_step_size_modeling', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('implicit_to_explicit', 'implicit_to_explicit', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('slope_field_construct', 'slope_field_construct', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('slope_field_sketching_solutions', 'slope_field_sketching_solutions', 'Differential_Equations') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('variables_not_fully_separated', 'variables_not_fully_separated') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('algebra_error_during_separation', 'algebra_error_during_separation') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('constant_solve_error_with_ic', 'constant_solve_error_with_ic') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('missing_constant_of_integration', 'missing_constant_of_integration') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('equilibrium_missed', 'equilibrium_missed') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('lost_solution_dividing_by_expression', 'lost_solution_dividing_by_expression') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('antiderivative_error', 'antiderivative_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('verification_not_global', 'verification_not_global') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('substitution_error_in_verification', 'substitution_error_in_verification') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('solution_curve_not_tangent', 'solution_curve_not_tangent') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('parameter_from_data_error', 'parameter_from_data_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('wrong_k_interpretation', 'wrong_k_interpretation') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('wrong_dependency_in_model', 'wrong_dependency_in_model') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('sign_error_in_rate', 'sign_error_in_rate') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('units_mismatch_or_ignored', 'units_mismatch_or_ignored') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('initial_condition_misread', 'initial_condition_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_to_explicit_algebra_error', 'implicit_to_explicit_algebra_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('missing_abs_in_log', 'missing_abs_in_log') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('derivative_computation_error', 'derivative_computation_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('slope_field_axis_mixup', 'slope_field_axis_mixup') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('invert_derivative', 'invert_derivative') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('confuse_slope_with_yvalue', 'confuse_slope_with_yvalue') ON CONFLICT (id) DO NOTHING;
DELETE FROM question_skills WHERE question_id = '0012d0cc-e291-467a-98b5-6d88fa1a2871';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0012d0cc-e291-467a-98b5-6d88fa1a2871', 'separate_variables', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0012d0cc-e291-467a-98b5-6d88fa1a2871', 'integrate_both_sides', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'separate_variables', 
    supporting_skill_ids = '{"integrate_both_sides"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"separate_variables","integrate_both_sides"}', 
    error_tags = '{"variables_not_fully_separated","algebra_error_during_separation"}', 
    options = '[{"id":"A","value":"$y\\,dy=x^2\\,dx$","explanation":"Correct: all $y$ terms are with $dy$ and all $x$ terms with $dx$."},{"id":"B","value":"$\\frac{1}{y}\\,dy=x^2\\,dx$","explanation":"Keeps $y$ in the denominator on the left incorrectly after moving terms."},{"id":"C","value":"$y\\,dy=\\frac{1}{x^2}\\,dx$","explanation":"Inverts $x^2$ incorrectly."},{"id":"D","value":"$dy=xy\\,dx$","explanation":"Does not match the original equation."}]',
    updated_at = NOW() 
WHERE id = '0012d0cc-e291-467a-98b5-6d88fa1a2871';
DELETE FROM question_skills WHERE question_id = '0080dcce-a0de-413a-88ed-331e3e221cc8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0080dcce-a0de-413a-88ed-331e3e221cc8', 'separate_variables', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0080dcce-a0de-413a-88ed-331e3e221cc8', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'separate_variables', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"separate_variables","interpret_in_context"}', 
    error_tags = '{"variables_not_fully_separated","algebra_error_during_separation"}', 
    options = '[{"id":"A","value":"Write $\\frac{1}{y}\\,dy=x\\,dx$","explanation":"Correct: variables are separated with $y$ on the left and $x$ on the right."},{"id":"B","value":"Write $\\frac{1}{x}\\,dx=y\\,dy$","explanation":"Mixes up which variable to isolate."},{"id":"C","value":"Write $y\\,dy=x\\,dx$","explanation":"Does not fully separate because $y$ is still on the left but not isolated properly for the given DE."},{"id":"D","value":"Write $\\ln y=x^2$ immediately","explanation":"You must separate and integrate first."}]',
    updated_at = NOW() 
WHERE id = '0080dcce-a0de-413a-88ed-331e3e221cc8';
DELETE FROM question_skills WHERE question_id = '0c01734f-e00f-4327-bbed-c6fe00c87d9e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0c01734f-e00f-4327-bbed-c6fe00c87d9e', 'solve_for_constant_using_ic', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0c01734f-e00f-4327-bbed-c6fe00c87d9e', 'integrate_both_sides', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'solve_for_constant_using_ic', 
    supporting_skill_ids = '{"integrate_both_sides"}', 
    target_time_seconds = 210, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"solve_for_constant_using_ic","integrate_both_sides"}', 
    error_tags = '{"constant_solve_error_with_ic","missing_constant_of_integration"}', 
    options = '[{"id":"A","value":"$C=\\ln 2$","explanation":"Correct: $C=\\ln 2$."},{"id":"B","value":"$C=2$","explanation":"Confuses $\\ln 2$ with $2$."},{"id":"C","value":"$C=\\frac{\\ln 2}{2}$","explanation":"Unjustified division by $2$."},{"id":"D","value":"$C=-\\ln 2$","explanation":"Wrong sign."}]',
    updated_at = NOW() 
WHERE id = '0c01734f-e00f-4327-bbed-c6fe00c87d9e';
DELETE FROM question_skills WHERE question_id = '0e923b8f-3402-405c-aca3-58cdeac9e4c1';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0e923b8f-3402-405c-aca3-58cdeac9e4c1', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0e923b8f-3402-405c-aca3-58cdeac9e4c1', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0e923b8f-3402-405c-aca3-58cdeac9e4c1', 'logistic_growth_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'logistic_growth_model', 
    supporting_skill_ids = '{"equilibrium_solutions","qualitative_behavior"}', 
    target_time_seconds = 210, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Correct. This follows the principles for solving or interpreting differential equations.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"equilibrium_solutions","qualitative_behavior","logistic_growth_model"}', 
    error_tags = '{"equilibrium_missed","lost_solution_dividing_by_expression"}', 
    options = '[{"id":"A","value":"$P=0$ only","explanation":"Misses the factor $1-\\frac{P}{K}=0$ at $P=K$."},{"id":"B","value":"$P=K$ only","explanation":"Misses $P=0$, which makes the right side zero."},{"id":"C","value":"$P=0$ and $P=K$","explanation":"Correct: both are roots of the right-hand side."},{"id":"D","value":"No equilibria because $P$ changes with $t$","explanation":"Equilibria are constant solutions where the rate is zero."}]',
    updated_at = NOW() 
WHERE id = '0e923b8f-3402-405c-aca3-58cdeac9e4c1';
DELETE FROM question_skills WHERE question_id = '17785bcb-75a1-48ae-987e-1012554e7af4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('17785bcb-75a1-48ae-987e-1012554e7af4', 'integrate_both_sides', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('17785bcb-75a1-48ae-987e-1012554e7af4', 'separate_variables', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables', 
    supporting_skill_ids = '{"integrate_both_sides"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"integrate_both_sides","separate_variables"}', 
    error_tags = '{"antiderivative_error","missing_constant_of_integration"}', 
    options = '[{"id":"A","value":"$y=Ce^{\\frac{3}{2}x^2}$","explanation":"Correct: exponent comes from integrating $3x$."},{"id":"B","value":"$y=Ce^{3x}$","explanation":"Uses $3x$ instead of $\\frac{3}{2}x^2$ in the exponent."},{"id":"C","value":"$y=\\frac{3}{2}x^2+C$","explanation":"Treats $y''$ like $y$ and integrates incorrectly."},{"id":"D","value":"$y=Cx^3$","explanation":"Not consistent with exponential growth in $x^2$."}]',
    updated_at = NOW() 
WHERE id = '17785bcb-75a1-48ae-987e-1012554e7af4';
DELETE FROM question_skills WHERE question_id = '177a2c28-afde-4559-b1e5-4fda248230e3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('177a2c28-afde-4559-b1e5-4fda248230e3', 'integrate_both_sides', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('177a2c28-afde-4559-b1e5-4fda248230e3', 'solve_for_constant_using_ic', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('177a2c28-afde-4559-b1e5-4fda248230e3', 'separate_variables_and_ic', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables_and_ic', 
    supporting_skill_ids = '{"integrate_both_sides","solve_for_constant_using_ic"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"integrate_both_sides","solve_for_constant_using_ic","separate_variables_and_ic"}', 
    error_tags = '{"antiderivative_error","constant_solve_error_with_ic"}', 
    options = '[{"id":"A","value":"$y=3x^2$","explanation":"Correct: gives $y=Cx^2$ and matches $y(1)=3$."},{"id":"B","value":"$y=3x$","explanation":"Would correspond to $\\frac{dy}{dx}=\\frac{1}{x}y$."},{"id":"C","value":"$y=3e^{2x}$","explanation":"Solves $y''=2y$, not $y''=\\frac{2}{x}y$."},{"id":"D","value":"$y=\\frac{3}{x^2}$","explanation":"Wrong power; would satisfy $\\frac{dy}{dx}=-\\frac{2}{x}y$."}]',
    updated_at = NOW() 
WHERE id = '177a2c28-afde-4559-b1e5-4fda248230e3';
DELETE FROM question_skills WHERE question_id = '18da3d50-8b52-423f-b132-0973ba18f2f8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('18da3d50-8b52-423f-b132-0973ba18f2f8', 'verify_by_substitution', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('18da3d50-8b52-423f-b132-0973ba18f2f8', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('18da3d50-8b52-423f-b132-0973ba18f2f8', 'slope_field_interpretation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_interpretation', 
    supporting_skill_ids = '{"verify_by_substitution","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","B":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"verify_by_substitution","interpret_in_context","slope_field_interpretation"}', 
    error_tags = '{"verification_not_global","substitution_error_in_verification"}', 
    options = '[{"id":"A","value":"The equation is true at one convenient point.","explanation":"Checking one point is not enough for a differential equation solution."},{"id":"B","value":"After computing $f''(x)$ and substituting, the equation holds for all $x$ in the interval where both sides are defined.","explanation":"Correct: it must hold for all valid $x$ in the interval."},{"id":"C","value":"The function is increasing everywhere on the interval.","explanation":"Monotonicity is not the definition of a solution."},{"id":"D","value":"The function can be written in explicit form.","explanation":"Solutions can be implicit; explicit form is not required."}]',
    updated_at = NOW() 
WHERE id = '18da3d50-8b52-423f-b132-0973ba18f2f8';
DELETE FROM question_skills WHERE question_id = '2251917e-f73b-4ef9-83fb-4f247f652734';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2251917e-f73b-4ef9-83fb-4f247f652734', 'slope_field_solution_curve', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2251917e-f73b-4ef9-83fb-4f247f652734', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2251917e-f73b-4ef9-83fb-4f247f652734', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2251917e-f73b-4ef9-83fb-4f247f652734', 'eulers_method_approximation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'eulers_method_approximation', 
    supporting_skill_ids = '{"slope_field_solution_curve","qualitative_behavior","equilibrium_solutions"}', 
    target_time_seconds = 210, 
    weight_primary = 0.6, 
    weight_supporting = 0.4, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"slope_field_solution_curve","qualitative_behavior","equilibrium_solutions","eulers_method_approximation"}', 
    error_tags = '{"solution_curve_not_tangent","equilibrium_missed"}', 
    options = '[{"id":"A","value":"It increases without bound.","explanation":"For $y>1$, slopes are negative, so it does not increase."},{"id":"B","value":"It decreases toward $y=1$.","explanation":"Correct: it moves down toward $y=1$."},{"id":"C","value":"It stays at $y=2$ for all $x$.","explanation":"Only equilibrium solutions stay constant; $y=2$ is not an equilibrium."},{"id":"D","value":"It decreases toward $y=0$.","explanation":"The field indicates $y=1$ is the attracting level, not $y=0$ for this start."}]',
    updated_at = NOW() 
WHERE id = '2251917e-f73b-4ef9-83fb-4f247f652734';
DELETE FROM question_skills WHERE question_id = '2582d2df-1b90-4ece-b829-a57fd20ee833';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2582d2df-1b90-4ece-b829-a57fd20ee833', 'estimate_parameter_from_data', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2582d2df-1b90-4ece-b829-a57fd20ee833', 'exponential_de_model', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'estimate_parameter_from_data', 
    supporting_skill_ids = '{"exponential_de_model"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"estimate_parameter_from_data","exponential_de_model"}', 
    error_tags = '{"parameter_from_data_error","wrong_k_interpretation"}', 
    options = '[{"id":"A","value":"$k=\\frac{\\ln 2}{5}$","explanation":"Correct: $e^{5k}=2$."},{"id":"B","value":"$k=\\frac{2}{5}$","explanation":"Treats growth as linear."},{"id":"C","value":"$k=\\ln 2$","explanation":"Forgets to divide by $5$ hours."},{"id":"D","value":"$k=-\\frac{\\ln 2}{5}$","explanation":"Wrong sign; doubling indicates growth."}]',
    updated_at = NOW() 
WHERE id = '2582d2df-1b90-4ece-b829-a57fd20ee833';
DELETE FROM question_skills WHERE question_id = '26751124-e856-4c63-9d30-95808c4da0cd';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('26751124-e856-4c63-9d30-95808c4da0cd', 'model_from_context_rate', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('26751124-e856-4c63-9d30-95808c4da0cd', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'model_from_context_rate', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 210, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"model_from_context_rate","interpret_in_context"}', 
    error_tags = '{"wrong_dependency_in_model","sign_error_in_rate"}', 
    options = '[{"id":"A","value":"$\\frac{dT}{dt}=k(T-T_r)$ with $k>0$","explanation":"Wrong sign: if $T>T_r$ this would make $\\frac{dT}{dt}>0$."},{"id":"B","value":"$\\frac{dT}{dt}=-k(T-T_r)$ with $k>0$","explanation":"Correct: negative sign makes the temperature move toward $T_r$."},{"id":"C","value":"$\\frac{dT}{dt}=kT_r$ with $k>0$","explanation":"Does not depend on the temperature difference."},{"id":"D","value":"$\\frac{dT}{dt}=-kT$ with $k>0$","explanation":"Forgets the room temperature shift $T_r$."}]',
    updated_at = NOW() 
WHERE id = '26751124-e856-4c63-9d30-95808c4da0cd';
DELETE FROM question_skills WHERE question_id = '2ab50910-fd85-4325-9555-0c09b4f2b8b3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ab50910-fd85-4325-9555-0c09b4f2b8b3', 'exponential_de_model', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ab50910-fd85-4325-9555-0c09b4f2b8b3', 'solve_for_constant_using_ic', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'exponential_de_model', 
    supporting_skill_ids = '{"solve_for_constant_using_ic"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"exponential_de_model","solve_for_constant_using_ic"}', 
    error_tags = '{"wrong_k_interpretation","constant_solve_error_with_ic"}', 
    options = '[{"id":"A","value":"$k=\\frac{\\ln 2}{5}$","explanation":"Correct: uses $e^{5k}=2$."},{"id":"B","value":"$k=\\frac{2}{5}$","explanation":"Treats growth as linear doubling."},{"id":"C","value":"$k=\\ln 2$","explanation":"Forgets to divide by $5$."},{"id":"D","value":"$k=-\\frac{\\ln 2}{5}$","explanation":"Wrong sign: the quantity increases from $12$ to $24$."}]',
    updated_at = NOW() 
WHERE id = '2ab50910-fd85-4325-9555-0c09b4f2b8b3';
DELETE FROM question_skills WHERE question_id = '343860ca-2242-4961-a770-3245dec9450c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('343860ca-2242-4961-a770-3245dec9450c', 'model_from_context_rate', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('343860ca-2242-4961-a770-3245dec9450c', 'units_mismatch_or_ignored', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('343860ca-2242-4961-a770-3245dec9450c', 'logistic_growth_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'logistic_growth_model', 
    supporting_skill_ids = '{"model_from_context_rate","units_mismatch_or_ignored"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Correct. This follows the principles for solving or interpreting differential equations.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"model_from_context_rate","units_mismatch_or_ignored","logistic_growth_model"}', 
    error_tags = '{"wrong_dependency_in_model","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$\\frac{dP}{dt}=kP$ with $k>0$","explanation":"Exponential growth does not include a carrying capacity."},{"id":"B","value":"$\\frac{dP}{dt}=k$ with $k>0$","explanation":"Constant rate gives linear growth, not leveling off."},{"id":"C","value":"$\\frac{dP}{dt}=kP\\left(1-\\frac{P}{K}\\right)$ with $k>0$","explanation":"Correct: growth slows when $P$ is near $K$."},{"id":"D","value":"$\\frac{dP}{dt}=-kP$ with $k>0$","explanation":"This models decay, not growth."}]',
    updated_at = NOW() 
WHERE id = '343860ca-2242-4961-a770-3245dec9450c';
DELETE FROM question_skills WHERE question_id = '3c939d8b-af89-4b07-8f27-b0bc5b32393f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3c939d8b-af89-4b07-8f27-b0bc5b32393f', 'equilibrium_solutions', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3c939d8b-af89-4b07-8f27-b0bc5b32393f', 'qualitative_behavior', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'equilibrium_solutions', 
    supporting_skill_ids = '{"qualitative_behavior"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Correct. This follows the principles for solving or interpreting differential equations.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"equilibrium_solutions","qualitative_behavior"}', 
    error_tags = '{"equilibrium_missed","lost_solution_dividing_by_expression"}', 
    options = '[{"id":"A","value":"$P=0$ only","explanation":"Misses the equilibrium at $P=K$."},{"id":"B","value":"$P=K$ only","explanation":"Misses the equilibrium at $P=0$."},{"id":"C","value":"$P=0$ and $P=K$","explanation":"Correct: both factors can make the rate zero."},{"id":"D","value":"No equilibria","explanation":"Equilibria exist when the rate can be zero."}]',
    updated_at = NOW() 
WHERE id = '3c939d8b-af89-4b07-8f27-b0bc5b32393f';
DELETE FROM question_skills WHERE question_id = '3f6ac70c-f6c6-46fb-babe-76094ded8654';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3f6ac70c-f6c6-46fb-babe-76094ded8654', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3f6ac70c-f6c6-46fb-babe-76094ded8654', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3f6ac70c-f6c6-46fb-babe-76094ded8654', 'differential_equation_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'differential_equation_basics', 
    supporting_skill_ids = '{"identify_initial_condition","interpret_in_context"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"identify_initial_condition","interpret_in_context","differential_equation_basics"}', 
    error_tags = '{"initial_condition_misread","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$y(30)=0$","explanation":"Swaps the input and output values."},{"id":"B","value":"$y(0)=30$","explanation":"Correct: at $t=0$, the amount is $30$."},{"id":"C","value":"$y(30)=30$","explanation":"Uses $t=30$ instead of $t=0$."},{"id":"D","value":"$y''(0)=30$","explanation":"This gives a starting rate, not the starting amount."}]',
    updated_at = NOW() 
WHERE id = '3f6ac70c-f6c6-46fb-babe-76094ded8654';
DELETE FROM question_skills WHERE question_id = '44be7b91-8d7b-41b6-bd2f-0cba68e75d42';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('44be7b91-8d7b-41b6-bd2f-0cba68e75d42', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('44be7b91-8d7b-41b6-bd2f-0cba68e75d42', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('44be7b91-8d7b-41b6-bd2f-0cba68e75d42', 'separate_variables_and_ic', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables_and_ic', 
    supporting_skill_ids = '{"identify_initial_condition","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","B":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"identify_initial_condition","interpret_in_context","separate_variables_and_ic"}', 
    error_tags = '{"initial_condition_misread","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$T(80)=10$","explanation":"Swaps input and output."},{"id":"B","value":"$T(10)=80$","explanation":"Correct: temperature at $t=10$ is $80$."},{"id":"C","value":"$T''(10)=80$","explanation":"This would be a rate of change at $t=10$."},{"id":"D","value":"$T''(80)=10$","explanation":"Mixes time and temperature in the derivative statement."}]',
    updated_at = NOW() 
WHERE id = '44be7b91-8d7b-41b6-bd2f-0cba68e75d42';
DELETE FROM question_skills WHERE question_id = '45d9bc53-5afc-4f55-bc35-ebbf25dba13e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('45d9bc53-5afc-4f55-bc35-ebbf25dba13e', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('45d9bc53-5afc-4f55-bc35-ebbf25dba13e', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('45d9bc53-5afc-4f55-bc35-ebbf25dba13e', 'euler_step_size_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'euler_step_size_modeling', 
    supporting_skill_ids = '{"identify_initial_condition","evaluate_derivative_at_point"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","B":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"identify_initial_condition","evaluate_derivative_at_point","euler_step_size_modeling"}', 
    error_tags = '{"initial_condition_misread","sign_error_in_rate"}', 
    options = '[{"id":"A","value":"$18$","explanation":"Correct: the second Euler update gives $18$."},{"id":"B","value":"$20$","explanation":"Common arithmetic slip from $30-12$."},{"id":"C","value":"$30$","explanation":"This is $y_1$, not $y_2$."},{"id":"D","value":"$50$","explanation":"This is the initial value $y_0$."}]',
    updated_at = NOW() 
WHERE id = '45d9bc53-5afc-4f55-bc35-ebbf25dba13e';
DELETE FROM question_skills WHERE question_id = '472264dc-3c8b-491d-a714-6738bccc26f8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('472264dc-3c8b-491d-a714-6738bccc26f8', 'implicit_to_explicit', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('472264dc-3c8b-491d-a714-6738bccc26f8', 'integrate_both_sides', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('472264dc-3c8b-491d-a714-6738bccc26f8', 'separate_variables', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables', 
    supporting_skill_ids = '{"implicit_to_explicit","integrate_both_sides"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"implicit_to_explicit","integrate_both_sides","separate_variables"}', 
    error_tags = '{"implicit_to_explicit_algebra_error","missing_abs_in_log"}', 
    options = '[{"id":"A","value":"$y=Ce^{x^2}$","explanation":"Correct: exponentiating produces a multiplicative constant."},{"id":"B","value":"$y=x^2+C$","explanation":"Does not undo the logarithm correctly."},{"id":"C","value":"$y=\\ln|x^2|+C$","explanation":"Changes the inside of the logarithm and the variable."},{"id":"D","value":"$y=e^{x^2}+C$","explanation":"Adds the constant after exponentiating instead of multiplying."}]',
    updated_at = NOW() 
WHERE id = '472264dc-3c8b-491d-a714-6738bccc26f8';
DELETE FROM question_skills WHERE question_id = '4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68', 'integrate_both_sides', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68', 'separate_variables', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'integrate_both_sides', 
    supporting_skill_ids = '{"separate_variables"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"integrate_both_sides","separate_variables"}', 
    error_tags = '{"antiderivative_error","missing_abs_in_log"}', 
    options = '[{"id":"A","value":"$\\ln|y|=\\frac{x^2}{2}+C$","explanation":"Correct: includes $\\ln|y|$, $\\frac{x^2}{2}$, and $+C$."},{"id":"B","value":"$\\ln y=\\frac{x^2}{2}$","explanation":"Missing $|\\cdot|$ and missing $+C$."},{"id":"C","value":"$\\frac{1}{y}=\\frac{x^2}{2}+C$","explanation":"Incorrect antiderivative of $\\frac{1}{y}$."},{"id":"D","value":"$\\ln|y|=x^2+C$","explanation":"Incorrect antiderivative of $x$ (should be $\\frac{x^2}{2}$)."}]',
    updated_at = NOW() 
WHERE id = '4d6ae2c6-93a4-4a6f-85f0-3d30b41d2e68';
DELETE FROM question_skills WHERE question_id = '519452b6-7812-47b0-b6b9-f0aa3f44fe36';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('519452b6-7812-47b0-b6b9-f0aa3f44fe36', 'model_from_context_rate', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('519452b6-7812-47b0-b6b9-f0aa3f44fe36', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'model_from_context_rate', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"model_from_context_rate","interpret_in_context"}', 
    error_tags = '{"sign_error_in_rate","wrong_dependency_in_model"}', 
    options = '[{"id":"A","value":"$\\frac{dA}{dt}=kA$ with $k>0$","explanation":"Wrong sign; this would increase when $A>0$."},{"id":"B","value":"$\\frac{dA}{dt}=-kA$ with $k>0$","explanation":"Correct: negative proportional rate gives decay."},{"id":"C","value":"$\\frac{dA}{dt}=k$ with $k>0$","explanation":"Not proportional to $A$."},{"id":"D","value":"$\\frac{dA}{dt}=\\frac{k}{A}$ with $k>0$","explanation":"Inverse dependence is not proportional to the amount present."}]',
    updated_at = NOW() 
WHERE id = '519452b6-7812-47b0-b6b9-f0aa3f44fe36';
DELETE FROM question_skills WHERE question_id = '52e3c523-69a2-4dbc-a166-174a0a01ab9d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('52e3c523-69a2-4dbc-a166-174a0a01ab9d', 'exponential_de_model', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('52e3c523-69a2-4dbc-a166-174a0a01ab9d', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'exponential_de_model', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"exponential_de_model","interpret_in_context"}', 
    error_tags = '{"wrong_k_interpretation","sign_error_in_rate"}', 
    options = '[{"id":"A","value":"$y(t)$ increases for all $t$.","explanation":"That would require $k>0$ when $y>0$."},{"id":"B","value":"$y(t)$ decreases for all $t$.","explanation":"Correct: negative rate implies decreasing."},{"id":"C","value":"$y(t)$ is constant for all $t$.","explanation":"Only if $k=0$."},{"id":"D","value":"$y(t)$ must become negative.","explanation":"Decay can approach $0$ without becoming negative."}]',
    updated_at = NOW() 
WHERE id = '52e3c523-69a2-4dbc-a166-174a0a01ab9d';
DELETE FROM question_skills WHERE question_id = '5324f337-963b-4a8c-a9e4-8be0df4cd6e0';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5324f337-963b-4a8c-a9e4-8be0df4cd6e0', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5324f337-963b-4a8c-a9e4-8be0df4cd6e0', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5324f337-963b-4a8c-a9e4-8be0df4cd6e0', 'euler_step_size_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'euler_step_size_modeling', 
    supporting_skill_ids = '{"interpret_in_context","evaluate_derivative_at_point"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"interpret_in_context","evaluate_derivative_at_point","euler_step_size_modeling"}', 
    error_tags = '{"verification_not_global","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"A secant line through two known solution points","explanation":"Euler uses a slope from the differential equation at one point, not a secant slope."},{"id":"B","value":"A tangent-line (local linear) approximation using the slope at $\\left(t_n,y_n\\right)$","explanation":"Correct: it uses the slope at $\\left(t_n,y_n\\right)$."},{"id":"C","value":"An exact antiderivative found by separation of variables","explanation":"Euler is numerical; it does not require an exact integral."},{"id":"D","value":"A slope field that forces the curve to be horizontal","explanation":"A slope field does not force horizontal motion everywhere."}]',
    updated_at = NOW() 
WHERE id = '5324f337-963b-4a8c-a9e4-8be0df4cd6e0';
DELETE FROM question_skills WHERE question_id = '536f4071-8710-49ae-acb2-2ded8272c83a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('536f4071-8710-49ae-acb2-2ded8272c83a', 'verify_by_substitution', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('536f4071-8710-49ae-acb2-2ded8272c83a', 'evaluate_derivative_at_point', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'verify_by_substitution', 
    supporting_skill_ids = '{"evaluate_derivative_at_point"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"verify_by_substitution","evaluate_derivative_at_point"}', 
    error_tags = '{"derivative_computation_error","substitution_error_in_verification"}', 
    options = '[{"id":"A","value":"$y''=Ce^{\\frac{x^2}{2}}$ so it does not match $xy$.","explanation":"Misses the chain rule factor $x$."},{"id":"B","value":"$y''=xCe^{\\frac{x^2}{2}}=xy$, so it is a solution.","explanation":"Correct: chain rule gives $y''=xy$."},{"id":"C","value":"$y''=\\frac{x^2}{2}Ce^{\\frac{x^2}{2}}$, so it is not a solution.","explanation":"Multiplies by the inside instead of differentiating it."},{"id":"D","value":"You cannot verify because $C$ is unknown.","explanation":"Verification works symbolically for any constant $C$."}]',
    updated_at = NOW() 
WHERE id = '536f4071-8710-49ae-acb2-2ded8272c83a';
DELETE FROM question_skills WHERE question_id = '538306cb-d42a-4efc-8876-a384d638b5c8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('538306cb-d42a-4efc-8876-a384d638b5c8', 'interpret_in_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('538306cb-d42a-4efc-8876-a384d638b5c8', 'qualitative_behavior', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'interpret_in_context', 
    supporting_skill_ids = '{"qualitative_behavior"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Correct. This follows the principles for solving or interpreting differential equations.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"interpret_in_context","qualitative_behavior"}', 
    error_tags = '{"units_mismatch_or_ignored","parameter_from_data_error"}', 
    options = '[{"id":"A","value":"$1.5$","explanation":"That is the value after the first step at $x=0.5$."},{"id":"B","value":"$2.0$","explanation":"Not consistent with the computed updates in the table."},{"id":"C","value":"$2.5$","explanation":"Correct: after two steps the table gives $y(1)\\approx 2.5$."},{"id":"D","value":"$3.0$","explanation":"Overestimates relative to the listed Euler updates."}]',
    updated_at = NOW() 
WHERE id = '538306cb-d42a-4efc-8876-a384d638b5c8';
DELETE FROM question_skills WHERE question_id = '5804e3a3-d1bf-4492-be1b-85ed1178e1e2';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5804e3a3-d1bf-4492-be1b-85ed1178e1e2', 'integrate_both_sides', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5804e3a3-d1bf-4492-be1b-85ed1178e1e2', 'separate_variables', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables', 
    supporting_skill_ids = '{"integrate_both_sides"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"integrate_both_sides","separate_variables"}', 
    error_tags = '{"antiderivative_error","missing_constant_of_integration"}', 
    options = '[{"id":"A","value":"$\\frac{1}{2}y^2=x+C$","explanation":"Correct: integrates to $\\frac{1}{2}y^2=x+C$."},{"id":"B","value":"$y=\\ln|x|+C$","explanation":"Integrates the wrong variable; $y$ is not $\\ln|x|$ here."},{"id":"C","value":"$\\ln|y|=x+C$","explanation":"Would correspond to $\\frac{dy}{dx}=y$, not $\\frac{1}{y}$."},{"id":"D","value":"$y^2=\\frac{1}{x}+C$","explanation":"Incorrect antiderivative of $1$ and wrong algebra."}]',
    updated_at = NOW() 
WHERE id = '5804e3a3-d1bf-4492-be1b-85ed1178e1e2';
DELETE FROM question_skills WHERE question_id = '5c35d208-6df2-4317-a62c-65bbe0e57970';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5c35d208-6df2-4317-a62c-65bbe0e57970', 'slope_field_solution_curve', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5c35d208-6df2-4317-a62c-65bbe0e57970', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5c35d208-6df2-4317-a62c-65bbe0e57970', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5c35d208-6df2-4317-a62c-65bbe0e57970', 'eulers_method_approximation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'eulers_method_approximation', 
    supporting_skill_ids = '{"slope_field_solution_curve","identify_initial_condition","evaluate_derivative_at_point"}', 
    target_time_seconds = 180, 
    weight_primary = 0.6, 
    weight_supporting = 0.4, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"slope_field_solution_curve","identify_initial_condition","evaluate_derivative_at_point","eulers_method_approximation"}', 
    error_tags = '{"solution_curve_not_tangent","initial_condition_misread"}', 
    options = '[{"id":"A","value":"Positive, because $x-y>0$","explanation":"Here $1-3<0$, so slope is not positive."},{"id":"B","value":"Negative, because $x-y<0$","explanation":"Correct: $1-3=-2<0$ gives a negative slope."},{"id":"C","value":"Zero, because $x=y$","explanation":"Slope is $0$ only when $x=y$; here $1\\neq 3$."},{"id":"D","value":"Undefined, because slope fields do not give slopes","explanation":"Slope fields show slopes at each point by direction segments."}]',
    updated_at = NOW() 
WHERE id = '5c35d208-6df2-4317-a62c-65bbe0e57970';
DELETE FROM question_skills WHERE question_id = '5d1ae77d-f99c-4d57-8a34-4ec2bf1372f2';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5d1ae77d-f99c-4d57-8a34-4ec2bf1372f2', 'slope_field_construct', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5d1ae77d-f99c-4d57-8a34-4ec2bf1372f2', 'evaluate_derivative_at_point', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'slope_field_construct', 
    supporting_skill_ids = '{"evaluate_derivative_at_point"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_construct","evaluate_derivative_at_point"}', 
    error_tags = '{"slope_field_axis_mixup","invert_derivative"}', 
    options = '[{"id":"A","value":"$-1$","explanation":"Uses $y-x$ or flips the subtraction."},{"id":"B","value":"$0$","explanation":"Slope is not zero here because $x\\neq y$."},{"id":"C","value":"$1$","explanation":"Correct: $1-0=1$."},{"id":"D","value":"$2$","explanation":"Adds instead of subtracting."}]',
    updated_at = NOW() 
WHERE id = '5d1ae77d-f99c-4d57-8a34-4ec2bf1372f2';
DELETE FROM question_skills WHERE question_id = '5ea5cae2-3aae-4de0-8e70-6a8c164f8203';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5ea5cae2-3aae-4de0-8e70-6a8c164f8203', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5ea5cae2-3aae-4de0-8e70-6a8c164f8203', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5ea5cae2-3aae-4de0-8e70-6a8c164f8203', 'logistic_growth_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'logistic_growth_model', 
    supporting_skill_ids = '{"interpret_in_context","equilibrium_solutions"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"interpret_in_context","equilibrium_solutions","logistic_growth_model"}', 
    error_tags = '{"wrong_k_interpretation","equilibrium_missed"}', 
    options = '[{"id":"A","value":"If $P(0)=600$, then $P(t)$ increases toward $500$.","explanation":"For $P>500$, the rate is negative, so it does not increase."},{"id":"B","value":"If $P(0)=600$, then $P(t)$ decreases toward $500$.","explanation":"Correct: negative rate for $P>500$ drives $P$ downward toward $500$."},{"id":"C","value":"If $P(0)=200$, then $P(t)$ decreases toward $0$.","explanation":"For $0<P<500$, the rate is positive, so it increases, not decreases."},{"id":"D","value":"There are no equilibrium solutions because the model is not linear.","explanation":"Equilibria occur where $\\frac{dP}{dt}=0$, regardless of linearity."}]',
    updated_at = NOW() 
WHERE id = '5ea5cae2-3aae-4de0-8e70-6a8c164f8203';
DELETE FROM question_skills WHERE question_id = '6652be9a-371e-442b-a7c2-aa4275d789b8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6652be9a-371e-442b-a7c2-aa4275d789b8', 'model_from_context_rate', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6652be9a-371e-442b-a7c2-aa4275d789b8', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6652be9a-371e-442b-a7c2-aa4275d789b8', 'differential_equation_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'differential_equation_basics', 
    supporting_skill_ids = '{"model_from_context_rate","interpret_in_context"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"model_from_context_rate","interpret_in_context","differential_equation_basics"}', 
    error_tags = '{"sign_error_in_rate","wrong_dependency_in_model"}', 
    options = '[{"id":"A","value":"$\\frac{dy}{dt}=ky$","explanation":"Wrong sign: this gives growth when $y>0$."},{"id":"B","value":"$\\frac{dy}{dt}=-ky$","explanation":"Correct: proportional to $y$ and negative for decay."},{"id":"C","value":"$\\frac{dy}{dt}=-k$","explanation":"Constant-rate change is not proportional to $y$."},{"id":"D","value":"$\\frac{dy}{dt}=\\frac{k}{y}$","explanation":"Inverse dependence is not proportional to $y$."}]',
    updated_at = NOW() 
WHERE id = '6652be9a-371e-442b-a7c2-aa4275d789b8';
DELETE FROM question_skills WHERE question_id = '6a1c14d9-bc6e-4211-8803-1b3bfa9f475a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6a1c14d9-bc6e-4211-8803-1b3bfa9f475a', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6a1c14d9-bc6e-4211-8803-1b3bfa9f475a', 'slope_field_construct', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6a1c14d9-bc6e-4211-8803-1b3bfa9f475a', 'slope_field_sketching_solutions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_sketching_solutions', 
    supporting_skill_ids = '{"equilibrium_solutions","slope_field_construct"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"equilibrium_solutions","slope_field_construct","slope_field_sketching_solutions"}', 
    error_tags = '{"equilibrium_missed","confuse_slope_with_yvalue"}', 
    options = '[{"id":"A","value":"$y=0$ and $y=1$","explanation":"Correct: both make the right side $0$."},{"id":"B","value":"$y=-1$ and $y=1$","explanation":"$y=-1$ gives $(-1)(2)\\neq 0$."},{"id":"C","value":"$y=0$ only","explanation":"Misses the factor $(1-y)=0$ at $y=1$."},{"id":"D","value":"No equilibria because the equation depends on $y$","explanation":"Depending on $y$ does not prevent equilibria."}]',
    updated_at = NOW() 
WHERE id = '6a1c14d9-bc6e-4211-8803-1b3bfa9f475a';
DELETE FROM question_skills WHERE question_id = '6b264ee1-498b-4f69-9594-0eaf952e8564';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6b264ee1-498b-4f69-9594-0eaf952e8564', 'slope_field_construct', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6b264ee1-498b-4f69-9594-0eaf952e8564', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6b264ee1-498b-4f69-9594-0eaf952e8564', 'slope_field_sketching_solutions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_sketching_solutions', 
    supporting_skill_ids = '{"slope_field_construct","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_construct","interpret_in_context","slope_field_sketching_solutions"}', 
    error_tags = '{"confuse_slope_with_yvalue","invert_derivative"}', 
    options = '[{"id":"A","value":"$y=x$","explanation":"Correct: $x-y=0$ on $y=x$."},{"id":"B","value":"$y=-x$","explanation":"This would correspond to $x+y=0$, not $x-y=0$."},{"id":"C","value":"$x=0$","explanation":"Slope is $-y$ on $x=0$, not always $0$."},{"id":"D","value":"$y=0$","explanation":"Slope is $x$ on $y=0$, not always $0$."}]',
    updated_at = NOW() 
WHERE id = '6b264ee1-498b-4f69-9594-0eaf952e8564';
DELETE FROM question_skills WHERE question_id = '6b7a2074-faa9-4942-96db-1e5de6d14c41';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6b7a2074-faa9-4942-96db-1e5de6d14c41', 'estimate_parameter_from_data', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6b7a2074-faa9-4942-96db-1e5de6d14c41', 'exponential_de_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'exponential_de_model', 
    supporting_skill_ids = '{"estimate_parameter_from_data"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"estimate_parameter_from_data","exponential_de_model"}', 
    error_tags = '{"parameter_from_data_error","wrong_k_interpretation"}', 
    options = '[{"id":"A","value":"$k=\\frac{\\ln(1.25)}{3}$","explanation":"Correct: uses the exponential ratio relationship."},{"id":"B","value":"$k=\\frac{1.25}{3}$","explanation":"Uses a linear rate instead of an exponential rate."},{"id":"C","value":"$k=\\ln(1.25)$","explanation":"Forgets to divide by the time interval $3$."},{"id":"D","value":"$k=-\\frac{\\ln(1.25)}{3}$","explanation":"Wrong sign: the data show growth, not decay."}]',
    updated_at = NOW() 
WHERE id = '6b7a2074-faa9-4942-96db-1e5de6d14c41';
DELETE FROM question_skills WHERE question_id = '701bf98b-cd27-4087-a79b-91671756f49e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('701bf98b-cd27-4087-a79b-91671756f49e', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('701bf98b-cd27-4087-a79b-91671756f49e', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('701bf98b-cd27-4087-a79b-91671756f49e', 'euler_step_size_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'euler_step_size_modeling', 
    supporting_skill_ids = '{"evaluate_derivative_at_point","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","C":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"evaluate_derivative_at_point","interpret_in_context","euler_step_size_modeling"}', 
    error_tags = '{"derivative_computation_error","sign_error_in_rate"}', 
    options = '[{"id":"A","value":"$-1$","explanation":"Sign mistake when computing $f(1,0)$ or updating $y$."},{"id":"B","value":"$0$","explanation":"Stops after one step and forgets the second update."},{"id":"C","value":"$1$","explanation":"Correct: $0+1\\cdot 1=1$."},{"id":"D","value":"$2$","explanation":"Treats $y_2$ as $t_2$ instead of the $y$-value."}]',
    updated_at = NOW() 
WHERE id = '701bf98b-cd27-4087-a79b-91671756f49e';
DELETE FROM question_skills WHERE question_id = '7241dd8c-c26b-4261-9a4b-2e9f8556b1de';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7241dd8c-c26b-4261-9a4b-2e9f8556b1de', 'model_from_context_rate', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7241dd8c-c26b-4261-9a4b-2e9f8556b1de', 'units_mismatch_or_ignored', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7241dd8c-c26b-4261-9a4b-2e9f8556b1de', 'exponential_de_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'exponential_de_model', 
    supporting_skill_ids = '{"model_from_context_rate","units_mismatch_or_ignored"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"model_from_context_rate","units_mismatch_or_ignored","exponential_de_model"}', 
    error_tags = '{"wrong_dependency_in_model","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$\\frac{dP}{dt}=kP$ with $k>0$","explanation":"Correct: proportional-to-current-value growth model."},{"id":"B","value":"$\\frac{dP}{dt}=k$ with $k>0$","explanation":"Constant growth rate is linear, not proportional."},{"id":"C","value":"$\\frac{dP}{dt}=\\frac{k}{P}$ with $k>0$","explanation":"Inverse dependence is not proportional to $P$."},{"id":"D","value":"$\\frac{dP}{dt}=-kP$ with $k>0$","explanation":"Negative sign would model decay, not growth."}]',
    updated_at = NOW() 
WHERE id = '7241dd8c-c26b-4261-9a4b-2e9f8556b1de';
DELETE FROM question_skills WHERE question_id = '726a89a7-aea6-4a2d-a58b-4b0f2e4347fe';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('726a89a7-aea6-4a2d-a58b-4b0f2e4347fe', 'separate_variables', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('726a89a7-aea6-4a2d-a58b-4b0f2e4347fe', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('726a89a7-aea6-4a2d-a58b-4b0f2e4347fe', 'separate_variables_and_ic', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables_and_ic', 
    supporting_skill_ids = '{"separate_variables","identify_initial_condition"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"separate_variables","identify_initial_condition","separate_variables_and_ic"}', 
    error_tags = '{"variables_not_fully_separated","initial_condition_misread"}', 
    options = '[{"id":"A","value":"$y=\\sqrt{x^2+4}$","explanation":"Correct: satisfies the DE and $y(0)=2$."},{"id":"B","value":"$y=\\sqrt{x^2-4}$","explanation":"Gives $y(0)=\\sqrt{-4}$, not real."},{"id":"C","value":"$y=x+2$","explanation":"Would imply $y''=1$, not $\\frac{x}{y}$ for all $x$."},{"id":"D","value":"$y=2e^{x}$","explanation":"Solves $y''=y$, not $y''=\\frac{x}{y}$."}]',
    updated_at = NOW() 
WHERE id = '726a89a7-aea6-4a2d-a58b-4b0f2e4347fe';
DELETE FROM question_skills WHERE question_id = '73ed8215-1dbc-437f-892e-1af41c082796';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('73ed8215-1dbc-437f-892e-1af41c082796', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('73ed8215-1dbc-437f-892e-1af41c082796', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('73ed8215-1dbc-437f-892e-1af41c082796', 'euler_step_size_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'euler_step_size_modeling', 
    supporting_skill_ids = '{"evaluate_derivative_at_point","identify_initial_condition"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"evaluate_derivative_at_point","identify_initial_condition","euler_step_size_modeling"}', 
    error_tags = '{"initial_condition_misread","derivative_computation_error"}', 
    options = '[{"id":"A","value":"$1.25$","explanation":"Uses an incorrect slope or step size."},{"id":"B","value":"$1.50$","explanation":"Correct: $1+0.5\\cdot 1=1.5$."},{"id":"C","value":"$1.75$","explanation":"Over-updates using the next slope too early."},{"id":"D","value":"$2.00$","explanation":"Treats the slope like $t+y=2$ at $t=0$ (wrong)."}]',
    updated_at = NOW() 
WHERE id = '73ed8215-1dbc-437f-892e-1af41c082796';
DELETE FROM question_skills WHERE question_id = '74215b1c-0e6e-411a-a45e-56e454dfbc4e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('74215b1c-0e6e-411a-a45e-56e454dfbc4e', 'implicit_to_explicit', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('74215b1c-0e6e-411a-a45e-56e454dfbc4e', 'integrate_both_sides', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'implicit_to_explicit', 
    supporting_skill_ids = '{"integrate_both_sides"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Correct. This follows the principles for solving or interpreting differential equations.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"implicit_to_explicit","integrate_both_sides"}', 
    error_tags = '{"implicit_to_explicit_algebra_error","missing_abs_in_log"}', 
    options = '[{"id":"A","value":"$y=C+\\frac{x^2}{2}$","explanation":"That treats $\\ln|y|$ like a linear expression in $y$."},{"id":"B","value":"$y=e^{\\frac{x^2}{2}+C}$","explanation":"Not simplified to the standard constant-multiplied form."},{"id":"C","value":"$y=Ce^{\\frac{x^2}{2}}$","explanation":"Correct: combines constants into a single multiplicative constant."},{"id":"D","value":"$y=\\frac{x^2}{2e^C}$","explanation":"Algebra is incorrect after exponentiating."}]',
    updated_at = NOW() 
WHERE id = '74215b1c-0e6e-411a-a45e-56e454dfbc4e';
DELETE FROM question_skills WHERE question_id = '7a1a7a65-e279-4b2c-9e47-d67a2bf23549';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7a1a7a65-e279-4b2c-9e47-d67a2bf23549', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7a1a7a65-e279-4b2c-9e47-d67a2bf23549', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7a1a7a65-e279-4b2c-9e47-d67a2bf23549', 'differential_equation_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'differential_equation_basics', 
    supporting_skill_ids = '{"evaluate_derivative_at_point","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"evaluate_derivative_at_point","interpret_in_context","differential_equation_basics"}', 
    error_tags = '{"sign_error_in_rate","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$-20$","explanation":"Correct: multiply $-0.2$ by $100$."},{"id":"B","value":"$-0.2$","explanation":"This is the coefficient, not the derivative value."},{"id":"C","value":"$20$","explanation":"Wrong sign: the model is decreasing."},{"id":"D","value":"$0.2$","explanation":"Wrong: uses the coefficient and wrong sign."}]',
    updated_at = NOW() 
WHERE id = '7a1a7a65-e279-4b2c-9e47-d67a2bf23549';
DELETE FROM question_skills WHERE question_id = '7ef4532d-228f-44b6-ab6f-56dfa7450562';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7ef4532d-228f-44b6-ab6f-56dfa7450562', 'interpret_in_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7ef4532d-228f-44b6-ab6f-56dfa7450562', 'exponential_de_model', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'interpret_in_context', 
    supporting_skill_ids = '{"exponential_de_model"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"interpret_in_context","exponential_de_model"}', 
    error_tags = '{"units_mismatch_or_ignored","wrong_k_interpretation"}', 
    options = '[{"id":"A","value":"$hours$","explanation":"Would make $ky$ have units $y\\cdot\\text{hours}$."},{"id":"B","value":"$\\frac{1}{\\text{hours}}$","explanation":"Correct: $k$ is a per-hour rate constant."},{"id":"C","value":"same units as $y$","explanation":"Would make $ky$ have units $y^2$."},{"id":"D","value":"$unitless$","explanation":"Unitless $k$ would not match $\\frac{dy}{dt}$ units."}]',
    updated_at = NOW() 
WHERE id = '7ef4532d-228f-44b6-ab6f-56dfa7450562';
DELETE FROM question_skills WHERE question_id = '7fbb7ea2-ee5c-4d46-8c39-b0c8289d6dbe';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7fbb7ea2-ee5c-4d46-8c39-b0c8289d6dbe', 'model_from_context_rate', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7fbb7ea2-ee5c-4d46-8c39-b0c8289d6dbe', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7fbb7ea2-ee5c-4d46-8c39-b0c8289d6dbe', 'differential_equation_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'differential_equation_basics', 
    supporting_skill_ids = '{"model_from_context_rate","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"model_from_context_rate","interpret_in_context","differential_equation_basics"}', 
    error_tags = '{"wrong_dependency_in_model","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$\\frac{dy}{dt}=y$","explanation":"Too large: if $y=9$, this predicts $\\frac{dy}{dt}=9$, not $3$."},{"id":"B","value":"$\\frac{dy}{dt}=\\sqrt{y}$","explanation":"Correct: $\\sqrt{4}=2$, $\\sqrt{9}=3$, $\\sqrt{16}=4$."},{"id":"C","value":"$\\frac{dy}{dt}=\\frac{1}{2}y$","explanation":"If $y=16$, this predicts $8$, not $4$."},{"id":"D","value":"$\\frac{dy}{dt}=\\frac{1}{\\sqrt{y}}$","explanation":"If $y=4$, this predicts $\\frac{1}{2}$, not $2$."}]',
    updated_at = NOW() 
WHERE id = '7fbb7ea2-ee5c-4d46-8c39-b0c8289d6dbe';
DELETE FROM question_skills WHERE question_id = '7fd74b25-e4f8-407f-94fa-265512b30791';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7fd74b25-e4f8-407f-94fa-265512b30791', 'evaluate_derivative_at_point', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7fd74b25-e4f8-407f-94fa-265512b30791', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'evaluate_derivative_at_point', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"evaluate_derivative_at_point","interpret_in_context"}', 
    error_tags = '{"sign_error_in_rate","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$-2$","explanation":"Correct: $1-3=-2$."},{"id":"B","value":"$-1$","explanation":"Arithmetic error."},{"id":"C","value":"$2$","explanation":"Drops the negative sign."},{"id":"D","value":"$4$","explanation":"Adds instead of subtracting."}]',
    updated_at = NOW() 
WHERE id = '7fd74b25-e4f8-407f-94fa-265512b30791';
DELETE FROM question_skills WHERE question_id = '8be225a9-8234-468f-bf07-8a16f882cfa3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8be225a9-8234-468f-bf07-8a16f882cfa3', 'slope_field_construct', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8be225a9-8234-468f-bf07-8a16f882cfa3', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8be225a9-8234-468f-bf07-8a16f882cfa3', 'slope_field_sketching_solutions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_sketching_solutions', 
    supporting_skill_ids = '{"slope_field_construct","evaluate_derivative_at_point"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_construct","evaluate_derivative_at_point","slope_field_sketching_solutions"}', 
    error_tags = '{"slope_field_axis_mixup","invert_derivative"}', 
    options = '[{"id":"A","value":"$f\\!\\left(y_0,x_0\\right)$","explanation":"Swaps inputs; slope uses $x$ then $y$."},{"id":"B","value":"$\\frac{1}{f\\!\\left(x_0,y_0\\right)}$","explanation":"This flips rise/run and is not generally correct."},{"id":"C","value":"$f\\!\\left(x_0,y_0\\right)$","explanation":"Correct: slope equals $f\\!\\left(x_0,y_0\\right)$."},{"id":"D","value":"$y_0$","explanation":"Slope is not the same as the $y$-value."}]',
    updated_at = NOW() 
WHERE id = '8be225a9-8234-468f-bf07-8a16f882cfa3';
DELETE FROM question_skills WHERE question_id = '8fde1ef5-209b-4ef7-aa9f-1d6d8abff1da';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8fde1ef5-209b-4ef7-aa9f-1d6d8abff1da', 'slope_field_solution_curve', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8fde1ef5-209b-4ef7-aa9f-1d6d8abff1da', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8fde1ef5-209b-4ef7-aa9f-1d6d8abff1da', 'slope_field_sketching_solutions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_sketching_solutions', 
    supporting_skill_ids = '{"slope_field_solution_curve","identify_initial_condition"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_solution_curve","identify_initial_condition","slope_field_sketching_solutions"}', 
    error_tags = '{"solution_curve_not_tangent","initial_condition_misread"}', 
    options = '[{"id":"A","value":"The curve’s tangent slope equals $f\\!\\left(0,2\\right)$.","explanation":"Correct: solution curves are tangent to the slope field."},{"id":"B","value":"The curve must be horizontal because $x=0$.","explanation":"Slope depends on $x$ and $y$, not just $x=0$."},{"id":"C","value":"The curve must pass through the origin next.","explanation":"Nothing in a slope field forces passing through the origin."},{"id":"D","value":"The curve’s $y$-value must equal the slope there.","explanation":"Slope is $\\frac{dy}{dx}$, not the $y$-value."}]',
    updated_at = NOW() 
WHERE id = '8fde1ef5-209b-4ef7-aa9f-1d6d8abff1da';
DELETE FROM question_skills WHERE question_id = '95cc5be2-c051-4a13-b977-ca61cea001d1';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('95cc5be2-c051-4a13-b977-ca61cea001d1', 'solve_for_constant_using_ic', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('95cc5be2-c051-4a13-b977-ca61cea001d1', 'implicit_to_explicit', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('95cc5be2-c051-4a13-b977-ca61cea001d1', 'separate_variables_and_ic', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables_and_ic', 
    supporting_skill_ids = '{"solve_for_constant_using_ic","implicit_to_explicit"}', 
    target_time_seconds = 210, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"solve_for_constant_using_ic","implicit_to_explicit","separate_variables_and_ic"}', 
    error_tags = '{"constant_solve_error_with_ic","implicit_to_explicit_algebra_error"}', 
    options = '[{"id":"A","value":"$y=-2e^{x-1}$","explanation":"Correct: matches $y(1)=-2$ and keeps the sign negative."},{"id":"B","value":"$y=2e^{x-1}$","explanation":"Wrong sign: would give $y(1)=2$."},{"id":"C","value":"$y=-2e^{1-x}$","explanation":"Wrong exponent direction: gives $y(1)=-2$ but does not match $|y|=Ae^{x}$ for all $x$."},{"id":"D","value":"$y=\\ln|x| -2$","explanation":"Does not undo the logarithm and is not an exponential form."}]',
    updated_at = NOW() 
WHERE id = '95cc5be2-c051-4a13-b977-ca61cea001d1';
DELETE FROM question_skills WHERE question_id = '95e59a49-62f2-4046-9522-47ce60796905';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('95e59a49-62f2-4046-9522-47ce60796905', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('95e59a49-62f2-4046-9522-47ce60796905', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('95e59a49-62f2-4046-9522-47ce60796905', 'logistic_growth_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'logistic_growth_model', 
    supporting_skill_ids = '{"interpret_in_context","identify_initial_condition"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"interpret_in_context","identify_initial_condition","logistic_growth_model"}', 
    error_tags = '{"initial_condition_misread","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$y(0)$ is close to $0$","explanation":"Correct: starts far below the limiting value and rises toward it."},{"id":"B","value":"$y(0)$ is close to the carrying capacity","explanation":"If it started near carrying capacity, it would begin nearly flat."},{"id":"C","value":"$y(0)$ is negative","explanation":"The graph shows positive values throughout."},{"id":"D","value":"$y(0)$ is larger than the carrying capacity","explanation":"Starting above carrying capacity would typically decrease toward it."}]',
    updated_at = NOW() 
WHERE id = '95e59a49-62f2-4046-9522-47ce60796905';
DELETE FROM question_skills WHERE question_id = 'aa6aa321-4400-4643-9f05-b934831070b9';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('aa6aa321-4400-4643-9f05-b934831070b9', 'solve_for_constant_using_ic', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('aa6aa321-4400-4643-9f05-b934831070b9', 'integrate_both_sides', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('aa6aa321-4400-4643-9f05-b934831070b9', 'separate_variables_and_ic', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables_and_ic', 
    supporting_skill_ids = '{"solve_for_constant_using_ic","integrate_both_sides"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"solve_for_constant_using_ic","integrate_both_sides","separate_variables_and_ic"}', 
    error_tags = '{"constant_solve_error_with_ic","missing_constant_of_integration"}', 
    options = '[{"id":"A","value":"$y=5e^{2x}$","explanation":"Correct: $C=5$ from the initial condition."},{"id":"B","value":"$y=e^{10x}$","explanation":"Wrong: changes the exponent instead of the constant."},{"id":"C","value":"$y=Ce^{2x}+5$","explanation":"Wrong: solutions scale by a constant, not add one."},{"id":"D","value":"$y=5e^{-2x}$","explanation":"Wrong sign in the exponent (would satisfy $y''=-2y$)."}]',
    updated_at = NOW() 
WHERE id = 'aa6aa321-4400-4643-9f05-b934831070b9';
DELETE FROM question_skills WHERE question_id = 'b23e9a3e-70de-46bf-aa8c-12774fef5dc5';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b23e9a3e-70de-46bf-aa8c-12774fef5dc5', 'verify_by_substitution', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b23e9a3e-70de-46bf-aa8c-12774fef5dc5', 'identify_initial_condition', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b23e9a3e-70de-46bf-aa8c-12774fef5dc5', 'slope_field_interpretation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_interpretation', 
    supporting_skill_ids = '{"verify_by_substitution","identify_initial_condition"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"verify_by_substitution","identify_initial_condition","slope_field_interpretation"}', 
    error_tags = '{"initial_condition_misread","substitution_error_in_verification"}', 
    options = '[{"id":"A","value":"$y=3e^{x}$","explanation":"Correct: matches the DE and the initial value."},{"id":"B","value":"$y=e^{3x}$","explanation":"Gives $y(0)=1$, not $3$."},{"id":"C","value":"$y=3x$","explanation":"Has $y''=3$, which is not equal to $y$ for all $x$."},{"id":"D","value":"$y=3e^{-x}$","explanation":"Has $y''=-3e^{-x}$, which is $-y$, not $y$."}]',
    updated_at = NOW() 
WHERE id = 'b23e9a3e-70de-46bf-aa8c-12774fef5dc5';
DELETE FROM question_skills WHERE question_id = 'b4ba378d-3528-445c-8767-93a76089fa54';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b4ba378d-3528-445c-8767-93a76089fa54', 'qualitative_behavior', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b4ba378d-3528-445c-8767-93a76089fa54', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'qualitative_behavior', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"qualitative_behavior","interpret_in_context"}', 
    error_tags = '{"wrong_k_interpretation","confuse_slope_with_yvalue"}', 
    options = '[{"id":"A","value":"$y(t)$ increases without bound.","explanation":"Logistic-type growth levels off."},{"id":"B","value":"$y(t)$ approaches a horizontal asymptote (levels off).","explanation":"Correct: the graph approaches a constant level."},{"id":"C","value":"$y(t)$ oscillates around a constant value.","explanation":"No oscillation is shown."},{"id":"D","value":"$y(t)$ decreases to $0$.","explanation":"The graph is increasing, not decreasing."}]',
    updated_at = NOW() 
WHERE id = 'b4ba378d-3528-445c-8767-93a76089fa54';
DELETE FROM question_skills WHERE question_id = 'b508b1f0-b367-48a5-bae0-60e817f1bd36';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b508b1f0-b367-48a5-bae0-60e817f1bd36', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b508b1f0-b367-48a5-bae0-60e817f1bd36', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b508b1f0-b367-48a5-bae0-60e817f1bd36', 'logistic_growth_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'logistic_growth_model', 
    supporting_skill_ids = '{"qualitative_behavior","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"qualitative_behavior","interpret_in_context","logistic_growth_model"}', 
    error_tags = '{"confuse_slope_with_yvalue","wrong_k_interpretation"}', 
    options = '[{"id":"A","value":"$y(t)$ increases without bound.","explanation":"Logistic-type growth levels off rather than growing unbounded."},{"id":"B","value":"$y(t)$ approaches a horizontal asymptote (levels off).","explanation":"Correct: the graph clearly approaches a constant level."},{"id":"C","value":"$y(t)$ oscillates around a constant value.","explanation":"No oscillations are shown."},{"id":"D","value":"$y(t)$ decreases to $0$.","explanation":"The curve is increasing and leveling off, not decreasing."}]',
    updated_at = NOW() 
WHERE id = 'b508b1f0-b367-48a5-bae0-60e817f1bd36';
DELETE FROM question_skills WHERE question_id = 'b961c6ba-5b7a-43c0-9f8a-6244590197aa';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b961c6ba-5b7a-43c0-9f8a-6244590197aa', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b961c6ba-5b7a-43c0-9f8a-6244590197aa', 'model_from_context_rate', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b961c6ba-5b7a-43c0-9f8a-6244590197aa', 'differential_equation_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'differential_equation_basics', 
    supporting_skill_ids = '{"interpret_in_context","model_from_context_rate"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Correct. This follows the principles for solving or interpreting differential equations.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"interpret_in_context","model_from_context_rate","differential_equation_basics"}', 
    error_tags = '{"units_mismatch_or_ignored","wrong_k_interpretation"}', 
    options = '[{"id":"A","value":"thousands of people","explanation":"That would make the right side have units “thousands$^2$ per day.”"},{"id":"B","value":"$days$","explanation":"A time unit alone cannot balance the equation."},{"id":"C","value":"per day","explanation":"Correct: it must convert thousands to thousands per day."},{"id":"D","value":"thousands of people per day","explanation":"That would make the right side “thousands$^2$ per day.”"}]',
    updated_at = NOW() 
WHERE id = 'b961c6ba-5b7a-43c0-9f8a-6244590197aa';
DELETE FROM question_skills WHERE question_id = 'b96cd360-58fe-46d9-acc7-d4f901c06ca7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b96cd360-58fe-46d9-acc7-d4f901c06ca7', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b96cd360-58fe-46d9-acc7-d4f901c06ca7', 'estimate_parameter_from_data', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b96cd360-58fe-46d9-acc7-d4f901c06ca7', 'exponential_de_model', 'primary');
UPDATE questions SET 
    primary_skill_id = 'exponential_de_model', 
    supporting_skill_ids = '{"interpret_in_context","estimate_parameter_from_data"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"interpret_in_context","estimate_parameter_from_data","exponential_de_model"}', 
    error_tags = '{"wrong_k_interpretation","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"The quantity grows faster because the relative growth rate is larger.","explanation":"Correct: larger $k$ increases the growth rate at every value of $P$."},{"id":"B","value":"The initial value $P(0)$ becomes larger.","explanation":"$P(0)$ is set by the initial condition, not by $k$."},{"id":"C","value":"The quantity must eventually become linear.","explanation":"Exponential models remain exponential, not linear."},{"id":"D","value":"The growth changes from exponential to logistic.","explanation":"Changing $k$ does not change the model type to logistic."}]',
    updated_at = NOW() 
WHERE id = 'b96cd360-58fe-46d9-acc7-d4f901c06ca7';
DELETE FROM question_skills WHERE question_id = 'c22d56eb-21de-4fd4-8aea-3ac092fdd75d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c22d56eb-21de-4fd4-8aea-3ac092fdd75d', 'estimate_parameter_from_data', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c22d56eb-21de-4fd4-8aea-3ac092fdd75d', 'exponential_de_model', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'estimate_parameter_from_data', 
    supporting_skill_ids = '{"exponential_de_model"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles for solving or interpreting differential equations.","B":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"estimate_parameter_from_data","exponential_de_model"}', 
    error_tags = '{"parameter_from_data_error","wrong_k_interpretation"}', 
    options = '[{"id":"A","value":"$k=\\frac{\\ln(0.8)}{2}$","explanation":"Correct: uses exponential ratio and divides by $2$ hours."},{"id":"B","value":"$k=\\frac{0.8}{2}$","explanation":"Uses a linear change idea instead of exponential."},{"id":"C","value":"$k=\\ln(0.8)$","explanation":"Forgets to divide by the time interval."},{"id":"D","value":"$k=-\\frac{\\ln(0.8)}{2}$","explanation":"Wrong sign; since $0.8<1$, $k$ must be negative."}]',
    updated_at = NOW() 
WHERE id = 'c22d56eb-21de-4fd4-8aea-3ac092fdd75d';
DELETE FROM question_skills WHERE question_id = 'c4d65874-de94-4951-8bc0-7d4aa7458965';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c4d65874-de94-4951-8bc0-7d4aa7458965', 'identify_initial_condition', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c4d65874-de94-4951-8bc0-7d4aa7458965', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'identify_initial_condition', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"identify_initial_condition","interpret_in_context"}', 
    error_tags = '{"initial_condition_misread","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$A(80)=0$","explanation":"Swaps input and output."},{"id":"B","value":"$A(0)=80$","explanation":"Correct: read directly from the $t=0$ row."},{"id":"C","value":"$A''(0)=80$","explanation":"The table gives $A(t)$, not $A''(t)$."},{"id":"D","value":"$A''(2)=64$","explanation":"The table does not list derivative values."}]',
    updated_at = NOW() 
WHERE id = 'c4d65874-de94-4951-8bc0-7d4aa7458965';
DELETE FROM question_skills WHERE question_id = 'c6542f5f-130c-40af-8d35-f076a169a5ae';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c6542f5f-130c-40af-8d35-f076a169a5ae', 'solve_for_constant_using_ic', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c6542f5f-130c-40af-8d35-f076a169a5ae', 'verify_by_substitution', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c6542f5f-130c-40af-8d35-f076a169a5ae', 'slope_field_interpretation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_interpretation', 
    supporting_skill_ids = '{"solve_for_constant_using_ic","verify_by_substitution"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"solve_for_constant_using_ic","verify_by_substitution","slope_field_interpretation"}', 
    error_tags = '{"constant_solve_error_with_ic","initial_condition_misread"}', 
    options = '[{"id":"A","value":"$C=e^2$","explanation":"Correct: $Ce=e^3$ gives $C=e^2$."},{"id":"B","value":"$C=e^3$","explanation":"Would make $y(1)=e^4$, not $e^3$."},{"id":"C","value":"$C=e$","explanation":"Would make $y(1)=e^2$, not $e^3$."},{"id":"D","value":"$C=1$","explanation":"Would make $y(1)=e$, not $e^3$."}]',
    updated_at = NOW() 
WHERE id = 'c6542f5f-130c-40af-8d35-f076a169a5ae';
DELETE FROM question_skills WHERE question_id = 'c77f5c65-81f0-44ce-905f-f62f1c9a89da';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c77f5c65-81f0-44ce-905f-f62f1c9a89da', 'slope_field_construct', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c77f5c65-81f0-44ce-905f-f62f1c9a89da', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c77f5c65-81f0-44ce-905f-f62f1c9a89da', 'slope_field_sketching_solutions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_sketching_solutions', 
    supporting_skill_ids = '{"slope_field_construct","evaluate_derivative_at_point"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_construct","evaluate_derivative_at_point","slope_field_sketching_solutions"}', 
    error_tags = '{"slope_field_axis_mixup","confuse_slope_with_yvalue"}', 
    options = '[{"id":"A","value":"$-1$","explanation":"This is $1-2$, which swaps $x$ and $y$."},{"id":"B","value":"$0$","explanation":"Slope is $0$ only when $x=y$."},{"id":"C","value":"$1$","explanation":"Correct: $2-1=1$."},{"id":"D","value":"$3$","explanation":"Incorrect arithmetic for $2-1$."}]',
    updated_at = NOW() 
WHERE id = 'c77f5c65-81f0-44ce-905f-f62f1c9a89da';
DELETE FROM question_skills WHERE question_id = 'd6c1b20f-2337-4d14-bbf2-19e6971b708d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d6c1b20f-2337-4d14-bbf2-19e6971b708d', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d6c1b20f-2337-4d14-bbf2-19e6971b708d', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d6c1b20f-2337-4d14-bbf2-19e6971b708d', 'eulers_method_approximation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'eulers_method_approximation', 
    supporting_skill_ids = '{"qualitative_behavior","interpret_in_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"qualitative_behavior","interpret_in_context","eulers_method_approximation"}', 
    error_tags = '{"confuse_slope_with_yvalue","slope_field_axis_mixup"}', 
    options = '[{"id":"A","value":"They must be decreasing there.","explanation":"Decreasing would require negative slopes."},{"id":"B","value":"They must be increasing there.","explanation":"Correct: positive slopes imply locally increasing solution curves."},{"id":"C","value":"They must have $y>0$ there.","explanation":"Slope sign does not directly determine whether $y$ is positive."},{"id":"D","value":"They must be horizontal there.","explanation":"Horizontal would require slope $0$."}]',
    updated_at = NOW() 
WHERE id = 'd6c1b20f-2337-4d14-bbf2-19e6971b708d';
DELETE FROM question_skills WHERE question_id = 'd7dd0758-3140-41d3-b41e-7ee36c8756cb';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d7dd0758-3140-41d3-b41e-7ee36c8756cb', 'interpret_in_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d7dd0758-3140-41d3-b41e-7ee36c8756cb', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d7dd0758-3140-41d3-b41e-7ee36c8756cb', 'euler_step_size_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'euler_step_size_modeling', 
    supporting_skill_ids = '{"interpret_in_context","qualitative_behavior"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"interpret_in_context","qualitative_behavior","euler_step_size_modeling"}', 
    error_tags = '{"units_mismatch_or_ignored","parameter_from_data_error"}', 
    options = '[{"id":"A","value":"Use a larger step size $h$","explanation":"Larger $h$ usually increases the error per step."},{"id":"B","value":"Use a smaller step size $h$","explanation":"Correct: smaller $h$ typically improves accuracy."},{"id":"C","value":"Replace $\\frac{dy}{dt}$ with $\\frac{dt}{dy}$","explanation":"Flipping derivatives changes the model and is not Euler’s method."},{"id":"D","value":"Ignore the initial condition","explanation":"Euler’s method needs a starting value to generate approximations."}]',
    updated_at = NOW() 
WHERE id = 'd7dd0758-3140-41d3-b41e-7ee36c8756cb';
DELETE FROM question_skills WHERE question_id = 'de4e8d68-db18-4bc8-b282-21fcb614344f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('de4e8d68-db18-4bc8-b282-21fcb614344f', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('de4e8d68-db18-4bc8-b282-21fcb614344f', 'separate_variables', 'primary');
UPDATE questions SET 
    primary_skill_id = 'separate_variables', 
    supporting_skill_ids = '{"equilibrium_solutions"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","B":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process.","C":"Correct. Solving by separation of variables involves moving all $y$-terms to one side and all $x$-terms to the other, followed by indefinite integration and solving for the constant C.","D":"Incorrect. Ensure all variables are properly separated (e.g., dy/$y = dx$) before integrating. Don''$t$ forget the constant of integration C early in the process."}', 
    skill_tags = '{"equilibrium_solutions","separate_variables"}', 
    error_tags = '{"lost_solution_dividing_by_expression","equilibrium_missed"}', 
    options = '[{"id":"A","value":"$y=0$ only","explanation":"Misses the equilibrium at $y=1$."},{"id":"B","value":"$y=1$ only","explanation":"Misses the equilibrium at $y=0$."},{"id":"C","value":"$y=0$ and $y=1$","explanation":"Correct: both make the right side $0$ and can be lost by division."},{"id":"D","value":"No constant solutions are possible","explanation":"This DE has equilibria where $\\frac{dy}{dx}=0$."}]',
    updated_at = NOW() 
WHERE id = 'de4e8d68-db18-4bc8-b282-21fcb614344f';
DELETE FROM question_skills WHERE question_id = 'e0135e56-e24f-4463-9023-2d2d38bf7cdc';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e0135e56-e24f-4463-9023-2d2d38bf7cdc', 'verify_by_substitution', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e0135e56-e24f-4463-9023-2d2d38bf7cdc', 'evaluate_derivative_at_point', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e0135e56-e24f-4463-9023-2d2d38bf7cdc', 'slope_field_interpretation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_interpretation', 
    supporting_skill_ids = '{"verify_by_substitution","evaluate_derivative_at_point"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"verify_by_substitution","evaluate_derivative_at_point","slope_field_interpretation"}', 
    error_tags = '{"derivative_computation_error","substitution_error_in_verification"}', 
    options = '[{"id":"A","value":"$y=x^2+3$","explanation":"Correct: $\\frac{d}{dx}(x^2+3)=2x$."},{"id":"B","value":"$y=2x+3$","explanation":"Derivative is $2$, not $2x$."},{"id":"C","value":"$y=\\frac{1}{x^2}$","explanation":"Derivative is $-\\frac{2}{x^3}$, not $2x$."},{"id":"D","value":"$y=e^{2x}$","explanation":"Derivative is $2e^{2x}$, not $2x$."}]',
    updated_at = NOW() 
WHERE id = 'e0135e56-e24f-4463-9023-2d2d38bf7cdc';
DELETE FROM question_skills WHERE question_id = 'e218920c-de93-4c6a-a1de-143b7a59b817';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e218920c-de93-4c6a-a1de-143b7a59b817', 'qualitative_behavior', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e218920c-de93-4c6a-a1de-143b7a59b817', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'qualitative_behavior', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"qualitative_behavior","interpret_in_context"}', 
    error_tags = '{"wrong_k_interpretation","units_mismatch_or_ignored"}', 
    options = '[{"id":"A","value":"$\\frac{dP}{dt}$ stays constant and positive.","explanation":"A constant positive rate would not level off."},{"id":"B","value":"$\\frac{dP}{dt}$ is still positive but getting closer to $0$.","explanation":"Correct: growth continues but slows as it approaches a limit."},{"id":"C","value":"$\\frac{dP}{dt}$ must be negative.","explanation":"The table shows increasing values, not decreasing."},{"id":"D","value":"$\\frac{dP}{dt}$ must be exactly $0$ for all later times.","explanation":"A leveling trend does not imply the rate is identically zero immediately."}]',
    updated_at = NOW() 
WHERE id = 'e218920c-de93-4c6a-a1de-143b7a59b817';
DELETE FROM question_skills WHERE question_id = 'e24d1fdf-9d44-4d41-bb25-158916db2bb1';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e24d1fdf-9d44-4d41-bb25-158916db2bb1', 'equilibrium_solutions', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e24d1fdf-9d44-4d41-bb25-158916db2bb1', 'interpret_in_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'equilibrium_solutions', 
    supporting_skill_ids = '{"interpret_in_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","B":"Correct. This follows the principles for solving or interpreting differential equations.","C":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application.","D":"Incorrect. This option fails to align with the rules of separation, integration, or initial condition application."}', 
    skill_tags = '{"equilibrium_solutions","interpret_in_context"}', 
    error_tags = '{"equilibrium_missed","confuse_slope_with_yvalue"}', 
    options = '[{"id":"A","value":"$P=0$ only","explanation":"Near $0$ (positive), the rate is positive, so solutions move away from $0$."},{"id":"B","value":"$P=500$ only","explanation":"Correct: the flow is toward $500$ from both sides."},{"id":"C","value":"Both $P=0$ and $P=500$","explanation":"$P=0$ is not attracting for positive initial values here."},{"id":"D","value":"Neither is stable","explanation":"The sign pattern shows $500$ is attracting."}]',
    updated_at = NOW() 
WHERE id = 'e24d1fdf-9d44-4d41-bb25-158916db2bb1';
DELETE FROM question_skills WHERE question_id = 'e44ba877-af7d-49b5-98bd-270d2fa2d35a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e44ba877-af7d-49b5-98bd-270d2fa2d35a', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e44ba877-af7d-49b5-98bd-270d2fa2d35a', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e44ba877-af7d-49b5-98bd-270d2fa2d35a', 'eulers_method_approximation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'eulers_method_approximation', 
    supporting_skill_ids = '{"qualitative_behavior","equilibrium_solutions"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","B":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"qualitative_behavior","equilibrium_solutions","eulers_method_approximation"}', 
    error_tags = '{"equilibrium_missed","solution_curve_not_tangent"}', 
    options = '[{"id":"A","value":"$y$ decreases toward $0$","explanation":"For $0<y<1$, slopes are positive, not negative."},{"id":"B","value":"$y$ increases toward $1$","explanation":"Correct: solutions move upward toward $y=1$."},{"id":"C","value":"$y$ stays constant for all $x$","explanation":"Only equilibria ($y=0$ or $y=1$) are constant solutions."},{"id":"D","value":"$y$ increases without bound","explanation":"Growth slows near $y=1$ and levels off at the carrying level."}]',
    updated_at = NOW() 
WHERE id = 'e44ba877-af7d-49b5-98bd-270d2fa2d35a';
DELETE FROM question_skills WHERE question_id = 'ef57750a-04fe-4568-acfb-b9006785b543';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ef57750a-04fe-4568-acfb-b9006785b543', 'slope_field_solution_curve', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ef57750a-04fe-4568-acfb-b9006785b543', 'identify_initial_condition', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'slope_field_solution_curve', 
    supporting_skill_ids = '{"identify_initial_condition"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","B":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_solution_curve","identify_initial_condition"}', 
    error_tags = '{"solution_curve_not_tangent","initial_condition_misread"}', 
    options = '[{"id":"A","value":"Curve A","explanation":"Starts at a different $y$-value when $x=0$."},{"id":"B","value":"Curve B","explanation":"Correct: passes through $(0,1)$ and is tangent to the field."},{"id":"C","value":"Curve C","explanation":"Starts at a different $y$-value when $x=0$."},{"id":"D","value":"All three curves","explanation":"Different initial conditions give different curves."}]',
    updated_at = NOW() 
WHERE id = 'ef57750a-04fe-4568-acfb-b9006785b543';
DELETE FROM question_skills WHERE question_id = 'f04b3e25-07c5-4b20-889f-3ebb72a715ae';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f04b3e25-07c5-4b20-889f-3ebb72a715ae', 'slope_field_solution_curve', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f04b3e25-07c5-4b20-889f-3ebb72a715ae', 'identify_initial_condition', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'slope_field_solution_curve', 
    supporting_skill_ids = '{"identify_initial_condition"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"slope_field_solution_curve","identify_initial_condition"}', 
    error_tags = '{"solution_curve_not_tangent","initial_condition_misread"}', 
    options = '[{"id":"A","value":"Curve A","explanation":"Correct: passes through $(0,1)$ and follows the direction field."},{"id":"B","value":"Curve B","explanation":"Has a different $y$-value at $x=0$."},{"id":"C","value":"Curve C","explanation":"Has a different $y$-value at $x=0$."},{"id":"D","value":"All three curves","explanation":"Different initial conditions produce different solution curves."}]',
    updated_at = NOW() 
WHERE id = 'f04b3e25-07c5-4b20-889f-3ebb72a715ae';
DELETE FROM question_skills WHERE question_id = 'f21fd267-cdeb-4bf3-9cae-b4bb0a62153d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f21fd267-cdeb-4bf3-9cae-b4bb0a62153d', 'verify_by_substitution', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f21fd267-cdeb-4bf3-9cae-b4bb0a62153d', 'implicit_to_explicit', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f21fd267-cdeb-4bf3-9cae-b4bb0a62153d', 'slope_field_interpretation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'slope_field_interpretation', 
    supporting_skill_ids = '{"verify_by_substitution","implicit_to_explicit"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Slope fields provide a visual representation of a differential equation $dy/dx = f(x,y)$. The solution curves must follow the slopes indicated at each point.","B":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","C":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments.","D":"Incorrect. Verify the slope at specific coordinate points $(x, y)$ by plugging them into the differential equation and checking if they match the slope field segments."}', 
    skill_tags = '{"verify_by_substitution","implicit_to_explicit","slope_field_interpretation"}', 
    error_tags = '{"derivative_computation_error","verification_not_global"}', 
    options = '[{"id":"A","value":"Yes, because differentiating gives $2x+2y\\frac{dy}{dx}=0$, so $\\frac{dy}{dx}=-\\frac{x}{y}$.","explanation":"Correct: the identity holds for all valid points with $y\\neq 0$."},{"id":"B","value":"Yes, but only at the point $\\left(0,5\\right)$.","explanation":"Verification must hold on an interval, not just one point."},{"id":"C","value":"No, because the derivative should be $\\frac{dy}{dx}=\\frac{x}{y}$.","explanation":"Sign error from solving $2x+2y\\frac{dy}{dx}=0$ incorrectly."},{"id":"D","value":"No, because $x^2+y^2=25$ is not an explicit function.","explanation":"A solution can be implicit; it still can satisfy the DE."}]',
    updated_at = NOW() 
WHERE id = 'f21fd267-cdeb-4bf3-9cae-b4bb0a62153d';
DELETE FROM question_skills WHERE question_id = 'f81a04ee-b98a-47f7-af1e-74cab63186c3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f81a04ee-b98a-47f7-af1e-74cab63186c3', 'equilibrium_solutions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f81a04ee-b98a-47f7-af1e-74cab63186c3', 'qualitative_behavior', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f81a04ee-b98a-47f7-af1e-74cab63186c3', 'eulers_method_approximation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'eulers_method_approximation', 
    supporting_skill_ids = '{"equilibrium_solutions","qualitative_behavior"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Euler''s method uses a sequence of tangent line steps to approximate points on a solution curve.","B":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","C":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope.","D":"Incorrect. Ensure your step size (h) and slope calculations at each iteration are consistent with the formula y_ne$w = y$_old + h * slope."}', 
    skill_tags = '{"equilibrium_solutions","qualitative_behavior","eulers_method_approximation"}', 
    error_tags = '{"equilibrium_missed","solution_curve_not_tangent"}', 
    options = '[{"id":"A","value":"$y=0$ and $y=1$ are equilibria, and $y=1$ is stable (attracting).","explanation":"Correct: $y=1$ attracts nearby solutions."},{"id":"B","value":"$y=0$ and $y=1$ are equilibria, and both are unstable.","explanation":"The slope directions near $y=1$ point toward it, not away."},{"id":"C","value":"Only $y=0$ is an equilibrium.","explanation":"Misses the equilibrium at $y=1$ where $y(1-y)=0$."},{"id":"D","value":"$y=1$ is not an equilibrium because the slope changes with $x$.","explanation":"This DE is autonomous (depends on $y$), and $y=1$ is an equilibrium."}]',
    updated_at = NOW() 
WHERE id = 'f81a04ee-b98a-47f7-af1e-74cab63186c3';
COMMIT;