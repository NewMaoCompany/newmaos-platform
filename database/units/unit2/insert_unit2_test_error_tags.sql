-- Insert missing uppercase Error Tags for Unit 2 Unit Test
-- These map to specific misconceptions identified in the Unit Test questions.

INSERT INTO public.error_tags (id, name, category, severity, unit)
VALUES
  ('E_AVG_VS_INST', 'Confusing Average vs Instantaneous Rate', 'Conceptual', 3, 'Unit 2'),
  ('E_SIGN_ERROR', 'Sign Error', 'Algebra', 2, 'Unit 2'),
  ('E_NOTATION_MISMATCH', 'Derivative Notation Mismatch', 'Notation', 2, 'Unit 2'),
  ('E_PLUG_H_EQUALS_0', 'Incorrectly Plugging h=0 (Undefined)', 'Limit Definition', 3, 'Unit 2'),
  ('E_SECANT_TANGENT_CONFUSION', 'Confusing Secant and Tangent Lines', 'Conceptual', 3, 'Unit 2'),
  ('E_GRAPH_READ', 'Misreading Graph / Coordinates', 'Graphing', 2, 'Unit 2'),
  ('E_DIFF_IMPLIES_CONT', 'Misunderstanding Differentiability Implies Continuity', 'Conceptual', 4, 'Unit 2'),
  ('E_VALUE_VS_DERIV', 'Confusing Function Value with Derivative Value', 'Conceptual', 3, 'Unit 2'),
  ('E_RULE_MISAPPLIED', 'Differentiation Rule Misapplied', 'Procedural', 3, 'Unit 2'),
  ('E_TABLE_READ', 'Misreading Table Values', 'Data Interpretation', 2, 'Unit 2'),
  ('E_ARITH_ERROR', 'Arithmetic Error', 'Algebra', 1, 'Unit 2'),
  ('E_CORNER_DIFF', 'Differentiability at a Corner/Cusp', 'Conceptual', 3, 'Unit 2'),
  ('E_ONE_SIDED_ONLY', 'Using Only One-Sided Derivative', 'Conceptual', 3, 'Unit 2'),
  ('E_TRIG_MIXUP', 'Confusing Trig Derivatives (e.g. sin vs cos)', 'Procedural', 3, 'Unit 2'),
  ('E_LOG_DERIV_CONFUSION', 'Confusing Log Deriv Rules', 'Procedural', 3, 'Unit 2')
ON CONFLICT (id) DO NOTHING;
