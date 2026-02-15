-- ============================================================
-- UNIFY AB/BC CONTENT STRUCTURE
-- Restructures tables to merge shared content and separate BC-only content.
-- Dropping/Recreating 'topics' and 'sections' tables.
-- ============================================================

-- 1. DROP EXISTING TABLES
DROP TABLE IF EXISTS public.sections CASCADE;
DROP TABLE IF EXISTS public.topics CASCADE; -- Or topic_content if it existed

-- 2. CREATE TOPICS TABLE
CREATE TABLE public.topics (
    id VARCHAR(50) PRIMARY KEY, -- e.g., 'ABBC_Limits', 'BC_Unit9'
    title VARCHAR(255) NOT NULL,
    description TEXT,
    course_scope VARCHAR(20) DEFAULT 'both' CHECK (course_scope IN ('both', 'ab_only', 'bc_only')),
    sort_order INTEGER DEFAULT 0
);

-- Enable RLS for topics
ALTER TABLE public.topics ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read topics" ON public.topics FOR SELECT USING (true);
CREATE POLICY "Creators can manage topics" ON public.topics FOR ALL USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND is_creator = true)
);

-- 3. CREATE SECTIONS TABLE
CREATE TABLE public.sections (
    id VARCHAR(50) NOT NULL, -- e.g., '1.1', '10.1', 'unit_test'
    topic_id VARCHAR(50) REFERENCES public.topics(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT DEFAULT '',
    course_scope VARCHAR(20) DEFAULT 'both' CHECK (course_scope IN ('both', 'ab_only', 'bc_only')),
    estimated_minutes INTEGER DEFAULT 15,
    has_lesson BOOLEAN DEFAULT true,
    has_practice BOOLEAN DEFAULT true,
    is_unit_test BOOLEAN DEFAULT false,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (topic_id, id)
);

-- Indices
CREATE INDEX idx_sections_topic_id ON public.sections(topic_id);
CREATE INDEX idx_sections_scope ON public.sections(course_scope);

-- Enable RLS for sections
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read sections" ON public.sections FOR SELECT USING (true);
CREATE POLICY "Creators can manage sections" ON public.sections FOR ALL USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND is_creator = true)
);


-- ============================================================
-- 4. INSERT UNIFIED CONTENT
-- ============================================================

-- UNIT 1: Limits (Shared)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_Limits', 'Unit 1: Limits and Continuity', 'Limits and Continuity', 'both', 1);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Limits', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 1.', 'both', 45, 0, true),
('ABBC_Limits', '1.1', '1.1 Introducing Calculus: Can Change Occur at an Instant?', 'Avg vs Instant Rate', 'both', 10, 1, false),
('ABBC_Limits', '1.2', '1.2 Defining Limits and Using Limit Notation', 'Limit Notation', 'both', 15, 2, false),
('ABBC_Limits', '1.3', '1.3 Estimating Limit Values from Graphs', 'Graphical Limits', 'both', 10, 3, false),
('ABBC_Limits', '1.4', '1.4 Estimating Limit Values from Tables', 'Numerical Limits', 'both', 10, 4, false),
('ABBC_Limits', '1.5', '1.5 Determining Limits Using Algebraic Properties of Limits', 'Limit Laws', 'both', 15, 5, false),
('ABBC_Limits', '1.6', '1.6 Determining Limits Using Algebraic Manipulation', 'Factoring/Conjugates', 'both', 20, 6, false),
('ABBC_Limits', '1.7', '1.7 Selecting Procedures for Determining Limits', 'Strategy', 'both', 15, 7, false),
('ABBC_Limits', '1.8', '1.8 Determining Limits Using the Squeeze Theorem', 'Squeeze Theorem', 'both', 15, 8, false),
('ABBC_Limits', '1.9', '1.9 Connecting Multiple Representations of Limits', 'Synthesis', 'both', 10, 9, false),
('ABBC_Limits', '1.10', '1.10 Exploring Types of Discontinuities', 'Removable/Jump/Infinite', 'both', 15, 10, false),
('ABBC_Limits', '1.11', '1.11 Defining Continuity at a Point', '3-Part Definition', 'both', 15, 11, false),
('ABBC_Limits', '1.12', '1.12 Confirming Continuity over an Interval', 'Intervals', 'both', 10, 12, false),
('ABBC_Limits', '1.13', '1.13 Removing Discontinuities', 'Extensions', 'both', 15, 13, false),
('ABBC_Limits', '1.14', '1.14 Connecting Infinite Limits and Vertical Asymptotes', 'Asymptotes', 'both', 15, 14, false),
('ABBC_Limits', '1.15', '1.15 Connecting Limits at Infinity and Horizontal Asymptotes', 'End Behavior', 'both', 15, 15, false),
('ABBC_Limits', '1.16', '1.16 Working with the Intermediate Value Theorem', 'IVT', 'both', 15, 16, false);


-- UNIT 2: Derivatives (Shared)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_Derivatives', 'Unit 2: Differentiation: Definition and Fundamental Properties', 'Differentiation Definition', 'both', 2);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Derivatives', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 2.', 'both', 45, 0, true),
('ABBC_Derivatives', '2.1', '2.1 Defining Average and Instantaneous Rates of Change at a Point', 'Slopes', 'both', 15, 1, false),
('ABBC_Derivatives', '2.2', '2.2 Defining the Derivative of a Function and Using Derivative Notation', 'Notation', 'both', 20, 2, false),
('ABBC_Derivatives', '2.3', '2.3 Estimating Derivatives of a Function at a Point', 'Estimation', 'both', 15, 3, false),
('ABBC_Derivatives', '2.4', '2.4 Connecting Differentiability and Continuity', 'Differentiability', 'both', 15, 4, false),
('ABBC_Derivatives', '2.5', '2.5 Applying the Power Rule', 'Power Rule', 'both', 10, 5, false),
('ABBC_Derivatives', '2.6', '2.6 Derivative Rules: Constant, Sum, Difference, and CM', 'Linearity', 'both', 10, 6, false),
('ABBC_Derivatives', '2.7', '2.7 Derivatives of cos x, sin x, e^x, and ln x', 'Basic Transcendentals', 'both', 15, 7, false),
('ABBC_Derivatives', '2.8', '2.8 The Product Rule', 'Product Rule', 'both', 15, 8, false),
('ABBC_Derivatives', '2.9', '2.9 The Quotient Rule', 'Quotient Rule', 'both', 15, 9, false),
('ABBC_Derivatives', '2.10', '2.10 Finding the Derivatives of Tangent, Cotangent, Secant, Cosecant', 'Other Trig', 'both', 15, 10, false);


-- UNIT 3: Composite (Shared)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_Composite', 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', 'Composite Functions', 'both', 3);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Composite', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 3.', 'both', 45, 0, true),
('ABBC_Composite', '3.1', '3.1 The Chain Rule', 'Chain Rule', 'both', 20, 1, false),
('ABBC_Composite', '3.2', '3.2 Implicit Differentiation', 'Implicit', 'both', 20, 2, false),
('ABBC_Composite', '3.3', '3.3 Differentiating Inverse Functions', 'Inverse Derivs', 'both', 15, 3, false),
('ABBC_Composite', '3.4', '3.4 Differentiating Inverse Trigonometric Functions', 'Inverse Trig', 'both', 15, 4, false),
('ABBC_Composite', '3.5', '3.5 Selecting Procedures for Calculating Derivatives', 'Strategy', 'both', 15, 5, false),
('ABBC_Composite', '3.6', '3.6 Calculating Higher-Order Derivatives', 'Higher Order', 'both', 15, 6, false);


-- UNIT 4: Applications (Shared)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_Applications', 'Unit 4: Contextual Applications of Differentiation', 'Contextual Applications', 'both', 4);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Applications', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 4.', 'both', 45, 0, true),
('ABBC_Applications', '4.1', '4.1 Interpreting the Meaning of the Derivative in Context', 'Context', 'both', 15, 1, false),
('ABBC_Applications', '4.2', '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration', 'Motion', 'both', 20, 2, false),
('ABBC_Applications', '4.3', '4.3 Rates of Change in Applied Contexts other than Motion', 'Other Rates', 'both', 15, 3, false),
('ABBC_Applications', '4.4', '4.4 Introduction to Related Rates', 'Intro RR', 'both', 20, 4, false),
('ABBC_Applications', '4.5', '4.5 Solving Related Rates Problems', 'Solving RR', 'both', 25, 5, false),
('ABBC_Applications', '4.6', '4.6 Approximating Values Using Local Linearity and Linearization', 'Linearization', 'both', 15, 6, false),
('ABBC_Applications', '4.7', '4.7 Using L''Hospital''s Rule for Finding Limits of Indeterminate Forms', 'L''Hospital', 'both', 15, 7, false);


-- UNIT 5: Analytical (Shared)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_Analytical', 'Unit 5: Analytical Applications of Differentiation', 'Analytical Applications', 'both', 5);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Analytical', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 5.', 'both', 45, 0, true),
('ABBC_Analytical', '5.1', '5.1 Using the Mean Value Theorem', 'MVT', 'both', 15, 1, false),
('ABBC_Analytical', '5.2', '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points', 'EVT', 'both', 20, 2, false),
('ABBC_Analytical', '5.3', '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing', 'Inc/Dec', 'both', 15, 3, false),
('ABBC_Analytical', '5.4', '5.4 Using the First Derivative Test to Find Relative (Local) Extrema', '1st Deriv Test', 'both', 15, 4, false),
('ABBC_Analytical', '5.5', '5.5 Using the Candidates Test to Find Absolute (Global) Extrema', 'Candidates Test', 'both', 20, 5, false),
('ABBC_Analytical', '5.6', '5.6 Determining Concavity of Functions over Their Domains', 'Concavity', 'both', 15, 6, false),
('ABBC_Analytical', '5.7', '5.7 Using the Second Derivative Test to Find Extrema', '2nd Deriv Test', 'both', 15, 7, false),
('ABBC_Analytical', '5.8', '5.8 Sketching Graphs of Functions and Their Derivatives', 'Sketching', 'both', 20, 8, false),
('ABBC_Analytical', '5.9', '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative', 'Connecting Graphs', 'both', 15, 9, false),
('ABBC_Analytical', '5.10', '5.10 Introduction to Optimization Problems', 'Opt Intro', 'both', 15, 10, false),
('ABBC_Analytical', '5.11', '5.11 Solving Optimization Problems', 'Solving Opt', 'both', 25, 11, false),
('ABBC_Analytical', '5.12', '5.12 Exploring Behaviors of Implicit Relations', 'Implicit Behaviors', 'both', 15, 12, false);


-- UNIT 6: Integration (Mixed Scope)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_Integration', 'Unit 6: Integration and Accumulation of Change', 'Integration and Accumulation of Change', 'both', 6);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_Integration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 6.', 'both', 45, 0, true),
('ABBC_Integration', '6.1', '6.1 Exploring Accumulations of Change', 'Accumulation', 'both', 15, 1, false),
('ABBC_Integration', '6.2', '6.2 Approximating Areas with Riemann Sums', 'Riemann Sums', 'both', 20, 2, false),
('ABBC_Integration', '6.3', '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation', 'Def Integral', 'both', 15, 3, false),
('ABBC_Integration', '6.4', '6.4 The Fundamental Theorem of Calculus and Accumulation Functions', 'FTC 1', 'both', 20, 4, false),
('ABBC_Integration', '6.5', '6.5 Interpreting the Behavior of Accumulation Functions Involving Area', 'Accumulation Funcs', 'both', 15, 5, false),
('ABBC_Integration', '6.6', '6.6 Applying Properties of Definite Integrals', 'Properties', 'both', 15, 6, false),
('ABBC_Integration', '6.7', '6.7 The Fundamental Theorem of Calculus and Definite Integrals', 'FTC 2', 'both', 15, 7, false),
('ABBC_Integration', '6.8', '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules', 'Indefinite', 'both', 15, 8, false),
('ABBC_Integration', '6.9', '6.9 Integrating Using Substitution', 'Substitution', 'both', 20, 9, false),
('ABBC_Integration', '6.10', '6.10 Integrating Functions Using Long Division and Completing the Square', 'Alg Manipulation', 'both', 20, 10, false),
-- BC Only Sections
('ABBC_Integration', '6.11', '6.11 (BC) Using Integration by Parts', 'Integration by Parts', 'bc_only', 20, 11, false),
('ABBC_Integration', '6.12', '6.12 (BC) Integrating Using Linear Partial Fractions', 'Partial Fractions', 'bc_only', 20, 12, false),
('ABBC_Integration', '6.13', '6.13 (BC) Evaluating Improper Integrals', 'Improper Integrals', 'bc_only', 20, 13, false),
-- Shared End
('ABBC_Integration', '6.14', '6.14 Selecting Techniques for Antidifferentiation', 'Selecting Techniques', 'both', 20, 14, false);


-- UNIT 7: Differential Equations (Mixed Scope)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_DiffEq', 'Unit 7: Differential Equations', 'Differential Equations', 'both', 7);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_DiffEq', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 7.', 'both', 45, 0, true),
('ABBC_DiffEq', '7.1', '7.1 Modeling Situations with Differential Equations', 'Modeling', 'both', 15, 1, false),
('ABBC_DiffEq', '7.2', '7.2 Verifying Solutions for Differential Equations', 'Verifying', 'both', 15, 2, false),
('ABBC_DiffEq', '7.3', '7.3 Sketching Slope Fields', 'Slope Fields', 'both', 20, 3, false),
('ABBC_DiffEq', '7.4', '7.4 Reasoning Using Slope Fields', 'Reasoning', 'both', 15, 4, false),
-- BC Only
('ABBC_DiffEq', '7.5', '7.5 (BC) Approximating Solutions Using Euler''s Method', 'Euler Method', 'bc_only', 20, 5, false),
-- Shared
('ABBC_DiffEq', '7.6', '7.6 Finding General Solutions Using Separation of Variables', 'Separation', 'both', 20, 6, false),
('ABBC_DiffEq', '7.7', '7.7 Finding Particular Solutions Using Initial Conditions', 'Particular Sol', 'both', 20, 7, false),
('ABBC_DiffEq', '7.8', '7.8 Exponential Models with Differential Equations', 'Exponential', 'both', 15, 8, false),
-- BC Only
('ABBC_DiffEq', '7.9', '7.9 (BC) Logistic Models with Differential Equations', 'Logistic Models', 'bc_only', 20, 9, false);


-- UNIT 8: App of Integration (Mixed Scope)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('ABBC_AppIntegration', 'Unit 8: Applications of Integration', 'Applications of Integration', 'both', 8);

INSERT INTO public.sections (topic_id, id, title, description, course_scope, estimated_minutes, sort_order, is_unit_test) VALUES
('ABBC_AppIntegration', 'unit_test', 'Unit Test', 'Comprehensive assessment covering all topics in Unit 8.', 'both', 45, 0, true),
('ABBC_AppIntegration', '8.1', '8.1 Finding the Average Value of a Function on an Interval', 'Average Value', 'both', 15, 1, false),
('ABBC_AppIntegration', '8.2', '8.2 Connecting Position, Velocity, and Acceleration Using Integrals', 'Motion Integrals', 'both', 15, 2, false),
('ABBC_AppIntegration', '8.3', '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts', 'Applied', 'both', 20, 3, false),
('ABBC_AppIntegration', '8.4', '8.4 Finding the Area Between Curves Expressed as Functions of x', 'Area x', 'both', 20, 4, false),
('ABBC_AppIntegration', '8.5', '8.5 Finding the Area Between Curves Expressed as Functions of y', 'Area y', 'both', 20, 5, false),
('ABBC_AppIntegration', '8.6', '8.6 Finding the Area Between Curves That Intersect at More Than Two Points', 'Multiple Intersections', 'both', 20, 6, false),
('ABBC_AppIntegration', '8.7', '8.7 Volumes with Cross Sections: Squares and Rectangles', 'Cross Sections 1', 'both', 20, 7, false),
('ABBC_AppIntegration', '8.8', '8.8 Volumes with Cross Sections: Triangles and Semicircles', 'Cross Sections 2', 'both', 20, 8, false),
('ABBC_AppIntegration', '8.9', '8.9 Volume with Disc Method: Revolving Around the x- or y-Axis', 'Disc', 'both', 20, 9, false),
('ABBC_AppIntegration', '8.10', '8.10 Volume with Disc Method: Revolving Around Other Axes', 'Disc Other', 'both', 20, 10, false),
('ABBC_AppIntegration', '8.11', '8.11 Volume with Washer Method: Revolving Around the x- or y-Axis', 'Washer', 'both', 20, 11, false),
('ABBC_AppIntegration', '8.12', '8.12 Volume with Washer Method: Revolving Around Other Axes', 'Washer Other', 'both', 20, 12, false),
-- BC Only
('ABBC_AppIntegration', '8.13', '8.13 (BC) The Arc Length of a Smooth, Planar Curve', 'Arc Length', 'bc_only', 20, 13, false);


-- UNIT 9: Parametric/Polar (BC Only)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('BC_Unit9', 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', 'Parametric/Polar/Vector', 'bc_only', 9);

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
('BC_Unit9', '9.9', '9.9 Finding the Area of the Region Bounded by Two Polar Curves', 'Polar Area Between', 'bc_only', 20, 9, false);


-- UNIT 10: Series (BC Only)
INSERT INTO public.topics (id, title, description, course_scope, sort_order) VALUES
('BC_Series', 'Unit 10: Infinite Sequences and Series', 'Infinite Series', 'bc_only', 10);

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
('BC_Series', '10.15', '10.15 Representing Functions as Power Series', 'Representation', 'bc_only', 20, 15, false);
