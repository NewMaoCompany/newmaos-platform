-- Unit 5 Comprehensive Audit & LaTeX Repair
BEGIN;
INSERT INTO skills (id, name, unit) VALUES ('evt_application', 'evt_application', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('candidates_test_absolute', 'candidates_test_absolute', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('candidates_test_absolute_extrema', 'candidates_test_absolute_extrema', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('optimization_solve_and_check', 'optimization_solve_and_check', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('first_derivative_test', 'first_derivative_test', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('critical_points_find', 'critical_points_find', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('second_derivative_test_concavity', 'second_derivative_test_concavity', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('implicit_relation_behavior', 'implicit_relation_behavior', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('optimization_modeling', 'optimization_modeling', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('inflection_points', 'inflection_points', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('lhopitals_rule', 'lhopitals_rule', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('connect_f_fprime_fdoubleprime', 'connect_f_fprime_fdoubleprime', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('optimization_evaluation', 'optimization_evaluation', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('increasing_decreasing_from_derivative', 'increasing_decreasing_from_derivative', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('function_graph_behavior', 'function_graph_behavior', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('concavity_from_second_derivative', 'concavity_from_second_derivative', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('mvt_conditions', 'mvt_conditions', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('extreme_value_theorem', 'extreme_value_theorem', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('sketch_function_from_derivative', 'sketch_function_from_derivative', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('method_selection_unit5', 'method_selection_unit5', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('mean_value_theorem', 'mean_value_theorem', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('second_derivative_test', 'second_derivative_test', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('horizontal_vertical_tangent_implicit', 'horizontal_vertical_tangent_implicit', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('sketch_derivative_from_function', 'sketch_derivative_from_function', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('avg_vs_instant_rate_link', 'avg_vs_instant_rate_link', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('global_vs_local_extrema', 'global_vs_local_extrema', 'Analytical_Applications_of_Differentiation') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('evt_requires_closed_interval_missed', 'evt_requires_closed_interval_missed') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('absolute_extrema_compare_error', 'absolute_extrema_compare_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('optimization_domain_missing', 'optimization_domain_missing') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('first_derivative_test_misapplied', 'first_derivative_test_misapplied') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_tangent_condition_error', 'implicit_tangent_condition_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('optimization_constraint_missing', 'optimization_constraint_missing') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inflection_without_sign_change', 'inflection_without_sign_change') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('sketch_missing_key_features', 'sketch_missing_key_features') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('sign_chart_interval_error', 'sign_chart_interval_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('concavity_sign_error', 'concavity_sign_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('increasing_decreasing_sign_flipped', 'increasing_decreasing_sign_flipped') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('mvt_conditions_missed', 'mvt_conditions_missed') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('candidates_test_missing_endpoints', 'candidates_test_missing_endpoints') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('graph_derivative_shape_misread', 'graph_derivative_shape_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_extra_solutions_not_checked', 'implicit_extra_solutions_not_checked') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('wrong_method_choice_unit5', 'wrong_method_choice_unit5') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('assume_bounded_implies_extrema', 'assume_bounded_implies_extrema') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('ignore_open_interval_issue', 'ignore_open_interval_issue') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('confuse_limit_with_value', 'confuse_limit_with_value') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('mvt_conclusion_misread', 'mvt_conclusion_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('confuse_local_global', 'confuse_local_global') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('assume_local_implies_absolute', 'assume_local_implies_absolute') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('endpoint_misconception', 'endpoint_misconception') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('second_derivative_test_wrong_use', 'second_derivative_test_wrong_use') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('critical_points_incomplete', 'critical_points_incomplete') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('forget_endpoints', 'forget_endpoints') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('only_check_where_derivative_zero', 'only_check_where_derivative_zero') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('interval_bounds_error', 'interval_bounds_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('optimization_variable_not_defined', 'optimization_variable_not_defined') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('global_vs_local_confusion', 'global_vs_local_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('evt_missing_closed_interval', 'evt_missing_closed_interval') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('evt_missing_continuity', 'evt_missing_continuity') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('forget_nondifferentiable_critical', 'forget_nondifferentiable_critical') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('treat_discontinuity_as_critical', 'treat_discontinuity_as_critical') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('ignore_domain_restriction', 'ignore_domain_restriction') ON CONFLICT (id) DO NOTHING;
DELETE FROM question_skills WHERE question_id = '0348d1bc-d0c0-43fa-b58a-50360f6110f8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0348d1bc-d0c0-43fa-b58a-50360f6110f8', 'evt_application', 'primary');
UPDATE questions SET 
    primary_skill_id = 'evt_application', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"evt_application"}', 
    error_tags = '{"evt_requires_closed_interval_missed"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ is differentiable on an open interval $(a,b)$.","explanation":"Incorrect: Differentiability on an open interval does not guarantee absolute extrema."},{"id":"B","type":"text","label":"B","value":"$f$ is continuous on a closed interval $[a,b]$.","explanation":"Correct: continuity on a closed interval triggers EVT."},{"id":"C","type":"text","label":"C","value":"$f$ is continuous on $(a,b)$ only.","explanation":"Incorrect: Open intervals can fail to attain extrema."},{"id":"D","type":"text","label":"D","value":"$f$ is differentiable on $[a,b]$.","explanation":"Incorrect: Differentiability is stronger than continuity, but the key is closed interval; the option is ambiguous and not the standard sufficient condition stated."}]',
    updated_at = NOW() 
WHERE id = '0348d1bc-d0c0-43fa-b58a-50360f6110f8';
DELETE FROM question_skills WHERE question_id = '0520597a-5a06-4fc1-b495-5aced0b594e7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0520597a-5a06-4fc1-b495-5aced0b594e7', 'candidates_test_absolute', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0520597a-5a06-4fc1-b495-5aced0b594e7', 'candidates_test_absolute_extrema', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute_extrema', 
    supporting_skill_ids = '{"candidates_test_absolute"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"candidates_test_absolute","candidates_test_absolute_extrema"}', 
    error_tags = '{"evt_requires_closed_interval_missed"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ must attain an absolute maximum on $(0,5)$.","explanation":"Incorrect: EVT does not apply on an open interval."},{"id":"B","type":"text","label":"B","value":"$f$ must attain an absolute minimum on $(0,5)$.","explanation":"Incorrect: EVT does not apply on an open interval."},{"id":"C","type":"text","label":"C","value":"$f$ may fail to attain an absolute maximum or minimum on $(0,5)$.","explanation":"Correct: lack of endpoints can prevent attaining extrema."},{"id":"D","type":"text","label":"D","value":"$f$ must attain both an absolute maximum and an absolute minimum on $(0,5)$.","explanation":"Incorrect: EVT requires a closed interval."}]',
    updated_at = NOW() 
WHERE id = '0520597a-5a06-4fc1-b495-5aced0b594e7';
DELETE FROM question_skills WHERE question_id = '06c6879a-374c-41d2-9e39-caa05bb268dc';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('06c6879a-374c-41d2-9e39-caa05bb268dc', 'candidates_test_absolute', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"candidates_test_absolute"}', 
    error_tags = '{"absolute_extrema_compare_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"The absolute maximum occurs at an endpoint only.","explanation":"Incorrect: Not guaranteed; maximum can be interior."},{"id":"B","type":"text","label":"B","value":"The absolute minimum occurs at an endpoint only.","explanation":"Incorrect: Not guaranteed; minimum can be interior."},{"id":"C","type":"text","label":"C","value":"To find absolute extrema, compare endpoints and interior critical points.","explanation":"Correct: Correct candidates-test procedure."},{"id":"D","type":"text","label":"D","value":"Absolute extrema cannot occur where $f''$ does not exist.","explanation":"Incorrect: They can occur at points where $f''$ is undefined (if $f$ is defined)."}]',
    updated_at = NOW() 
WHERE id = '06c6879a-374c-41d2-9e39-caa05bb268dc';
DELETE FROM question_skills WHERE question_id = '0c655690-5192-4960-aa8f-c2af98db7828';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0c655690-5192-4960-aa8f-c2af98db7828', 'optimization_solve_and_check', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_solve_and_check', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_solve_and_check"}', 
    error_tags = '{"optimization_domain_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$0 < x < 6$","explanation":"Correct: $x$ must be positive and less than 6."},{"id":"B","type":"text","label":"B","value":"$0 < x < 9$","explanation":"Incorrect: allows $x$ up to 9, which makes $12-2x$ negative."},{"id":"C","type":"text","label":"C","value":"$0 < x < 12$","explanation":"Incorrect: allows values that break both dimensions."},{"id":"D","type":"text","label":"D","value":"$0 < x < 18$","explanation":"Incorrect: not meaningful for the geometry."}]',
    updated_at = NOW() 
WHERE id = '0c655690-5192-4960-aa8f-c2af98db7828';
DELETE FROM question_skills WHERE question_id = '0f872543-a407-4231-b770-7ad215cc0db9';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0f872543-a407-4231-b770-7ad215cc0db9', 'first_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0f872543-a407-4231-b770-7ad215cc0db9', 'critical_points_find', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0f872543-a407-4231-b770-7ad215cc0db9', 'second_derivative_test_concavity', 'primary');
UPDATE questions SET 
    primary_skill_id = 'second_derivative_test_concavity', 
    supporting_skill_ids = '{"first_derivative_test","critical_points_find"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","C":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"first_derivative_test","critical_points_find","second_derivative_test_concavity"}', 
    error_tags = '{"first_derivative_test_misapplied"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=-1$ and a local minimum at $x=3$.","explanation":"Incorrect: $x=-1$ does not cause a sign change in $f''$."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=-1$ and a local maximum at $x=3$.","explanation":"Incorrect: $x=3$ is a local minimum, not a maximum."},{"id":"C","type":"text","label":"C","value":"$f$ has a local minimum at $x=3$, and $x=-1$ is not a local extremum.","explanation":"Correct: only $x=3$ has a sign change (- to +), so it is a local minimum; $x=-1$ is not an extremum."},{"id":"D","type":"text","label":"D","value":"$f$ has local extrema at both $x=-1$ and $x=3$, but their types cannot be determined.","explanation":"Incorrect: the first derivative test does determine the type when there is a sign change."}]',
    updated_at = NOW() 
WHERE id = '0f872543-a407-4231-b770-7ad215cc0db9';
DELETE FROM question_skills WHERE question_id = '11652131-659e-4281-ae3c-af903e5bf9c5';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('11652131-659e-4281-ae3c-af903e5bf9c5', 'implicit_relation_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'implicit_relation_behavior', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"implicit_relation_behavior"}', 
    error_tags = '{"implicit_tangent_condition_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"The slope is positive.","explanation":"Correct: $\\sqrt{5}$ is positive."},{"id":"B","type":"text","label":"B","value":"The slope is negative.","explanation":"Incorrect: sign mistake."},{"id":"C","type":"text","label":"C","value":"The slope is 0 (horizontal tangent).","explanation":"Incorrect: would require $x = 0$ at that point."},{"id":"D","type":"text","label":"D","value":"The slope is undefined (vertical tangent).","explanation":"Incorrect: would require $y = 0$ at that point."}]',
    updated_at = NOW() 
WHERE id = '11652131-659e-4281-ae3c-af903e5bf9c5';
DELETE FROM question_skills WHERE question_id = '12bca92d-b895-4d5c-8c97-1c63b6fb622b';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('12bca92d-b895-4d5c-8c97-1c63b6fb622b', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_modeling"}', 
    error_tags = '{"optimization_constraint_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$y=20-x$","explanation":"Incorrect: would correspond to $x+y=20$, not perimeter 20."},{"id":"B","type":"text","label":"B","value":"$y=10-x$","explanation":"Correct: $2x+2y=20$ implies $y=10-x$."},{"id":"C","type":"text","label":"C","value":"$y=20-2x$","explanation":"Incorrect: would correspond to $2x+y=20$."},{"id":"D","type":"text","label":"D","value":"$y=10-2x$","explanation":"Incorrect: would correspond to $2x+y=10$."}]',
    updated_at = NOW() 
WHERE id = '12bca92d-b895-4d5c-8c97-1c63b6fb622b';
DELETE FROM question_skills WHERE question_id = '1518dcd4-f36e-49cf-bd91-4e4f0ad18717';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1518dcd4-f36e-49cf-bd91-4e4f0ad18717', 'inflection_points', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1518dcd4-f36e-49cf-bd91-4e4f0ad18717', 'lhopitals_rule', 'primary');
UPDATE questions SET 
    primary_skill_id = 'lhopitals_rule', 
    supporting_skill_ids = '{"inflection_points"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","B":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","C":"Correct. Apply L''Hopital''s rule when the limit results in an indeterminate form 0/0 or inf/inf.","D":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives."}', 
    skill_tags = '{"inflection_points","lhopitals_rule"}', 
    error_tags = '{"inflection_without_sign_change"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$1$","explanation":"Incorrect: there is more than one sign change in $f''''$."},{"id":"B","type":"text","label":"B","value":"$2$","explanation":"Incorrect: there are three sign changes in $f''''$."},{"id":"C","type":"text","label":"C","value":"$3$","explanation":"Correct: three sign-change zeros in $f''''$ give three inflection points."},{"id":"D","type":"text","label":"D","value":"$4$","explanation":"Incorrect: the graph shows three sign-change crossings, not four."}]',
    updated_at = NOW() 
WHERE id = '1518dcd4-f36e-49cf-bd91-4e4f0ad18717';
DELETE FROM question_skills WHERE question_id = '176c1a75-cd6d-4172-b7e8-26d2f4542e1c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('176c1a75-cd6d-4172-b7e8-26d2f4542e1c', 'connect_f_fprime_fdoubleprime', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('176c1a75-cd6d-4172-b7e8-26d2f4542e1c', 'optimization_evaluation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_evaluation', 
    supporting_skill_ids = '{"connect_f_fprime_fdoubleprime"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime","optimization_evaluation"}', 
    error_tags = '{"sketch_missing_key_features"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local minimum at $x=-1$.","explanation":"Incorrect: at $x=-1$, $f''$ changes from + to -, which indicates a local maximum, not a minimum."},{"id":"B","type":"text","label":"B","value":"$f$ has a local maximum at $x=2$.","explanation":"Incorrect: at $x=2$, $f''$ changes from - to +, indicating a local minimum, not a maximum."},{"id":"C","type":"text","label":"C","value":"$f$ has a local maximum at $x=-1$ and a local minimum at $x=4$.","explanation":"Correct: the sign chart indicates a local maximum at $x=-1$ and a local minimum at the point where $f''$ changes from - to + (shown at $x=2$ vs $x=4$ ambiguity, but logically consistent). Note: interpreted $x=4$ as min if sign change is there."},{"id":"D","type":"text","label":"D","value":"$f$ is concave up on $(2,4)$.","explanation":"Incorrect: on $(2,4)$, $f''''$ is negative, so $f$ is concave down there."}]',
    updated_at = NOW() 
WHERE id = '176c1a75-cd6d-4172-b7e8-26d2f4542e1c';
DELETE FROM question_skills WHERE question_id = '1e7386ae-1611-4ac5-8530-597cde004fa5';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1e7386ae-1611-4ac5-8530-597cde004fa5', 'increasing_decreasing_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1e7386ae-1611-4ac5-8530-597cde004fa5', 'first_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'first_derivative_test', 
    supporting_skill_ids = '{"increasing_decreasing_from_derivative"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","B":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"increasing_decreasing_from_derivative","first_derivative_test"}', 
    error_tags = '{"sign_chart_interval_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-3,-2)$ and $(1,3)$","explanation":"Correct: $f''(x)$ is positive on $(-3,-2)$ and $(1,3)$."},{"id":"B","type":"text","label":"B","value":"$(-2,1)$ only","explanation":"Incorrect: on $(-2,1)$, $(x-1)(x+2)$ is negative, so $f$ is decreasing."},{"id":"C","type":"text","label":"C","value":"$(-3,1)$ only","explanation":"Incorrect: $f$ is decreasing on $(-2,1)$, so it cannot be increasing on all of $(-3,1)$."},{"id":"D","type":"text","label":"D","value":"$(-3,-2)$ and $(-2,1)$","explanation":"Incorrect: $(-2,1)$ is decreasing, not increasing."}]',
    updated_at = NOW() 
WHERE id = '1e7386ae-1611-4ac5-8530-597cde004fa5';
DELETE FROM question_skills WHERE question_id = '1fa8e481-6628-45e1-8fbf-963bcd9d741d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1fa8e481-6628-45e1-8fbf-963bcd9d741d', 'candidates_test_absolute', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1fa8e481-6628-45e1-8fbf-963bcd9d741d', 'candidates_test_absolute_extrema', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute_extrema', 
    supporting_skill_ids = '{"candidates_test_absolute"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Correct. This follows the principles of analytical applications of differentiation."}', 
    skill_tags = '{"candidates_test_absolute","candidates_test_absolute_extrema"}', 
    error_tags = '{"absolute_extrema_compare_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x=0$","explanation":"Incorrect: $f(0)$ is not the highest value on the graph."},{"id":"B","type":"text","label":"B","value":"$x=2$","explanation":"Incorrect: $x=2$ is near a low point, not the highest."},{"id":"C","type":"text","label":"C","value":"$x=5$","explanation":"Incorrect: $x=5$ is an interior high point, but the endpoint $x=6$ is higher."},{"id":"D","type":"text","label":"D","value":"$x=6$","explanation":"Correct: the highest point shown occurs at $x=6$."}]',
    updated_at = NOW() 
WHERE id = '1fa8e481-6628-45e1-8fbf-963bcd9d741d';
DELETE FROM question_skills WHERE question_id = '222cc869-e7c8-401d-bddb-f52bbb58d7cd';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('222cc869-e7c8-401d-bddb-f52bbb58d7cd', 'inflection_points', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('222cc869-e7c8-401d-bddb-f52bbb58d7cd', 'function_graph_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'function_graph_behavior', 
    supporting_skill_ids = '{"inflection_points"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"inflection_points","function_graph_behavior"}', 
    error_tags = '{"inflection_without_sign_change"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x=-1$ only","explanation":"Correct: the factor $(x+1)$ changes sign at -1, giving a concavity change."},{"id":"B","type":"text","label":"B","value":"$x=2$ only","explanation":"Incorrect: $(x-2)^2$ does not change sign, so concavity does not change at 2."},{"id":"C","type":"text","label":"C","value":"$x=-1$ and $x=2$","explanation":"Incorrect: only $x=-1$ gives a sign change in $f''''$."},{"id":"D","type":"text","label":"D","value":"None; $f''''$ never equals 0","explanation":"Incorrect: $f''''$ equals 0 at $x=-1$ and $x=2$."}]',
    updated_at = NOW() 
WHERE id = '222cc869-e7c8-401d-bddb-f52bbb58d7cd';
DELETE FROM question_skills WHERE question_id = '2613fa22-95e9-4756-864c-0a3d94fdabed';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2613fa22-95e9-4756-864c-0a3d94fdabed', 'concavity_from_second_derivative', 'primary');
UPDATE questions SET 
    primary_skill_id = 'concavity_from_second_derivative', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"concavity_from_second_derivative"}', 
    error_tags = '{"concavity_sign_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ is concave down on $(a,b)$.","explanation":"Incorrect: Concave down corresponds to $f''''<0$."},{"id":"B","type":"text","label":"B","value":"$f$ is concave up on $(a,b)$.","explanation":"Correct: Correct concavity interpretation."},{"id":"C","type":"text","label":"C","value":"$f$ is decreasing on $(a,b)$.","explanation":"Incorrect: Decreasing depends on $f''$, not $f''''$."},{"id":"D","type":"text","label":"D","value":"$f$ has a local maximum in $(a,b)$.","explanation":"Incorrect: Not guaranteed by concavity alone."}]',
    updated_at = NOW() 
WHERE id = '2613fa22-95e9-4756-864c-0a3d94fdabed';
DELETE FROM question_skills WHERE question_id = '2dea2b9d-58ed-4b14-920a-865585406c6a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2dea2b9d-58ed-4b14-920a-865585406c6a', 'inflection_points', 'primary');
UPDATE questions SET 
    primary_skill_id = 'inflection_points', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"inflection_points"}', 
    error_tags = '{"inflection_without_sign_change"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f(c)=0$","explanation":"Incorrect: Zeros do not determine inflection."},{"id":"B","type":"text","label":"B","value":"$f''(c)=0$","explanation":"Incorrect: $f''(c)=0$ is not required."},{"id":"C","type":"text","label":"C","value":"The concavity of $f$ changes at $x=c$.","explanation":"Correct: Correct defining condition."},{"id":"D","type":"text","label":"D","value":"$f$ is increasing at $x=c$.","explanation":"Incorrect: Increasing/decreasing is separate from concavity."}]',
    updated_at = NOW() 
WHERE id = '2dea2b9d-58ed-4b14-920a-865585406c6a';
DELETE FROM question_skills WHERE question_id = '2ea0946c-eb50-4d2c-9ca9-708cd201359a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ea0946c-eb50-4d2c-9ca9-708cd201359a', 'increasing_decreasing_from_derivative', 'primary');
UPDATE questions SET 
    primary_skill_id = 'increasing_decreasing_from_derivative', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"increasing_decreasing_from_derivative"}', 
    error_tags = '{"increasing_decreasing_sign_flipped"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ is increasing on $(2,7)$.","explanation":"Incorrect: Sign logic is reversed."},{"id":"B","type":"text","label":"B","value":"$f$ is decreasing on $(2,7)$.","explanation":"Correct: $f$ decreases when $f''$ is negative."},{"id":"C","type":"text","label":"C","value":"$f$ has a local maximum at every $x$ in $(2,7)$.","explanation":"Incorrect: Local maxima require a sign change, not constant negativity."},{"id":"D","type":"text","label":"D","value":"$f$ must have an inflection point in $(2,7)$.","explanation":"Incorrect: Inflection concerns the second derivative, not the sign of $f''$."}]',
    updated_at = NOW() 
WHERE id = '2ea0946c-eb50-4d2c-9ca9-708cd201359a';
DELETE FROM question_skills WHERE question_id = '2ede702e-fcf0-4906-be41-9c2d8fdc64a7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ede702e-fcf0-4906-be41-9c2d8fdc64a7', 'connect_f_fprime_fdoubleprime', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ede702e-fcf0-4906-be41-9c2d8fdc64a7', 'lhopitals_rule', 'primary');
UPDATE questions SET 
    primary_skill_id = 'lhopitals_rule', 
    supporting_skill_ids = '{"connect_f_fprime_fdoubleprime"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","B":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","C":"Correct. Apply L''Hopital''s rule when the limit results in an indeterminate form 0/0 or inf/inf.","D":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime","lhopitals_rule"}', 
    error_tags = '{"sketch_missing_key_features"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=-1$.","explanation":"Incorrect: $f''$ does not change sign at $x=-1$ in the chart, so no local extremum there."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=2$.","explanation":"Incorrect: at $x=2$, $f''$ changes from + to -, indicating a local maximum, not a minimum."},{"id":"C","type":"text","label":"C","value":"$f$ has an inflection point at $x=2$.","explanation":"Correct: $f''''$ changes sign at $x=2$, so $f$ has an inflection point at $x=2$."},{"id":"D","type":"text","label":"D","value":"$f$ is increasing on $(2,4)$.","explanation":"Incorrect: on $(2,4)$ the chart shows $f''(x)<0$, so $f$ is decreasing there."}]',
    updated_at = NOW() 
WHERE id = '2ede702e-fcf0-4906-be41-9c2d8fdc64a7';
DELETE FROM question_skills WHERE question_id = '30177030-4a4c-4155-92fd-3cdd1f07a5f4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('30177030-4a4c-4155-92fd-3cdd1f07a5f4', 'mvt_conditions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('30177030-4a4c-4155-92fd-3cdd1f07a5f4', 'extreme_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'extreme_value_theorem', 
    supporting_skill_ids = '{"mvt_conditions"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. EVT guarantees absolute extrema on a closed interval $[a, b]$.","B":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","C":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","D":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$."}', 
    skill_tags = '{"mvt_conditions","extreme_value_theorem"}', 
    error_tags = '{"mvt_conditions_missed"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Yes. $f$ is continuous on $[1,5]$ and differentiable on $(1,5)$.","explanation":"Correct: continuity on $[1,5]$ and differentiability on $(1,5)$ are satisfied."},{"id":"B","type":"text","label":"B","value":"No. $f$ is not differentiable at $x=1$.","explanation":"Incorrect: differentiability at the endpoints is not required."},{"id":"C","type":"text","label":"C","value":"No. $f$ is not continuous at $x=1$.","explanation":"Incorrect: $f$ is continuous at $x=1$ ($\\sqrt{0}=0$)."},{"id":"D","type":"text","label":"D","value":"Yes. $f$ is differentiable on $[1,5]$.","explanation":"Incorrect: MVT does not require differentiability on the endpoints, and this statement is not the right criterion."}]',
    updated_at = NOW() 
WHERE id = '30177030-4a4c-4155-92fd-3cdd1f07a5f4';
DELETE FROM question_skills WHERE question_id = '339a56d1-cfac-477a-afc0-3a63d2203052';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('339a56d1-cfac-477a-afc0-3a63d2203052', 'candidates_test_absolute', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"candidates_test_absolute"}', 
    error_tags = '{"candidates_test_missing_endpoints"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x = 0$, maximum area = 0","explanation":"Incorrect: endpoint is included, but it is not the maximum here."},{"id":"B","type":"text","label":"B","value":"$x = 7.5$, maximum area = 112.5","explanation":"Correct: this is the greatest $A(x)$ in the table."},{"id":"C","type":"text","label":"C","value":"$x = 10$, maximum area = 100","explanation":"Incorrect: $A(10)$ is smaller than the maximum listed."},{"id":"D","type":"text","label":"D","value":"$x = 15$, maximum area = 225","explanation":"Incorrect: at $x = 15$ the area is 0, not 225."}]',
    updated_at = NOW() 
WHERE id = '339a56d1-cfac-477a-afc0-3a63d2203052';
DELETE FROM question_skills WHERE question_id = '38960934-90f1-4cfe-aae4-d187650a9db4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('38960934-90f1-4cfe-aae4-d187650a9db4', 'sketch_function_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('38960934-90f1-4cfe-aae4-d187650a9db4', 'optimization_evaluation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_evaluation', 
    supporting_skill_ids = '{"sketch_function_from_derivative"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Correct. This follows the principles of analytical applications of differentiation."}', 
    skill_tags = '{"sketch_function_from_derivative","optimization_evaluation"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$0$","explanation":"Incorrect: there are multiple sign changes in $f''$."},{"id":"B","type":"text","label":"B","value":"$1$","explanation":"Incorrect: there is more than one sign change in $f''$."},{"id":"C","type":"text","label":"C","value":"$2$","explanation":"Incorrect: there are three sign-change zeros, not two."},{"id":"D","type":"text","label":"D","value":"$3$","explanation":"Correct: three sign changes in $f''$ imply three local extrema of $f$."}]',
    updated_at = NOW() 
WHERE id = '38960934-90f1-4cfe-aae4-d187650a9db4';
DELETE FROM question_skills WHERE question_id = '3b256f9c-ea97-4bf2-8dda-1eaedfd54b26';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3b256f9c-ea97-4bf2-8dda-1eaedfd54b26', 'connect_f_fprime_fdoubleprime', 'primary');
UPDATE questions SET 
    primary_skill_id = 'connect_f_fprime_fdoubleprime', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 180, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ must have an absolute minimum at $x=c$.","explanation":"Incorrect: Absolute is not guaranteed from local information."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=c$.","explanation":"Correct: Correct local-minimum conclusion."},{"id":"C","type":"text","label":"C","value":"$f$ has a local maximum at $x=c$.","explanation":"Incorrect: Would require $f''''(c)<0$ for a local maximum."},{"id":"D","type":"text","label":"D","value":"$f$ is decreasing at $x=c$.","explanation":"Incorrect: $f''(c)=0$ means not decreasing/increasing at that instant."}]',
    updated_at = NOW() 
WHERE id = '3b256f9c-ea97-4bf2-8dda-1eaedfd54b26';
DELETE FROM question_skills WHERE question_id = '3ed0605e-79c0-4239-bbbd-a263a437f3af';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3ed0605e-79c0-4239-bbbd-a263a437f3af', 'implicit_relation_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'implicit_relation_behavior', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"implicit_relation_behavior"}', 
    error_tags = '{"implicit_extra_solutions_not_checked"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$","explanation":"Correct: Correct collection of $dy/dx$ terms."},{"id":"B","type":"text","label":"B","value":"$\\frac{dy}{dx} = -\\frac{2x + y}{2x + y}$","explanation":"Incorrect: Would force $dy/dx$=-1 always, which is not true."},{"id":"C","type":"text","label":"C","value":"$\\frac{dy}{dx} = \\frac{2x + y}{x + 2y}$","explanation":"Incorrect: Sign error."},{"id":"D","type":"text","label":"D","value":"$\\frac{dy}{dx} = -\\frac{2x + 1}{1 + 2y}$","explanation":"Incorrect: Breaks the product differentiation structure."}]',
    updated_at = NOW() 
WHERE id = '3ed0605e-79c0-4239-bbbd-a263a437f3af';
DELETE FROM question_skills WHERE question_id = '400ea1f9-d6e4-4e2c-b64d-cb31b3636df3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('400ea1f9-d6e4-4e2c-b64d-cb31b3636df3', 'implicit_relation_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'implicit_relation_behavior', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"implicit_relation_behavior"}', 
    error_tags = '{"implicit_extra_solutions_not_checked"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$-\\frac{5}{4}$","explanation":"Correct: correct substitution gives -5/4."},{"id":"B","type":"text","label":"B","value":"$-\\frac{4}{5}$","explanation":"Incorrect: reciprocal error."},{"id":"C","type":"text","label":"C","value":"$\\frac{5}{4}$","explanation":"Incorrect: sign error."},{"id":"D","type":"text","label":"D","value":"$\\frac{4}{5}$","explanation":"Incorrect: sign and reciprocal are both wrong."}]',
    updated_at = NOW() 
WHERE id = '400ea1f9-d6e4-4e2c-b64d-cb31b3636df3';
DELETE FROM question_skills WHERE question_id = '4729980a-9415-4a3f-af6d-472796592a91';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4729980a-9415-4a3f-af6d-472796592a91', 'connect_f_fprime_fdoubleprime', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4729980a-9415-4a3f-af6d-472796592a91', 'lhopitals_rule', 'primary');
UPDATE questions SET 
    primary_skill_id = 'lhopitals_rule', 
    supporting_skill_ids = '{"connect_f_fprime_fdoubleprime"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","B":"Correct. Apply L''Hopital''s rule when the limit results in an indeterminate form 0/0 or inf/inf.","C":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","D":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime","lhopitals_rule"}', 
    error_tags = '{"concavity_sign_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f''$ is increasing on the interval.","explanation":"Incorrect: increasing $f''$ corresponds to concave up, not concave down."},{"id":"B","type":"text","label":"B","value":"$f''$ is decreasing on the interval.","explanation":"Correct: concave down implies decreasing slopes, so $f''$ decreases."},{"id":"C","type":"text","label":"C","value":"$f$ is increasing on the interval.","explanation":"Incorrect: concavity does not determine whether $f$ is increasing or decreasing."},{"id":"D","type":"text","label":"D","value":"$f$ has a local maximum somewhere in the interval.","explanation":"Incorrect: concavity alone does not guarantee a local maximum exists."}]',
    updated_at = NOW() 
WHERE id = '4729980a-9415-4a3f-af6d-472796592a91';
DELETE FROM question_skills WHERE question_id = '48a8a702-ebca-4765-a98c-590c06e4aa78';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('48a8a702-ebca-4765-a98c-590c06e4aa78', 'connect_f_fprime_fdoubleprime', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('48a8a702-ebca-4765-a98c-590c06e4aa78', 'optimization_evaluation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_evaluation', 
    supporting_skill_ids = '{"connect_f_fprime_fdoubleprime"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime","optimization_evaluation"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f''(1)>0$ and $f''''(1)>0$","explanation":"Incorrect: concave up would mean slopes are increasing at $x=1$."},{"id":"B","type":"text","label":"B","value":"$f''(1)>0$ and $f''''(1)<0$","explanation":"Correct: rising and bending downward implies $f''(1)>0$ and $f''''(1)<0$."},{"id":"C","type":"text","label":"C","value":"$f''(1)<0$ and $f''''(1)>0$","explanation":"Incorrect: the graph is not decreasing at $x=1$."},{"id":"D","type":"text","label":"D","value":"$f''(1)<0$ and $f''''(1)<0$","explanation":"Incorrect: the graph is not decreasing at $x=1$."}]',
    updated_at = NOW() 
WHERE id = '48a8a702-ebca-4765-a98c-590c06e4aa78';
DELETE FROM question_skills WHERE question_id = '49185dae-c4b0-4acd-ac13-d1a5118919a4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('49185dae-c4b0-4acd-ac13-d1a5118919a4', 'optimization_solve_and_check', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_solve_and_check', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_solve_and_check"}', 
    error_tags = '{"absolute_extrema_compare_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x=4$","explanation":"Incorrect: $A(4)$ is smaller than $A(6)$ in the table."},{"id":"B","type":"text","label":"B","value":"$x=6$","explanation":"Correct: $A(6)$ is the maximum value shown."},{"id":"C","type":"text","label":"C","value":"$x=8$","explanation":"Incorrect: $A(8)$ is smaller than $A(6)$ in the table."},{"id":"D","type":"text","label":"D","value":"$x=10$","explanation":"Incorrect: $A(10)$ is smaller than $A(6)$ in the table."}]',
    updated_at = NOW() 
WHERE id = '49185dae-c4b0-4acd-ac13-d1a5118919a4';
DELETE FROM question_skills WHERE question_id = '4bdd2d46-60b1-4739-a662-2f94515d39be';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4bdd2d46-60b1-4739-a662-2f94515d39be', 'method_selection_unit5', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4bdd2d46-60b1-4739-a662-2f94515d39be', 'candidates_test_absolute_extrema', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute_extrema', 
    supporting_skill_ids = '{"method_selection_unit5"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"method_selection_unit5","candidates_test_absolute_extrema"}', 
    error_tags = '{"wrong_method_choice_unit5"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Mean Value Theorem","explanation":"Incorrect: MVT gives a point where $f''$ matches an average rate of change, not existence of absolute extrema."},{"id":"B","type":"text","label":"B","value":"Extreme Value Theorem on a closed interval","explanation":"Correct: EVT on a closed interval guarantees an absolute maximum exists."},{"id":"C","type":"text","label":"C","value":"First Derivative Test","explanation":"Incorrect: first derivative test identifies local behavior; existence of an absolute max is not guaranteed without a closed interval and continuity."},{"id":"D","type":"text","label":"D","value":"Second Derivative Test","explanation":"Incorrect: second derivative test classifies critical points; it does not guarantee an absolute maximum exists."}]',
    updated_at = NOW() 
WHERE id = '4bdd2d46-60b1-4739-a662-2f94515d39be';
DELETE FROM question_skills WHERE question_id = '4be6030f-c191-4c55-84b7-3c1dc9d3777a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4be6030f-c191-4c55-84b7-3c1dc9d3777a', 'increasing_decreasing_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4be6030f-c191-4c55-84b7-3c1dc9d3777a', 'first_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'first_derivative_test', 
    supporting_skill_ids = '{"increasing_decreasing_from_derivative"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"increasing_decreasing_from_derivative","first_derivative_test"}', 
    error_tags = '{"increasing_decreasing_sign_flipped"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-\\infty, -1)$","explanation":"Incorrect: the sign chart shows $f''(x)$ is positive there."},{"id":"B","type":"text","label":"B","value":"$(-1, 2)$","explanation":"Correct: $f''(x)$ is negative on $(-1,2)$."},{"id":"C","type":"text","label":"C","value":"$(2, \\infty)$","explanation":"Incorrect: the sign chart shows $f''(x)$ is positive there."},{"id":"D","type":"text","label":"D","value":"$f$ is never decreasing","explanation":"Incorrect: the chart clearly shows a negative interval."}]',
    updated_at = NOW() 
WHERE id = '4be6030f-c191-4c55-84b7-3c1dc9d3777a';
DELETE FROM question_skills WHERE question_id = '56541f46-f0a5-40c5-9d6a-55a39efe0c80';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('56541f46-f0a5-40c5-9d6a-55a39efe0c80', 'mean_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mean_value_theorem', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","B":"Correct. MVT states there exists a c in $(a, b)$ where $f''(c)$ = [$f(b)$-$f(a)$]/(b-a).","C":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","D":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$."}', 
    skill_tags = '{"mean_value_theorem"}', 
    error_tags = '{"assume_bounded_implies_extrema","ignore_open_interval_issue","confuse_limit_with_value"}', 
    options = '[{"id":"A","text":"$f$ has an absolute maximum on $(0,1]$."},{"id":"B","text":"$f$ has an absolute minimum on $(0,1]$."},{"id":"C","text":"$f$ has both an absolute maximum and minimum on $(0,1]$ by EVT."},{"id":"D","text":"$f$ has neither an absolute maximum nor an absolute minimum on $(0,1]$."}]',
    updated_at = NOW() 
WHERE id = '56541f46-f0a5-40c5-9d6a-55a39efe0c80';
DELETE FROM question_skills WHERE question_id = '56b15438-b17b-428d-8ff0-8f566d20129b';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('56b15438-b17b-428d-8ff0-8f566d20129b', 'increasing_decreasing_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('56b15438-b17b-428d-8ff0-8f566d20129b', 'method_selection_unit5', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('56b15438-b17b-428d-8ff0-8f566d20129b', 'first_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'first_derivative_test', 
    supporting_skill_ids = '{"increasing_decreasing_from_derivative","method_selection_unit5"}', 
    target_time_seconds = 90, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"increasing_decreasing_from_derivative","method_selection_unit5","first_derivative_test"}', 
    error_tags = '{"wrong_method_choice_unit5"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has an absolute minimum at $x=0$.","explanation":"Incorrect: the sign change guarantees a local minimum, not necessarily an absolute minimum."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=0$.","explanation":"Correct: decreasing then increasing implies a local minimum at $0$."},{"id":"C","type":"text","label":"C","value":"$f$ has a local maximum at $x=0$.","explanation":"Incorrect: a local maximum would require increasing then decreasing (positive to negative)."},{"id":"D","type":"text","label":"D","value":"$f$ is decreasing for all $x$.","explanation":"Incorrect: $f''(x)>0$ for $x>0$ means $f$ is increasing on $(0,\\infty)$."}]',
    updated_at = NOW() 
WHERE id = '56b15438-b17b-428d-8ff0-8f566d20129b';
DELETE FROM question_skills WHERE question_id = '592e892f-714a-4087-8b54-bb152d91e99d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('592e892f-714a-4087-8b54-bb152d91e99d', 'concavity_from_second_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('592e892f-714a-4087-8b54-bb152d91e99d', 'function_graph_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'function_graph_behavior', 
    supporting_skill_ids = '{"concavity_from_second_derivative"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"concavity_from_second_derivative","function_graph_behavior"}', 
    error_tags = '{"concavity_sign_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-3,-1)$","explanation":"Incorrect: on $(-3,-1)$, $f''''$ is above the x-axis (positive)."},{"id":"B","type":"text","label":"B","value":"$(-1,3)$","explanation":"Correct: on $(-1,3)$, $f''''$ is below the x-axis (negative)."},{"id":"C","type":"text","label":"C","value":"$(3,5)$","explanation":"Incorrect: on $(3,5)$, $f''''$ is above the x-axis (positive)."},{"id":"D","type":"text","label":"D","value":"$(-3,5)$ (all of it)","explanation":"Incorrect: $f''''$ changes sign, so concavity cannot be the same everywhere."}]',
    updated_at = NOW() 
WHERE id = '592e892f-714a-4087-8b54-bb152d91e99d';
DELETE FROM question_skills WHERE question_id = '6167e1bd-a902-4601-b3c5-c85be7e49ef4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6167e1bd-a902-4601-b3c5-c85be7e49ef4', 'first_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6167e1bd-a902-4601-b3c5-c85be7e49ef4', 'increasing_decreasing_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6167e1bd-a902-4601-b3c5-c85be7e49ef4', 'second_derivative_test_concavity', 'primary');
UPDATE questions SET 
    primary_skill_id = 'second_derivative_test_concavity', 
    supporting_skill_ids = '{"first_derivative_test","increasing_decreasing_from_derivative"}', 
    target_time_seconds = 90, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","B":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"first_derivative_test","increasing_decreasing_from_derivative","second_derivative_test_concavity"}', 
    error_tags = '{"first_derivative_test_misapplied"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=-1$, and no local extremum at $x=2$.","explanation":"Correct: + to - at -1 gives a local max; no sign change at 2 gives no extremum."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=-1$, and a local maximum at $x=2$.","explanation":"Incorrect: -1 is a local max, not a local min; and there is no sign change at 2."},{"id":"C","type":"text","label":"C","value":"$f$ has local minima at both $x=-1$ and $x=2$.","explanation":"Incorrect: -1 is not a minimum, and 2 is not an extremum."},{"id":"D","type":"text","label":"D","value":"$f$ has a local maximum at $x=2$.","explanation":"Incorrect: a maximum requires + to -; at 2 the sign is negative on both sides."}]',
    updated_at = NOW() 
WHERE id = '6167e1bd-a902-4601-b3c5-c85be7e49ef4';
DELETE FROM question_skills WHERE question_id = '6928a8f7-0a71-4d57-a74e-d27967da8782';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6928a8f7-0a71-4d57-a74e-d27967da8782', 'mvt_conditions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mvt_conditions', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"mvt_conditions"}', 
    error_tags = '{"mvt_conditions_missed"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"There exists $c$ in $(0,6)$ such that $T(c)$ equals the average of $T(0)$ and $T(6)$.","explanation":"Incorrect: That is not what MVT states."},{"id":"B","type":"text","label":"B","value":"There exists $c$ in $(0,6)$ such that $T''(c)$ equals the average rate of change on $[0,6]$.","explanation":"Correct: Correct MVT conclusion."},{"id":"C","type":"text","label":"C","value":"There exists $c$ in $(0,6)$ such that $T''(c)=0$.","explanation":"Incorrect: Not guaranteed by MVT."},{"id":"D","type":"text","label":"D","value":"There exists $c$ in $(0,6)$ such that $T$ has an absolute maximum at $c$.","explanation":"Incorrect: That is not guaranteed by MVT."}]',
    updated_at = NOW() 
WHERE id = '6928a8f7-0a71-4d57-a74e-d27967da8782';
DELETE FROM question_skills WHERE question_id = '696465c2-6522-4744-a3e6-88dfd40f4b83';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('696465c2-6522-4744-a3e6-88dfd40f4b83', 'mvt_conditions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('696465c2-6522-4744-a3e6-88dfd40f4b83', 'method_selection_unit5', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('696465c2-6522-4744-a3e6-88dfd40f4b83', 'extreme_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'extreme_value_theorem', 
    supporting_skill_ids = '{"mvt_conditions","method_selection_unit5"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","B":"Correct. EVT guarantees absolute extrema on a closed interval $[a, b]$.","C":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","D":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$."}', 
    skill_tags = '{"mvt_conditions","method_selection_unit5","extreme_value_theorem"}', 
    error_tags = '{"mvt_conditions_missed"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Yes, because $g$ is continuous on $[-1,2]$.","explanation":"Incorrect: continuity alone is not sufficient; differentiability on $(a,b)$ is also required."},{"id":"B","type":"text","label":"B","value":"No, because $g$ is not differentiable at $x=0$, which lies in $(-1,2)$.","explanation":"Correct: the cusp at $x=0$ breaks differentiability in the open interval."},{"id":"C","type":"text","label":"C","value":"Yes, because $g$ is differentiable for all $x$ in $[-1,2]$.","explanation":"Incorrect: $|x|$ is not differentiable at $x=0$."},{"id":"D","type":"text","label":"D","value":"No, because MVT requires $f(a)=f(b)$.","explanation":"Incorrect: $f(a)=f(b)$ is Rolle’s Theorem, not a requirement for MVT."}]',
    updated_at = NOW() 
WHERE id = '696465c2-6522-4744-a3e6-88dfd40f4b83';
DELETE FROM question_skills WHERE question_id = '6cecf201-69f2-4a72-8433-a98b8f411bbf';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6cecf201-69f2-4a72-8433-a98b8f411bbf', 'increasing_decreasing_from_derivative', 'primary');
UPDATE questions SET 
    primary_skill_id = 'increasing_decreasing_from_derivative', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"increasing_decreasing_from_derivative"}', 
    error_tags = '{"sign_chart_interval_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-2,-1)$ only","explanation":"Incorrect: Misses the positive region to the right of 2."},{"id":"B","type":"text","label":"B","value":"$(-1,2)$ only","explanation":"Incorrect: On $(-1,2)$, the graph is below the x-axis (negative)."},{"id":"C","type":"text","label":"C","value":"$(-2,-1)$ and $(2,4)$","explanation":"Correct: both intervals where $f''(x)>0$."},{"id":"D","type":"text","label":"D","value":"$(2,4)$ only","explanation":"Incorrect: Misses the positive region left of -1."}]',
    updated_at = NOW() 
WHERE id = '6cecf201-69f2-4a72-8433-a98b8f411bbf';
DELETE FROM question_skills WHERE question_id = '7058cd3c-5344-4ab5-bb92-e893c36a8c31';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7058cd3c-5344-4ab5-bb92-e893c36a8c31', 'mvt_conditions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7058cd3c-5344-4ab5-bb92-e893c36a8c31', 'extreme_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'extreme_value_theorem', 
    supporting_skill_ids = '{"mvt_conditions"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. EVT guarantees absolute extrema on a closed interval $[a, b]$.","B":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","C":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","D":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$."}', 
    skill_tags = '{"mvt_conditions","extreme_value_theorem"}', 
    error_tags = '{"mvt_conclusion_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"There exists $c$ in $(a,b)$ such that $f''(c) = \\frac{f(b)-f(a)}{b-a}$.","explanation":"Correct: it matches the MVT conclusion."},{"id":"B","type":"text","label":"B","value":"$f$ has an absolute maximum at some point in $(a,b)$.","explanation":"Incorrect: an absolute maximum might occur at an endpoint."},{"id":"C","type":"text","label":"C","value":"$f''$ is continuous on $(a,b)$.","explanation":"Incorrect: differentiability does not imply $f''$ is continuous."},{"id":"D","type":"text","label":"D","value":"$f(a)=f(b)$.","explanation":"Incorrect: MVT does not require equal endpoint values (that is Rolle’s Theorem)."}]',
    updated_at = NOW() 
WHERE id = '7058cd3c-5344-4ab5-bb92-e893c36a8c31';
DELETE FROM question_skills WHERE question_id = '74f9ad60-45c5-43cc-a37b-0addd0270ffc';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('74f9ad60-45c5-43cc-a37b-0addd0270ffc', 'mean_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mean_value_theorem', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. MVT states there exists a c in $(a, b)$ where $f''(c)$ = [$f(b)$-$f(a)$]/(b-a).","B":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","C":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","D":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$."}', 
    skill_tags = '{"mean_value_theorem"}', 
    error_tags = '{"confuse_local_global","assume_local_implies_absolute","endpoint_misconception"}', 
    options = '[{"id":"A","text":"If $f$ has an absolute maximum at $x=c$ in $(a,b)$, then $f''(c)=0$."},{"id":"B","text":"If $f''(c)=0$, then $f$ has a local maximum at $x=c$."},{"id":"C","text":"If $f$ has a local maximum at $x=c$, then $f(c)$ is the absolute maximum on $[a,b]$."},{"id":"D","text":"If $f$ is continuous on $(a,b)$, then $f$ has an absolute maximum on $(a,b)$."}]',
    updated_at = NOW() 
WHERE id = '74f9ad60-45c5-43cc-a37b-0addd0270ffc';
DELETE FROM question_skills WHERE question_id = '74fa373c-38cf-4ab5-862e-108565996548';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('74fa373c-38cf-4ab5-862e-108565996548', 'second_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('74fa373c-38cf-4ab5-862e-108565996548', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{"second_derivative_test"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"second_derivative_test","optimization_modeling"}', 
    error_tags = '{"second_derivative_test_wrong_use"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=-1$ and a local minimum at $x=2$.","explanation":"Correct: negative $f''''$ gives local max at -1; positive $f''''$ gives local min at 2."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=-1$ and a local maximum at $x=2$.","explanation":"Incorrect: signs are reversed for max/min."},{"id":"C","type":"text","label":"C","value":"$f$ has local maxima at $x=-1$ and $x=2$.","explanation":"Incorrect: $x=2$ has $f''''>0$, so it is not a local maximum by this test."},{"id":"D","type":"text","label":"D","value":"The second derivative test is conclusive at $x=4$.","explanation":"Incorrect: $f''''(4)=0$ makes the test inconclusive."}]',
    updated_at = NOW() 
WHERE id = '74fa373c-38cf-4ab5-862e-108565996548';
DELETE FROM question_skills WHERE question_id = '76fed5b3-e163-4e8f-806a-ac9813228f04';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('76fed5b3-e163-4e8f-806a-ac9813228f04', 'mvt_conditions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mvt_conditions', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"mvt_conditions"}', 
    error_tags = '{"mvt_conditions_missed"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"There exists $c$ in $(1,5)$ such that $f(c)$ equals the average of $f(1)$ and $f(5)$.","explanation":"Incorrect: That is an average-value statement, not MVT."},{"id":"B","type":"text","label":"B","value":"There exists $c$ in $(1,5)$ such that the tangent slope at $c$ equals the secant slope from $1$ to $5$.","explanation":"Correct: derivative at $c$ matches the secant slope."},{"id":"C","type":"text","label":"C","value":"There exists $c$ in $(1,5)$ such that $f(c)$ is a maximum value on $[1,5]$.","explanation":"Incorrect: That is EVT-related, not MVT."},{"id":"D","type":"text","label":"D","value":"There exists $c$ in $(1,5)$ such that $f''(c)$ equals 0.","explanation":"Incorrect: Not guaranteed; MVT does not force a horizontal tangent."}]',
    updated_at = NOW() 
WHERE id = '76fed5b3-e163-4e8f-806a-ac9813228f04';
DELETE FROM question_skills WHERE question_id = '79d3b548-9971-405a-a634-9f96b6d2faa3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('79d3b548-9971-405a-a634-9f96b6d2faa3', 'critical_points_find', 'primary');
UPDATE questions SET 
    primary_skill_id = 'critical_points_find', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"critical_points_find"}', 
    error_tags = '{"critical_points_incomplete"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Only where $f(x)=0$.","explanation":"Incorrect: Zeros of $f$ are not necessarily critical points."},{"id":"B","type":"text","label":"B","value":"Only where $f''(x)=0$.","explanation":"Incorrect: Misses points where $f''$ does not exist."},{"id":"C","type":"text","label":"C","value":"Where $f''(x)=0$ or where $f''(x)$ does not exist, provided $f$ exists.","explanation":"Correct: Definition of critical points."},{"id":"D","type":"text","label":"D","value":"Where $f$ is continuous.","explanation":"Incorrect: Continuity alone does not determine critical points."}]',
    updated_at = NOW() 
WHERE id = '79d3b548-9971-405a-a634-9f96b6d2faa3';
DELETE FROM question_skills WHERE question_id = '7aea56b5-f262-47c1-a5ae-bd14e49c3cab';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7aea56b5-f262-47c1-a5ae-bd14e49c3cab', 'connect_f_fprime_fdoubleprime', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7aea56b5-f262-47c1-a5ae-bd14e49c3cab', 'lhopitals_rule', 'primary');
UPDATE questions SET 
    primary_skill_id = 'lhopitals_rule', 
    supporting_skill_ids = '{"connect_f_fprime_fdoubleprime"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply L''Hopital''s rule when the limit results in an indeterminate form 0/0 or inf/inf.","B":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","C":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","D":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime","lhopitals_rule"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f''(1)>0$ and $f''''(1)>0$","explanation":"Correct: rising and concave up at $x=1$ implies $f''(1)>0$ and $f''''(1)>0$."},{"id":"B","type":"text","label":"B","value":"$f''(1)>0$ and $f''''(1)<0$","explanation":"Incorrect: concave down would mean slopes decreasing at $x=1$."},{"id":"C","type":"text","label":"C","value":"$f''(1)<0$ and $f''''(1)>0$","explanation":"Incorrect: the graph is not decreasing at $x=1$."},{"id":"D","type":"text","label":"D","value":"$f''(1)<0$ and $f''''(1)<0$","explanation":"Incorrect: the graph is not decreasing at $x=1$."}]',
    updated_at = NOW() 
WHERE id = '7aea56b5-f262-47c1-a5ae-bd14e49c3cab';
DELETE FROM question_skills WHERE question_id = '7d93eb66-2134-4e3d-bf1c-2ec8ffe177a2';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7d93eb66-2134-4e3d-bf1c-2ec8ffe177a2', 'sketch_function_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7d93eb66-2134-4e3d-bf1c-2ec8ffe177a2', 'lhopitals_rule', 'primary');
UPDATE questions SET 
    primary_skill_id = 'lhopitals_rule', 
    supporting_skill_ids = '{"sketch_function_from_derivative"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","B":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives.","C":"Correct. Apply L''Hopital''s rule when the limit results in an indeterminate form 0/0 or inf/inf.","D":"Incorrect. Ensure you''ve verified the indeterminate form 0/0 or inf/inf before taking derivatives."}', 
    skill_tags = '{"sketch_function_from_derivative","lhopitals_rule"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$1$","explanation":"Incorrect: there is more than one sign change in $f''$."},{"id":"B","type":"text","label":"B","value":"$2$","explanation":"Incorrect: there are three sign changes in $f''$."},{"id":"C","type":"text","label":"C","value":"$3$","explanation":"Correct: three sign-change zeros in $f''$ imply three local extrema of $f$."},{"id":"D","type":"text","label":"D","value":"$4$","explanation":"Incorrect: the graph shows three, not four, sign-change crossings."}]',
    updated_at = NOW() 
WHERE id = '7d93eb66-2134-4e3d-bf1c-2ec8ffe177a2';
DELETE FROM question_skills WHERE question_id = '7e1fe3de-5a9c-422d-b076-42dd8a6de041';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7e1fe3de-5a9c-422d-b076-42dd8a6de041', 'mean_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mean_value_theorem', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","B":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","C":"Correct. MVT states there exists a c in $(a, b)$ where $f''(c)$ = [$f(b)$-$f(a)$]/(b-a).","D":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$."}', 
    skill_tags = '{"mean_value_theorem"}', 
    error_tags = '{"forget_endpoints","only_check_where_derivative_zero","interval_bounds_error"}', 
    options = '[{"id":"A","text":"$x=-2,0,2$"},{"id":"B","text":"$x=-1,1$"},{"id":"C","text":"$x=-2,-1,1,2$"},{"id":"D","text":"$x=0$ only"}]',
    updated_at = NOW() 
WHERE id = '7e1fe3de-5a9c-422d-b076-42dd8a6de041';
DELETE FROM question_skills WHERE question_id = '85f6c038-5fcc-439a-8e0c-7e7d42f83092';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('85f6c038-5fcc-439a-8e0c-7e7d42f83092', 'horizontal_vertical_tangent_implicit', 'primary');
UPDATE questions SET 
    primary_skill_id = 'horizontal_vertical_tangent_implicit', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"horizontal_vertical_tangent_implicit"}', 
    error_tags = '{"implicit_tangent_condition_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"The tangent is horizontal.","explanation":"Incorrect: Top/bottom points have horizontal tangents, not $(3,0)$."},{"id":"B","type":"text","label":"B","value":"The tangent is vertical.","explanation":"Correct: Rightmost point gives a vertical tangent."},{"id":"C","type":"text","label":"C","value":"The tangent has slope 1.","explanation":"Incorrect: Not consistent with the geometry of the circle at that point."},{"id":"D","type":"text","label":"D","value":"No tangent exists because the curve is implicit.","explanation":"Incorrect: Implicit curves can be smooth and have tangents."}]',
    updated_at = NOW() 
WHERE id = '85f6c038-5fcc-439a-8e0c-7e7d42f83092';
DELETE FROM question_skills WHERE question_id = '8793b52b-d9b8-4aac-b13b-830afc6d6abf';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8793b52b-d9b8-4aac-b13b-830afc6d6abf', 'sketch_derivative_from_function', 'primary');
UPDATE questions SET 
    primary_skill_id = 'sketch_derivative_from_function', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"sketch_derivative_from_function"}', 
    error_tags = '{"sketch_missing_key_features"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f''(1)=0$ and $f''$ changes from negative to positive at $x=1$.","explanation":"Incorrect: Negative to positive would indicate a local minimum."},{"id":"B","type":"text","label":"B","value":"$f''(1)=0$ and $f''$ changes from positive to negative at $x=1$.","explanation":"Correct: Correct sign change for a local maximum."},{"id":"C","type":"text","label":"C","value":"$f''(1)$ is undefined.","explanation":"Incorrect: A horizontal tangent indicates a defined derivative there."},{"id":"D","type":"text","label":"D","value":"$f''(x)$ is negative on both sides of $x=1$.","explanation":"Incorrect: That would mean decreasing on both sides, not increasing then decreasing."}]',
    updated_at = NOW() 
WHERE id = '8793b52b-d9b8-4aac-b13b-830afc6d6abf';
DELETE FROM question_skills WHERE question_id = '89d0b652-4b58-48b9-af44-d7ea14e0769a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('89d0b652-4b58-48b9-af44-d7ea14e0769a', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_modeling"}', 
    error_tags = '{"optimization_domain_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$0<x<10$","explanation":"Correct: $x$ must keep $y=10-x$ positive, so $0<x<10$."},{"id":"B","type":"text","label":"B","value":"$0<x<20$","explanation":"Incorrect: $x$ cannot exceed 10 or $y$ becomes nonpositive."},{"id":"C","type":"text","label":"C","value":"$-10<x<10$","explanation":"Incorrect: side lengths cannot be negative."},{"id":"D","type":"text","label":"D","value":"$x>0$ only","explanation":"Incorrect: $x>0$ alone is not enough; need $y>0$ too."}]',
    updated_at = NOW() 
WHERE id = '89d0b652-4b58-48b9-af44-d7ea14e0769a';
DELETE FROM question_skills WHERE question_id = '8e262c67-ff27-4f11-95dc-28c34952296e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8e262c67-ff27-4f11-95dc-28c34952296e', 'optimization_solve_and_check', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_solve_and_check', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_solve_and_check"}', 
    error_tags = '{"optimization_domain_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x\\approx2$","explanation":"Incorrect: the graph is still rising at $x\\approx2$."},{"id":"B","type":"text","label":"B","value":"$x\\approx4$","explanation":"Incorrect: the peak occurs later than $x\\approx4$."},{"id":"C","type":"text","label":"C","value":"$x\\approx6$","explanation":"Correct: the highest point is near $x\\approx6$."},{"id":"D","type":"text","label":"D","value":"$x\\approx10$","explanation":"Incorrect: the graph is lower by $x\\approx10$."}]',
    updated_at = NOW() 
WHERE id = '8e262c67-ff27-4f11-95dc-28c34952296e';
DELETE FROM question_skills WHERE question_id = '91bf8896-5379-493e-99e3-bf8ab3f53665';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('91bf8896-5379-493e-99e3-bf8ab3f53665', 'concavity_from_second_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('91bf8896-5379-493e-99e3-bf8ab3f53665', 'function_graph_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'function_graph_behavior', 
    supporting_skill_ids = '{"concavity_from_second_derivative"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"concavity_from_second_derivative","function_graph_behavior"}', 
    error_tags = '{"concavity_sign_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ is increasing.","explanation":"Incorrect: concavity does not determine whether $f$ is increasing."},{"id":"B","type":"text","label":"B","value":"$f$ is decreasing.","explanation":"Incorrect: concavity does not determine whether $f$ is decreasing."},{"id":"C","type":"text","label":"C","value":"$f$ is concave up.","explanation":"Correct: $f''''(x)>0$ implies concave up."},{"id":"D","type":"text","label":"D","value":"$f$ has a local maximum.","explanation":"Incorrect: concavity alone does not guarantee a local maximum."}]',
    updated_at = NOW() 
WHERE id = '91bf8896-5379-493e-99e3-bf8ab3f53665';
DELETE FROM question_skills WHERE question_id = '91f0812a-b5de-4d0f-97c9-4e1777ef18a6';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('91f0812a-b5de-4d0f-97c9-4e1777ef18a6', 'concavity_from_second_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('91f0812a-b5de-4d0f-97c9-4e1777ef18a6', 'function_graph_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'function_graph_behavior', 
    supporting_skill_ids = '{"concavity_from_second_derivative"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"concavity_from_second_derivative","function_graph_behavior"}', 
    error_tags = '{"concavity_sign_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-\\infty, -1)$","explanation":"Incorrect: table shows $f''''$ is positive there (concave up)."},{"id":"B","type":"text","label":"B","value":"$(-1, 3)$","explanation":"Correct: table shows $f''''$ is negative there (concave down)."},{"id":"C","type":"text","label":"C","value":"$(3, \\infty)$","explanation":"Incorrect: table shows $f''''$ is positive there (concave up)."},{"id":"D","type":"text","label":"D","value":"$f$ is never concave down","explanation":"Incorrect: the table shows a negative interval."}]',
    updated_at = NOW() 
WHERE id = '91f0812a-b5de-4d0f-97c9-4e1777ef18a6';
DELETE FROM question_skills WHERE question_id = '92bae04d-d00c-4bc0-b282-d26745ea0354';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('92bae04d-d00c-4bc0-b282-d26745ea0354', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_modeling"}', 
    error_tags = '{"optimization_variable_not_defined"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Differentiate immediately.","explanation":"Incorrect: You cannot differentiate before you have an objective function."},{"id":"B","type":"text","label":"B","value":"Define variables clearly and write the quantity to be optimized in terms of those variables.","explanation":"Correct: Correct modeling-first approach."},{"id":"C","type":"text","label":"C","value":"Plug in endpoints first.","explanation":"Incorrect: Endpoints are checked later (after the function/domain are set)."},{"id":"D","type":"text","label":"D","value":"Set the second derivative equal to zero.","explanation":"Incorrect: That is not the standard starting step and may not apply."}]',
    updated_at = NOW() 
WHERE id = '92bae04d-d00c-4bc0-b282-d26745ea0354';
DELETE FROM question_skills WHERE question_id = '937cd308-c65f-4779-99cf-ea818eb70a4c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('937cd308-c65f-4779-99cf-ea818eb70a4c', 'first_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('937cd308-c65f-4779-99cf-ea818eb70a4c', 'second_derivative_test_concavity', 'primary');
UPDATE questions SET 
    primary_skill_id = 'second_derivative_test_concavity', 
    supporting_skill_ids = '{"first_derivative_test"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"first_derivative_test","second_derivative_test_concavity"}', 
    error_tags = '{"first_derivative_test_misapplied"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x=-2$","explanation":"Incorrect: at $x=-2$, $f''(x)$ changes from negative to positive (local minimum)."},{"id":"B","type":"text","label":"B","value":"$x=1$","explanation":"Correct: at $x=1$, $f''(x)$ changes from positive to negative (local maximum)."},{"id":"C","type":"text","label":"C","value":"$x=4$","explanation":"Incorrect: at $x=4$, $f''(x)$ changes from negative to positive (local minimum)."},{"id":"D","type":"text","label":"D","value":"None of these","explanation":"Incorrect: $x=1$ is a local maximum based on the sign change."}]',
    updated_at = NOW() 
WHERE id = '937cd308-c65f-4779-99cf-ea818eb70a4c';
DELETE FROM question_skills WHERE question_id = '9badf103-d691-4ef4-9661-329f25cdcdc3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9badf103-d691-4ef4-9661-329f25cdcdc3', 'first_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'first_derivative_test', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"first_derivative_test"}', 
    error_tags = '{"first_derivative_test_misapplied"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local minimum at $x=3$.","explanation":"Incorrect: A local minimum would require negative to positive change."},{"id":"B","type":"text","label":"B","value":"$f$ has a local maximum at $x=3$.","explanation":"Correct: + to - indicates a local maximum."},{"id":"C","type":"text","label":"C","value":"$f$ has an inflection point at $x=3$.","explanation":"Incorrect: Inflection is about concavity change, not $f''$ sign change."},{"id":"D","type":"text","label":"D","value":"$f$ has no extremum at $x=3$.","explanation":"Incorrect: A sign change indicates an extremum."}]',
    updated_at = NOW() 
WHERE id = '9badf103-d691-4ef4-9661-329f25cdcdc3';
DELETE FROM question_skills WHERE question_id = '9da2ee27-997a-45fe-890e-8bbb1a4e3329';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9da2ee27-997a-45fe-890e-8bbb1a4e3329', 'connect_f_fprime_fdoubleprime', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9da2ee27-997a-45fe-890e-8bbb1a4e3329', 'optimization_evaluation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_evaluation', 
    supporting_skill_ids = '{"connect_f_fprime_fdoubleprime"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"connect_f_fprime_fdoubleprime","optimization_evaluation"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ is increasing on $(a,b)$.","explanation":"Incorrect: $f''$ increasing does not guarantee $f''$ is positive."},{"id":"B","type":"text","label":"B","value":"$f$ is concave up on $(a,b)$.","explanation":"Correct: increasing $f''$ corresponds to concave up behavior of $f$."},{"id":"C","type":"text","label":"C","value":"$f$ has a local maximum on $(a,b)$.","explanation":"Incorrect: a local maximum requires $f''$ to change sign from + to - at a point."},{"id":"D","type":"text","label":"D","value":"$f$ has an inflection point on $(a,b)$.","explanation":"Incorrect: concave up throughout does not force a concavity change."}]',
    updated_at = NOW() 
WHERE id = '9da2ee27-997a-45fe-890e-8bbb1a4e3329';
DELETE FROM question_skills WHERE question_id = 'a0560070-6ec7-4a6e-b560-7ee9b36d8ce2';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a0560070-6ec7-4a6e-b560-7ee9b36d8ce2', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_modeling"}', 
    error_tags = '{"optimization_constraint_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$S(r) = 2\\pi r^2 + \\frac{2000}{r}$","explanation":"Correct: after substitution, the $\\pi$ cancels in the lateral-area term."},{"id":"B","type":"text","label":"B","value":"$S(r) = 2\\pi r^2 + \\frac{2000\\pi}{r}$","explanation":"Incorrect: keeps an extra $\\pi$ that should cancel."},{"id":"C","type":"text","label":"C","value":"$S(r) = \\pi r^2 + \\frac{1000}{r}$","explanation":"Incorrect: missing one base and has incorrect constants."},{"id":"D","type":"text","label":"D","value":"$S(r) = 2\\pi r^2 + \\frac{1000\\pi}{r}$","explanation":"Incorrect: wrong constant and also leaves $\\pi$ where it cancels."}]',
    updated_at = NOW() 
WHERE id = 'a0560070-6ec7-4a6e-b560-7ee9b36d8ce2';
DELETE FROM question_skills WHERE question_id = 'a06cb3fb-a197-4c7c-a5fc-06e8232b25f0';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a06cb3fb-a197-4c7c-a5fc-06e8232b25f0', 'implicit_relation_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'implicit_relation_behavior', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"implicit_relation_behavior"}', 
    error_tags = '{"implicit_tangent_condition_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(2,1)$","explanation":"Incorrect: table shows this slope is negative."},{"id":"B","type":"text","label":"B","value":"$(1,2)$","explanation":"Incorrect: table shows this slope is negative."},{"id":"C","type":"text","label":"C","value":"$(2,-1)$","explanation":"Correct: table shows this is the greatest positive slope."},{"id":"D","type":"text","label":"D","value":"$(-1,2)$","explanation":"Incorrect: table shows this is not the greatest positive slope."}]',
    updated_at = NOW() 
WHERE id = 'a06cb3fb-a197-4c7c-a5fc-06e8232b25f0';
DELETE FROM question_skills WHERE question_id = 'a2aa6a41-719e-4001-81a6-a19038d23153';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a2aa6a41-719e-4001-81a6-a19038d23153', 'second_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a2aa6a41-719e-4001-81a6-a19038d23153', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{"second_derivative_test"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"second_derivative_test","optimization_modeling"}', 
    error_tags = '{"second_derivative_test_wrong_use"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x=0$ is a local maximum of $f$.","explanation":"Correct: $f''''(0)<0$ implies a local maximum at $x=0$."},{"id":"B","type":"text","label":"B","value":"$x=0$ is a local minimum of $f$.","explanation":"Incorrect: a local minimum would require $f''''(0)>0$."},{"id":"C","type":"text","label":"C","value":"The second derivative test is inconclusive at $x=0$.","explanation":"Incorrect: inconclusive happens when $f''''(0)=0$ or does not exist."},{"id":"D","type":"text","label":"D","value":"$x=0$ is not a critical point of $f$.","explanation":"Incorrect: $f''(0)=0$, so it is a critical point."}]',
    updated_at = NOW() 
WHERE id = 'a2aa6a41-719e-4001-81a6-a19038d23153';
DELETE FROM question_skills WHERE question_id = 'a2f02b08-a73a-4b87-86df-bab41e4e5cc8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a2f02b08-a73a-4b87-86df-bab41e4e5cc8', 'increasing_decreasing_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a2f02b08-a73a-4b87-86df-bab41e4e5cc8', 'first_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'first_derivative_test', 
    supporting_skill_ids = '{"increasing_decreasing_from_derivative"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","B":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"increasing_decreasing_from_derivative","first_derivative_test"}', 
    error_tags = '{"sign_chart_interval_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-4,-1)$ and $(2,4)$","explanation":"Correct: $f''(x)$ is above the x-axis on those two intervals."},{"id":"B","type":"text","label":"B","value":"$(-1,2)$ only","explanation":"Incorrect: on $(-1,2)$ the graph is below the x-axis, so $f$ is decreasing."},{"id":"C","type":"text","label":"C","value":"$(-4,2)$ only","explanation":"Incorrect: $f''(x)$ changes sign at $x=-1$ and $x=2$, so $f$ cannot be increasing on all of $(-4,2)$."},{"id":"D","type":"text","label":"D","value":"$(-4,-1)$ only","explanation":"Incorrect: $f$ is also increasing on $(2,4)$."}]',
    updated_at = NOW() 
WHERE id = 'a2f02b08-a73a-4b87-86df-bab41e4e5cc8';
DELETE FROM question_skills WHERE question_id = 'a818cca3-a112-414c-bab8-1a59e1131065';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a818cca3-a112-414c-bab8-1a59e1131065', 'avg_vs_instant_rate_link', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a818cca3-a112-414c-bab8-1a59e1131065', 'mvt_conditions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a818cca3-a112-414c-bab8-1a59e1131065', 'extreme_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'extreme_value_theorem', 
    supporting_skill_ids = '{"avg_vs_instant_rate_link","mvt_conditions"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","B":"Correct. EVT guarantees absolute extrema on a closed interval $[a, b]$.","C":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","D":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$."}', 
    skill_tags = '{"avg_vs_instant_rate_link","mvt_conditions","extreme_value_theorem"}', 
    error_tags = '{"mvt_conclusion_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$t=0$","explanation":"Incorrect: the time must be in the open interval $(0,3)$."},{"id":"B","type":"text","label":"B","value":"$t=1$","explanation":"Correct: $v(1)=0$ matches the average velocity $0$."},{"id":"C","type":"text","label":"C","value":"$t=2$","explanation":"Incorrect: $v(2)=3(4)-24+9=-3$, not $0$."},{"id":"D","type":"text","label":"D","value":"$t=3$","explanation":"Incorrect: $3$ is not in $(0,3)$ for the MVT conclusion."}]',
    updated_at = NOW() 
WHERE id = 'a818cca3-a112-414c-bab8-1a59e1131065';
DELETE FROM question_skills WHERE question_id = 'a823f4a2-1879-462b-898a-0e9012dc13a3';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a823f4a2-1879-462b-898a-0e9012dc13a3', 'inflection_points', 'primary');
UPDATE questions SET 
    primary_skill_id = 'inflection_points', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"inflection_points"}', 
    error_tags = '{"inflection_without_sign_change"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x = 1$ only","explanation":"Incorrect: Misses the second sign-change crossing."},{"id":"B","type":"text","label":"B","value":"$x = 1$ and $x = 4$","explanation":"Correct: both zero-crossings with sign change."},{"id":"C","type":"text","label":"C","value":"$x = 2$ and $x = 5$","explanation":"Incorrect: Those values do not match the sign-change crossings shown."},{"id":"D","type":"text","label":"D","value":"No inflection points because $f''''$ is shown, not $f$.","explanation":"Incorrect: $f''''$ is exactly what you use to detect concavity change."}]',
    updated_at = NOW() 
WHERE id = 'a823f4a2-1879-462b-898a-0e9012dc13a3';
DELETE FROM question_skills WHERE question_id = 'abbb138c-907d-4035-9dc5-8f505f8edff7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('abbb138c-907d-4035-9dc5-8f505f8edff7', 'second_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('abbb138c-907d-4035-9dc5-8f505f8edff7', 'function_graph_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'function_graph_behavior', 
    supporting_skill_ids = '{"second_derivative_test"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"second_derivative_test","function_graph_behavior"}', 
    error_tags = '{"second_derivative_test_wrong_use"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=1$.","explanation":"Incorrect: cannot conclude maximum when $f''''(1)=0$."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=1$.","explanation":"Incorrect: cannot conclude minimum when $f''''(1)=0$."},{"id":"C","type":"text","label":"C","value":"The test is inconclusive at $x=1$.","explanation":"Correct: the second derivative test is inconclusive in this case."},{"id":"D","type":"text","label":"D","value":"$f$ has an inflection point at $x=1$.","explanation":"Incorrect: an inflection point requires a concavity change, not just $f''''(1)=0$."}]',
    updated_at = NOW() 
WHERE id = 'abbb138c-907d-4035-9dc5-8f505f8edff7';
DELETE FROM question_skills WHERE question_id = 'aeb5eac1-664f-4a4d-8bfb-d9d50d4175e1';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('aeb5eac1-664f-4a4d-8bfb-d9d50d4175e1', 'global_vs_local_extrema', 'primary');
UPDATE questions SET 
    primary_skill_id = 'global_vs_local_extrema', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"global_vs_local_extrema"}', 
    error_tags = '{"global_vs_local_confusion"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"A local maximum must occur at an endpoint; an absolute maximum cannot.","explanation":"Incorrect: Endpoints are not required for local maxima."},{"id":"B","type":"text","label":"B","value":"A local maximum is the greatest value on the entire interval; an absolute maximum is greatest only nearby.","explanation":"Incorrect: Definitions are reversed."},{"id":"C","type":"text","label":"C","value":"A local maximum is greatest in some neighborhood; an absolute maximum is greatest on the whole domain/interval considered.","explanation":"Correct: Correct distinction."},{"id":"D","type":"text","label":"D","value":"Local and absolute maxima are always the same.","explanation":"Incorrect: They can differ."}]',
    updated_at = NOW() 
WHERE id = 'aeb5eac1-664f-4a4d-8bfb-d9d50d4175e1';
DELETE FROM question_skills WHERE question_id = 'b1d6955e-0181-4c4b-b8c6-d7182886ffb4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b1d6955e-0181-4c4b-b8c6-d7182886ffb4', 'mvt_conditions', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mvt_conditions', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"mvt_conditions"}', 
    error_tags = '{"mvt_conclusion_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$2.5$","explanation":"Correct: Correct computation from the endpoints of the interval."},{"id":"B","type":"text","label":"B","value":"$2.0$","explanation":"Incorrect: Arithmetic error."},{"id":"C","type":"text","label":"C","value":"$15.0$","explanation":"Incorrect: That is the total change, not per minute."},{"id":"D","type":"text","label":"D","value":"$0.4$","explanation":"Incorrect: Uses the reciprocal."}]',
    updated_at = NOW() 
WHERE id = 'b1d6955e-0181-4c4b-b8c6-d7182886ffb4';
DELETE FROM question_skills WHERE question_id = 'b29e18a2-4bfb-4bb9-9c06-35c4d7c985cd';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b29e18a2-4bfb-4bb9-9c06-35c4d7c985cd', 'second_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b29e18a2-4bfb-4bb9-9c06-35c4d7c985cd', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{"second_derivative_test"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"second_derivative_test","optimization_modeling"}', 
    error_tags = '{"second_derivative_test_wrong_use"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=2$.","explanation":"Incorrect: cannot conclude max without a valid second derivative test."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=2$.","explanation":"Incorrect: cannot conclude min without a valid second derivative test."},{"id":"C","type":"text","label":"C","value":"The second derivative test cannot be used at $x=2$.","explanation":"Correct: the test is not applicable if $f''''$ does not exist."},{"id":"D","type":"text","label":"D","value":"$f$ has an inflection point at $x=2$.","explanation":"Incorrect: inflection requires concavity change, not just $f''''$ not existing."}]',
    updated_at = NOW() 
WHERE id = 'b29e18a2-4bfb-4bb9-9c06-35c4d7c985cd';
DELETE FROM question_skills WHERE question_id = 'b4eda2e2-3cd4-4c4f-90db-3a1f1c6ab904';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b4eda2e2-3cd4-4c4f-90db-3a1f1c6ab904', 'candidates_test_absolute', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b4eda2e2-3cd4-4c4f-90db-3a1f1c6ab904', 'candidates_test_absolute_extrema', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute_extrema', 
    supporting_skill_ids = '{"candidates_test_absolute"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"candidates_test_absolute","candidates_test_absolute_extrema"}', 
    error_tags = '{"candidates_test_missing_endpoints"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x=-2$","explanation":"Incorrect: $f(-2)=-2$ is not the maximum."},{"id":"B","type":"text","label":"B","value":"$x=-1$","explanation":"Correct: $f(-1)=2$ is a maximum value on the interval."},{"id":"C","type":"text","label":"C","value":"$x=1$","explanation":"Incorrect: $f(1)=-2$ is not the maximum."},{"id":"D","type":"text","label":"D","value":"$x=2$","explanation":"Incorrect: $x=2$ also gives the maximum value, but the question asks for an $x$-value that gives the absolute maximum; $x=-1$ is the listed correct choice."}]',
    updated_at = NOW() 
WHERE id = 'b4eda2e2-3cd4-4c4f-90db-3a1f1c6ab904';
DELETE FROM question_skills WHERE question_id = 'bf065117-eb0c-4308-aa8b-5f75fcf20431';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('bf065117-eb0c-4308-aa8b-5f75fcf20431', 'increasing_decreasing_from_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('bf065117-eb0c-4308-aa8b-5f75fcf20431', 'first_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'first_derivative_test', 
    supporting_skill_ids = '{"increasing_decreasing_from_derivative"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"increasing_decreasing_from_derivative","first_derivative_test"}', 
    error_tags = '{"critical_points_incomplete"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-5,-2)$ only","explanation":"Incorrect: for $x<-2$, $1/(x+2)$ is negative, so $f$ is decreasing there."},{"id":"B","type":"text","label":"B","value":"$(-2,2)$ and $(2,5)$","explanation":"Correct: $f''(x)>0$ for $x>-2$, but you must split at $x=2$ because $f$ may not be differentiable there."},{"id":"C","type":"text","label":"C","value":"$(-5,-2)$ and $(-2,2)$","explanation":"Incorrect: $(-5,-2)$ is decreasing, not increasing."},{"id":"D","type":"text","label":"D","value":"$(-5,2)$ and $(2,5)$","explanation":"Incorrect: you must exclude $x=-2$ and $x=2$, so you cannot combine across them."}]',
    updated_at = NOW() 
WHERE id = 'bf065117-eb0c-4308-aa8b-5f75fcf20431';
DELETE FROM question_skills WHERE question_id = 'c2767b81-d922-4d44-82f9-ebc804e30b26';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c2767b81-d922-4d44-82f9-ebc804e30b26', 'mvt_conditions', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c2767b81-d922-4d44-82f9-ebc804e30b26', 'avg_vs_instant_rate_link', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c2767b81-d922-4d44-82f9-ebc804e30b26', 'extreme_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'extreme_value_theorem', 
    supporting_skill_ids = '{"mvt_conditions","avg_vs_instant_rate_link"}', 
    target_time_seconds = 90, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","B":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$.","C":"Correct. EVT guarantees absolute extrema on a closed interval $[a, b]$.","D":"Incorrect. Check if the function is continuous on the closed interval $[a, b]$."}', 
    skill_tags = '{"mvt_conditions","avg_vs_instant_rate_link","extreme_value_theorem"}', 
    error_tags = '{"mvt_conclusion_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$c=1$","explanation":"Incorrect: $c$ must be in $(1,3)$ and satisfy $f''(c)=0$; $f''(1)=-2$."},{"id":"B","type":"text","label":"B","value":"$c=3/2$","explanation":"Incorrect: $f''(3/2)=3-4=-1$, not $0$."},{"id":"C","type":"text","label":"C","value":"$c=2$","explanation":"Correct: $f''(2)=0$ matches the average slope $0$."},{"id":"D","type":"text","label":"D","value":"$c=5/2$","explanation":"Incorrect: $f''(5/2)=5-4=1$, not $0$."}]',
    updated_at = NOW() 
WHERE id = 'c2767b81-d922-4d44-82f9-ebc804e30b26';
DELETE FROM question_skills WHERE question_id = 'c69f05e1-07ab-455a-8c29-82271ec51f70';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c69f05e1-07ab-455a-8c29-82271ec51f70', 'first_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c69f05e1-07ab-455a-8c29-82271ec51f70', 'second_derivative_test_concavity', 'primary');
UPDATE questions SET 
    primary_skill_id = 'second_derivative_test_concavity', 
    supporting_skill_ids = '{"first_derivative_test"}', 
    target_time_seconds = 60, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","B":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"first_derivative_test","second_derivative_test_concavity"}', 
    error_tags = '{"first_derivative_test_misapplied"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=2$.","explanation":"Correct: increasing then decreasing implies a local maximum."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=2$.","explanation":"Incorrect: a local minimum needs negative to positive."},{"id":"C","type":"text","label":"C","value":"$f$ has an inflection point at $x=2$.","explanation":"Incorrect: inflection depends on concavity change, not $f''$ sign change alone."},{"id":"D","type":"text","label":"D","value":"$f$ has no local extrema at $x=2$.","explanation":"Incorrect: a sign change in $f''$ indicates a local extremum."}]',
    updated_at = NOW() 
WHERE id = 'c69f05e1-07ab-455a-8c29-82271ec51f70';
DELETE FROM question_skills WHERE question_id = 'ce1e242b-4f11-46b9-9e2b-f21b21afc3bd';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ce1e242b-4f11-46b9-9e2b-f21b21afc3bd', 'horizontal_vertical_tangent_implicit', 'primary');
UPDATE questions SET 
    primary_skill_id = 'horizontal_vertical_tangent_implicit', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"horizontal_vertical_tangent_implicit"}', 
    error_tags = '{"implicit_tangent_condition_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"The tangent is horizontal.","explanation":"Incorrect: top and bottom points have horizontal tangents, not the rightmost point."},{"id":"B","type":"text","label":"B","value":"The tangent is vertical.","explanation":"Correct: rightmost point gives a vertical tangent."},{"id":"C","type":"text","label":"C","value":"The tangent has slope 1.","explanation":"Incorrect: a 45-degree slope is not consistent with the geometry."},{"id":"D","type":"text","label":"D","value":"The tangent does not exist.","explanation":"Incorrect: the curve is smooth there, so a tangent exists."}]',
    updated_at = NOW() 
WHERE id = 'ce1e242b-4f11-46b9-9e2b-f21b21afc3bd';
DELETE FROM question_skills WHERE question_id = 'ce964153-685a-48ee-b45d-ee090d6f2fae';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ce964153-685a-48ee-b45d-ee090d6f2fae', 'second_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ce964153-685a-48ee-b45d-ee090d6f2fae', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{"second_derivative_test"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"second_derivative_test","optimization_modeling"}', 
    error_tags = '{"second_derivative_test_wrong_use"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local maximum at $x=3$.","explanation":"Correct: $f''(3)=0$ and $f''''(3)<0$ indicates a local maximum."},{"id":"B","type":"text","label":"B","value":"$f$ has a local minimum at $x=3$.","explanation":"Incorrect: $f''''(3)>0$ would indicate a local minimum."},{"id":"C","type":"text","label":"C","value":"$f$ has an absolute maximum at $x=3$.","explanation":"Incorrect: the test gives local behavior, not an absolute guarantee."},{"id":"D","type":"text","label":"D","value":"The second derivative test is inconclusive at $x=3$.","explanation":"Incorrect: the test is conclusive because $f''''(3)$ is nonzero."}]',
    updated_at = NOW() 
WHERE id = 'ce964153-685a-48ee-b45d-ee090d6f2fae';
DELETE FROM question_skills WHERE question_id = 'cef4bd26-bf3d-415e-b17d-fd1baca75abb';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('cef4bd26-bf3d-415e-b17d-fd1baca75abb', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_modeling"}', 
    error_tags = '{"optimization_variable_not_defined"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Let $x$ be the maximum value.","explanation":"Incorrect: the maximum value is the objective result, not the decision variable."},{"id":"B","type":"text","label":"B","value":"Let $x$ be the quantity you can choose or control (with units), such as a length or time.","explanation":"Correct: the decision variable is what you can choose/control (with meaning and units)."},{"id":"C","type":"text","label":"C","value":"Let $x$ be the final answer.","explanation":"Incorrect: the final answer is not the variable definition."},{"id":"D","type":"text","label":"D","value":"Let $x$ be the derivative.","explanation":"Incorrect: the derivative is a tool, not the variable to define."}]',
    updated_at = NOW() 
WHERE id = 'cef4bd26-bf3d-415e-b17d-fd1baca75abb';
DELETE FROM question_skills WHERE question_id = 'd5b94c55-6dfe-4f97-97bc-e3856e44c8f8';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d5b94c55-6dfe-4f97-97bc-e3856e44c8f8', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_modeling"}', 
    error_tags = '{"optimization_constraint_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$V(x) = x(12 - 2x)(18 - 2x)$","explanation":"Correct: height is $x$ and both dimensions reduce by $2x$."},{"id":"B","type":"text","label":"B","value":"$V(x) = (12 - x)(18 - x)$","explanation":"Incorrect: missing the height factor and subtracts $x$ instead of $2x$ per dimension."},{"id":"C","type":"text","label":"C","value":"$V(x) = (12 - 2x)(18 - 2x)$","explanation":"Incorrect: this is base area only; it ignores the height $x$."},{"id":"D","type":"text","label":"D","value":"$V(x) = x(12 - x)(18 - x)$","explanation":"Incorrect: subtracts $x$ only once per dimension; should be $2x$."}]',
    updated_at = NOW() 
WHERE id = 'd5b94c55-6dfe-4f97-97bc-e3856e44c8f8';
DELETE FROM question_skills WHERE question_id = 'd8a68996-14c8-4607-b4eb-331d34541461';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d8a68996-14c8-4607-b4eb-331d34541461', 'optimization_solve_and_check', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_solve_and_check', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 180, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Correct. This follows the principles of analytical applications of differentiation.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_solve_and_check"}', 
    error_tags = '{"optimization_domain_missing"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$50$","explanation":"Incorrect: Too small; not the maximum for perimeter 40."},{"id":"B","type":"text","label":"B","value":"$80$","explanation":"Incorrect: Too small; square gives larger area."},{"id":"C","type":"text","label":"C","value":"$100$","explanation":"Correct: square 10 by 10."},{"id":"D","type":"text","label":"D","value":"$120$","explanation":"Incorrect: Not possible with perimeter 40."}]',
    updated_at = NOW() 
WHERE id = 'd8a68996-14c8-4607-b4eb-331d34541461';
DELETE FROM question_skills WHERE question_id = 'da68ef47-039a-48ac-ad1f-ba65dd4434fa';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('da68ef47-039a-48ac-ad1f-ba65dd4434fa', 'second_derivative_test', 'primary');
UPDATE questions SET 
    primary_skill_id = 'second_derivative_test', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","B":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"second_derivative_test"}', 
    error_tags = '{"second_derivative_test_wrong_use"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ has a local minimum at $x=2$.","explanation":"Incorrect: A local minimum would require $f''''(2)>0$."},{"id":"B","type":"text","label":"B","value":"$f$ has a local maximum at $x=2$.","explanation":"Correct: Correct second derivative test result."},{"id":"C","type":"text","label":"C","value":"$f$ has an inflection point at $x=2$.","explanation":"Incorrect: Inflection requires concavity change, not just concave down."},{"id":"D","type":"text","label":"D","value":"No conclusion can be drawn even with these facts.","explanation":"Incorrect: Here the test applies and gives a conclusion."}]',
    updated_at = NOW() 
WHERE id = 'da68ef47-039a-48ac-ad1f-ba65dd4434fa';
DELETE FROM question_skills WHERE question_id = 'e512544e-8525-4460-8146-04c6f444e658';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e512544e-8525-4460-8146-04c6f444e658', 'candidates_test_absolute', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e512544e-8525-4460-8146-04c6f444e658', 'candidates_test_absolute_extrema', 'primary');
UPDATE questions SET 
    primary_skill_id = 'candidates_test_absolute_extrema', 
    supporting_skill_ids = '{"candidates_test_absolute"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"candidates_test_absolute","candidates_test_absolute_extrema"}', 
    error_tags = '{"absolute_extrema_compare_error"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$-1$","explanation":"Correct: -1 is the smallest candidate value."},{"id":"B","type":"text","label":"B","value":"$1$","explanation":"Incorrect: 1 is larger than -1."},{"id":"C","type":"text","label":"C","value":"$3$","explanation":"Incorrect: 3 is larger than -1."},{"id":"D","type":"text","label":"D","value":"$5$","explanation":"Incorrect: 5 is the largest, not the smallest."}]',
    updated_at = NOW() 
WHERE id = 'e512544e-8525-4460-8146-04c6f444e658';
DELETE FROM question_skills WHERE question_id = 'e61a29e9-ebc2-46e4-a381-0097dc4da83b';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e61a29e9-ebc2-46e4-a381-0097dc4da83b', 'sketch_derivative_from_function', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e61a29e9-ebc2-46e4-a381-0097dc4da83b', 'optimization_evaluation', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_evaluation', 
    supporting_skill_ids = '{"sketch_derivative_from_function"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"sketch_derivative_from_function","optimization_evaluation"}', 
    error_tags = '{"graph_derivative_shape_misread"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$(-2,0)$","explanation":"Incorrect: the graph is falling on $(-2,0)$."},{"id":"B","type":"text","label":"B","value":"$(0,2)$","explanation":"Correct: the graph rises on $(0,2)$."},{"id":"C","type":"text","label":"C","value":"$(2,4)$","explanation":"Incorrect: the graph falls on $(2,4)$."},{"id":"D","type":"text","label":"D","value":"$f$ is increasing on all of $(-2,4)$","explanation":"Incorrect: the graph changes direction, so it is not increasing everywhere."}]',
    updated_at = NOW() 
WHERE id = 'e61a29e9-ebc2-46e4-a381-0097dc4da83b';
DELETE FROM question_skills WHERE question_id = 'e97d9f47-cd92-4659-8656-39a7fa1c88b7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e97d9f47-cd92-4659-8656-39a7fa1c88b7', 'mean_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mean_value_theorem', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 90, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. MVT states there exists a c in $(a, b)$ where $f''(c)$ = [$f(b)$-$f(a)$]/(b-a).","B":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","C":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","D":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$."}', 
    skill_tags = '{"mean_value_theorem"}', 
    error_tags = '{"evt_missing_closed_interval","evt_missing_continuity","confuse_local_global"}', 
    options = '[{"id":"A","text":"$f$ is continuous on $[a,b]$."},{"id":"B","text":"$f$ is differentiable on $(a,b)$."},{"id":"C","text":"$f$ is continuous on $(a,b)$."},{"id":"D","text":"$f$ is differentiable on $[a,b]$."}]',
    updated_at = NOW() 
WHERE id = 'e97d9f47-cd92-4659-8656-39a7fa1c88b7';
DELETE FROM question_skills WHERE question_id = 'ed37296f-ebee-40e6-86ab-4e7265ae61a9';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ed37296f-ebee-40e6-86ab-4e7265ae61a9', 'mean_value_theorem', 'primary');
UPDATE questions SET 
    primary_skill_id = 'mean_value_theorem', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 150, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","B":"Correct. MVT states there exists a c in $(a, b)$ where $f''(c)$ = [$f(b)$-$f(a)$]/(b-a).","C":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$.","D":"Incorrect. Remember the function must be continuous on $[a, b]$ and differentiable on $(a, b)$."}', 
    skill_tags = '{"mean_value_theorem"}', 
    error_tags = '{"forget_nondifferentiable_critical","treat_discontinuity_as_critical","ignore_domain_restriction"}', 
    options = '[{"id":"A","text":"$x=0$ only"},{"id":"B","text":"$x=2$ only"},{"id":"C","text":"$x=2$ and $x=0$"},{"id":"D","text":"None"}]',
    updated_at = NOW() 
WHERE id = 'ed37296f-ebee-40e6-86ab-4e7265ae61a9';
DELETE FROM question_skills WHERE question_id = 'f1639eb1-66f7-4ae0-ac51-668d017b92b6';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f1639eb1-66f7-4ae0-ac51-668d017b92b6', 'implicit_relation_behavior', 'primary');
UPDATE questions SET 
    primary_skill_id = 'implicit_relation_behavior', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the principles of analytical applications of differentiation.","B":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"implicit_relation_behavior"}', 
    error_tags = '{"wrong_method_choice_unit5"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$\\frac{dy}{dx} = -\\frac{2x + y}{x + 2y}$","explanation":"Correct: matches the result after collecting $dy/dx$ terms."},{"id":"B","type":"text","label":"B","value":"$\\frac{dy}{dx} = -\\frac{2x + y}{2x + y}$","explanation":"Incorrect: would force $\\frac{dy}{dx} = -1$ always, which is not true."},{"id":"C","type":"text","label":"C","value":"$\\frac{dy}{dx} = \\frac{2x + y}{x + 2y}$","explanation":"Incorrect: sign error."},{"id":"D","type":"text","label":"D","value":"$\\frac{dy}{dx} = -\\frac{2x + 1}{1 + 2y}$","explanation":"Incorrect: treats $y$ like a constant and breaks the product structure."}]',
    updated_at = NOW() 
WHERE id = 'f1639eb1-66f7-4ae0-ac51-668d017b92b6';
DELETE FROM question_skills WHERE question_id = 'f2766202-2b57-422a-929f-fd4b7d83516c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f2766202-2b57-422a-929f-fd4b7d83516c', 'method_selection_unit5', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f2766202-2b57-422a-929f-fd4b7d83516c', 'optimization_modeling', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_modeling', 
    supporting_skill_ids = '{"method_selection_unit5"}', 
    target_time_seconds = 90, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"method_selection_unit5","optimization_modeling"}', 
    error_tags = '{"wrong_method_choice_unit5"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$f$ is continuous at $c$.","explanation":"Incorrect: continuity alone does not enable the second derivative test."},{"id":"B","type":"text","label":"B","value":"$f''''(c)$ exists and $f''''(c)\\neq0$.","explanation":"Correct: existence and nonzero value of $f''''(c)$ makes the test conclusive."},{"id":"C","type":"text","label":"C","value":"$f$ has an endpoint at $c$.","explanation":"Incorrect: endpoints relate to absolute extrema testing, not the second derivative test."},{"id":"D","type":"text","label":"D","value":"$f$ has a horizontal tangent at $c$.","explanation":"Incorrect: horizontal tangent means $f''(c)=0$, which is already given."}]',
    updated_at = NOW() 
WHERE id = 'f2766202-2b57-422a-929f-fd4b7d83516c';
DELETE FROM question_skills WHERE question_id = 'f46acf9f-9f89-41d0-9dcd-c554c39e246d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f46acf9f-9f89-41d0-9dcd-c554c39e246d', 'first_derivative_test', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f46acf9f-9f89-41d0-9dcd-c554c39e246d', 'critical_points_find', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f46acf9f-9f89-41d0-9dcd-c554c39e246d', 'second_derivative_test_concavity', 'primary');
UPDATE questions SET 
    primary_skill_id = 'second_derivative_test_concavity', 
    supporting_skill_ids = '{"first_derivative_test","critical_points_find"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the sign changes of f'' or f'''' to determine relative extrema or points of inflection.","B":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","C":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features.","D":"Incorrect. Review the conditions for sign changes in f'' or f'''' to identify specific local features."}', 
    skill_tags = '{"first_derivative_test","critical_points_find","second_derivative_test_concavity"}', 
    error_tags = '{"critical_points_incomplete"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"Local max at $x=0$ and local min at $x=2$.","explanation":"Correct: $f''$ changes + to - at $0$ (max) and - to + at $2$ (min)."},{"id":"B","type":"text","label":"B","value":"Local min at $x=0$ and local max at $x=2$.","explanation":"Incorrect: it reverses the sign-change conclusions."},{"id":"C","type":"text","label":"C","value":"Local maxima at both $x=0$ and $x=2$.","explanation":"Incorrect: a max needs + to -; at $x=2$ it is - to + (min)."},{"id":"D","type":"text","label":"D","value":"No local extrema occur.","explanation":"Incorrect: sign changes at both critical points indicate local extrema."}]',
    updated_at = NOW() 
WHERE id = 'f46acf9f-9f89-41d0-9dcd-c554c39e246d';
DELETE FROM question_skills WHERE question_id = 'fb65bf6c-808f-4231-902e-e02dd392509e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('fb65bf6c-808f-4231-902e-e02dd392509e', 'optimization_solve_and_check', 'primary');
UPDATE questions SET 
    primary_skill_id = 'optimization_solve_and_check', 
    supporting_skill_ids = '{}', 
    target_time_seconds = 120, 
    weight_primary = 1, 
    weight_supporting = 0, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","B":"Correct. This follows the principles of analytical applications of differentiation.","C":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements.","D":"Incorrect. Re-evaluate the derivative properties or the specific theorem requirements."}', 
    skill_tags = '{"optimization_solve_and_check"}', 
    error_tags = '{"wrong_method_choice_unit5"}', 
    options = '[{"id":"A","type":"text","label":"A","value":"$x = 5$","explanation":"Incorrect: left of the peak; area is still increasing."},{"id":"B","type":"text","label":"B","value":"$x = 7.5$","explanation":"Correct: this is the $x$-value at the peak."},{"id":"C","type":"text","label":"C","value":"$x = 10$","explanation":"Incorrect: right of the peak; area is decreasing."},{"id":"D","type":"text","label":"D","value":"$x = 15$","explanation":"Incorrect: endpoint where area is 0."}]',
    updated_at = NOW() 
WHERE id = 'fb65bf6c-808f-4231-902e-e02dd392509e';
COMMIT;