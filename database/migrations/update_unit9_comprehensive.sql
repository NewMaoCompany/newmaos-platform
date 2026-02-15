-- Unit 9 Comprehensive Audit & LaTeX Repair
BEGIN;
INSERT INTO skills (id, name, unit) VALUES ('bounds_from_context', 'bounds_from_context', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('graph_reading_interval_error', 'graph_reading_interval_error', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_path_interpretation', 'vector_path_interpretation', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_displacement_from_table', 'vector_displacement_from_table', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_derivative_slope', 'polar_derivative_slope', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_speed_magnitude', 'vector_speed_magnitude', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_area_formula', 'polar_area_formula', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_valued_position_integral', 'vector_valued_position_integral', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_valued_position', 'vector_valued_position', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_derivative_velocity', 'vector_derivative_velocity', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_area_between_curves', 'polar_area_between_curves', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_valued_function_concept', 'vector_valued_function_concept', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_component_derivative', 'vector_component_derivative', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_valued_motion_basics', 'vector_valued_motion_basics', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_area_single_curve', 'polar_area_single_curve', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('algebra_simplification_error', 'algebra_simplification_error', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_first_derivatives', 'parametric_first_derivatives', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_to_rectangular_conversion', 'polar_to_rectangular_conversion', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_velocity_acceleration', 'vector_velocity_acceleration', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_arc_length_formula', 'polar_arc_length_formula', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_tangent_normal_lines', 'parametric_tangent_normal_lines', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_dydx', 'parametric_dydx', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_derivative_dy_dx', 'parametric_derivative_dy_dx', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_second_derivative', 'parametric_second_derivative', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_representation_concept', 'parametric_representation_concept', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_concavity_analysis', 'parametric_concavity_analysis', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('polar_graph_interpretation', 'polar_graph_interpretation', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_arc_length', 'parametric_arc_length', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_horizontal_vertical_tangents', 'parametric_horizontal_vertical_tangents', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('parametric_eliminate_parameter', 'parametric_eliminate_parameter', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_position_from_velocity', 'vector_position_from_velocity', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('vector_integral_componentwise', 'vector_integral_componentwise', 'Parametric_Polar_Vectors') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('graph_reading_interval_error', 'graph_reading_interval_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('algebra_simplification_error', 'algebra_simplification_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vector_component_swap', 'vector_component_swap') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vector_displacement_endpoint_swap', 'vector_displacement_endpoint_swap') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('derivative_power_rule_error', 'derivative_power_rule_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('speed_missing_magnitude', 'speed_missing_magnitude') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('polar_area_missing_one_half', 'polar_area_missing_one_half') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('polar_area_wrong_bounds', 'polar_area_wrong_bounds') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_tangent_line_point_mismatch', 'param_tangent_line_point_mismatch') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('velocity_vs_speed_confusion', 'velocity_vs_speed_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('parametric_dydx_missing_divide_by_dxdt', 'parametric_dydx_missing_divide_by_dxdt') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vector_magnitude_error', 'vector_magnitude_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('calculator_mode_or_rounding_issue', 'calculator_mode_or_rounding_issue') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('arc_length_missing_sqrt_structure', 'arc_length_missing_sqrt_structure') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('arc_length_wrong_bounds', 'arc_length_wrong_bounds') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('polar_arc_length_missing_dr_dtheta', 'polar_arc_length_missing_dr_dtheta') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_dydx_missing_divide_by_dxdt', 'param_dydx_missing_divide_by_dxdt') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_dxdt_zero_not_checked', 'param_dxdt_zero_not_checked') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_second_derivative_wrong_formula', 'param_second_derivative_wrong_formula') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_concavity_sign_error', 'param_concavity_sign_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('polar_area_wrong_outer_inner', 'polar_area_wrong_outer_inner') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('arc_length_missing_squares', 'arc_length_missing_squares') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_horizontal_vertical_conditions_swapped', 'param_horizontal_vertical_conditions_swapped') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('param_elimination_algebra_error', 'param_elimination_algebra_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('arc_length_simplification_error', 'arc_length_simplification_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vector_derivative_not_componentwise', 'vector_derivative_not_componentwise') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vector_integral_missing_constant_vector', 'vector_integral_missing_constant_vector') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vector_initial_value_not_applied', 'vector_initial_value_not_applied') ON CONFLICT (id) DO NOTHING;
DELETE FROM question_skills WHERE question_id = '04feded2-5fed-4e6b-b12e-126331a4138c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('04feded2-5fed-4e6b-b12e-126331a4138c', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('04feded2-5fed-4e6b-b12e-126331a4138c', 'graph_reading_interval_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"graph_reading_interval_error"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$\\frac{\\pi}{3}$"},{"id":"B","value":"$\\frac{\\pi}{2}$"},{"id":"C","value":"$\\frac{2\\pi}{3}$"},{"id":"D","value":"$\\pi$"}]',
    updated_at = NOW() 
WHERE id = '04feded2-5fed-4e6b-b12e-126331a4138c';
DELETE FROM question_skills WHERE question_id = '0739596b-f665-4184-8a88-72611b959d50';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0739596b-f665-4184-8a88-72611b959d50', 'vector_path_interpretation', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0739596b-f665-4184-8a88-72611b959d50', 'bounds_from_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_path_interpretation', 
    supporting_skill_ids = '{"bounds_from_context"}', 
    target_time_seconds = 120, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_path_interpretation","bounds_from_context"}', 
    error_tags = '{"graph_reading_interval_error","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"The rightmost labeled point on the curve"},{"id":"B","value":"The leftmost labeled point on the curve"},{"id":"C","value":"The highest labeled point on the curve"},{"id":"D","value":"Cannot be determined from the diagram"}]',
    updated_at = NOW() 
WHERE id = '0739596b-f665-4184-8a88-72611b959d50';
DELETE FROM question_skills WHERE question_id = '0afb802a-fe10-4200-9842-e3272499ad62';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0afb802a-fe10-4200-9842-e3272499ad62', 'vector_displacement_from_table', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0afb802a-fe10-4200-9842-e3272499ad62', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0afb802a-fe10-4200-9842-e3272499ad62', 'polar_derivative_slope', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_derivative_slope', 
    supporting_skill_ids = '{"vector_displacement_from_table","bounds_from_context"}', 
    target_time_seconds = 210, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_displacement_from_table","bounds_from_context","polar_derivative_slope"}', 
    error_tags = '{"vector_displacement_endpoint_swap","graph_reading_interval_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\langle 4, 0 \\rangle$"},{"id":"B","value":"$\\langle 2, 0 \\rangle$"},{"id":"C","value":"$\\langle 4, -4 \\rangle$"},{"id":"D","value":"$\\langle 0, 4 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = '0afb802a-fe10-4200-9842-e3272499ad62';
DELETE FROM question_skills WHERE question_id = '0bc6e4bc-5346-4e54-8fb1-805879fc8eea';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0bc6e4bc-5346-4e54-8fb1-805879fc8eea', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('0bc6e4bc-5346-4e54-8fb1-805879fc8eea', 'graph_reading_interval_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"graph_reading_interval_error"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","derivative_power_rule_error"}', 
    options = '[{"id":"A","value":"$Positive$"},{"id":"B","value":"$Negative$"},{"id":"C","value":"$Zero$"},{"id":"D","value":"Cannot be determined"}]',
    updated_at = NOW() 
WHERE id = '0bc6e4bc-5346-4e54-8fb1-805879fc8eea';
DELETE FROM question_skills WHERE question_id = '1b990acc-b964-4ff3-a93a-7feba98fd2f1';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1b990acc-b964-4ff3-a93a-7feba98fd2f1', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1b990acc-b964-4ff3-a93a-7feba98fd2f1', 'vector_speed_magnitude', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"vector_speed_magnitude"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","vector_speed_magnitude"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","speed_missing_magnitude"}', 
    options = '[{"id":"A","value":"$7.5$"},{"id":"B","value":"$9.5$"},{"id":"C","value":"$7.0$"},{"id":"D","value":"$3.5$"}]',
    updated_at = NOW() 
WHERE id = '1b990acc-b964-4ff3-a93a-7feba98fd2f1';
DELETE FROM question_skills WHERE question_id = '1cfbe8ae-ac74-4029-8acb-4120e6dba17a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1cfbe8ae-ac74-4029-8acb-4120e6dba17a', 'polar_area_formula', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1cfbe8ae-ac74-4029-8acb-4120e6dba17a', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1cfbe8ae-ac74-4029-8acb-4120e6dba17a', 'vector_valued_position_integral', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_position_integral', 
    supporting_skill_ids = '{"polar_area_formula","bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"polar_area_formula","bounds_from_context","vector_valued_position_integral"}', 
    error_tags = '{"polar_area_missing_one_half","polar_area_wrong_bounds","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\frac{1}{2} \\int_0^{2\\pi} (1 + \\sin\\theta)^2 \\, d\\theta$"},{"id":"B","value":"$\\int_0^{2\\pi} (1 + \\sin\\theta)^2 \\, d\\theta$"},{"id":"C","value":"$\\frac{1}{2} \\int_0^{2\\pi} (1 + \\sin\\theta) \\, d\\theta$"},{"id":"D","value":"$\\int_0^{2\\pi} (1 + \\sin\\theta) \\, d\\theta$"}]',
    updated_at = NOW() 
WHERE id = '1cfbe8ae-ac74-4029-8acb-4120e6dba17a';
DELETE FROM question_skills WHERE question_id = '1ea9d9c6-c358-4a09-b6e6-d88f014bc71f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1ea9d9c6-c358-4a09-b6e6-d88f014bc71f', 'vector_path_interpretation', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1ea9d9c6-c358-4a09-b6e6-d88f014bc71f', 'vector_valued_position', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('1ea9d9c6-c358-4a09-b6e6-d88f014bc71f', 'polar_derivative_slope', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_derivative_slope', 
    supporting_skill_ids = '{"vector_path_interpretation","vector_valued_position"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_path_interpretation","vector_valued_position","polar_derivative_slope"}', 
    error_tags = '{"graph_reading_interval_error","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$(2, 4)$"},{"id":"B","value":"$(4, 2)$"},{"id":"C","value":"$(2, 2)$"},{"id":"D","value":"$(0, 2)$"}]',
    updated_at = NOW() 
WHERE id = '1ea9d9c6-c358-4a09-b6e6-d88f014bc71f';
DELETE FROM question_skills WHERE question_id = '210db70b-c5f2-424e-9eb0-e22fed144c4f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('210db70b-c5f2-424e-9eb0-e22fed144c4f', 'vector_displacement_from_table', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('210db70b-c5f2-424e-9eb0-e22fed144c4f', 'bounds_from_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_displacement_from_table', 
    supporting_skill_ids = '{"bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_displacement_from_table","bounds_from_context"}', 
    error_tags = '{"vector_displacement_endpoint_swap","graph_reading_interval_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\langle 4, 2 \\rangle$"},{"id":"B","value":"$\\langle 2, 1 \\rangle$"},{"id":"C","value":"$\\langle 2, 2 \\rangle$"},{"id":"D","value":"$\\langle 0, 2 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = '210db70b-c5f2-424e-9eb0-e22fed144c4f';
DELETE FROM question_skills WHERE question_id = '2ac1b654-d16b-4d75-aff8-5608ad04cbff';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ac1b654-d16b-4d75-aff8-5608ad04cbff', 'vector_speed_magnitude', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2ac1b654-d16b-4d75-aff8-5608ad04cbff', 'vector_derivative_velocity', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_speed_magnitude', 
    supporting_skill_ids = '{"vector_derivative_velocity"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_speed_magnitude","vector_derivative_velocity"}', 
    error_tags = '{"speed_missing_magnitude","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$5$"},{"id":"B","value":"$1$"},{"id":"C","value":"$7$"},{"id":"D","value":"$-5$"}]',
    updated_at = NOW() 
WHERE id = '2ac1b654-d16b-4d75-aff8-5608ad04cbff';
DELETE FROM question_skills WHERE question_id = '2c04142c-7ae9-4f17-b8fd-e08212579543';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2c04142c-7ae9-4f17-b8fd-e08212579543', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2c04142c-7ae9-4f17-b8fd-e08212579543', 'graph_reading_interval_error', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('2c04142c-7ae9-4f17-b8fd-e08212579543', 'polar_area_between_curves', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_between_curves', 
    supporting_skill_ids = '{"bounds_from_context","graph_reading_interval_error"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error","polar_area_between_curves"}', 
    error_tags = '{"algebra_simplification_error","graph_reading_interval_error","speed_missing_magnitude"}', 
    options = '[{"id":"A","value":"$1.47$"},{"id":"B","value":"$1.10$"},{"id":"C","value":"$1.99$"},{"id":"D","value":"$0.74$"}]',
    updated_at = NOW() 
WHERE id = '2c04142c-7ae9-4f17-b8fd-e08212579543';
DELETE FROM question_skills WHERE question_id = '3051cc8e-6fc5-4f86-9234-f7d665fbc81c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3051cc8e-6fc5-4f86-9234-f7d665fbc81c', 'vector_valued_function_concept', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3051cc8e-6fc5-4f86-9234-f7d665fbc81c', 'vector_component_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('3051cc8e-6fc5-4f86-9234-f7d665fbc81c', 'vector_valued_motion_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_motion_basics', 
    supporting_skill_ids = '{"vector_valued_function_concept","vector_component_derivative"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_valued_function_concept","vector_component_derivative","vector_valued_motion_basics"}', 
    error_tags = '{"graph_reading_interval_error","param_tangent_line_point_mismatch","velocity_vs_speed_confusion"}', 
    options = '[{"id":"A","value":"It moves along the upper semicircle from $(1,0)$ to $(-1,0)$ counterclockwise."},{"id":"B","value":"It moves along the upper semicircle from $(-1,0)$ to $(1,0)$ counterclockwise."},{"id":"C","value":"It moves along the lower semicircle from $(1,0)$ to $(-1,0)$."},{"id":"D","value":"It stays at $(1,0)$ because the position is periodic."}]',
    updated_at = NOW() 
WHERE id = '3051cc8e-6fc5-4f86-9234-f7d665fbc81c';
DELETE FROM question_skills WHERE question_id = '30581f46-5b19-48c5-a4de-6e4dd97110ad';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('30581f46-5b19-48c5-a4de-6e4dd97110ad', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('30581f46-5b19-48c5-a4de-6e4dd97110ad', 'graph_reading_interval_error', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('30581f46-5b19-48c5-a4de-6e4dd97110ad', 'polar_area_between_curves', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_between_curves', 
    supporting_skill_ids = '{"bounds_from_context","graph_reading_interval_error"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error","polar_area_between_curves"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","parametric_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"$\\frac{1}{2} \\int_{0}^{\\pi/3} ((2\\cos\\theta)^2 - 1^2) \\, d\\theta$"},{"id":"B","value":"$\\frac{1}{2} \\int_{0}^{\\pi/2} ((2\\cos\\theta)^2 - 1^2) \\, d\\theta$"},{"id":"C","value":"$\\frac{1}{2} \\int_{0}^{\\pi/3} (1^2 - (2\\cos\\theta)^2) \\, d\\theta$"},{"id":"D","value":"$\\int_{0}^{\\pi/3} (2\\cos\\theta - 1) \\, d\\theta$"}]',
    updated_at = NOW() 
WHERE id = '30581f46-5b19-48c5-a4de-6e4dd97110ad';
DELETE FROM question_skills WHERE question_id = '33417a9d-1493-4c9e-a5d0-ea936767a6b7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('33417a9d-1493-4c9e-a5d0-ea936767a6b7', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('33417a9d-1493-4c9e-a5d0-ea936767a6b7', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('33417a9d-1493-4c9e-a5d0-ea936767a6b7', 'polar_area_single_curve', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_single_curve', 
    supporting_skill_ids = '{"vector_speed_magnitude","bounds_from_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_speed_magnitude","bounds_from_context","polar_area_single_curve"}', 
    error_tags = '{"speed_missing_magnitude","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$1$"},{"id":"B","value":"$\\sin t + \\cos t$"},{"id":"C","value":"$\\sqrt{\\sin t + \\cos t}$"},{"id":"D","value":"$\\sin^2 t + \\cos^2 t$"}]',
    updated_at = NOW() 
WHERE id = '33417a9d-1493-4c9e-a5d0-ea936767a6b7';
DELETE FROM question_skills WHERE question_id = '349834af-f515-42db-ac6a-7eb43fdf272a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('349834af-f515-42db-ac6a-7eb43fdf272a', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('349834af-f515-42db-ac6a-7eb43fdf272a', 'algebra_simplification_error', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('349834af-f515-42db-ac6a-7eb43fdf272a', 'polar_area_between_curves', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_between_curves', 
    supporting_skill_ids = '{"bounds_from_context","algebra_simplification_error"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"bounds_from_context","algebra_simplification_error","polar_area_between_curves"}', 
    error_tags = '{"algebra_simplification_error","graph_reading_interval_error","derivative_power_rule_error"}', 
    options = '[{"id":"A","value":"$\\frac{\\pi}{3}$"},{"id":"B","value":"$\\frac{\\pi}{2}$"},{"id":"C","value":"$\\frac{2\\pi}{3}$"},{"id":"D","value":"$\\frac{\\pi}{6}$"}]',
    updated_at = NOW() 
WHERE id = '349834af-f515-42db-ac6a-7eb43fdf272a';
DELETE FROM question_skills WHERE question_id = '363cfb89-5f9e-4ee8-920f-73eb4add4d23';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('363cfb89-5f9e-4ee8-920f-73eb4add4d23', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('363cfb89-5f9e-4ee8-920f-73eb4add4d23', 'algebra_simplification_error', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('363cfb89-5f9e-4ee8-920f-73eb4add4d23', 'polar_area_between_curves', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_between_curves', 
    supporting_skill_ids = '{"bounds_from_context","algebra_simplification_error"}', 
    target_time_seconds = 210, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"bounds_from_context","algebra_simplification_error","polar_area_between_curves"}', 
    error_tags = '{"algebra_simplification_error","graph_reading_interval_error","derivative_power_rule_error"}', 
    options = '[{"id":"A","value":"$\\frac{\\pi}{6} + \\frac{\\sqrt{3}}{4}$"},{"id":"B","value":"$\\frac{\\pi}{6} - \\frac{\\sqrt{3}}{4}$"},{"id":"C","value":"$\\frac{\\pi}{3} + \\frac{\\sqrt{3}}{2}$"},{"id":"D","value":"$\\frac{\\pi}{12} + \\frac{\\sqrt{3}}{8}$"}]',
    updated_at = NOW() 
WHERE id = '363cfb89-5f9e-4ee8-920f-73eb4add4d23';
DELETE FROM question_skills WHERE question_id = '40c78a87-ea5c-467e-a798-7716bbb3b281';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('40c78a87-ea5c-467e-a798-7716bbb3b281', 'vector_derivative_velocity', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('40c78a87-ea5c-467e-a798-7716bbb3b281', 'parametric_first_derivatives', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('40c78a87-ea5c-467e-a798-7716bbb3b281', 'polar_to_rectangular_conversion', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_to_rectangular_conversion', 
    supporting_skill_ids = '{"vector_derivative_velocity","parametric_first_derivatives"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_derivative_velocity","parametric_first_derivatives","polar_to_rectangular_conversion"}', 
    error_tags = '{"derivative_power_rule_error","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\langle 2t, -1 \\rangle$"},{"id":"B","value":"$\\langle t, -1 \\rangle$"},{"id":"C","value":"$\\langle 2t, 1 \\rangle$"},{"id":"D","value":"$\\langle t^2, 3-t \\rangle$"}]',
    updated_at = NOW() 
WHERE id = '40c78a87-ea5c-467e-a798-7716bbb3b281';
DELETE FROM question_skills WHERE question_id = '445f6e73-44fc-40ad-be2e-a3037ba3030a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('445f6e73-44fc-40ad-be2e-a3037ba3030a', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('445f6e73-44fc-40ad-be2e-a3037ba3030a', 'vector_velocity_acceleration', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('445f6e73-44fc-40ad-be2e-a3037ba3030a', 'vector_valued_motion_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_motion_basics', 
    supporting_skill_ids = '{"vector_speed_magnitude","vector_velocity_acceleration"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_speed_magnitude","vector_velocity_acceleration","vector_valued_motion_basics"}', 
    error_tags = '{"velocity_vs_speed_confusion","vector_magnitude_error","calculator_mode_or_rounding_issue"}', 
    options = '[{"id":"A","value":"$-1$"},{"id":"B","value":"$7$"},{"id":"C","value":"$5$"},{"id":"D","value":"$1$"}]',
    updated_at = NOW() 
WHERE id = '445f6e73-44fc-40ad-be2e-a3037ba3030a';
DELETE FROM question_skills WHERE question_id = '4692d815-c08d-4b45-be0e-8b85174fe986';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4692d815-c08d-4b45-be0e-8b85174fe986', 'polar_arc_length_formula', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4692d815-c08d-4b45-be0e-8b85174fe986', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4692d815-c08d-4b45-be0e-8b85174fe986', 'vector_valued_position_integral', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_position_integral', 
    supporting_skill_ids = '{"polar_arc_length_formula","bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"polar_arc_length_formula","bounds_from_context","vector_valued_position_integral"}', 
    error_tags = '{"arc_length_missing_sqrt_structure","arc_length_wrong_bounds","polar_arc_length_missing_dr_dtheta"}', 
    options = '[{"id":"A","value":"$\\sqrt{r^2 + (\\frac{dr}{d\\theta})^2}$"},{"id":"B","value":"$\\sqrt{1 + (\\frac{dr}{d\\theta})^2}$"},{"id":"C","value":"$r + \\frac{dr}{d\\theta}$"},{"id":"D","value":"$r^2 + (\\frac{dr}{d\\theta})^2$"}]',
    updated_at = NOW() 
WHERE id = '4692d815-c08d-4b45-be0e-8b85174fe986';
DELETE FROM question_skills WHERE question_id = '4823b93a-40eb-4dc5-bd37-d1b2fd59209e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4823b93a-40eb-4dc5-bd37-d1b2fd59209e', 'parametric_tangent_normal_lines', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4823b93a-40eb-4dc5-bd37-d1b2fd59209e', 'parametric_dydx', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('4823b93a-40eb-4dc5-bd37-d1b2fd59209e', 'parametric_derivative_dy_dx', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_derivative_dy_dx', 
    supporting_skill_ids = '{"parametric_tangent_normal_lines","parametric_dydx"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_tangent_normal_lines","parametric_dydx","parametric_derivative_dy_dx"}', 
    error_tags = '{"param_dydx_missing_divide_by_dxdt","param_tangent_line_point_mismatch","param_dxdt_zero_not_checked"}', 
    options = '[{"id":"A","value":"$y=x-1$"},{"id":"B","value":"$y=-x+1$"},{"id":"C","value":"$y=2x-2$"},{"id":"D","value":"$y=1/2x-1/2$"}]',
    updated_at = NOW() 
WHERE id = '4823b93a-40eb-4dc5-bd37-d1b2fd59209e';
DELETE FROM question_skills WHERE question_id = '484483f3-2d2c-4b36-be4b-c993094bd87d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('484483f3-2d2c-4b36-be4b-c993094bd87d', 'vector_derivative_velocity', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('484483f3-2d2c-4b36-be4b-c993094bd87d', 'bounds_from_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_derivative_velocity', 
    supporting_skill_ids = '{"bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_derivative_velocity","bounds_from_context"}', 
    error_tags = '{"parametric_dydx_missing_divide_by_dxdt","derivative_power_rule_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\frac{3t^2-3}{2t}$"},{"id":"B","value":"$\\frac{3t^2-3}{2t^2}$"},{"id":"C","value":"$\\frac{3t^2-3}{4t^2}$"},{"id":"D","value":"$\\frac{3t^2-3}{4t^3}$"}]',
    updated_at = NOW() 
WHERE id = '484483f3-2d2c-4b36-be4b-c993094bd87d';
DELETE FROM question_skills WHERE question_id = '5896dce4-e74f-4ab3-a6c9-2495b0d9db19';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5896dce4-e74f-4ab3-a6c9-2495b0d9db19', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5896dce4-e74f-4ab3-a6c9-2495b0d9db19', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5896dce4-e74f-4ab3-a6c9-2495b0d9db19', 'polar_derivative_slope', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_derivative_slope', 
    supporting_skill_ids = '{"vector_speed_magnitude","bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_speed_magnitude","bounds_from_context","polar_derivative_slope"}', 
    error_tags = '{"speed_missing_magnitude","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$\\sqrt{2}$"},{"id":"B","value":"$0$"},{"id":"C","value":"$2$"},{"id":"D","value":"$-\\sqrt{2}$"}]',
    updated_at = NOW() 
WHERE id = '5896dce4-e74f-4ab3-a6c9-2495b0d9db19';
DELETE FROM question_skills WHERE question_id = '5942e552-036d-4e8a-a205-5ca7132911e0';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5942e552-036d-4e8a-a205-5ca7132911e0', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('5942e552-036d-4e8a-a205-5ca7132911e0', 'vector_derivative_velocity', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"vector_derivative_velocity"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","vector_derivative_velocity"}', 
    error_tags = '{"parametric_dydx_missing_divide_by_dxdt","algebra_simplification_error","derivative_power_rule_error"}', 
    options = '[{"id":"A","value":"$\\cos\\theta$"},{"id":"B","value":"$-\\cos\\theta$"},{"id":"C","value":"$1 + \\cos\\theta$"},{"id":"D","value":"$\\sin\\theta$"}]',
    updated_at = NOW() 
WHERE id = '5942e552-036d-4e8a-a205-5ca7132911e0';
DELETE FROM question_skills WHERE question_id = '61431c58-5f91-4526-aeb4-56966039a60f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('61431c58-5f91-4526-aeb4-56966039a60f', 'parametric_second_derivative', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('61431c58-5f91-4526-aeb4-56966039a60f', 'parametric_dydx', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_second_derivative', 
    supporting_skill_ids = '{"parametric_dydx"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_second_derivative","parametric_dydx"}', 
    error_tags = '{"param_second_derivative_wrong_formula","param_dxdt_zero_not_checked","param_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"$3/4$"},{"id":"B","value":"$4/3$"},{"id":"C","value":"$3$"},{"id":"D","value":"$3/8$"}]',
    updated_at = NOW() 
WHERE id = '61431c58-5f91-4526-aeb4-56966039a60f';
DELETE FROM question_skills WHERE question_id = '677d688f-31c0-4733-b9eb-77aa4991f2a2';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('677d688f-31c0-4733-b9eb-77aa4991f2a2', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('677d688f-31c0-4733-b9eb-77aa4991f2a2', 'vector_speed_magnitude', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"vector_speed_magnitude"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","vector_speed_magnitude"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","speed_missing_magnitude"}', 
    options = '[{"id":"A","value":"$10.0$"},{"id":"B","value":"$8.0$"},{"id":"C","value":"$12.0$"},{"id":"D","value":"$5.0$"}]',
    updated_at = NOW() 
WHERE id = '677d688f-31c0-4733-b9eb-77aa4991f2a2';
DELETE FROM question_skills WHERE question_id = '6a301382-316f-4d02-9f5f-15f014a2e777';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6a301382-316f-4d02-9f5f-15f014a2e777', 'vector_displacement_from_table', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6a301382-316f-4d02-9f5f-15f014a2e777', 'vector_valued_position', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6a301382-316f-4d02-9f5f-15f014a2e777', 'polar_to_rectangular_conversion', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_to_rectangular_conversion', 
    supporting_skill_ids = '{"vector_displacement_from_table","vector_valued_position"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_displacement_from_table","vector_valued_position","polar_to_rectangular_conversion"}', 
    error_tags = '{"vector_displacement_endpoint_swap","graph_reading_interval_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\langle 0, 4 \\rangle$"},{"id":"B","value":"$\\langle 4, 0 \\rangle$"},{"id":"C","value":"$\\langle -4, 0 \\rangle$"},{"id":"D","value":"$\\langle 1, 4 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = '6a301382-316f-4d02-9f5f-15f014a2e777';
DELETE FROM question_skills WHERE question_id = '6bd8cbb5-d228-485c-89bd-91faa5c3d805';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6bd8cbb5-d228-485c-89bd-91faa5c3d805', 'parametric_representation_concept', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6bd8cbb5-d228-485c-89bd-91faa5c3d805', 'parametric_first_derivatives', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('6bd8cbb5-d228-485c-89bd-91faa5c3d805', 'parametric_derivative_dy_dx', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_derivative_dy_dx', 
    supporting_skill_ids = '{"parametric_representation_concept","parametric_first_derivatives"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_representation_concept","parametric_first_derivatives","parametric_derivative_dy_dx"}', 
    error_tags = '{"param_tangent_line_point_mismatch","graph_reading_interval_error","param_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"It moves counterclockwise along the unit circle from $(1,0)$ to $(0,1)$."},{"id":"B","value":"It moves clockwise along the unit circle from $(1,0)$ to $(0,1)$."},{"id":"C","value":"It moves along a line segment from $(0,1)$ to $(1,0)$."},{"id":"D","value":"It stays at a single point because co$s(t)$ and si$n(t)$ are periodic."}]',
    updated_at = NOW() 
WHERE id = '6bd8cbb5-d228-485c-89bd-91faa5c3d805';
DELETE FROM question_skills WHERE question_id = '7794304a-14a7-421b-b325-c554ea6b66da';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7794304a-14a7-421b-b325-c554ea6b66da', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7794304a-14a7-421b-b325-c554ea6b66da', 'graph_reading_interval_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"graph_reading_interval_error"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$\\frac{1}{2} \\int_a^b (f(\\theta))^2 \\, d\\theta$"},{"id":"B","value":"$\\int_a^b f(\\theta) \\, d\\theta$"},{"id":"C","value":"$\\int_a^b \\sqrt{1 + (f''(\\theta))^2} \\, d\\theta$"},{"id":"D","value":"$| \\int_a^b f(\\theta) \\, d\\theta |$"}]',
    updated_at = NOW() 
WHERE id = '7794304a-14a7-421b-b325-c554ea6b66da';
DELETE FROM question_skills WHERE question_id = '78779b1b-59fd-4aea-965a-52b1579635b7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('78779b1b-59fd-4aea-965a-52b1579635b7', 'parametric_second_derivative', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('78779b1b-59fd-4aea-965a-52b1579635b7', 'parametric_dydx', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_second_derivative', 
    supporting_skill_ids = '{"parametric_dydx"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_second_derivative","parametric_dydx"}', 
    error_tags = '{"param_second_derivative_wrong_formula","param_dydx_missing_divide_by_dxdt","param_dxdt_zero_not_checked"}', 
    options = '[{"id":"A","value":"$3/4$"},{"id":"B","value":"$3/2$"},{"id":"C","value":"$1/2$"},{"id":"D","value":"$3/8$"}]',
    updated_at = NOW() 
WHERE id = '78779b1b-59fd-4aea-965a-52b1579635b7';
DELETE FROM question_skills WHERE question_id = '7b3d2dba-b960-4bf7-a060-6c46a37be0fc';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7b3d2dba-b960-4bf7-a060-6c46a37be0fc', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7b3d2dba-b960-4bf7-a060-6c46a37be0fc', 'algebra_simplification_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"algebra_simplification_error"}', 
    target_time_seconds = 210, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","algebra_simplification_error"}', 
    error_tags = '{"algebra_simplification_error","graph_reading_interval_error","derivative_power_rule_error"}', 
    options = '[{"id":"A","value":"$\\frac{\\pi}{6} + \\frac{\\sqrt{3}}{4}$"},{"id":"B","value":"$\\frac{\\pi}{6} - \\frac{\\sqrt{3}}{4}$"},{"id":"C","value":"$\\frac{\\pi}{3} + \\frac{\\sqrt{3}}{2}$"},{"id":"D","value":"$\\frac{\\pi}{12} + \\frac{\\sqrt{3}}{8}$"}]',
    updated_at = NOW() 
WHERE id = '7b3d2dba-b960-4bf7-a060-6c46a37be0fc';
DELETE FROM question_skills WHERE question_id = '7c8368dd-0ea5-455b-8154-293369c9fbe0';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7c8368dd-0ea5-455b-8154-293369c9fbe0', 'parametric_concavity_analysis', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7c8368dd-0ea5-455b-8154-293369c9fbe0', 'parametric_representation_concept', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('7c8368dd-0ea5-455b-8154-293369c9fbe0', 'parametric_second_derivative', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_second_derivative', 
    supporting_skill_ids = '{"parametric_concavity_analysis","parametric_representation_concept"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_concavity_analysis","parametric_representation_concept","parametric_second_derivative"}', 
    error_tags = '{"param_concavity_sign_error","param_tangent_line_point_mismatch","param_second_derivative_wrong_formula"}', 
    options = '[{"id":"A","value":"$(0,0)$"},{"id":"B","value":"$(1,-2)$"},{"id":"C","value":"$(-1,2)$"},{"id":"D","value":"$(0,-3)$"}]',
    updated_at = NOW() 
WHERE id = '7c8368dd-0ea5-455b-8154-293369c9fbe0';
DELETE FROM question_skills WHERE question_id = '819027ac-a51f-4f1d-81d5-bfa34752667e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('819027ac-a51f-4f1d-81d5-bfa34752667e', 'vector_valued_position', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('819027ac-a51f-4f1d-81d5-bfa34752667e', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('819027ac-a51f-4f1d-81d5-bfa34752667e', 'polar_area_single_curve', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_single_curve', 
    supporting_skill_ids = '{"vector_valued_position","bounds_from_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_valued_position","bounds_from_context","polar_area_single_curve"}', 
    error_tags = '{"vector_displacement_endpoint_swap","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\langle 10, -5 \\rangle$"},{"id":"B","value":"$\\langle 2, -1 \\rangle$"},{"id":"C","value":"$\\langle 5, -2 \\rangle$"},{"id":"D","value":"$\\langle -10, 5 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = '819027ac-a51f-4f1d-81d5-bfa34752667e';
DELETE FROM question_skills WHERE question_id = '8323f25c-f6f3-4de0-b12b-9c2ab6d1c66f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8323f25c-f6f3-4de0-b12b-9c2ab6d1c66f', 'vector_valued_position', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('8323f25c-f6f3-4de0-b12b-9c2ab6d1c66f', 'bounds_from_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_position', 
    supporting_skill_ids = '{"bounds_from_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_valued_position","bounds_from_context"}', 
    error_tags = '{"vector_component_swap","algebra_simplification_error","vector_displacement_endpoint_swap"}', 
    options = '[{"id":"A","value":"$\\langle 2t+1, 3 \\rangle$"},{"id":"B","value":"$\\langle 2t, 3 \\rangle$"},{"id":"C","value":"$\\langle t+1, 3t \\rangle$"},{"id":"D","value":"$\\langle 2t+3, 1 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = '8323f25c-f6f3-4de0-b12b-9c2ab6d1c66f';
DELETE FROM question_skills WHERE question_id = '91e575ac-d954-4834-9b2f-92b384c33240';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('91e575ac-d954-4834-9b2f-92b384c33240', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('91e575ac-d954-4834-9b2f-92b384c33240', 'graph_reading_interval_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"graph_reading_interval_error"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$\\frac{\\pi}{3}$"},{"id":"B","value":"$\\frac{\\pi}{6}$"},{"id":"C","value":"$\\frac{\\pi}{2}$"},{"id":"D","value":"$\\frac{2\\pi}{3}$"}]',
    updated_at = NOW() 
WHERE id = '91e575ac-d954-4834-9b2f-92b384c33240';
DELETE FROM question_skills WHERE question_id = '92db6ddb-3bb0-42cb-9087-6a9cca80e8ad';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('92db6ddb-3bb0-42cb-9087-6a9cca80e8ad', 'vector_derivative_velocity', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('92db6ddb-3bb0-42cb-9087-6a9cca80e8ad', 'bounds_from_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_derivative_velocity', 
    supporting_skill_ids = '{"bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_derivative_velocity","bounds_from_context"}', 
    error_tags = '{"parametric_dydx_missing_divide_by_dxdt","algebra_simplification_error","derivative_power_rule_error"}', 
    options = '[{"id":"A","value":"$-1$"},{"id":"B","value":"$1$"},{"id":"C","value":"$-\\sqrt{2}$"},{"id":"D","value":"$0$"}]',
    updated_at = NOW() 
WHERE id = '92db6ddb-3bb0-42cb-9087-6a9cca80e8ad';
DELETE FROM question_skills WHERE question_id = '97eec5a9-a1f7-4ef3-accb-77d0b9449762';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('97eec5a9-a1f7-4ef3-accb-77d0b9449762', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('97eec5a9-a1f7-4ef3-accb-77d0b9449762', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('97eec5a9-a1f7-4ef3-accb-77d0b9449762', 'polar_area_single_curve', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_single_curve', 
    supporting_skill_ids = '{"vector_speed_magnitude","bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_speed_magnitude","bounds_from_context","polar_area_single_curve"}', 
    error_tags = '{"speed_missing_magnitude","graph_reading_interval_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\int_a^b \\|\\mathbf{v}(t)\\| \\, dt$"},{"id":"B","value":"\\| $\\int_a^b \\mathbf{v}(t) \\, dt$ \\|"},{"id":"C","value":"$\\int_a^b \\mathbf{v}(t) \\, dt$"},{"id":"D","value":"$\\int_a^b \\|\\mathbf{v}(t)\\|^2 \\, dt$"}]',
    updated_at = NOW() 
WHERE id = '97eec5a9-a1f7-4ef3-accb-77d0b9449762';
DELETE FROM question_skills WHERE question_id = '9a18403a-4400-4c99-ab36-56fb784ff0d4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9a18403a-4400-4c99-ab36-56fb784ff0d4', 'polar_graph_interpretation', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9a18403a-4400-4c99-ab36-56fb784ff0d4', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9a18403a-4400-4c99-ab36-56fb784ff0d4', 'vector_valued_position_integral', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_position_integral', 
    supporting_skill_ids = '{"polar_graph_interpretation","bounds_from_context"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"polar_graph_interpretation","bounds_from_context","vector_valued_position_integral"}', 
    error_tags = '{"graph_reading_interval_error","polar_area_wrong_bounds","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"It is a circle of radius $1$ centered at $(1,0)$."},{"id":"B","value":"It is a circle of radius $2$ centered at the origin."},{"id":"C","value":"It is a cardioid with a cusp at the origin."},{"id":"D","value":"It is a line segment along the $y$-axis."}]',
    updated_at = NOW() 
WHERE id = '9a18403a-4400-4c99-ab36-56fb784ff0d4';
DELETE FROM question_skills WHERE question_id = '9b07fc35-5de4-4266-b87a-9d432894e95b';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9b07fc35-5de4-4266-b87a-9d432894e95b', 'polar_area_between_curves', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9b07fc35-5de4-4266-b87a-9d432894e95b', 'polar_graph_interpretation', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('9b07fc35-5de4-4266-b87a-9d432894e95b', 'vector_valued_position_integral', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_position_integral', 
    supporting_skill_ids = '{"polar_area_between_curves","polar_graph_interpretation"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"polar_area_between_curves","polar_graph_interpretation","vector_valued_position_integral"}', 
    error_tags = '{"polar_area_wrong_outer_inner","polar_area_wrong_bounds","polar_area_missing_one_half"}', 
    options = '[{"id":"A","value":"$\\frac{1}{2} \\int_0^{2\\pi} (4 - (1 + \\cos\\theta)^2) \\, d\\theta$"},{"id":"B","value":"$\\frac{1}{2} \\int_0^{2\\pi} ((1 + \\cos\\theta)^2 - 4) \\, d\\theta$"},{"id":"C","value":"$\\int_0^{2\\pi} (2 - (1 + \\cos\\theta)) \\, d\\theta$"},{"id":"D","value":"$\\frac{1}{2} \\int_0^{\\pi} (4 - (1 + \\cos\\theta)^2) \\, d\\theta$"}]',
    updated_at = NOW() 
WHERE id = '9b07fc35-5de4-4266-b87a-9d432894e95b';
DELETE FROM question_skills WHERE question_id = 'a16483b4-f4a1-484b-ba15-d49bb794eb2a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a16483b4-f4a1-484b-ba15-d49bb794eb2a', 'parametric_arc_length', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a16483b4-f4a1-484b-ba15-d49bb794eb2a', 'parametric_representation_concept', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_arc_length', 
    supporting_skill_ids = '{"parametric_representation_concept"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_arc_length","parametric_representation_concept"}', 
    error_tags = '{"arc_length_wrong_bounds","graph_reading_interval_error","arc_length_missing_squares"}', 
    options = '[{"id":"A","value":"$0<=t<=3$"},{"id":"B","value":"$-3<=t<=0$"},{"id":"C","value":"$1<=t<=9$"},{"id":"D","value":"$-2<=t<=1$"}]',
    updated_at = NOW() 
WHERE id = 'a16483b4-f4a1-484b-ba15-d49bb794eb2a';
DELETE FROM question_skills WHERE question_id = 'a5249bf3-7689-4fc9-ba07-6cc4d6026e53';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a5249bf3-7689-4fc9-ba07-6cc4d6026e53', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a5249bf3-7689-4fc9-ba07-6cc4d6026e53', 'vector_derivative_velocity', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a5249bf3-7689-4fc9-ba07-6cc4d6026e53', 'polar_area_single_curve', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_single_curve', 
    supporting_skill_ids = '{"vector_speed_magnitude","vector_derivative_velocity"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_speed_magnitude","vector_derivative_velocity","polar_area_single_curve"}', 
    error_tags = '{"speed_missing_magnitude","derivative_power_rule_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\sqrt{13}$"},{"id":"B","value":"$5$"},{"id":"C","value":"$\\sqrt{5}$"},{"id":"D","value":"$13$"}]',
    updated_at = NOW() 
WHERE id = 'a5249bf3-7689-4fc9-ba07-6cc4d6026e53';
DELETE FROM question_skills WHERE question_id = 'a633bc58-29ba-4dd7-b2b0-b7b06880ad5a';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a633bc58-29ba-4dd7-b2b0-b7b06880ad5a', 'polar_area_between_curves', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a633bc58-29ba-4dd7-b2b0-b7b06880ad5a', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a633bc58-29ba-4dd7-b2b0-b7b06880ad5a', 'vector_valued_position_integral', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_position_integral', 
    supporting_skill_ids = '{"polar_area_between_curves","bounds_from_context"}', 
    target_time_seconds = 210, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"polar_area_between_curves","bounds_from_context","vector_valued_position_integral"}', 
    error_tags = '{"polar_area_wrong_outer_inner","polar_area_wrong_bounds","polar_area_missing_one_half"}', 
    options = '[{"id":"A","value":"$\\frac{1}{2} \\int_0^{2\\pi} (2^2 - (1 + \\cos\\theta)^2) \\, d\\theta$"},{"id":"B","value":"$\\frac{1}{2} \\int_0^{2\\pi} ((1 + \\cos\\theta)^2 - 2^2) \\, d\\theta$"},{"id":"C","value":"$\\int_0^{2\\pi} (2 - (1 + \\cos\\theta)) \\, d\\theta$"},{"id":"D","value":"$\\frac{1}{2} (\\int_0^{2\\pi} 2^2 \\, d\\theta - \\int_0^{2\\pi} (1 + \\cos\\theta) \\, d\\theta)$"}]',
    updated_at = NOW() 
WHERE id = 'a633bc58-29ba-4dd7-b2b0-b7b06880ad5a';
DELETE FROM question_skills WHERE question_id = 'a688da17-9c1d-4fb7-acfa-85ec1be736f9';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a688da17-9c1d-4fb7-acfa-85ec1be736f9', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a688da17-9c1d-4fb7-acfa-85ec1be736f9', 'graph_reading_interval_error', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a688da17-9c1d-4fb7-acfa-85ec1be736f9', 'polar_area_between_curves', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_between_curves', 
    supporting_skill_ids = '{"bounds_from_context","graph_reading_interval_error"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error","polar_area_between_curves"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$0 \\le \\theta \\le \\frac{\\pi}{3}$"},{"id":"B","value":"$\\frac{\\pi}{3} \\le \\theta \\le \\frac{\\pi}{2}$"},{"id":"C","value":"$0 \\le \\theta \\le \\frac{\\pi}{2}$"},{"id":"D","value":"$\\frac{\\pi}{6} \\le \\theta \\le \\frac{\\pi}{3}$"}]',
    updated_at = NOW() 
WHERE id = 'a688da17-9c1d-4fb7-acfa-85ec1be736f9';
DELETE FROM question_skills WHERE question_id = 'a7551acd-9ec0-4b1f-80b9-5588244d4b62';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a7551acd-9ec0-4b1f-80b9-5588244d4b62', 'parametric_horizontal_vertical_tangents', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a7551acd-9ec0-4b1f-80b9-5588244d4b62', 'parametric_dydx', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('a7551acd-9ec0-4b1f-80b9-5588244d4b62', 'parametric_derivative_dy_dx', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_derivative_dy_dx', 
    supporting_skill_ids = '{"parametric_horizontal_vertical_tangents","parametric_dydx"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_horizontal_vertical_tangents","parametric_dydx","parametric_derivative_dy_dx"}', 
    error_tags = '{"param_dxdt_zero_not_checked","param_horizontal_vertical_conditions_swapped","param_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"$t=-1$ and $t=1$"},{"id":"B","value":"$t=0$ only"},{"id":"C","value":"$t=-1$ only"},{"id":"D","value":"$t=1$ only"}]',
    updated_at = NOW() 
WHERE id = 'a7551acd-9ec0-4b1f-80b9-5588244d4b62';
DELETE FROM question_skills WHERE question_id = 'ad734da9-97cd-49e3-b713-50bd7bbbfc3e';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ad734da9-97cd-49e3-b713-50bd7bbbfc3e', 'vector_derivative_velocity', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ad734da9-97cd-49e3-b713-50bd7bbbfc3e', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ad734da9-97cd-49e3-b713-50bd7bbbfc3e', 'polar_derivative_slope', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_derivative_slope', 
    supporting_skill_ids = '{"vector_derivative_velocity","bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_derivative_velocity","bounds_from_context","polar_derivative_slope"}', 
    error_tags = '{"parametric_dydx_missing_divide_by_dxdt","algebra_simplification_error","graph_reading_interval_error"}', 
    options = '[{"id":"A","value":"$3$"},{"id":"B","value":"$\\frac{3}{2}$"},{"id":"C","value":"$\\frac{9}{4}$"},{"id":"D","value":"$\\frac{4}{9}$"}]',
    updated_at = NOW() 
WHERE id = 'ad734da9-97cd-49e3-b713-50bd7bbbfc3e';
DELETE FROM question_skills WHERE question_id = 'b0746c49-7371-46d0-9cfc-7d3c1500cfd5';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b0746c49-7371-46d0-9cfc-7d3c1500cfd5', 'vector_derivative_velocity', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b0746c49-7371-46d0-9cfc-7d3c1500cfd5', 'vector_valued_position', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b0746c49-7371-46d0-9cfc-7d3c1500cfd5', 'polar_derivative_slope', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_derivative_slope', 
    supporting_skill_ids = '{"vector_derivative_velocity","vector_valued_position"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_derivative_velocity","vector_valued_position","polar_derivative_slope"}', 
    error_tags = '{"derivative_power_rule_error","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\langle 1, 2t \\rangle$"},{"id":"B","value":"$\\langle t, 2t \\rangle$"},{"id":"C","value":"$\\langle 1, t^2 \\rangle$"},{"id":"D","value":"$\\langle 2t, 1 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = 'b0746c49-7371-46d0-9cfc-7d3c1500cfd5';
DELETE FROM question_skills WHERE question_id = 'b1c77136-6321-4ebc-a48e-77c4df7e2982';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b1c77136-6321-4ebc-a48e-77c4df7e2982', 'vector_path_interpretation', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('b1c77136-6321-4ebc-a48e-77c4df7e2982', 'vector_valued_position', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_path_interpretation', 
    supporting_skill_ids = '{"vector_valued_position"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_path_interpretation","vector_valued_position"}', 
    error_tags = '{"graph_reading_interval_error","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"The motion follows the arrow on the curve."},{"id":"B","value":"The motion always goes left to right."},{"id":"C","value":"The motion always goes upward."},{"id":"D","value":"Direction cannot be determined."}]',
    updated_at = NOW() 
WHERE id = 'b1c77136-6321-4ebc-a48e-77c4df7e2982';
DELETE FROM question_skills WHERE question_id = 'ba3f16c0-8b0c-4f94-9500-0afd823b569b';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ba3f16c0-8b0c-4f94-9500-0afd823b569b', 'parametric_dydx', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ba3f16c0-8b0c-4f94-9500-0afd823b569b', 'parametric_first_derivatives', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ba3f16c0-8b0c-4f94-9500-0afd823b569b', 'parametric_derivative_dy_dx', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_derivative_dy_dx', 
    supporting_skill_ids = '{"parametric_dydx","parametric_first_derivatives"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_dydx","parametric_first_derivatives","parametric_derivative_dy_dx"}', 
    error_tags = '{"param_dydx_missing_divide_by_dxdt","param_tangent_line_point_mismatch","param_elimination_algebra_error"}', 
    options = '[{"id":"A","value":"$3/4$"},{"id":"B","value":"$4/3$"},{"id":"C","value":"$3/2$"},{"id":"D","value":"$3/8$"}]',
    updated_at = NOW() 
WHERE id = 'ba3f16c0-8b0c-4f94-9500-0afd823b569b';
DELETE FROM question_skills WHERE question_id = 'bb3a763a-590e-4f5a-bada-b8027b30c07f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('bb3a763a-590e-4f5a-bada-b8027b30c07f', 'parametric_arc_length', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('bb3a763a-590e-4f5a-bada-b8027b30c07f', 'parametric_first_derivatives', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_arc_length', 
    supporting_skill_ids = '{"parametric_first_derivatives"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","B":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_arc_length","parametric_first_derivatives"}', 
    error_tags = '{"arc_length_wrong_bounds","arc_length_missing_squares","arc_length_simplification_error"}', 
    options = '[{"id":"A","value":"$1$"},{"id":"B","value":"$\\pi$/2"},{"id":"C","value":"$\\pi$"},{"id":"D","value":"$2$"}]',
    updated_at = NOW() 
WHERE id = 'bb3a763a-590e-4f5a-bada-b8027b30c07f';
DELETE FROM question_skills WHERE question_id = 'c1b75290-daeb-4489-a3d3-bb72835900e7';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c1b75290-daeb-4489-a3d3-bb72835900e7', 'parametric_arc_length', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c1b75290-daeb-4489-a3d3-bb72835900e7', 'parametric_first_derivatives', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_arc_length', 
    supporting_skill_ids = '{"parametric_first_derivatives"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_arc_length","parametric_first_derivatives"}', 
    error_tags = '{"arc_length_wrong_bounds","arc_length_simplification_error","calculator_mode_or_rounding_issue"}', 
    options = '[{"id":"A","value":"$17.8$"},{"id":"B","value":"$18.0$"},{"id":"C","value":"$16.8$"},{"id":"D","value":"$35.6$"}]',
    updated_at = NOW() 
WHERE id = 'c1b75290-daeb-4489-a3d3-bb72835900e7';
DELETE FROM question_skills WHERE question_id = 'c1e0cc2d-5cb8-46c2-b7e5-75e757beb2fc';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c1e0cc2d-5cb8-46c2-b7e5-75e757beb2fc', 'parametric_eliminate_parameter', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c1e0cc2d-5cb8-46c2-b7e5-75e757beb2fc', 'parametric_representation_concept', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c1e0cc2d-5cb8-46c2-b7e5-75e757beb2fc', 'parametric_derivative_dy_dx', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_derivative_dy_dx', 
    supporting_skill_ids = '{"parametric_eliminate_parameter","parametric_representation_concept"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_eliminate_parameter","parametric_representation_concept","parametric_derivative_dy_dx"}', 
    error_tags = '{"param_elimination_algebra_error","param_tangent_line_point_mismatch","calculator_mode_or_rounding_issue"}', 
    options = '[{"id":"A","value":"$y=((x-1)/2)^2$"},{"id":"B","value":"$y=(x-1)/2$"},{"id":"C","value":"$y=(2/(x-1))^2$"},{"id":"D","value":"$y=(x-1)^2$"}]',
    updated_at = NOW() 
WHERE id = 'c1e0cc2d-5cb8-46c2-b7e5-75e757beb2fc';
DELETE FROM question_skills WHERE question_id = 'c7e2157f-3b11-430a-944f-da89fcc8e729';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c7e2157f-3b11-430a-944f-da89fcc8e729', 'parametric_concavity_analysis', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('c7e2157f-3b11-430a-944f-da89fcc8e729', 'parametric_second_derivative', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_second_derivative', 
    supporting_skill_ids = '{"parametric_concavity_analysis"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_concavity_analysis","parametric_second_derivative"}', 
    error_tags = '{"param_concavity_sign_error","param_second_derivative_wrong_formula","param_tangent_line_point_mismatch"}', 
    options = '[{"id":"A","value":"Concave up"},{"id":"B","value":"Concave down"},{"id":"C","value":"Neither; $d^2y/dx^2$=0 at $t=1$"},{"id":"D","value":"Cannot be determined without numerical values"}]',
    updated_at = NOW() 
WHERE id = 'c7e2157f-3b11-430a-944f-da89fcc8e729';
DELETE FROM question_skills WHERE question_id = 'ca7b241f-f31f-4270-94cf-769fb44fd3b2';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ca7b241f-f31f-4270-94cf-769fb44fd3b2', 'vector_displacement_from_table', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ca7b241f-f31f-4270-94cf-769fb44fd3b2', 'bounds_from_context', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_displacement_from_table', 
    supporting_skill_ids = '{"bounds_from_context"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_displacement_from_table","bounds_from_context"}', 
    error_tags = '{"vector_displacement_endpoint_swap","graph_reading_interval_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\frac{\\Delta x}{\\Delta t}$ using the first and last rows"},{"id":"B","value":"Average of all listed $x$ values"},{"id":"C","value":"Largest listed $x$ value"},{"id":"D","value":"Sum of all listed $x$ values"}]',
    updated_at = NOW() 
WHERE id = 'ca7b241f-f31f-4270-94cf-769fb44fd3b2';
DELETE FROM question_skills WHERE question_id = 'ccb60045-f70b-43cd-aacd-1e661deb9045';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ccb60045-f70b-43cd-aacd-1e661deb9045', 'parametric_arc_length', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ccb60045-f70b-43cd-aacd-1e661deb9045', 'parametric_first_derivatives', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_arc_length', 
    supporting_skill_ids = '{"parametric_first_derivatives"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_arc_length","parametric_first_derivatives"}', 
    error_tags = '{"arc_length_missing_squares","arc_length_wrong_bounds","arc_length_simplification_error"}', 
    options = '[{"id":"A","value":"$\\int _0^1 \\sqrt ((2t)^2+(e^t)^2) dt$"},{"id":"B","value":"$\\int _0^1 (2t+e^t) dt$"},{"id":"C","value":"$\\int _0^1 \\sqrt (1+(e^t/2t)^2) dt$"},{"id":"D","value":"$\\int _0^1 \\sqrt ((2t)+(e^t)) dt$"}]',
    updated_at = NOW() 
WHERE id = 'ccb60045-f70b-43cd-aacd-1e661deb9045';
DELETE FROM question_skills WHERE question_id = 'cd2f5536-8076-4d9a-9d8a-4d2f54c3a2a6';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('cd2f5536-8076-4d9a-9d8a-4d2f54c3a2a6', 'vector_derivative_velocity', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('cd2f5536-8076-4d9a-9d8a-4d2f54c3a2a6', 'vector_valued_position', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_derivative_velocity', 
    supporting_skill_ids = '{"vector_valued_position"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_derivative_velocity","vector_valued_position"}', 
    error_tags = '{"derivative_power_rule_error","vector_component_swap","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\frac{3}{2t}$"},{"id":"B","value":"$\\frac{3}{t}$"},{"id":"C","value":"$\\frac{2t}{3}$"},{"id":"D","value":"$6t$"}]',
    updated_at = NOW() 
WHERE id = 'cd2f5536-8076-4d9a-9d8a-4d2f54c3a2a6';
DELETE FROM question_skills WHERE question_id = 'd0ef430f-434b-48b8-b7e2-003a4c1a695d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d0ef430f-434b-48b8-b7e2-003a4c1a695d', 'vector_valued_position', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d0ef430f-434b-48b8-b7e2-003a4c1a695d', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d0ef430f-434b-48b8-b7e2-003a4c1a695d', 'polar_to_rectangular_conversion', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_to_rectangular_conversion', 
    supporting_skill_ids = '{"vector_valued_position","bounds_from_context"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_valued_position","bounds_from_context","polar_to_rectangular_conversion"}', 
    error_tags = '{"vector_component_swap","algebra_simplification_error","graph_reading_interval_error"}', 
    options = '[{"id":"A","value":"$\\langle 4, 1 \\rangle$"},{"id":"B","value":"$\\langle 2, 1 \\rangle$"},{"id":"C","value":"$\\langle 4, -1 \\rangle$"},{"id":"D","value":"$\\langle 1, 4 \\rangle$"}]',
    updated_at = NOW() 
WHERE id = 'd0ef430f-434b-48b8-b7e2-003a4c1a695d';
DELETE FROM question_skills WHERE question_id = 'd318fc58-5c23-43b0-9d6d-f277f567c543';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d318fc58-5c23-43b0-9d6d-f277f567c543', 'parametric_arc_length', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d318fc58-5c23-43b0-9d6d-f277f567c543', 'parametric_first_derivatives', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'parametric_arc_length', 
    supporting_skill_ids = '{"parametric_first_derivatives"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","B":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_arc_length","parametric_first_derivatives"}', 
    error_tags = '{"arc_length_missing_squares","arc_length_wrong_bounds","arc_length_simplification_error"}', 
    options = '[{"id":"A","value":"$10$"},{"id":"B","value":"$20$"},{"id":"C","value":"$5$"},{"id":"D","value":"$\\sqrt$5"}]',
    updated_at = NOW() 
WHERE id = 'd318fc58-5c23-43b0-9d6d-f277f567c543';
DELETE FROM question_skills WHERE question_id = 'd874a11a-9cd3-479f-a5d2-b0ccb90c1325';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d874a11a-9cd3-479f-a5d2-b0ccb90c1325', 'vector_velocity_acceleration', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d874a11a-9cd3-479f-a5d2-b0ccb90c1325', 'vector_component_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d874a11a-9cd3-479f-a5d2-b0ccb90c1325', 'vector_valued_motion_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_motion_basics', 
    supporting_skill_ids = '{"vector_velocity_acceleration","vector_component_derivative"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_velocity_acceleration","vector_component_derivative","vector_valued_motion_basics"}', 
    error_tags = '{"vector_derivative_not_componentwise","param_tangent_line_point_mismatch","calculator_mode_or_rounding_issue"}', 
    options = '[{"id":"A","value":"⟨1, 4⟩"},{"id":"B","value":"⟨2, 4⟩"},{"id":"C","value":"⟨1, 2⟩"},{"id":"D","value":"⟨2, 8⟩"}]',
    updated_at = NOW() 
WHERE id = 'd874a11a-9cd3-479f-a5d2-b0ccb90c1325';
DELETE FROM question_skills WHERE question_id = 'd8cda7cb-cb3d-42a6-9c36-db920d4ee677';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d8cda7cb-cb3d-42a6-9c36-db920d4ee677', 'vector_path_interpretation', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d8cda7cb-cb3d-42a6-9c36-db920d4ee677', 'vector_valued_position', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('d8cda7cb-cb3d-42a6-9c36-db920d4ee677', 'polar_to_rectangular_conversion', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_to_rectangular_conversion', 
    supporting_skill_ids = '{"vector_path_interpretation","vector_valued_position"}', 
    target_time_seconds = 150, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_path_interpretation","vector_valued_position","polar_to_rectangular_conversion"}', 
    error_tags = '{"graph_reading_interval_error","vector_component_swap","vector_displacement_endpoint_swap"}', 
    options = '[{"id":"A","value":"The particle moves generally upward (increasing $y$) while $x$ returns to its starting value."},{"id":"B","value":"The particle moves generally rightward (increasing $x$) while $y$ returns to its starting value."},{"id":"C","value":"The particle stays on a horizontal line (constant $y$)."},{"id":"D","value":"The particle moves in a circle centered at the origin."}]',
    updated_at = NOW() 
WHERE id = 'd8cda7cb-cb3d-42a6-9c36-db920d4ee677';
DELETE FROM question_skills WHERE question_id = 'dd3a2c56-664a-458c-9a3e-905e58aad0a4';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('dd3a2c56-664a-458c-9a3e-905e58aad0a4', 'parametric_concavity_analysis', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('dd3a2c56-664a-458c-9a3e-905e58aad0a4', 'parametric_second_derivative', 'primary');
UPDATE questions SET 
    primary_skill_id = 'parametric_second_derivative', 
    supporting_skill_ids = '{"parametric_concavity_analysis"}', 
    target_time_seconds = 150, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","B":"Correct. Apply the parametric chain rule: $dy/dx$ = ($dy/dt$) / ($dx/dt$) or $d^2y/dx^2$ = [d/dt($dy/dx$)] / ($dx/dt$).","C":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas.","D":"Incorrect. Verify your derivatives with respect to $t$ and ensure you are using the correct parametric derivative formulas."}', 
    skill_tags = '{"parametric_concavity_analysis","parametric_second_derivative"}', 
    error_tags = '{"param_concavity_sign_error","param_second_derivative_wrong_formula","param_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"Concave up"},{"id":"B","value":"Concave down"},{"id":"C","value":"Neither; $d^2y/dx^2$=0 at $t=-1$"},{"id":"D","value":"Cannot be determined without a graph"}]',
    updated_at = NOW() 
WHERE id = 'dd3a2c56-664a-458c-9a3e-905e58aad0a4';
DELETE FROM question_skills WHERE question_id = 'e2dbe0c5-c426-455d-bb28-5165d0b7d59b';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e2dbe0c5-c426-455d-bb28-5165d0b7d59b', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('e2dbe0c5-c426-455d-bb28-5165d0b7d59b', 'graph_reading_interval_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"graph_reading_interval_error"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","graph_reading_interval_error"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","parametric_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"$0 \\le \\theta \\le \\frac{\\pi}{3}$"},{"id":"B","value":"$\\frac{\\pi}{3} \\le \\theta \\le \\frac{\\pi}{2}$"},{"id":"C","value":"$0 \\le \\theta \\le \\frac{\\pi}{2}$"},{"id":"D","value":"$\\frac{\\pi}{6} \\le \\theta \\le \\frac{\\pi}{3}$"}]',
    updated_at = NOW() 
WHERE id = 'e2dbe0c5-c426-455d-bb28-5165d0b7d59b';
DELETE FROM question_skills WHERE question_id = 'ea4f2084-2b81-429b-b5e9-d1c69b40b83c';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ea4f2084-2b81-429b-b5e9-d1c69b40b83c', 'bounds_from_context', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ea4f2084-2b81-429b-b5e9-d1c69b40b83c', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ea4f2084-2b81-429b-b5e9-d1c69b40b83c', 'polar_area_single_curve', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_area_single_curve', 
    supporting_skill_ids = '{"bounds_from_context","vector_speed_magnitude"}', 
    target_time_seconds = 210, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"bounds_from_context","vector_speed_magnitude","polar_area_single_curve"}', 
    error_tags = '{"graph_reading_interval_error","algebra_simplification_error","speed_missing_magnitude"}', 
    options = '[{"id":"A","value":"$7.5$"},{"id":"B","value":"$9.5$"},{"id":"C","value":"$7.0$"},{"id":"D","value":"$3.5$"}]',
    updated_at = NOW() 
WHERE id = 'ea4f2084-2b81-429b-b5e9-d1c69b40b83c';
DELETE FROM question_skills WHERE question_id = 'ed4b4584-0d83-4c1d-b439-52edfce9e94f';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ed4b4584-0d83-4c1d-b439-52edfce9e94f', 'bounds_from_context', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ed4b4584-0d83-4c1d-b439-52edfce9e94f', 'algebra_simplification_error', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'bounds_from_context', 
    supporting_skill_ids = '{"algebra_simplification_error"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. This follows the coordinate system rules for parametric, polar, or vector calculus.","B":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","C":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system.","D":"Incorrect. Re-examine the specific derivative or integral setup required for this non-rectangular system."}', 
    skill_tags = '{"bounds_from_context","algebra_simplification_error"}', 
    error_tags = '{"algebra_simplification_error","derivative_power_rule_error","parametric_dydx_missing_divide_by_dxdt"}', 
    options = '[{"id":"A","value":"$\\int_0^2 \\sqrt{(\\frac{dx}{dt})^2 + (\\frac{dy}{dt})^2} \\, dt$"},{"id":"B","value":"$\\int_0^2 (\\frac{dx}{dt} + \\frac{dy}{dt}) \\, dt$"},{"id":"C","value":"$\\int_0^2 \\sqrt{1 + (\\frac{dy}{dt})^2} \\, dt$"},{"id":"D","value":"$\\int_0^2 ((\\frac{dx}{dt})^2 + (\\frac{dy}{dt})^2) \\, dt$"}]',
    updated_at = NOW() 
WHERE id = 'ed4b4584-0d83-4c1d-b439-52edfce9e94f';
DELETE FROM question_skills WHERE question_id = 'ed51ebae-5d9e-4960-b07c-6bfff943307d';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ed51ebae-5d9e-4960-b07c-6bfff943307d', 'vector_speed_magnitude', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ed51ebae-5d9e-4960-b07c-6bfff943307d', 'vector_derivative_velocity', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('ed51ebae-5d9e-4960-b07c-6bfff943307d', 'polar_to_rectangular_conversion', 'primary');
UPDATE questions SET 
    primary_skill_id = 'polar_to_rectangular_conversion', 
    supporting_skill_ids = '{"vector_speed_magnitude","vector_derivative_velocity"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. Use the polar area formula: integral of 1/2 * $r(theta)$^2 $d(theta)$ or conversion $x = r$ co$s(theta)$, $y = r$ si$n(theta)$.","B":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","C":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates.","D":"Incorrect. Check your polar area formula (1/2 * $r^2$) or your conversion between polar and rectangular coordinates."}', 
    skill_tags = '{"vector_speed_magnitude","vector_derivative_velocity","polar_to_rectangular_conversion"}', 
    error_tags = '{"speed_missing_magnitude","algebra_simplification_error","vector_component_swap"}', 
    options = '[{"id":"A","value":"$\\sqrt{73}$"},{"id":"B","value":"$11$"},{"id":"C","value":"$\\sqrt{25}$"},{"id":"D","value":"$\\sqrt{19}$"}]',
    updated_at = NOW() 
WHERE id = 'ed51ebae-5d9e-4960-b07c-6bfff943307d';
DELETE FROM question_skills WHERE question_id = 'f4d01517-39c2-459a-82cb-00808ce9d450';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f4d01517-39c2-459a-82cb-00808ce9d450', 'vector_speed_magnitude', 'primary');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f4d01517-39c2-459a-82cb-00808ce9d450', 'vector_derivative_velocity', 'supporting');
UPDATE questions SET 
    primary_skill_id = 'vector_speed_magnitude', 
    supporting_skill_ids = '{"vector_derivative_velocity"}', 
    target_time_seconds = 180, 
    weight_primary = 0.8, 
    weight_supporting = 0.2, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_speed_magnitude","vector_derivative_velocity"}', 
    error_tags = '{"speed_missing_magnitude","derivative_power_rule_error","algebra_simplification_error"}', 
    options = '[{"id":"A","value":"$\\sqrt{e^{2t}+1}$"},{"id":"B","value":"$e^t+1$"},{"id":"C","value":"$\\sqrt{e^t+1}$"},{"id":"D","value":"$e^{2t}+1$"}]',
    updated_at = NOW() 
WHERE id = 'f4d01517-39c2-459a-82cb-00808ce9d450';
DELETE FROM question_skills WHERE question_id = 'f5bb8ad8-302b-47ad-8ab0-6c6458df9b29';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f5bb8ad8-302b-47ad-8ab0-6c6458df9b29', 'vector_component_derivative', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f5bb8ad8-302b-47ad-8ab0-6c6458df9b29', 'vector_valued_function_concept', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('f5bb8ad8-302b-47ad-8ab0-6c6458df9b29', 'vector_valued_motion_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_motion_basics', 
    supporting_skill_ids = '{"vector_component_derivative","vector_valued_function_concept"}', 
    target_time_seconds = 120, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_component_derivative","vector_valued_function_concept","vector_valued_motion_basics"}', 
    error_tags = '{"vector_derivative_not_componentwise","param_elimination_algebra_error","calculator_mode_or_rounding_issue"}', 
    options = '[{"id":"A","value":"⟨2t, 3, co$s(t)$⟩"},{"id":"B","value":"⟨$t^2$, 3t, si$n(t)$⟩"},{"id":"C","value":"⟨2, 3, co$s(t)$⟩"},{"id":"D","value":"⟨2t, 0, co$s(t)$⟩"}]',
    updated_at = NOW() 
WHERE id = 'f5bb8ad8-302b-47ad-8ab0-6c6458df9b29';
DELETE FROM question_skills WHERE question_id = 'fbf71205-f3fb-4f8e-ad1b-6d874bfc8ee9';
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('fbf71205-f3fb-4f8e-ad1b-6d874bfc8ee9', 'vector_position_from_velocity', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('fbf71205-f3fb-4f8e-ad1b-6d874bfc8ee9', 'vector_integral_componentwise', 'supporting');
INSERT INTO question_skills (question_id, skill_id, role) VALUES ('fbf71205-f3fb-4f8e-ad1b-6d874bfc8ee9', 'vector_valued_motion_basics', 'primary');
UPDATE questions SET 
    primary_skill_id = 'vector_valued_motion_basics', 
    supporting_skill_ids = '{"vector_position_from_velocity","vector_integral_componentwise"}', 
    target_time_seconds = 180, 
    weight_primary = 0.7, 
    weight_supporting = 0.3, 
    prompt_type = 'text', 
    micro_explanations = '{"A":"Correct. For vector-valued functions, differentiate or integrate each component $x(t)$ and $y(t)$ independently.","B":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","C":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors.","D":"Incorrect. Remember to treat horizontal and vertical components separately when applying calculus to vectors."}', 
    skill_tags = '{"vector_position_from_velocity","vector_integral_componentwise","vector_valued_motion_basics"}', 
    error_tags = '{"vector_integral_missing_constant_vector","vector_initial_value_not_applied","calculator_mode_or_rounding_issue"}', 
    options = '[{"id":"A","value":"⟨1+$\\pi$^2, 0⟩"},{"id":"B","value":"⟨$\\pi$^2, 0⟩"},{"id":"C","value":"⟨1+2$\\pi$, 1⟩"},{"id":"D","value":"⟨1+$\\pi$^2, 2⟩"}]',
    updated_at = NOW() 
WHERE id = 'fbf71205-f3fb-4f8e-ad1b-6d874bfc8ee9';
COMMIT;