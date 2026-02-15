-- ============================================
-- SECTIONS SEED DATA ONLY (Fixed Topic IDs)
-- Run this in Supabase SQL Editor
-- ============================================

-- Clear existing data (if any)
DELETE FROM sections;

-- ABBC_Limits sections (Unit 1)
-- Note: Using ABBC_Limits to match frontend constants
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_Limits', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 1.', 45, 0, true, 'both'),
('ABBC_Limits', '1.1', '1.1 Introducing Calculus: Can Change Occur at an Instant?', 'Avg vs Instant Rate', 10, 1, false, 'both'),
('ABBC_Limits', '1.2', '1.2 Defining Limits and Using Limit Notation', 'Limit Notation', 15, 2, false, 'both'),
('ABBC_Limits', '1.3', '1.3 Estimating Limit Values from Graphs', 'Graphical Limits', 10, 3, false, 'both'),
('ABBC_Limits', '1.4', '1.4 Estimating Limit Values from Tables', 'Numerical Limits', 10, 4, false, 'both'),
('ABBC_Limits', '1.5', '1.5 Determining Limits Using Algebraic Properties of Limits', 'Limit Laws', 15, 5, false, 'both'),
('ABBC_Limits', '1.6', '1.6 Determining Limits Using Algebraic Manipulation', 'Factoring/Conjugates', 20, 6, false, 'both'),
('ABBC_Limits', '1.7', '1.7 Selecting Procedures for Determining Limits', 'Strategy', 15, 7, false, 'both'),
('ABBC_Limits', '1.8', '1.8 Determining Limits Using the Squeeze Theorem', 'Squeeze Theorem', 15, 8, false, 'both'),
('ABBC_Limits', '1.9', '1.9 Connecting Multiple Representations of Limits', 'Synthesis', 10, 9, false, 'both'),
('ABBC_Limits', '1.10', '1.10 Exploring Types of Discontinuities', 'Removable/Jump/Infinite', 15, 10, false, 'both'),
('ABBC_Limits', '1.11', '1.11 Defining Continuity at a Point', '3-Part Definition', 15, 11, false, 'both'),
('ABBC_Limits', '1.12', '1.12 Confirming Continuity over an Interval', 'Intervals', 10, 12, false, 'both'),
('ABBC_Limits', '1.13', '1.13 Removing Discontinuities', 'Extensions', 15, 13, false, 'both'),
('ABBC_Limits', '1.14', '1.14 Connecting Infinite Limits and Vertical Asymptotes', 'Asymptotes', 15, 14, false, 'both'),
('ABBC_Limits', '1.15', '1.15 Connecting Limits at Infinity and Horizontal Asymptotes', 'End Behavior', 15, 15, false, 'both'),
('ABBC_Limits', '1.16', '1.16 Working with the Intermediate Value Theorem', 'IVT', 15, 16, false, 'both');

-- ABBC_Derivatives sections (Unit 2)
-- Note: Using ABBC_Derivatives to match frontend constants
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_Derivatives', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 2.', 45, 0, true, 'both'),
('ABBC_Derivatives', '2.1', '2.1 Defining Average and Instantaneous Rates of Change at a Point', 'Slopes', 15, 1, false, 'both'),
('ABBC_Derivatives', '2.2', '2.2 Defining the Derivative of a Function and Using Derivative Notation', 'Notation', 20, 2, false, 'both'),
('ABBC_Derivatives', '2.3', '2.3 Estimating Derivatives of a Function at a Point', 'Estimation', 15, 3, false, 'both'),
('ABBC_Derivatives', '2.4', '2.4 Connecting Differentiability and Continuity', 'Differentiability', 15, 4, false, 'both'),
('ABBC_Derivatives', '2.5', '2.5 Applying the Power Rule', 'Power Rule', 10, 5, false, 'both'),
('ABBC_Derivatives', '2.6', '2.6 Derivative Rules: Constant, Sum, Difference, and Constant Multiple', 'Linearity', 10, 6, false, 'both'),
('ABBC_Derivatives', '2.7', '2.7 Derivatives of $\cos x$, $\sin x$, $e^x$, and $\ln x$', 'Basic Transcendentals', 15, 7, false, 'both'),
('ABBC_Derivatives', '2.8', '2.8 The Product Rule', 'Product Rule', 15, 8, false, 'both'),
('ABBC_Derivatives', '2.9', '2.9 The Quotient Rule', 'Quotient Rule', 15, 9, false, 'both'),
('ABBC_Derivatives', '2.10', '2.10 Finding the Derivatives of Tangent, Cotangent, Secant, and/or Cosecant Functions', 'Other Trig', 15, 10, false, 'both');

-- ABBC_Composite sections (Unit 3)
-- Note: Using ABBC_Composite to match frontend constants
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_Composite', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 3.', 45, 0, true, 'both'),
('ABBC_Composite', '3.1', '3.1 The Chain Rule', 'Chain Rule', 20, 1, false, 'both'),
('ABBC_Composite', '3.2', '3.2 Implicit Differentiation', 'Implicit', 20, 2, false, 'both'),
('ABBC_Composite', '3.3', '3.3 Differentiating Inverse Functions', 'Inverse Derivs', 15, 3, false, 'both'),
('ABBC_Composite', '3.4', '3.4 Differentiating Inverse Trigonometric Functions', 'Inverse Trig', 15, 4, false, 'both'),
('ABBC_Composite', '3.5', '3.5 Selecting Procedures for Calculating Derivatives', 'Strategy', 15, 5, false, 'both'),
('ABBC_Composite', '3.6', '3.6 Calculating Higher-Order Derivatives', 'Higher Order', 15, 6, false, 'both');

-- ABBC_Applications sections (Unit 4)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_Applications', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 4.', 45, 0, true, 'both'),
('ABBC_Applications', '4.1', '4.1 Interpreting the Meaning of the Derivative in Context', 'Context', 15, 1, false, 'both'),
('ABBC_Applications', '4.2', '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration', 'Motion', 20, 2, false, 'both'),
('ABBC_Applications', '4.3', '4.3 Rates of Change in Applied Contexts other than Motion', 'Other Rates', 15, 3, false, 'both'),
('ABBC_Applications', '4.4', '4.4 Introduction to Related Rates', 'Intro RR', 20, 4, false, 'both'),
('ABBC_Applications', '4.5', '4.5 Solving Related Rates Problems', 'Solving RR', 25, 5, false, 'both'),
('ABBC_Applications', '4.6', '4.6 Approximating Values of a Function Using Local Linearity and Linearization', 'Linearization', 15, 6, false, 'both'),
('ABBC_Applications', '4.7', '4.7 Using L’Hospital’s Rule for Finding Limits of Indeterminate Forms', 'L’Hospital', 15, 7, false, 'both');

-- ABBC_Analytical sections (Unit 5)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_Analytical', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 5.', 45, 0, true, 'both'),
('ABBC_Analytical', '5.1', '5.1 Using the Mean Value Theorem', 'MVT', 15, 1, false, 'both'),
('ABBC_Analytical', '5.2', '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points', 'EVT', 20, 2, false, 'both'),
('ABBC_Analytical', '5.3', '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing', 'Inc/Dec', 15, 3, false, 'both'),
('ABBC_Analytical', '5.4', '5.4 Using the First Derivative Test to Find Relative (Local) Extrema', '1st Deriv Test', 15, 4, false, 'both'),
('ABBC_Analytical', '5.5', '5.5 Using the Candidates Test to Find Absolute (Global) Extrema', 'Candidates Test', 20, 5, false, 'both'),
('ABBC_Analytical', '5.6', '5.6 Determining Concavity of Functions over Their Domains', 'Concavity', 15, 6, false, 'both'),
('ABBC_Analytical', '5.7', '5.7 Using the Second Derivative Test to Find Extrema', '2nd Deriv Test', 15, 7, false, 'both'),
('ABBC_Analytical', '5.8', '5.8 Sketching Graphs of Functions and Their Derivatives', 'Sketching', 20, 8, false, 'both'),
('ABBC_Analytical', '5.9', '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative', 'Connecting Graphs', 15, 9, false, 'both'),
('ABBC_Analytical', '5.10', '5.10 Introduction to Optimization Problems', 'Opt Intro', 15, 10, false, 'both'),
('ABBC_Analytical', '5.11', '5.11 Solving Optimization Problems', 'Solving Opt', 25, 11, false, 'both'),
('ABBC_Analytical', '5.12', '5.12 Exploring Behaviors of Implicit Relations', 'Implicit Behaviors', 15, 12, false, 'both');

-- ABBC_Integration sections (Unit 6)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_Integration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 6.', 45, 0, true, 'both'),
('ABBC_Integration', '6.1', '6.1 Exploring Accumulations of Change', 'Accumulation', 15, 1, false, 'both'),
('ABBC_Integration', '6.2', '6.2 Approximating Areas with Riemann Sums', 'Riemann Sums', 20, 2, false, 'both'),
('ABBC_Integration', '6.3', '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation', 'Def Integral', 15, 3, false, 'both'),
('ABBC_Integration', '6.4', '6.4 The Fundamental Theorem of Calculus and Accumulation Functions', 'FTC 1', 20, 4, false, 'both'),
('ABBC_Integration', '6.5', '6.5 Interpreting the Behavior of Accumulation Functions Involving Area', 'Accumulation Funcs', 15, 5, false, 'both'),
('ABBC_Integration', '6.6', '6.6 Applying Properties of Definite Integrals', 'Properties', 15, 6, false, 'both'),
('ABBC_Integration', '6.7', '6.7 The Fundamental Theorem of Calculus and Definite Integrals', 'FTC 2', 15, 7, false, 'both'),
('ABBC_Integration', '6.8', '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules and Notation', 'Indefinite', 15, 8, false, 'both'),
('ABBC_Integration', '6.9', '6.9 Integrating Using Substitution', 'Substitution', 20, 9, false, 'both'),
('ABBC_Integration', '6.10', '6.10 Integrating Functions Using Long Division and Completing the Square', 'Alg Manipulation', 20, 10, false, 'both'),
('ABBC_Integration', '6.11', '6.11 (BC ONLY) Using Integration by Parts', 'Integration by Parts', 20, 11, false, 'bc_only'),
('ABBC_Integration', '6.12', '6.12 (BC ONLY) Integrating Using Linear Partial Fractions', 'Partial Fractions', 20, 12, false, 'bc_only'),
('ABBC_Integration', '6.13', '6.13 (BC ONLY) Evaluating Improper Integrals', 'Improper Integrals', 20, 13, false, 'bc_only'),
('ABBC_Integration', '6.14', '6.14 Selecting Techniques for Antidifferentiation', 'Selecting Techniques', 20, 14, false, 'both');

-- ABBC_DiffEq sections (Unit 7)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_DiffEq', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 7.', 45, 0, true, 'both'),
('ABBC_DiffEq', '7.1', '7.1 Modeling Situations with Differential Equations', 'Modeling', 15, 1, false, 'both'),
('ABBC_DiffEq', '7.2', '7.2 Verifying Solutions for Differential Equations', 'Verifying', 15, 2, false, 'both'),
('ABBC_DiffEq', '7.3', '7.3 Sketching Slope Fields', 'Slope Fields', 20, 3, false, 'both'),
('ABBC_DiffEq', '7.4', '7.4 Reasoning Using Slope Fields', 'Reasoning', 15, 4, false, 'both'),
('ABBC_DiffEq', '7.5', '7.5 (BC ONLY) Approximating Solutions Using Euler’s Method', 'Euler Method', 20, 5, false, 'bc_only'),
('ABBC_DiffEq', '7.6', '7.6 Finding General Solutions Using Separation of Variables', 'Separation', 20, 6, false, 'both'),
('ABBC_DiffEq', '7.7', '7.7 Finding Particular Solutions Using Initial Conditions and Separation of Variables', 'Particular Sol', 20, 7, false, 'both'),
('ABBC_DiffEq', '7.8', '7.8 Exponential Models with Differential Equations', 'Exponential', 15, 8, false, 'both'),
('ABBC_DiffEq', '7.9', '7.9 (BC ONLY) Logistic Models with Differential Equations', 'Logistic Models', 20, 9, false, 'bc_only');

-- ABBC_AppIntegration sections (Unit 8)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('ABBC_AppIntegration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 8.', 45, 0, true, 'both'),
('ABBC_AppIntegration', '8.1', '8.1 Finding the Average Value of a Function on an Interval', 'Avg Value', 15, 1, false, 'both'),
('ABBC_AppIntegration', '8.2', '8.2 Connecting Position, Velocity, and Acceleration Functions Using Integrals', 'Motion', 15, 2, false, 'both'),
('ABBC_AppIntegration', '8.3', '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts', 'Accumulation', 15, 3, false, 'both'),
('ABBC_AppIntegration', '8.4', '8.4 Finding the Area Between Curves Expressed as Functions of x', 'Area dx', 20, 4, false, 'both'),
('ABBC_AppIntegration', '8.5', '8.5 Finding the Area Between Curves Expressed as Functions of y', 'Area dy', 20, 5, false, 'both'),
('ABBC_AppIntegration', '8.6', '8.6 Finding the Area Between Curves That Intersect at More Than Two Points', 'Intersections', 20, 6, false, 'both'),
('ABBC_AppIntegration', '8.7', '8.7 Volumes with Cross-Sections - Squares and Rectangles', 'Cross Sec 1', 20, 7, false, 'both'),
('ABBC_AppIntegration', '8.8', '8.8 Volumes with Cross-Sections - Triangles and Semicircles', 'Cross Sec 2', 20, 8, false, 'both'),
('ABBC_AppIntegration', '8.9', '8.9 Volume with Disc Method - Revolving Around x- or y-axis', 'Disc', 20, 9, false, 'both'),
('ABBC_AppIntegration', '8.10', '8.10 Volume with Disc Method - Revolving Around Other Axes', 'Disc Shift', 20, 10, false, 'both'),
('ABBC_AppIntegration', '8.11', '8.11 Volume with Washer Method - Revolving Around x- or y-axis', 'Washer', 20, 11, false, 'both'),
('ABBC_AppIntegration', '8.12', '8.12 Volume with Washer Method - Revolving Around Other Axes', 'Washer Shift', 20, 12, false, 'both'),
('ABBC_AppIntegration', '8.13', '8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled', 'Arc Length', 20, 13, false, 'bc_only');

-- BC_Unit9 sections (Unit 9)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('BC_Unit9', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 9.', 45, 0, true, 'bc_only'),
('BC_Unit9', '9.1', '9.1 (BC ONLY) Defining and Differentiating Parametric Equations', 'Parametric Derivs', 20, 1, false, 'bc_only'),
('BC_Unit9', '9.2', '9.2 (BC ONLY) Second Derivatives of Parametric Equations', 'Parametric 2nd Deriv', 20, 2, false, 'bc_only'),
('BC_Unit9', '9.3', '9.3 (BC ONLY) Finding Arc Lengths of Curves Given by Parametric Equations', 'Parametric Arc Length', 15, 3, false, 'bc_only'),
('BC_Unit9', '9.4', '9.4 (BC ONLY) Defining and Differentiating Vector-Valued Functions', 'Vector Derivs', 15, 4, false, 'bc_only'),
('BC_Unit9', '9.5', '9.5 (BC ONLY) Integrating Vector-Valued Functions', 'Vector Int', 15, 5, false, 'bc_only'),
('BC_Unit9', '9.6', '9.6 (BC ONLY) Solving Motion Problems Using Parametric and Vector-Valued Functions', 'Vector Motion', 20, 6, false, 'bc_only'),
('BC_Unit9', '9.7', '9.7 (BC ONLY) Defining Polar Coordinates and Differentiating in Polar Form', 'Polar Derivs', 20, 7, false, 'bc_only'),
('BC_Unit9', '9.8', '9.8 (BC ONLY) Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve', 'Polar Area', 20, 8, false, 'bc_only'),
('BC_Unit9', '9.9', '9.9 (BC ONLY) Finding the Area of the Region Bounded by Two Polar Curves', 'Area Between Polar', 20, 9, false, 'bc_only');

-- BC_Series sections (Unit 10)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test, course_scope) VALUES
('BC_Series', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 10.', 45, 0, true, 'bc_only'),
('BC_Series', '10.1', '10.1 (BC ONLY) Defining Convergent and Divergent Infinite Series', 'Convergence', 15, 1, false, 'bc_only'),
('BC_Series', '10.2', '10.2 (BC ONLY) Working with Geometric Series', 'Geometric', 20, 2, false, 'bc_only'),
('BC_Series', '10.3', '10.3 (BC ONLY) The nth-Term Test for Divergence', 'nth Term', 15, 3, false, 'bc_only'),
('BC_Series', '10.4', '10.4 (BC ONLY) Integral Test for Convergence', 'Integral Test', 20, 4, false, 'bc_only'),
('BC_Series', '10.5', '10.5 (BC ONLY) Harmonic Series and p-Series', 'p-Series', 15, 5, false, 'bc_only'),
('BC_Series', '10.6', '10.6 (BC ONLY) Comparison Tests for Convergence', 'Comparison', 20, 6, false, 'bc_only'),
('BC_Series', '10.7', '10.7 (BC ONLY) Alternating Series Test for Convergence', 'AST', 15, 7, false, 'bc_only'),
('BC_Series', '10.8', '10.8 (BC ONLY) Ratio Test for Convergence', 'Ratio Test', 20, 8, false, 'bc_only'),
('BC_Series', '10.9', '10.9 (BC ONLY) Determining Absolute or Conditional Convergence', 'Abs/Cond', 15, 9, false, 'bc_only'),
('BC_Series', '10.10', '10.10 (BC ONLY) Alternating Series Error Bound', 'AST Error', 15, 10, false, 'bc_only'),
('BC_Series', '10.11', '10.11 (BC ONLY) Finding Taylor Polynomial Approximations of Functions', 'Taylor Poly', 20, 11, false, 'bc_only'),
('BC_Series', '10.12', '10.12 (BC ONLY) Lagrange Error Bound', 'Lagrange', 20, 12, false, 'bc_only'),
('BC_Series', '10.13', '10.13 (BC ONLY) Radius and Interval of Convergence of Power Series', 'Radius/Interval', 20, 13, false, 'bc_only'),
('BC_Series', '10.14', '10.14 (BC ONLY) Finding Taylor or Maclaurin Series for a Function', 'Finding Series', 20, 14, false, 'bc_only'),
('BC_Series', '10.15', '10.15 (BC ONLY) Representing Functions as Power Series', 'Ops on Series', 20, 15, false, 'bc_only');

-- Verify
SELECT COUNT(*) AS total_sections FROM sections;
