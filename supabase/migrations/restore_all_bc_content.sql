-- ============================================================
-- RESTORE ALL BC-ONLY CONTENT (UNITS 6, 7, 8, 9, 10)
-- This script safely inserts/updates all BC-exclusive sections.
-- ============================================================

-- UNIT 6: Integration (BC Only Parts)
-- Parent Topic: ABBC_Integration
INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Integration', '6.11', '6.11 (BC ONLY) Using Integration by Parts', 'Integration by Parts', 'bc_only', 20, 11, false),
('ABBC_Integration', '6.12', '6.12 (BC ONLY) Integrating Using Linear Partial Fractions', 'Partial Fractions', 'bc_only', 20, 12, false),
('ABBC_Integration', '6.13', '6.13 (BC ONLY) Evaluating Improper Integrals', 'Improper Integrals', 'bc_only', 20, 13, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;


-- UNIT 7: Differential Equations (BC Only Parts)
-- Parent Topic: ABBC_DiffEq
INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_DiffEq', '7.5', '7.5 (BC ONLY) Approximating Solutions Using Euler’s Method', 'Euler Method', 'bc_only', 20, 5, false),
('ABBC_DiffEq', '7.9', '7.9 (BC ONLY) Logistic Models with Differential Equations', 'Logistic Models', 'bc_only', 20, 9, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;


-- UNIT 8: Applications of Integration (BC Only Parts)
-- Parent Topic: ABBC_AppIntegration
INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_AppIntegration', '8.13', '8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled', 'Arc Length', 'bc_only', 20, 13, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;


-- UNIT 9: Parametric/Polar (BC Only Unit)
INSERT INTO public.topics (id, title, description, course_scope, sort_order)
VALUES ('BC_Unit9', 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', 'Parametric/Polar/Vector', 'bc_only', 9)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Unit9', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 9.', 'bc_only', 45, 0, true),
('BC_Unit9', '9.1', '9.1 (BC ONLY) Defining and Differentiating Parametric Equations', 'Parametric Derivs', 'bc_only', 20, 1, false),
('BC_Unit9', '9.2', '9.2 (BC ONLY) Second Derivatives of Parametric Equations', 'Parametric 2nd Deriv', 'bc_only', 20, 2, false),
('BC_Unit9', '9.3', '9.3 (BC ONLY) Finding Arc Lengths of Curves Given by Parametric Equations', 'Parametric Arc Length', 'bc_only', 15, 3, false),
('BC_Unit9', '9.4', '9.4 (BC ONLY) Defining and Differentiating Vector-Valued Functions', 'Vector Derivs', 'bc_only', 15, 4, false),
('BC_Unit9', '9.5', '9.5 (BC ONLY) Integrating Vector-Valued Functions', 'Vector Int', 'bc_only', 15, 5, false),
('BC_Unit9', '9.6', '9.6 (BC ONLY) Solving Motion Problems Using Parametric and Vector-Valued Functions', 'Vector Motion', 'bc_only', 20, 6, false),
('BC_Unit9', '9.7', '9.7 (BC ONLY) Defining Polar Coordinates and Differentiating in Polar Form', 'Polar Derivs', 'bc_only', 20, 7, false),
('BC_Unit9', '9.8', '9.8 (BC ONLY) Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve', 'Polar Area', 'bc_only', 20, 8, false),
('BC_Unit9', '9.9', '9.9 (BC ONLY) Finding the Area of the Region Bounded by Two Polar Curves', 'Area Between Polar', 'bc_only', 20, 9, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;


-- UNIT 10: Series (BC Only Unit)
INSERT INTO public.topics (id, title, description, course_scope, sort_order)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series', 'Infinite Series', 'bc_only', 10)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Series', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 10.', 'bc_only', 45, 0, true),
('BC_Series', '10.1', '10.1 (BC ONLY) Defining Convergent and Divergent Infinite Series', 'Convergence', 'bc_only', 15, 1, false),
('BC_Series', '10.2', '10.2 (BC ONLY) Working with Geometric Series', 'Geometric', 'bc_only', 20, 2, false),
('BC_Series', '10.3', '10.3 (BC ONLY) The nth-Term Test for Divergence', 'nth Term', 'bc_only', 15, 3, false),
('BC_Series', '10.4', '10.4 (BC ONLY) Integral Test for Convergence', 'Integral Test', 'bc_only', 20, 4, false),
('BC_Series', '10.5', '10.5 (BC ONLY) Harmonic Series and p-Series', 'p-Series', 'bc_only', 15, 5, false),
('BC_Series', '10.6', '10.6 (BC ONLY) Comparison Tests for Convergence', 'Comparison', 'bc_only', 20, 6, false),
('BC_Series', '10.7', '10.7 (BC ONLY) Alternating Series Test for Convergence', 'AST', 'bc_only', 15, 7, false),
('BC_Series', '10.8', '10.8 (BC ONLY) Ratio Test for Convergence', 'Ratio Test', 'bc_only', 20, 8, false),
('BC_Series', '10.9', '10.9 (BC ONLY) Determining Absolute or Conditional Convergence', 'Abs/Cond', 'bc_only', 15, 9, false),
('BC_Series', '10.10', '10.10 (BC ONLY) Alternating Series Error Bound', 'AST Error', 'bc_only', 15, 10, false),
('BC_Series', '10.11', '10.11 (BC ONLY) Finding Taylor Polynomial Approximations of Functions', 'Taylor Poly', 'bc_only', 20, 11, false),
('BC_Series', '10.12', '10.12 (BC ONLY) Lagrange Error Bound', 'Lagrange', 'bc_only', 20, 12, false),
('BC_Series', '10.13', '10.13 (BC ONLY) Radius and Interval of Convergence of Power Series', 'Radius/Interval', 'bc_only', 20, 13, false),
('BC_Series', '10.14', '10.14 (BC ONLY) Finding Taylor or Maclaurin Series for a Function', 'Finding Series', 'bc_only', 20, 14, false),
('BC_Series', '10.15', '10.15 (BC ONLY) Representing Functions as Power Series', 'Representation', 'bc_only', 20, 15, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;
