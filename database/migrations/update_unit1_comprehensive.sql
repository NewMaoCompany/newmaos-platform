-- Unit 1 Deep Semantic Audit & Repair
-- Retrospective Update

BEGIN;

-- PHASE 1: Populate Reference Tables (Unit 1)
INSERT INTO skills (id, name, unit) VALUES ('discontinuity_types', 'discontinuity_types', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('limit_estimation_graph', 'limit_estimation_graph', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('limit_laws', 'limit_laws', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('algebraic_simplification', 'algebraic_simplification', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('limits_at_infinity', 'limits_at_infinity', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('infinite_limits_asymptotes', 'infinite_limits_asymptotes', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('ivt_application', 'ivt_application', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('continuity_concept', 'continuity_concept', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('avg_vs_instant_rate', 'avg_vs_instant_rate', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('limit_concept', 'limit_concept', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('squeeze_theorem', 'squeeze_theorem', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('derivative_definition', 'derivative_definition', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('limit_estimation_table', 'limit_estimation_table', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('limit_notation', 'limit_notation', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('method_selection', 'method_selection', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('conjugate_rationalization', 'conjugate_rationalization', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO skills (id, name, unit) VALUES ('one_sided_from_data', 'one_sided_from_data', 'Both_Limits') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('graph_jump_confusion', 'graph_jump_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('illegal_substitution_0over0', 'illegal_substitution_0over0') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('asymptote_confusion', 'asymptote_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('ivt_missing_continuity', 'ivt_missing_continuity') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('average_vs_instant', 'average_vs_instant') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('squeeze_bounds_incorrect', 'squeeze_bounds_incorrect') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('difference_quotient_wrong_limit', 'difference_quotient_wrong_limit') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('table_trend_misread', 'table_trend_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('continuity_three_conditions_miss', 'continuity_three_conditions_miss') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('wrong_method_choice', 'wrong_method_choice') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('infinity_degree_mistake', 'infinity_degree_mistake') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('infinite_limit_meaning', 'infinite_limit_meaning') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('two_sided_requires_match', 'two_sided_requires_match') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('conjugate_setup_error', 'conjugate_setup_error') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('endpoint_domain_issue', 'endpoint_domain_issue') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('open_vs_closed_point', 'open_vs_closed_point') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('factor_cancel_mistake', 'factor_cancel_mistake') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('limit_vs_value', 'limit_vs_value') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('quotient_law_denominator_zero', 'quotient_law_denominator_zero') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('interval_continuity_confusion', 'interval_continuity_confusion') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('notation_misread', 'notation_misread') ON CONFLICT (id) DO NOTHING;
INSERT INTO error_tags (id, name) VALUES ('one_sided_from_data', 'one_sided_from_data') ON CONFLICT (id) DO NOTHING;

-- PHASE 2: Populate Question Skills Relation
INSERT INTO question_skills (question_id, skill_id) VALUES ('0015173b-cc1a-4da5-9bd2-4c6aaeecd720', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0015173b-cc1a-4da5-9bd2-4c6aaeecd720', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('029895ae-b361-44f1-b162-e391e6578fe0', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('029895ae-b361-44f1-b162-e391e6578fe0', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('051cdc2e-fd06-4eb2-b3b1-ba75e807a64a', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('051cdc2e-fd06-4eb2-b3b1-ba75e807a64a', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('09af0e9c-0e94-4178-8e99-19821f5bb9bd', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('09af0e9c-0e94-4178-8e99-19821f5bb9bd', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0d6904ae-a190-4330-bed2-615431a5bc48', 'avg_vs_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0d6904ae-a190-4330-bed2-615431a5bc48', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0f685f6a-9fcd-4555-afd2-03d2b1a2e899', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('0f685f6a-9fcd-4555-afd2-03d2b1a2e899', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('11ae027c-0215-4834-aa74-0e88e3ca6b6b', 'derivative_definition') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('11ae027c-0215-4834-aa74-0e88e3ca6b6b', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('140e8637-cefb-4071-961f-dd01e9627f51', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('140e8637-cefb-4071-961f-dd01e9627f51', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('141ebcb4-37bf-41f0-9a6a-3c5a0c9860e3', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('141ebcb4-37bf-41f0-9a6a-3c5a0c9860e3', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1d1df4d4-390a-4763-98ee-9a9154aa7101', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('1d1df4d4-390a-4763-98ee-9a9154aa7101', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('206da2ab-d968-47a0-b06f-a2d64a795e69', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('206da2ab-d968-47a0-b06f-a2d64a795e69', 'avg_vs_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('26c57f87-799d-4e6a-a786-96f77b64d5c9', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('26c57f87-799d-4e6a-a786-96f77b64d5c9', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('28b9e55f-47cd-4797-b14b-127f3656400b', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('28b9e55f-47cd-4797-b14b-127f3656400b', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('34b950cd-3e01-4236-acf4-9985a39744bf', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('34b950cd-3e01-4236-acf4-9985a39744bf', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3e778fee-ed46-4ce9-9957-0f98aab05d85', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('3e778fee-ed46-4ce9-9957-0f98aab05d85', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('42aacaf5-0631-49b3-ae54-46805526a3ac', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('42aacaf5-0631-49b3-ae54-46805526a3ac', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('45053b2f-bb1a-40db-ba92-8b4cb8d8b544', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('45053b2f-bb1a-40db-ba92-8b4cb8d8b544', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4a20b9f3-7002-470a-b576-e8a4850d729c', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4a20b9f3-7002-470a-b576-e8a4850d729c', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4ab23ec2-7fee-4ecc-a197-8b7d7573d46d', 'conjugate_rationalization') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4ab23ec2-7fee-4ecc-a197-8b7d7573d46d', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4b832987-d059-4273-9bd7-131e14f980f8', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4b832987-d059-4273-9bd7-131e14f980f8', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4be50f42-dfe8-46b0-a397-ce4bcb1d0402', 'conjugate_rationalization') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4be50f42-dfe8-46b0-a397-ce4bcb1d0402', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4dc9f63b-711d-4eeb-9893-07dfc03a2b71', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4dc9f63b-711d-4eeb-9893-07dfc03a2b71', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4fcdb293-25e2-46f2-b889-0899197211c0', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('4fcdb293-25e2-46f2-b889-0899197211c0', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('51448cae-3144-4bde-b809-392cdfe4dfa2', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('51448cae-3144-4bde-b809-392cdfe4dfa2', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('517f0d4c-d735-47fc-bbac-90231c61b275', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('517f0d4c-d735-47fc-bbac-90231c61b275', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('54582b8f-de15-48cd-8f11-af7480321207', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('54582b8f-de15-48cd-8f11-af7480321207', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5692b215-8191-4b07-be69-fcc4c13f11a2', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5692b215-8191-4b07-be69-fcc4c13f11a2', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5f960cac-a4ff-458c-a372-995fcb81d7f9', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('5f960cac-a4ff-458c-a372-995fcb81d7f9', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('603adacd-60af-4530-822d-09a41b3dfc9c', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('603adacd-60af-4530-822d-09a41b3dfc9c', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6437c89c-ffff-4f06-84e7-db84847b05dd', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('657988f9-e8d7-4cea-b466-87dcff445639', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('657988f9-e8d7-4cea-b466-87dcff445639', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6a70ff57-aff2-4d70-ad1e-1e4eabdb2f7b', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6a70ff57-aff2-4d70-ad1e-1e4eabdb2f7b', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d17abb7-94c3-4b6c-8645-61f01c7c0d9d', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6d17abb7-94c3-4b6c-8645-61f01c7c0d9d', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6f768c3d-dd63-41ea-9c26-5eb51354e217', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('6f768c3d-dd63-41ea-9c26-5eb51354e217', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7411bef6-0477-4631-924b-b38afc3d2ecb', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7411bef6-0477-4631-924b-b38afc3d2ecb', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7e1b0164-2ec4-4bad-ad4e-3b65aec2534b', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7e1b0164-2ec4-4bad-ad4e-3b65aec2534b', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7e5e4219-1a50-4b7c-8f66-caf8a4aca5db', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('7e5e4219-1a50-4b7c-8f66-caf8a4aca5db', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('878f40cf-d90f-4112-a418-15a46a710606', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('878f40cf-d90f-4112-a418-15a46a710606', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('89417aeb-e2c3-4535-940c-1b4d2484e9c0', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('89417aeb-e2c3-4535-940c-1b4d2484e9c0', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8a0ad35f-00a0-488e-875e-e3cc3be3279e', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8a0ad35f-00a0-488e-875e-e3cc3be3279e', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8a284217-7c14-4f3b-876f-f2d56e95ca85', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8a284217-7c14-4f3b-876f-f2d56e95ca85', 'conjugate_rationalization') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8acd8514-e063-407b-8559-b87300662014', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8acd8514-e063-407b-8559-b87300662014', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8c4724a4-1bdf-4c88-a925-cdf2a9f9ccad', 'derivative_definition') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8c4724a4-1bdf-4c88-a925-cdf2a9f9ccad', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8f5c5672-f562-453c-802c-d79b2c05185f', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('8f5c5672-f562-453c-802c-d79b2c05185f', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('93cff0de-5d7c-40ed-8492-2b741df23cad', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('93cff0de-5d7c-40ed-8492-2b741df23cad', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('97146b56-a7f9-43b4-a468-97e60063dc7d', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('97146b56-a7f9-43b4-a468-97e60063dc7d', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9823692e-26d8-4e6d-9d33-9eeed60e4ff3', 'avg_vs_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9823692e-26d8-4e6d-9d33-9eeed60e4ff3', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('98fa533e-edaf-4c99-bee2-5d9df04aa0ac', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('98fa533e-edaf-4c99-bee2-5d9df04aa0ac', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('995d20ab-7ad4-4fc2-aa05-06031445ebb2', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('995d20ab-7ad4-4fc2-aa05-06031445ebb2', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9b8a1428-e64e-4826-93cf-3167497f581d', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('9b8a1428-e64e-4826-93cf-3167497f581d', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a2ee2cd1-6734-4fcc-8665-ec0e3d3dabd2', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a2ee2cd1-6734-4fcc-8665-ec0e3d3dabd2', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a3d4039d-b209-4027-9fd1-093c022401d0', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a3d4039d-b209-4027-9fd1-093c022401d0', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a42d9d06-35ba-410c-95ba-7f036ef1a11b', 'derivative_definition') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a42d9d06-35ba-410c-95ba-7f036ef1a11b', 'conjugate_rationalization') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a42f296d-1ba8-4e0b-a145-62988c59870c', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a42f296d-1ba8-4e0b-a145-62988c59870c', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a621e024-4133-4c53-aa01-043d473c67fd', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a621e024-4133-4c53-aa01-043d473c67fd', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a6e38b84-164f-47d8-9795-57aebf867316', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('a6e38b84-164f-47d8-9795-57aebf867316', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('aaecf8d8-17f7-446d-938e-2c6bdebacde1', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('aaecf8d8-17f7-446d-938e-2c6bdebacde1', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ad9b29d7-485b-43d8-956c-8770a3f580c5', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ad9b29d7-485b-43d8-956c-8770a3f580c5', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('adc81ac2-cfc7-4e33-b3df-345b6e79ae16', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('adc81ac2-cfc7-4e33-b3df-345b6e79ae16', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('aec34f1c-1ed9-4dd8-a80a-eae2e091722e', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('aec34f1c-1ed9-4dd8-a80a-eae2e091722e', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b06360c6-c478-442e-956b-41b946d58257', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b06360c6-c478-442e-956b-41b946d58257', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b0fb72ce-126e-4c41-96e9-dcf4f96e3af0', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b0fb72ce-126e-4c41-96e9-dcf4f96e3af0', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b47292a2-5ca2-486b-af57-cabf8ff5f4fe', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('b47292a2-5ca2-486b-af57-cabf8ff5f4fe', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ba9b6523-8207-4cae-8cc6-7d1955a32c07', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ba9b6523-8207-4cae-8cc6-7d1955a32c07', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c351da6f-a1c7-4cc5-aa9f-efed76b3930b', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c351da6f-a1c7-4cc5-aa9f-efed76b3930b', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c89d6f58-94bb-4419-b946-51a74f246164', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c89d6f58-94bb-4419-b946-51a74f246164', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c9f2ebf0-c91a-48ed-af89-cb117b185b75', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('c9f2ebf0-c91a-48ed-af89-cb117b185b75', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cb4e1f66-2fc1-4ec8-a37a-16d6371fab80', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cb4e1f66-2fc1-4ec8-a37a-16d6371fab80', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cb96d608-8cf3-4653-862d-037e39493960', 'avg_vs_instant_rate') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cb96d608-8cf3-4653-862d-037e39493960', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cd685f61-7b8b-4bb8-b637-349deaf4d681', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('cd685f61-7b8b-4bb8-b637-349deaf4d681', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ce84ec70-73b1-459c-b382-a3d6f599ab60', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ce84ec70-73b1-459c-b382-a3d6f599ab60', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d3ca74be-e13a-4e47-ad7d-137bdbdbc842', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d3ca74be-e13a-4e47-ad7d-137bdbdbc842', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d5394b68-91d3-431f-b00b-49be645f13fe', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('d5394b68-91d3-431f-b00b-49be645f13fe', 'infinite_limits_asymptotes') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('dcfc4e82-0e48-4eba-81f2-0b0d75e0f9a4', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('dcfc4e82-0e48-4eba-81f2-0b0d75e0f9a4', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ddab50a0-a3fc-4ea4-910d-0b38bf5de730', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ddab50a0-a3fc-4ea4-910d-0b38bf5de730', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('dea4fa4e-088e-42cb-a25e-bd633e8871c3', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('dea4fa4e-088e-42cb-a25e-bd633e8871c3', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e1e8385f-557c-49d4-bd29-b5180bf2f599', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e1e8385f-557c-49d4-bd29-b5180bf2f599', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e432e2fb-7cd6-4257-bbb4-d503e8ca9056', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e432e2fb-7cd6-4257-bbb4-d503e8ca9056', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e75e1786-e15d-43b8-a759-038b5d77adc5', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e75e1786-e15d-43b8-a759-038b5d77adc5', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e8484a49-598c-464e-8765-9bba307a9337', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('e8484a49-598c-464e-8765-9bba307a9337', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ea511a78-2b62-4d07-9573-a16f6180335a', 'conjugate_rationalization') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ea511a78-2b62-4d07-9573-a16f6180335a', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ead92a67-4eb0-42af-8f2f-0dd065eb3f56', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ead92a67-4eb0-42af-8f2f-0dd065eb3f56', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ebdcf9bf-cc03-4b4e-ba2d-49dc62e535c9', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ebdcf9bf-cc03-4b4e-ba2d-49dc62e535c9', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ec27c3b6-dda8-4c93-909b-cdc99b1d50cb', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ec27c3b6-dda8-4c93-909b-cdc99b1d50cb', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ed9ed524-ace7-4e8f-831d-f9afe6fc1812', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ed9ed524-ace7-4e8f-831d-f9afe6fc1812', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ede9ce0c-1d22-49d6-a995-208f49ef89c3', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ede9ce0c-1d22-49d6-a995-208f49ef89c3', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ee05cd56-783f-48e2-b2a5-3134c3b55c37', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ee05cd56-783f-48e2-b2a5-3134c3b55c37', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ef4f083e-929a-4e18-8757-cd4e398e0d3c', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ef4f083e-929a-4e18-8757-cd4e398e0d3c', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f1bbd9af-c033-45d5-82bc-b45fff0e4248', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f1bbd9af-c033-45d5-82bc-b45fff0e4248', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f1bd14a2-40f6-419e-9d08-589c611f57bb', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f1bd14a2-40f6-419e-9d08-589c611f57bb', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f2158552-ce7a-43c0-a13d-1da8103a5a5b', 'limits_at_infinity') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f2158552-ce7a-43c0-a13d-1da8103a5a5b', 'limit_laws') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f31cc2b4-fa53-4012-aa37-73263175e165', 'squeeze_theorem') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f31cc2b4-fa53-4012-aa37-73263175e165', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f3ddbcd3-9929-4fd9-9fdd-065e17da100d', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f3ddbcd3-9929-4fd9-9fdd-065e17da100d', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f60e26b6-b238-4d1c-9540-5174ebd4f98f', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f60e26b6-b238-4d1c-9540-5174ebd4f98f', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f625c885-89ec-4710-97bd-12c5b697f4be', 'limit_estimation_table') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f625c885-89ec-4710-97bd-12c5b697f4be', 'limit_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f7736271-34ba-4f37-a844-c69297d05892', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f7736271-34ba-4f37-a844-c69297d05892', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f7c82732-afba-4e9f-90b2-a2b9686812f1', 'algebraic_simplification') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f7c82732-afba-4e9f-90b2-a2b9686812f1', 'continuity_concept') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f974bbf4-173d-4d31-93e6-03f39cb216e6', 'limit_notation') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('f974bbf4-173d-4d31-93e6-03f39cb216e6', 'method_selection') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fd68ffa8-f867-472f-b04d-7e9298e31aec', 'ivt_application') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('fd68ffa8-f867-472f-b04d-7e9298e31aec', 'discontinuity_types') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ffa99911-ca73-4e4e-8871-d43eac06be80', 'limit_estimation_graph') ON CONFLICT DO NOTHING;
INSERT INTO question_skills (question_id, skill_id) VALUES ('ffa99911-ca73-4e4e-8871-d43eac06be80', 'one_sided_from_data') ON CONFLICT DO NOTHING;

-- PHASE 3: Update Questions Table (Semantic Version)
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Uses unit1_UT_Q4_graph.png Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"discontinuity_types","limit_estimation_graph"}', 
    error_tags = '{"graph_jump_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '0015173b-cc1a-4da5-9bd2-4c6aaeecd720';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Ch 1.5 substitution (CORRECT OPTION FIX APPLIED) Text and Image.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws","algebraic_simplification"}', 
    error_tags = '{"illegal_substitution_0over0"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '029895ae-b361-44f1-b162-e391e6578fe0';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limits_at_infinity","infinite_limits_asymptotes"}', 
    error_tags = '{"asymptote_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '051cdc2e-fd06-4eb2-b3b1-ba75e807a64a';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","B":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","continuity_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '09af0e9c-0e94-4178-8e99-19821f5bb9bd';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"avg_vs_instant_rate","limit_concept"}', 
    error_tags = '{"average_vs_instant"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '0d6904ae-a190-4330-bed2-615431a5bc48';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","B":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","C":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","limit_laws"}', 
    error_tags = '{"squeeze_bounds_incorrect"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '0f685f6a-9fcd-4555-afd2-03d2b1a2e899';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Connects Unit 1 to derivative definition',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"derivative_definition","algebraic_simplification"}', 
    error_tags = '{"difference_quotient_wrong_limit"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '11ae027c-0215-4834-aa74-0e88e3ca6b6b';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Text and Image.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limit_notation"}', 
    error_tags = '{"table_trend_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '140e8637-cefb-4071-961f-dd01e9627f51';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Ch 1.13 removable discontinuity / extension',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_concept"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '141ebcb4-37bf-41f0-9a6a-3c5a0c9860e3';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_laws"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '1d1df4d4-390a-4763-98ee-9a9154aa7101';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","avg_vs_instant_rate"}', 
    error_tags = '{"table_trend_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '206da2ab-d968-47a0-b06f-a2d64a795e69';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws","method_selection"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '26c57f87-799d-4e6a-a786-96f77b64d5c9';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","algebraic_simplification"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '28b9e55f-47cd-4797-b14b-127f3656400b';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limits_at_infinity","limit_laws"}', 
    error_tags = '{"infinity_degree_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '34b950cd-3e01-4236-acf4-9985a39744bf';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '3e778fee-ed46-4ce9-9957-0f98aab05d85';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"limit_estimation_table","limit_notation"}', 
    error_tags = '{"two_sided_requires_match"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '42aacaf5-0631-49b3-ae54-46805526a3ac';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_table"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '45053b2f-bb1a-40db-ba92-8b4cb8d8b544';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","B":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"asymptote_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4a20b9f3-7002-470a-b576-e8a4850d729c';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"conjugate_rationalization","algebraic_simplification"}', 
    error_tags = '{"conjugate_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4ab23ec2-7fee-4ecc-a197-8b7d7573d46d';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","discontinuity_types"}', 
    error_tags = '{"endpoint_domain_issue"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4b832987-d059-4273-9bd7-131e14f980f8';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Ch 1.6 conjugate',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","C":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"conjugate_rationalization","method_selection"}', 
    error_tags = '{"conjugate_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4be50f42-dfe8-46b0-a397-ce4bcb1d0402';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"asymptote_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4dc9f63b-711d-4eeb-9893-07dfc03a2b71';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"discontinuity_types","limit_estimation_graph"}', 
    error_tags = '{"open_vs_closed_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '4fcdb293-25e2-46f2-b889-0899197211c0';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","method_selection"}', 
    error_tags = '{"illegal_substitution_0over0"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '51448cae-3144-4bde-b809-392cdfe4dfa2';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","method_selection"}', 
    error_tags = '{"factor_cancel_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '517f0d4c-d735-47fc-bbac-90231c61b275';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Ch 1.10/1.11 limit vs value',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_concept","limit_laws"}', 
    error_tags = '{"limit_vs_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '54582b8f-de15-48cd-8f11-af7480321207';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_graph","continuity_concept"}', 
    error_tags = '{"limit_vs_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5692b215-8191-4b07-be69-fcc4c13f11a2';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws","limit_concept"}', 
    error_tags = '{"quotient_law_denominator_zero"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '5f960cac-a4ff-458c-a372-995fcb81d7f9';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"limit_estimation_graph","limit_concept"}', 
    error_tags = '{"graph_jump_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '603adacd-60af-4530-822d-09a41b3dfc9c';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Fix: correct answer APPLIED (B=1)',
    weight_primary = 1,
    weight_supporting = 0,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","B":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","C":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws"}', 
    error_tags = '{"quotient_law_denominator_zero"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6437c89c-ffff-4f06-84e7-db84847b05dd';
UPDATE questions SET
    target_time_seconds = 60,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","limit_laws"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '657988f9-e8d7-4cea-b466-87dcff445639';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_concept"}', 
    error_tags = '{"interval_continuity_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6a70ff57-aff2-4d70-ad1e-1e4eabdb2f7b';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","continuity_concept"}', 
    error_tags = '{"factor_cancel_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6d17abb7-94c3-4b6c-8645-61f01c7c0d9d';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","B":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","limit_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '6f768c3d-dd63-41ea-9c26-5eb51354e217';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '7411bef6-0477-4631-924b-b38afc3d2ecb';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"discontinuity_types","limit_concept"}', 
    error_tags = '{"two_sided_requires_match"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '7e1b0164-2ec4-4bad-ad4e-3b65aec2534b';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","algebraic_simplification"}', 
    error_tags = '{"illegal_substitution_0over0"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '7e5e4219-1a50-4b7c-8f66-caf8a4aca5db';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","B":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","C":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","limit_concept"}', 
    error_tags = '{"squeeze_bounds_incorrect"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '878f40cf-d90f-4112-a418-15a46a710606';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Uses unit1_UT_Q18_graph.png Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","B":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","C":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","limit_estimation_graph"}', 
    error_tags = '{"squeeze_bounds_incorrect"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '89417aeb-e2c3-4535-940c-1b4d2484e9c0';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_graph","discontinuity_types"}', 
    error_tags = '{"open_vs_closed_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8a0ad35f-00a0-488e-875e-e3cc3be3279e';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","conjugate_rationalization"}', 
    error_tags = '{"conjugate_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8a284217-7c14-4f3b-876f-f2d56e95ca85';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_concept"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8acd8514-e063-407b-8559-b87300662014';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"derivative_definition","discontinuity_types"}', 
    error_tags = '{"two_sided_requires_match"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8c4724a4-1bdf-4c88-a925-cdf2a9f9ccad';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Ch 1.2 limit notation',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_notation","limit_concept"}', 
    error_tags = '{"notation_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '8f5c5672-f562-453c-802c-d79b2c05185f';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","C":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","limit_laws"}', 
    error_tags = '{"quotient_law_denominator_zero"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '93cff0de-5d7c-40ed-8492-2b741df23cad';
UPDATE questions SET
    target_time_seconds = 140,
    notes = 'Ch 1.15 end behavior + strategy',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","limits_at_infinity"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '97146b56-a7f9-43b4-a468-97e60063dc7d';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Ch 1.1 average rate',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"avg_vs_instant_rate","limit_concept"}', 
    error_tags = '{"average_vs_instant"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '9823692e-26d8-4e6d-9d33-9eeed60e4ff3';
UPDATE questions SET
    target_time_seconds = 60,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_notation","limit_concept"}', 
    error_tags = '{"notation_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '98fa533e-edaf-4c99-bee2-5d9df04aa0ac';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limit_notation"}', 
    error_tags = '{"one_sided_from_data"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '995d20ab-7ad4-4fc2-aa05-06031445ebb2';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limit_concept"}', 
    error_tags = '{"limit_vs_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = '9b8a1428-e64e-4826-93cf-3167497f581d';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Ch 1.9 synthesis (one-sided)',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","D":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value."}',
    skill_tags = '{"limit_concept","method_selection"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a2ee2cd1-6734-4fcc-8665-ec0e3d3dabd2';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Ch 1.7 strategy selection',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","limit_laws"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a3d4039d-b209-4027-9fd1-093c022401d0';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.7,
    weight_supporting = 0.3,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"derivative_definition","conjugate_rationalization"}', 
    error_tags = '{"conjugate_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a42d9d06-35ba-410c-95ba-7f036ef1a11b';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","algebraic_simplification"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a42f296d-1ba8-4e0b-a145-62988c59870c';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","algebraic_simplification"}', 
    error_tags = '{"quotient_law_denominator_zero"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a621e024-4133-4c53-aa01-043d473c67fd';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_graph","discontinuity_types"}', 
    error_tags = '{"open_vs_closed_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'a6e38b84-164f-47d8-9795-57aebf867316';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws","limit_notation"}', 
    error_tags = '{"limit_vs_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'aaecf8d8-17f7-446d-938e-2c6bdebacde1';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","B":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","C":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","limit_concept"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ad9b29d7-485b-43d8-956c-8770a3f580c5';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_graph","limit_concept"}', 
    error_tags = '{"endpoint_domain_issue"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'adc81ac2-cfc7-4e33-b3df-345b6e79ae16';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limits_at_infinity"}', 
    error_tags = '{"table_trend_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'aec34f1c-1ed9-4dd8-a80a-eae2e091722e';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b06360c6-c478-442e-956b-41b946d58257';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_concept"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b0fb72ce-126e-4c41-96e9-dcf4f96e3af0';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","B":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","C":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","limit_concept"}', 
    error_tags = '{"squeeze_bounds_incorrect"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'b47292a2-5ca2-486b-af57-cabf8ff5f4fe';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Uses unit1_UT_Q12_graph.png (Ch 1.14) Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ba9b6523-8207-4cae-8cc6-7d1955a32c07';
UPDATE questions SET
    target_time_seconds = 140,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","B":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_notation"}', 
    error_tags = '{"notation_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c351da6f-a1c7-4cc5-aa9f-efed76b3930b';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","B":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","continuity_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c89d6f58-94bb-4419-b946-51a74f246164';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","B":"Correct. Vertical asymptotes occur where the function value goes to infinity, while horizontal asymptotes occur as the variable approaches infinity.","C":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point).","D":"Incorrect. Distinguish between horizontal asymptotes (behavior at infinity) and vertical asymptotes (infinite growth at a single point)."}',
    skill_tags = '{"infinite_limits_asymptotes","limit_estimation_graph"}', 
    error_tags = '{"asymptote_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'c9f2ebf0-c91a-48ed-af89-cb117b185b75';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","continuity_concept"}', 
    error_tags = '{"limit_vs_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'cb4e1f66-2fc1-4ec8-a37a-16d6371fab80';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"avg_vs_instant_rate","method_selection"}', 
    error_tags = '{"difference_quotient_wrong_limit"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'cb96d608-8cf3-4653-862d-037e39493960';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","discontinuity_types"}', 
    error_tags = '{"factor_cancel_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'cd685f61-7b8b-4bb8-b637-349deaf4d681';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Ch 1.15 end behavior',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limits_at_infinity","limit_laws"}', 
    error_tags = '{"infinity_degree_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ce84ec70-73b1-459c-b382-a3d6f599ab60';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_estimation_graph"}', 
    error_tags = '{"endpoint_domain_issue"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd3ca74be-e13a-4e47-ad7d-137bdbdbc842';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","infinite_limits_asymptotes"}', 
    error_tags = '{"infinite_limit_meaning"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'd5394b68-91d3-431f-b00b-49be645f13fe';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limits_at_infinity","method_selection"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'dcfc4e82-0e48-4eba-81f2-0b0d75e0f9a4';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"limit_estimation_graph","discontinuity_types"}', 
    error_tags = '{"graph_jump_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ddab50a0-a3fc-4ea4-910d-0b38bf5de730';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"discontinuity_types","limit_estimation_graph"}', 
    error_tags = '{"open_vs_closed_point"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'dea4fa4e-088e-42cb-a25e-bd633e8871c3';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Ch 1.8 squeeze theorem',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","B":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","C":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","limit_concept"}', 
    error_tags = '{"squeeze_bounds_incorrect"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e1e8385f-557c-49d4-bd29-b5180bf2f599';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Correct. This option aligns with the definitions and laws of limits and continuity.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limit_concept"}', 
    error_tags = '{"table_trend_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e432e2fb-7cd6-4257-bbb4-d503e8ca9056';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Ch 1.16 IVT',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","B":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","continuity_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e75e1786-e15d-43b8-a759-038b5d77adc5';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Uses unit1_UT_Q7_table.png',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limit_concept"}', 
    error_tags = '{"table_trend_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'e8484a49-598c-464e-8765-9bba307a9337';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"conjugate_rationalization","method_selection"}', 
    error_tags = '{"conjugate_setup_error"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ea511a78-2b62-4d07-9573-a16f6180335a';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Correct. This option aligns with the definitions and laws of limits and continuity.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_notation","algebraic_simplification"}', 
    error_tags = '{"limit_vs_value"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ead92a67-4eb0-42af-8f2f-0dd065eb3f56';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_concept"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ebdcf9bf-cc03-4b4e-ba2d-49dc62e535c9';
UPDATE questions SET
    target_time_seconds = 120,
    notes = 'Ch 1.6 / derivative setup (CORRECT OPTION FIX APPLIED)',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","limit_laws"}', 
    error_tags = '{"difference_quotient_wrong_limit"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ec27c3b6-dda8-4c93-909b-cdc99b1d50cb';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","B":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","C":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws","method_selection"}', 
    error_tags = '{"illegal_substitution_0over0"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ed9ed524-ace7-4e8f-831d-f9afe6fc1812';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","limit_notation"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ede9ce0c-1d22-49d6-a995-208f49ef89c3';
UPDATE questions SET
    target_time_seconds = 60,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","B":"Correct. Based on the definition of a limit, as the variable approaches a value, the left and right limits must be equal and approach a unique finite value.","C":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification.","D":"Incorrect. Please check if the left-hand and right-hand limits agree, or if there is an indeterminate form (like 0/0) requiring simplification."}',
    skill_tags = '{"limit_laws","limit_notation"}', 
    error_tags = '{"notation_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ee05cd56-783f-48e2-b2a5-3134c3b55c37';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"method_selection","limits_at_infinity"}', 
    error_tags = '{"infinity_degree_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ef4f083e-929a-4e18-8757-cd4e398e0d3c';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.9,
    weight_supporting = 0.1,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","B":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","algebraic_simplification"}', 
    error_tags = '{"continuity_three_conditions_miss"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f1bbd9af-c033-45d5-82bc-b45fff0e4248';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","B":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","continuity_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f1bd14a2-40f6-419e-9d08-589c611f57bb';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limits_at_infinity","limit_laws"}', 
    error_tags = '{"infinity_degree_mistake"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f2158552-ce7a-43c0-a13d-1da8103a5a5b';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Squeeze Theorem states that if a function is bounded by two others that approach the same limit, the middle function must also approach that limit.","B":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","C":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest.","D":"Incorrect. The Squeeze Theorem requires the bounding functions to have identical limits at the point of interest."}',
    skill_tags = '{"squeeze_theorem","method_selection"}', 
    error_tags = '{"wrong_method_choice"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f31cc2b4-fa53-4012-aa37-73263175e165';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","B":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","continuity_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f3ddbcd3-9929-4fd9-9fdd-065e17da100d';
UPDATE questions SET
    target_time_seconds = 100,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","B":"Correct. A function is continuous at a point if the limit exists, the function value exists, and the limit value equals the function value.","C":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal.","D":"Incorrect. Continuity requires three things: the limit exists, f(a) exists, and they are equal."}',
    skill_tags = '{"continuity_concept","discontinuity_types"}', 
    error_tags = '{"interval_continuity_confusion"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f60e26b6-b238-4d1c-9540-5174ebd4f98f';
UPDATE questions SET
    target_time_seconds = 80,
    notes = 'Text and Image.',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text_and_image',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Correct. This option aligns with the definitions and laws of limits and continuity.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems."}',
    skill_tags = '{"limit_estimation_table","limit_concept"}', 
    error_tags = '{"table_trend_misread"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f625c885-89ec-4710-97bd-12c5b697f4be';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","B":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","C":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","continuity_concept"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f7736271-34ba-4f37-a844-c69297d05892';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","B":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions.","C":"Correct. For a 0/0 indeterminate form, limits can be found by factoring, canceling common terms, or rationalizing the numerator/denominator.","D":"Incorrect. Please double-check your algebraic steps, especially when expanding conjugates or simplifying complex fractions."}',
    skill_tags = '{"algebraic_simplification","continuity_concept"}', 
    error_tags = '{"quotient_law_denominator_zero"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f7c82732-afba-4e9f-90b2-a2b9686812f1';
UPDATE questions SET
    target_time_seconds = 80,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"limit_notation","method_selection"}', 
    error_tags = '{"two_sided_requires_match"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'f974bbf4-173d-4d31-93e6-03f39cb216e6';
UPDATE questions SET
    target_time_seconds = 120,
    notes = NULL,
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","B":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b].","C":"Correct. The Intermediate Value Theorem (IVT) states that if a continuous function takes different values at the ends of an interval, it must take all values in between.","D":"Incorrect. To apply IVT, the function must be continuous on the closed interval [a, b]."}',
    skill_tags = '{"ivt_application","discontinuity_types"}', 
    error_tags = '{"ivt_missing_continuity"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'fd68ffa8-f867-472f-b04d-7e9298e31aec';
UPDATE questions SET
    target_time_seconds = 100,
    notes = 'Ch 1.3 two-sided from graph (Q4 graph file)',
    weight_primary = 0.8,
    weight_supporting = 0.2,
    prompt_type = 'text',
    micro_explanations = '{"A":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","B":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","C":"Incorrect. This option does not satisfy the requirements of limit existence or relevant theorems.","D":"Correct. This option aligns with the definitions and laws of limits and continuity."}',
    skill_tags = '{"limit_estimation_graph","one_sided_from_data"}', 
    error_tags = '{"two_sided_requires_match"}',
    tolerance = 0.001,
    updated_at = NOW()
WHERE id = 'ffa99911-ca73-4e4e-8871-d43eac06be80';

COMMIT;
