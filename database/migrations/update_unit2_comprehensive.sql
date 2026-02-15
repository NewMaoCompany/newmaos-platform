-- Unit 2 Deep Semantic Audit & Repair
-- Retrospective Update

BEGIN;

-- PHASE 1: Populate Reference Tables (Unit 2)
INSERT INTO skills (id, name, unit) VALUES ('exp_derivatives_basic', 'exp_derivatives_basic', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('tangent_line_equation', 'tangent_line_equation', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('derivative_notation', 'derivative_notation', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('trig_derivatives_basic', 'trig_derivatives_basic', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('derivative_definition_limit', 'derivative_definition_limit', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('difference_quotient', 'difference_quotient', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('quotient_rule', 'quotient_rule', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('product_rule', 'product_rule', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('diff_vs_continuity', 'diff_vs_continuity', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('linearity_rules', 'linearity_rules', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('derivative_from_graph', 'derivative_from_graph', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('slope_instant_rate', 'slope_instant_rate', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('method_selection_derivatives', 'method_selection_derivatives', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('differentiability_concept', 'differentiability_concept', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('derivative_from_table', 'derivative_from_table', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('log_derivatives_basic', 'log_derivatives_basic', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('interpret_derivative_context', 'interpret_derivative_context', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('nondifferentiable_features', 'nondifferentiable_features', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('power_rule_basic', 'power_rule_basic', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('normal_line_equation', 'normal_line_equation', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('slope_avg_rate', 'slope_avg_rate', 'Differentiation_Definition') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('exp_log_derivative_confusion', 'exp_log_derivative_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('tangent_line_equation_error', 'tangent_line_equation_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('trig_derivative_swap_error', 'trig_derivative_swap_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('h_limit_handling_error', 'h_limit_handling_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('quotient_rule_structure_error', 'quotient_rule_structure_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('product_rule_structure_error', 'product_rule_structure_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('diff_implies_continuity_missed', 'diff_implies_continuity_missed') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('tangent_line_point_confusion', 'tangent_line_point_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('difference_quotient_setup_error', 'difference_quotient_setup_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('slope_from_graph_misread', 'slope_from_graph_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('linearity_missing_term', 'linearity_missing_term') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('wrong_method_choice_derivative', 'wrong_method_choice_derivative') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('continuous_implies_diff_wrong', 'continuous_implies_diff_wrong') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('table_derivative_estimate_error', 'table_derivative_estimate_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('quotient_rule_sign_error', 'quotient_rule_sign_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('cancel_h_mistake', 'cancel_h_mistake') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('secant_vs_tangent_confusion', 'secant_vs_tangent_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('corner_cusp_not_recognized', 'corner_cusp_not_recognized') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('constant_derivative_error', 'constant_derivative_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('normal_line_slope_error', 'normal_line_slope_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('derivative_notation_misread', 'derivative_notation_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('power_rule_exponent_error', 'power_rule_exponent_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('average_rate_wrong_interval', 'average_rate_wrong_interval') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('vertical_tangent_not_recognized', 'vertical_tangent_not_recognized') ON CONFLICT (id) DO NOTHING;

-- PHASE 2: Populate Question Skills Relation
INSERT INTO question_skills (question_id, skill_id) VALUES ('020c11da-da5a-4654-b7ff-6fdcabcf592e', 'exp_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('05a91bec-4319-43c9-9174-95660bef2707', 'tangent_line_equation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('05a91bec-4319-43c9-9174-95660bef2707', 'derivative_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0f1685a4-0118-4400-bfa2-63f046bddd3e', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('17c52048-f1e4-4f08-8732-13f794ab9668', 'derivative_definition_limit') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('17c52048-f1e4-4f08-8732-13f794ab9668', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('184e3ee3-de68-47e6-aaeb-a6acab457ffd', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1cbf9be0-4580-42cc-99af-8b8e92c9b97b', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1cbf9be0-4580-42cc-99af-8b8e92c9b97b', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1d9802c3-0bb0-4ee2-b28b-e4c3f9d62d74', 'diff_vs_continuity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('20a746ae-7223-4895-8a78-79cbdeaf172a', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('20a746ae-7223-4895-8a78-79cbdeaf172a', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('22333f09-d3e6-4f04-b4ba-a6781c1cb98c', 'derivative_from_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('24c4c6d2-d7e8-4467-997e-a66d596d79aa', 'derivative_definition_limit') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('24c4c6d2-d7e8-4467-997e-a66d596d79aa', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('24e9f4f8-695b-4ced-a7ca-d192f49a1a48', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('24e9f4f8-695b-4ced-a7ca-d192f49a1a48', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('271d5001-ab77-40ee-863d-ecb908e00ee7', 'derivative_from_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('271d5001-ab77-40ee-863d-ecb908e00ee7', 'slope_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('30247f6c-c5ac-40e7-9057-909944b38a42', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('30572517-70d6-4e48-9829-347311411348', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('30572517-70d6-4e48-9829-347311411348', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('33421970-4324-4bd1-82b3-c9d57ce2617a', 'differentiability_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3421ebd1-1cd7-4034-827d-816461063c96', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3421ebd1-1cd7-4034-827d-816461063c96', 'derivative_definition_limit') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3733383c-7480-4fcb-814e-0a6afe057944', 'derivative_from_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3733383c-7480-4fcb-814e-0a6afe057944', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3828181b-4115-4bf0-bc85-5f5813ca1857', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3828181b-4115-4bf0-bc85-5f5813ca1857', 'log_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3f678293-e82d-4368-8577-0717a129a045', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3f678293-e82d-4368-8577-0717a129a045', 'derivative_definition_limit') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3f92f0dc-2b38-4563-8a4b-2dbc2203027e', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3f92f0dc-2b38-4563-8a4b-2dbc2203027e', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('408aed1b-0bf7-4b20-9168-ce3048175967', 'diff_vs_continuity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('432288c0-0c3b-456a-aeef-07a638861fa8', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('432288c0-0c3b-456a-aeef-07a638861fa8', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('44f58c63-78f3-4a23-91d4-0e6e48196efe', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('489db17c-15b1-4b1b-943c-308806d5c54f', 'interpret_derivative_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('489db17c-15b1-4b1b-943c-308806d5c54f', 'slope_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4cf08aad-480a-4ee7-8ad3-aa81da9665a5', 'derivative_from_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4eb3349b-6d4c-469f-9a3b-aada3e83c2c1', 'nondifferentiable_features') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4eb3349b-6d4c-469f-9a3b-aada3e83c2c1', 'diff_vs_continuity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('512e4ef2-cfb6-48ac-91da-fae6d237ea84', 'derivative_from_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('52fe8fe2-8729-4d93-a390-97f661acfd9a', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('52fe8fe2-8729-4d93-a390-97f661acfd9a', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('57d30721-0abe-45a6-96be-8f381262537e', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('57d30721-0abe-45a6-96be-8f381262537e', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5e620428-3fe0-4c61-a644-8f749e2041be', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5e620428-3fe0-4c61-a644-8f749e2041be', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5f28158d-416c-4237-b617-427fdd4fac14', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5f28158d-416c-4237-b617-427fdd4fac14', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('69737486-d14c-40e6-8c8c-f71c5e557aca', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d1f1f2e-5090-4f8f-a00d-16a85041bf56', 'log_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d8ccce8-090a-40be-8e25-03c4c9cbd0f4', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d8ccce8-090a-40be-8e25-03c4c9cbd0f4', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('72dd142e-bef9-4f05-b426-56c2c61e8c27', 'derivative_from_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('73c6b115-5fb3-4030-a85f-135b917a8000', 'derivative_from_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('73c6b115-5fb3-4030-a85f-135b917a8000', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('73fa8c73-5409-41cc-92bf-4e6dd7ec9d57', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('73fa8c73-5409-41cc-92bf-4e6dd7ec9d57', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('754f482a-844c-422c-b23d-aff2d66ca4fc', 'normal_line_equation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('754f482a-844c-422c-b23d-aff2d66ca4fc', 'tangent_line_equation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('80c62aaf-d83c-40b3-b2ab-9cca15eac2e8', 'slope_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('80c62aaf-d83c-40b3-b2ab-9cca15eac2e8', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('85bda686-1664-4841-b4fc-81ef3370758f', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('85bda686-1664-4841-b4fc-81ef3370758f', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('878d6f75-6746-419a-9dfd-5a10fae3966f', 'diff_vs_continuity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8819d62b-11ae-4131-9a73-f9060b516421', 'nondifferentiable_features') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('88ae6803-0699-487d-8c33-45c2bf06f10c', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('88ae6803-0699-487d-8c33-45c2bf06f10c', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('88fa7ab9-c412-41be-be20-0c1ccd0c66a0', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('88fa7ab9-c412-41be-be20-0c1ccd0c66a0', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('891d304e-8db9-44e3-8b7c-f0dab0c25a78', 'derivative_from_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('891d304e-8db9-44e3-8b7c-f0dab0c25a78', 'derivative_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8d676d26-b96a-4f4b-8b5e-6b034eabc24a', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8d676d26-b96a-4f4b-8b5e-6b034eabc24a', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('92067e1f-2ca7-43cf-b08c-265573e35955', 'slope_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('92067e1f-2ca7-43cf-b08c-265573e35955', 'slope_avg_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('965e82a6-505e-4854-8bc4-925baecd03ff', 'interpret_derivative_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('965e82a6-505e-4854-8bc4-925baecd03ff', 'slope_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('997b15cc-b985-4c56-a08a-8ae4cf99dfc6', 'trig_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a80c0b86-0167-403d-b31d-74fb4b0a39ea', 'derivative_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a80c0b86-0167-403d-b31d-74fb4b0a39ea', 'interpret_derivative_context') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('abe28423-4854-4a34-83c3-4dd9d0fc88a0', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('add0bc6f-e828-405d-87ea-f5e224796bf1', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b1fdc896-1b99-4753-b986-7ee1fcdb27ac', 'slope_avg_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('bae2f1fc-ce42-4bdd-b9d0-45cf31f0149f', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('bc798f16-fc48-4db1-bcf5-41b57770ff85', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('bc798f16-fc48-4db1-bcf5-41b57770ff85', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('beab9937-2e0a-420e-a540-3e46624c7188', 'difference_quotient') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('beab9937-2e0a-420e-a540-3e46624c7188', 'slope_avg_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ca6b2eda-8919-4bff-9da7-84bdb3322cb2', 'derivative_from_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d7f5b853-f6d2-4d12-b043-787faef79f35', 'derivative_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d90dc96e-148d-4ac8-a406-2903dbd38e8a', 'nondifferentiable_features') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('db269d76-4ce6-48f6-bb2e-138cc79ef3e8', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('dde972b3-8ff0-44ef-94c0-7551944318f7', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('dde972b3-8ff0-44ef-94c0-7551944318f7', 'log_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e1ccd149-62f7-4418-a18c-6c850e37dcb2', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e1ccd149-62f7-4418-a18c-6c850e37dcb2', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e5bfc943-7601-4e22-ad58-283a5e336f49', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e5bfc943-7601-4e22-ad58-283a5e336f49', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e7e2561d-5502-476b-9f39-f26e2216c5ce', 'slope_avg_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ef9eb6a7-d358-4817-b018-a06f38d840ad', 'linearity_rules') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ef9eb6a7-d358-4817-b018-a06f38d840ad', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('efdf6412-1289-4538-9ce6-acd1b67bafad', 'log_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f51602e6-ecf7-46ea-8f9c-4a726ebb1a75', 'product_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f51602e6-ecf7-46ea-8f9c-4a726ebb1a75', 'power_rule_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f8b5fead-9cb7-4857-b7ac-0bd35befaabc', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f8b5fead-9cb7-4857-b7ac-0bd35befaabc', 'quotient_rule') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f8cda24a-c64d-43d8-8848-d978318dd686', 'exp_derivatives_basic') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fca9dfc7-9f43-4d82-8627-bbf1cccb0eb6', 'method_selection_derivatives') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fca9dfc7-9f43-4d82-8627-bbf1cccb0eb6', 'derivative_definition_limit') ON CONFLICT DO NOTHING;

-- PHASE 3: Update Questions Table (Semantic Version)
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"exp_derivatives_basic"}', 
    error_tags = '{"exp_log_derivative_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '020c11da-da5a-4654-b7ff-6fdcabcf592e';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"tangent_line_equation","derivative_notation"}', 
    error_tags = '{"tangent_line_equation_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '05a91bec-4319-43c9-9174-95660bef2707';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Standard trig derivatives: (sin x)'' = cos x, (cos x)'' = -sin x. This option follows the established formulas.","B":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","C":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","D":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine."}',
    skill_tags = '{"trig_derivatives_basic"}', 
    error_tags = '{"trig_derivative_swap_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '0f1685a4-0118-4400-bfa2-63f046bddd3e';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please verify the standard form of the derivative''s definition, ensuring the increment h and the difference quotient are correctly structured.","B":"Incorrect. Please verify the standard form of the derivative''s definition, ensuring the increment h and the difference quotient are correctly structured.","C":"Correct. Based on the limit definition of a derivative, f''(a) = lim(h->0) [f(a+h)-f(a)]/h. This expression accurately reflects that definition.","D":"Incorrect. Please verify the standard form of the derivative''s definition, ensuring the increment h and the difference quotient are correctly structured."}',
    skill_tags = '{"derivative_definition_limit","difference_quotient"}', 
    error_tags = '{"h_limit_handling_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '17c52048-f1e4-4f08-8732-13f794ab9668';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Quotient Rule is (f/g)'' = (f''g - fg'')/g^2. Note the order of subtraction in the numerator and the squared denominator.","B":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","C":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","D":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator."}',
    skill_tags = '{"quotient_rule"}', 
    error_tags = '{"quotient_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '184e3ee3-de68-47e6-aaeb-a6acab457ffd';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Product Rule is (fg)'' = f''g + fg''. this option correctly applies alternating derivatives and sums them.","B":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","C":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","D":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results."}',
    skill_tags = '{"product_rule","trig_derivatives_basic"}', 
    error_tags = '{"product_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '1cbf9be0-4580-42cc-99af-8b8e92c9b97b';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Use file U2_1769404469_2.4-P2_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","B":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","C":"Correct. Differentiability implies continuity, but continuity does not always imply differentiability (e.g., at sharp turns or vertical tangents).","D":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope)."}',
    skill_tags = '{"diff_vs_continuity"}', 
    error_tags = '{"diff_implies_continuity_missed"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '1d9802c3-0bb0-4ee2-b28b-e4c3f9d62d74';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Standard trig derivatives: (sin x)'' = cos x, (cos x)'' = -sin x. This option follows the established formulas.","B":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","C":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","D":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine."}',
    skill_tags = '{"trig_derivatives_basic","linearity_rules"}', 
    error_tags = '{"trig_derivative_swap_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '20a746ae-7223-4895-8a78-79cbdeaf172a';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Use file U2_1769404469_2.3-P4_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_graph"}', 
    error_tags = '{"tangent_line_point_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '22333f09-d3e6-4f04-b4ba-a6781c1cb98c';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Based on the limit definition of a derivative, f''(a) = lim(h->0) [f(a+h)-f(a)]/h. This expression accurately reflects that definition.","B":"Incorrect. Please verify the standard form of the derivative''s definition, ensuring the increment h and the difference quotient are correctly structured.","C":"Incorrect. Please verify the standard form of the derivative''s definition, ensuring the increment h and the difference quotient are correctly structured.","D":"Incorrect. Please verify the standard form of the derivative''s definition, ensuring the increment h and the difference quotient are correctly structured."}',
    skill_tags = '{"derivative_definition_limit","difference_quotient"}', 
    error_tags = '{"h_limit_handling_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '24c4c6d2-d7e8-4467-997e-a66d596d79aa';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"difference_quotient","linearity_rules"}', 
    error_tags = '{"difference_quotient_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '24e9f4f8-695b-4ced-a7ca-d192f49a1a48';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Graph file: U2_UT_Q4_graph.png',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_graph","slope_instant_rate"}', 
    error_tags = '{"slope_from_graph_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '271d5001-ab77-40ee-863d-ecb908e00ee7';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"linearity_rules"}', 
    error_tags = '{"linearity_missing_term"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '30247f6c-c5ac-40e7-9057-909944b38a42';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","linearity_rules"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '30572517-70d6-4e48-9829-347311411348';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"differentiability_concept"}', 
    error_tags = '{"continuous_implies_diff_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '33421970-4324-4bd1-82b3-c9d57ce2617a';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","derivative_definition_limit"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3421ebd1-1cd7-4034-827d-816461063c96';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Table file: U2_UT_Q7_table.png',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_table","difference_quotient"}', 
    error_tags = '{"table_derivative_estimate_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3733383c-7480-4fcb-814e-0a6afe057944';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Quotient Rule is (f/g)'' = (f''g - fg'')/g^2. Note the order of subtraction in the numerator and the squared denominator.","B":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","C":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","D":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator."}',
    skill_tags = '{"quotient_rule","log_derivatives_basic"}', 
    error_tags = '{"quotient_rule_sign_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3828181b-4115-4bf0-bc85-5f5813ca1857';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"difference_quotient","derivative_definition_limit"}', 
    error_tags = '{"cancel_h_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3f678293-e82d-4368-8577-0717a129a045';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Standard trig derivatives: (sin x)'' = cos x, (cos x)'' = -sin x. This option follows the established formulas.","B":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","C":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","D":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine."}',
    skill_tags = '{"trig_derivatives_basic","linearity_rules"}', 
    error_tags = '{"trig_derivative_swap_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3f92f0dc-2b38-4563-8a4b-2dbc2203027e';
UPDATE questions SET
    target_time_seconds = 140,
    notes = 'Use file U2_1769404469_2.4-P4_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","B":"Correct. Differentiability implies continuity, but continuity does not always imply differentiability (e.g., at sharp turns or vertical tangents).","C":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","D":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope)."}',
    skill_tags = '{"diff_vs_continuity"}', 
    error_tags = '{"continuous_implies_diff_wrong"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '408aed1b-0bf7-4b20-9168-ce3048175967';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"linearity_rules","trig_derivatives_basic"}', 
    error_tags = '{"linearity_missing_term"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '432288c0-0c3b-456a-aeef-07a638861fa8';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Standard trig derivatives: (sin x)'' = cos x, (cos x)'' = -sin x. This option follows the established formulas.","B":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","C":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","D":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine."}',
    skill_tags = '{"trig_derivatives_basic"}', 
    error_tags = '{"trig_derivative_swap_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '44f58c63-78f3-4a23-91d4-0e6e48196efe';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","B":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","C":"Correct. Geometrically, the derivative represents the slope of the tangent line; physically, it represents the instantaneous rate of change.","D":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change."}',
    skill_tags = '{"interpret_derivative_context","slope_instant_rate"}', 
    error_tags = '{"secant_vs_tangent_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '489db17c-15b1-4b1b-943c-308806d5c54f';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Use file U2_1769404469_2.3-P1_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_graph"}', 
    error_tags = '{"slope_from_graph_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4cf08aad-480a-4ee7-8ad3-aa81da9665a5';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Graph file: U2_UT_Q10_graph.png',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Differentiability implies continuity, but continuity does not always imply differentiability (e.g., at sharp turns or vertical tangents).","B":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","C":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","D":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope)."}',
    skill_tags = '{"nondifferentiable_features","diff_vs_continuity"}', 
    error_tags = '{"corner_cusp_not_recognized"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4eb3349b-6d4c-469f-9a3b-aada3e83c2c1';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Use file U2_1769404469_2.3-P2_table.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_table"}', 
    error_tags = '{"table_derivative_estimate_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '512e4ef2-cfb6-48ac-91da-fae6d237ea84';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Quotient Rule is (f/g)'' = (f''g - fg'')/g^2. Note the order of subtraction in the numerator and the squared denominator.","B":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","C":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","D":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator."}',
    skill_tags = '{"quotient_rule","trig_derivatives_basic"}', 
    error_tags = '{"quotient_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '52fe8fe2-8729-4d93-a390-97f661acfd9a';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","trig_derivatives_basic"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '57d30721-0abe-45a6-96be-8f381262537e';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. According to the Power Rule, the derivative of x^n is n * x^(n-1).","B":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","C":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","D":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1."}',
    skill_tags = '{"power_rule_basic","linearity_rules"}', 
    error_tags = '{"constant_derivative_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5e620428-3fe0-4c61-a644-8f749e2041be';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Quotient Rule is (f/g)'' = (f''g - fg'')/g^2. Note the order of subtraction in the numerator and the squared denominator.","B":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","C":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","D":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator."}',
    skill_tags = '{"quotient_rule","power_rule_basic"}', 
    error_tags = '{"quotient_rule_sign_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5f28158d-416c-4237-b617-427fdd4fac14';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Product Rule is (fg)'' = f''g + fg''. this option correctly applies alternating derivatives and sums them.","B":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","C":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","D":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results."}',
    skill_tags = '{"product_rule"}', 
    error_tags = '{"product_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '69737486-d14c-40e6-8c8c-f71c5e557aca';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"log_derivatives_basic"}', 
    error_tags = '{"exp_log_derivative_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6d1f1f2e-5090-4f8f-a00d-16a85041bf56';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"linearity_rules","power_rule_basic"}', 
    error_tags = '{"constant_derivative_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6d8ccce8-090a-40be-8e25-03c4c9cbd0f4';
UPDATE questions SET
    target_time_seconds = 140,
    notes = 'Use file U2_1769404469_2.3-P5_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_graph"}', 
    error_tags = '{"slope_from_graph_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '72dd142e-bef9-4f05-b426-56c2c61e8c27';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Use file U2_1769403109_2.1-P5_table.png',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_table","difference_quotient"}', 
    error_tags = '{"table_derivative_estimate_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '73c6b115-5fb3-4030-a85f-135b917a8000';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Product Rule is (fg)'' = f''g + fg''. this option correctly applies alternating derivatives and sums them.","B":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","C":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","D":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results."}',
    skill_tags = '{"product_rule","trig_derivatives_basic"}', 
    error_tags = '{"product_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '73fa8c73-5409-41cc-92bf-4e6dd7ec9d57';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"normal_line_equation","tangent_line_equation"}', 
    error_tags = '{"normal_line_slope_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '754f482a-844c-422c-b23d-aff2d66ca4fc';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Geometrically, the derivative represents the slope of the tangent line; physically, it represents the instantaneous rate of change.","B":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","C":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","D":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change."}',
    skill_tags = '{"slope_instant_rate","difference_quotient"}', 
    error_tags = '{"secant_vs_tangent_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '80c62aaf-d83c-40b3-b2ab-9cca15eac2e8';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Product Rule is (fg)'' = f''g + fg''. this option correctly applies alternating derivatives and sums them.","B":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","C":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","D":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results."}',
    skill_tags = '{"product_rule","trig_derivatives_basic"}', 
    error_tags = '{"product_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '85bda686-1664-4841-b4fc-81ef3370758f';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Differentiability implies continuity, but continuity does not always imply differentiability (e.g., at sharp turns or vertical tangents).","B":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","C":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","D":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope)."}',
    skill_tags = '{"diff_vs_continuity"}', 
    error_tags = '{"diff_implies_continuity_missed"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '878d6f75-6746-419a-9dfd-5a10fae3966f';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Use file U2_1769404469_2.4-P1_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","B":"Correct. Differentiability implies continuity, but continuity does not always imply differentiability (e.g., at sharp turns or vertical tangents).","C":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","D":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope)."}',
    skill_tags = '{"nondifferentiable_features"}', 
    error_tags = '{"corner_cusp_not_recognized"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8819d62b-11ae-4131-9a73-f9060b516421';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","trig_derivatives_basic"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '88ae6803-0699-487d-8c33-45c2bf06f10c';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Quotient Rule is (f/g)'' = (f''g - fg'')/g^2. Note the order of subtraction in the numerator and the squared denominator.","B":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","C":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","D":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator."}',
    skill_tags = '{"quotient_rule","power_rule_basic"}', 
    error_tags = '{"quotient_rule_sign_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '88fa7ab9-c412-41be-be20-0c1ccd0c66a0';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Use file U2_1769403109_2.2-P4_graph.png',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_graph","derivative_notation"}', 
    error_tags = '{"slope_from_graph_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '891d304e-8db9-44e3-8b7c-f0dab0c25a78';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Quotient Rule is (f/g)'' = (f''g - fg'')/g^2. Note the order of subtraction in the numerator and the squared denominator.","B":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","C":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator.","D":"Incorrect. The key to the Quotient Rule is: (Low dHigh - High dLow) / Low-squared. Please check the sign in the numerator."}',
    skill_tags = '{"quotient_rule","trig_derivatives_basic"}', 
    error_tags = '{"quotient_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8d676d26-b96a-4f4b-8b5e-6b034eabc24a';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Use file U2_1769403109_2.1-P2_graph.png',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","B":"Correct. Geometrically, the derivative represents the slope of the tangent line; physically, it represents the instantaneous rate of change.","C":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","D":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change."}',
    skill_tags = '{"slope_instant_rate","slope_avg_rate"}', 
    error_tags = '{"secant_vs_tangent_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '92067e1f-2ca7-43cf-b08c-265573e35955';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Geometrically, the derivative represents the slope of the tangent line; physically, it represents the instantaneous rate of change.","B":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","C":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","D":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change."}',
    skill_tags = '{"interpret_derivative_context","slope_instant_rate"}', 
    error_tags = '{"secant_vs_tangent_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '965e82a6-505e-4854-8bc4-925baecd03ff';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Standard trig derivatives: (sin x)'' = cos x, (cos x)'' = -sin x. This option follows the established formulas.","B":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","C":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine.","D":"Incorrect. Please verify standard trigonometric differentiation formulas, paying special attention to the negative sign for the derivative of cosine."}',
    skill_tags = '{"trig_derivatives_basic"}', 
    error_tags = '{"trig_derivative_swap_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '997b15cc-b985-4c56-a08a-8ae4cf99dfc6';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_notation","interpret_derivative_context"}', 
    error_tags = '{"derivative_notation_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a80c0b86-0167-403d-b31d-74fb4b0a39ea';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. According to the Power Rule, the derivative of x^n is n * x^(n-1).","B":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","C":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","D":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1."}',
    skill_tags = '{"power_rule_basic"}', 
    error_tags = '{"power_rule_exponent_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'abe28423-4854-4a34-83c3-4dd9d0fc88a0';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. According to the Power Rule, the derivative of x^n is n * x^(n-1).","B":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","C":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","D":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1."}',
    skill_tags = '{"power_rule_basic"}', 
    error_tags = '{"power_rule_exponent_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'add0bc6f-e828-405d-87ea-f5e224796bf1';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Geometrically, the derivative represents the slope of the tangent line; physically, it represents the instantaneous rate of change.","B":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","C":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","D":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change."}',
    skill_tags = '{"slope_avg_rate"}', 
    error_tags = '{"average_rate_wrong_interval"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b1fdc896-1b99-4753-b986-7ee1fcdb27ac';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. According to the Power Rule, the derivative of x^n is n * x^(n-1).","B":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","C":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","D":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1."}',
    skill_tags = '{"power_rule_basic"}', 
    error_tags = '{"power_rule_exponent_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'bae2f1fc-ce42-4bdd-b9d0-45cf31f0149f';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. According to the Power Rule, the derivative of x^n is n * x^(n-1).","B":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","C":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1.","D":"Incorrect. When applying the Power Rule, the original exponent becomes the coefficient, and the new exponent is decreased by 1."}',
    skill_tags = '{"power_rule_basic","linearity_rules"}', 
    error_tags = '{"linearity_missing_term"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'bc798f16-fc48-4db1-bcf5-41b57770ff85';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"difference_quotient","slope_avg_rate"}', 
    error_tags = '{"difference_quotient_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'beab9937-2e0a-420e-a540-3e46624c7188';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Use file U2_1769404469_2.3-P3_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_from_graph"}', 
    error_tags = '{"slope_from_graph_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ca6b2eda-8919-4bff-9da7-84bdb3322cb2';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"derivative_notation"}', 
    error_tags = '{"derivative_notation_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd7f5b853-f6d2-4d12-b043-787faef79f35';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Use file U2_1769404469_2.4-P3_graph.png',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","B":"Correct. Differentiability implies continuity, but continuity does not always imply differentiability (e.g., at sharp turns or vertical tangents).","C":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope).","D":"Incorrect. Distinguish between continuity (no breaks) and differentiability (smoothness and a defined, finite slope)."}',
    skill_tags = '{"nondifferentiable_features"}', 
    error_tags = '{"vertical_tangent_not_recognized"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd90dc96e-148d-4ac8-a406-2903dbd38e8a';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"linearity_rules"}', 
    error_tags = '{"linearity_missing_term"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'db269d76-4ce6-48f6-bb2e-138cc79ef3e8';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Product Rule is (fg)'' = f''g + fg''. this option correctly applies alternating derivatives and sums them.","B":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","C":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","D":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results."}',
    skill_tags = '{"product_rule","log_derivatives_basic"}', 
    error_tags = '{"product_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'dde972b3-8ff0-44ef-94c0-7551944318f7';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","power_rule_basic"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e1ccd149-62f7-4418-a18c-6c850e37dcb2';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","product_rule"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e5bfc943-7601-4e22-ad58-283a5e336f49';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Geometrically, the derivative represents the slope of the tangent line; physically, it represents the instantaneous rate of change.","B":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","C":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change.","D":"Incorrect. The derivative reflects the rate of change, not the function value itself or the average rate of change."}',
    skill_tags = '{"slope_avg_rate"}', 
    error_tags = '{"average_rate_wrong_interval"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e7e2561d-5502-476b-9f39-f26e2216c5ce';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"linearity_rules","power_rule_basic"}', 
    error_tags = '{"linearity_missing_term"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ef9eb6a7-d358-4817-b018-a06f38d840ad';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"log_derivatives_basic"}', 
    error_tags = '{"exp_log_derivative_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'efdf6412-1289-4538-9ce6-acd1b67bafad';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Product Rule is (fg)'' = f''g + fg''. this option correctly applies alternating derivatives and sums them.","B":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","C":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results.","D":"Incorrect. The Product Rule requires keeping one term constant while differentiating the other, then summing the cross-results."}',
    skill_tags = '{"product_rule","power_rule_basic"}', 
    error_tags = '{"product_rule_structure_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f51602e6-ecf7-46ea-8f9c-4a726ebb1a75';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","quotient_rule"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f8b5fead-9cb7-4857-b7ac-0bd35befaabc';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"exp_derivatives_basic"}', 
    error_tags = '{"exp_log_derivative_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f8cda24a-c64d-43d8-8848-d978318dd686';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","B":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative.","C":"Correct. This option aligns with basic derivative rules, definitions, or geometric interpretations.","D":"Incorrect. This option does not follow differentiation rules or the mathematical definition of a derivative."}',
    skill_tags = '{"method_selection_derivatives","derivative_definition_limit"}', 
    error_tags = '{"wrong_method_choice_derivative"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'fca9dfc7-9f43-4d82-8627-bbf1cccb0eb6';

COMMIT;
