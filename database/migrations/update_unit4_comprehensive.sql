-- Unit 4 Deep Semantic Audit & Repair
-- Retrospective Update

BEGIN;

-- PHASE 1: Populate Reference Tables (Unit 4)
INSERT INTO skills (id, name, unit) VALUES ('derivative_meaning_context', 'derivative_meaning_context', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('units_analysis', 'units_analysis', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('linearization_interpret_graph', 'linearization_interpret_graph', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('local_linearity_concept', 'local_linearity_concept', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('differential_error_estimate', 'differential_error_estimate', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('lhospital_apply_once', 'lhospital_apply_once', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('lhospital_identify_indeterminate', 'lhospital_identify_indeterminate', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('linearization_interpret_table', 'linearization_interpret_table', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('linearization_numeric_estimate', 'linearization_numeric_estimate', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('average_rate_context', 'average_rate_context', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_units_signs', 'related_rates_units_signs', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('interpret_table_context', 'interpret_table_context', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('average_vs_instant_context', 'average_vs_instant_context', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('method_selection_unit4', 'method_selection_unit4', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('rate_from_table_estimate', 'rate_from_table_estimate', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('interpret_graph_context', 'interpret_graph_context', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_ladder', 'related_rates_ladder', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_solve_strategy', 'related_rates_solve_strategy', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('lhospital_repeat_application', 'lhospital_repeat_application', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_chain_rule', 'related_rates_chain_rule', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_differentiate_time', 'related_rates_differentiate_time', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('acceleration_concept', 'acceleration_concept', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('linearization_build_tangent', 'linearization_build_tangent', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('motion_sign_analysis', 'motion_sign_analysis', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('lhospital_strategy_choice', 'lhospital_strategy_choice', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('lhospital_rewrite_form', 'lhospital_rewrite_form', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('rates_non_motion', 'rates_non_motion', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_geometry_cone', 'related_rates_geometry_cone', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('motion_turning_points', 'motion_turning_points', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_common_mistakes', 'related_rates_common_mistakes', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('position_velocity_acceleration', 'position_velocity_acceleration', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('motion_interpret_graph', 'motion_interpret_graph', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_geometry_sphere', 'related_rates_geometry_sphere', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('rate_change_other_context', 'rate_change_other_context', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('related_rates_identify_variables', 'related_rates_identify_variables', 'Contextual_Diff_Applications') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('units_missing_or_wrong', 'units_missing_or_wrong') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('linearization_far_from_point', 'linearization_far_from_point') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('differential_sign_error', 'differential_sign_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('differentiate_only_numerator', 'differentiate_only_numerator') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('linearization_point_misuse', 'linearization_point_misuse') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('units_mismatch_linearization', 'units_mismatch_linearization') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('average_rate_wrong_interval', 'average_rate_wrong_interval') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('sign_error_rate_direction', 'sign_error_rate_direction') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('table_rate_estimate_wrong', 'table_rate_estimate_wrong') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('use_lhospital_wrong_form', 'use_lhospital_wrong_form') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('avg_vs_instant_confusion_context', 'avg_vs_instant_confusion_context') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('table_slope_estimate_error', 'table_slope_estimate_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('graph_rate_misinterpretation', 'graph_rate_misinterpretation') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('wrong_method_choice_unit4', 'wrong_method_choice_unit4') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('stop_too_early_lhospital', 'stop_too_early_lhospital') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('missing_chain_rule_related_rates', 'missing_chain_rule_related_rates') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('mixing_velocity_acceleration', 'mixing_velocity_acceleration') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('plug_in_before_diff_error', 'plug_in_before_diff_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('acceleration_velocity_confusion', 'acceleration_velocity_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('rewrite_indeterminate_wrong', 'rewrite_indeterminate_wrong') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('unit_conversion_error', 'unit_conversion_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('use_lhospital_when_algebra_easier', 'use_lhospital_when_algebra_easier') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('speed_vs_velocity_confusion', 'speed_vs_velocity_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('differentiate_wrt_wrong_variable', 'differentiate_wrt_wrong_variable') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('missing_geometry_relation', 'missing_geometry_relation') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('velocity_position_confusion', 'velocity_position_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('speeding_up_rule_wrong', 'speeding_up_rule_wrong') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('slope_sign_misread', 'slope_sign_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('units_mismatch_derivative', 'units_mismatch_derivative') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('tangent_slope_wrong_value', 'tangent_slope_wrong_value') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('missing_differentiate_time', 'missing_differentiate_time') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('missing_related_variables', 'missing_related_variables') ON CONFLICT (id) DO NOTHING;

-- PHASE 2: Populate Question Skills Relation
INSERT INTO question_skills (question_id, skill_id) VALUES ('0b5ec5e1-c183-4440-b8e5-892fe530ef59', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0b5ec5e1-c183-4440-b8e5-892fe530ef59', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0e38b63c-dc56-4c17-b47b-b315f12ab916', 'linearization_interpret_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0e38b63c-dc56-4c17-b47b-b315f12ab916', 'local_linearity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('15648368-5038-4fcf-ad02-e2258e887161', 'differential_error_estimate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('15648368-5038-4fcf-ad02-e2258e887161', 'local_linearity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('165c0b5a-2cc7-4b38-82a6-ae753a9573f1', 'lhospital_apply_once') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('165c0b5a-2cc7-4b38-82a6-ae753a9573f1', 'lhospital_identify_indeterminate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('174cd8fa-3380-42a3-a78d-fce4079ce5b9', 'local_linearity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('174cd8fa-3380-42a3-a78d-fce4079ce5b9', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('19215925-6ac3-4652-9eb7-cb0642c2ccbb', 'linearization_interpret_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('19215925-6ac3-4652-9eb7-cb0642c2ccbb', 'linearization_numeric_estimate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1952a965-80b2-49a9-a0b1-18270911be16', 'average_rate_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1952a965-80b2-49a9-a0b1-18270911be16', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('219e4573-8a97-4652-b052-fa0040bf6b7b', 'related_rates_units_signs') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('219e4573-8a97-4652-b052-fa0040bf6b7b', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('27e1b417-3cbf-453b-b67d-d674a2651572', 'interpret_table_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('27e1b417-3cbf-453b-b67d-d674a2651572', 'average_vs_instant_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('304b711c-69e9-4052-adb3-8f09af6d01c2', 'lhospital_identify_indeterminate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('304b711c-69e9-4052-adb3-8f09af6d01c2', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('33834e0b-ccaa-4ed4-aa1a-214f4b38864b', 'average_vs_instant_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('33834e0b-ccaa-4ed4-aa1a-214f4b38864b', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('35d4bd67-50cb-407c-a77a-8ec853aed927', 'rate_from_table_estimate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('35d4bd67-50cb-407c-a77a-8ec853aed927', 'average_rate_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('37b207d5-829d-4863-bcca-611285028ba3', 'interpret_graph_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('37b207d5-829d-4863-bcca-611285028ba3', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3b29f4ec-ca55-439b-b075-6a54545873ae', 'related_rates_ladder') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3b29f4ec-ca55-439b-b075-6a54545873ae', 'related_rates_units_signs') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3dfb37b2-bd9d-49a2-92b3-88e1eb012b0f', 'interpret_graph_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3dfb37b2-bd9d-49a2-92b3-88e1eb012b0f', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5913ba03-f895-428e-8bb6-d6c9dc9995f7', 'related_rates_solve_strategy') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5913ba03-f895-428e-8bb6-d6c9dc9995f7', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5dabb2e1-5bd2-40f8-9485-d5b6c46fea30', 'lhospital_repeat_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5dabb2e1-5bd2-40f8-9485-d5b6c46fea30', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('64b6c4bb-1d86-41fe-a563-f8cb13bc617a', 'differential_error_estimate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('64b6c4bb-1d86-41fe-a563-f8cb13bc617a', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('65e7f3b7-9dac-42e5-bafa-f2beac943bac', 'related_rates_chain_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('65e7f3b7-9dac-42e5-bafa-f2beac943bac', 'related_rates_differentiate_time') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('66325853-9fdb-4d14-950a-a5f88a160fc2', 'acceleration_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('66325853-9fdb-4d14-950a-a5f88a160fc2', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('672114f3-4c91-40ff-97fe-ff2929909282', 'linearization_numeric_estimate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('672114f3-4c91-40ff-97fe-ff2929909282', 'local_linearity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('68155b09-054b-4b23-a58c-10c2556aa329', 'linearization_build_tangent') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('68155b09-054b-4b23-a58c-10c2556aa329', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6a4560b7-0b79-42f6-9172-fa3c82561e8d', 'related_rates_solve_strategy') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6a4560b7-0b79-42f6-9172-fa3c82561e8d', 'related_rates_differentiate_time') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6c619343-3297-49f3-ae60-2e872bbbf542', 'motion_sign_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6c619343-3297-49f3-ae60-2e872bbbf542', 'interpret_graph_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d0ae77d-f1ad-4445-b420-6d5b88b87f8e', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d0ae77d-f1ad-4445-b420-6d5b88b87f8e', 'lhospital_strategy_choice') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('71100bea-cb03-4644-a5a6-2eaa984aa501', 'interpret_table_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('71100bea-cb03-4644-a5a6-2eaa984aa501', 'average_vs_instant_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('75e5fa48-b47f-4bf4-b2ab-65a3dfd8e00f', 'lhospital_rewrite_form') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('75e5fa48-b47f-4bf4-b2ab-65a3dfd8e00f', 'lhospital_identify_indeterminate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('76612946-d553-43b6-9814-4f1effddd06d', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('76612946-d553-43b6-9814-4f1effddd06d', 'rates_non_motion') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('799a24f2-d9e9-4ec7-84b6-e9d0bba1beed', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('799a24f2-d9e9-4ec7-84b6-e9d0bba1beed', 'rates_non_motion') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('84e8c37e-3c65-4769-9f2e-5f0cbf0fdc49', 'rates_non_motion') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('84e8c37e-3c65-4769-9f2e-5f0cbf0fdc49', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('866720da-cafa-4f06-a648-aee393ee7f3e', 'lhospital_repeat_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('866720da-cafa-4f06-a648-aee393ee7f3e', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('894a84ba-27bf-4d8c-acd0-78f35015bc1e', 'lhospital_apply_once') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('894a84ba-27bf-4d8c-acd0-78f35015bc1e', 'lhospital_identify_indeterminate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8a5a8c88-80f4-400b-90f4-87883453669a', 'related_rates_geometry_cone') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8a5a8c88-80f4-400b-90f4-87883453669a', 'related_rates_units_signs') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8b0a2216-2fb3-4cba-9c01-a9f502ca1b61', 'lhospital_strategy_choice') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8b0a2216-2fb3-4cba-9c01-a9f502ca1b61', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9f00e0af-6a55-43bc-9ebc-3789d248d1bb', 'related_rates_chain_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9f00e0af-6a55-43bc-9ebc-3789d248d1bb', 'related_rates_differentiate_time') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ab64c787-e399-48d4-bfee-fbd4d89a334c', 'motion_turning_points') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ab64c787-e399-48d4-bfee-fbd4d89a334c', 'interpret_graph_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('abaf3722-b983-4100-9912-80b38d064984', 'related_rates_common_mistakes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('abaf3722-b983-4100-9912-80b38d064984', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('afcd22f1-edc2-4d3e-86db-ca417bf118b6', 'related_rates_differentiate_time') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('afcd22f1-edc2-4d3e-86db-ca417bf118b6', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b1d50a83-ca4c-4198-a784-fb80940e42e6', 'related_rates_geometry_cone') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b1d50a83-ca4c-4198-a784-fb80940e42e6', 'related_rates_differentiate_time') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('bf21d218-2889-4069-adc3-0b23c487ad55', 'position_velocity_acceleration') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('bf21d218-2889-4069-adc3-0b23c487ad55', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c47718c9-0fce-43d6-b659-10083653ae99', 'motion_sign_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c47718c9-0fce-43d6-b659-10083653ae99', 'position_velocity_acceleration') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c51dff4b-9a2e-4a4a-9eb1-c4d47bbb6534', 'lhospital_rewrite_form') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c51dff4b-9a2e-4a4a-9eb1-c4d47bbb6534', 'lhospital_identify_indeterminate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c5246fab-da2c-4f2b-a719-b7831b4d40aa', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c5246fab-da2c-4f2b-a719-b7831b4d40aa', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c59e6b78-2259-4480-ab21-1078ebe83e12', 'motion_interpret_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c59e6b78-2259-4480-ab21-1078ebe83e12', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c6901684-f363-49ff-acc3-41c1f0d64737', 'derivative_meaning_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c6901684-f363-49ff-acc3-41c1f0d64737', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cd269e62-6001-427b-81c6-eb91e87e5516', 'linearization_build_tangent') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cd269e62-6001-427b-81c6-eb91e87e5516', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d10d386b-09ab-4640-a890-a8d539079078', 'related_rates_geometry_sphere') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d10d386b-09ab-4640-a890-a8d539079078', 'related_rates_differentiate_time') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d316a9a3-6487-497d-a3b7-84cf86731c9c', 'related_rates_units_signs') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d316a9a3-6487-497d-a3b7-84cf86731c9c', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e5e544b7-f580-4ba8-9c91-99a252ab4ecc', 'lhospital_identify_indeterminate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e5e544b7-f580-4ba8-9c91-99a252ab4ecc', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e60d81e0-4425-4572-9928-c7dcfe2002d3', 'local_linearity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e60d81e0-4425-4572-9928-c7dcfe2002d3', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e83ef46c-4fe7-4bbc-b867-0719e990a87d', 'rate_change_other_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e83ef46c-4fe7-4bbc-b867-0719e990a87d', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e87db5fb-fd83-4ca6-b12e-c2a8d02b4f23', 'interpret_table_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e87db5fb-fd83-4ca6-b12e-c2a8d02b4f23', 'average_vs_instant_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ec9c3034-0e0b-4c16-92c8-2825d2fd9553', 'related_rates_identify_variables') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ec9c3034-0e0b-4c16-92c8-2825d2fd9553', 'units_analysis') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fcacc153-0283-435f-b0fe-e955d1d665db', 'related_rates_identify_variables') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fcacc153-0283-435f-b0fe-e955d1d665db', 'method_selection_unit4') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fd1cfd71-973b-46ed-8be3-8fec56c4d3a7', 'lhospital_strategy_choice') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fd1cfd71-973b-46ed-8be3-8fec56c4d3a7', 'method_selection_unit4') ON CONFLICT DO NOTHING;

-- PHASE 3: Update Questions Table (Semantic Version)
UPDATE questions SET
    target_time_seconds = 105,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","B":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"derivative_meaning_context","units_analysis"}', 
    error_tags = '{"units_missing_or_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '0b5ec5e1-c183-4440-b8e5-892fe530ef59';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Graph included: ln(x) and tangent at x=4.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","B":"Correct. Linearization uses the tangent line equation L(x) = f(a) + f''(a)(x-a) to approximate function values near the point of tangency.","C":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","D":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity."}',
    skill_tags = '{"linearization_interpret_graph","local_linearity_concept"}', 
    error_tags = '{"linearization_far_from_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '0e38b63c-dc56-4c17-b47b-b315f12ab916';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","C":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"differential_error_estimate","local_linearity_concept"}', 
    error_tags = '{"differential_sign_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '15648368-5038-4fcf-ad02-e2258e887161';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_apply_once","lhospital_identify_indeterminate"}', 
    error_tags = '{"differentiate_only_numerator"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '165c0b5a-2cc7-4b38-82a6-ae753a9573f1';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"local_linearity_concept","derivative_meaning_context"}', 
    error_tags = '{"linearization_point_misuse"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '174cd8fa-3380-42a3-a78d-fce4079ce5b9';
UPDATE questions SET
    target_time_seconds = 155,
    notes = 'Table included: true vs linear approx near x=9.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","B":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","C":"Correct. Linearization uses the tangent line equation L(x) = f(a) + f''(a)(x-a) to approximate function values near the point of tangency.","D":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity."}',
    skill_tags = '{"linearization_interpret_table","linearization_numeric_estimate"}', 
    error_tags = '{"units_mismatch_linearization"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '19215925-6ac3-4652-9eb7-cb0642c2ccbb';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"average_rate_context","units_analysis"}', 
    error_tags = '{"average_rate_wrong_interval"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '1952a965-80b2-49a9-a0b1-18270911be16';
UPDATE questions SET
    target_time_seconds = 160,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_units_signs","units_analysis"}', 
    error_tags = '{"sign_error_rate_direction"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '219e4573-8a97-4652-b052-fa0040bf6b7b';
UPDATE questions SET
    target_time_seconds = 155,
    notes = 'Table required: V(t) at t=0,2,4,6,8.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","B":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"interpret_table_context","average_vs_instant_context"}', 
    error_tags = '{"table_rate_estimate_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '27e1b417-3cbf-453b-b67d-d674a2651572';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_identify_indeterminate","method_selection_unit4"}', 
    error_tags = '{"use_lhospital_wrong_form"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '304b711c-69e9-4052-adb3-8f09af6d01c2';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"average_vs_instant_context","derivative_meaning_context"}', 
    error_tags = '{"avg_vs_instant_confusion_context"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '33834e0b-ccaa-4ed4-aa1a-214f4b38864b';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Table included: temperature vs time.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"rate_from_table_estimate","average_rate_context"}', 
    error_tags = '{"table_slope_estimate_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '35d4bd67-50cb-407c-a77a-8ec853aed927';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Graph required: R(t) vs t with tangent at t=3.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","B":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"interpret_graph_context","derivative_meaning_context"}', 
    error_tags = '{"graph_rate_misinterpretation"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '37b207d5-829d-4863-bcca-611285028ba3';
UPDATE questions SET
    target_time_seconds = 180,
    notes = 'Diagram required: ladder against wall with x and y labeled.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_ladder","related_rates_units_signs"}', 
    error_tags = '{"sign_error_rate_direction"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3b29f4ec-ca55-439b-b075-6a54545873ae';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Graph required: Temperature vs time with tangent at t=4.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","B":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"interpret_graph_context","derivative_meaning_context"}', 
    error_tags = '{"graph_rate_misinterpretation"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3dfb37b2-bd9d-49a2-92b3-88e1eb012b0f';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_solve_strategy","method_selection_unit4"}', 
    error_tags = '{"wrong_method_choice_unit4"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5913ba03-f895-428e-8bb6-d6c9dc9995f7';
UPDATE questions SET
    target_time_seconds = 160,
    notes = 'Harder L''Hospital limit; multiple applications needed.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","B":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_repeat_application","method_selection_unit4"}', 
    error_tags = '{"stop_too_early_lhospital"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5dabb2e1-5bd2-40f8-9485-d5b6c46fea30';
UPDATE questions SET
    target_time_seconds = 160,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule."}',
    skill_tags = '{"differential_error_estimate","units_analysis"}', 
    error_tags = '{"differential_sign_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '64b6c4bb-1d86-41fe-a563-f8cb13bc617a';
UPDATE questions SET
    target_time_seconds = 130,
    notes = NULL,
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","B":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_chain_rule","related_rates_differentiate_time"}', 
    error_tags = '{"missing_chain_rule_related_rates"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '65e7f3b7-9dac-42e5-bafa-f2beac943bac';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"acceleration_concept","derivative_meaning_context"}', 
    error_tags = '{"mixing_velocity_acceleration"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '66325853-9fdb-4d14-950a-a5f88a160fc2';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Graph included: curve and tangent line near x=8.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Linearization uses the tangent line equation L(x) = f(a) + f''(a)(x-a) to approximate function values near the point of tangency.","B":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","C":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","D":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity."}',
    skill_tags = '{"linearization_numeric_estimate","local_linearity_concept"}', 
    error_tags = '{"linearization_far_from_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '672114f3-4c91-40ff-97fe-ff2929909282';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Linearization uses the tangent line equation L(x) = f(a) + f''(a)(x-a) to approximate function values near the point of tangency.","B":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","C":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","D":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity."}',
    skill_tags = '{"linearization_build_tangent","derivative_meaning_context"}', 
    error_tags = '{"linearization_point_misuse"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '68155b09-054b-4b23-a58c-10c2556aa329';
UPDATE questions SET
    target_time_seconds = 160,
    notes = NULL,
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_solve_strategy","related_rates_differentiate_time"}', 
    error_tags = '{"plug_in_before_diff_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6a4560b7-0b79-42f6-9172-fa3c82561e8d';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Graph required: a(t) vs t with clear positive peak near t=0.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Velocity is the derivative of position, and acceleration is the derivative of velocity. Whether an object speeds up or slows down depends on whether velocity and acceleration have the same sign.","B":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","C":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","D":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion."}',
    skill_tags = '{"motion_sign_analysis","interpret_graph_context"}', 
    error_tags = '{"acceleration_velocity_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6c619343-3297-49f3-ae60-2e872bbbf542';
UPDATE questions SET
    target_time_seconds = 180,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"method_selection_unit4","lhospital_strategy_choice"}', 
    error_tags = '{"wrong_method_choice_unit4"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6d0ae77d-f1ad-4445-b420-6d5b88b87f8e';
UPDATE questions SET
    target_time_seconds = 180,
    notes = 'Table required: A(t) at 5,5.5,6,6.5,7.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","B":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"interpret_table_context","average_vs_instant_context"}', 
    error_tags = '{"table_rate_estimate_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '71100bea-cb03-4644-a5a6-2eaa984aa501';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Both A and C lead to 0/0; C is better for L’Hospital emphasis.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","C":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_rewrite_form","lhospital_identify_indeterminate"}', 
    error_tags = '{"rewrite_indeterminate_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '75e5fa48-b47f-4bf4-b2ab-65a3dfd8e00f';
UPDATE questions SET
    target_time_seconds = 155,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"units_analysis","rates_non_motion"}', 
    error_tags = '{"units_missing_or_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '76612946-d553-43b6-9814-4f1effddd06d';
UPDATE questions SET
    target_time_seconds = 180,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","B":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"method_selection_unit4","rates_non_motion"}', 
    error_tags = '{"wrong_method_choice_unit4"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '799a24f2-d9e9-4ec7-84b6-e9d0bba1beed';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","B":"Correct. Velocity is the derivative of position, and acceleration is the derivative of velocity. Whether an object speeds up or slows down depends on whether velocity and acceleration have the same sign.","C":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","D":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion."}',
    skill_tags = '{"rates_non_motion","derivative_meaning_context"}', 
    error_tags = '{"avg_vs_instant_confusion_context"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '84e8c37e-3c65-4769-9f2e-5f0cbf0fdc49';
UPDATE questions SET
    target_time_seconds = 160,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_repeat_application","method_selection_unit4"}', 
    error_tags = '{"stop_too_early_lhospital"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '866720da-cafa-4f06-a648-aee393ee7f3e';
UPDATE questions SET
    target_time_seconds = 160,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_apply_once","lhospital_identify_indeterminate"}', 
    error_tags = '{"differentiate_only_numerator"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '894a84ba-27bf-4d8c-acd0-78f35015bc1e';
UPDATE questions SET
    target_time_seconds = 180,
    notes = 'This problem uses similarity and cone volume rates.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_geometry_cone","related_rates_units_signs"}', 
    error_tags = '{"unit_conversion_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8a5a8c88-80f4-400b-90f4-87883453669a';
UPDATE questions SET
    target_time_seconds = 180,
    notes = 'Graph included: compares numerator and denominator shapes near 0.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_strategy_choice","method_selection_unit4"}', 
    error_tags = '{"use_lhospital_when_algebra_easier"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8b0a2216-2fb3-4cba-9c01-a9f502ca1b61';
UPDATE questions SET
    target_time_seconds = 180,
    notes = NULL,
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","B":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_chain_rule","related_rates_differentiate_time"}', 
    error_tags = '{"missing_chain_rule_related_rates"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '9f00e0af-6a55-43bc-9ebc-3789d248d1bb';
UPDATE questions SET
    target_time_seconds = 155,
    notes = 'Graph required: v(t) vs t, showing v(t) becomes negative after t=7.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","B":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","C":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","D":"Correct. Velocity is the derivative of position, and acceleration is the derivative of velocity. Whether an object speeds up or slows down depends on whether velocity and acceleration have the same sign."}',
    skill_tags = '{"motion_turning_points","interpret_graph_context"}', 
    error_tags = '{"speed_vs_velocity_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ab64c787-e399-48d4-bfee-fbd4d89a334c';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","C":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_common_mistakes","method_selection_unit4"}', 
    error_tags = '{"plug_in_before_diff_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'abaf3722-b983-4100-9912-80b38d064984';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_differentiate_time","derivative_meaning_context"}', 
    error_tags = '{"differentiate_wrt_wrong_variable"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'afcd22f1-edc2-4d3e-86db-ca417bf118b6';
UPDATE questions SET
    target_time_seconds = 155,
    notes = 'Diagram required: cone cross-section with r and h labeled.',
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_geometry_cone","related_rates_differentiate_time"}', 
    error_tags = '{"missing_geometry_relation"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b1d50a83-ca4c-4198-a784-fb80940e42e6';
UPDATE questions SET
    target_time_seconds = 130,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","B":"Correct. Velocity is the derivative of position, and acceleration is the derivative of velocity. Whether an object speeds up or slows down depends on whether velocity and acceleration have the same sign.","C":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","D":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion."}',
    skill_tags = '{"position_velocity_acceleration","units_analysis"}', 
    error_tags = '{"velocity_position_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'bf21d218-2889-4069-adc3-0b23c487ad55';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","B":"Correct. Velocity is the derivative of position, and acceleration is the derivative of velocity. Whether an object speeds up or slows down depends on whether velocity and acceleration have the same sign.","C":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","D":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion."}',
    skill_tags = '{"motion_sign_analysis","position_velocity_acceleration"}', 
    error_tags = '{"speeding_up_rule_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c47718c9-0fce-43d6-b659-10083653ae99';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_rewrite_form","lhospital_identify_indeterminate"}', 
    error_tags = '{"rewrite_indeterminate_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c51dff4b-9a2e-4a4a-9eb1-c4d47bbb6534';
UPDATE questions SET
    target_time_seconds = 130,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","B":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"derivative_meaning_context","units_analysis"}', 
    error_tags = '{"unit_conversion_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c5246fab-da2c-4f2b-a719-b7831b4d40aa';
UPDATE questions SET
    target_time_seconds = 135,
    notes = 'Graph included: position vs time.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","B":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion.","C":"Correct. Velocity is the derivative of position, and acceleration is the derivative of velocity. Whether an object speeds up or slows down depends on whether velocity and acceleration have the same sign.","D":"Incorrect. Please distinguish between velocity and speed, and understand how they interact with acceleration to determine the state of motion."}',
    skill_tags = '{"motion_interpret_graph","derivative_meaning_context"}', 
    error_tags = '{"slope_sign_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c59e6b78-2259-4480-ab21-1078ebe83e12';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","B":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change."}',
    skill_tags = '{"derivative_meaning_context","units_analysis"}', 
    error_tags = '{"units_mismatch_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c6901684-f363-49ff-acc3-41c1f0d64737';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Linearization uses the tangent line equation L(x) = f(a) + f''(a)(x-a) to approximate function values near the point of tangency.","B":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","C":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity.","D":"Incorrect. The accuracy of a linear approximation depends on the distance from the point of tangency; whether it is an over- or under-estimate depends on the function''s concavity."}',
    skill_tags = '{"linearization_build_tangent","method_selection_unit4"}', 
    error_tags = '{"tangent_slope_wrong_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'cd269e62-6001-427b-81c6-eb91e87e5516';
UPDATE questions SET
    target_time_seconds = 130,
    notes = NULL,
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","C":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_geometry_sphere","related_rates_differentiate_time"}', 
    error_tags = '{"missing_differentiate_time"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd10d386b-09ab-4640-a890-a8d539079078';
UPDATE questions SET
    target_time_seconds = 180,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_units_signs","units_analysis"}', 
    error_tags = '{"sign_error_rate_direction"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd316a9a3-6487-497d-a3b7-84cf86731c9c';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","C":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_identify_indeterminate","method_selection_unit4"}', 
    error_tags = '{"use_lhospital_wrong_form"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e5e544b7-f580-4ba8-9c91-99a252ab4ecc';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","B":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"local_linearity_concept","method_selection_unit4"}', 
    error_tags = '{"linearization_far_from_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e60d81e0-4425-4572-9928-c7dcfe2002d3';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","B":"Correct. This option aligns with the mathematical applications of related rates, motion models, or L''Hospital''s Rule.","C":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning.","D":"Incorrect. This option contains an error in modeling, differentiating rates, or interpreting physical meaning."}',
    skill_tags = '{"rate_change_other_context","units_analysis"}', 
    error_tags = '{"units_mismatch_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e83ef46c-4fe7-4bbc-b867-0719e990a87d';
UPDATE questions SET
    target_time_seconds = 180,
    notes = 'Table required: s(t) around t=3.0 with small time steps.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","B":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","C":"Incorrect. Remember that the derivative''s units are typically ''(units of dependent variable) / (units of independent variable)''. This option misinterprets the rate of change.","D":"Correct. In context, the derivative represents the instantaneous rate of change (e.g., change in a physical quantity per unit of time). This option accurately interprets that meaning."}',
    skill_tags = '{"interpret_table_context","average_vs_instant_context"}', 
    error_tags = '{"table_rate_estimate_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e87db5fb-fd83-4ca6-b12e-c2a8d02b4f23';
UPDATE questions SET
    target_time_seconds = 110,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","B":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_identify_variables","units_analysis"}', 
    error_tags = '{"missing_related_variables"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ec9c3034-0e0b-4c16-92c8-2825d2fd9553';
UPDATE questions SET
    target_time_seconds = 135,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","B":"Correct. In related rates problems, you must establish a geometric or algebraic model, differentiate with respect to time t (using implicit differentiation), and substitute instantaneous values to solve.","C":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time.","D":"Incorrect. To solve related rates, ensure you''ve established a correct equation relating the variables and applied the Chain Rule correctly when differentiating with respect to time."}',
    skill_tags = '{"related_rates_identify_variables","method_selection_unit4"}', 
    error_tags = '{"missing_related_variables"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'fcacc153-0283-435f-b0fe-e955d1d665db';
UPDATE questions SET
    target_time_seconds = 180,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","B":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity.","C":"Correct. When a limit presents a 0/0 or infinity/infinity indeterminate form, L''Hospital''s Rule allows you to differentiate the numerator and denominator separately and attempt the limit again.","D":"Incorrect. L''Hospital''s Rule can only be applied if the limit is confirmed to be one of the specific indeterminate forms like 0/0 or infinity/infinity."}',
    skill_tags = '{"lhospital_strategy_choice","method_selection_unit4"}', 
    error_tags = '{"use_lhospital_when_algebra_easier"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'fd1cfd71-973b-46ed-8be3-8fec56c4d3a7';

COMMIT;
