-- Insert Unit 10 Questions (10.1, 10.2, 10.5, 10.6, 10.7, 10.8)
-- 
-- Configuration:
-- Topic ID: 'BC_Series'
-- Course: 'BC'
-- Representation Type: 'symbolic' (forced)

-- =====================================================
-- SCHEMA ALIGNMENT: Relax status constraint to allow 'published'
-- =====================================================
DO $$ 
BEGIN 
    -- 1. Relax status constraint if it exists
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'public.questions'::regclass AND conname = 'questions_status_check') THEN
        ALTER TABLE public.questions DROP CONSTRAINT questions_status_check;
        ALTER TABLE public.questions ADD CONSTRAINT questions_status_check CHECK (status IN ('draft', 'active', 'published', 'retired'));
    END IF;

    -- 2. Synchronize existing 'active' questions to 'published' for UI compatibility
    -- DISABLE TRIGGER to avoid duplicate key error in question_versions
    ALTER TABLE public.questions DISABLE TRIGGER trg_create_question_version;
    
    UPDATE public.questions SET status = 'published' WHERE status = 'active';
    
    ALTER TABLE public.questions ENABLE TRIGGER trg_create_question_version;
END $$;

DO $$
DECLARE
    q_id UUID;
BEGIN

    -- 1. \frac{Insert}{Ensure} Skills
    INSERT INTO public.skills (id, name, unit) VALUES
        ('series_definition_partial_sums', 'Definition of Series Convergence (Partial Sums)', 'Unit10_InfiniteSequencesAndSeries'),
        ('convergence_strategy_selection', 'Selecting a Convergence Strategy', 'Unit10_InfiniteSequencesAndSeries'),
        ('sequence_limit_convergence', 'Sequence Limit & Convergence', 'Unit10_InfiniteSequencesAndSeries'),
        ('nth_term_test_divergence', 'nth-Term Test for Divergence', 'Unit10_InfiniteSequencesAndSeries'),
        ('sequence_divergence_behavior', 'Sequence Divergence Behavior', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_geometric_recognize', 'Recognizing Geometric Series', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_geometric_sum', 'Geometric Series Sum Formula', 'Unit10_InfiniteSequencesAndSeries'),
        ('p_series_test', 'p-Series Test', 'Unit10_InfiniteSequencesAndSeries'),
        ('harmonic_series_recognize', 'Recognizing Harmonic Series', 'Unit10_InfiniteSequencesAndSeries'),
        ('algebra_simplification_asymptotic', 'Asymptotic Algebra Simplification', 'Unit10_InfiniteSequencesAndSeries'),
        ('comparison_test_direct', 'Direct Comparison Test', 'Unit10_InfiniteSequencesAndSeries'),
        ('inequality_setup_comparison', 'Setting up Inequalities for Comparison', 'Unit10_InfiniteSequencesAndSeries'),
        ('\\\\\\\\limit_comparison_test', 'Limit Comparison Test', 'Unit10_InfiniteSequencesAndSeries'),
        ('alternating_series_test', 'Alternating Series Test (AST)', 'Unit10_InfiniteSequencesAndSeries'),
        ('monotonicity_check_sequence', 'Checking Sequence Monotonicity', 'Unit10_InfiniteSequencesAndSeries'),
        ('alternating_series_error_bound', 'Alternating Series Error Bound', 'Unit10_InfiniteSequencesAndSeries'),
        ('ratio_test', 'Ratio Test', 'Unit10_InfiniteSequencesAndSeries'),
        ('\\\\\\\\limit_computation', 'Computation of Limits', 'Unit10_InfiniteSequencesAndSeries'),
        ('factorial_algebra_simplify', 'Simplifying Factorials', 'Unit10_InfiniteSequencesAndSeries'),
        ('\\interpret_ratio_test_outcome', 'Interpreting Ratio Test Outcome', 'Unit10_InfiniteSequencesAndSeries'),
        ('\\integral_test_setup', 'Integral Test Setup', 'Unit10_InfiniteSequencesAndSeries'),
        ('taylor_polynomial_approximation', 'Taylor Polynomial Approximation', 'Unit10_InfiniteSequencesAndSeries'),
        ('taylor_approximation_eval', 'Evaluating Taylor Approximations', 'Unit10_InfiniteSequencesAndSeries'),
        ('lagrange_error_bound', 'Lagrange Error Bound', 'Unit10_InfiniteSequencesAndSeries'),
        ('power_series_radius_interval', 'Radius and Interval of Convergence', 'Unit10_InfiniteSequencesAndSeries'),
        ('\\interval_notation_interpretation', 'Interpreting Interval Notation', 'Unit10_InfiniteSequencesAndSeries'),
        ('maclaurin_series_known', 'Known Maclaurin Series', 'Unit10_InfiniteSequencesAndSeries'),
        ('known_series_transform', 'Transforming Known Series', 'Unit10_InfiniteSequencesAndSeries'),
        ('identify_series_from_coefficients', 'Identifying Series from Coefficients', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_operations_multiply', 'Series Operations (Multiplication)', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_operations_derivative', 'Series Operations (Derivative)', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_operations_integral', 'Series Operations (Integration)', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_coefficient_extraction', 'Extracting Series Coefficients', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_convergence_divergence_basic', 'Basic Series \frac{Convergence}{Divergence}', 'Unit10_InfiniteSequencesAndSeries'),
        ('geometric_series_identification', 'Geometric Series Identification', 'Unit10_InfiniteSequencesAndSeries'),
        ('absolute_vs_conditional', 'Absolute vs Conditional Convergence', 'Unit10_InfiniteSequencesAndSeries'),
        ('alternating_error_bound', 'Alternating Series Error Bound Basic', 'Unit10_InfiniteSequencesAndSeries'),
        ('geometric_series_from_function', 'Geometric Series from Functions', 'Unit10_InfiniteSequencesAndSeries'),
        ('\\interpret_error_bound_direction', 'Interpreting Error Bound Direction', 'Unit10_InfiniteSequencesAndSeries'),
        ('derivative_matching_at_center', 'Derivative Matching at Center', 'Unit10_InfiniteSequencesAndSeries'),
        ('endpoint_convergence_check', 'Power Series Endpoint Check', 'Unit10_InfiniteSequencesAndSeries'),
        ('pattern_identification', 'Identifying Series Patterns', 'Unit10_InfiniteSequencesAndSeries'),
        ('series_center_shift', 'Series Center Shift', 'Unit10_InfiniteSequencesAndSeries')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        unit = EXCLUDED.unit;

    -- 2. \frac{Insert}{Ensure} Error Tags
    INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
        ('partial_sum_definition_missing', 'Forgot Series is Limit of Partial Sums', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('convergence_vs_sum_confusion', 'Confusing Convergence with Sum Value', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('nth_term_test_misused', 'Misusing nth-Term Test (Convergence vs Divergence)', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('\\integral_test_requirements_missed', 'Missed Integral Test Conditions (Pos, Decr, Cont)', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('strategy_test_choice_wrong', 'Chose \frac{Inefficient}{Wrong} Test', 'Strategy', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('ast_conditions_missed', 'Missed AST Conditions (Alt, Decr, Lim=0)', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('\\\\\\\\limit_to_zero_not_checked', 'Forgot to Check Limit -> 0', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('ratio_test_rule_misread', 'Misread Ratio Test Rule (L<1 vs L>1)', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('inconclusive_case_misread', 'Misinterpreted Inconclusive Ratio Test', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('comparison_direction_wrong', 'Wrong Inequality Direction for Comparison', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('taylor_derivative_coefficient_error', 'Taylor Coeff Error (Forgot n! or Deriv)', 'Formula', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('factorial_in_denominator_error', 'Factorial Denominator Error', 'Formula', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('substitution_error', 'Substitution Error', 'Algebra', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('center_mismatch', 'Used Wrong Center for Taylor Poly', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('overgeneralizing_accuracy', 'Misunderstanding Approximation Accuracy', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('degree_mismatch', 'Degree Mismatch in Taylor Poly', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('derivative_order_confusion', 'Confused Derivative Order with Degree', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('sign_error_series', 'Sign Error in Series Expansion', 'Algebra', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('lagrange_formula_misread', 'Misread Lagrange Error Formula', 'Formula', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('lagrange_bound_max_derivative_misidentified', 'Misidentified Max Derivative (M)', 'Procedural', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('power_factor_error', 'Incorrect Power in Remainder', 'Formula', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('\\interval_wrong_for_M', 'Chose Wrong Interval for M', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('radius_confusion', 'Confused Radius with Interval', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('endpoint_test_skipped', 'Skipped Endpoint Convergence Check', 'Procedural', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('\\interval_notation_error', 'Interval Notation Error (\frac{Open}{Closed})', 'Notation', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('endpoint_open_closed_confusion', 'Confused \frac{Open}{Closed} Endpoints', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('center_shift_error', 'Series Center Shift Error', 'Algebra', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('even_power_substitution_missed', 'Missed Even Power Effect on Interval', 'Procedural', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('missing_common_ratio', 'Missing Common Ratio in Geometric Series', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('index_shift_error', 'Index Shift Error', 'Procedural', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('pattern_misread', 'Misread Series Pattern', 'Observation', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('power_pattern_error', 'Incorrect Power Pattern', 'Observation', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('coefficient_extraction_error', 'Coefficient Extraction Error', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('term_degree_tracking_error', 'Lost Track of Term Degree', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('term_by_term_diff_misapplied', 'Misapplied Term-by-Term Differentiation', 'Procedural', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('radius_not_updated_correctly', 'Failed to Update Radius', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('term_by_term_integration_misapplied', 'Misapplied Term-by-Term Integration', 'Procedural', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('constant_of_integration_missing', 'Forgot Constant of Integration', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('confusing_sequence_vs_series', 'Confusing Sequence with Series', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('common_ratio_misidentified', 'Misidentified Common Ratio', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('p_series_rule_misread', 'Misread p-Series Rule', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('comparison_direction_error', 'Comparison Direction Error', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('\\\\\\\\limit_comparison_setup_error', 'LCT Setup Error', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('alternating_test_conditions_missed', 'AST Conditions Missed', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('absolute_vs_conditional_confusion', 'Confused Abs vs Cond Convergence', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('error_bound_misinterpreted', 'Misinterpreted Error Bound', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('geometric_r_identification_error', 'Incorrect Ratio Identification', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('geometric_condition_error', 'Forgot |r|<1 Condition', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('geometric_sum_formula_error', 'Geometric Sum Formula Error', 'Formula', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('p_series_threshold_error', 'Wrong p-Series Threshold (p>1 vs p>=1)', 'Conceptual', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('harmonic_vs_pseries_confusion', 'Harmonic vs p-Series Confusion', 'Conceptual', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('algebra_simplification_error', 'Algebra Simplification Error', 'Algebra', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('inequality_setup_error', 'Inequality Setup Error', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('\\\\\\\\limit_comparison_limit_error', 'Limit Comparison Limit Error', 'Calculation', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('choose_wrong_comparison_series', 'Chose Wrong Series for Comparison', 'Strategy', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('monotonicity_assumed_not_verified', 'Assumed Monotonicity Without Check', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('alt_error_bound_misapplied', 'Misapplied AST Error Bound', 'Formula', 3, 'Unit10_InfiniteSequencesAndSeries'),
        ('next_term_not_used_for_error', 'Did Not Use Next Term for Error', 'Procedural', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('ratio_test_limit_error', 'Ratio Test Limit Calculation Error', 'Calculation', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('factorial_cancel_error', 'Factorial Cancellation Error', 'Algebra', 2, 'Unit10_InfiniteSequencesAndSeries'),
        ('rounding_error_bound_direction', 'Rounding Error in Bound Direction', 'Calculation', 2, 'Unit10_InfiniteSequencesAndSeries')
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        category = EXCLUDED.category,
        severity = EXCLUDED.severity,
        unit = EXCLUDED.unit;

    -- 3. Cleanup Existing Questions
    DELETE FROM public.questions WHERE title IN (
        'U10.1-P1', 'U10.1-P2', 'U10.1-P3', 'U10.1-P4', 'U10.1-P5',
        'U10.2-P1', 'U10.2-P2', 'U10.2-P3', 'U10.2-P4', 'U10.2-P5',
        'U10.3-P1', 'U10.3-P2', 'U10.3-P3', 'U10.3-P4', 'U10.3-P5',
        'U10.4-P1', 'U10.4-P2', 'U10.4-P3', 'U10.4-P4', 'U10.4-P5',
        'U10.5-P1', 'U10.5-P2', 'U10.5-P3', 'U10.5-P4', 'U10.5-P5',
        'U10.6-P1', 'U10.6-P2', 'U10.6-P3', 'U10.6-P4', 'U10.6-P5',
        'U10.7-P1', 'U10.7-P2', 'U10.7-P3', 'U10.7-P4', 'U10.7-P5',
        'U10.8-P1', 'U10.8-P2', 'U10.8-P3', 'U10.8-P4', 'U10.8-P5',
        'U10.9-P1', 'U10.9-P2', 'U10.9-P3', 'U10.9-P4', 'U10.9-P5',
        'U10.10-P1', 'U10.10-P2', 'U10.10-P3', 'U10.10-P4', 'U10.10-P5',
        'U10.11-P1', 'U10.11-P2', 'U10.11-P3', 'U10.11-P4', 'U10.11-P5',
        'U10.12-P1', 'U10.12-P2', 'U10.12-P3', 'U10.12-P4', 'U10.12-P5',
        'U10.13-P1', 'U10.13-P2', 'U10.13-P3', 'U10.13-P4', 'U10.13-P5',
        'U10.14-P1', 'U10.14-P2', 'U10.14-P3', 'U10.14-P4', 'U10.14-P5',
        'U10.15-P1', 'U10.15-P2', 'U10.15-P3', 'U10.15-P4', 'U10.15-P5',
        'U10-UT-Q1', 'U10-UT-Q2', 'U10-UT-Q3', 'U10-UT-Q4', 'U10-UT-Q5',
        'U10-UT-Q6', 'U10-UT-Q7', 'U10-UT-Q8', 'U10-UT-Q9', 'U10-UT-Q10',
        'U10-UT-Q11', 'U10-UT-Q12', 'U10-UT-Q13', 'U10-UT-Q14', 'U10-UT-Q15',
        'U10-UT-Q16', 'U10-UT-Q17', 'U10-UT-Q18', 'U10-UT-Q19', 'U10-UT-Q20'
    );

    -- 4. Insert Questions

    -- U10.1-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.1-P1', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ', false, 2,
        'Which statement best describes what it means for an infinite series $\sum_{n=1}^{\infty} a_n$ to converge?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The terms satisfy $a_n > 0$ for all $n$."},
            {"id": "B", "value": "The sequence of partial sums $S_N = \\\sum_{n=1}^{N} a_n$ approaches a finite \\\\\\\\limit as $N \\to \\infty$."},
            {"id": "C", "value": "The terms satisfy $a_n \\to \\infty$ as $n \\to \\infty$."},
            {"id": "D", "value": "The partial sums $S_N$ are increasing for all $N$."}
        ]'::jsonb, 'B',
        'A series converges if and only if its partial sums approach a finite \\\\\\\\limit.',
        'series_definition_partial_sums', ARRAY['series_definition_partial_sums', 'convergence_strategy_selection'], ARRAY['partial_sum_definition_missing', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.1-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.1-P2', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ', false, 3,
        'Let $a_n = \frac{1}{n(n+1)}$ and $S_N = \sum_{n=1}^{N} a_n$. Which expression for $S_N$ is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$S_N = \\frac{N}{N+1}$"},
            {"id": "B", "value": "$S_N = \\frac{N+1}{N}$"},
            {"id": "C", "value": "$S_N = \\ln(N+1)$"},
            {"id": "D", "value": "$S_N = \\frac{1}{N+1}$"}
        ]'::jsonb, 'A',
        'Using partial \\fractions $\frac{1}{n(n+1)} = \frac{1}{n} - \frac{1}{n+1}$, the sum telescopes to $S_N = 1 - \frac{1}{N+1} = \frac{N}{N+1}$.',
        'series_definition_partial_sums', ARRAY['series_definition_partial_sums', 'sequence_limit_convergence', 'convergence_strategy_selection'], ARRAY['partial_sum_definition_missing', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.1-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.1-P3', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ', false, 2,
        'Which statement is always true if the series $\sum_{n=1}^{\infty} a_n$ converges?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$a_n \\to 0$ as $n \\to \\infty$"},
            {"id": "B", "value": "$a_n$ is decreasing for all $n$"},
            {"id": "C", "value": "$a_n > 0$ for all $n$"},
            {"id": "D", "value": "$\\\sum_{n=1}^{\\infty} a_n$ must be geometric"}
        ]'::jsonb, 'A',
        'If partial sums converge, then $a_n=S_n-S_{n-1} \to 0$; this is necessary but not sufficient for convergence.',
        'series_definition_partial_sums', ARRAY['series_definition_partial_sums', 'nth_term_test_divergence'], ARRAY['nth_term_test_misused', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.1-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.1-P4', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ', false, 3,
        'A sequence of partial sums is defined by $S_N = 2 - \frac{1}{N}$. Let $\sum_{n=1}^{\infty} a_n$ be the series with these partial sums. What is the value of $\sum_{n=1}^{\infty} a_n$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$0$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$2$"},
            {"id": "D", "value": "The series diverges because $S_N$ depends on $N$"}
        ]'::jsonb, 'C',
        'Since $S_N \to 2$ as $N \to \infty$, the infinite series converges to $2$.',
        'series_definition_partial_sums', ARRAY['series_definition_partial_sums', 'sequence_limit_convergence'], ARRAY['convergence_vs_sum_confusion', 'partial_sum_definition_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.1-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.1-P5', 'BC', 'BC_Series', 'BC_Series', '10.1', '10.1', 'MCQ', false, 3,
        'Suppose $S_N = \sum_{n=1}^{N} a_n$ satisfies $S_{2k} = 1$ and $S_{2k-1} = 0$ for all \\integers $k \ge 1$. Which statement is correct about $\sum_{n=1}^{\infty} a_n$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The series converges to $\\frac{1}{2}$"},
            {"id": "B", "value": "The series converges to $1$"},
            {"id": "C", "value": "The series diverges because the partial sums do not approach a \\\\\\\\single \\\\\\\\limit"},
            {"id": "D", "value": "The series converges because $S_N$ is bounded"}
        ]'::jsonb, 'C',
        'The partial sums oscillate between $0$ and $1$ and therefore do not converge to a \\\\\\\\single value, so the series diverges.',
        'series_definition_partial_sums', ARRAY['series_definition_partial_sums', 'sequence_divergence_behavior'], ARRAY['partial_sum_definition_missing', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.2-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.2-P1', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ', false, 2,
        'Which series is geometric?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=1}^{\\infty} \\frac{1}{n}$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} 3 \\cdot 2^n$"},
            {"id": "C", "value": "$\\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$"},
            {"id": "D", "value": "$\\\sum_{n=1}^{\\infty} \\frac{n}{n+1}$"}
        ]'::jsonb, 'B',
        'A geometric series has a constant ratio between consecutive terms; $3\\cdot 2^n$ has ratio $2$.',
        'series_geometric_recognize', ARRAY['series_geometric_recognize', 'series_definition_partial_sums'], ARRAY['geometric_r_identification_error', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.2-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.2-P2', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ', false, 2,
        'Consider the geometric series $\sum_{n=0}^{\infty} 5 \left(\frac{1}{3}\right)^n$. What is its sum?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{5}{1-\\frac{1}{3}}$"},
            {"id": "B", "value": "$\\frac{5}{1+\\frac{1}{3}}$"},
            {"id": "C", "value": "$\\frac{1}{1-\\frac{1}{3}}$"},
            {"id": "D", "value": "The series diverges because $\\frac{1}{3} \\neq 0$"}
        ]'::jsonb, 'A',
        'Here $a = 5$ and $r = \frac{1}{3}$ with $|r| < 1$, so the sum is $\frac{a}{1-r} = \frac{5}{1-\frac{1}{3}}$.',
        'series_geometric_sum', ARRAY['series_geometric_sum', 'series_geometric_recognize'], ARRAY['geometric_condition_error', 'geometric_sum_formula_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.2-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.2-P3', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ', false, 3,
        'For the series $\sum_{n=1}^{\infty} 12 \left(-\frac{2}{3}\right)^{n-1}$, which statement is true?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It diverges because $r < 0$"},
            {"id": "B", "value": "It converges and its sum is $\\frac{12}{1+\\frac{2}{3}}$"},
            {"id": "C", "value": "It converges and its sum is $\\frac{12}{1-(-\\frac{2}{3})}$"},
            {"id": "D", "value": "It diverges because $|r| > 1$"}
        ]'::jsonb, 'C',
        'This is geometric with $a=12$ and $r = -\frac{2}{3}$; \\\\\\\\since $|r| < 1$, it converges and the sum is $\frac{a}{1-r} = \frac{12}{1-(-\frac{2}{3})}$.',
        'series_geometric_sum', ARRAY['series_geometric_sum', 'series_geometric_recognize', 'series_definition_partial_sums'], ARRAY['geometric_condition_error', 'geometric_sum_formula_error', 'geometric_r_identification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.2-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.2-P4', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ', false, 3,
        'A geometric series has first term $a_1 = 9$ and common ratio $r = \frac{1}{2}$. What is the smallest \\integer $N$ such that the partial sum $S_N$ satisfies $S_N > 17$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$N=1$"},
            {"id": "B", "value": "$N=2$"},
            {"id": "C", "value": "$N=3$"},
            {"id": "D", "value": "$N=5$"}
        ]'::jsonb, 'D',
        'Compute partial sums: $S_1 = 9$, $S_2 = 13.5$, $S_3 = 15.75$, $S_4 = 16.875$, $S_5 = 17.4375$. The smallest \\integer is $N = 5$.',
        'series_geometric_sum', ARRAY['series_geometric_sum', 'series_definition_partial_sums', 'sequence_limit_convergence'], ARRAY['geometric_sum_formula_error', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.2-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.2-P5', 'BC', 'BC_Series', 'BC_Series', '10.2', '10.2', 'MCQ', false, 3,
        'Which value of $r$ makes the geometric series $\sum_{n=0}^{\infty} 7r^n$ converge?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$r = -2$"},
            {"id": "B", "value": "$r = 1$"},
            {"id": "C", "value": "$r = \\frac{3}{2}$"},
            {"id": "D", "value": "$r = -\\frac{3}{4}$"}
        ]'::jsonb, 'D',
        'A geometric series $\sum_{n=0}^{\infty} ar^n$ converges exactly when $|r| < 1$; only $r = -\frac{3}{4}$ satisfies this.',
        'series_geometric_recognize', ARRAY['series_geometric_recognize', 'series_geometric_sum', 'convergence_strategy_selection'], ARRAY['geometric_condition_error', 'geometric_r_identification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.3-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.3-P1', 'BC', 'BC_Series', 'BC_Series', '10.3', '10.3', 'MCQ', false, 3,
        'Consider the series $\sum_{n=1}^{\infty} \frac{n}{n+1}$. What does the $n$th-term test tell you about this series?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The series converges because $n/(n+1) \\to 0$."},
            {"id": "B", "value": "The series diverges because $n/(n+1)$ does not approach $0$."},
            {"id": "C", "value": "The series converges because it is a $p$-series."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because $n/(n+1) \\to 0$."}
        ]'::jsonb, 'B',
        'Since $\frac{n}{n+1} \to 1 \ne 0$, the series must diverge by the $n$th-term test.',
        'nth_term_test_divergence', ARRAY['nth_term_test_divergence', 'series_definition_partial_sums'], ARRAY['nth_term_test_misused', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.3-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.3-P2', 'BC', 'BC_Series', 'BC_Series', '10.3', '10.3', 'MCQ', false, 3,
        'Consider the series $\sum_{n=1}^{\infty} \frac{\\\\\\\sin(n)}{n}$. Which conclusion is correct based only on the $n$th-term test?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The series converges because $\\sin(n)/n \\to 0$."},
            {"id": "B", "value": "The series diverges because $\\sin(n)$ oscillates."},
            {"id": "C", "value": "The $n$th-term test is inconclusive because $\\sin(n)/n \\to 0$."},
            {"id": "D", "value": "The series diverges because $\\sin(n)/n$ is not decreasing."}
        ]'::jsonb, 'C',
        'Since $\left|\frac{\\\\\\\sin(n)}{n}\right| \le \frac{1}{n}$, we have $\frac{\\\\\\\sin(n)}{n} \to 0$; the $n$th-term test cannot decide convergence from this alone.',
        'nth_term_test_divergence', ARRAY['nth_term_test_divergence', 'convergence_strategy_selection'], ARRAY['nth_term_test_misused', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.3-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.3-P3', 'BC', 'BC_Series', 'BC_Series', '10.3', '10.3', 'MCQ', false, 2,
        'Let $a_n = (-1)^n$. What does the $n$th-term test imply about $\sum_{n=1}^{\infty} a_n$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The series converges because the terms alternate."},
            {"id": "B", "value": "The series diverges because $a_n$ does not approach $0$."},
            {"id": "C", "value": "The series converges to $0$ because the average term is $0$."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because the terms are bounded."}
        ]'::jsonb, 'B',
        'Since $(-1)^n$ does not approach $0$, the series must diverge by the $n$th-term test.',
        'nth_term_test_divergence', ARRAY['nth_term_test_divergence', 'sequence_divergence_behavior'], ARRAY['nth_term_test_misused', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.3-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.3-P4', 'BC', 'BC_Series', 'BC_Series', '10.3', '10.3', 'MCQ', false, 3,
        'Refer to Table 10.3-A (`U10.3_Practice_Table1_Terms.png`), which lists terms $a_n$. What can you conclude about $\sum_{n=1}^{\infty} a_n$ using the $n$th-term test?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "The series converges because the terms are decreasing."},
            {"id": "B", "value": "The series converges because $a_n \\to 0$."},
            {"id": "C", "value": "The series diverges because $a_n$ does not approach $0$."},
            {"id": "D", "value": "The $n$th-term test is inconclusive because the terms are bounded."}
        ]'::jsonb, 'C',
        'From the table, $a_n$ approaches a value near $1$ rather than $0$, so the series must diverge by the $n$th-term test.',
        'nth_term_test_divergence', ARRAY['nth_term_test_divergence', 'series_definition_partial_sums'], ARRAY['nth_term_test_misused', 'partial_sum_definition_missing'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.3_Practice_Table1_Terms.png'
    );

    -- U10.3-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.3-P5', 'BC', 'BC_Series', 'BC_Series', '10.3', '10.3', 'MCQ', false, 3,
        'Which statement about the condition $a_n \to 0$ is correct for an infinite series $\sum_{n=1}^{\infty} a_n$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "If $a_n \\to 0$, then the series must converge."},
            {"id": "B", "value": "If $a_n \\to 0$, then the series must diverge."},
            {"id": "C", "value": "If $a_n \\to 0$, the $n$th-term test is inconclusive."},
            {"id": "D", "value": "If $a_n \\to 0$, then the series is geometric."}
        ]'::jsonb, 'C',
        'The condition $a_n \to 0$ is necessary for convergence, but not sufficient; the $n$th-term test cannot decide in that case.',
        'convergence_strategy_selection', ARRAY['convergence_strategy_selection', 'nth_term_test_divergence'], ARRAY['convergence_vs_sum_confusion', 'nth_term_test_misused'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.4-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.4-P1', 'BC', 'BC_Series', 'BC_Series', '10.4', '10.4', 'MCQ', false, 3,
        'Consider the series $\sum_{n=2}^{\infty} \frac{1}{n\\\\\\\ln(n)}$. If $f(x) = \frac{1}{x\\\\\\\ln(x)}$, which statement best matches the \\integral test conclusion?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The \\integral converges, so the series converges."},
            {"id": "B", "value": "The \\integral diverges, so the series diverges."},
            {"id": "C", "value": "The \\integral test cannot be applied because $f(x)$ is positive."},
            {"id": "D", "value": "The series converges because $1/(n \\ln(n)) \\to 0$."}
        ]'::jsonb, 'B',
        'Here $f$ is positive, continuous, and decreasing for $x > 1$, and $\int_2^{\infty} \frac{1}{x \\\\\\\ln x} \, dx = \infty$, so the series diverges by the \\integral test.',
        '\\integral_test_setup', ARRAY['\\integral_test_setup', 'convergence_strategy_selection'], ARRAY['\\integral_test_conditions_missed', 'strategy_test_choice_wrong'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.4-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.4-P2', 'BC', 'BC_Series', 'BC_Series', '10.4', '10.4', 'MCQ', false, 2,
        'Consider the series $\sum_{n=1}^{\infty} \frac{1}{n^2}$. Which statement is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It diverges because $\\frac{1}{n}^2 \\to 0$."},
            {"id": "B", "value": "It converges because it is a $p$-series with $p > 1$."},
            {"id": "C", "value": "It diverges because it is a $p$-series with $p > 1$."},
            {"id": "D", "value": "The $p$-series test is inconclusive when $p = 2$."}
        ]'::jsonb, 'B',
        'This is a $p$-series with $p = 2 > 1$, so it converges (and the \\integral test also confirms convergence).',
        'p_series_test', ARRAY['p_series_test', '\\integral_test_setup'], ARRAY['p_series_threshold_error', '\\integral_test_conditions_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.4-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.4-P3', 'BC', 'BC_Series', 'BC_Series', '10.4', '10.4', 'MCQ', false, 3,
        'Consider the series $\sum_{n=1}^{\infty} \frac{1}{n^2+1}$. Using $f(x) = \frac{1}{x^2+1}$, which conclusion is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The \\integral converges, so the series converges."},
            {"id": "B", "value": "The \\integral diverges, so the series diverges."},
            {"id": "C", "value": "The \\integral test cannot be applied because $f(x)$ is decreasing."},
            {"id": "D", "value": "The series diverges because $1/(n^2+1) \\to 0$."}
        ]'::jsonb, 'A',
        'For $x \ge 1$, $f$ is positive, continuous, and decreasing, and $\int_1^{\infty} \frac{1}{x^2+1} \, dx$ converges, so the series converges by the \\integral test.',
        '\\integral_test_setup', ARRAY['\\integral_test_setup', 'sequence_limit_convergence'], ARRAY['\\integral_test_conditions_missed', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.4-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.4-P4', 'BC', 'BC_Series', 'BC_Series', '10.4', '10.4', 'MCQ', false, 3,
        'Refer to Table 10.4-A (`U10.4_Practice_Table1_FunctionValues.png`), where $f(x) = \frac{x-1}{x}$ is listed at \\integer inputs. Which condition needed for the \\integral test fails for $f$ on $[1, \infty)$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$f$ is not positive on $[1, \\infty)$."},
            {"id": "B", "value": "$f$ is not continuous on $[1, \\infty)$."},
            {"id": "C", "value": "$f$ is not decreasing on $[1, \\infty)$."},
            {"id": "D", "value": "$f$ does not satisfy $\\\\\\\\\lim_{x \\to \\infty} f(x) = 0$."}
        ]'::jsonb, 'C',
        'The table shows $f(x)$ increases toward $1$, so $f$ is not decreasing; that violates an \\integral test requirement.',
        '\\integral_test_setup', ARRAY['\\integral_test_setup', 'nth_term_test_divergence'], ARRAY['\\integral_test_conditions_missed', 'nth_term_test_misused'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.4_Practice_Table1_FunctionValues.png'
    );

    -- U10.4-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.4-P5', 'BC', 'BC_Series', 'BC_Series', '10.4', '10.4', 'MCQ', false, 2,
        'Suppose $a_n=f(n)$ where $f$ is positive, continuous, and decreasing on $[1,\infty)$. Which statement about the \\integral test is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "If $\\int f(x) \\\, dx$ converges, then $\\sum a_n$ converges."},
            {"id": "B", "value": "If $\\int f(x) \\\, dx$ converges, then $\\sum a_n$ diverges."},
            {"id": "C", "value": "If $\\int f(x) \\\, dx$ diverges, then $\\sum a_n$ converges."},
            {"id": "D", "value": "The \\integral test determines the exact sum of $\\sum a_n$."}
        ]'::jsonb, 'A',
        'Under the \\integral test conditions, $\sum a_n$ and $\int f(x) \, dx$ either both converge or both diverge; thus \\integral convergence implies series convergence.',
        '\\integral_test_setup', ARRAY['\\integral_test_setup', 'series_definition_partial_sums'], ARRAY['\\integral_test_conditions_missed', 'convergence_vs_sum_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.5-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.5-P1', 'BC', 'BC_Series', 'BC_Series', '10.5', '10.5', 'MCQ', false, 2,
        'Which statement about the $p$-series $\sum_{n=1}^{\infty} \frac{1}{n^p}$ is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It converges for all $p > 0$."},
            {"id": "B", "value": "It converges only when $p > 1$."},
            {"id": "C", "value": "It diverges for all $p > 1$."},
            {"id": "D", "value": "It converges only when $p < 1$."}
        ]'::jsonb, 'B',
        'A $p$-series $\sum \frac{1}{n^p}$ converges if and only if $p > 1$; it diverges for $p \le 1$.',
        'p_series_test', ARRAY['p_series_test', 'convergence_strategy_selection'], ARRAY['p_series_threshold_error', 'harmonic_vs_pseries_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.5-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.5-P2', 'BC', 'BC_Series', 'BC_Series', '10.5', '10.5', 'MCQ', false, 2,
        'Which series is the harmonic series?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=1}^{\\infty} \\frac{1}{n}$"},
            {"id": "B", "value": "$\\\sum_{n=1}^{\\infty} \\frac{1}{n^2}$"},
            {"id": "C", "value": "$\\\sum_{n=1}^{\\infty} \\frac{1}{2^n}$"},
            {"id": "D", "value": "$\\\sum_{n=1}^{\\infty} \\frac{1}{n!}$"}
        ]'::jsonb, 'A',
        'The harmonic series is $\sum_{n=1}^{\infty} \frac{1}{n}$, which is the $p$-series with $p = 1$ (and it diverges).',
        'harmonic_series_recognize', ARRAY['harmonic_series_recognize', 'p_series_test'], ARRAY['harmonic_vs_pseries_confusion', 'p_series_threshold_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.5-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.5-P3', 'BC', 'BC_Series', 'BC_Series', '10.5', '10.5', 'MCQ', false, 3,
        'Refer to Table 10.5-A (`U10.5_Practice_Table1_Harmonic_vs_p2.png`). Which statement is correct?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "Both $\\sum \\frac{1}{n}$ and $\\sum \\frac{1}{n^2}$ diverge because their terms approach $0$."},
            {"id": "B", "value": "$\\sum \\frac{1}{n}$ converges and $\\sum \\frac{1}{n^2}$ diverges."},
            {"id": "C", "value": "$\\sum \\frac{1}{n}$ diverges and $\\sum \\frac{1}{n^2}$ converges."},
            {"id": "D", "value": "Both series converge because the terms decrease."}
        ]'::jsonb, 'C',
        'The harmonic series $\sum \frac{1}{n}$ diverges ($p=1$), while $\sum \frac{1}{n^2}$ converges because it is a $p$-series with $p = 2 > 1$.',
        'p_series_test', ARRAY['p_series_test', 'harmonic_series_recognize'], ARRAY['harmonic_vs_pseries_confusion', 'p_series_threshold_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.5_Practice_Table1_Harmonic_vs_p2.png'
    );

    -- U10.5-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.5-P4', 'BC', 'BC_Series', 'BC_Series', '10.5', '10.5', 'MCQ', false, 3,
        'Determine whether the series $\sum_{n=1}^{\infty} \frac{1}{n^{\frac{3}{2}}}$ converges or diverges.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges ($p$-series with $p = \\frac{3}{2} > 1$)"},
            {"id": "B", "value": "Diverges ($p$-series with $p = \\frac{3}{2} > 1$)"},
            {"id": "C", "value": "Converges because $\\frac{1}{n}^{\\frac{3}{2}} \\to 0$"},
            {"id": "D", "value": "Diverges because $\\frac{1}{n}^{\\frac{3}{2}} \\to 0$"}
        ]'::jsonb, 'A',
        'This is a $p$-series with $p = \frac{3}{2} > 1$, so it converges.',
        'p_series_test', ARRAY['p_series_test', 'algebra_simplification_asymptotic'], ARRAY['p_series_threshold_error', 'algebra_simplification_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.5-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.5-P5', 'BC', 'BC_Series', 'BC_Series', '10.5', '10.5', 'MCQ', false, 3,
        'For which value of $p$ does the series $\sum_{n=1}^{\infty} \frac{1}{n^p}$ diverge?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$p = 2$"},
            {"id": "B", "value": "$p = \\frac{3}{2}$"},
            {"id": "C", "value": "$p = 1$"},
            {"id": "D", "value": "$p = 4$"}
        ]'::jsonb, 'C',
        'A $p$-series diverges when $p \le 1$; among the options, $p = 1$ gives the harmonic series, which diverges.',
        'p_series_test', ARRAY['p_series_test', 'convergence_strategy_selection'], ARRAY['p_series_threshold_error', 'harmonic_vs_pseries_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.6-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.6-P1', 'BC', 'BC_Series', 'BC_Series', '10.6', '10.6', 'MCQ', false, 3,
        'You know that $\sum_{n=1}^{\infty} \frac{1}{n^2}$ converges. Which inequality would be most useful to prove that $\sum_{n=1}^{\infty} \frac{1}{n^2+5}$ also converges by direct comparison?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1/(n^2+5) \\le \\frac{1}{n}^2$ for $n \\ge 1$"},
            {"id": "B", "value": "$1/(n^2+5) \\ge \\frac{1}{n}^2$ for $n \\ge 1$"},
            {"id": "C", "value": "$1/(n^2+5) \\le \\frac{1}{n}$ for $n \\ge 1$"},
            {"id": "D", "value": "$1/(n^2+5) \\ge \\frac{1}{n}$ for $n \\ge 1$"}
        ]'::jsonb, 'A',
        'Since $n^2+5 \ge n^2$, we have $\frac{1}{n^2+5} \le \frac{1}{n^2}$. Comparing to a known convergent series proves convergence.',
        'comparison_test_direct', ARRAY['comparison_test_direct', 'inequality_setup_comparison'], ARRAY['comparison_direction_wrong', 'inequality_setup_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.6-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.6-P2', 'BC', 'BC_Series', 'BC_Series', '10.6', '10.6', 'MCQ', false, 4,
        'Use \\\\\\\\limit comparison to determine the behavior of $\sum_{n=1}^{\infty} \frac{3n+1}{n^2+5}$ by comparing to $\sum_{n=1}^{\infty} \frac{1}{n}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges because the \\\\\\\\limit comparison constant is $0$."},
            {"id": "B", "value": "Diverges because the \\\\\\\\limit comparison constant is a finite positive number."},
            {"id": "C", "value": "Converges because it is smaller than $\\frac{1}{n}$."},
            {"id": "D", "value": "The \\\\\\\\limit comparison test cannot be used with $\\frac{1}{n}$."}
        ]'::jsonb, 'B',
        'Here $\frac{(3n+1)/(n^2+5)}{\frac{1}{n}} = \frac{n(3n+1)}{n^2+5} \to 3$, a finite positive constant, so both series share the same behavior. Since $\sum \frac{1}{n}$ diverges, this series diverges.',
        '\\\\\\\\limit_comparison_test', ARRAY['\\\\\\\\limit_comparison_test', 'algebra_simplification_asymptotic'], ARRAY['\\\\\\\\limit_comparison_limit_error', 'algebra_simplification_error', 'choose_wrong_comparison_series'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.6-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.6-P3', 'BC', 'BC_Series', 'BC_Series', '10.6', '10.6', 'MCQ', false, 4,
        'Refer to Table 10.6-A (`U10.6_Practice_Table1_LimitComparison.png`), which lists $a_n$, $b_n$, and $\frac{a_n}{b_n}$ where $b_n = \frac{3}{n}$. Which conclusion is correct?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "$\\sum a_n$ converges because $a_n/b_n$ is less than $1$ for the shown $n$."},
            {"id": "B", "value": "$\\sum a_n$ diverges because $a_n/b_n$ approaches a finite positive constant and $\\sum b_n$ diverges."},
            {"id": "C", "value": "$\\sum a_n$ converges because $a_n/b_n$ approaches $0$."},
            {"id": "D", "value": "No conclusion can be drawn because the table uses only finitely many terms."}
        ]'::jsonb, 'B',
        'The ratio column is trending toward a positive constant (near $1$), so by \\\\\\\\limit comparison $\sum a_n$ has the same behavior as $\sum \frac{3}{n}$, which diverges.',
        '\\\\\\\\limit_comparison_test', ARRAY['\\\\\\\\limit_comparison_test', 'convergence_strategy_selection'], ARRAY['\\\\\\\\limit_comparison_limit_error', 'choose_wrong_comparison_series'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.6_Practice_Table1_LimitComparison.png'
    );

    -- U10.6-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.6-P4', 'BC', 'BC_Series', 'BC_Series', '10.6', '10.6', 'MCQ', false, 3,
        'To test $\sum_{n=1}^{\infty} \frac{n}{n^3+1}$, which comparison is most appropriate?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Compare to $\\sum \\frac{1}{n^2}$ because $n/(n^3+1) \\le \\frac{1}{n}^2$ for $n \\ge 1$."},
            {"id": "B", "value": "Compare to $\\sum \\frac{1}{n}$ because $n/(n^3+1) \\ge \\frac{1}{n}$ for $n \\ge 1$."},
            {"id": "C", "value": "Compare to $\\sum 1$ because $n/(n^3+1) \\ge 1$ for $n \\ge 1$."},
            {"id": "D", "value": "Compare to $\\sum n$ because $n/(n^3+1) \\approx n$ for large $n$."}
        ]'::jsonb, 'A',
        'Since $n^3+1 \ge n^3$, we have $\frac{n}{n^3+1} \le \frac{n}{n^3} = \frac{1}{n^2}$. Comparing to a convergent $p$-series proves convergence.',
        'comparison_test_direct', ARRAY['comparison_test_direct', 'p_series_test'], ARRAY['comparison_direction_wrong', 'strategy_test_choice_wrong'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.6-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.6-P5', 'BC', 'BC_Series', 'BC_Series', '10.6', '10.6', 'MCQ', false, 3,
        'For large $n$, $\frac{2n^2+1}{n^3-4n}$ behaves most like which term, making it a good choice for \\\\\\\\limit comparison?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\frac{1}{n}$"},
            {"id": "B", "value": "$\\frac{1}{n}^2$"},
            {"id": "C", "value": "$\\frac{1}{n}^3$"},
            {"id": "D", "value": "$n$"}
        ]'::jsonb, 'A',
        'Leading terms give $\\frac{2n^2}{n^3}=\\frac{2}{n}$, so $\\frac{1}{n}$ is the correct comparison type (harmonic-like).',
        '\\\\\\\\limit_comparison_test', ARRAY['\\\\\\\\limit_comparison_test', 'algebra_simplification_asymptotic'], ARRAY['choose_wrong_comparison_series', 'algebra_simplification_error', '\\\\\\\\limit_comparison_limit_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.7-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.7-P1', 'BC', 'BC_Series', 'BC_Series', '10.7', '10.7', 'MCQ', false, 3,
        'Consider the series $\sum_{n=1}^{\infty} \frac{(-1)^{n+1}}{n}$. Which statement is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "It converges absolutely because $\\sum \\frac{1}{n}$ converges."},
            {"id": "B", "value": "It converges conditionally by the alternating series test."},
            {"id": "C", "value": "It diverges because the terms alternate."},
            {"id": "D", "value": "It diverges because $\\frac{1}{n} \\to 0$."}
        ]'::jsonb, 'B',
        'The terms alternate, $\\frac{1}{n}$ decreases, and $\\frac{1}{n}\\to 0$, so the series converges by AST, but not absolutely because $\\sum \\frac{1}{n}$ diverges.',
        'alternating_series_test', ARRAY['alternating_series_test', 'sequence_limit_convergence'], ARRAY['ast_conditions_missed', '\\\\\\\\limit_to_zero_not_checked'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.7-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.7-P2', 'BC', 'BC_Series', 'BC_Series', '10.7', '10.7', 'MCQ', false, 4,
        'Consider the series $\sum_{n=1}^{\infty} (-1)^n \frac{n}{n+1}$. Which conclusion is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges by AST because $n/(n+1)$ decreases and approaches $0$."},
            {"id": "B", "value": "Converges by AST because $n/(n+1) \\to 1$."},
            {"id": "C", "value": "Diverges because $n/(n+1)$ does not approach $0$."},
            {"id": "D", "value": "Converges absolutely because alternating signs guarantee absolute convergence."}
        ]'::jsonb, 'C',
        'A necessary condition for any series to converge is $a_n \to 0$. Here $\frac{n}{n+1} \to 1$, so the terms do not approach $0$ and the series diverges.',
        'alternating_series_test', ARRAY['alternating_series_test', 'monotonicity_check_sequence'], ARRAY['ast_conditions_missed', 'monotonicity_assumed_not_verified'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.7-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.7-P3', 'BC', 'BC_Series', 'BC_Series', '10.7', '10.7', 'MCQ', false, 3,
        'Refer to Table 10.7-A (`U10.7_Practice_Table1_AlternatingTerms.png`), where $a_n = \frac{(-1)^{n+1}}{n}$. Which condition is needed (in addition to $|a_n| \to 0$) to apply the alternating series test?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "The terms must be positive (no alternating signs)."},
            {"id": "B", "value": "The absolute values $|a_n|$ must be eventually decreasing."},
            {"id": "C", "value": "The partial sums must be increasing."},
            {"id": "D", "value": "The series must be geometric."}
        ]'::jsonb, 'B',
        'AST requires alternating signs, $|a_n|$ eventually decreasing, and $|a_n| \to 0$.',
        'alternating_series_test', ARRAY['alternating_series_test', 'monotonicity_check_sequence'], ARRAY['ast_conditions_missed', 'monotonicity_assumed_not_verified'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.7_Practice_Table1_AlternatingTerms.png'
    );

    -- U10.7-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.7-P4', 'BC', 'BC_Series', 'BC_Series', '10.7', '10.7', 'MCQ', false, 3,
        'For an alternating series that satisfies the alternating series test, which statement about the error after $N$ terms is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The error is always exactly $a_N$."},
            {"id": "B", "value": "The error satisfies $|R_N| \\le |a_{N+1}|$."},
            {"id": "C", "value": "The error satisfies $|R_N| \\le \\\sum_{n=N+1}^{\\infty} |a_n|$ and equals that sum."},
            {"id": "D", "value": "The error is bounded by $|a_N - a_{N+1}|$."}
        ]'::jsonb, 'B',
        'If AST applies, then the alternating series remainder satisfies $|R_N| \le |a_{N+1}|$.',
        'alternating_series_error_bound', ARRAY['alternating_series_error_bound', 'alternating_series_test'], ARRAY['alt_error_bound_misapplied', 'next_term_not_used_for_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.7-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.7-P5', 'BC', 'BC_Series', 'BC_Series', '10.7', '10.7', 'MCQ', false, 4,
        'Which series is best suited to be tested first with the alternating series test?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "$\\sum (-1)^{n+1} \\frac{1}{n^{\\frac{3}{2}}}$"},
            {"id": "C", "value": "$\\sum \\frac{2^n}{n}$"},
            {"id": "D", "value": "$\\sum \\frac{1}{3^n}$"}
        ]'::jsonb, 'B',
        'Option B is explicitly alternating and has a decreasing magnitude that approaches $0$, matching AST conditions.',
        'alternating_series_test', ARRAY['alternating_series_test', 'convergence_strategy_selection'], ARRAY['strategy_test_choice_wrong', 'ast_conditions_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.8-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.8-P1', 'BC', 'BC_Series', 'BC_Series', '10.8', '10.8', 'MCQ', false, 3,
        'Apply the ratio test to $\sum_{n=1}^{\infty} \frac{n!}{3^n}$. Which \\\\\\\\limit is used?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\\\\\\\lim_{n \\to \\infty} |a_n/a_{n+1}|$"},
            {"id": "B", "value": "$\\\\\\\\\lim_{n \\to \\infty} |a_{n+1}/a_n|$"},
            {"id": "C", "value": "$\\\\\\\\\lim_{n \\to \\infty} a_n$"},
            {"id": "D", "value": "$\\\\\\\\\lim_{n \\to \\infty} a_n/n$"}
        ]'::jsonb, 'B',
        'The ratio test uses $L = \\\\\\\lim_{n \to \infty} \left|\frac{a_{n+1}}{a_n}\right|$ when the \\\\\\\\limit exists.',
        'ratio_test', ARRAY['ratio_test', '\\\\\\\\limit_computation'], ARRAY['ratio_test_limit_error', 'ratio_test_rule_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.8-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.8-P2', 'BC', 'BC_Series', 'BC_Series', '10.8', '10.8', 'MCQ', false, 4,
        'For $a_n = \frac{n!}{3^n}$, compute $|a_{n+1}/a_n|$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$(n+1)/3$"},
            {"id": "B", "value": "$3/(n+1)$"},
            {"id": "C", "value": "$\\frac{n}{3}$"},
            {"id": "D", "value": "$\\frac{3}{n}$"}
        ]'::jsonb, 'A',
        '$\frac{a_{n+1}}{a_n} = \frac{(n+1)!/3^{n+1}}{n!/3^n} = \frac{n+1}{3}$.',
        'ratio_test', ARRAY['ratio_test', 'factorial_algebra_simplify'], ARRAY['factorial_cancel_error', 'ratio_test_limit_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.8-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.8-P3', 'BC', 'BC_Series', 'BC_Series', '10.8', '10.8', 'MCQ', false, 4,
        'Refer to Table 10.8-A (`U10.8_Practice_Table1_RatioValues.png`) for $a_n = \frac{n!}{2^n}$. Based on the ratio test, what is the behavior of $\sum_{n=1}^{\infty} a_n$?', 'image', 'symbolic',
        '[
            {"id": "A", "value": "Converges because $|a_{n+1}/a_n| < 1$ for the shown values."},
            {"id": "B", "value": "Diverges because $|a_{n+1}/a_n|$ grows beyond $1$ as $n$ increases."},
            {"id": "C", "value": "Converges absolutely because the terms are positive."},
            {"id": "D", "value": "The ratio test is inconclusive because the ratio is not constant."}
        ]'::jsonb, 'B',
        'Here $\frac{a_{n+1}}{a_n} = \frac{n+1}{2} \to \infty$, so $L > 1$ and the series diverges by the ratio test.',
        'ratio_test', ARRAY['ratio_test', '\\interpret_ratio_test_outcome'], ARRAY['ratio_test_rule_misread', 'inconclusive_case_misread'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.8_Practice_Table1_RatioValues.png'
    );

    -- U10.8-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.8-P4', 'BC', 'BC_Series', 'BC_Series', '10.8', '10.8', 'MCQ', false, 3,
        'The ratio test gives $L = \\\\\\\lim_{n \to \infty} |a_{n+1}/a_n| = 1$. What can you conclude?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "The series converges."},
            {"id": "B", "value": "The series diverges."},
            {"id": "C", "value": "The ratio test is inconclusive."},
            {"id": "D", "value": "The series is geometric."}
        ]'::jsonb, 'C',
        'If $L=1$, the ratio test is inconclusive; the series may converge or diverge depending on other structure.',
        'ratio_test', ARRAY['ratio_test', '\\interpret_ratio_test_outcome'], ARRAY['ratio_test_rule_misread', 'inconclusive_case_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.8-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.8-P5', 'BC', 'BC_Series', 'BC_Series', '10.8', '10.8', 'MCQ', false, 4,
        'Which series is typically best matched to the ratio test as a first choice?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sum \\frac{1}{n^2}$"},
            {"id": "B", "value": "$\\sum \\frac{\\ln(n)}{n}$"},
            {"id": "C", "value": "$\\sum \\frac{n!}{5^n}$"},
            {"id": "D", "value": "$\\sum \\frac{1}{n}$"}
        ]'::jsonb, 'C',
        'Factorials and exponentials often simplify cleanly with $\frac{a_{n+1}}{a_n}$, making the ratio test the natural first choice.',
        'ratio_test', ARRAY['ratio_test', 'convergence_strategy_selection'], ARRAY['strategy_test_choice_wrong', 'ratio_test_rule_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.9-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.9-P1', 'BC', 'BC_Series', 'BC_Series', '10.9', '10.9', 'MCQ', false, 4,
        'Determine the type of convergence of $\sum_{n=1}^{\infty} (-1)^{n+1} \frac{1}{\sqrt{n}}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges absolutely"},
            {"id": "B", "value": "Converges conditionally"},
            {"id": "C", "value": "Diverges"},
            {"id": "D", "value": "The ratio test is inconclusive, so no conclusion"}
        ]'::jsonb, 'B',
        'The alternating series test applies because $\frac{1}{\sqrt{n}}$ decreases and approaches $0$, so the series converges. But $\sum |a_n| = \sum \frac{1}{\sqrt{n}}$ is a $p$-series with $p = \frac{1}{2} \le 1$, so it diverges. Therefore the convergence is conditional.',
        'convergence_strategy_selection', ARRAY['convergence_strategy_selection', 'alternating_series_test'], ARRAY['strategy_test_choice_wrong', 'ast_conditions_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.9-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.9-P2', 'BC', 'BC_Series', 'BC_Series', '10.9', '10.9', 'MCQ', false, 4,
        'Determine the type of convergence of $\sum_{n=1}^{\infty} (-1)^n \frac{1}{n^2}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges absolutely"},
            {"id": "B", "value": "Converges conditionally"},
            {"id": "C", "value": "Diverges"},
            {"id": "D", "value": "Converges, but the type cannot be determined"}
        ]'::jsonb, 'A',
        'Check absolute convergence: $\sum |a_n| = \sum \frac{1}{n^2}$ is a $p$-series with $p = 2 > 1$, so it converges. Therefore the original series converges absolutely.',
        'convergence_strategy_selection', ARRAY['convergence_strategy_selection', 'p_series_test'], ARRAY['p_series_threshold_error', 'harmonic_vs_pseries_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.9-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.9-P3', 'BC', 'BC_Series', 'BC_Series', '10.9', '10.9', 'MCQ', false, 4,
        'Refer to Table 10.9-A (`U10.9_Practice_Table1_AbsVsCond.png`) for $a_n = \frac{(-1)^{n+1}}{\sqrt{n}}$. Which statement is correct?', 'image', 'table',
        '[
            {"id": "A", "value": "Because $|a_n| \\to 0$, $\\sum |a_n|$ converges."},
            {"id": "B", "value": "Because $|a_n|$ decreases to $0$, $\\sum a_n$ converges by AST."},
            {"id": "C", "value": "Because $a_n$ alternates, $\\sum a_n$ converges absolutely."},
            {"id": "D", "value": "Because $|a_n|$ is positive, $\\sum a_n$ diverges."}
        ]'::jsonb, 'B',
        'The table supports that $|a_n|$ decreases and approaches $0$, so $\sum a_n$ converges by the alternating series test (AST). This does not imply absolute convergence.',
        'convergence_strategy_selection', ARRAY['convergence_strategy_selection', 'alternating_series_test'], ARRAY['strategy_test_choice_wrong', '\\\\\\\\limit_to_zero_not_checked'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.9_Practice_Table1_AbsVsCond.png'
    );

    -- U10.9-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.9-P4', 'BC', 'BC_Series', 'BC_Series', '10.9', '10.9', 'MCQ', false, 3,
        'You find that an alternating series converges by the alternating series test. What is the correct next step to determine whether it is absolute or conditional?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Stop; AST already proves absolute convergence."},
            {"id": "B", "value": "Test $\\sum |a_n|$ for convergence."},
            {"id": "C", "value": "Test $\\sum a_n$ again with the ratio test until it is conclusive."},
            {"id": "D", "value": "Check whether $a_n$ is eventually increasing."}
        ]'::jsonb, 'B',
        'AST only proves convergence (often conditional). To classify the type, you must test the absolute-value series $\sum |a_n|$.',
        'convergence_strategy_selection', ARRAY['convergence_strategy_selection', 'ratio_test'], ARRAY['ratio_test_rule_misread', 'inconclusive_case_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.9-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.9-P5', 'BC', 'BC_Series', 'BC_Series', '10.9', '10.9', 'MCQ', false, 4,
        'Determine the type of convergence of $\sum_{n=1}^{\infty} (-1)^{n+1} \frac{1}{n}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges absolutely"},
            {"id": "B", "value": "Converges conditionally"},
            {"id": "C", "value": "Diverges because it is harmonic"},
            {"id": "D", "value": "Diverges because alternating series always diverge"}
        ]'::jsonb, 'B',
        'The alternating harmonic series converges by AST, but $\sum |a_n| = \sum \frac{1}{n}$ diverges, so the convergence is conditional.',
        'convergence_strategy_selection', ARRAY['convergence_strategy_selection', 'comparison_test_direct'], ARRAY['comparison_direction_wrong', 'strategy_test_choice_wrong'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.10-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.10-P1', 'BC', 'BC_Series', 'BC_Series', '10.10', '10.10', 'MCQ', false, 3,
        'An alternating series satisfies the alternating series test. Which statement about the remainder $R_N$ after $N$ terms is correct?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$|R_N| \\le |a_N|$"},
            {"id": "B", "value": "$|R_N| \\le |a_{N+1}|$"},
            {"id": "C", "value": "$|R_N| \\le |a_{N+1}|/2$"},
            {"id": "D", "value": "$|R_N| \\le \\\sum_{n=N+1}^{\\infty} |a_n|$"}
        ]'::jsonb, 'B',
        'For an alternating series that meets AST conditions, the alternating series error bound gives $|R_N| \le |a_{N+1}|$.',
        'alternating_series_error_bound', ARRAY['alternating_series_error_bound', 'alternating_series_test'], ARRAY['alt_error_bound_misapplied', 'next_term_not_used_for_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.10-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.10-P2', 'BC', 'BC_Series', 'BC_Series', '10.10', '10.10', 'MCQ', false, 4,
        'Let $\sum_{n=1}^{\infty}(-1)^{n+1}\frac{1}{n^2+1}$ satisfy the alternating series test. What is the smallest $N$ that guarantees the alternating series approximation error is less than $0.01$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$N=4$"},
            {"id": "B", "value": "$N=9$"},
            {"id": "C", "value": "$N=10$"},
            {"id": "D", "value": "$N=11$"}
        ]'::jsonb, 'B',
        'We need $|R_N| \le |a_{N+1}| < 0.01$. Here $|a_{N+1}| = \frac{1}{(N+1)^2+1} < 0.01$, which implies $(N+1)^2+1 > 100$, so $(N+1)^2 > 99$. The smallest \\integer $N$ satisfying this is $N = 9$ (\\\\\\\\since $10^2 > 99$).',
        'alternating_series_error_bound', ARRAY['alternating_series_error_bound', '\\\\\\\\limit_computation'], ARRAY['alt_error_bound_misapplied', 'next_term_not_used_for_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.10-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.10-P3', 'BC', 'BC_Series', 'BC_Series', '10.10', '10.10', 'MCQ', false, 3,
        'Refer to Table 10.10-A (U10.10_Practice_Table1_ErrorBounds.png). For which listed $N$ is the guaranteed error bound less than $0.01$?', 'image', 'table',
        '[
            {"id": "A", "value": "$N=2$ only"},
            {"id": "B", "value": "$N=4$ and $N=6$ only"},
            {"id": "C", "value": "$N=6$ and $N=8$ only"},
            {"id": "D", "value": "All listed $N$ values"}
        ]'::jsonb, 'D',
        'Each listed value shows $|a_{N+1}|$ (the error bound). In the table, all listed bounds are below $0.01$, so each listed $N$ guarantees error less than $0.01$.',
        'alternating_series_error_bound', ARRAY['alternating_series_error_bound', 'alternating_series_test'], ARRAY['alt_error_bound_misapplied', 'next_term_not_used_for_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.10_Practice_Table1_ErrorBounds.png'
    );

    -- U10.10-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.10-P4', 'BC', 'BC_Series', 'BC_Series', '10.10', '10.10', 'MCQ', false, 4,
        'An alternating series satisfies AST, and you compute the partial sum $S_N$. Which statement is correct about where the true sum $S$ lies relative to $S_N$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$S$ is always greater than $S_N$."},
            {"id": "B", "value": "$S$ is always less than $S_N$."},
            {"id": "C", "value": "$S$ lies within $\\pm|a_{N+1}|$ of $S_N$."},
            {"id": "D", "value": "$S$ must equal $S_N$ when $N$ is even."}
        ]'::jsonb, 'C',
        'The alternating series estimation theorem guarantees $|S - S_N| = |R_N| \le |a_{N+1}|$, so the true sum lies within that \\interval around $S_N$.',
        'alternating_series_error_bound', ARRAY['alternating_series_error_bound', '\\interpret_error_bound_direction'], ARRAY['alt_error_bound_misapplied', 'rounding_error_bound_direction'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.10-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.10-P5', 'BC', 'BC_Series', 'BC_Series', '10.10', '10.10', 'MCQ', false, 4,
        'You want the error in an alternating series approximation to be less than $0.0005$. Which setup correctly expresses the goal using the alternating series error bound?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Choose $N$ so that $|a_N| < 0.0005$."},
            {"id": "B", "value": "Choose $N$ so that $|a_{N+1}| < 0.0005$."},
            {"id": "C", "value": "Choose $N$ so that $\\\sum_{n=N+1}^{\\infty} |a_n| < 0.0005$."},
            {"id": "D", "value": "Choose $N$ so that $|a_{N+1} - a_N| < 0.0005$."}
        ]'::jsonb, 'B',
        'For AST-series, $|R_N| \le |a_{N+1}|$. To guarantee error $< 0.0005$, require $|a_{N+1}| < 0.0005$.',
        'alternating_series_error_bound', ARRAY['alternating_series_error_bound', 'convergence_strategy_selection'], ARRAY['next_term_not_used_for_error', 'alt_error_bound_misapplied'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.11-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.11-P1', 'BC', 'BC_Series', 'BC_Series', '10.11', '10.11', 'MCQ', false, 3,
        'What is the 2nd-degree Maclaurin polynomial for $e^x$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1 + x + x^\\frac{2}{2}$"},
            {"id": "B", "value": "$1 + x + x^2$"},
            {"id": "C", "value": "$1 + \\frac{x}{2} + x^\\frac{2}{2}$"},
            {"id": "D", "value": "$1 + x + x^\\frac{3}{6}$"}
        ]'::jsonb, 'A',
        'For $e^x$, all derivatives at $0$ equal $1$, so $T_2(x)=1+x+\\frac{x^2}{2}$.',
        'taylor_polynomial_approximation', ARRAY['taylor_polynomial_approximation', 'maclaurin_series_known'], ARRAY['taylor_derivative_coefficient_error', 'factorial_in_denominator_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.11-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.11-P2', 'BC', 'BC_Series', 'BC_Series', '10.11', '10.11', 'MCQ', false, 4,
        'Use the 2nd-degree Maclaurin polynomial for $e^x$ to approximate $e^{0.2}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$1.02$"},
            {"id": "B", "value": "$1.20$"},
            {"id": "C", "value": "$1.22$"},
            {"id": "D", "value": "$1.24$"}
        ]'::jsonb, 'C',
        '$T_2(x) = 1 + x + \frac{x^2}{2}$, so $T_2(0.2) = 1 + 0.2 + \frac{0.2^2}{2} = 1 + 0.2 + 0.02 = 1.22$.',
        'taylor_approximation_eval', ARRAY['taylor_approximation_eval', 'taylor_polynomial_approximation'], ARRAY['substitution_error', 'factorial_in_denominator_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.11-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.11-P3', 'BC', 'BC_Series', 'BC_Series', '10.11', '10.11', 'MCQ', false, 3,
        'Refer to Table 10.11-A (`U10.11_Practice_Table1_TaylorApprox.png`), where $T_2(x) = 1 + x + \frac{x^2}{2}$ approximates $e^x$. Which statement is best supported by the table?', 'image', 'table',
        '[
            {"id": "A", "value": "The approximation is most accurate when $x$ is closest to $0$."},
            {"id": "B", "value": "The approximation is equally accurate for all shown $x$ values."},
            {"id": "C", "value": "The approximation always overestimates $e^x$."},
            {"id": "D", "value": "The approximation becomes more accurate as $|x|$ increases."}
        ]'::jsonb, 'A',
        'A Maclaurin polynomial is centered at $0$, so accuracy is typically best near $x=0$. The table’s smallest errors occur for the smallest $|x|$ values.',
        'taylor_approximation_eval', ARRAY['taylor_approximation_eval', 'taylor_polynomial_approximation'], ARRAY['center_mismatch', 'overgeneralizing_accuracy'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.11_Practice_Table1_TaylorApprox.png'
    );

    -- U10.11-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.11-P4', 'BC', 'BC_Series', 'BC_Series', '10.11', '10.11', 'MCQ', false, 4,
        'A Taylor polynomial centered at $x=0$ is required to match a function’s value, first derivative, and \\second derivative at $0$. What is the minimum degree needed?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Degree 0"},
            {"id": "B", "value": "Degree 1"},
            {"id": "C", "value": "Degree 2"},
            {"id": "D", "value": "Degree 3"}
        ]'::jsonb, 'C',
        'To match through the \\second derivative at the center, you need terms up to $x^2$, so the minimum degree is 2.',
        'taylor_polynomial_approximation', ARRAY['taylor_polynomial_approximation', 'derivative_matching_at_center'], ARRAY['degree_mismatch', 'derivative_order_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.11-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.11-P5', 'BC', 'BC_Series', 'BC_Series', '10.11', '10.11', 'MCQ', false, 4,
        'What is the 2nd-degree Maclaurin polynomial for $\\\\\\\ln(1+x)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$x + x^\\frac{2}{2}$"},
            {"id": "B", "value": "$x - x^\\frac{2}{2}$"},
            {"id": "C", "value": "$1 + x - x^\\frac{2}{2}$"},
            {"id": "D", "value": "$x - x^\\frac{2}{2} + x^\\frac{3}{3}$"}
        ]'::jsonb, 'B',
        '$\\\\\\\ln(1+x) = x - \frac{x^2}{2} + \dots$, so the 2nd-degree polynomial is $x - \frac{x^2}{2}$.',
        'maclaurin_series_known', ARRAY['maclaurin_series_known', 'taylor_polynomial_approximation'], ARRAY['sign_error_series', 'factorial_in_denominator_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.12-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.12-P1', 'BC', 'BC_Series', 'BC_Series', '10.12', '10.12', 'MCQ', false, 4,
        'A Taylor polynomial of degree $n$ is used to approximate $f(x)$ near $x = a$. Which expression is the Lagrange error bound form?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$|R_n(x)| \\le M |x-a|^\\frac{n}{n}!$"},
            {"id": "B", "value": "$|R_n(x)| \\le M |x-a|^{n+1}/(n+1)!$"},
            {"id": "C", "value": "$|R_n(x)| \\le |f^{(n+1)}(x)|/(n+1)!$"},
            {"id": "D", "value": "$|R_n(x)| \\le M |x-a|$"}
        ]'::jsonb, 'B',
        'The Lagrange form uses the next derivative: $|R_n(x)| \le M \frac{|x-a|^{n+1}}{(n+1)!}$, where $M$ bounds $|f^{(n+1)}(z)|$ on the \\interval.',
        'lagrange_error_bound', ARRAY['lagrange_error_bound', 'taylor_polynomial_approximation'], ARRAY['lagrange_formula_misread', 'factorial_in_denominator_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.12-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.12-P2', 'BC', 'BC_Series', 'BC_Series', '10.12', '10.12', 'MCQ', false, 4,
        'Use $T_2(x) = 1 + x + \frac{x^2}{2}$ to approximate $e^{0.2}$. A valid Lagrange error bound is $|R_2(0.2)| \le M \frac{0.2^3}{3!}$ on $[0, 0.2]$. What is $M$ for $f(x) = e^x$ on this \\interval?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$M = e^0$"},
            {"id": "B", "value": "$M = e^{0.2}$"},
            {"id": "C", "value": "$M = 0.2$"},
            {"id": "D", "value": "$M = 2$"}
        ]'::jsonb, 'B',
        'For $e^x$, all derivatives equal $e^x$. On $[0, 0.2]$, the maximum of $e^x$ occurs at $x=0.2$, so $M = e^{0.2}$.',
        'lagrange_error_bound', ARRAY['lagrange_error_bound', 'taylor_approximation_eval'], ARRAY['lagrange_bound_max_derivative_misidentified', 'factorial_in_denominator_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.12-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.12-P3', 'BC', 'BC_Series', 'BC_Series', '10.12', '10.12', 'MCQ', false, 3,
        'Refer to Table 10.12-A (U10.12_Practice_Table1_LagrangeBound.png), which lists bounds for using $T_2$ at $0$ to approximate $e^x$. Which statement is correct?', 'image', 'table',
        '[
            {"id": "A", "value": "The bound depends on |x|^2 because the polynomial degree is 2."},
            {"id": "B", "value": "For x>0, a valid choice is M=e^x on [0,x]."},
            {"id": "C", "value": "For x<0, M must be e^x because that is always largest."},
            {"id": "D", "value": "The bound is exact, so it equals the true error."}
        ]'::jsonb, 'B',
        'For degree 2, the remainder uses the 3rd derivative and $|x|^\frac{3}{3}!$. For $e^x$ on $[0,x]$ with $x>0$, the maximum occurs at the right endpoint, so $M=e^x$ is valid.',
        'lagrange_error_bound', ARRAY['lagrange_error_bound', '\\interpret_error_bound_direction'], ARRAY['lagrange_bound_max_derivative_misidentified', 'power_factor_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.12_Practice_Table1_LagrangeBound.png'
    );

    -- U10.12-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.12-P4', 'BC', 'BC_Series', 'BC_Series', '10.12', '10.12', 'MCQ', false, 4,
        'Approximate $\\\\\\\sin(0.1)$ using the 1st-degree Maclaurin polynomial $T_1(x) = x$. A Lagrange error bound is $|R_1(0.1)| \le M \frac{0.1^2}{2!}$ on $[0, 0.1]$. For $\\\\\\\sin x$, what is a valid choice for $M$ on this \\interval?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$M = 0$"},
            {"id": "B", "value": "$M = 1$"},
            {"id": "C", "value": "$M = 0.1$"},
            {"id": "D", "value": "$M = \\sin(0.1)$"}
        ]'::jsonb, 'B',
        'For $T_1$, we bound $|f''(z)|$. If $f(x) = \\\\\\\sin x$, then $f''(z) = -\\\\\\\sin z$, and $|-\\\\\\\sin z| \le 1$ on any \\interval, so $M = 1$ is valid.',
        'lagrange_error_bound', ARRAY['lagrange_error_bound', 'maclaurin_series_known'], ARRAY['lagrange_bound_max_derivative_misidentified', 'factorial_in_denominator_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.12-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.12-P5', 'BC', 'BC_Series', 'BC_Series', '10.12', '10.12', 'MCQ', false, 4,
        'When using a Lagrange error bound for a Taylor approximation from $a$ to $x$, which \\interval must be used to choose $M$ (a maximum of the next derivative)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Only at the \\\\\\\\single point z=x"},
            {"id": "B", "value": "Only at the \\\\\\\\single point z=a"},
            {"id": "C", "value": "On the entire \\interval between a and x"},
            {"id": "D", "value": "On any convenient \\interval, \\\\\\\\since the bound is always exact"}
        ]'::jsonb, 'C',
        'The Lagrange bound requires a maximum (or upper bound) for $|f^{(n+1)}(z)|$ on the whole \\interval connecting $a$ and $x$.',
        'lagrange_error_bound', ARRAY['lagrange_error_bound', 'convergence_strategy_selection'], ARRAY['lagrange_bound_max_derivative_misidentified', '\\interval_wrong_for_M'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.13-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.13-P1', 'BC', 'BC_Series', 'BC_Series', '10.13', '10.13', 'MCQ', false, 4,
        'Find the radius of convergence of $\sum_{n=1}^{\infty} n \left(\frac{x}{3}\right)^n$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$R = 1$"},
            {"id": "B", "value": "$R = 3$"},
            {"id": "C", "value": "$R = \\frac{1}{3}$"},
            {"id": "D", "value": "$R = \\infty$"}
        ]'::jsonb, 'B',
        'Using the ratio test on $a_n = n \left(\frac{x}{3}\right)^n$ gives convergence when $\left|\frac{x}{3}\right| < 1$, so $|x| < 3$ and $R = 3$.',
        'power_series_radius_interval', ARRAY['power_series_radius_interval', 'ratio_test'], ARRAY['ratio_test_rule_misread', 'radius_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.13-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.13-P2', 'BC', 'BC_Series', 'BC_Series', '10.13', '10.13', 'MCQ', false, 5,
        'Find the \\interval of convergence of $\sum_{n=1}^{\infty} \frac{(x-1)^n}{n}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$(-\\infty, \\infty)$"},
            {"id": "B", "value": "$(0, 2)$"},
            {"id": "C", "value": "$[0, 2)$"},
            {"id": "D", "value": "$(0, 2]$"}
        ]'::jsonb, 'C',
        'Ratio test gives $|x-1| < 1 \Rightarrow 0 < x < 2$. Check endpoints: at $x=0$, the series is $\sum \frac{(-1)^n}{n}$ which converges (alternating harmonic). At $x=2$, it is $\sum \frac{1}{n}$ which diverges. So $[0, 2)$.',
        'power_series_radius_interval', ARRAY['power_series_radius_interval', 'endpoint_convergence_check'], ARRAY['endpoint_test_skipped', '\\interval_notation_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.13-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.13-P3', 'BC', 'BC_Series', 'BC_Series', '10.13', '10.13', 'MCQ', false, 3,
        'Refer to Figure 10.13-A (U10.13_Practice_Image1_Interval.png). Which \\interval is shown?', 'image', 'graph',
        '[
            {"id": "A", "value": "(0, 2)"},
            {"id": "B", "value": "[0, 2)"},
            {"id": "C", "value": "(0, 2]"},
            {"id": "D", "value": "[0, 2]"}
        ]'::jsonb, 'B',
        'The left endpoint at $0$ is closed (filled dot) and the right endpoint at $2$ is open (hollow dot), so the \\interval is $[0,2)$.',
        '\\interval_notation_interpretation', ARRAY['\\interval_notation_interpretation', 'power_series_radius_interval'], ARRAY['\\interval_notation_error', 'endpoint_open_closed_confusion'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.13_Practice_Image1_Interval.png'
    );

    -- U10.13-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.13-P4', 'BC', 'BC_Series', 'BC_Series', '10.13', '10.13', 'MCQ', false, 4,
        'Find the radius of convergence of $\sum_{n=1}^{\infty} \frac{(x+2)^n}{n^2 5^n}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$R = 2$"},
            {"id": "B", "value": "$R = 5$"},
            {"id": "C", "value": "$R = \\frac{1}{5}$"},
            {"id": "D", "value": "$R = \\infty$"}
        ]'::jsonb, 'B',
        'Ratio test gives convergence when $\left|\frac{x+2}{5}\right| < 1$, so $|x+2| < 5$ and the radius is $R = 5$ (center at $-2$).',
        'power_series_radius_interval', ARRAY['power_series_radius_interval', 'series_center_shift'], ARRAY['center_shift_error', 'radius_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.13-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.13-P5', 'BC', 'BC_Series', 'BC_Series', '10.13', '10.13', 'MCQ', false, 5,
        'Find the \\interval of convergence of $\sum_{n=0}^{\infty} (-1)^n \frac{(x-3)^{2n}}{2n+1}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$(2, 4)$"},
            {"id": "B", "value": "$[2, 4]$"},
            {"id": "C", "value": "$[2, 4)$"},
            {"id": "D", "value": "$(2, 4]$"}
        ]'::jsonb, 'B',
        'Let $u = (x-3)^2 \ge 0$. Ratio test gives $u < 1 \Rightarrow |x-3| < 1 \Rightarrow 2 < x < 4$. At $x=2$ or $x=4$, the series becomes $\sum (-1)^n \frac{1}{2n+1}$, which converges by AST. So the \\interval is $[2, 4]$.',
        'power_series_radius_interval', ARRAY['power_series_radius_interval', 'endpoint_convergence_check'], ARRAY['endpoint_test_skipped', 'even_power_substitution_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.14-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.14-P1', 'BC', 'BC_Series', 'BC_Series', '10.14', '10.14', 'MCQ', false, 3,
        'Which power series represents $\frac{1}{1-x}$ for $|x| < 1$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} x^n$"},
            {"id": "B", "value": "$\\\sum_{n=1}^{\\infty} x^n$"},
            {"id": "C", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^n$"},
            {"id": "D", "value": "$\\\sum_{n=0}^{\\infty} x^\\frac{n}{n}!$"}
        ]'::jsonb, 'A',
        'The geometric series gives $\frac{1}{1-x} = \sum_{n=0}^{\infty} x^n$ for $|x| < 1$.',
        'maclaurin_series_known', ARRAY['maclaurin_series_known', 'geometric_series_from_function'], ARRAY['missing_common_ratio', 'index_shift_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.14-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.14-P2', 'BC', 'BC_Series', 'BC_Series', '10.14', '10.14', 'MCQ', false, 3,
        'Which power series represents $\frac{1}{1+x}$ for $|x| < 1$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} x^n$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^n$"},
            {"id": "C", "value": "$\\\sum_{n=1}^{\\infty} (-1)^n x^n$"},
            {"id": "D", "value": "$\\\sum_{n=0}^{\\infty} x^{2n}/(2n+1)$"}
        ]'::jsonb, 'B',
        'Use $\frac{1}{1-(-x)} = \sum_{n=0}^{\infty} (-x)^n = \sum_{n=0}^{\infty} (-1)^n x^n$ for $|x| < 1$.',
        'known_series_transform', ARRAY['known_series_transform', 'maclaurin_series_known'], ARRAY['sign_error_series', 'missing_common_ratio'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.14-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.14-P3', 'BC', 'BC_Series', 'BC_Series', '10.14', '10.14', 'MCQ', false, 4,
        'Refer to Table 10.14-A (`U10.14_Practice_Table1_Coefficients.png`). The shown coefficients match the beginning of which series?', 'image', 'table',
        '[
            {"id": "A", "value": "$\\ln(1+x) = x - x^\\frac{2}{2} + x^\\frac{3}{3} - x^\\frac{4}{4} + \\\dots$"},
            {"id": "B", "value": "$1/(1-x) = 1 + x + x^2 + x^3 + \\\dots$"},
            {"id": "C", "value": "$e^x = 1 + x + x^\\frac{2}{2} + x^\\frac{3}{6} + \\\dots$"},
            {"id": "D", "value": "$\\sin x = x - x^\\frac{3}{6} + x^\\frac{5}{120} - \\\dots$"}
        ]'::jsonb, 'A',
        'The coefficients $1, -\frac{1}{2}, \frac{1}{3}, -\frac{1}{4}, \dots$ for powers $x, x^2, x^3, x^4, \dots$ match the Maclaurin series for $\\\\\\\ln(1+x)$.',
        'identify_series_from_coefficients', ARRAY['identify_series_from_coefficients', 'maclaurin_series_known'], ARRAY['sign_error_series', 'pattern_misread'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.14_Practice_Table1_Coefficients.png'
    );

    -- U10.14-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.14-P4', 'BC', 'BC_Series', 'BC_Series', '10.14', '10.14', 'MCQ', false, 4,
        'Which series equals $\arctan(x)$ for $|x| \le 1$ (with convergence at endpoints in the usual sense)?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^{2n+1}/(2n+1)$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} x^{2n+1}/(2n+1)$"},
            {"id": "C", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^\\frac{n}{n}!$"},
            {"id": "D", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^{2n}/(2n+1)$"}
        ]'::jsonb, 'A',
        'The Maclaurin series for $\arctan(x)$ is $x - \frac{x^3}{3} + \frac{x^5}{5} - \dots = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n+1}}{2n+1}$.',
        'maclaurin_series_known', ARRAY['maclaurin_series_known', 'pattern_identification'], ARRAY['power_pattern_error', 'sign_error_series'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.14-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.14-P5', 'BC', 'BC_Series', 'BC_Series', '10.14', '10.14', 'MCQ', false, 5,
        'Let $e^x = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \dots$. In the Maclaurin expansion of $x^2 e^x$, what is the coefficient of $x^3$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$0$"},
            {"id": "B", "value": "$1$"},
            {"id": "C", "value": "$\\frac{1}{2}$"},
            {"id": "D", "value": "$\\frac{1}{6}$"}
        ]'::jsonb, 'B',
        'Multiply by $x^2$: $x^2e^x = x^2 + x^3 + \frac{x^4}{2} + \dots$. The coefficient of $x^3$ is $1$.',
        'series_operations_multiply', ARRAY['series_operations_multiply', 'maclaurin_series_known'], ARRAY['coefficient_extraction_error', 'term_degree_tracking_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.15-P1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.15-P1', 'BC', 'BC_Series', 'BC_Series', '10.15', '10.15', 'MCQ', false, 3,
        'Which power series represents $\frac{1}{1-2x}$ for $|x| < \frac{1}{2}$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} (2x)^n$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} 2^n x^{n+1}$"},
            {"id": "C", "value": "$\\\sum_{n=0}^{\\infty} (-2x)^n$"},
            {"id": "D", "value": "$\\\sum_{n=1}^{\\infty} (2x)^n$"}
        ]'::jsonb, 'A',
        'Using $\frac{1}{1-r} = \sum_{n=0}^{\infty} r^n$ with $r = 2x$ gives $\frac{1}{1-2x} = \sum_{n=0}^{\infty} (2x)^n$.',
        'known_series_transform', ARRAY['known_series_transform', 'geometric_series_from_function'], ARRAY['missing_common_ratio', 'sign_error_series'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.15-P2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10.15-P2', 'BC', 'BC_Series', 'BC_Series', '10.15', '10.15', 'MCQ', false, 4,
        'Refer to Table 10.15-A (`U10.15_Practice_Table1_SeriesForms.png`). Which function could produce $A(x) = 1 + 2x + 4x^2 + 8x^3 + \dots$?', 'image', 'table',
        '[
            {"id": "A", "value": "$1/(1-2x)$"},
            {"id": "B", "value": "$1/(1-x)$"},
            {"id": "C", "value": "$\\ln(1+x)$"},
            {"id": "D", "value": "$e^x$"}
        ]'::jsonb, 'A',
        'The coefficients match $\sum (2x)^n = 1 + 2x + 4x^2 + 8x^3 + \dots$, which equals $\frac{1}{1-2x}$.',
        'identify_series_from_coefficients', ARRAY['identify_series_from_coefficients', 'known_series_transform'], ARRAY['pattern_misread', 'index_shift_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.15_Practice_Table1_SeriesForms.png'
    );

    -- U10.15-P3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.15-P3', 'BC', 'BC_Series', 'BC_Series', '10.15', '10.15', 'MCQ', false, 5,
        'Given $\frac{1}{1-x} = \sum_{n=0}^{\infty} x^n$ for $|x| < 1$, what series represents $\frac{1}{(1-x)^2}$ for $|x| < 1$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} n x^{n-1}$"},
            {"id": "B", "value": "$\\\sum_{n=1}^{\\infty} n x^{n-1}$"},
            {"id": "C", "value": "$\\\sum_{n=0}^{\\infty} (n+1)x^n$"},
            {"id": "D", "value": "$\\\sum_{n=0}^{\\infty} x^n/(n+1)$"}
        ]'::jsonb, 'C',
        'Differentiate: $\frac{1}{(1-x)^2} = \sum_{n=1}^{\infty} n x^{n-1}$. Re-index with $n = k+1$ to get $\sum_{k=0}^{\infty} (k+1)x^k$.',
        'series_operations_derivative', ARRAY['series_operations_derivative', 'geometric_series_from_function'], ARRAY['term_by_term_diff_misapplied', 'radius_not_updated_correctly'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.15-P4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.15-P4', 'BC', 'BC_Series', 'BC_Series', '10.15', '10.15', 'MCQ', false, 4,
        'Given $\frac{1}{1+x} = \sum_{n=0}^{\infty} (-1)^n x^n$ for $|x| < 1$, a series for $\\\\\\\ln(1+x)$ is', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^{n+1}/(n+1)$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^n/(n+1)$"},
            {"id": "C", "value": "$\\\sum_{n=1}^{\\infty} (-1)^n x^n/(n+1)$"},
            {"id": "D", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^{2n+1}/(2n+1)$"}
        ]'::jsonb, 'A',
        'Integrate term-by-term: $\\\\\\\ln(1+x) = \int \frac{1}{1+x} \, dx = \sum_{n=0}^{\infty} (-1)^n \frac{x^{n+1}}{n+1}$ (choose constant so $\\\\\\\ln(1+0) = 0$).',
        'series_operations_integral', ARRAY['series_operations_integral', 'geometric_series_from_function'], ARRAY['term_by_term_integration_misapplied', 'constant_of_integration_missing'],
        NOW(), NOW(), 'published', 1
    );

    -- U10.15-P5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10.15-P5', 'BC', 'BC_Series', 'BC_Series', '10.15', '10.15', 'MCQ', false, 5,
        'Let $\frac{1}{1-x} = \sum_{n=0}^{\infty} x^n$. In the power series for $\frac{x^2}{1-x}$, what is the coefficient of $x^5$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "0"},
            {"id": "B", "value": "1"},
            {"id": "C", "value": "2"},
            {"id": "D", "value": "5"}
        ]'::jsonb, 'B',
        '$\frac{x^2}{1-x} = x^2 \sum_{n=0}^{\infty} x^n = \sum_{n=0}^{\infty} x^{n+2} = x^2 + x^3 + x^4 + x^5 + \dots$, so the coefficient of $x^5$ is $1$.',
        'series_coefficient_extraction', ARRAY['series_coefficient_extraction', 'series_operations_multiply'], ARRAY['term_degree_tracking_error', 'coefficient_extraction_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q1
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q1', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'If $\sum_{n=1}^{\infty} a_n$ converges, which must be true?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\\\\\\\lim_{n \\to \\infty} a_n = 0$"},
            {"id": "B", "value": "$\\\\\\\\\lim_{n \\to \\infty} a_n = 1$"},
            {"id": "C", "value": "$a_n$ is decreasing for all $n$"},
            {"id": "D", "value": "$a_n > 0$ for all $n$"}
        ]'::jsonb, 'A',
        'A necessary condition for series convergence is $\\\\\\\\lim a_n=0$.',
        'series_convergence_divergence_basic', ARRAY['series_convergence_divergence_basic'], ARRAY['confusing_sequence_vs_series'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q2
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q2', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Does $\sum_{n=1}^{\infty} \frac{n}{n+1}$ converge?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges by comparison with $\\sum \\frac{1}{n}^2$"},
            {"id": "B", "value": "Converges by telescoping"},
            {"id": "C", "value": "Diverges because $\\\\\\\\\lim_{n \\to \\infty} \\frac{n}{n+1} \\neq 0$"},
            {"id": "D", "value": "Converges because terms are less than $1$"}
        ]'::jsonb, 'C',
        '$\\\\\\\lim_{n \to \infty} \frac{n}{n+1} = 1 \ne 0$, so the series diverges by the $n$th-term test.',
        'nth_term_test_divergence', ARRAY['nth_term_test_divergence', 'series_convergence_divergence_basic'], ARRAY['nth_term_test_misused'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q3
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10-UT-Q3', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'Refer to Table 10.2-A (`U10.2_Practice_Table1_GeometricTerms.png`). The listed terms have common ratio $r$. Which expression gives the sum to infinity (when it exists) if the first term is $a$?', 'image', 'table',
        '[
            {"id": "A", "value": "$a/(1-r)$"},
            {"id": "B", "value": "$a(1-r)$"},
            {"id": "C", "value": "$a/(1+r)$"},
            {"id": "D", "value": "$a/(r-1)$ for $|r| > 1$"}
        ]'::jsonb, 'A',
        'A geometric series with $|r| < 1$ sums to $\frac{a}{1-r}$.',
        'geometric_series_identification', ARRAY['geometric_series_identification', 'geometric_series_sum'], ARRAY['common_ratio_misidentified'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.2_Practice_Table1_GeometricTerms.png'
    );

    -- U10-UT-Q4
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q4', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Which condition is required to apply the Integral Test to $\\sum a_n$ with $a_n=f(n)$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$f(x)$ is continuous, positive, and decreasing on $[1, \\infty)$"},
            {"id": "B", "value": "$f(x)$ is periodic"},
            {"id": "C", "value": "$f(x)$ is even"},
            {"id": "D", "value": "$f(x)$ is bounded above by $1$"}
        ]'::jsonb, 'A',
        'Integral Test requires $f$ to be continuous, positive, and decreasing for large $x$.',
        '\\integral_test_setup', ARRAY['\\integral_test_setup', 'p_series_identification'], ARRAY['\\integral_test_requirements_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q5
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q5', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'For what values of $p$ does $\\sum_{n=1}^{\\infty}\\frac{1}{n^p}$ converge?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$p > 0$"},
            {"id": "B", "value": "$p > 1$"},
            {"id": "C", "value": "$p \\ge 1$"},
            {"id": "D", "value": "All real $p$"}
        ]'::jsonb, 'B',
        'A $p$-series converges exactly when $p>1$.',
        'p_series_identification', ARRAY['p_series_identification', 'comparison_test_basic'], ARRAY['p_series_rule_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q6
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q6', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Determine the behavior of $\sum_{n=1}^{\infty} \frac{1}{n^2+1}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges by comparison with $\\sum \\frac{1}{n}^2$"},
            {"id": "B", "value": "Diverges by comparison with $\\sum \\frac{1}{n}^2$"},
            {"id": "C", "value": "Diverges by the $n$th-term test"},
            {"id": "D", "value": "Converges only if alternating"}
        ]'::jsonb, 'A',
        'Since $\frac{1}{n^2+1} < \frac{1}{n^2}$ and $\sum \frac{1}{n^2}$ converges, the given series converges by comparison.',
        'comparison_test_basic', ARRAY['comparison_test_basic', 'p_series_identification'], ARRAY['comparison_direction_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q7
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q7', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Use \\\\\\\\limit comparison to determine $\sum_{n=1}^{\infty} \frac{3n^2+1}{n^3-4}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges (like $\\sum \\frac{1}{n}^2$)"},
            {"id": "B", "value": "Diverges (like $\\sum \\frac{1}{n}$)"},
            {"id": "C", "value": "Diverges because it is geometric"},
            {"id": "D", "value": "Converges by alternating series test"}
        ]'::jsonb, 'B',
        'For large $n$, $\frac{3n^2+1}{n^3-4} \sim \frac{3}{n}$. Compare with $\sum \frac{1}{n}$, which diverges, so the series diverges.',
        '\\\\\\\\limit_comparison_test', ARRAY['\\\\\\\\limit_comparison_test', 'p_series_identification'], ARRAY['\\\\\\\\limit_comparison_setup_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q8
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q8', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Which condition is required for the Alternating Series Test to guarantee convergence of $\\sum (-1)^n b_n$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$b_n$ increases and $\\\\\\\\\lim_{n \\to \\infty} b_n = 0$"},
            {"id": "B", "value": "$b_n$ decreases and $\\\\\\\\\lim_{n \\to \\infty} b_n = 0$"},
            {"id": "C", "value": "$\\sum b_n$ converges absolutely"},
            {"id": "D", "value": "$b_n$ is bounded above by $1$"}
        ]'::jsonb, 'B',
        'AST requires $b_n$ decreasing (eventually) and $\\\\\\\lim b_n = 0$.',
        'alternating_series_test', ARRAY['alternating_series_test'], ARRAY['alternating_test_conditions_missed'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q9
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10-UT-Q9', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Refer to Table 10.6-A (`U10.6_Practice_Table1_LimitComparison.png`). The table suggests $\\\\\\\lim \frac{a_n}{b_n} = L$ with $0 < L < \infty$. What conclusion is valid?', 'image', 'table',
        '[
            {"id": "A", "value": "$\\sum a_n$ and $\\sum b_n$ both converge or both diverge"},
            {"id": "B", "value": "$\\sum a_n$ always converges"},
            {"id": "C", "value": "$\\sum a_n$ always diverges"},
            {"id": "D", "value": "No conclusion can be drawn"}
        ]'::jsonb, 'A',
        'Limit Comparison Test: if $\\\\\\\lim a_n/b_n = L$ with $0 < L < \infty$, the two series share the same convergence behavior.',
        '\\\\\\\\limit_comparison_test', ARRAY['\\\\\\\\limit_comparison_test', 'comparison_test_basic'], ARRAY['\\\\\\\\limit_comparison_setup_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.6_Practice_Table1_LimitComparison.png'
    );

    -- U10-UT-Q10
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q10', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Use the Ratio Test to determine $\sum_{n=1}^{\infty} \frac{n!}{3^n}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "Converges because the \\\\\\\\limit is $\\frac{1}{3}$"},
            {"id": "B", "value": "Diverges because the ratio \\\\\\\\limit is $\\infty$"},
            {"id": "C", "value": "Converges by $p$-series"},
            {"id": "D", "value": "Diverges by the Integral Test"}
        ]'::jsonb, 'B',
        '$\frac{a_{n+1}}{a_n} = \frac{(n+1)!/3^{n+1}}{n!/3^n} = \frac{n+1}{3} \to \infty > 1$, so the series diverges.',
        'ratio_test', ARRAY['ratio_test'], ARRAY['ratio_test_rule_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q11
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q11', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Which series is an example of conditional convergence?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\sum \\frac{1}{n}^2$"},
            {"id": "B", "value": "$\\sum (-1)^n \\frac{1}{n}$"},
            {"id": "C", "value": "$\\sum (-1)^n \\frac{1}{n}^2$"},
            {"id": "D", "value": "$\\sum \\frac{1}{n}$"}
        ]'::jsonb, 'B',
        '$\sum (-1)^n \frac{1}{n}$ converges by AST but $\sum \left|(-1)^n \frac{1}{n}\right| = \sum \frac{1}{n}$ diverges, so it is conditional.',
        'absolute_vs_conditional', ARRAY['absolute_vs_conditional', 'alternating_series_test'], ARRAY['absolute_vs_conditional_confusion'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q12
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q12', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'For an alternating series with decreasing $b_n$ and $\\\\\\\lim b_n = 0$, the error after using $n$ terms satisfies', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$|R_n| \\le b_{n+1}$"},
            {"id": "B", "value": "$|R_n| \\le b_n^2$"},
            {"id": "C", "value": "$|R_n| \\ge b_{n+1}$"},
            {"id": "D", "value": "$|R_n| \\le b_{n+1}/2$"}
        ]'::jsonb, 'A',
        'Alternating Series Error Bound: the magnitude of the remainder is at most the first omitted term $b_{n+1}$.',
        'alternating_error_bound', ARRAY['alternating_error_bound', 'alternating_series_test'], ARRAY['error_bound_misinterpreted'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q13
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q13', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'What is the 3rd-degree Maclaurin polynomial for $\\\\\\\sin x$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "x + x^\\frac{3}{6}"},
            {"id": "B", "value": "x - x^\\frac{3}{6}"},
            {"id": "C", "value": "1 - x + x^\\frac{2}{2}"},
            {"id": "D", "value": "x - x^\\frac{2}{2}"}
        ]'::jsonb, 'B',
        '$\\\\\\\sin x = x - \frac{x^3}{6} + \dots$, so the degree-3 Maclaurin polynomial is $x - \frac{x^3}{6}$.',
        'taylor_polynomial_approximation', ARRAY['taylor_polynomial_approximation', 'maclaurin_series_known'], ARRAY['factorial_in_denominator_error', 'degree_mismatch'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q14
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10-UT-Q14', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Refer to Table 10.11-A (U10.11_Practice_Table1_TaylorApprox.png). Based on the table, for which $x$ is $T_2(x)$ the most accurate approximation to $e^x$?', 'image', 'table',
        '[
            {"id": "A", "value": "The x value with smallest |x|"},
            {"id": "B", "value": "The largest positive x shown"},
            {"id": "C", "value": "The most negative x shown"},
            {"id": "D", "value": "All shown x values are equally accurate"}
        ]'::jsonb, 'A',
        'A Maclaurin polynomial is centered at $0$, so accuracy is generally best near $x=0$; the table’s smallest errors align with smallest $|x|$.',
        'taylor_approximation_eval', ARRAY['taylor_approximation_eval', 'taylor_polynomial_approximation'], ARRAY['overgeneralizing_accuracy'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.11_Practice_Table1_TaylorApprox.png'
    );

    -- U10-UT-Q15
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q15', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'A correct Lagrange error bound for a degree-$n$ Taylor approximation about $a$ uses', 'text', 'symbolic',
        '[
            {"id": "A", "value": "M |x-a|^\\frac{n}{n}!"},
            {"id": "B", "value": "M |x-a|^{n+1}/(n+1)!"},
            {"id": "C", "value": "|x-a|^{n+1}/n!"},
            {"id": "D", "value": "M |x-a|"}
        ]'::jsonb, 'B',
        'The remainder uses the next derivative, so the power is $n+1$ and the factorial is $(n+1)!$.',
        'lagrange_error_bound', ARRAY['lagrange_error_bound'], ARRAY['lagrange_formula_misread'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q16
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10-UT-Q16', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 3,
        'Refer to Figure 10.13-A (U10.13_Practice_Image1_Interval.png). Which \\interval is shown?', 'image', 'graph',
        '[
            {"id": "A", "value": "(0, 2)"},
            {"id": "B", "value": "[0, 2)"},
            {"id": "C", "value": "(0, 2]"},
            {"id": "D", "value": "[0, 2]"}
        ]'::jsonb, 'B',
        'Closed at 0 and open at 2, so $[0,2)$.',
        '\\interval_notation_interpretation', ARRAY['\\interval_notation_interpretation'], ARRAY['\\interval_notation_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10.13_Practice_Image1_Interval.png'
    );

    -- U10-UT-Q17
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q17', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Find the \\interval of convergence of $\sum_{n=1}^{\infty} \frac{(x-2)^n}{n}$.', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$(1, 3)$"},
            {"id": "B", "value": "$[1, 3)$"},
            {"id": "C", "value": "$(1, 3]$"},
            {"id": "D", "value": "$[1, 3]$"}
        ]'::jsonb, 'B',
        'Radius from ratio test is $|x-2| < 1 \Rightarrow 1 < x < 3$. At $x=1$, $\sum \frac{(-1)^n}{n}$ converges; at $x=3$, $\sum \frac{1}{n}$ diverges. So $[1, 3)$.',
        'power_series_radius_interval', ARRAY['power_series_radius_interval', 'endpoint_convergence_check'], ARRAY['endpoint_test_skipped'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q18
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q18', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 4,
        'Given $\frac{1}{1-x} = \sum_{n=0}^{\infty} x^n$, which series equals $\frac{1}{(1-x)^2}$?', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} (n+1)x^n$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} n x^n$"},
            {"id": "C", "value": "$\\\sum_{n=0}^{\\infty} x^n/(n+1)$"},
            {"id": "D", "value": "$\\\sum_{n=1}^{\\infty} x^n$"}
        ]'::jsonb, 'A',
        'Differentiate and re-index to get $\frac{1}{(1-x)^2} = \sum_{n=0}^{\infty} (n+1)x^n$.',
        'series_operations_derivative', ARRAY['series_operations_derivative', 'geometric_series_from_function'], ARRAY['term_by_term_diff_misapplied'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q19
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version
    ) VALUES (
        'U10-UT-Q19', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Using $\frac{1}{1+x} = \sum_{n=0}^{\infty} (-1)^n x^n$, a correct series for $\\\\\\\ln(1+x)$ is', 'text', 'symbolic',
        '[
            {"id": "A", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^{n+1}/(n+1)$"},
            {"id": "B", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^n/(n+1)$"},
            {"id": "C", "value": "$\\\sum_{n=1}^{\\infty} (-1)^n x^\\frac{n}{n}$"},
            {"id": "D", "value": "$\\\sum_{n=0}^{\\infty} (-1)^n x^{2n}/(2n+1)$"}
        ]'::jsonb, 'A',
        'Integrate term-by-term and choose the constant so the value at $x=0$ is 0: $\\\\\\\ln(1+x) = \sum_{n=0}^{\infty} (-1)^n \frac{x^{n+1}}{n+1}$.',
        'series_operations_integral', ARRAY['series_operations_integral', 'maclaurin_series_known'], ARRAY['constant_of_integration_missing', 'index_shift_error'],
        NOW(), NOW(), 'published', 1
    );

    -- U10-UT-Q20
    INSERT INTO public.questions (
        title, course, topic, topic_id, section_id, sub_topic_id, type, calculator_allowed, difficulty,
        prompt, prompt_type, representation_type,
        options, correct_option_id, explanation,
        primary_skill_id, skill_tags, error_tags,
        created_at, updated_at, status, version, notes
    ) VALUES (
        'U10-UT-Q20', 'BC', 'BC_Series', 'BC_Series', 'unit_test', 'unit_test', 'MCQ', false, 5,
        'Refer to the Unit 10 Test Table (`U10_UT_Table1_Coeffs.png`) for $f(x) = \sum_{n=0}^{\infty} a_n x^n$. What is the coefficient of $x^4$ in $x^2 f(x)$?', 'image', 'table',
        '[
            {"id": "A", "value": "$a_4$"},
            {"id": "B", "value": "$a_2$"},
            {"id": "C", "value": "$a_6$"},
            {"id": "D", "value": "$a_0$"}
        ]'::jsonb, 'B',
        '$x^2 f(x) = \sum a_n x^{n+2}$. To get $x^4$, we need $n+2 = 4 \Rightarrow n = 2$, so the coefficient is $a_2$.',
        'series_coefficient_extraction', ARRAY['series_coefficient_extraction', 'identify_series_from_coefficients'], ARRAY['coefficient_extraction_error', 'term_degree_tracking_error'],
        NOW(), NOW(), 'published', 1, 'Uses image file: U10_UT_Table1_Coeffs.png'
    );

END $$;
