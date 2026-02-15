-- ============================================================
-- RESTORE MISSING BC UNITS (9 & 10)
-- Use this script if the main migration stopped early.
-- ============================================================

-- UNIT 9: Parametric/Polar (BC Only)
INSERT INTO public.topics (id, title, description, course_scope, sort_order)
VALUES ('BC_Unit9', 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', 'Parametric/Polar/Vector', 'bc_only', 9)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope, sort_order = EXCLUDED.sort_order;

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Unit9', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 9.', 'bc_only', 45, 0, true),
('BC_Unit9', '9.1', '9.1 Defining and Differentiating Parametric Equations', 'Parametric Intro', 'bc_only', 20, 1, false),
('BC_Unit9', '9.2', '9.2 Second Derivatives of Parametric Equations', 'Param 2nd Deriv', 'bc_only', 15, 2, false),
('BC_Unit9', '9.3', '9.3 Finding Arc Lengths of Curves Given by Parametric Equations', 'Param Arc', 'bc_only', 20, 3, false),
('BC_Unit9', '9.4', '9.4 Defining and Differentiating Vector-Valued Functions', 'Vectors', 'bc_only', 20, 4, false),
('BC_Unit9', '9.5', '9.5 Integrating Vector-Valued Functions', 'Vector Integration', 'bc_only', 20, 5, false),
('BC_Unit9', '9.6', '9.6 Solving Motion Problems Using Parametric and Vector Functions', 'Motion', 'bc_only', 25, 6, false),
('BC_Unit9', '9.7', '9.7 Defining Polar Coordinates and Differentiating in Polar Form', 'Polar Intro', 'bc_only', 20, 7, false),
('BC_Unit9', '9.8', '9.8 Finding the Area of a Polar Region', 'Polar Area Single', 'bc_only', 20, 8, false),
('BC_Unit9', '9.9', '9.9 Finding the Area of the Region Bounded by Two Polar Curves', 'Polar Area Between', 'bc_only', 20, 9, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;


-- UNIT 10: Series (BC Only)
INSERT INTO public.topics (id, title, description, course_scope, sort_order)
VALUES ('BC_Series', 'Unit 10: Infinite Sequences and Series', 'Infinite Series', 'bc_only', 10)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope, sort_order = EXCLUDED.sort_order;

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Series', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 10.', 'bc_only', 45, 0, true),
('BC_Series', '10.1', '10.1 Defining Convergent and Divergent Infinite Series', 'Convergence', 'bc_only', 20, 1, false),
('BC_Series', '10.2', '10.2 Working with Geometric Series', 'Geometric', 'bc_only', 15, 2, false),
('BC_Series', '10.3', '10.3 The nth Term Test for Divergence', 'nth Term', 'bc_only', 15, 3, false),
('BC_Series', '10.4', '10.4 Integral Test for Convergence', 'Integral Test', 'bc_only', 20, 4, false),
('BC_Series', '10.5', '10.5 Harmonic Series and p-Series', 'Harmonic/p-Series', 'bc_only', 15, 5, false),
('BC_Series', '10.6', '10.6 Comparison Tests for Convergence', 'Comparison', 'bc_only', 20, 6, false),
('BC_Series', '10.7', '10.7 Alternating Series Test for Convergence', 'Alternating', 'bc_only', 15, 7, false),
('BC_Series', '10.8', '10.8 Ratio Test for Convergence', 'Ratio Test', 'bc_only', 15, 8, false),
('BC_Series', '10.9', '10.9 Determining Absolute or Conditional Convergence', 'Abs/Cond', 'bc_only', 15, 9, false),
('BC_Series', '10.10', '10.10 Alternating Series Error Bound', 'Error Bound', 'bc_only', 15, 10, false),
('BC_Series', '10.11', '10.11 Finding Taylor Polynomial Approximations of Functions', 'Taylor Poly', 'bc_only', 25, 11, false),
('BC_Series', '10.12', '10.12 Lagrange Error Bound', 'Lagrange', 'bc_only', 20, 12, false),
('BC_Series', '10.13', '10.13 Radius and Interval of Convergence of Power Series', 'Radius/Interval', 'bc_only', 20, 13, false),
('BC_Series', '10.14', '10.14 Finding Taylor or Maclaurin Series for a Function', 'Taylor/Maclaurin', 'bc_only', 25, 14, false),
('BC_Series', '10.15', '10.15 Representing Functions as Power Series', 'Representation', 'bc_only', 20, 15, false)
ON CONFLICT (topic_id, id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, course_scope = EXCLUDED.course_scope;
