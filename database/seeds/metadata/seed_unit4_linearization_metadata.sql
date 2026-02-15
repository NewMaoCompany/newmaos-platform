-- Insert Skills and Error Tags for Unit 4.6 and 4.7
-- Unit: ABBC_Applications / 4.6 (Linearization) and 4.7 (L'Hospital)

-- ============================================================
-- SKILLS
-- ============================================================
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
-- 4.6 Skills (Linearization)
('local_linearity_concept', 'Concept of Local Linearity', 'ABBC_Applications', '{derivative_definition}'),
('linearization_build_tangent', 'Building a Linear Approximation', 'ABBC_Applications', '{point_slope_form}'),
('linearization_numeric_estimate', 'Estimating Values using Linearization', 'ABBC_Applications', '{linearization_build_tangent}'),
('differential_error_estimate', 'Estimating Error with Differentials', 'ABBC_Applications', '{linearization_concept}'),
('linearization_interpret_table', 'Interpreting Linearization Tables', 'ABBC_Applications', '{linearization_numeric_estimate}'),

-- 4.7 Skills (L'Hospital's Rule)
('lhospital_identify_indeterminate', 'Identifying Indeterminate Forms', 'ABBC_Applications', '{limits_algebraic}'),
('lhospital_apply_once', 'Applying L’Hospital’s Rule (Single)', 'ABBC_Applications', '{derivatives_basic}'),
('lhospital_repeat_application', 'Repeated Application of L’Hospital', 'ABBC_Applications', '{lhospital_apply_once}'),
('lhospital_rewrite_form', 'Rewriting for L’Hospital', 'ABBC_Applications', '{algebra_manipulation}'),
('lhospital_strategy_choice', 'Strategic use of L’Hospital', 'ABBC_Applications', '{lhospital_identify_indeterminate}')
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name, unit = EXCLUDED.unit;

-- ============================================================
-- ERROR TAGS
-- ============================================================
-- Schema: id, name, category, severity, unit
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
-- 4.6 Errors
('linearization_point_misuse', 'Misusing the Tangent Point', 'Conceptual', 3, 'ABBC_Applications'),
('tangent_slope_wrong_value', 'Incorrect Tangent Slope', 'Procedural', 4, 'ABBC_Applications'),
('linearization_far_from_point', 'Approximating Too Far from Point', 'Conceptual', 3, 'ABBC_Applications'),
('differential_sign_error', 'Sign Error in Differential', 'Validation', 3, 'ABBC_Applications'),
('units_mismatch_linearization', 'Units Mismatch in Linearization', 'Detailed', 2, 'ABBC_Applications'),

-- 4.7 Errors
('use_lhospital_wrong_form', 'L’Hospital on Wrong Form', 'Conceptual', 5, 'ABBC_Applications'),
('differentiate_only_numerator', 'Forgot to Differentiate Denominator', 'Procedural', 5, 'ABBC_Applications'),
('stop_too_early_lhospital', 'Stopped L’Hospital Too Early', 'Strategy', 4, 'ABBC_Applications'),
('rewrite_indeterminate_wrong', 'Incorrect Rewrite for Limits', 'Algebraic', 4, 'ABBC_Applications'),
('use_lhospital_when_algebra_easier', 'Inefficient Method Choice', 'Strategy', 2, 'ABBC_Applications')
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name, category = EXCLUDED.category, severity = EXCLUDED.severity;
