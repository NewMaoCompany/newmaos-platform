-- Mass Insert Script for Unit 1 Skills and Error Tags
-- Generated based on user request (Unit 1: Limits & Continuity)
-- Target Unit ID: Both_Limits

-- 1. Schema Migration: Ensure error_tags has 'unit' column
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'error_tags' AND column_name = 'unit') THEN
        ALTER TABLE public.error_tags ADD COLUMN unit text;
    END IF;
END $$;

-- 2. Cleanup Old Unit 1 Data to avoid duplicates
DELETE FROM public.skills WHERE unit = 'Both_Limits';
DELETE FROM public.error_tags WHERE unit = 'Both_Limits';

-- 3. Insert Skills (Unit 1)
INSERT INTO public.skills (id, name, unit) VALUES
('limit_concept', 'Understanding Limit Concept (Approach vs Value, Existence)', 'Both_Limits'),
('limit_notation', 'Reading/Writing Limit Notation (Left/Right, Infinity)', 'Both_Limits'),
('limit_estimation_graph', 'Estimating Limits from Graphs (Open/Closed Points, Jumps, Asymptotes)', 'Both_Limits'),
('limit_estimation_table', 'Estimating Limits from Tables (Approximation, Trend)', 'Both_Limits'),
('limit_laws', 'Limit Laws & Arithmetic Rules (Sum, Product, Quotient, Power)', 'Both_Limits'),
('algebraic_simplification', 'Algebraic Simplification (Factoring, Canceling)', 'Both_Limits'),
('conjugate_rationalization', 'Rationalization using Conjugates', 'Both_Limits'),
('limits_at_infinity', 'Limits at Infinity (Highest Degree Analysis, End Behavior)', 'Both_Limits'),
('infinite_limits_asymptotes', 'Infinite Limits & Vertical Asymptotes', 'Both_Limits'),
('continuity_concept', 'Concept of Continuity (Point vs Interval)', 'Both_Limits'),
('discontinuity_types', 'Types of Discontinuity (Removable, Jump, Infinite)', 'Both_Limits'),
('ivt_application', 'Application of IVT (Existence of Roots)', 'Both_Limits'),
('avg_vs_instant_rate', 'Average vs Instantaneous Rate of Change', 'Both_Limits'),
('derivative_definition', 'Definition of Derivative (Limit of Difference Quotient)', 'Both_Limits'),
('method_selection', 'Strategy Selection (Substitution, Simplification, Squeeze Thm)', 'Both_Limits'),
('squeeze_theorem', 'Squeeze Theorem Structure & Application', 'Both_Limits');

-- 4. Insert Error Tags (Unit 1)
-- Categories mapped from headers provided by user
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
-- Limit Meaning & Notation Errors
('limit_vs_value', 'Confusing Limit with Function Value', 'Limit Meaning & Notation', 1, 'Both_Limits'),
('notation_misread', 'Misreading Notation (x->a vs x->inf)', 'Limit Meaning & Notation', 1, 'Both_Limits'),
('two_sided_requires_match', 'Forgetting Left/Right Limits Must Match', 'Limit Meaning & Notation', 2, 'Both_Limits'),
('endpoint_domain_issue', 'Domain/Endpoint Restrictions', 'Limit Meaning & Notation', 1, 'Both_Limits'),

-- Graph / Table Interpretation Errors
('open_vs_closed_point', 'Confusing Open vs Closed Points', 'Graph / Table Interpretation', 1, 'Both_Limits'),
('graph_jump_confusion', 'Misinterpreting Jumps as Limits or DNE', 'Graph / Table Interpretation', 2, 'Both_Limits'),
('table_trend_misread', 'Misreading Table Trends (One-sided or Far Points)', 'Graph / Table Interpretation', 2, 'Both_Limits'),
('one_sided_from_data', 'Inferring Two-Sided Limit from One-Sided Data', 'Graph / Table Interpretation', 2, 'Both_Limits'),

-- Limit Laws / Algebra Errors
('illegal_substitution_0over0', 'Direct Substitution on 0/0 Form', 'Limit Laws / Algebra', 3, 'Both_Limits'),
('factor_cancel_mistake', 'Factoring or Cancellation Error', 'Limit Laws / Algebra', 2, 'Both_Limits'),
('conjugate_setup_error', 'Conjugate Setup or Expansion Error', 'Limit Laws / Algebra', 2, 'Both_Limits'),
('quotient_law_denominator_zero', 'Applying Quotient Law when Denominator is 0', 'Limit Laws / Algebra', 3, 'Both_Limits'),
('infinity_degree_mistake', 'Degree Analysis Error for Limits at Infinity', 'Limit Laws / Algebra', 2, 'Both_Limits'),

-- Infinite Limits / Asymptotes Errors
('infinite_limit_meaning', 'Misinterpreting Infinite Limits (Value vs Behavior)', 'Infinite Limits / Asymptotes', 2, 'Both_Limits'),
('asymptote_confusion', 'Confusing Vertical vs Horizontal Asymptotes', 'Infinite Limits / Asymptotes', 2, 'Both_Limits'),

-- Continuity / IVT Errors
('continuity_three_conditions_miss', 'Missing 3 Conditions for Continuity', 'Continuity / IVT', 2, 'Both_Limits'),
('ivt_missing_continuity', 'Applying IVT without Continuity Check', 'Continuity / IVT', 3, 'Both_Limits'),
('interval_continuity_confusion', 'Interval Continuity Confusion (Endpoints)', 'Continuity / IVT', 1, 'Both_Limits'),

-- Rate of Change / Derivative Definition Errors
('average_vs_instant', 'Confusing Average vs Instantaneous Rate', 'Rate of Change', 3, 'Both_Limits'),
('difference_quotient_wrong_limit', 'Incorrect Difference Quotient Setup', 'Rate of Change', 2, 'Both_Limits'),

-- Strategy Errors
('wrong_method_choice', 'Incorrect Strategy Choice', 'Strategy', 2, 'Both_Limits'),
('squeeze_bounds_incorrect', 'Incorrect Squeeze Theorem Bounds', 'Strategy', 2, 'Both_Limits');
