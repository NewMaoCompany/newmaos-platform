-- Mass Insert Script for Unit 5 Skills and Error Tags
-- Generated based on user request (Unit 5: Analytical Applications of Differentiation)
-- Target Unit ID: ABBC_Analytical

-- 1. Schema Migration: Ensure skills has 'prerequisites' column (Standard check)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'skills' AND column_name = 'prerequisites') THEN
        ALTER TABLE public.skills ADD COLUMN prerequisites text[];
    END IF;
END $$;

-- 2. Insert Skills (Unit 5)
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
('mvt_conditions', 'Mean Value Theorem Conditions (Continuity & Differentiability)', 'ABBC_Analytical', '{}'),
('mvt_application', 'Applying Mean Value Theorem (Finding c)', 'ABBC_Analytical', '{"mvt_conditions"}'),
('avg_vs_instant_rate_link', 'Linking Average and Instantaneous Rates (MVT Context)', 'ABBC_Analytical', '{"mvt_application"}'),
('evt_application', 'Extreme Value Theorem Application (Existence of Extrema)', 'ABBC_Analytical', '{}'),
('candidates_test_absolute', 'Candidates Test for Absolute Extrema (Endpoints & Critical Points)', 'ABBC_Analytical', '{"evt_application"}'),
('global_vs_local_extrema', 'Distinguishing Global vs Local Extrema', 'ABBC_Analytical', '{"candidates_test_absolute"}'),
('critical_points_find', 'Finding Critical Points (Derivative is 0 or Undefined)', 'ABBC_Analytical', '{}'),
('method_selection_unit5', 'Strategy Selection for Unit 5 (MVT vs EVT vs IVT)', 'ABBC_Analytical', '{}'),
('increasing_decreasing_from_derivative', 'Determining Increasing/Decreasing Intervals from f''', 'ABBC_Analytical', '{"critical_points_find"}'),
('first_derivative_test', 'First Derivative Test for Local Extrema', 'ABBC_Analytical', '{"increasing_decreasing_from_derivative"}')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    unit = EXCLUDED.unit,
    prerequisites = EXCLUDED.prerequisites;

-- 3. Insert Error Tags (Unit 5)
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
('mvt_conditions_missed', 'Missing Conditions for MVT (Continuity/Differentiability)', 'MVT', 3, 'ABBC_Analytical'),
('mvt_conclusion_misread', 'Misinterpreting MVT Conclusion (f''(c) vs Average Rate)', 'MVT', 3, 'ABBC_Analytical'),
('evt_requires_closed_interval_missed', 'Applying EVT to Open Interval (Missing Closed Interval Condition)', 'EVT', 4, 'ABBC_Analytical'),
('candidates_test_missing_endpoints', 'Forgetting to Check Endpoints in Candidates Test', 'Optimization', 4, 'ABBC_Analytical'),
('global_vs_local_confusion', 'Confusing Local Max/Min with Absolute Max/Min', 'Optimization', 3, 'ABBC_Analytical'),
('absolute_extrema_compare_error', 'Error Comparing Values for Absolute Extrema', 'Optimization', 2, 'ABBC_Analytical'),
('sign_chart_interval_error', 'Misinterpreting Sign Chart Intervals', 'Analysis', 3, 'ABBC_Analytical'),
('critical_points_incomplete', 'Missing Critical Points (e.g. Undefined F'')', 'Analysis', 4, 'ABBC_Analytical'),
('increasing_decreasing_sign_flipped', 'Confusing f''>0 with f''<0 (Inc vs Dec)', 'Analysis', 3, 'ABBC_Analytical'),
('wrong_method_choice_unit5', 'Choosing Wrong Method (Local vs Global Tools)', 'Strategy', 3, 'ABBC_Analytical'),
('first_derivative_test_misapplied', 'Misapplying First Derivative Test (Sign Change)', 'Analysis', 4, 'ABBC_Analytical')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    severity = EXCLUDED.severity,
    unit = EXCLUDED.unit;
