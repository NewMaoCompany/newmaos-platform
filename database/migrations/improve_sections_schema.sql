-- Improve Sections Schema & Data (Generated)

-- 1. Add new column
ALTER TABLE sections ADD COLUMN IF NOT EXISTS topic_introduction TEXT;

-- 2. Update Data
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 1 Test',
    updated_at = NOW()
WHERE id = 'Both_Limits_unit_test' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 13,
    description = 'Notation',
    title = '2.2 Defining the Derivative of a Function and Using Derivative Notation',
    updated_at = NOW()
WHERE id = '2.2' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 3 Test',
    updated_at = NOW()
WHERE id = 'Both_Composite_unit_test' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = 'Continuing the theme of linearization, this chapter delves deeper into using local linearity to approximate solutions for non-linear equations. You will practice building linear models in various contexts and understanding that "local linearity" is a central idea of differential calculus. Problems may involve graphs, asking you to visually judge the relationship between a tangent line and a curve to infer the accuracy of an approximation.',
    estimated_minutes = 19,
    description = 'Linearization',
    title = '4.6 Approximating Values of a Function Using Local Linearity and Linearization',
    updated_at = NOW()
WHERE id = '4.6' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 4 Test',
    updated_at = NOW()
WHERE id = 'Both_Applications_unit_test' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 15,
    description = 'Integration by Parts',
    title = '6.11 (BC ONLY) Using Integration by Parts',
    updated_at = NOW()
WHERE id = '6.11' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'The Mean Value Theorem (MVT) is a fundamental existence theorem. It guarantees that for a function continuous on a closed interval and differentiable on the open interval, there is a point where the instantaneous rate of change equals the average rate of change. You must not only solve for c algebraically but also understand the geometric meaning (parallel tangent and secant lines). Rigorously checking the conditions is the first step in any MVT problem.',
    estimated_minutes = 10,
    description = 'MVT',
    title = '5.1 Using the Mean Value Theorem',
    updated_at = NOW()
WHERE id = '5.1' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'Differential equations model the world by describing rates of change. This chapter starts with translating text like "growth rate is proportional to population" into equations. It''s the first step in modeling, emphasizing understanding the physical meaning of every symbol.',
    estimated_minutes = 8,
    description = 'Modeling',
    title = '7.1 Modeling Situations with Differential Equations',
    updated_at = NOW()
WHERE id = '7.1' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = 'You will learn to verify if a function is a solution to a differential equation. Verification involves differentiating and substituting to check if "LHS equals RHS." This reinforces that a solution is a function, not a number, and sharpens differentiation skills.',
    estimated_minutes = 8,
    description = 'Verifying',
    title = '7.2 Verifying Solutions for Differential Equations',
    updated_at = NOW()
WHERE id = '7.2' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = 'Slope Fields visualize differential equations. You will draw small slope segments on a grid to see the flow of solution curves. AP exams require both drawing them and matching them to equations.',
    estimated_minutes = 8,
    description = 'Slope Fields',
    title = '7.3 Sketching Slope Fields',
    updated_at = NOW()
WHERE id = '7.3' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = 'Reasoning with Slope Fields extends the previous chapter. By observing slope patterns (dependence on x vs y), you can infer the equation''s structure and predict long-term behavior (asymptotes).',
    estimated_minutes = 8,
    description = 'Reasoning',
    title = '7.4 Reasoning Using Slope Fields',
    updated_at = NOW()
WHERE id = '7.4' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = '(BC Only) Euler''s Method is a numerical approach to solving differential equations using "tangent line stepping." You calculate points iteratively. Organization in your calculation table is key to accuracy.',
    estimated_minutes = 8,
    description = 'Euler Method',
    title = '7.5 (BC ONLY) Approximating Solutions Using Euler’s Method',
    updated_at = NOW()
WHERE id = '7.5' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = 'Separation of Variables is the primary analytic method for first-order ODEs. You master the flow: "Separate, Integrate, Solve." Attention to algebra, especially with logs/exponents, is crucial.',
    estimated_minutes = 8,
    description = 'Separation',
    title = '7.6 Finding General Solutions Using Separation of Variables',
    updated_at = NOW()
WHERE id = '7.6' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = 'Finding Particular Solutions adds initial conditions to separation of variables. You solve for the constant C to find the specific function. This is often a high-value FRQ part.',
    estimated_minutes = 8,
    description = 'Particular Sol',
    title = '7.7 Finding Particular Solutions Using Initial Conditions and Separation of Variables',
    updated_at = NOW()
WHERE id = '7.7' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 13,
    description = 'Estimation',
    title = '2.3 Estimating Derivatives of a Function at a Point',
    updated_at = NOW()
WHERE id = '2.3' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 12,
    description = 'Differentiability',
    title = '2.4 Connecting Differentiability and Continuity',
    updated_at = NOW()
WHERE id = '2.4' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 12,
    description = 'Power Rule',
    title = '2.5 Applying the Power Rule',
    updated_at = NOW()
WHERE id = '2.5' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 12,
    description = 'Linearity',
    title = '2.6 Derivative Rules: Constant, Sum, Difference',
    updated_at = NOW()
WHERE id = '2.6' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = 'Basic Transcendentals',
    title = '2.7 Derivatives of cos x, sin x, e^x, and ln x',
    updated_at = NOW()
WHERE id = '2.7' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 14,
    description = 'Product Rule',
    title = '2.8 The Product Rule',
    updated_at = NOW()
WHERE id = '2.8' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 15,
    description = 'Quotient Rule',
    title = '2.9 The Quotient Rule',
    updated_at = NOW()
WHERE id = '2.9' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 17,
    description = 'Numerical Limits',
    title = '1.4 Estimating Limit Values from Tables',
    updated_at = NOW()
WHERE id = '1.4' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 18,
    description = 'Limit Laws',
    title = '1.5 Determining Limits Using Algebraic Properties of Limits',
    updated_at = NOW()
WHERE id = '1.5' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 21,
    description = 'Factoring/Conjugates',
    title = '1.6 Determining Limits Using Algebraic Manipulation',
    updated_at = NOW()
WHERE id = '1.6' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 18,
    description = 'Strategy',
    title = '1.7 Selecting Procedures for Determining Limits',
    updated_at = NOW()
WHERE id = '1.7' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 19,
    description = 'Squeeze Theorem',
    title = '1.8 Determining Limits Using the Squeeze Theorem',
    updated_at = NOW()
WHERE id = '1.8' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = 'Chain Rule',
    title = '3.1 The Chain Rule',
    updated_at = NOW()
WHERE id = '3.1' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 5 Test',
    updated_at = NOW()
WHERE id = 'Both_Analytical_unit_test' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 21,
    description = 'Intervals',
    title = '1.12 Confirming Continuity over an Interval',
    updated_at = NOW()
WHERE id = '1.12' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 24,
    description = 'Extensions',
    title = '1.13 Removing Discontinuities',
    updated_at = NOW()
WHERE id = '1.13' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 24,
    description = 'Asymptotes',
    title = '1.14 Connecting Infinite Limits and Vertical Asymptotes',
    updated_at = NOW()
WHERE id = '1.14' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 23,
    description = 'End Behavior',
    title = '1.15 Connecting Limits at Infinity and Horizontal Asymptotes',
    updated_at = NOW()
WHERE id = '1.15' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 24,
    description = 'IVT',
    title = '1.16 Working with the Intermediate Value Theorem',
    updated_at = NOW()
WHERE id = '1.16' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 12,
    description = 'Other Trig',
    title = '2.10 Finding the Derivatives of Tangent, Cotangent, Secant, and/or Cosecant Functions',
    updated_at = NOW()
WHERE id = '2.10' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 2 Test',
    updated_at = NOW()
WHERE id = 'Both_Derivatives_unit_test' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = 'This chapter focuses on interpreting the derivative in real-world contexts. You will learn to translate the abstract concept of "rate of change" into specific language, such as population growth, cooling rates, or vehicle acceleration. Problems typically require you to interpret the meaning of a derivative value (increasing or decreasing) based on a given function or data table, paying attention to units (e.g., "gallons per minute"). The key is to accurately use the phrase "at a specific time t" and avoid confusing average rates with instantaneous rates.',
    estimated_minutes = 12,
    description = 'Context',
    title = '4.1 Interpreting the Meaning of the Derivative in Context',
    updated_at = NOW()
WHERE id = '4.1' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 16,
    description = 'Avg vs Instant Rate',
    title = '1.1 Introducing Calculus: Can Change Occur at an Instant?',
    updated_at = NOW()
WHERE id = '1.1' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 15,
    description = 'Limit Notation',
    title = '1.2 Defining Limits and Using Limit Notation',
    updated_at = NOW()
WHERE id = '1.2' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 16,
    description = 'Graphical Limits',
    title = '1.3 Estimating Limit Values from Graphs',
    updated_at = NOW()
WHERE id = '1.3' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 13,
    description = 'Implicit',
    title = '3.2 Implicit Differentiation',
    updated_at = NOW()
WHERE id = '3.2' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 14,
    description = 'Inverse Derivs',
    title = '3.3 Differentiating Inverse Functions',
    updated_at = NOW()
WHERE id = '3.3' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 15,
    description = 'Inverse Trig',
    title = '3.4 Differentiating Inverse Trigonometric Functions',
    updated_at = NOW()
WHERE id = '3.4' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = 'Area Between Curves (dx). You calculate area as Integral of (Top - Bottom). Key steps: finding intersection points and handling curve crossovers.',
    estimated_minutes = 8,
    description = 'Area dx',
    title = '8.4 Finding the Area Between Curves Expressed as Functions of x',
    updated_at = NOW()
WHERE id = '8.4' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 12,
    description = 'Strategy',
    title = '3.5 Selecting Procedures for Calculating Derivatives',
    updated_at = NOW()
WHERE id = '3.5' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 11,
    description = 'Higher Order',
    title = '3.6 Calculating Higher-Order Derivatives',
    updated_at = NOW()
WHERE id = '3.6' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    topic_introduction = 'This chapter applies derivatives to object motion along a straight line, a classic physical application of calculus. You will explore the relationship between position, velocity, and acceleration: velocity is the derivative of position, and acceleration is the derivative of velocity. Key practice includes determining when an object is at rest (velocity is zero), when it changes direction, and analyzing whether it is speeding up or slowing down (depending on the signs of velocity and acceleration). Graphical analysis is also central, requiring you to read displacement and acceleration from velocity-time graphs.',
    estimated_minutes = 19,
    description = 'Motion',
    title = '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration',
    updated_at = NOW()
WHERE id = '4.2' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = 'Beyond straight-line motion, derivatives describe various other rates of change. This chapter covers topics like changing areas/volumes of geometric shapes, rates of fluid flow, and marginal cost in economics. The key to solving these problems is identifying knowns and unknowns from the text and establishing the correct function relationship. You will practice extracting mathematical models from word problems and interpreting the sign of the derivative in context (e.g., "water level looks like it is dropping at 2 cm/min").',
    estimated_minutes = 18,
    description = 'Other Rates',
    title = '4.3 Rates of Change in Applied Contexts other than Motion',
    updated_at = NOW()
WHERE id = '4.3' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = 'This chapter introduces Related Rates, a technique for differentiating in dynamic situations. When two or more variables change with time and are linked by a equation (like Pythagorean theorem or volume formulas), we differentiate with respect to time t to find how their rates are related. The process is highly structured: set up the equation, differentiate implicitly, and substitute known values. Pay attention to signs (is a quantity increasing or decreasing?) and distinguish between constants and variables.',
    estimated_minutes = 18,
    description = 'Intro RR',
    title = '4.4 Introduction to Related Rates',
    updated_at = NOW()
WHERE id = '4.4' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = 'This chapter explains how to use Linear Approximation (Tangent Line Approximation) to estimate function values near a specific point. The core idea is that "locally, curves look like lines." You will learn to build tangent line equations and use them to approximate complex function values. A key concept is error analysis: using concavity (sign of the second derivative) to determine if the approximation is an overestimate or underestimate.',
    estimated_minutes = 22,
    description = 'Solving RR',
    title = '4.5 Solving Related Rates Problems',
    updated_at = NOW()
WHERE id = '4.5' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = 'L''Hôpital''s Rule is a powerful tool for evaluating indeterminate limits (like 0/0 or ∞/∞). You will learn to use derivatives to compute these otherwise "unsolvable" limits. The crucial step is verifying conditions: you can only apply the rule if the limit is truly indeterminate. Practice covers combinations of algebraic, trigonometric, and exponential functions, noting that sometimes the rule must be applied multiple times.',
    estimated_minutes = 20,
    description = 'L’Hospital',
    title = '4.7 Using L’Hospital’s Rule for Finding Limits of Indeterminate Forms',
    updated_at = NOW()
WHERE id = '4.7' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    topic_introduction = 'This chapter explores the relationship between the first derivative and function behavior (increasing/decreasing). Using the "First Derivative Test," you will identify intervals of monotonicity and relative extrema. Emphasis is placed on constructing "Sign Charts" to aid reasoning and writing formal justifications (e.g., "Since f''(x) changes from positive to negative, f has a relative maximum at x=c").',
    estimated_minutes = 11,
    description = 'Inc/Dec',
    title = '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing',
    updated_at = NOW()
WHERE id = '5.3' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'The second derivative reveals the curvature of a graph—concavity. You will learn to use the sign of f''''(x) to determine if a function is concave up or down and to find inflection points. The "Second Derivative Test" is introduced as an alternative for finding extrema. Mastering the relationships between f, f'', and f'''' graphs is a challenging but high-yield topic.',
    estimated_minutes = 11,
    description = '1st Deriv Test',
    title = '5.4 Using the First Derivative Test to Find Relative (Local) Extrema',
    updated_at = NOW()
WHERE id = '5.4' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'Integrating previous concepts, this chapter focuses on Curve Sketching. Given information about f'' and f'''' (not the function itself), you must reconstruct the shape of f. This tests logical synthesis over calculation. Problems often provide derivative sign charts or graphs, asking you to deduce increase/decrease, extrema, concavity, and inflection points—a mathematical detective game.',
    estimated_minutes = 12,
    description = 'Candidates Test',
    title = '5.5 Using the Candidates Test to Find Absolute (Global) Extrema',
    updated_at = NOW()
WHERE id = '5.5' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'This chapter uses the Extreme Value Theorem (EVT) to find global maximums and minimums on a closed interval. This is the foundation of optimization. You will master the "Candidate Test": comparing function values at critical points and endpoints. Understanding why endpoints must be checked and the theoretical guarantee of EVT for continuous functions is essential. These problems are frequent in AP exams, often within applied contexts.',
    estimated_minutes = 18,
    description = 'EVT',
    title = '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points',
    updated_at = NOW()
WHERE id = '5.2' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'Optimization problems seek the "best" solution (e.g., minimum cost, maximum area). You will translate real-world problems into mathematical models, identifying the objective function and constraints, then use derivatives to find extrema. Beyond calculation, correctly setting up the geometry/physics model, defining the domain, and verifying the result is indeed the desired extremum are critical steps.',
    estimated_minutes = 13,
    description = 'Concavity',
    title = '5.6 Determining Concavity of Functions over Their Domains',
    updated_at = NOW()
WHERE id = '5.6' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'This chapter deepens optimization applications, potentially involving complex geometric or economic models. The focus is on parsing lengthy text for key information and handling optimization with parameters. Maintaining clear logic steps (Model -> Differentiate -> Critical Points -> Verify) is the key to success.',
    estimated_minutes = 12,
    description = '2nd Deriv Test',
    title = '5.7 Using the Second Derivative Test to Find Extrema',
    updated_at = NOW()
WHERE id = '5.7' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'This chapter serves as a comprehensive review or advanced application of derivative analysis. You should essentially be fluent in translating between analytical, tabular, graphical, and verbal representations. Deriving properties of f from the graph of f'' (or vice versa) is a challenging task that tests your deep understanding of calculus concepts.',
    estimated_minutes = 17,
    description = 'Sketching',
    title = '5.8 Sketching Graphs of Functions and Their Derivatives',
    updated_at = NOW()
WHERE id = '5.8' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'This chapter explores the meaning of the definite integral as "Total Change." By FTC, the integral of a rate of change equals the net change in the quantity (e.g., integral of velocity is displacement). You will practice interpreting ∫ f''(x) dx in various contexts, a key skill for justifying answers in FRQs.',
    estimated_minutes = 14,
    description = 'Accumulation Funcs',
    title = '6.5 Interpreting the Behavior of Accumulation Functions Involving Area',
    updated_at = NOW()
WHERE id = '6.5' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'Integration by Substitution (u-sub) is the reverse chain rule. It is the go-to tool for complex integrals. You will learn to spot the "function-derivative pair" structure and simplify the integral by changing variables. A critical detail is correctly transforming the limits of integration for definite integrals.',
    estimated_minutes = 12,
    description = 'FTC 2',
    title = '6.7 The Fundamental Theorem of Calculus and Definite Integrals',
    updated_at = NOW()
WHERE id = '6.7' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '(BC Only) Partial Fraction Decomposition handles rational function integrals. Key idea: break a complex fraction into simpler terms that integrate into logs. Algebraic precision in solving for constants is key.',
    estimated_minutes = 17,
    description = 'Substitution',
    title = '6.9 Integrating Using Substitution',
    updated_at = NOW()
WHERE id = '6.9' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 18,
    description = 'Synthesis',
    title = '1.9 Connecting Multiple Representations of Limits',
    updated_at = NOW()
WHERE id = '1.9' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 20,
    description = 'Removable/Jump/Infinite',
    title = '1.10 Exploring Types of Discontinuities',
    updated_at = NOW()
WHERE id = '1.10' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 22,
    description = '3-Part Definition',
    title = '1.11 Defining Continuity at a Point',
    updated_at = NOW()
WHERE id = '1.11' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 11,
    description = 'Slopes',
    title = '2.1 Defining Average and Instantaneous Rates of Change at a Point',
    updated_at = NOW()
WHERE id = '2.1' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 18,
    description = 'Connecting Graphs',
    title = '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative',
    updated_at = NOW()
WHERE id = '5.9' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = '(BC Only) Integration by Parts is the reverse product rule. Essential for integrals like x·e^x or ln(x). You will learn to choose u and dv using the LIDET guideline to simplify the integral. Organized work is vital to avoid sign errors.',
    estimated_minutes = 12,
    description = 'Indefinite',
    title = '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules and Notation',
    updated_at = NOW()
WHERE id = '6.8' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '(BC Only) Improper Integrals deal with infinite intervals or unbounded functions. You will learn to use limits to define these integrals and determine convergence or divergence. This concept is vital for the later Integral Test for series.',
    estimated_minutes = 18,
    description = 'Alg Manipulation',
    title = '6.10 Integrating Functions Using Long Division and Completing the Square',
    updated_at = NOW()
WHERE id = '6.10' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'Exponential Growth/Decay (dy/dt = ky) models population and radioactivity. You analyze the solution y = Ce^(kt) and solve for parameters like half-life. It connects calculus to natural sciences.',
    estimated_minutes = 8,
    description = 'Exponential',
    title = '7.8 Exponential Models with Differential Equations',
    updated_at = NOW()
WHERE id = '7.8' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = '(BC Only) Logistic Growth models population with limits (carrying capacity). You analyze the S-curve: fastest growth at half cap, asymptotic behavior. Understanding the qualitative behavior is more important than solving the equation.',
    estimated_minutes = 8,
    description = 'Logistic Models',
    title = '7.9 (BC ONLY) Logistic Models with Differential Equations',
    updated_at = NOW()
WHERE id = '7.9' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = 'Using integration to find the Average Value of a function. Based on "Average Height * Width = Area," you learn the formula and interpret its meaning (e.g., average velocity).',
    estimated_minutes = 8,
    description = 'Avg Value',
    title = '8.1 Finding the Average Value of a Function on an Interval',
    updated_at = NOW()
WHERE id = '8.1' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Kinematics revisited with integration. You connect velocity to displacement versus total distance traveled. Distinguishing between the two (net change vs absolute sum) is the main challenge.',
    estimated_minutes = 8,
    description = 'Motion',
    title = '8.2 Connecting Position, Velocity, and Acceleration Functions Using Integrals',
    updated_at = NOW()
WHERE id = '8.2' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Accumulation applies to non-motion contexts: amount of water, energy, or people. determining Net Change = Start + Integral of Rate. Critical for interpreting word problems.',
    estimated_minutes = 8,
    description = 'Accumulation',
    title = '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts',
    updated_at = NOW()
WHERE id = '8.3' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Area Between Curves (dy). Sometimes integrating with respect to y (Right - Left) is easier. Requires spatial flexibility in visualizing functions as x = g(y).',
    estimated_minutes = 8,
    description = 'Area dy',
    title = '8.5 Finding the Area Between Curves Expressed as Functions of y',
    updated_at = NOW()
WHERE id = '8.5' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Volume with Known Cross Sections. You calculate volume by integrating area slices A(x). The difficulty lies in deriving the correct A(x) formula from the base geometry.',
    estimated_minutes = 8,
    description = 'Intersections',
    title = '8.6 Finding the Area Between Curves That Intersect at More Than Two Points',
    updated_at = NOW()
WHERE id = '8.6' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Disk Method for rotation volume. V = π ∫ R(x)² dx. Used for solid rotations. Identifying the radius R relative to the axis of rotation is key.',
    estimated_minutes = 8,
    description = 'Cross Sec 1',
    title = '8.7 Volumes with Cross-Sections - Squares and Rectangles',
    updated_at = NOW()
WHERE id = '8.7' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Washer Method for hollow rotations. V = π ∫ (R² - r²) dx. Requires seeing both outer and inner radii clearly. Drawing precise diagrams is essential.',
    estimated_minutes = 8,
    description = 'Cross Sec 2',
    title = '8.8 Volumes with Cross-Sections - Triangles and Semicircles',
    updated_at = NOW()
WHERE id = '8.8' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = '(BC Only) Arc Length. Using integral of √(1 + f''(x)²) to find curve length. Derivation from Pythagorean theorem helps understanding.',
    estimated_minutes = 8,
    description = 'Disc',
    title = '8.9 Volume with Disc Method - Revolving Around x- or y-axis',
    updated_at = NOW()
WHERE id = '8.9' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = '(BC Only) Surface Area of Revolution. 2π ∫ r ds. Combines arc length with rotation circumference. A complex topic testing spatial intuition.',
    estimated_minutes = 8,
    description = 'Disc Shift',
    title = '8.10 Volume with Disc Method - Revolving Around Other Axes',
    updated_at = NOW()
WHERE id = '8.10' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Washer',
    title = '8.11 Volume with Washer Method - Revolving Around x- or y-axis',
    updated_at = NOW()
WHERE id = '8.11' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Vector-Valued Functions describe motion with vectors r(t). Connects math to physics. Component-wise operations make complex paths manageable.',
    estimated_minutes = 8,
    description = 'Vector Derivs',
    title = '9.4 (BC ONLY) Defining and Differentiating Vector-Valued Functions',
    updated_at = NOW()
WHERE id = '9.4' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Abs/Cond',
    title = '10.9 (BC ONLY) Determining Absolute or Conditional Convergence',
    updated_at = NOW()
WHERE id = '10.9' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'AST Error',
    title = '10.10 (BC ONLY) Alternating Series Error Bound',
    updated_at = NOW()
WHERE id = '10.10' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 18,
    description = 'Opt Intro',
    title = '5.10 Introduction to Optimization Problems',
    updated_at = NOW()
WHERE id = '5.10' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = 'This chapter introduces the other half of calculus—Integration—as "accumulated change." You will learn to approximate the area under a curve using Riemann Sums (Left, Right, Midpoint). The focus is not just arithmetic but understanding how this "slice and sum" approach approximates the true area and whether specific methods underestimate or overestimate based on function behavior.',
    estimated_minutes = 11,
    description = 'Accumulation',
    title = '6.1 Exploring Accumulations of Change',
    updated_at = NOW()
WHERE id = '6.1' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'This chapter links "infinite accumulation" to "area under the curve" via the definite integral definition. You will learn definite integral notation and use geometric area formulas (rectangle, triangle, semicircle) to compute integrals for simple functions. Understanding that definite integrals represent "signed area" (area below x-axis is negative) is a core concept.',
    estimated_minutes = 15,
    description = 'Riemann Sums',
    title = '6.2 Approximating Areas with Riemann Sums',
    updated_at = NOW()
WHERE id = '6.2' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'The Fundamental Theorem of Calculus (FTC) Part 1 relates integration to accumulation functions. You will study functions defined by integrals (e.g., A(x) = ∫ from 0 to x of f(t) dt) and learn to differentiate them, revealing the inverse nature of differentiation and integration. This is crucial for analyzing functions defined by graphs.',
    estimated_minutes = 13,
    description = 'Def Integral',
    title = '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation',
    updated_at = NOW()
WHERE id = '6.3' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'The Fundamental Theorem of Calculus (FTC) Part 2 revolutionizes integral calculation. Instead of approximation or geometry, you find the exact value by using antiderivatives. This is the core computational training, requiring mastery of basic integration rules for polynomials, trig, and exponentials. It is the bridge between differential and integral calculus.',
    estimated_minutes = 16,
    description = 'FTC 1',
    title = '6.4 The Fundamental Theorem of Calculus and Accumulation Functions',
    updated_at = NOW()
WHERE id = '6.4' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = 'This chapter introduces basic integration techniques, reinforcing properties of antiderivatives (linearity, reverse power rule). You will build intuition for finding antiderivatives of common functions. Proficiency here is the prerequisite for advanced techniques like u-substitution.',
    estimated_minutes = 11,
    description = 'Properties',
    title = '6.6 Applying Properties of Definite Integrals',
    updated_at = NOW()
WHERE id = '6.6' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 16,
    description = 'Partial Fractions',
    title = '6.12 (BC ONLY) Integrating Using Linear Partial Fractions',
    updated_at = NOW()
WHERE id = '6.12' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 16,
    description = 'Improper Integrals',
    title = '6.13 (BC ONLY) Evaluating Improper Integrals',
    updated_at = NOW()
WHERE id = '6.13' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 15,
    description = 'Selecting Techniques',
    title = '6.14 Selecting Techniques for Antidifferentiation',
    updated_at = NOW()
WHERE id = '6.14' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 6 Test',
    updated_at = NOW()
WHERE id = 'Both_Integration_unit_test' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 7 Test',
    updated_at = NOW()
WHERE id = 'Both_DiffEq_unit_test' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Taylor Poly',
    title = '10.11 (BC ONLY) Finding Taylor Polynomial Approximations of Functions',
    updated_at = NOW()
WHERE id = '10.11' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Lagrange',
    title = '10.12 (BC ONLY) Lagrange Error Bound',
    updated_at = NOW()
WHERE id = '10.12' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Radius/Interval',
    title = '10.13 (BC ONLY) Radius and Interval of Convergence of Power Series',
    updated_at = NOW()
WHERE id = '10.13' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Finding Series',
    title = '10.14 (BC ONLY) Finding Taylor or Maclaurin Series for a Function',
    updated_at = NOW()
WHERE id = '10.14' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Ops on Series',
    title = '10.15 (BC ONLY) Representing Functions as Power Series',
    updated_at = NOW()
WHERE id = '10.15' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 10 Test',
    updated_at = NOW()
WHERE id = 'BC_Series_unit_test' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Washer Shift',
    title = '8.12 Volume with Washer Method - Revolving Around Other Axes',
    updated_at = NOW()
WHERE id = '8.12' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Arc Length',
    title = '8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled',
    updated_at = NOW()
WHERE id = '8.13' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 8 Test',
    updated_at = NOW()
WHERE id = 'Both_AppIntegration_unit_test' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    topic_introduction = 'Parametric Equations define x and y via parameter t. Great for motion. You learn dy/dx slopes and how velocity components relate to the path.',
    estimated_minutes = 8,
    description = 'Parametric Derivs',
    title = '9.1 (BC ONLY) Defining and Differentiating Parametric Equations',
    updated_at = NOW()
WHERE id = '9.1' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Second derivatives in parametric are tricky. d²y/dx² requires chain rule care: d(y'')/dt / (dx/dt). Crucial for concavity analysis.',
    estimated_minutes = 8,
    description = 'Parametric 2nd Deriv',
    title = '9.2 (BC ONLY) Second Derivatives of Parametric Equations',
    updated_at = NOW()
WHERE id = '9.2' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Integrals in parametric for area and arc length. Requires transforming integrals to dt and adjusting limits. Direction of motion matters.',
    estimated_minutes = 8,
    description = 'Parametric Arc Length',
    title = '9.3 (BC ONLY) Finding Arc Lengths of Curves Given by Parametric Equations',
    updated_at = NOW()
WHERE id = '9.3' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Motion analysis with vectors: speed (magnitude of velocity) and distance traveled (integral of speed). Unifies math and physics concepts.',
    estimated_minutes = 8,
    description = 'Vector Int',
    title = '9.5 (BC ONLY) Integrating Vector-Valued Functions',
    updated_at = NOW()
WHERE id = '9.5' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Polar coordinates (r, θ). You learn coordinate conversion and finding slopes dy/dx. Product rule is heavy here. Visualization is key.',
    estimated_minutes = 8,
    description = 'Vector Motion',
    title = '9.6 (BC ONLY) Solving Motion Problems Using Parametric and Vector-Valued Functions',
    updated_at = NOW()
WHERE id = '9.6' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Area in Polar regions using ½ ∫ r² dθ. Distinct from rectangular area. Finding correct angular limits by sketching is the main hurdle.',
    estimated_minutes = 8,
    description = 'Polar Derivs',
    title = '9.7 (BC ONLY) Defining Polar Coordinates and Differentiating in Polar Form',
    updated_at = NOW()
WHERE id = '9.7' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Arc Length in Polar. ∫ √(r² + (dr/dθ)²) dθ. Complex integrals often requiring setup over evaluation. Tests comprehensive integration geometry.',
    estimated_minutes = 8,
    description = 'Polar Area',
    title = '9.8 (BC ONLY) Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve',
    updated_at = NOW()
WHERE id = '9.8' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 8,
    description = 'Area Between Polar',
    title = '9.9 (BC ONLY) Finding the Area of the Region Bounded by Two Polar Curves',
    updated_at = NOW()
WHERE id = '9.9' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 10,
    description = '',
    title = 'Unit 9 Test',
    updated_at = NOW()
WHERE id = 'BC_Unit9_unit_test' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    topic_introduction = 'Taylor Polynomials approximate functions like polynomials. You match derivatives at a center. The more terms, the better the fit.',
    estimated_minutes = 8,
    description = 'Convergence',
    title = '10.1 (BC ONLY) Defining Convergent and Divergent Infinite Series',
    updated_at = NOW()
WHERE id = '10.1' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Lagrange Error Bound quantifies approximation error. It bounds the "next derivative." A theoretical but powerful tool for accuracy confidence.',
    estimated_minutes = 8,
    description = 'Geometric',
    title = '10.2 (BC ONLY) Working with Geometric Series',
    updated_at = NOW()
WHERE id = '10.2' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Taylor Series extend polynomials to infinity. You memorize core series (e^x, sin x) to build others quickly. New series from old is the efficiency hack.',
    estimated_minutes = 8,
    description = 'nth Term',
    title = '10.3 (BC ONLY) The nth-Term Test for Divergence',
    updated_at = NOW()
WHERE id = '10.3' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Convergence Tests overview. You need to choose the right test (Nth term, Integral). Intuition for spotting the test type is critical.',
    estimated_minutes = 8,
    description = 'Integral Test',
    title = '10.4 (BC ONLY) Integral Test for Convergence',
    updated_at = NOW()
WHERE id = '10.4' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Comparison Tests (Direct/Limit). Compare an unknown series to a known one (like p-series) to determine fate. Requires identifying dominant terms.',
    estimated_minutes = 8,
    description = 'p-Series',
    title = '10.5 (BC ONLY) Harmonic Series and p-Series',
    updated_at = NOW()
WHERE id = '10.5' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Alternating Series allow convergence even if terms don''t shrink fast enough absolutely. The error bound (next term) is simple and useful.',
    estimated_minutes = 8,
    description = 'Comparison',
    title = '10.6 (BC ONLY) Comparison Tests for Convergence',
    updated_at = NOW()
WHERE id = '10.6' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Ratio Test is the heavyweight champion for finding convergence radius. Essential for power series. Algebra with factorials/exponents is the workout.',
    estimated_minutes = 8,
    description = 'AST',
    title = '10.7 (BC ONLY) Alternating Series Test for Convergence',
    updated_at = NOW()
WHERE id = '10.7' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = 'Power Series are functions defined by series. You find the Interval of Convergence (domain). Testing endpoints separately is the final, crucial step.',
    estimated_minutes = 8,
    description = 'Ratio Test',
    title = '10.8 (BC ONLY) Ratio Test for Convergence',
    updated_at = NOW()
WHERE id = '10.8' AND topic_id = 'BC_Series';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 13,
    description = 'Solving Opt',
    title = '5.11 Solving Optimization Problems',
    updated_at = NOW()
WHERE id = '5.11' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 462,
    description = 'Comprehensive assessment covering all topics in Unit 5.',
    title = 'Unit Test',
    updated_at = NOW()
WHERE id = 'unit_test' AND topic_id = 'ABBC_Analytical';
UPDATE sections SET 
    topic_introduction = '',
    estimated_minutes = 12,
    description = 'Implicit Behaviors',
    title = '5.12 Exploring Behaviors of Implicit Relations',
    updated_at = NOW()
WHERE id = '5.12' AND topic_id = 'Both_Analytical';

-- 3. Cleanup Legacy Columns (Uncomment to execute)
-- ALTER TABLE sections DROP COLUMN IF EXISTS description2;
-- ALTER TABLE sections DROP COLUMN IF EXISTS description_2;
-- ALTER TABLE sections DROP COLUMN IF EXISTS detailed_description;
