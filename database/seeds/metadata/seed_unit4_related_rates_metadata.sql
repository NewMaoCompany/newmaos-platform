-- Insert Skills and Error Tags for Unit 4 (Related Rates)
-- Unit: ABBC_Applications / 4.4 and 4.5

-- ============================================================
-- SKILLS
-- ============================================================
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
-- 4.4 Skills
('related_rates_identify_variables', 'Identifying Variables in Related Rates', 'ABBC_Applications', '{derivative_meaning_context}'),
('related_rates_differentiate_time', 'Differentiating with Respect to Time', 'ABBC_Applications', '{chain_rule}'),
('related_rates_common_mistakes', 'Avoiding Common Related Rates Errors', 'ABBC_Applications', '{related_rates_differentiate_time}'),
('related_rates_geometry_cone', 'Related Rates: Cone Problems', 'ABBC_Applications', '{related_rates_identify_variables}'),
('related_rates_units_signs', 'Managing Units and Signs in Rates', 'ABBC_Applications', '{derivative_meaning_context}'),
-- 4.5 Skills
('related_rates_solve_strategy', 'Related Rates Solution Strategy', 'ABBC_Applications', '{related_rates_identify_variables}'),
('related_rates_ladder', 'Related Rates: Ladder Problems', 'ABBC_Applications', '{pythagorean_theorem}'),
('related_rates_geometry_sphere', 'Related Rates: Sphere Problems', 'ABBC_Applications', '{related_rates_identify_variables}'),
('related_rates_chain_rule', 'Chain Rule in Related Rates', 'ABBC_Applications', '{chain_rule}'),
-- Method Selection (General)
('method_selection_unit4', 'Selecting Procedures for Contextual Applications', 'ABBC_Applications', '{}'),
('units_analysis', 'Dimensional Analysis', 'ABBC_Applications', '{}')
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name, unit = EXCLUDED.unit;

-- ============================================================
-- ERROR TAGS
-- ============================================================
-- Fixed Schema: id, name, category, severity, unit (Removed description/remediation)
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('missing_related_variables', 'Missing Related Variables', 'Conceptual', 3, 'ABBC_Applications'),
('differentiate_wrt_wrong_variable', 'Differentiation Variable Error', 'Procedural', 4, 'ABBC_Applications'),
('plug_in_before_diff_error', 'Substituted Too Early', 'Conceptual', 5, 'ABBC_Applications'),
('missing_geometry_relation', 'Missing Geometric Formula', 'Conceptual', 4, 'ABBC_Applications'),
('sign_error_rate_direction', 'Sign Error (Rate Direction)', 'Validation', 3, 'ABBC_Applications'),
('wrong_method_choice_unit4', 'Wrong Method Choice', 'Strategy', 3, 'ABBC_Applications'),
('unit_conversion_error', 'Unit Conversion Error', 'Detailed', 2, 'ABBC_Applications'),
('missing_chain_rule_related_rates', 'Missing Chain Rule', 'Procedural', 4, 'ABBC_Applications'),
('missing_differentiate_time', 'Forgot to Differentiate Time', 'Procedural', 4, 'ABBC_Applications')
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name, category = EXCLUDED.category, severity = EXCLUDED.severity;
