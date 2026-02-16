BEGIN;

-- Insert Unit 5 Uppercase SKILLS
INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
  ('SK_MVT', 'Mean Value Theorem', 'Unit 5', '{}'),
  ('SK_EVT', 'Extreme Value Theorem', 'Unit 5', '{"SK_MVT"}'),
  ('SK_AVG_ROC', 'Average Rate of Change', 'Unit 5', '{}'),
  ('SK_ABS_EXTREMA_CANDIDATES', 'Absolute Extrema Candidates Test', 'Unit 5', '{"SK_EVT"}'),
  ('SK_SIGN_CHART', 'Sign Chart Analysis', 'Unit 5', '{}'),
  ('SK_INCREASING_DECREASING', 'Increasing and Decreasing Behavior', 'Unit 5', '{"SK_SIGN_CHART"}'),
  ('SK_FIRST_DERIV_TEST', 'First Derivative Test', 'Unit 5', '{"SK_INCREASING_DECREASING"}'),
  ('SK_CONCAVITY', 'Concavity and Points of Inflection', 'Unit 5', '{"SK_SECOND_DERIV_TEST"}'),
  ('SK_SECOND_DERIV_TEST', 'Second Derivative Test', 'Unit 5', '{"SK_FIRST_DERIV_TEST"}'),
  ('SK_OPT_MODEL', 'Optimization Modeling', 'Unit 5', '{}'),
  ('SK_OPT_SOLVE', 'Optimization Solving', 'Unit 5', '{"SK_OPT_MODEL","SK_ABS_EXTREMA_CANDIDATES"}'),
  ('SK_IMPLICIT_DIFF', 'Implicit Differentiation', 'Unit 5', '{}'),
  ('SK_BEHAVIOR_IMPLICIT', 'Behavior of Implicit Curves', 'Unit 5', '{"SK_IMPLICIT_DIFF"}'),
  ('SK_GRAPH_MATCH', 'Matching Graphs to Functions', 'Unit 5', '{}'),
  ('SK_GRAPH_CONNECT', 'Connecting f, f'', f''''', 'Unit 5', '{"SK_GRAPH_MATCH"}'),
  ('SK_GRAPH_SKETCH', 'Curve Sketching', 'Unit 5', '{"SK_GRAPH_CONNECT"}'),
  ('SK_CRITICAL_POINTS', 'Finding Critical Points', 'Unit 5', '{}'),
  ('SK_ALGEBRA', 'Algebraic Manipulation', 'Unit 5', '{}'),
  ('SK_INTERPRET_GRAPH', 'Graph Interpretation', 'Unit 5', '{}')
ON CONFLICT (id) DO UPDATE SET 
  unit = EXCLUDED.unit,
  prerequisites = EXCLUDED.prerequisites;

-- Insert Unit 5 Uppercase ERROR TAGS
INSERT INTO public.error_tags (id, name, category, severity, unit) VALUES
  ('E_MVT_HYPOTHESES', 'MVT Hypotheses Not Met', 'Conceptual', 3, 'Unit 5'),
  ('E_EVT_MISUSE', 'Misuse of Extreme Value Theorem', 'Conceptual', 3, 'Unit 5'),
  ('E_ENDPOINTS_IGNORED', 'Endpoints Ignored in Extrema Check', 'Procedural', 4, 'Unit 5'),
  ('E_SIGN_CHART', 'Sign Chart Error', 'Procedural', 3, 'Unit 5'),
  ('E_GRAPH_MISMATCH', 'Misinterpreting Graph Features', 'Visual', 2, 'Unit 5'),
  ('E_LOCAL_VS_GLOBAL', 'Confusing Local and Global Extrema', 'Conceptual', 3, 'Unit 5'),
  ('E_CONCAVITY_SIGN', 'Concavity Sign Error', 'Conceptual', 3, 'Unit 5'),
  ('E_OPT_CONSTRAINT', 'Optimization Constraint Error', 'Modeling', 3, 'Unit 5'),
  ('E_ARITHMETIC', 'Arithmetic Calculation Error', 'Calculation', 1, 'Unit 5'),
  ('E_IMPLICIT_UNDEFINED', 'Undefined Derivative in Implicit Diff', 'Conceptual', 3, 'Unit 5'),
  ('E_AVG_VS_INST', 'Average vs Instantaneous Rate Confusion', 'Conceptual', 3, 'Unit 5')
ON CONFLICT (id) DO UPDATE SET 
  unit = EXCLUDED.unit,
  category = EXCLUDED.category,
  severity = EXCLUDED.severity;

COMMIT;
