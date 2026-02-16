-- Insert missing skills for Unit 1.1 - 1.4

INSERT INTO public.skills (id, name, unit, prerequisites)
VALUES
  -- Unit 1.1
  ('SK_AVG_ROC', 'Average Rate of Change', 'Unit 1', '{}'),
  ('SK_SECANT_SLOPE', 'Slope of Secant Line', 'Unit 1', '{}'),
  ('SK_FUNC_EVAL', 'Function Evaluation', 'Unit 1', '{}'),
  ('SK_UNITS_INTERPRET', 'Interpreting Units of Rates', 'Unit 1', '{}'),
  ('SK_LIMIT_DEF_DERIV', 'Limit Definition of Derivative', 'Unit 1', '{}'),
  ('SK_DIFF_QUOTIENT', 'Difference Quotient', 'Unit 1', '{}'),
  ('SK_LIMIT_CONCEPT', 'Concept of a Limit', 'Unit 1', '{}'),
  ('SK_RADICAL_RATIONALIZE', 'Rationalizing Radical Expressions', 'Unit 1', '{}'),
  ('SK_ALGEBRA_SIMPLIFY', 'Algebraic Simplification', 'Unit 1', '{}'),
  
  -- Unit 1.2
  ('SK_LIMIT_NOTATION', 'Limit Notation', 'Unit 1', '{}'),
  ('SK_ONE_SIDED_LIMIT', 'One-Sided Limits', 'Unit 1', '{}'),
  ('SK_LIMIT_EXISTENCE', 'Existence of Limits', 'Unit 1', '{}'),
  ('SK_ABS_VALUE_SIGN', 'Absolute Value and Sign Analysis', 'Unit 1', '{}'),
  ('SK_LIMIT_LAWS', 'Limit Laws', 'Unit 1', '{}'),
  ('SK_PIECEWISE_LIMIT', 'Limit of Piecewise Function', 'Unit 1', '{}'),
  
  -- Unit 1.3
  ('SK_READ_LIMIT_FROM_GRAPH', 'Reading Limits from Graphs', 'Unit 1', '{}'),
  ('SK_LIMIT_DNE_FROM_GRAPH', 'Identifying DNE Limits Graphically', 'Unit 1', '{}'),
  ('SK_INFINITE_LIMIT_FROM_GRAPH', 'Infinite Limits from Graphs', 'Unit 1', '{}'),
  ('SK_LIMIT_EXISTS_GRAPHICALLY', 'Graphical Existence of Limits', 'Unit 1', '{}'),
  
  -- Unit 1.4
  ('SK_ESTIMATE_LIMIT_FROM_TABLE', 'Estimating Limits from Tables', 'Unit 1', '{}'),
  ('SK_LIMIT_DNE_FROM_TABLE', 'Identifying DNE Limits from Tables', 'Unit 1', '{}'),
  ('SK_INFINITE_LIMIT_FROM_TABLE', 'Infinite Limits from Tables', 'Unit 1', '{}'),
  ('SK_LIMIT_NOTATION_INFINITE', 'Infinite Limit Notation', 'Unit 1', '{}'),
  ('SK_AVERAGE_RATE_LIMIT', 'Limit of Average Rates', 'Unit 1', '{}'),

  -- Unit 1.5
  ('SK_DIRECT_SUBSTITUTION', 'Limits by Direct Substitution', 'Unit 1', '{}'),
  ('SK_GRAPH_LIMIT_READ', 'Reading Limits from Graph (General)', 'Unit 1', '{}'),
  ('SK_FUNCTION_COMPOSITION_LIMITS', 'Limits of Composite Functions', 'Unit 1', '{}'),
  ('SK_RATIONAL_LIMITS', 'Limits of Rational Functions', 'Unit 1', '{}'),

  -- Unit 1.6
  ('SK_ALGEBRAIC_LIMITS', 'Algebraic Manipulation of Limits', 'Unit 1', '{}'),
  ('SK_FACTOR_CANCEL', 'Factoring and Canceling', 'Unit 1', '{}'),
  ('SK_RATIONALIZE_CONJUGATE', 'Rationalizing with Conjugates', 'Unit 1', '{}'),
  ('SK_CONTINUITY_REMOVABLE', 'Removable Discontinuities', 'Unit 1', '{}'),

  -- Unit 1.7
  ('SK_LIMIT_PROCEDURE_SELECT', 'Selecting Limit Procedures', 'Unit 1', '{}'),
  ('SK_GRAPH_LIMIT_INTERP', 'Interpreting Limits from Graphs', 'Unit 1', '{}'),
  ('SK_ALG_LIMIT_EVAL', 'Algebraic Limit Evaluation', 'Unit 1', '{}'),
  ('SK_ONE_SIDED_LIMITS', 'One-Sided Limits (General)', 'Unit 1', '{}'),
  ('SK_INFINITE_LIMITS_ASYM', 'Infinite Limits and Asymptotes', 'Unit 1', '{}'),

  -- Unit 1.8
  ('SK_SQUEEZE', 'Squeeze Theorem', 'Unit 1', '{}'),
  ('SK_TRIG_BOUNDS', 'Trigonometric Bounds', 'Unit 1', '{}'),
  ('SK_INEQUALITY_BOUND', 'Inequality Bounding', 'Unit 1', '{}'),
  ('SK_ABS_INEQUAL', 'Absolute Value Inequalities', 'Unit 1', '{}'),

  -- Unit 1.9
  ('SK_LIMIT_GRAPH', 'Limits from Graphs', 'Unit 1', '{}'),
  ('SK_LIMIT_ALGEBRA', 'Limits from Algebraic Rules', 'Unit 1', '{}'),
  ('SK_VALUE_VS_LIMIT', 'Function Value vs. Limit', 'Unit 1', '{}'),
  ('SK_LIMIT_TABLE', 'Limits from Tables', 'Unit 1', '{}'),
  ('SK_ABSOLUTE_VALUE', 'Absolute Value Limits', 'Unit 1', '{}'),

  -- Unit 1.10
  ('SK_DISC_CLASSIFY', 'Classifying Discontinuities', 'Unit 1', '{}'),
  ('SK_DISC_REMOVABLE', 'Removable Discontinuity', 'Unit 1', '{}'),
  ('SK_INFINITE_LIMITS', 'Infinite Limits', 'Unit 1', '{}'),
  ('SK_VERT_ASYMPTOTE', 'Vertical Asymptotes', 'Unit 1', '{}'),
  ('SK_CONTINUITY_DEF', 'Definition of Continuity', 'Unit 1', '{}'),

  -- Unit 1.11
  ('SK_CONTINUITY_AT_A_POINT', 'Continuity at a Point', 'Unit 1', '{}'),
  ('SK_CONTINUITY_FROM_GRAPH', 'Continuity from Graph', 'Unit 1', '{}'),
  ('SK_SOLVE_FOR_PARAMETER', 'Solving for Parameters (Continuity)', 'Unit 1', '{}'),
  
  -- Unit 1.12
  ('SK_CONTINUITY_OVER_INTERVAL', 'Continuity over an Interval', 'Unit 1', '{}'),
  ('SK_DOMAIN_ENDPOINTS', 'Domain and Endpoints Continuity', 'Unit 1', '{}'),
  ('SK_IVT_APPLICATION', 'Intermediate Value Theorem', 'Unit 1', '{}'),

  -- Unit 1.13
  ('SK_REMOVABLE_DISCONTINUITY', 'Removable Discontinuities', 'Unit 1', '{}'),
  ('SK_ALGEBRAIC_SIMPLIFICATION', 'Algebraic Simplification', 'Unit 1', '{}'),
  ('SK_CONTINUITY_PARAMETER', 'Finding Parameters for Continuity', 'Unit 1', '{}'),

  -- Unit 1.14
  ('SK_INFINITE_LIMITS_VA', 'Infinite Limits and Vertical Asymptotes', 'Unit 1', '{}'),
  ('SK_ONE_SIDED_SIGN_ANALYSIS', 'One-Sided Sign Analysis', 'Unit 1', '{}'),
  ('SK_RATIONAL_VA_HOLE_ANALYSIS', 'Distinguishing Vertical Asymptotes from Holes', 'Unit 1', '{}'),

  -- Unit 1.15
  ('SK_LIMITS_INFINITY_HA_RULES', 'Limits at Infinity and Horizontal Asymptotes', 'Unit 1', '{}'),
  ('SK_RATIONAL_END_BEHAVIOR', 'End Behavior of Rational Functions', 'Unit 1', '{}'),
  ('SK_NUMERICAL_ESTIMATION_LIMITS', 'Numerical Estimation of Limits', 'Unit 1', '{}'),
  ('SK_GRAPH_INTERPRETATION_LIMITS', 'Interpretation of Limits from Graphs', 'Unit 1', '{}'),

  -- Unit 1.16
  ('SK_FUNCTION_CONTINUITY_CHECK', 'Checking Function Continuity', 'Unit 1', '{}'),
  ('SK_EQUATION_SETUP', 'Setting up Equations', 'Unit 1', '{}'),

  -- Unit 1 Unit Test (Aliases/General)
  ('SK_ALGEBRAIC_LIMIT', 'Algebraic Limits (General)', 'Unit 1', '{}'),
  ('SK_GRAPHICAL_LIMIT', 'Graphical Limits (General)', 'Unit 1', '{}'),
  ('SK_NUMERICAL_LIMIT', 'Numerical Limits (General)', 'Unit 1', '{}'),
  ('SK_STRATEGY_SELECTION', 'Limit Strategy Selection', 'Unit 1', '{}'),
  ('SK_SQUEEZE_THEOREM', 'Squeeze Theorem (General)', 'Unit 1', '{}'),
  ('SK_DISCONTINUITY_CLASS', 'Classification of Discontinuities', 'Unit 1', '{}'),
  ('SK_CONTINUITY_POINT', 'Continuity at a Point (General)', 'Unit 1', '{}'),
  ('SK_CONTINUITY_INTERVAL', 'Continuity on an Interval', 'Unit 1', '{}'),
  ('SK_REMOVE_REMOVABLE', 'Removing Removable Discontinuities', 'Unit 1', '{}'),
  ('SK_LIMITS_INFINITY_HA', 'Limits at Infinity and HA', 'Unit 1', '{}'),
  ('SK_IVT', 'Intermediate Value Theorem (General)', 'Unit 1', '{}')

ON CONFLICT (id) DO NOTHING;
