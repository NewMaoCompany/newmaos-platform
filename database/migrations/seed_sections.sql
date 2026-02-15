
-- 1. Ensure get_all_user_progress exists (Critical for Resume/Status)
DROP FUNCTION IF EXISTS get_all_user_progress();

CREATE OR REPLACE FUNCTION get_all_user_progress()
RETURNS SETOF user_section_progress AS $$
BEGIN
    RETURN QUERY SELECT * FROM user_section_progress WHERE user_id = auth.uid();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Ensure Sections Table Exists with Correct Structure
CREATE TABLE IF NOT EXISTS sections (
    id TEXT NOT NULL,
    topic_id TEXT NOT NULL,
    title TEXT NOT NULL,
    is_unit_test BOOLEAN DEFAULT false,
    course_scope TEXT DEFAULT 'both',
    estimated_minutes INTEGER DEFAULT 0,
    description_2 TEXT, -- Added for detailed content
    -- Add any other missing columns if needed, but these are core
    CONSTRAINT sections_pkey PRIMARY KEY (id)
);

-- ROBUST FIX: Ensure PK exists on id, removing duplicates and old constraints if needed
DO $$
DECLARE
    r RECORD;
BEGIN
    -- 0. Ensure description_2 column exists
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='sections' AND column_name='description_2') THEN
        ALTER TABLE sections ADD COLUMN description_2 TEXT;
    END IF;

    -- 1. Remove duplicates (keeping the latest one based on ctid is simple, or just any one)
    DELETE FROM sections a USING sections b WHERE a.id = b.id AND a.ctid < b.ctid;

    -- 2. Drop any EXISTING Primary Key constraint on 'sections' (handle case where name is not 'sections_pkey')
    FOR r IN SELECT conname FROM pg_constraint WHERE conrelid = 'sections'::regclass AND contype = 'p'
    LOOP
        EXECUTE 'ALTER TABLE sections DROP CONSTRAINT ' || quote_ident(r.conname);
    END LOOP;

    -- 3. Add the correct Primary Key
    ALTER TABLE sections ADD CONSTRAINT sections_pkey PRIMARY KEY (id);
END $$;

-- 3. Seed Sections (Units 1-10) with Descriptions

INSERT INTO sections (id, topic_id, title, is_unit_test, course_scope, estimated_minutes, description_2)
VALUES
-- Unit 1
('1.1', 'Both_Limits', '1.1 Introducing Calculus: Can Change Occur at an Instant?', false, 'both', 10, 'This chapter bridges precalculus and calculus by examining the difference between average rate of change and instantaneous rate of change. Students explore the secant line slope as a precursor to the tangent line slope. The core concept is that as the time interval shrinks to zero, the average velocity approaches the instantaneous velocity. This limit process is foundational to understanding derivatives. It challenges students to think about motion and change not just over intervals, but at a specific moment in time.'),
('1.2', 'Both_Limits', '1.2 Defining Limits and Using Limit Notation', false, 'both', 15, 'This chapter introduces the formal notation of limits, requiring students to understand that a limit describes the behavior of a function as inputs approach a value, not necessarily the value of the function at that point. It covers one-sided limits and the condition for a general limit to exist. Students learn to read and write limit expressions correctly, emphasizing that ''approaching'' is the key operation. This rigorous definition sets the stage for all future calculus operations.'),
('1.3', 'Both_Limits', '1.3 Estimating Limit Values from Graphs', false, 'both', 10, 'In this chapter, students develop visual intuition for limits by examining graphs of functions, including those with holes, jumps, and vertical asymptotes. The focus is on identifying the y-value that the graph approaches from both the left and right sides. Students distinguish between the limit value and the function value (f(c)), reinforcing that a function can be undefined at a point yet still have a limit there. This visual skill is critical for quick analysis of function behavior.'),
('1.4', 'Both_Limits', '1.4 Estimating Limit Values from Tables', false, 'both', 10, 'This chapter focuses on the numerical approach to limits. Students analyze tables of values to observe trends as x gets closer and closer to a target number from both sides. It emphasizes the importance of choosing x-values that are incrementally closer (e.g., 1.9, 1.99, 1.999) to establish a convincing pattern. Students also learn to recognize when a table suggests that a limit does not exist, such as when values oscillate or diverge.'),
('1.5', 'Both_Limits', '1.5 Determining Limits Using Algebraic Properties of Limits', false, 'both', 15, 'This chapter covers the algebraic laws that allow limits to be computed by breaking complex expressions into simpler parts. Students learn rules for sums, differences, products, quotients, and powers. The lesson emphasizes that these rules apply directly only when the limits of the individual components exist. It builds a toolkit for evaluating limits analytically without relying solely on graphs or calculators, serving as a first step toward algebraic mastery of calculus.'),
('1.6', 'Both_Limits', '1.6 Determining Limits Using Algebraic Manipulation', false, 'both', 20, 'This chapter tackles indeterminate forms like 0/0 by equipping students with algebraic techniques such as factoring, canceling common factors, rationalizing numerators using conjugates, and simplifying complex fractions. The goal is to transform the expression into a continuous form where direct substitution works. This ''algebraic gymnastics'' is a core skill for AP Calculus, requiring precision and the ability to recognize which method unlocks the limit.'),
('1.7', 'Both_Limits', '1.7 Selecting Procedures for Determining Limits', false, 'both', 15, 'This chapter synthesizes previous methods, asking students to choose the most efficient strategy for a given limit problem. They must decide whether to use direct substitution, algebraic manipulation, graphical inspection, or numerical estimation. It emphasizes recognizing problem types—knowing when to factor versus when to rationalize or when to check one-sided limits. This decision-making process is crucial for speed and accuracy on the Exam.'),
('1.8', 'Both_Limits', '1.8 Determining Limits Using the Squeeze Theorem', false, 'both', 15, 'This chapter introduces the squeeze theorem as a powerful way to evaluate limits that are difficult or impossible to compute directly. Students learn to trap a function between two simpler functions that share the same limiting behavior. The focus is on building correct bounds, checking that the target function truly stays between them, and drawing a valid conclusion. Many problems involve oscillating behavior and require strong inequality reasoning.'),
('1.9', 'Both_Limits', '1.9 Connecting Multiple Representations of Limits', false, 'both', 10, 'This chapter connects graphical, numerical, and algebraic representations of limits. Students practice translating between these forms to build a robust understanding. For example, they might start with a graph and derive an algebraic function, or look at a table and sketch a possible graph. This multi-modal approach ensures deep conceptual retention and prepares students for questions that test flexibility in thinking about functions.'),
('1.10', 'Both_Limits', '1.10 Exploring Types of Discontinuities', false, 'both', 15, 'This chapter categorizes discontinuities into three main types: removable (holes), jump (breaks), and infinite (vertical asymptotes). Students learn the specific limit conditions that define each type. The lesson emphasizes the difference between a function incorrectly defined at a point versus the limit not matching the function value. Mastering this vocabulary allows students to describe function behavior precisely and diagnose why a function fails to be continuous.'),
('1.11', 'Both_Limits', '1.11 Defining Continuity at a Point', false, 'both', 15, 'This chapter presents the rigorous three-part definition of continuity: 1) f(c) helps exist, 2) limit as x approaches c exists, and 3) the limit equals the function value. Students must verify all three conditions to prove continuity at a specific point. This definition is a frequent free-response topic. The lesson drills the logical steps required to construct a formal argument for or against continuity.'),
('1.12', 'Both_Limits', '1.12 Confirming Continuity over an Interval', false, 'both', 10, 'This chapter extends the concept of continuity from a single point to an entire interval. Students investigate what it means for a function to be continuous on open versus closed intervals. The lesson covers the specific behavior required at endpoints and how domain restrictions (like roots and logs) affect continuity. Understanding interval continuity is a prerequisite for major theorems like IVT and EVT.'),
('1.13', 'Both_Limits', '1.13 Removing Discontinuities', false, 'both', 15, 'This chapter teaches students how to fix certain discontinuities by redefining a function at a single point. Students learn when a discontinuity is removable and how to choose a value that makes the function continuous. The key skill is understanding that the function''s behavior near a point determines whether it can be repaired. This chapter reinforces the relationship between limits and continuity.'),
('1.14', 'Both_Limits', '1.14 Connecting Infinite Limits and Vertical Asymptotes', false, 'both', 15, 'This chapter establishes the link between infinite limits and vertical asymptotes. Students learn that if a limit approaches infinity as x approaches a number, the graph has a vertical asymptote there. The lesson involves analyzing rational functions where the denominator is zero but the numerator is not. Students practice writing limit statements to justify the existence of asymptotes, a required skill for the AP exam.'),
('1.15', 'Both_Limits', '1.15 Connecting Limits at Infinity and Horizontal Asymptotes', false, 'both', 15, 'This chapter focuses on end behavior, examining limits as x approaches positive or negative infinity. Students learn that these limits determine horizontal asymptotes. The lesson covers techniques for comparing growth rates of numerator and denominator terms (dominant terms) to quickly evaluate limits at infinity. This global view of functions complements the local view provided by derivatives.'),
('1.16', 'Both_Limits', '1.16 Working with the Intermediate Value Theorem', false, 'both', 15, 'This chapter introduces the Intermediate Value Theorem (IVT), an existence theorem that guarantees a function takes on every value between two endpoints if it is continuous. Students learn the precise conditions required to apply IVT (continuity on a closed interval) and how to construct a justification statement. The lesson emphasizes that IVT guarantees a solution exists but does not find it.'),
('Both_Limits_unit_test', 'Both_Limits', 'Unit 1 Test', true, 'both', 45, ''),

-- Unit 2
('2.1', 'Both_Derivatives', '2.1 Defining Average and Instantaneous Rates of Change at a Point', false, 'both', 15, ''),
('2.2', 'Both_Derivatives', '2.2 Defining the Derivative of a Function and Using Derivative Notation', false, 'both', 20, ''),
('2.3', 'Both_Derivatives', '2.3 Estimating Derivatives of a Function at a Point', false, 'both', 15, ''),
('2.4', 'Both_Derivatives', '2.4 Connecting Differentiability and Continuity', false, 'both', 15, ''),
('2.5', 'Both_Derivatives', '2.5 Applying the Power Rule', false, 'both', 10, ''),
('2.6', 'Both_Derivatives', '2.6 Derivative Rules: Constant, Sum, Difference', false, 'both', 10, ''),
('2.7', 'Both_Derivatives', '2.7 Derivatives of cos x, sin x, e^x, and ln x', false, 'both', 15, ''),
('2.8', 'Both_Derivatives', '2.8 The Product Rule', false, 'both', 15, ''),
('2.9', 'Both_Derivatives', '2.9 The Quotient Rule', false, 'both', 15, ''),
('2.10', 'Both_Derivatives', '2.10 Finding the Derivatives of Tangent, Cotangent, Secant, and/or Cosecant Functions', false, 'both', 15, ''),
('Both_Derivatives_unit_test', 'Both_Derivatives', 'Unit 2 Test', true, 'both', 45, ''),

-- Unit 3
('3.1', 'Both_Composite', '3.1 The Chain Rule', false, 'both', 20, ''),
('3.2', 'Both_Composite', '3.2 Implicit Differentiation', false, 'both', 20, ''),
('3.3', 'Both_Composite', '3.3 Differentiating Inverse Functions', false, 'both', 15, ''),
('3.4', 'Both_Composite', '3.4 Differentiating Inverse Trigonometric Functions', false, 'both', 15, ''),
('3.5', 'Both_Composite', '3.5 Selecting Procedures for Calculating Derivatives', false, 'both', 15, ''),
('3.6', 'Both_Composite', '3.6 Calculating Higher-Order Derivatives', false, 'both', 15, ''),
('Both_Composite_unit_test', 'Both_Composite', 'Unit 3 Test', true, 'both', 45, ''),

-- Unit 4
('4.1', 'Both_Applications', '4.1 Interpreting the Meaning of the Derivative in Context', false, 'both', 15, ''),
('4.2', 'Both_Applications', '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration', false, 'both', 20, ''),
('4.3', 'Both_Applications', '4.3 Rates of Change in Applied Contexts other than Motion', false, 'both', 15, ''),
('4.4', 'Both_Applications', '4.4 Introduction to Related Rates', false, 'both', 20, ''),
('4.5', 'Both_Applications', '4.5 Solving Related Rates Problems', false, 'both', 25, ''),
('4.6', 'Both_Applications', '4.6 Approximating Values of a Function Using Local Linearity and Linearization', false, 'both', 15, ''),
('4.7', 'Both_Applications', '4.7 Using L’Hospital’s Rule for Finding Limits of Indeterminate Forms', false, 'both', 15, ''),
('Both_Applications_unit_test', 'Both_Applications', 'Unit 4 Test', true, 'both', 45, ''),

-- Unit 5
('5.1', 'Both_Analytical', '5.1 Using the Mean Value Theorem', false, 'both', 15, ''),
('5.2', 'Both_Analytical', '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points', false, 'both', 20, ''),
('5.3', 'Both_Analytical', '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing', false, 'both', 15, ''),
('5.4', 'Both_Analytical', '5.4 Using the First Derivative Test to Find Relative (Local) Extrema', false, 'both', 15, ''),
('5.5', 'Both_Analytical', '5.5 Using the Candidates Test to Find Absolute (Global) Extrema', false, 'both', 20, ''),
('5.6', 'Both_Analytical', '5.6 Determining Concavity of Functions over Their Domains', false, 'both', 15, ''),
('5.7', 'Both_Analytical', '5.7 Using the Second Derivative Test to Find Extrema', false, 'both', 15, ''),
('5.8', 'Both_Analytical', '5.8 Sketching Graphs of Functions and Their Derivatives', false, 'both', 20, ''),
('5.9', 'Both_Analytical', '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative', false, 'both', 15, ''),
('5.10', 'Both_Analytical', '5.10 Introduction to Optimization Problems', false, 'both', 15, ''),
('5.11', 'Both_Analytical', '5.11 Solving Optimization Problems', false, 'both', 25, ''),
('5.12', 'Both_Analytical', '5.12 Exploring Behaviors of Implicit Relations', false, 'both', 15, ''),
('Both_Analytical_unit_test', 'Both_Analytical', 'Unit 5 Test', true, 'both', 45, ''),

-- Unit 6 (BC/Mixed)
('6.1', 'Both_Integration', '6.1 Exploring Accumulations of Change', false, 'both', 15, ''),
('6.2', 'Both_Integration', '6.2 Approximating Areas with Riemann Sums', false, 'both', 20, ''),
('6.3', 'Both_Integration', '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation', false, 'both', 15, ''),
('6.4', 'Both_Integration', '6.4 The Fundamental Theorem of Calculus and Accumulation Functions', false, 'both', 20, ''),
('6.5', 'Both_Integration', '6.5 Interpreting the Behavior of Accumulation Functions Involving Area', false, 'both', 15, ''),
('6.6', 'Both_Integration', '6.6 Applying Properties of Definite Integrals', false, 'both', 15, ''),
('6.7', 'Both_Integration', '6.7 The Fundamental Theorem of Calculus and Definite Integrals', false, 'both', 15, ''),
('6.8', 'Both_Integration', '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules and Notation', false, 'both', 15, ''),
('6.9', 'Both_Integration', '6.9 Integrating Using Substitution', false, 'both', 20, ''),
('6.10', 'Both_Integration', '6.10 Integrating Functions Using Long Division and Completing the Square', false, 'both', 20, ''),
('6.11', 'Both_Integration', '6.11 (BC ONLY) Using Integration by Parts', false, 'bc_only', 20, ''),
('6.12', 'Both_Integration', '6.12 (BC ONLY) Integrating Using Linear Partial Fractions', false, 'bc_only', 20, ''),
('6.13', 'Both_Integration', '6.13 (BC ONLY) Evaluating Improper Integrals', false, 'bc_only', 20, ''),
('6.14', 'Both_Integration', '6.14 Selecting Techniques for Antidifferentiation', false, 'both', 20, ''),
('Both_Integration_unit_test', 'Both_Integration', 'Unit 6 Test', true, 'both', 45, ''),

-- Unit 7 (Diff Eq)
('7.1', 'Both_DiffEq', '7.1 Modeling Situations with Differential Equations', false, 'both', 15, ''),
('7.2', 'Both_DiffEq', '7.2 Verifying Solutions for Differential Equations', false, 'both', 15, ''),
('7.3', 'Both_DiffEq', '7.3 Sketching Slope Fields', false, 'both', 20, ''),
('7.4', 'Both_DiffEq', '7.4 Reasoning Using Slope Fields', false, 'both', 15, ''),
('7.5', 'Both_DiffEq', '7.5 (BC ONLY) Approximating Solutions Using Euler’s Method', false, 'bc_only', 20, ''),
('7.6', 'Both_DiffEq', '7.6 Finding General Solutions Using Separation of Variables', false, 'both', 20, ''),
('7.7', 'Both_DiffEq', '7.7 Finding Particular Solutions Using Initial Conditions and Separation of Variables', false, 'both', 20, ''),
('7.8', 'Both_DiffEq', '7.8 Exponential Models with Differential Equations', false, 'both', 15, ''),
('7.9', 'Both_DiffEq', '7.9 (BC ONLY) Logistic Models with Differential Equations', false, 'bc_only', 20, ''),
('Both_DiffEq_unit_test', 'Both_DiffEq', 'Unit 7 Test', true, 'both', 45, ''),

-- Unit 8 (App of Int)
('8.1', 'Both_AppIntegration', '8.1 Finding the Average Value of a Function on an Interval', false, 'both', 15, ''),
('8.2', 'Both_AppIntegration', '8.2 Connecting Position, Velocity, and Acceleration Functions Using Integrals', false, 'both', 15, ''),
('8.3', 'Both_AppIntegration', '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts', false, 'both', 15, ''),
('8.4', 'Both_AppIntegration', '8.4 Finding the Area Between Curves Expressed as Functions of x', false, 'both', 20, ''),
('8.5', 'Both_AppIntegration', '8.5 Finding the Area Between Curves Expressed as Functions of y', false, 'both', 20, ''),
('8.6', 'Both_AppIntegration', '8.6 Finding the Area Between Curves That Intersect at More Than Two Points', false, 'both', 20, ''),
('8.7', 'Both_AppIntegration', '8.7 Volumes with Cross-Sections - Squares and Rectangles', false, 'both', 20, ''),
('8.8', 'Both_AppIntegration', '8.8 Volumes with Cross-Sections - Triangles and Semicircles', false, 'both', 20, ''),
('8.9', 'Both_AppIntegration', '8.9 Volume with Disc Method - Revolving Around x- or y-axis', false, 'both', 20, ''),
('8.10', 'Both_AppIntegration', '8.10 Volume with Disc Method - Revolving Around Other Axes', false, 'both', 20, ''),
('8.11', 'Both_AppIntegration', '8.11 Volume with Washer Method - Revolving Around x- or y-axis', false, 'both', 20, ''),
('8.12', 'Both_AppIntegration', '8.12 Volume with Washer Method - Revolving Around Other Axes', false, 'both', 20, ''),
('8.13', 'Both_AppIntegration', '8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled', false, 'bc_only', 20, ''),
('Both_AppIntegration_unit_test', 'Both_AppIntegration', 'Unit 8 Test', true, 'both', 45, ''),

-- Unit 9 (Parametric)
('9.1', 'BC_Unit9', '9.1 (BC ONLY) Defining and Differentiating Parametric Equations', false, 'bc_only', 20, ''),
('9.2', 'BC_Unit9', '9.2 (BC ONLY) Second Derivatives of Parametric Equations', false, 'bc_only', 20, ''),
('9.3', 'BC_Unit9', '9.3 (BC ONLY) Finding Arc Lengths of Curves Given by Parametric Equations', false, 'bc_only', 15, ''),
('9.4', 'BC_Unit9', '9.4 (BC ONLY) Defining and Differentiating Vector-Valued Functions', false, 'bc_only', 15, ''),
('9.5', 'BC_Unit9', '9.5 (BC ONLY) Integrating Vector-Valued Functions', false, 'bc_only', 15, ''),
('9.6', 'BC_Unit9', '9.6 (BC ONLY) Solving Motion Problems Using Parametric and Vector-Valued Functions', false, 'bc_only', 20, ''),
('9.7', 'BC_Unit9', '9.7 (BC ONLY) Defining Polar Coordinates and Differentiating in Polar Form', false, 'bc_only', 20, ''),
('9.8', 'BC_Unit9', '9.8 (BC ONLY) Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve', false, 'bc_only', 20, ''),
('9.9', 'BC_Unit9', '9.9 (BC ONLY) Finding the Area of the Region Bounded by Two Polar Curves', false, 'bc_only', 20, ''),
('BC_Unit9_unit_test', 'BC_Unit9', 'Unit 9 Test', true, 'bc_only', 45, ''),

-- Unit 10 (Series)
('10.1', 'BC_Series', '10.1 (BC ONLY) Defining Convergent and Divergent Infinite Series', false, 'bc_only', 15, ''),
('10.2', 'BC_Series', '10.2 (BC ONLY) Working with Geometric Series', false, 'bc_only', 20, ''),
('10.3', 'BC_Series', '10.3 (BC ONLY) The nth-Term Test for Divergence', false, 'bc_only', 15, ''),
('10.4', 'BC_Series', '10.4 (BC ONLY) Integral Test for Convergence', false, 'bc_only', 20, ''),
('10.5', 'BC_Series', '10.5 (BC ONLY) Harmonic Series and p-Series', false, 'bc_only', 15, ''),
('10.6', 'BC_Series', '10.6 (BC ONLY) Comparison Tests for Convergence', false, 'bc_only', 20, ''),
('10.7', 'BC_Series', '10.7 (BC ONLY) Alternating Series Test for Convergence', false, 'bc_only', 15, ''),
('10.8', 'BC_Series', '10.8 (BC ONLY) Ratio Test for Convergence', false, 'bc_only', 20, ''),
('10.9', 'BC_Series', '10.9 (BC ONLY) Determining Absolute or Conditional Convergence', false, 'bc_only', 15, ''),
('10.10', 'BC_Series', '10.10 (BC ONLY) Alternating Series Error Bound', false, 'bc_only', 15, ''),
('10.11', 'BC_Series', '10.11 (BC ONLY) Finding Taylor Polynomial Approximations of Functions', false, 'bc_only', 20, ''),
('10.12', 'BC_Series', '10.12 (BC ONLY) Lagrange Error Bound', false, 'bc_only', 20, ''),
('10.13', 'BC_Series', '10.13 (BC ONLY) Radius and Interval of Convergence of Power Series', false, 'bc_only', 20, ''),
('10.14', 'BC_Series', '10.14 (BC ONLY) Finding Taylor or Maclaurin Series for a Function', false, 'bc_only', 20, ''),
('10.15', 'BC_Series', '10.15 (BC ONLY) Representing Functions as Power Series', false, 'bc_only', 20, ''),
('BC_Series_unit_test', 'BC_Series', 'Unit 10 Test', true, 'bc_only', 45, '')

ON CONFLICT ON CONSTRAINT sections_pkey DO UPDATE SET 
    topic_id = EXCLUDED.topic_id,
    title = EXCLUDED.title,
    is_unit_test = EXCLUDED.is_unit_test,
    course_scope = EXCLUDED.course_scope;
