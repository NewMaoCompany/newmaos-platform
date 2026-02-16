
-- Insert missing skills for Unit 2.1 - 2.2

INSERT INTO public.skills (id, name, unit, prerequisites)
VALUES
  -- Unit 2.1
  ('SK_SLOPE_2PTS', 'Slope Between Two Points', 'Unit 2', '{}'),
  ('SK_INST_ROC', 'Instantaneous Rate of Change', 'Unit 2', '{}'),
  ('SK_LIMIT_INTUITION', 'Intuitive Understanding of Limits', 'Unit 2', '{}'),
  ('SK_INEQUALITY_REASONING', 'Inequality Reasoning', 'Unit 2', '{}'),
  
  -- Unit 2.2
  ('SK_DERIV_NOTATION', 'Derivative Notation', 'Unit 2', '{}'),
  ('SK_SYMBOL_INTERPRET', 'Symbolic Interpretation', 'Unit 2', '{}'),

  -- Unit 2.3
  ('SK_DERIV_ESTIMATE_NUMERICAL', 'Estimating Derivatives Numerically', 'Unit 2', '{}'),
  ('SK_GRAPH_INTERPRETATION', 'Interpreting Graphs for Derivatives', 'Unit 2', '{}'),
  ('SK_AVG_RATE_CHANGE', 'Average Rate of Change (General)', 'Unit 2', '{}'),
  ('SK_LIMIT_CONCEPT', 'Concept of Limits (General)', 'Unit 2', '{}'),

  -- Unit 2.4
  ('SK_DIFF_CONTINUITY', 'Relationship Between Differentiability and Continuity', 'Unit 2', '{}'),

  -- Unit 2.5
  ('SK_POWER_RULE', 'Power Rule', 'Unit 2', '{}'),
  ('SK_ALGEBRA_SIMPLIFY', 'Algebraic Simplification', 'Unit 2', '{}'),
  ('SK_EVAL_AT_POINT', 'Evaluating Derivatives at a Point', 'Unit 2', '{}'),

  -- Unit 2.6
  ('SK_DERIV_LINEARITY', 'Linearity of Differentiation (Sum/Difference)', 'Unit 2', '{}'),
  ('SK_CONST_RULE', 'Constant Rule', 'Unit 2', '{}'),

  -- Unit 2.7
  ('SK_DERIV_BASIC_TRANSC', 'Derivatives of Basic Transcendental Functions', 'Unit 2', '{}'),
  ('SK_ALG_EXP_LOG', 'Algebra with Exponents and Logs', 'Unit 2', '{}'),
  ('SK_TRIG_IDENT', 'Trigonometric Identities', 'Unit 2', '{}'),
  ('SK_UNITS_INTERPRET', 'Interpreting Units of Derivatives', 'Unit 2', '{}'),

  -- Unit 2.8
  ('SK_PRODUCT_RULE', 'Product Rule', 'Unit 2', '{}'),
  
  -- Unit 2.9
  ('SK_QUOTIENT_RULE', 'The Quotient Rule', 'Unit 2', '{}'),
  
  -- Unit 2.10
  ('SK_TRIG_DERIV_TAN', 'Derivative of Tangent', 'Unit 2', '{}'),
  ('SK_TRIG_DERIV_SEC', 'Derivative of Secant', 'Unit 2', '{}'),
  ('SK_TRIG_DERIV_COT', 'Derivative of Cotangent', 'Unit 2', '{}'),
  ('SK_TRIG_DERIV_CSC', 'Derivative of Cosecant', 'Unit 2', '{}'),
  
  -- Unit Test Skills
  ('SK_TABLE_READ', 'Reading Values from Tables', 'Unit 2', '{}'),
  ('SK_TRIG_DERIV', 'Derivatives of Sine and Cosine', 'Unit 2', '{}'),
  ('SK_LOG_DERIV', 'Derivative of Natural Logarithm', 'Unit 2', '{}'),
  ('SK_OTHER_TRIG', 'Derivatives of Other Trig Functions (Sec, Csc, Cot)', 'Unit 2', '{}'),
  ('SK_LIMIT_DEF', 'Limit Definition of Derivative', 'Unit 2', '{}'),
  ('SK_AVG_ROC', 'Average Rate of Change (Alias)', 'Unit 2', '{}'),
  ('SK_FUNC_EVAL', 'Function Evaluation', 'Unit 2', '{}'),
  ('SK_DIFF_CONT', 'Differentiability implies Continuity (Alias)', 'Unit 2', '{}'),
  ('SK_LINEARTY', 'Linearity of Differentiation (Alias)', 'Unit 2', '{}'),
  ('SK_GRAPH_READ', 'Reading Graphs', 'Unit 2', '{}')

ON CONFLICT (id) DO NOTHING;
