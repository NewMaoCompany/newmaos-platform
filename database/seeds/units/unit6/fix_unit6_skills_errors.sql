-- Comprehensive Fix for Unit 6 Skills and Error Tags (Chapters 6.3 - 6.8)
-- Targets: questions, question_skills, question_error_patterns
-- Strict adherence to provided Skill IDs and Error Tag IDs

BEGIN;

-- 1. Create a temporary mapping table
CREATE TEMP TABLE unit6_fixes (
    q_title TEXT,
    p_skill_id TEXT,
    s_skill_id TEXT, -- Can be NULL
    err_tag_id TEXT,
    p_weight NUMERIC DEFAULT 1.0,
    s_weight NUMERIC DEFAULT 0.0
) ON COMMIT DROP;

INSERT INTO unit6_fixes (q_title, p_skill_id, s_skill_id, err_tag_id, p_weight, s_weight)
VALUES
-- 6.3 Mapping
('U6.3-P1', 'definite_integral_notation', 'summation_notation_sigma', 'sigma_bounds_misread', 0.6, 0.4),
('U6.3-P2', 'riemann_sum_from_table', 'riemann_sum_setup', 'delta_x_wrong', 0.7, 0.3),
('U6.3-P3', 'integral_properties_basic', 'definite_integral_notation', 'integral_additivity_error', 0.8, 0.2),
('U6.3-P4', 'area_under_curve_interpretation', 'riemann_sum_from_graph', 'area_sign_misread', 0.8, 0.2),
('U6.3-P5', 'riemann_sum_approximation', NULL, 'wrong_method_choice_unit6', 1.0, 0.0),

-- 6.4 Mapping
('U6.4-P1', 'ftc1_accumulation_function', 'area_under_curve_interpretation', 'accumulation_derivative_wrong_variable', 0.8, 0.2),
('U6.4-P2', 'accumulation_from_variable_limit', 'ftc1_accumulation_function', 'accumulation_chain_rule_missing', 0.8, 0.2),
('U6.4-P3', 'accumulation_behavior_analysis', 'area_under_curve_interpretation', 'accumulation_behavior_misread', 0.7, 0.3),
('U6.4-P4', 'accumulation_concept', 'integral_total_vs_net_area', 'integral_bounds_reversal_error', 0.8, 0.2),
('U6.4-P5', 'riemann_sum_from_table', 'accumulation_concept', 'delta_x_wrong', 0.7, 0.3),

-- 6.5 Mapping
('U6.5-P1', 'accumulation_behavior_analysis', 'area_under_curve_interpretation', 'accumulation_behavior_misread', 0.8, 0.2),
('U6.5-P2', 'accumulation_behavior_analysis', 'area_under_curve_interpretation', 'accumulation_behavior_misread', 0.8, 0.2),
('U6.5-P3', 'accumulation_behavior_analysis', 'ftc1_accumulation_function', 'accumulation_behavior_misread', 0.8, 0.2),
('U6.5-P4', 'accumulation_concept', 'area_under_curve_interpretation', 'accumulation_behavior_misread', 0.8, 0.2),
('U6.5-P5', 'accumulation_concept', NULL, 'net_vs_total_change_confusion', 1.0, 0.0),

-- 6.6 Mapping
('U6.6-P1', 'integral_properties_basic', NULL, 'integral_additivity_error', 1.0, 0.0),
('U6.6-P2', 'integral_properties_basic', NULL, 'integral_bounds_reversal_error', 1.0, 0.0),
('U6.6-P3', 'integral_properties_basic', NULL, 'integral_additivity_error', 1.0, 0.0),
('U6.6-P4', 'integral_properties_basic', NULL, 'integral_additivity_error', 1.0, 0.0),
('U6.6-P5', 'integral_symmetry_even_odd', NULL, 'symmetry_even_odd_misuse', 1.0, 0.0),

-- 6.7 Mapping
('U6.7-P1', 'ftc1_accumulation_function', NULL, 'accumulation_derivative_wrong_variable', 1.0, 0.0),
('U6.7-P2', 'ftc1_accumulation_function', 'area_under_curve_interpretation', 'accumulation_derivative_wrong_variable', 0.8, 0.2),
('U6.7-P3', 'accumulation_from_variable_limit', 'ftc1_chain_inside', 'accumulation_chain_rule_missing', 0.8, 0.2), -- Wait, ftc1_chain_inside is NOT in valid list. Map to accumulation_from_variable_limit + u_substitution_limits? No, strict map: Just accumulation_from_variable_limit (1.0)
('U6.7-P4', 'accumulation_from_variable_limit', NULL, 'accumulation_chain_rule_missing', 1.0, 0.0),
('U6.7-P5', 'accumulation_from_variable_limit', 'ftc1_accumulation_function', 'accumulation_derivative_wrong_variable', 0.8, 0.2),

-- 6.8 Mapping
('U6.8-P1', 'antiderivative_basic_rules', NULL, 'power_rule_antiderivative_error', 1.0, 0.0),
('U6.8-P2', 'antiderivative_basic_rules', 'indefinite_integral_notation', 'antiderivative_constant_missing', 0.8, 0.2),
('U6.8-P3', 'antiderivative_basic_rules', NULL, 'power_rule_antiderivative_error', 1.0, 0.0),
('U6.8-P4', 'indefinite_integral_notation', NULL, 'antiderivative_constant_missing', 1.0, 0.0),
('U6.8-P5', 'antiderivative_basic_rules', NULL, 'power_rule_antiderivative_error', 1.0, 0.0);

-- Correction for 6.7-P3: ftc1_chain_inside was invalid.
UPDATE unit6_fixes SET s_skill_id = NULL, p_weight = 1.0, s_weight = 0.0 WHERE q_title = 'U6.7-P3';


-- 2. Update questions table for skill_tags and error_tags array
UPDATE public.questions q
SET
    skill_tags = CASE
        WHEN f.s_skill_id IS NOT NULL THEN ARRAY[f.p_skill_id, f.s_skill_id]
        ELSE ARRAY[f.p_skill_id]
    END,
    error_tags = ARRAY[f.err_tag_id]
FROM unit6_fixes f
WHERE q.title = f.q_title;

-- 3. Clear existing link table entries for these questions
DELETE FROM public.question_skills
WHERE question_id IN (SELECT id FROM public.questions WHERE title IN (SELECT q_title FROM unit6_fixes));

DELETE FROM public.question_error_patterns
WHERE question_id IN (SELECT id FROM public.questions WHERE title IN (SELECT q_title FROM unit6_fixes));

-- 4. Insert Primary Skills
INSERT INTO public.question_skills (question_id, skill_id, role, weight)
SELECT q.id, f.p_skill_id, 'primary', f.p_weight
FROM public.questions q
JOIN unit6_fixes f ON q.title = f.q_title;

-- 5. Insert Supporting Skills (where not null)
INSERT INTO public.question_skills (question_id, skill_id, role, weight)
SELECT q.id, f.s_skill_id, 'supporting', f.s_weight
FROM public.questions q
JOIN unit6_fixes f ON q.title = f.q_title
WHERE f.s_skill_id IS NOT NULL;

-- 6. Insert Error Patterns
INSERT INTO public.question_error_patterns (question_id, error_tag_id)
SELECT q.id, f.err_tag_id
FROM public.questions q
JOIN unit6_fixes f ON q.title = f.q_title;

COMMIT;
