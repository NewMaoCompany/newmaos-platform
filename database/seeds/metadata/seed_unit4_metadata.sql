-- Mass Insert Script for Unit 4 Skills and Error Tags
-- Generated based on user request (Unit 4: Contextual Applications)
-- Target Unit ID: ABBC_Applications

-- 1. Schema Migration: Ensure skills has 'prerequisites' column
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'skills' AND column_name = 'prerequisites') THEN
        ALTER TABLE public.skills ADD COLUMN prerequisites text[];
    END IF;
END $$;

-- 2. Cleanup (Optional: distinct unit cleanup, but ON CONFLICT handles the rest)
-- We keep this to clean up any strictly unit-bound items if we want to reset them, 
-- but we won't rely on it to clear IDs that might be shared.
DELETE FROM public.skills WHERE unit IN ('ABBC_Applications', 'Unit4_Contextual');
DELETE FROM public.error_tags WHERE unit IN ('ABBC_Applications', 'Unit4_Contextual');

-- 3. Insert Skills (Unit 4)
-- Using ON CONFLICT to handle skills that might already exist from other units
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('derivative_meaning_context', 'Meaning of the Derivative in Context (Rate, Units, Interpretation)', 'ABBC_Applications', '{}'),
('units_analysis', 'Units Analysis for Rates (Correct Units and Conversions)', 'ABBC_Applications', '{}'),
('interpret_graph_context', 'Interpreting Context from Graphs (Slope as Rate, Sign, Increasing/Decreasing)', 'ABBC_Applications', '{"derivative_meaning_context"}'),
('interpret_table_context', 'Interpreting Context from Tables (Average vs Instant Rate, Approximation)', 'ABBC_Applications', '{"derivative_meaning_context"}'),

('position_velocity_acceleration', 'Position–Velocity–Acceleration Relationships (Motion)', 'ABBC_Applications', '{}'),
('motion_sign_analysis', 'Motion Sign Analysis (Direction, Speeding Up/Slowing Down)', 'ABBC_Applications', '{"position_velocity_acceleration"}'),
('motion_turning_points', 'Motion Turning Points (When Velocity Changes Sign)', 'ABBC_Applications', '{"position_velocity_acceleration"}'),

('rates_non_motion', 'Rates of Change in Non-Motion Contexts (Growth/Decay/Cost/Volume)', 'ABBC_Applications', '{"derivative_meaning_context"}'),
('average_vs_instant_context', 'Average vs Instantaneous Rate in Context (Correct Interpretation)', 'ABBC_Applications', '{"derivative_meaning_context"}'),

('related_rates_setup', 'Related Rates Setup (Identify Variables and Relationship)', 'ABBC_Applications', '{}'),
('related_rates_differentiate', 'Related Rates Differentiate (Implicit Differentiation w.r.t. Time)', 'ABBC_Applications', '{"related_rates_setup"}'),
('related_rates_substitution', 'Related Rates Substitution (Plug Values After Differentiation)', 'ABBC_Applications', '{"related_rates_differentiate"}'),
('related_rates_geometry', 'Related Rates with Geometry (Pythagorean, Similar Triangles, Area/Volume)', 'ABBC_Applications', '{"related_rates_setup"}'),

('linearization_concept', 'Linearization Concept (Tangent Line Approximation)', 'ABBC_Applications', '{}'),
('local_linearity_estimation', 'Local Linearity Estimation (Approximate Values + Error Sense)', 'ABBC_Applications', '{"linearization_concept"}'),
('differentials_dy_dx', 'Differentials (dy, dx) and Approximation Usage', 'ABBC_Applications', '{"linearization_concept"}'),

('lhospital_indeterminate_forms', 'Identify Indeterminate Forms (0/0, ∞/∞) for L''Hospital', 'ABBC_Applications', '{}'),
('lhospital_apply', 'Apply L''Hospital’s Rule Correctly (Differentiate Numerator/Denominator)', 'ABBC_Applications', '{"lhospital_indeterminate_forms"}'),
('lhospital_recheck_form', 'Recheck Form After Applying L''Hospital (Repeat or Stop Appropriately)', 'ABBC_Applications', '{"lhospital_apply"}'),

('method_selection_unit4', 'Strategy Selection for Unit 4 (Interpretation vs RR vs Linearization vs L''Hospital)', 'ABBC_Applications', '{}'),

-- NEW SKILLS ADDED FOR UNIT TEST COMPATIBILITY
('average_rate_context', 'Average Rate of Change in Context', 'ABBC_Applications', '{"average_vs_instant_context"}'),
('acceleration_concept', 'Conceptual Understanding of Acceleration', 'ABBC_Applications', '{"position_velocity_acceleration"}'),
('motion_interpret_graph', 'Interpreting Motion Graphs (Pos/Vel/Acc)', 'ABBC_Applications', '{"interpret_graph_context"}'),
('rate_change_other_context', 'Rates of Change in General Contexts', 'ABBC_Applications', '{"rates_non_motion"}'),
('related_rates_identify_variables', 'Identify Variables in Related Rates', 'ABBC_Applications', '{"related_rates_setup"}'),
('related_rates_units_signs', 'Units and Signs in Related Rates', 'ABBC_Applications', '{"related_rates_setup"}'),
('rate_from_table_estimate', 'Estimating Rates from Tables', 'ABBC_Applications', '{"interpret_table_context"}'),
('local_linearity_concept', 'Concept of Local Linearity', 'ABBC_Applications', '{"linearization_concept"}'),
('linearization_build_tangent', 'Building Tangent Line for Linearization', 'ABBC_Applications', '{"linearization_concept"}'),
('related_rates_solve_strategy', 'Strategy for Solving Related Rates', 'ABBC_Applications', '{"related_rates_setup"}'),
('related_rates_differentiate_time', 'Differentiating w.r.t Time in Related Rates', 'ABBC_Applications', '{"related_rates_differentiate"}'),
('lhospital_identify_indeterminate', 'Identifying Indeterminate Forms for L''Hospital', 'ABBC_Applications', '{"lhospital_indeterminate_forms"}'),
('linearization_interpret_graph', 'Interpreting Linearization on Graphs', 'ABBC_Applications', '{"linearization_concept"}'),
('lhospital_apply_once', 'Single Application of L''Hospital''s Rule', 'ABBC_Applications', '{"lhospital_apply"}'),
('lhospital_repeat_application', 'Repeated Application of L''Hospital''s Rule', 'ABBC_Applications', '{"lhospital_recheck_form"}'),
('lhospital_rewrite_form', 'Rewriting Expressions for L''Hospital', 'ABBC_Applications', '{"lhospital_indeterminate_forms"}'),
('lhospital_strategy_choice', 'Strategic Choice for L''Hospital Limits', 'ABBC_Applications', '{"method_selection_unit4"}'),
('differential_error_estimate', 'Estimating Error with Differentials', 'ABBC_Applications', '{"differentials_dy_dx"}'),
('related_rates_chain_rule', 'Chain Rule in Related Rates', 'ABBC_Applications', '{"related_rates_differentiate"}'),
('related_rates_common_mistakes', 'Common Mistakes in Related Rates', 'ABBC_Applications', '{"related_rates_setup"}'),
('related_rates_geometry_cone', 'Related Rates: Cone Problems', 'ABBC_Applications', '{"related_rates_geometry"}'),
('related_rates_geometry_sphere', 'Related Rates: Sphere Problems', 'ABBC_Applications', '{"related_rates_geometry"}'),
('related_rates_ladder', 'Related Rates: Ladder Problems', 'ABBC_Applications', '{"related_rates_geometry"}'),
('linearization_numeric_estimate', 'Numeric Estimation using Linearization', 'ABBC_Applications', '{"local_linearity_estimation"}')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;


-- 4. Insert Error Tags (Unit 4)
-- Using ON CONFLICT to handle tags that might already exist from other units
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('units_missing_or_wrong', 'Missing or Incorrect Units in Final Answer', 'Units', 3, 'ABBC_Applications'),
('unit_conversion_error', 'Unit Conversion Error (Minutes/Hours, Feet/Miles, etc.)', 'Units', 3, 'ABBC_Applications'),
('units_mismatch_derivative', 'Units Mismatch in Derivative Interpretation', 'Units', 3, 'ABBC_Applications'),

('avg_vs_instant_confusion_context', 'Confusing Average Rate with Instantaneous Rate in Context', 'Interpretation', 3, 'ABBC_Applications'),
('average_rate_wrong_interval', 'Calculating Average Rate over Wrong Interval', 'Interpretation', 3, 'ABBC_Applications'),
('slope_sign_misread_context', 'Misreading Rate Sign (Increase vs Decrease) from Context/Graph', 'Interpretation', 3, 'ABBC_Applications'),
('graph_rate_misinterpretation', 'Interpreting Graph Incorrectly (Slope vs Height Confusion)', 'Graph Interpretation', 3, 'ABBC_Applications'),
('slope_sign_misread', 'Misreading Slope Sign on Graph', 'Graph Interpretation', 3, 'ABBC_Applications'),
('table_rate_estimate_wrong', 'Incorrect Rate Estimate from Table Data', 'Table Interpretation', 2, 'ABBC_Applications'),
('table_slope_estimate_error', 'Error Estimating Slope from Table', 'Table Interpretation', 2, 'ABBC_Applications'),

('velocity_position_confusion', 'Confusing Position and Velocity (Value vs Derivative)', 'Motion', 4, 'ABBC_Applications'),
('acceleration_velocity_confusion', 'Confusing Velocity and Acceleration (Derivative Level Error)', 'Motion', 4, 'ABBC_Applications'),
('mixing_velocity_acceleration', 'Mixing Properties of Velocity and Acceleration', 'Motion', 4, 'ABBC_Applications'),
('speed_vs_velocity_confusion', 'Confusing Speed with Velocity (Absolute Value Issue)', 'Motion', 3, 'ABBC_Applications'),
('speeding_up_rule_wrong', 'Speeding Up/Slowing Down Rule Applied Incorrectly', 'Motion', 4, 'ABBC_Applications'),

('related_rates_variable_mismatch', 'Related Rates Variable Mismatch (Wrong Variable or Missing One)', 'Related Rates', 4, 'ABBC_Applications'),
('missing_related_variables', 'Failing to Identify All Related Variables', 'Related Rates', 4, 'ABBC_Applications'),
('related_rates_diff_before_substitute_missed', 'Substituting Values Before Differentiating (Order Mistake)', 'Related Rates', 4, 'ABBC_Applications'),
('plug_in_before_diff_error', 'Plugging in Constants Before Differentiating', 'Related Rates', 5, 'ABBC_Applications'),
('related_rates_time_derivative_missing', 'Forgetting d/dt on One Term (Missing Chain Rule Factor)', 'Related Rates', 4, 'ABBC_Applications'),
('missing_chain_rule_related_rates', 'Missing Chain Rule Factor in Related Rates', 'Related Rates', 4, 'ABBC_Applications'),
('related_rates_geometry_setup_error', 'Geometry Relationship Setup Error (Wrong Equation/Diagram)', 'Related Rates', 3, 'ABBC_Applications'),
('missing_geometry_relation', 'Missing Geometric Relationship Formula', 'Related Rates', 3, 'ABBC_Applications'),
('related_rates_sign_error', 'Related Rates Sign Error (Approaching vs Receding)', 'Related Rates', 3, 'ABBC_Applications'),
('sign_error_rate_direction', 'Sign Error in Rate Direction', 'Related Rates', 3, 'ABBC_Applications'),
('missing_differentiate_time', 'Forgetting to Differentiate with Respect to Time', 'Related Rates', 4, 'ABBC_Applications'),
('differentiate_wrt_wrong_variable', 'Differentiating with Respect to Wrong Variable', 'Related Rates', 4, 'ABBC_Applications'),


('linearization_point_wrong', 'Linearization Uses Wrong Base Point (a-value)', 'Linearization', 3, 'ABBC_Applications'),
('linearization_point_misuse', 'Misusing the Tangent Point in Linearization', 'Linearization', 3, 'ABBC_Applications'),
('linearization_far_from_point', 'Using Linearization Too Far From Tangent Point', 'Linearization', 3, 'ABBC_Applications'),
('linearization_formula_misuse', 'Incorrect Tangent Line/Linearization Structure', 'Linearization', 3, 'ABBC_Applications'),
('tangent_slope_wrong_value', 'Using Wrong Value for Tangent Slope', 'Linearization', 3, 'ABBC_Applications'),
('differentials_dy_dx_swap', 'Mixing Up dy and dx / Substituting Incorrectly', 'Differentials', 3, 'ABBC_Applications'),
('differential_sign_error', 'Sign Error in Differential Estimation', 'Differentials', 3, 'ABBC_Applications'),
('units_mismatch_linearization', 'Units Mismatch in Linearization', 'Linearization', 3, 'ABBC_Applications'),


('lhospital_wrong_form', 'Applying L''Hospital When Not 0/0 or ∞/∞', 'L''Hospital', 4, 'ABBC_Applications'),
('use_lhospital_wrong_form', 'Using L''Hospital on Determinate Form', 'L''Hospital', 4, 'ABBC_Applications'),
('lhospital_derivative_mistake', 'Differentiation Error During L''Hospital Step', 'L''Hospital', 3, 'ABBC_Applications'),
('differentiate_only_numerator', 'Differentiating Only Numerator (Quotient Rule Error)', 'L''Hospital', 4, 'ABBC_Applications'),
('lhospital_not_recheck', 'Not Rechecking Indeterminate Form After Applying L''Hospital', 'L''Hospital', 3, 'ABBC_Applications'),
('lhospital_repeat_unnecessarily', 'Repeating L''Hospital Unnecessarily / Stopping Too Early', 'L''Hospital', 2, 'ABBC_Applications'),
('stop_too_early_lhospital', 'Stopping L''Hospital Application Too Early', 'L''Hospital', 3, 'ABBC_Applications'),
('rewrite_indeterminate_wrong', 'Incorrectly Rewriting to Indeterminate Form', 'L''Hospital', 3, 'ABBC_Applications'),
('use_lhospital_when_algebra_easier', 'Using L''Hospital When Algebra is simpler', 'Strategy', 2, 'ABBC_Applications'),

('wrong_method_choice_unit4', 'Wrong Method Choice (RR vs Linearization vs Interpretation vs L''Hospital)', 'Strategy', 3, 'ABBC_Applications')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;
