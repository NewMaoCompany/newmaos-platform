-- ============================================
-- SECTIONS TABLE MIGRATION
-- Creates a proper sections table for Chapter/Section entities
-- ============================================

-- Drop if exists for clean migration
DROP TABLE IF EXISTS sections CASCADE;

-- Create sections table
CREATE TABLE sections (
    id TEXT NOT NULL,                       -- e.g., "1.1", "1.2", "unit_test"
    topic_id TEXT NOT NULL,                 -- FK to topic_content.id (e.g., "AB_Limits")
    title TEXT NOT NULL,
    description TEXT DEFAULT '',
    estimated_minutes INTEGER DEFAULT 15,
    has_lesson BOOLEAN DEFAULT true,
    has_practice BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,           -- For ordering within a unit
    is_unit_test BOOLEAN DEFAULT false,     -- Flag for unit test sections
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (topic_id, id)              -- Composite primary key
);

-- Create index for fast lookups
CREATE INDEX idx_sections_topic_id ON sections(topic_id);

-- Enable RLS
ALTER TABLE sections ENABLE ROW LEVEL SECURITY;

-- RLS policy: Anyone can read
CREATE POLICY "Anyone can read sections" ON sections
    FOR SELECT USING (true);

-- RLS policy: Only creators can modify
CREATE POLICY "Creators can modify sections" ON sections
    FOR ALL USING (
        EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND is_creator = true)
    );

-- ============================================
-- SEED DATA: All AP Calculus Sections
-- ============================================

-- AB_Limits sections (Unit 1)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_Limits', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 1.', 45, 0, true),
('AB_Limits', '1.1', '1.1 Introducing Calculus: Can Change Occur at an Instant?', 'Avg vs Instant Rate', 10, 1, false),
('AB_Limits', '1.2', '1.2 Defining Limits and Using Limit Notation', 'Limit Notation', 15, 2, false),
('AB_Limits', '1.3', '1.3 Estimating Limit Values from Graphs', 'Graphical Limits', 10, 3, false),
('AB_Limits', '1.4', '1.4 Estimating Limit Values from Tables', 'Numerical Limits', 10, 4, false),
('AB_Limits', '1.5', '1.5 Determining Limits Using Algebraic Properties of Limits', 'Limit Laws', 15, 5, false),
('AB_Limits', '1.6', '1.6 Determining Limits Using Algebraic Manipulation', 'Factoring/Conjugates', 20, 6, false),
('AB_Limits', '1.7', '1.7 Selecting Procedures for Determining Limits', 'Strategy', 15, 7, false),
('AB_Limits', '1.8', '1.8 Determining Limits Using the Squeeze Theorem', 'Squeeze Theorem', 15, 8, false),
('AB_Limits', '1.9', '1.9 Connecting Multiple Representations of Limits', 'Synthesis', 10, 9, false),
('AB_Limits', '1.10', '1.10 Exploring Types of Discontinuities', 'Removable/Jump/Infinite', 15, 10, false),
('AB_Limits', '1.11', '1.11 Defining Continuity at a Point', '3-Part Definition', 15, 11, false),
('AB_Limits', '1.12', '1.12 Confirming Continuity over an Interval', 'Intervals', 10, 12, false),
('AB_Limits', '1.13', '1.13 Removing Discontinuities', 'Extensions', 15, 13, false),
('AB_Limits', '1.14', '1.14 Connecting Infinite Limits and Vertical Asymptotes', 'Asymptotes', 15, 14, false),
('AB_Limits', '1.15', '1.15 Connecting Limits at Infinity and Horizontal Asymptotes', 'End Behavior', 15, 15, false),
('AB_Limits', '1.16', '1.16 Working with the Intermediate Value Theorem', 'IVT', 15, 16, false);

-- AB_Derivatives sections (Unit 2)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_Derivatives', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 2.', 45, 0, true),
('AB_Derivatives', '2.1', '2.1 Defining Average and Instantaneous Rates of Change at a Point', 'Slopes', 15, 1, false),
('AB_Derivatives', '2.2', '2.2 Defining the Derivative of a Function and Using Derivative Notation', 'Notation', 20, 2, false),
('AB_Derivatives', '2.3', '2.3 Estimating Derivatives of a Function at a Point', 'Estimation', 15, 3, false),
('AB_Derivatives', '2.4', '2.4 Connecting Differentiability and Continuity', 'Differentiability', 15, 4, false),
('AB_Derivatives', '2.5', '2.5 Applying the Power Rule', 'Power Rule', 10, 5, false),
('AB_Derivatives', '2.6', '2.6 Derivative Rules: Constant, Sum, Difference, and Constant Multiple', 'Linearity', 10, 6, false),
('AB_Derivatives', '2.7', '2.7 Derivatives of cos x, sin x, e^x, and ln x', 'Basic Transcendentals', 15, 7, false),
('AB_Derivatives', '2.8', '2.8 The Product Rule', 'Product Rule', 15, 8, false),
('AB_Derivatives', '2.9', '2.9 The Quotient Rule', 'Quotient Rule', 15, 9, false),
('AB_Derivatives', '2.10', '2.10 Finding the Derivatives of Tangent, Cotangent, Secant, and/or Cosecant Functions', 'Other Trig', 15, 10, false);

-- AB_Composite sections (Unit 3)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_Composite', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 3.', 45, 0, true),
('AB_Composite', '3.1', '3.1 The Chain Rule', 'Chain Rule', 20, 1, false),
('AB_Composite', '3.2', '3.2 Implicit Differentiation', 'Implicit', 20, 2, false),
('AB_Composite', '3.3', '3.3 Differentiating Inverse Functions', 'Inverse Derivs', 15, 3, false),
('AB_Composite', '3.4', '3.4 Differentiating Inverse Trigonometric Functions', 'Inverse Trig', 15, 4, false),
('AB_Composite', '3.5', '3.5 Selecting Procedures for Calculating Derivatives', 'Strategy', 15, 5, false),
('AB_Composite', '3.6', '3.6 Calculating Higher-Order Derivatives', 'Higher Order', 15, 6, false);

-- AB_Applications sections (Unit 4)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_Applications', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 4.', 45, 0, true),
('AB_Applications', '4.1', '4.1 Interpreting the Meaning of the Derivative in Context', 'Context', 15, 1, false),
('AB_Applications', '4.2', '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration', 'Motion', 20, 2, false),
('AB_Applications', '4.3', '4.3 Rates of Change in Applied Contexts other than Motion', 'Other Rates', 15, 3, false),
('AB_Applications', '4.4', '4.4 Introduction to Related Rates', 'Intro RR', 20, 4, false),
('AB_Applications', '4.5', '4.5 Solving Related Rates Problems', 'Solving RR', 25, 5, false),
('AB_Applications', '4.6', '4.6 Approximating Values Using Local Linearity and Linearization', 'Linearization', 15, 6, false),
('AB_Applications', '4.7', '4.7 Using L''Hospital''s Rule for Finding Limits of Indeterminate Forms', 'L''Hospital', 15, 7, false);

-- AB_Analytical sections (Unit 5)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_Analytical', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 5.', 45, 0, true),
('AB_Analytical', '5.1', '5.1 Using the Mean Value Theorem', 'MVT', 15, 1, false),
('AB_Analytical', '5.2', '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points', 'EVT', 20, 2, false),
('AB_Analytical', '5.3', '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing', 'Inc/Dec', 15, 3, false),
('AB_Analytical', '5.4', '5.4 Using the First Derivative Test to Find Relative (Local) Extrema', '1st Deriv Test', 15, 4, false),
('AB_Analytical', '5.5', '5.5 Using the Candidates Test to Find Absolute (Global) Extrema', 'Candidates Test', 20, 5, false),
('AB_Analytical', '5.6', '5.6 Determining Concavity of Functions over Their Domains', 'Concavity', 15, 6, false),
('AB_Analytical', '5.7', '5.7 Using the Second Derivative Test to Find Extrema', '2nd Deriv Test', 15, 7, false),
('AB_Analytical', '5.8', '5.8 Sketching Graphs of Functions and Their Derivatives', 'Sketching', 20, 8, false),
('AB_Analytical', '5.9', '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative', 'Connecting Graphs', 15, 9, false),
('AB_Analytical', '5.10', '5.10 Introduction to Optimization Problems', 'Opt Intro', 15, 10, false),
('AB_Analytical', '5.11', '5.11 Solving Optimization Problems', 'Solving Opt', 25, 11, false),
('AB_Analytical', '5.12', '5.12 Exploring Behaviors of Implicit Relations', 'Implicit Behaviors', 15, 12, false);

-- AB_Integration sections (Unit 6)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_Integration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 6.', 45, 0, true),
('AB_Integration', '6.1', '6.1 Exploring Accumulations of Change', 'Accumulation', 15, 1, false),
('AB_Integration', '6.2', '6.2 Approximating Areas with Riemann Sums', 'Riemann Sums', 20, 2, false),
('AB_Integration', '6.3', '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation', 'Def Integral', 15, 3, false),
('AB_Integration', '6.4', '6.4 The Fundamental Theorem of Calculus and Accumulation Functions', 'FTC 1', 20, 4, false),
('AB_Integration', '6.5', '6.5 Interpreting the Behavior of Accumulation Functions Involving Area', 'Accumulation Funcs', 15, 5, false),
('AB_Integration', '6.6', '6.6 Applying Properties of Definite Integrals', 'Properties', 15, 6, false),
('AB_Integration', '6.7', '6.7 The Fundamental Theorem of Calculus and Definite Integrals', 'FTC 2', 15, 7, false),
('AB_Integration', '6.8', '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules', 'Indefinite', 15, 8, false),
('AB_Integration', '6.9', '6.9 Integrating Using Substitution', 'Substitution', 20, 9, false),
('AB_Integration', '6.10', '6.10 Integrating Functions Using Long Division and Completing the Square', 'Alg Manipulation', 20, 10, false),
('AB_Integration', '6.14', '6.14 Selecting Techniques for Antidifferentiation', 'Selecting Techniques', 20, 11, false);

-- AB_DiffEq sections (Unit 7)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_DiffEq', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 7.', 45, 0, true),
('AB_DiffEq', '7.1', '7.1 Modeling Situations with Differential Equations', 'Modeling', 15, 1, false),
('AB_DiffEq', '7.2', '7.2 Verifying Solutions for Differential Equations', 'Verifying', 15, 2, false),
('AB_DiffEq', '7.3', '7.3 Sketching Slope Fields', 'Slope Fields', 20, 3, false),
('AB_DiffEq', '7.4', '7.4 Reasoning Using Slope Fields', 'Reasoning', 15, 4, false),
('AB_DiffEq', '7.6', '7.6 Finding General Solutions Using Separation of Variables', 'Separation', 20, 5, false),
('AB_DiffEq', '7.7', '7.7 Finding Particular Solutions Using Initial Conditions', 'Particular Sol', 20, 6, false),
('AB_DiffEq', '7.8', '7.8 Exponential Models with Differential Equations', 'Exponential', 15, 7, false);

-- AB_AppIntegration sections (Unit 8)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('AB_AppIntegration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 8.', 45, 0, true),
('AB_AppIntegration', '8.1', '8.1 Finding the Average Value of a Function on an Interval', 'Average Value', 15, 1, false),
('AB_AppIntegration', '8.2', '8.2 Connecting Position, Velocity, and Acceleration Using Integrals', 'Motion Integrals', 15, 2, false),
('AB_AppIntegration', '8.3', '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts', 'Applied', 20, 3, false),
('AB_AppIntegration', '8.4', '8.4 Finding the Area Between Curves Expressed as Functions of x', 'Area x', 20, 4, false),
('AB_AppIntegration', '8.5', '8.5 Finding the Area Between Curves Expressed as Functions of y', 'Area y', 20, 5, false),
('AB_AppIntegration', '8.6', '8.6 Finding the Area Between Curves That Intersect at More Than Two Points', 'Multiple Intersections', 20, 6, false),
('AB_AppIntegration', '8.7', '8.7 Volumes with Cross Sections: Squares and Rectangles', 'Cross Sections 1', 20, 7, false),
('AB_AppIntegration', '8.8', '8.8 Volumes with Cross Sections: Triangles and Semicircles', 'Cross Sections 2', 20, 8, false),
('AB_AppIntegration', '8.9', '8.9 Volume with Disc Method: Revolving Around the x- or y-Axis', 'Disc', 20, 9, false),
('AB_AppIntegration', '8.10', '8.10 Volume with Disc Method: Revolving Around Other Axes', 'Disc Other', 20, 10, false),
('AB_AppIntegration', '8.11', '8.11 Volume with Washer Method: Revolving Around the x- or y-Axis', 'Washer', 20, 11, false),
('AB_AppIntegration', '8.12', '8.12 Volume with Washer Method: Revolving Around Other Axes', 'Washer Other', 20, 12, false);

-- ============================================
-- BC Course sections (same Units 1-8, then Units 9-10)
-- Copy AB sections for BC (Units 1-5 are identical)
-- ============================================

-- BC_Limits (same as AB)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_Limits', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_Limits';

-- BC_Derivatives (same as AB)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_Derivatives', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_Derivatives';

-- BC_Composite (same as AB)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_Composite', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_Composite';

-- BC_Applications (same as AB)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_Applications', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_Applications';

-- BC_Analytical (same as AB)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_Analytical', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_Analytical';

-- BC_Integration (includes BC-only sections 6.11-6.13)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_Integration', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_Integration';

INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Integration', '6.11', '6.11 (BC) Using Integration by Parts', 'Integration by Parts', 20, 12, false),
('BC_Integration', '6.12', '6.12 (BC) Integrating Using Linear Partial Fractions', 'Partial Fractions', 20, 13, false),
('BC_Integration', '6.13', '6.13 (BC) Evaluating Improper Integrals', 'Improper Integrals', 20, 14, false);

-- BC_DiffEq (includes BC-only sections 7.5, 7.9)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_DiffEq', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_DiffEq';

INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_DiffEq', '7.5', '7.5 (BC) Approximating Solutions Using Euler''s Method', 'Euler Method', 20, 5, false),
('BC_DiffEq', '7.9', '7.9 (BC) Logistic Models with Differential Equations', 'Logistic Models', 20, 8, false);

-- BC_AppIntegration (includes BC-only section 8.13)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test)
SELECT 'BC_AppIntegration', id, title, description, estimated_minutes, sort_order, is_unit_test
FROM sections WHERE topic_id = 'AB_AppIntegration';

INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_AppIntegration', '8.13', '8.13 (BC) The Arc Length of a Smooth, Planar Curve', 'Arc Length', 20, 13, false);

-- BC_Unit9 (Parametric, Polar, Vectors - BC only)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Unit9', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 9.', 45, 0, true),
('BC_Unit9', '9.1', '9.1 Defining and Differentiating Parametric Equations', 'Parametric Intro', 20, 1, false),
('BC_Unit9', '9.2', '9.2 Second Derivatives of Parametric Equations', 'Param 2nd Deriv', 15, 2, false),
('BC_Unit9', '9.3', '9.3 Finding Arc Lengths of Curves Given by Parametric Equations', 'Param Arc', 20, 3, false),
('BC_Unit9', '9.4', '9.4 Defining and Differentiating Vector-Valued Functions', 'Vectors', 20, 4, false),
('BC_Unit9', '9.5', '9.5 Integrating Vector-Valued Functions', 'Vector Integration', 20, 5, false),
('BC_Unit9', '9.6', '9.6 Solving Motion Problems Using Parametric and Vector Functions', 'Motion', 25, 6, false),
('BC_Unit9', '9.7', '9.7 Defining Polar Coordinates and Differentiating in Polar Form', 'Polar Intro', 20, 7, false),
('BC_Unit9', '9.8', '9.8 Finding the Area of a Polar Region', 'Polar Area Single', 20, 8, false),
('BC_Unit9', '9.9', '9.9 Finding the Area of the Region Bounded by Two Polar Curves', 'Polar Area Between', 20, 9, false);

-- BC_Series (Infinite Sequences and Series - BC only)
INSERT INTO sections (topic_id, id, title, description, estimated_minutes, sort_order, is_unit_test) VALUES
('BC_Series', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 10.', 45, 0, true),
('BC_Series', '10.1', '10.1 Defining Convergent and Divergent Infinite Series', 'Convergence', 20, 1, false),
('BC_Series', '10.2', '10.2 Working with Geometric Series', 'Geometric', 15, 2, false),
('BC_Series', '10.3', '10.3 The nth Term Test for Divergence', 'nth Term', 15, 3, false),
('BC_Series', '10.4', '10.4 Integral Test for Convergence', 'Integral Test', 20, 4, false),
('BC_Series', '10.5', '10.5 Harmonic Series and p-Series', 'Harmonic/p-Series', 15, 5, false),
('BC_Series', '10.6', '10.6 Comparison Tests for Convergence', 'Comparison', 20, 6, false),
('BC_Series', '10.7', '10.7 Alternating Series Test for Convergence', 'Alternating', 15, 7, false),
('BC_Series', '10.8', '10.8 Ratio Test for Convergence', 'Ratio Test', 15, 8, false),
('BC_Series', '10.9', '10.9 Determining Absolute or Conditional Convergence', 'Abs/Cond', 15, 9, false),
('BC_Series', '10.10', '10.10 Alternating Series Error Bound', 'Error Bound', 15, 10, false),
('BC_Series', '10.11', '10.11 Finding Taylor Polynomial Approximations of Functions', 'Taylor Poly', 25, 11, false),
('BC_Series', '10.12', '10.12 Lagrange Error Bound', 'Lagrange', 20, 12, false),
('BC_Series', '10.13', '10.13 Radius and Interval of Convergence of Power Series', 'Radius/Interval', 20, 13, false),
('BC_Series', '10.14', '10.14 Finding Taylor or Maclaurin Series for a Function', 'Taylor/Maclaurin', 25, 14, false),
('BC_Series', '10.15', '10.15 Representing Functions as Power Series', 'Representation', 20, 15, false);

-- Verify count
SELECT COUNT(*) AS total_sections FROM sections;
