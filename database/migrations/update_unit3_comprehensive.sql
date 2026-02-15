-- Unit 3 Deep Semantic Audit & Repair
-- Retrospective Update

BEGIN;
-- PHASE 1: Populate Reference Tables (Unit 3)
INSERT INTO skills (id, name, unit) VALUES ('method_selection_unit3', 'method_selection_unit3', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('inverse_trig_derivatives', 'inverse_trig_derivatives', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('higher_order_derivatives', 'higher_order_derivatives', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('inverse_function_derivative', 'inverse_function_derivative', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('inverse_from_table_graph', 'inverse_from_table_graph', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('inverse_trig_chain', 'inverse_trig_chain', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('chain_rule_basic', 'chain_rule_basic', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('implicit_diff_basic', 'implicit_diff_basic', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('chain_rule_with_trig_exp_log', 'chain_rule_with_trig_exp_log', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('chain_rule_multi_layer', 'chain_rule_multi_layer', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('implicit_diff_product_quotient', 'implicit_diff_product_quotient', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('implicit_diff_at_point', 'implicit_diff_at_point', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('higher_order_meaning', 'higher_order_meaning', 'Composite_Implicit_Inverse') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inverse_derivative_wrong_input', 'inverse_derivative_wrong_input') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inverse_trig_wrong_formula', 'inverse_trig_wrong_formula') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('higher_order_compute_error', 'higher_order_compute_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inverse_trig_missing_chain', 'inverse_trig_missing_chain') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inverse_table_lookup_error', 'inverse_table_lookup_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('chain_rule_missing_inner', 'chain_rule_missing_inner') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('method_choice_wrong_unit3', 'method_choice_wrong_unit3') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_diff_forget_dydx', 'implicit_diff_forget_dydx') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('higher_order_derivative_misread', 'higher_order_derivative_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('chain_rule_wrong_layers', 'chain_rule_wrong_layers') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_diff_wrong_product_rule', 'implicit_diff_wrong_product_rule') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inverse_trig_sign_domain_confusion', 'inverse_trig_sign_domain_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_diff_point_sub_error', 'implicit_diff_point_sub_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('chain_rule_algebra_slip', 'chain_rule_algebra_slip') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('inverse_derivative_reciprocal_confusion', 'inverse_derivative_reciprocal_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('implicit_diff_not_isolated', 'implicit_diff_not_isolated') ON CONFLICT (id) DO NOTHING;

-- PHASE 2: Populate Question Skills Relation
INSERT INTO question_skills (question_id, skill_id) VALUES ('064151a0-0ebb-4a10-8b79-d93609c59ee9', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('12429fb2-5293-418d-87bf-140f7b17f6f2', 'inverse_trig_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('217431e2-b0ca-42cc-b9c9-2278d5b3825d', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('237cf050-c6e9-417f-82f2-f087c0e64031', 'inverse_function_derivative') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('2c8a01b6-04cf-4640-8859-1e7693ddff10', 'inverse_from_table_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('32dad1dc-44f2-4d16-8891-658a35c6949a', 'inverse_trig_chain') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('43f54028-932d-4324-93bd-bc7b66d4aa60', 'inverse_from_table_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('45c7fa2f-01e9-40fa-9952-9e5174deb197', 'chain_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('48ff88e2-4be0-406e-b3dc-9e143a76b037', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4ac07956-9445-4ba7-8503-887545eccf85', 'chain_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4ae5ad52-fd2a-45fb-8299-9c496d49fbad', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('59ef59bc-c73f-499e-9eb5-4572d8ac5352', 'implicit_diff_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5ba089cb-f6b9-427f-8b66-dec62446e2f6', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('68e20850-4913-4f14-b767-b7bafe0f078e', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('693e3865-f241-4f57-8dd8-3b4c1c3ba5f6', 'chain_rule_with_trig_exp_log') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7852b305-5521-476c-8f83-a3e330ac8e50', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7b2a990b-362a-4e30-945a-62143fb5feec', 'chain_rule_multi_layer') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('813fb837-2d2c-496e-a3d0-9d2aabd140cc', 'implicit_diff_product_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8823710e-ebdc-4df6-ad52-29c428493194', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('897e129e-4492-4730-a82f-cb9ce2fc9288', 'inverse_trig_chain') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('91021dbf-3f38-431a-a003-f82eb3d54442', 'inverse_trig_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9341e84d-13ef-4339-b540-3be3de4ae6b2', 'implicit_diff_product_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9948ca83-d7e5-436a-9732-7a0459aa8485', 'implicit_diff_at_point') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a1929b91-9cb1-490f-92b9-6f814c232c49', 'chain_rule_with_trig_exp_log') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a2a450ef-9de9-405b-a9ce-0fd06a62c7ec', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a4321137-6af8-407b-a198-c4e51643b63b', 'inverse_trig_chain') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('aa958cac-bb36-4906-81e0-f962563d7266', 'inverse_trig_chain') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ab0a99e4-7fa2-4633-b6ba-7846588fef95', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('aba62706-c5e8-4b65-889d-567b46443a58', 'inverse_function_derivative') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b06e5bba-2b83-4c37-97ca-9532b76345b1', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b24bb9d4-e702-48df-bc3d-9273302d1302', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b512ef70-c34c-44bc-a74b-636a5e48f66e', 'inverse_trig_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b916692b-b088-4d8b-a58e-435aef8e94d4', 'chain_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c10ecac2-d45e-4889-a2e4-138c7ee3c760', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c207f06e-4de5-4ce8-a445-976ef78ae13d', 'inverse_trig_chain') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c5013f1b-d22c-40ac-9b2a-04cce9be4846', 'chain_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c7fc9c97-240f-40df-a0cb-a7188349c5cc', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c8512468-74c6-4d5b-861c-72f6ed11cb61', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ce013efd-dec8-49e0-8794-80deb344430a', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d284a0ec-a98f-4349-aec0-2e4f0d394005', 'higher_order_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d59b784d-995b-4b67-8fc4-ae8cab832f9d', 'inverse_function_derivative') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d90169b7-1b2d-4b99-b142-5fbf168c4e47', 'inverse_function_derivative') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d938642b-9344-4467-ab9b-72853a0f6845', 'higher_order_meaning') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ddd27b7b-19ad-4540-8b4e-644ed93bd859', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e225840b-7f71-4a71-a1a3-c2951f79fc3f', 'inverse_trig_chain') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e5dba277-8737-4ae1-b68b-65ba01e5fb08', 'higher_order_meaning') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e83c7313-4921-4d24-bfd9-5cb3c28fc38b', 'inverse_function_derivative') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('eb432132-45c2-4c67-a8dc-b16e3e885d16', 'implicit_diff_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ec11e644-7d02-40b2-8533-878258709ccb', 'method_selection_unit3') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ed7dddc1-2ffc-4a21-a080-f07f60e14e3f', 'implicit_diff_basic') ON CONFLICT DO NOTHING;

-- PHASE 3: Update Questions Table (Semantic Version)
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"inverse_derivative_wrong_input"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '064151a0-0ebb-4a10-8b79-d93609c59ee9';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_derivatives"}', 
    error_tags = '{"inverse_trig_wrong_formula"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '12429fb2-5293-418d-87bf-140f7b17f6f2';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_compute_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '217431e2-b0ca-42cc-b9c9-2278d5b3825d';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","B":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","C":"Correct. The derivative of an inverse function is g''(x) = 1 / f''(g(x)). This option correctly applies that reciprocal relationship.","D":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign."}',
    skill_tags = '{"inverse_function_derivative"}', 
    error_tags = '{"inverse_derivative_wrong_input"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '237cf050-c6e9-417f-82f2-f087c0e64031';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Uses a provided graph image with tangent line.',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_from_table_graph"}', 
    error_tags = '{"inverse_derivative_wrong_input"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '2c8a01b6-04cf-4640-8859-1e7693ddff10';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_chain"}', 
    error_tags = '{"inverse_trig_missing_chain"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '32dad1dc-44f2-4d16-8891-658a35c6949a';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Uses a provided table image.',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_from_table_graph"}', 
    error_tags = '{"inverse_table_lookup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '43f54028-932d-4324-93bd-bc7b66d4aa60';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","B":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","C":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_basic"}', 
    error_tags = '{"chain_rule_missing_inner"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '45c7fa2f-01e9-40fa-9952-9e5174deb197';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '48ff88e2-4be0-406e-b3dc-9e143a76b037';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","B":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","C":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_basic"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4ac07956-9445-4ba7-8503-887545eccf85';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"inverse_derivative_wrong_input"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4ae5ad52-fd2a-45fb-8299-9c496d49fbad';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","B":"Correct. Implicit differentiation requires attaching a dy/dx term whenever you differentiate a term containing y, then solving algebraically.","C":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","D":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance."}',
    skill_tags = '{"implicit_diff_basic"}', 
    error_tags = '{"implicit_diff_forget_dydx"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '59ef59bc-c73f-499e-9eb5-4572d8ac5352';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5ba089cb-f6b9-427f-8b66-dec62446e2f6';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_derivative_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '68e20850-4913-4f14-b767-b7bafe0f078e';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","B":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","C":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_with_trig_exp_log"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '693e3865-f241-4f57-8dd8-3b4c1c3ba5f6';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '7852b305-5521-476c-8f83-a3e330ac8e50';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","B":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","C":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_multi_layer"}', 
    error_tags = '{"chain_rule_wrong_layers"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '7b2a990b-362a-4e30-945a-62143fb5feec';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Implicit differentiation requires attaching a dy/dx term whenever you differentiate a term containing y, then solving algebraically.","B":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","C":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","D":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance."}',
    skill_tags = '{"implicit_diff_product_quotient"}', 
    error_tags = '{"implicit_diff_wrong_product_rule"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '813fb837-2d2c-496e-a3d0-9d2aabd140cc';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_compute_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8823710e-ebdc-4df6-ad52-29c428493194';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_chain"}', 
    error_tags = '{"inverse_trig_sign_domain_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '897e129e-4492-4730-a82f-cb9ce2fc9288';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_derivatives"}', 
    error_tags = '{"inverse_trig_wrong_formula"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '91021dbf-3f38-431a-a003-f82eb3d54442';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","B":"Correct. Implicit differentiation requires attaching a dy/dx term whenever you differentiate a term containing y, then solving algebraically.","C":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","D":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance."}',
    skill_tags = '{"implicit_diff_product_quotient"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '9341e84d-13ef-4339-b540-3be3de4ae6b2';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Implicit differentiation requires attaching a dy/dx term whenever you differentiate a term containing y, then solving algebraically.","B":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","C":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","D":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance."}',
    skill_tags = '{"implicit_diff_at_point"}', 
    error_tags = '{"implicit_diff_point_sub_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '9948ca83-d7e5-436a-9732-7a0459aa8485';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","B":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","C":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_with_trig_exp_log"}', 
    error_tags = '{"chain_rule_missing_inner"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a1929b91-9cb1-490f-92b9-6f814c232c49';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a2a450ef-9de9-405b-a9ce-0fd06a62c7ec';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_chain"}', 
    error_tags = '{"inverse_trig_sign_domain_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a4321137-6af8-407b-a198-c4e51643b63b';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_chain"}', 
    error_tags = '{"inverse_trig_missing_chain"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'aa958cac-bb36-4906-81e0-f962563d7266';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ab0a99e4-7fa2-4633-b6ba-7846588fef95';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The derivative of an inverse function is g''(x) = 1 / f''(g(x)). This option correctly applies that reciprocal relationship.","B":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","C":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","D":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign."}',
    skill_tags = '{"inverse_function_derivative"}', 
    error_tags = '{"inverse_derivative_wrong_input"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'aba62706-c5e8-4b65-889d-567b46443a58';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_compute_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b06e5bba-2b83-4c37-97ca-9532b76345b1';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_compute_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b24bb9d4-e702-48df-bc3d-9273302d1302';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_derivatives"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b512ef70-c34c-44bc-a74b-636a5e48f66e';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","B":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","C":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_basic"}', 
    error_tags = '{"chain_rule_algebra_slip"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b916692b-b088-4d8b-a58e-435aef8e94d4';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_derivative_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c10ecac2-d45e-4889-a2e4-138c7ee3c760';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_chain"}', 
    error_tags = '{"inverse_trig_missing_chain"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c207f06e-4de5-4ce8-a445-976ef78ae13d';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","B":"Correct. According to the Chain Rule, you must first differentiate the outer function while keeping the inner function intact, then multiply by the derivative of the inner function.","C":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting.","D":"Incorrect. Please check if you missed the derivative of the ''inner function'' or if there was a logical error in handling multiple layers of nesting."}',
    skill_tags = '{"chain_rule_basic"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c5013f1b-d22c-40ac-9b2a-04cce9be4846';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c7fc9c97-240f-40df-a0cb-a7188349c5cc';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c8512468-74c6-4d5b-861c-72f6ed11cb61';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ce013efd-dec8-49e0-8794-80deb344430a';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives."}',
    skill_tags = '{"higher_order_derivatives"}', 
    error_tags = '{"higher_order_compute_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd284a0ec-a98f-4349-aec0-2e4f0d394005';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","B":"Correct. The derivative of an inverse function is g''(x) = 1 / f''(g(x)). This option correctly applies that reciprocal relationship.","C":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","D":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign."}',
    skill_tags = '{"inverse_function_derivative"}', 
    error_tags = '{"inverse_derivative_reciprocal_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd59b784d-995b-4b67-8fc4-ae8cab832f9d';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","B":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","C":"Correct. The derivative of an inverse function is g''(x) = 1 / f''(g(x)). This option correctly applies that reciprocal relationship.","D":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign."}',
    skill_tags = '{"inverse_function_derivative"}', 
    error_tags = '{"inverse_derivative_wrong_input"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd90169b7-1b2d-4b99-b142-5fbf168c4e47';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_meaning"}', 
    error_tags = '{"higher_order_derivative_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd938642b-9344-4467-ab9b-72853a0f6845';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ddd27b7b-19ad-4540-8b4e-644ed93bd859';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","B":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"inverse_trig_chain"}', 
    error_tags = '{"inverse_trig_missing_chain"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e225840b-7f71-4a71-a1a3-c2951f79fc3f';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"higher_order_meaning"}', 
    error_tags = '{"higher_order_derivative_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e5dba277-8737-4ae1-b68b-65ba01e5fb08';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","B":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign.","C":"Correct. The derivative of an inverse function is g''(x) = 1 / f''(g(x)). This option correctly applies that reciprocal relationship.","D":"Incorrect. The derivative of an inverse is the reciprocal of the original function''s derivative at the corresponding point, not just a simple inversion of the sign."}',
    skill_tags = '{"inverse_function_derivative"}', 
    error_tags = '{"inverse_derivative_reciprocal_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e83c7313-4921-4d24-bfd9-5cb3c28fc38b';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Implicit differentiation requires attaching a dy/dx term whenever you differentiate a term containing y, then solving algebraically.","B":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","C":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","D":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance."}',
    skill_tags = '{"implicit_diff_basic"}', 
    error_tags = '{"implicit_diff_not_isolated"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'eb432132-45c2-4c67-a8dc-b16e3e885d16';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the mathematical logic of the Chain Rule, implicit differentiation, or inverse function derivatives.","B":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","C":"Incorrect. This option contains a logical error in handling nested functions or implicit terms.","D":"Incorrect. This option contains a logical error in handling nested functions or implicit terms."}',
    skill_tags = '{"method_selection_unit3"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ec11e644-7d02-40b2-8533-878258709ccb';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Implicit differentiation requires attaching a dy/dx term whenever you differentiate a term containing y, then solving algebraically.","B":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","C":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance.","D":"Incorrect. The key to implicit differentiation is applying the Chain Rule to y-terms, producing a dy/dx factor for each instance."}',
    skill_tags = '{"implicit_diff_basic"}', 
    error_tags = '{"method_choice_wrong_unit3"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ed7dddc1-2ffc-4a21-a080-f07f60e14e3f';
COMMIT;
