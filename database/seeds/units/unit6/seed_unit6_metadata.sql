-- Mass Insert Script for Unit 6 Skills and Error Tags
-- Generated based on user request (Unit 6: Integration)
-- Target Unit ID: ABBC_Integration

-- 1. Schema Migration: Ensure skills has 'prerequisites' column (Standard check)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'skills' AND column_name = 'prerequisites') THEN
        ALTER TABLE public.skills ADD COLUMN prerequisites text[];
    END IF;
END $$;

-- 2. Insert Skills (Unit 6)
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('accumulation_concept', 'Accumulation of Change (Net vs Total Change)', 'ABBC_Integration', '{}'),
('area_under_curve_interpretation', 'Interpreting Area Under a Rate Graph (Units/Meaning)', 'ABBC_Integration', '{"accumulation_concept"}'),
('riemann_sum_setup', 'Riemann Sum Setup (Left/Right/Midpoint, Δx, Subintervals)', 'ABBC_Integration', '{}'),
('riemann_sum_approximation', 'Approximating Definite Integrals with Riemann Sums', 'ABBC_Integration', '{"riemann_sum_setup"}'),
('riemann_sum_from_table', 'Riemann Sums from Tables/Data (Unequal Intervals)', 'ABBC_Integration', '{"riemann_sum_setup"}'),
('riemann_sum_from_graph', 'Riemann Sums from Graphs (Heights/Signs)', 'ABBC_Integration', '{"riemann_sum_setup"}'),
('summation_notation_sigma', 'Summation Notation (Sigma) Interpretation', 'ABBC_Integration', '{}'),
('definite_integral_notation', 'Definite Integral Notation (Bounds, Variable, Meaning)', 'ABBC_Integration', '{"summation_notation_sigma"}'),
('link_riemann_to_integral', 'Connecting Riemann Sums, Sigma Form, and Definite Integral', 'ABBC_Integration', '{"riemann_sum_setup", "definite_integral_notation"}'),
('ftc1_accumulation_function', 'FTC Part 1 (Accumulation Function as Integral of a Rate)', 'ABBC_Integration', '{"definite_integral_notation"}'),
('accumulation_from_variable_limit', 'Derivative of an Accumulation Function (Variable Upper Limit)', 'ABBC_Integration', '{"ftc1_accumulation_function"}'),
('accumulation_behavior_analysis', 'Behavior of Accumulation Functions (Inc/Dec, Extrema, Concavity)', 'ABBC_Integration', '{"accumulation_from_variable_limit"}'),
('integral_properties_basic', 'Properties of Definite Integrals (Additivity, Reversal, Scaling)', 'ABBC_Integration', '{"definite_integral_notation"}'),
('integral_symmetry_even_odd', 'Symmetry with Even/Odd Integrands on Symmetric Intervals', 'ABBC_Integration', '{"integral_properties_basic"}'),
('integral_total_vs_net_area', 'Net Area vs Total Area Using Integrals and Absolute Value', 'ABBC_Integration', '{"area_under_curve_interpretation"}'),
('ftc2_evaluate_integral', 'FTC Part 2 (Evaluate Definite Integral via Antiderivative)', 'ABBC_Integration', '{"definite_integral_notation"}'),
('antiderivative_basic_rules', 'Finding Antiderivatives (Basic Rules and Notation)', 'ABBC_Integration', '{}'),
('indefinite_integral_notation', 'Indefinite Integrals (Constant of Integration + Meaning)', 'ABBC_Integration', '{"antiderivative_basic_rules"}'),
('u_substitution_setup', 'u-Substitution Setup (Recognize Pattern, Choose u)', 'ABBC_Integration', '{"antiderivative_basic_rules"}'),
('u_substitution_limits', 'u-Substitution with Definite Integrals (Change Limits vs Back-Substitute)', 'ABBC_Integration', '{"u_substitution_setup", "ftc2_evaluate_integral"}'),
('algebraic_prep_long_division', 'Algebraic Preparation: Long Division Before Integrating', 'ABBC_Integration', '{"antiderivative_basic_rules"}'),
('algebraic_prep_complete_square', 'Algebraic Preparation: Completing the Square Before Integrating', 'ABBC_Integration', '{"antiderivative_basic_rules"}'),
('technique_selection_antidiff', 'Selecting Techniques for Antidifferentiation (Rules vs Substitution vs Algebra Prep)', 'ABBC_Integration', '{"u_substitution_setup", "algebraic_prep_long_division", "algebraic_prep_complete_square"}'),
('units_and_context_integrals', 'Interpreting Integral Results in Context (Units, Meaning, Reasonableness)', 'ABBC_Integration', '{"area_under_curve_interpretation"}'),
('area_as_integral_from_graph', 'Approximating Definite Integral from Graph using Geometry', 'ABBC_Integration', '{"area_under_curve_interpretation"}'),
('riemann_sum_interpretation', 'conceptual Understanding of Riemann Sums (Accuracy, Convergence)', 'ABBC_Integration', '{"riemann_sum_approximation"}'),
('method_selection_unit6', 'Selecting Integration Techniques (General Strategy)', 'ABBC_Integration', '{"technique_selection_antidiff"}'),
('ftc1_derivative_of_accumulation', 'Derivative of Accumulation Function (FTC1)', 'ABBC_Integration', '{"ftc1_accumulation_function"}'),
('accumulation_function_from_graph', 'Analyzing Accumulation Function from Rate Graph', 'ABBC_Integration', '{"area_under_curve_interpretation"}'),
('ftc1_chain_inside', 'FTC1 with Chain Rule (Variable Upper Limit)', 'ABBC_Integration', '{"accumulation_from_variable_limit"}'),
('recover_f_from_accumulation_graph', 'Recovering Rate Function Value from Accumulation Graph Slope', 'ABBC_Integration', '{"ftc1_derivative_of_accumulation"}'),
('accumulation_function_behavior', 'Behavior of Accumulation Functions (Inc/Dec/Concavity)', 'ABBC_Integration', '{"accumulation_behavior_analysis"}'),
('net_change_from_integral', 'Calculating Net Change using Definite Integral', 'ABBC_Integration', '{"accumulation_concept"}'),
('accumulation_from_table_trapezoid', 'Accumulation from Table using Trapezoidal Rule', 'ABBC_Integration', '{"riemann_sum_from_table"}')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;

-- 3. Insert Error Tags (Unit 6)
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('net_vs_total_change_confusion', 'Confusing Net Change with Total Change', 'Accumulation', 3, 'ABBC_Integration'),
('area_sign_misread', 'Misreading Sign of Area (Above/Below Axis)', 'Accumulation', 3, 'ABBC_Integration'),
('units_not_interpreted', 'Not Interpreting Units of Integral/Rate Correctly', 'Context', 3, 'ABBC_Integration'),
('delta_x_wrong', 'Incorrect Δx (Wrong Interval Length / Subinterval Count)', 'Riemann Sums', 4, 'ABBC_Integration'),
('sample_point_wrong', 'Wrong Sample Point Choice (Left/Right/Midpoint Misapplied)', 'Riemann Sums', 3, 'ABBC_Integration'),
('table_interval_misuse', 'Incorrect Use of Table Intervals (Unequal Widths Ignored)', 'Riemann Sums', 4, 'ABBC_Integration'),
('riemann_sum_arithmetic_error', 'Arithmetic/Organization Error in Riemann Sum Computation', 'Riemann Sums', 2, 'ABBC_Integration'),
('sigma_bounds_misread', 'Misreading Sigma Bounds or Indexing', 'Sigma Notation', 3, 'ABBC_Integration'),
('sigma_expression_mismatch', 'Incorrect Term Expression in Sigma Form (Wrong Input Pattern)', 'Sigma Notation', 4, 'ABBC_Integration'),
('integral_bounds_reversal_error', 'Forgetting Bound Reversal Changes Sign', 'Integral Properties', 3, 'ABBC_Integration'),
('integral_additivity_error', 'Additivity Error When Splitting/Combining Intervals', 'Integral Properties', 3, 'ABBC_Integration'),
('symmetry_even_odd_misuse', 'Misusing Even/Odd Symmetry Rules', 'Integral Properties', 3, 'ABBC_Integration'),
('ftc1_as_area_only', 'Treating Accumulation Function as Pure Geometry (Ignoring Sign/Rate Meaning)', 'FTC / Accumulation', 3, 'ABBC_Integration'),
('accumulation_derivative_wrong_variable', 'FTC1 Derivative Error (Wrong Variable / Not Applying Variable Limit Idea)', 'FTC / Accumulation', 4, 'ABBC_Integration'),
('accumulation_chain_rule_missing', 'Missing Chain Rule Factor in Accumulation Derivative', 'FTC / Accumulation', 4, 'ABBC_Integration'),
('accumulation_behavior_misread', 'Incorrect Inc/Dec or Concavity Conclusions for Accumulation Function', 'Accumulation Functions', 3, 'ABBC_Integration'),
('ftc2_antiderivative_not_used', 'Not Using Antiderivative Correctly to Evaluate a Definite Integral', 'FTC / Evaluation', 3, 'ABBC_Integration'),
('antiderivative_constant_missing', 'Forgetting Constant of Integration (Indefinite Integrals)', 'Antiderivatives', 3, 'ABBC_Integration'),
('power_rule_antiderivative_error', 'Basic Antiderivative Rule Error (Exponents/Constants)', 'Antiderivatives', 3, 'ABBC_Integration'),
('u_choice_poor', 'Poor/Incorrect Choice of u in Substitution', 'Substitution', 4, 'ABBC_Integration'),
('du_missing_factor', 'Missing Factor When Converting dx to du', 'Substitution', 4, 'ABBC_Integration'),
('u_limits_not_changed_or_mixed', 'Mixing u-Limits with x-Expression (Limits Not Changed or Inconsistently Handled)', 'Substitution', 3, 'ABBC_Integration'),
('long_division_skipped', 'Skipping Long Division When Needed Before Integrating', 'Algebra Prep', 3, 'ABBC_Integration'),
('complete_square_incorrect', 'Completing the Square Incorrectly Before Integrating', 'Algebra Prep', 3, 'ABBC_Integration'),
('wrong_method_choice_unit6', 'Wrong Method Choice (Riemann vs FTC vs Properties vs Substitution)', 'Strategy', 3, 'ABBC_Integration')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;
