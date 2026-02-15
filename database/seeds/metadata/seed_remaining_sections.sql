-- ============================================
-- SECTIONS SEED DATA FOR UNITS 3-10
-- Run this in Supabase SQL Editor
-- ============================================

-- Unit 3: Differentiation: Composite, Implicit, and Inverse Functions
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Composite', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 3.', 45, 0, true),
('ABBC_Composite', '3.1', '3.1 The Chain Rule', 'Chain Rule', 20, 1, false),
('ABBC_Composite', '3.2', '3.2 Implicit Differentiation', 'Implicit', 20, 2, false),
('ABBC_Composite', '3.3', '3.3 Differentiating Inverse Functions', 'Inverse Derivs', 15, 3, false),
('ABBC_Composite', '3.4', '3.4 Differentiating Inverse Trigonometric Functions', 'Inverse Trig', 15, 4, false),
('ABBC_Composite', '3.5', '3.5 Selecting Procedures for Calculating Derivatives', 'Strategy', 15, 5, false),
('ABBC_Composite', '3.6', '3.6 Calculating Higher-Order Derivatives', 'Higher Order', 15, 6, false);

-- Unit 4: Contextual Applications of Differentiation
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Applications', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 4.', 45, 0, true),
('ABBC_Applications', '4.1', '4.1 Interpreting the Meaning of the Derivative in Context', 'Context', 15, 1, false),
('ABBC_Applications', '4.2', '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration', 'Motion', 20, 2, false),
('ABBC_Applications', '4.3', '4.3 Rates of Change in Applied Contexts other than Motion', 'Other Rates', 15, 3, false),
('ABBC_Applications', '4.4', '4.4 Introduction to Related Rates', 'Intro RR', 20, 4, false),
('ABBC_Applications', '4.5', '4.5 Solving Related Rates Problems', 'Solving RR', 25, 5, false),
('ABBC_Applications', '4.6', '4.6 Approximating Values of a Function Using Local Linearity and Linearization', 'Linearization', 15, 6, false),
('ABBC_Applications', '4.7', '4.7 Using L’Hospital’s Rule for Finding Limits of Indeterminate Forms', 'L’Hospital', 15, 7, false);

-- Unit 5: Analytical Applications of Differentiation
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Analytical', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 5.', 45, 0, true),
('ABBC_Analytical', '5.1', '5.1 Using the Mean Value Theorem', 'MVT', 15, 1, false),
('ABBC_Analytical', '5.2', '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points', 'EVT', 20, 2, false),
('ABBC_Analytical', '5.3', '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing', 'Inc/Dec', 15, 3, false),
('ABBC_Analytical', '5.4', '5.4 Using the First Derivative Test to Find Relative (Local) Extrema', '1st Deriv Test', 15, 4, false),
('ABBC_Analytical', '5.5', '5.5 Using the Candidates Test to Find Absolute (Global) Extrema', 'Candidates Test', 20, 5, false),
('ABBC_Analytical', '5.6', '5.6 Determining Concavity of Functions over Their Domains', 'Concavity', 15, 6, false),
('ABBC_Analytical', '5.7', '5.7 Using the Second Derivative Test to Find Extrema', '2nd Deriv Test', 15, 7, false),
('ABBC_Analytical', '5.8', '5.8 Sketching Graphs of Functions and Their Derivatives', 'Sketching', 20, 8, false),
('ABBC_Analytical', '5.9', '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative', 'Connecting Graphs', 15, 9, false),
('ABBC_Analytical', '5.10', '5.10 Introduction to Optimization Problems', 'Opt Intro', 15, 10, false),
('ABBC_Analytical', '5.11', '5.11 Solving Optimization Problems', 'Solving Opt', 25, 11, false),
('ABBC_Analytical', '5.12', '5.12 Exploring Behaviors of Implicit Relations', 'Implicit Behaviors', 15, 12, false);

-- Unit 6: Integration and Accumulation of Change (BC set covers AB)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Integration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 6.', 45, 0, true),
('ABBC_Integration', '6.1', '6.1 Exploring Accumulations of Change', 'Accumulation', 15, 1, false),
('ABBC_Integration', '6.2', '6.2 Approximating Areas with Riemann Sums', 'Riemann Sums', 20, 2, false),
('ABBC_Integration', '6.3', '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation', 'Def Integral', 15, 3, false),
('ABBC_Integration', '6.4', '6.4 The Fundamental Theorem of Calculus and Accumulation Functions', 'FTC 1', 20, 4, false),
('ABBC_Integration', '6.5', '6.5 Interpreting the Behavior of Accumulation Functions Involving Area', 'Accumulation Funcs', 15, 5, false),
('ABBC_Integration', '6.6', '6.6 Applying Properties of Definite Integrals', 'Properties', 15, 6, false),
('ABBC_Integration', '6.7', '6.7 The Fundamental Theorem of Calculus and Definite Integrals', 'FTC 2', 15, 7, false),
('ABBC_Integration', '6.8', '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules and Notation', 'Indefinite', 15, 8, false),
('ABBC_Integration', '6.9', '6.9 Integrating Using Substitution', 'Substitution', 20, 9, false),
('ABBC_Integration', '6.10', '6.10 Integrating Functions Using Long Division and Completing the Square', 'Alg Manipulation', 20, 10, false),
-- BC Only Parts
('ABBC_Integration', '6.11', '6.11 (BC ONLY) Using Integration by Parts', 'Integration by Parts', 20, 11, false),
('ABBC_Integration', '6.12', '6.12 (BC ONLY) Integrating Using Linear Partial Fractions', 'Partial Fractions', 20, 12, false),
('ABBC_Integration', '6.13', '6.13 (BC ONLY) Evaluating Improper Integrals', 'Improper Integrals', 20, 13, false),
('ABBC_Integration', '6.14', '6.14 Selecting Techniques for Antidifferentiation', 'Selecting Techniques', 20, 14, false);

-- Unit 7: Differential Equations
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_DiffEq', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 7.', 45, 0, true),
('ABBC_DiffEq', '7.1', '7.1 Modeling Situations with Differential Equations', 'Modeling', 15, 1, false),
('ABBC_DiffEq', '7.2', '7.2 Verifying Solutions for Differential Equations', 'Verifying', 15, 2, false),
('ABBC_DiffEq', '7.3', '7.3 Sketching Slope Fields', 'Slope Fields', 20, 3, false),
('ABBC_DiffEq', '7.4', '7.4 Reasoning Using Slope Fields', 'Reasoning', 15, 4, false),
('ABBC_DiffEq', '7.5', '7.5 (BC ONLY) Approximating Solutions Using Euler’s Method', 'Euler Method', 20, 5, false),
('ABBC_DiffEq', '7.6', '7.6 Finding General Solutions Using Separation of Variables', 'Separation', 20, 6, false),
('ABBC_DiffEq', '7.7', '7.7 Finding Particular Solutions Using Initial Conditions and Separation of Variables', 'Particular Sol', 20, 7, false),
('ABBC_DiffEq', '7.8', '7.8 Exponential Models with Differential Equations', 'Exponential', 15, 8, false),
('ABBC_DiffEq', '7.9', '7.9 (BC ONLY) Logistic Models with Differential Equations', 'Logistic Models', 20, 9, false);

-- Unit 8: Applications of Integration
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_AppIntegration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 8.', 45, 0, true),
('ABBC_AppIntegration', '8.1', '8.1 Finding the Average Value of a Function on an Interval', 'Avg Value', 15, 1, false),
('ABBC_AppIntegration', '8.2', '8.2 Connecting Position, Velocity, and Acceleration Functions Using Integrals', 'Motion', 15, 2, false),
('ABBC_AppIntegration', '8.3', '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts', 'Accumulation', 15, 3, false),
('ABBC_AppIntegration', '8.4', '8.4 Finding the Area Between Curves Expressed as Functions of x', 'Area dx', 20, 4, false),
('ABBC_AppIntegration', '8.5', '8.5 Finding the Area Between Curves Expressed as Functions of y', 'Area dy', 20, 5, false),
('ABBC_AppIntegration', '8.6', '8.6 Finding the Area Between Curves That Intersect at More Than Two Points', 'Intersections', 20, 6, false),
('ABBC_AppIntegration', '8.7', '8.7 Volumes with Cross-Sections - Squares and Rectangles', 'Cross Sec 1', 20, 7, false),
('ABBC_AppIntegration', '8.8', '8.8 Volumes with Cross-Sections - Triangles and Semicircles', 'Cross Sec 2', 20, 8, false),
('ABBC_AppIntegration', '8.9', '8.9 Volume with Disc Method - Revolving Around x- or y-axis', 'Disc', 20, 9, false),
('ABBC_AppIntegration', '8.10', '8.10 Volume with Disc Method - Revolving Around Other Axes', 'Disc Shift', 20, 10, false),
('ABBC_AppIntegration', '8.11', '8.11 Volume with Washer Method - Revolving Around x- or y-axis', 'Washer', 20, 11, false),
('ABBC_AppIntegration', '8.12', '8.12 Volume with Washer Method - Revolving Around Other Axes', 'Washer Shift', 20, 12, false),
('ABBC_AppIntegration', '8.13', '8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled', 'Arc Length', 20, 13, false);

-- Unit 9: Parametric, Polar, and Vector (BC ONLY)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Unit9', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 9.', 45, 0, true),
('BC_Unit9', '9.1', '9.1 (BC ONLY) Defining and Differentiating Parametric Equations', 'Parametric Derivs', 20, 1, false),
('BC_Unit9', '9.2', '9.2 (BC ONLY) Second Derivatives of Parametric Equations', 'Parametric 2nd Deriv', 20, 2, false),
('BC_Unit9', '9.3', '9.3 (BC ONLY) Finding Arc Lengths of Curves Given by Parametric Equations', 'Parametric Arc Length', 15, 3, false),
('BC_Unit9', '9.4', '9.4 (BC ONLY) Defining and Differentiating Vector-Valued Functions', 'Vector Derivs', 15, 4, false),
('BC_Unit9', '9.5', '9.5 (BC ONLY) Integrating Vector-Valued Functions', 'Vector Int', 15, 5, false),
('BC_Unit9', '9.6', '9.6 (BC ONLY) Solving Motion Problems Using Parametric and Vector-Valued Functions', 'Vector Motion', 20, 6, false),
('BC_Unit9', '9.7', '9.7 (BC ONLY) Defining Polar Coordinates and Differentiating in Polar Form', 'Polar Derivs', 20, 7, false),
('BC_Unit9', '9.8', '9.8 (BC ONLY) Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve', 'Polar Area', 20, 8, false),
('BC_Unit9', '9.9', '9.9 (BC ONLY) Finding the Area of the Region Bounded by Two Polar Curves', 'Area Between Polar', 20, 9, false);

-- Unit 10: Infinite Sequences and Series (BC ONLY)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Series', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 10.', 45, 0, true),
('BC_Series', '10.1', '10.1 (BC ONLY) Defining Convergent and Divergent Infinite Series', 'Convergence', 15, 1, false),
('BC_Series', '10.2', '10.2 (BC ONLY) Working with Geometric Series', 'Geometric', 20, 2, false),
('BC_Series', '10.3', '10.3 (BC ONLY) The nth-Term Test for Divergence', 'nth Term', 15, 3, false),
('BC_Series', '10.4', '10.4 (BC ONLY) Integral Test for Convergence', 'Integral Test', 20, 4, false),
('BC_Series', '10.5', '10.5 (BC ONLY) Harmonic Series and p-Series', 'p-Series', 15, 5, false),
('BC_Series', '10.6', '10.6 (BC ONLY) Comparison Tests for Convergence', 'Comparison', 20, 6, false),
('BC_Series', '10.7', '10.7 (BC ONLY) Alternating Series Test for Convergence', 'AST', 15, 7, false),
('BC_Series', '10.8', '10.8 (BC ONLY) Ratio Test for Convergence', 'Ratio Test', 20, 8, false),
('BC_Series', '10.9', '10.9 (BC ONLY) Determining Absolute or Conditional Convergence', 'Abs/Cond', 15, 9, false),
('BC_Series', '10.10', '10.10 (BC ONLY) Alternating Series Error Bound', 'AST Error', 15, 10, false),
('BC_Series', '10.11', '10.11 (BC ONLY) Finding Taylor Polynomial Approximations of Functions', 'Taylor Poly', 20, 11, false),
('BC_Series', '10.12', '10.12 (BC ONLY) Lagrange Error Bound', 'Lagrange', 20, 12, false),
('BC_Series', '10.13', '10.13 (BC ONLY) Radius and Interval of Convergence of Power Series', 'Radius/Interval', 20, 13, false),
('BC_Series', '10.14', '10.14 (BC ONLY) Finding Taylor or Maclaurin Series for a Function', 'Finding Series', 20, 14, false),
('BC_Series', '10.15', '10.15 (BC ONLY) Representing Functions as Power Series', 'Ops on Series', 20, 15, false);

-- Verify
SELECT topic_id, COUNT(*) FROM sections GROUP BY topic_id;
