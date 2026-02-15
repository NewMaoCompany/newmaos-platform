-- Seed file for Unit 3 (Composite, Implicit, Inverse) Metadata: Skills and Error Tags
-- Generated based on user request

-- ============================================================
-- 1. Skills
-- ============================================================
-- Clean up existing Unit 3 skills to avoid duplicates/conflicts
DELETE FROM public.skills WHERE unit = 'Unit3_Composite_Implicit_Inverse';

INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('chain_rule_basic', 'Chain Rule (Basic Composite Differentiation)', 'Unit3_Composite_Implicit_Inverse', '{"power_rule_basic"}'),
('chain_rule_multi_layer', 'Chain Rule (Multi-Layer / Nested Functions)', 'Unit3_Composite_Implicit_Inverse', '{"chain_rule_basic"}'),
('chain_rule_with_trig_exp_log', 'Chain Rule with Trig/Exp/Log Functions', 'Unit3_Composite_Implicit_Inverse', '{"chain_rule_basic", "trig_derivatives_basic", "exp_derivatives_basic", "log_derivatives_basic"}'),

('implicit_diff_basic', 'Implicit Differentiation (Basic dy/dx Isolation)', 'Unit3_Composite_Implicit_Inverse', '{"linearity_rules"}'),
('implicit_diff_product_quotient', 'Implicit Differentiation with Product/Quotient Structures', 'Unit3_Composite_Implicit_Inverse', '{"implicit_diff_basic", "product_rule", "quotient_rule"}'),
('implicit_diff_at_point', 'Implicit Differentiation: Evaluate dy/dx at a Given Point', 'Unit3_Composite_Implicit_Inverse', '{"implicit_diff_basic"}'),

('inverse_function_derivative', 'Derivative of an Inverse Function (General Method)', 'Unit3_Composite_Implicit_Inverse', '{"derivative_notation"}'),
('inverse_from_table_graph', 'Derivative of Inverse from Table/Graph Data', 'Unit3_Composite_Implicit_Inverse', '{"inverse_function_derivative"}'),

('inverse_trig_derivatives', 'Inverse Trig Derivatives (arcsin, arccos, arctan)', 'Unit3_Composite_Implicit_Inverse', '{"trig_derivatives_basic"}'),
('inverse_trig_chain', 'Inverse Trig + Chain Rule Combination', 'Unit3_Composite_Implicit_Inverse', '{"inverse_trig_derivatives", "chain_rule_basic"}'),

('method_selection_unit3', 'Strategy Selection (Chain vs Implicit vs Inverse Methods)', 'Unit3_Composite_Implicit_Inverse', '{}'),

('higher_order_derivatives', 'Higher-Order Derivatives (Second/Third Derivative Computation)', 'Unit3_Composite_Implicit_Inverse', '{"linearity_rules"}'),
('higher_order_meaning', 'Interpreting Higher-Order Derivatives (Concavity/Rate of Change of Rate)', 'Unit3_Composite_Implicit_Inverse', '{"higher_order_derivatives"}'),

('algebraic_simplification_unit3', 'Algebraic Simplification for Derivative Expressions (Unit 3)', 'Unit3_Composite_Implicit_Inverse', '{}');

-- ============================================================
-- 2. Error Tags
-- ============================================================
-- Clean up existing Unit 3 error tags
DELETE FROM public.error_tags WHERE unit = 'Unit3_Composite_Implicit_Inverse';

INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('chain_rule_missing_inner', 'Chain Rule Missing Inner Derivative (Forgetting g''(x))', 'Chain Rule', 4, 'Unit3_Composite_Implicit_Inverse'),
('chain_rule_wrong_layers', 'Chain Rule Misidentifying Layers (Wrong Outer/Inner Split)', 'Chain Rule', 3, 'Unit3_Composite_Implicit_Inverse'),
('chain_rule_algebra_slip', 'Chain Rule Algebra Slip After Differentiation', 'Chain Rule', 2, 'Unit3_Composite_Implicit_Inverse'),

('implicit_diff_forget_dydx', 'Implicit Differentiation: Forgetting dy/dx on y-Terms', 'Implicit', 4, 'Unit3_Composite_Implicit_Inverse'),
('implicit_diff_wrong_product_rule', 'Implicit Differentiation: Product Rule Setup Error', 'Implicit', 4, 'Unit3_Composite_Implicit_Inverse'),
('implicit_diff_wrong_quotient_rule', 'Implicit Differentiation: Quotient Rule Setup Error', 'Implicit', 4, 'Unit3_Composite_Implicit_Inverse'),
('implicit_diff_not_isolated', 'Implicit Differentiation: Not Solving for dy/dx', 'Implicit', 3, 'Unit3_Composite_Implicit_Inverse'),
('implicit_diff_point_sub_error', 'Implicit Differentiation: Substituting Point Incorrectly', 'Implicit', 2, 'Unit3_Composite_Implicit_Inverse'),

('inverse_derivative_reciprocal_confusion', 'Inverse Derivative Confusion (Mixing f'' and 1/f'')', 'Inverse Functions', 4, 'Unit3_Composite_Implicit_Inverse'),
('inverse_derivative_wrong_input', 'Inverse Derivative Wrong Input (Using x Instead of f(x) or Vice Versa)', 'Inverse Functions', 4, 'Unit3_Composite_Implicit_Inverse'),
('inverse_table_lookup_error', 'Inverse from Table/Graph: Swapping x and y Incorrectly', 'Inverse Functions', 3, 'Unit3_Composite_Implicit_Inverse'),

('inverse_trig_wrong_formula', 'Inverse Trig Derivative Formula Error', 'Inverse Trig', 4, 'Unit3_Composite_Implicit_Inverse'),
('inverse_trig_missing_chain', 'Inverse Trig Missing Chain Rule Factor', 'Inverse Trig', 4, 'Unit3_Composite_Implicit_Inverse'),
('inverse_trig_sign_domain_confusion', 'Inverse Trig Sign/Domain Confusion in Simplification', 'Inverse Trig', 3, 'Unit3_Composite_Implicit_Inverse'),

('method_choice_wrong_unit3', 'Wrong Method Choice (Rules vs Chain vs Implicit vs Inverse)', 'Strategy', 3, 'Unit3_Composite_Implicit_Inverse'),

('higher_order_derivative_misread', 'Higher-Order Derivative Misread (Mixing f'' and f'''' or Order)', 'Higher Order', 3, 'Unit3_Composite_Implicit_Inverse'),
('higher_order_compute_error', 'Higher-Order Derivative Computation Error (Repeat Differentiation Mistake)', 'Higher Order', 2, 'Unit3_Composite_Implicit_Inverse'),

('notation_dydx_misuse', 'Notation Misuse (dy/dx vs Δy/Δx vs f''(a))', 'Notation', 2, 'Unit3_Composite_Implicit_Inverse'),

('algebra_simplification_error_unit3', 'Algebra/Simplification Error in Final Derivative', 'Algebra', 2, 'Unit3_Composite_Implicit_Inverse');
