-- Seed file for Unit 2 (Derivatives) Metadata: Skills and Error Tags

-- ============================================================
-- 1. Skills
-- ============================================================
DELETE FROM public.skills WHERE unit = 'Unit2_Derivatives';

INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('slope_avg_rate', 'Average Rate of Change (Secant Slope)', 'Unit2_Derivatives', '{}'),
('slope_instant_rate', 'Instantaneous Rate of Change (Tangent Slope)', 'Unit2_Derivatives', '{"slope_avg_rate"}'),
('difference_quotient', 'Difference Quotient Setup and Interpretation', 'Unit2_Derivatives', '{}'),
('derivative_definition_limit', 'Derivative from Limit Definition', 'Unit2_Derivatives', '{"difference_quotient"}'),
('derivative_notation', 'Derivative Notation (f'', dy/dx, D_x)', 'Unit2_Derivatives', '{}'),
('derivative_from_graph', 'Estimating Derivative from a Graph (Tangent Slope)', 'Unit2_Derivatives', '{"slope_instant_rate"}'),
('derivative_from_table', 'Estimating Derivative from a Table / Data', 'Unit2_Derivatives', '{"difference_quotient"}'),
('differentiability_concept', 'Differentiability Concept (When f'' Exists)', 'Unit2_Derivatives', '{}'),
('diff_vs_continuity', 'Differentiability vs Continuity (Implications)', 'Unit2_Derivatives', '{"differentiability_concept"}'),
('nondifferentiable_features', 'Recognizing Non-Differentiable Features (Corner/Cusp/Discontinuity/Vertical Tangent)', 'Unit2_Derivatives', '{"differentiability_concept"}'),
('power_rule_basic', 'Power Rule (Polynomial Terms)', 'Unit2_Derivatives', '{}'),
('linearity_rules', 'Linearity Rules (Sum/Difference/Constant Multiple)', 'Unit2_Derivatives', '{"power_rule_basic"}'),
('trig_derivatives_basic', 'Basic Trig Derivatives (sin, cos)', 'Unit2_Derivatives', '{}'),
('exp_derivatives_basic', 'Basic Exponential Derivatives (e^x, a^x)', 'Unit2_Derivatives', '{}'),
('log_derivatives_basic', 'Basic Logarithmic Derivatives (ln x)', 'Unit2_Derivatives', '{}'),
('product_rule', 'Product Rule', 'Unit2_Derivatives', '{"linearity_rules"}'),
('quotient_rule', 'Quotient Rule', 'Unit2_Derivatives', '{"linearity_rules"}'),
('tangent_line_equation', 'Equation of a Tangent Line', 'Unit2_Derivatives', '{"derivative_notation"}'),
('normal_line_equation', 'Equation of a Normal Line', 'Unit2_Derivatives', '{"tangent_line_equation"}'),
('interpret_derivative_context', 'Interpreting Derivative in Context (Units/Meaning)', 'Unit2_Derivatives', '{"slope_instant_rate"}'),
('method_selection_derivatives', 'Strategy Selection for Derivative Problems', 'Unit2_Derivatives', '{}');

-- ============================================================
-- 2. Error Tags
-- ============================================================
DELETE FROM public.error_tags WHERE unit = 'Unit2_Derivatives';

INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('secant_vs_tangent_confusion', 'Confusing Secant Slope with Tangent Slope', 'Rate of Change', 3, 'Unit2_Derivatives'),
('average_rate_wrong_interval', 'Average Rate of Change Using Wrong Interval/Order', 'Rate of Change', 2, 'Unit2_Derivatives'),
('difference_quotient_setup_error', 'Difference Quotient Setup Error (Wrong Substitution)', 'Definition of Derivative', 3, 'Unit2_Derivatives'),
('h_limit_handling_error', 'Incorrect Handling of h → 0 Limit', 'Definition of Derivative', 3, 'Unit2_Derivatives'),
('cancel_h_mistake', 'Canceling h Incorrectly / Algebra Slip in Definition', 'Algebra', 2, 'Unit2_Derivatives'),
('derivative_notation_misread', 'Misreading Derivative Notation (f''(a), dy/dx)', 'Notation', 2, 'Unit2_Derivatives'),
('slope_from_graph_misread', 'Misreading Slope from Graph (Rise/Run or Sign)', 'Graph Interpretation', 3, 'Unit2_Derivatives'),
('tangent_line_point_confusion', 'Using the Wrong Point on the Tangent Line', 'Graph Interpretation', 2, 'Unit2_Derivatives'),
('table_derivative_estimate_error', 'Incorrect Derivative Estimate from Table Data', 'Table Interpretation', 2, 'Unit2_Derivatives'),
('diff_implies_continuity_missed', 'Forgetting Differentiable ⇒ Continuous', 'Differentiability', 3, 'Unit2_Derivatives'),
('continuous_implies_diff_wrong', 'Assuming Continuous ⇒ Differentiable', 'Differentiability', 3, 'Unit2_Derivatives'),
('corner_cusp_not_recognized', 'Not Recognizing Corner/Cusp as Non-Differentiable', 'Differentiability', 3, 'Unit2_Derivatives'),
('vertical_tangent_not_recognized', 'Not Recognizing Vertical Tangent as Non-Differentiable', 'Differentiability', 3, 'Unit2_Derivatives'),
('power_rule_exponent_error', 'Power Rule Exponent Mistake', 'Rules', 2, 'Unit2_Derivatives'),
('constant_derivative_error', 'Derivative of Constant Misapplied', 'Rules', 1, 'Unit2_Derivatives'),
('linearity_missing_term', 'Linearity Error (Dropping a Term / Sign Error)', 'Rules', 2, 'Unit2_Derivatives'),
('trig_derivative_swap_error', 'Trig Derivative Swap Error (sin vs cos sign)', 'Rules', 3, 'Unit2_Derivatives'),
('exp_log_derivative_confusion', 'Exponential vs Log Derivative Confusion', 'Rules', 3, 'Unit2_Derivatives'),
('product_rule_structure_error', 'Product Rule Structure Error', 'Rules', 4, 'Unit2_Derivatives'),
('quotient_rule_structure_error', 'Quotient Rule Structure Error', 'Rules', 4, 'Unit2_Derivatives'),
('quotient_rule_sign_error', 'Quotient Rule Sign / Order Error', 'Rules', 3, 'Unit2_Derivatives'),
('tangent_line_equation_error', 'Tangent Line Equation Setup Error', 'Applications', 3, 'Unit2_Derivatives'),
('normal_line_slope_error', 'Normal Line Slope (Negative Reciprocal) Error', 'Applications', 3, 'Unit2_Derivatives'),
('wrong_method_choice_derivative', 'Wrong Method Choice (Definition vs Rules vs Estimation)', 'Strategy', 3, 'Unit2_Derivatives');
