-- ============================================
-- SECTIONS SEED DATA ONLY
-- Run this in Supabase SQL Editor
-- ============================================

-- Clear existing data (if any)
DELETE FROM sections;

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

-- Verify
SELECT COUNT(*) AS total_sections FROM sections;
