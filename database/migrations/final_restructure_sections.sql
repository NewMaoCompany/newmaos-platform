-- Final Section Restructuring (Complete English + description_2)

-- 1. Update Data (Sync from JSON)
UPDATE sections SET 
    description_2 = 'This is the comprehensive Unit 1 Test. It covers limits, continuity, and the definition of the derivative. Expect problems requiring algebraic manipulation of limits, Squeeze Theorem application, and Intermediate Value Theorem justification.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Limits_unit_test' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Estimating derivatives at a point. If we don''t have a formula, we can estimate f''(c) using the slope of a secant line between points very close to c. We also learn to estimate slopes from tables of data, a common AP exam task.',
    description = 'Notation',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '2.2' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'Unit 3 Test focusing on Implicit Differentiation and Inverse Functions. High precision with Chain Rule layers is required. You will also calculate higher-order derivatives.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Composite_unit_test' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Building directly on local linearity, this chapter explores the numerical and graphical implications of approximating functions. We delve deeper into the structure of linear approximations, often using them to solve differential equations numerically in later chapters (like Euler''s Method). The focus here is often on interpreting the tangent line equation. You will see problems that ask you to not only estimate a value but to discuss the validity of that estimation as you move further away from the point of tangency. We reinforce the idea that differentiability implies local linearity—a smooth curve has no sharp corners, so a linear approximation is always valid ''locally''. You will practice visualizing these tangents on graphs of concave up and concave down functions, solidifying the link between algebraic linearization and geometric curvature.',
    description = 'Linearization',
    estimated_minutes = 19,
    updated_at = NOW()
WHERE id = '4.6' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'Unit 4 Test on Contextual Applications. Key topics: Related Rates, Linearization, and Motion analysis. Interpreting the meaning of the derivative in word problems is the primary skill.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Applications_unit_test' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = '(BC Only) Integration by Parts practice. We continue refining this technique, looking at cyclical cases (like e^x * sin x) where applying the method twice brings you back to the original integral, allowing you to solve for it algebraically. We also look at ''tabular integration'', a shorthand method for repeated integration by parts that saves time and reduces arithmetic errors.',
    description = 'Integration by Parts',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '6.11' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'The Mean Value Theorem (MVT) is one of the most significant theoretical pillars of calculus. In simple terms, it guarantees that for any smooth journey, there must be at least one moment where your instantaneous speed exactly matches your average speed for the whole trip. Geometrically, this means there is always a tangent line parallel to the secant line connecting the endpoints. While the theorem itself is an existence theorem—it tells us ''that'' a point exists, not necessarily ''where'' it is—we will practice finding these specific points algebraically. Crucially, we will emphasize the preconditions: the function must be continuous on the closed interval and differentiable on the open interval. If a graph has a sharp corner or a hole, the guarantee vanishes. Understanding why these conditions matter is just as important as the calculation itself.',
    description = 'MVT',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = '5.1' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'A differential equation is simply an equation that involves a derivative—it describes a rule for how a system changes. Instead of solving for a number `x`, we solve for a function `y` whose rate of change follows the rule. We start by modeling verbal descriptions: ''The population grows at a rate proportional to its size'' becomes dy/dt = ky. This chapter focuses on understanding the language of change and verifying solutions. Checking a solution is straightforward: verify if the function and its derivative make the equation true.',
    description = 'Modeling',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.1' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'Verifying solutions serves as a bridge to solving them. We reinforce that a solution is a whole family of functions (general solution) unless an initial condition pinpoints a specific curve (particular solution). We explore the geometry of these families. For instance, dy/dx = 2x has a solution family of parabolas y = x^2 + C, which are just vertical shifts of each other. This conceptual understanding helps demystify the abstract nature of differential equations.',
    description = 'Verifying',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.2' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'Slope Fields provide a powerful visualization of differential equations without solving them. By calculating the slope at various grid points satisfy the differential equation, we draw a field of small tangent segments. These segments act like flow markers in a fluid, showing the path that any solution curve must follow. You will learn to sketch solution curves by tracing through the field, following the direction of the slopes. This qualitative tool allows us to see the shape of solutions even when finding an formula is difficult.',
    description = 'Slope Fields',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.3' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'We delve deeper into reading Slope Fields. You will learn to identify the differential equation from its visual fingerprint. For example, if the slopes are constant in horizontal rows, the rate depends only on y. If they are constant in vertical columns, it depends only on x. We also analyze the long-term behavior of solutions—do they flatten out? Do they approach an asymptote? This connects the algebraic structure of the derivative to the geometric behavior of the solution family.',
    description = 'Reasoning',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.4' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = '(BC Only) Euler''s Method is a numerical algorithm used to approximate solutions when an algebraic answer is impossible. The idea is simple: start at a known point, calculate the slope, and take a small step in that direction to estimate the next point. It is a process of ''linearization by stepping''. We discuss how step size affects accuracy and whether the method overestimates or underestimates based on the convexity of the solution curve (concavity).',
    description = 'Euler Method',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.5' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'Separation of Variables is the primary algebraic technique for solving first-order differential equations in AP Calculus. The strategy is to rearrange the algebra so that all ''y'' terms are with ''dy'' and all ''x'' terms are with ''dx''. Once separated, we integrate both sides to remove the derivatives. This method requires strong algebra skills, especially when dealing with logarithms and exponentials during the final cleanup to solve for y explicitely.',
    description = 'Separation',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.6' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'Finding a Particular Solution means using an Initial Value (like y(0) = 5) to find the specific constant of integration ''C''. This step turns a general family of curves into a single, specific trajectory. In Free Response Questions, this is often a high-stakes problem; failing to separate variables correctly usually results in getting zero points. We emphasize the rigorous step-by-step process: Separate, Integrate, Substitute Initial Condition, Solve for C, and finally Solve for y.',
    description = 'Particular Sol',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.7' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'Differentiability implies Continuity. If a function is smooth (differentiable), it must be unbroken (continuous). However, the reverse is false: corners (like |x|) and vertical tangents (like cube root of x) are continuous but not differentiable. We map these failure points.',
    description = 'Estimation',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '2.3' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'The Power Rule is our first shortcut. Instead of limits, we use the pattern nx^(n-1). We extend this to sums and constant multiples. Differentiation transforms from a page-long limit problem into a one-line calculation.',
    description = 'Differentiability',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.4' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'The Product Rule and Quotient Rule allow us to differentiate combinations of functions. (fg)'' = f''g + fg'' and (f/g)'' = (f''g - fg'')/g^2. Mnemonic devices like ''Low D-High minus High D-Low'' help memorize the complex quotient structure.',
    description = 'Power Rule',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.5' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'Derivatives of Trigonometric Functions require memorizing the derivatives of sin, cos, tan, sec, csc, and cot. We recognize the cyclic nature of sine and cosine and the patterns in secant and tangent. These are building blocks for complex chain rule problems.',
    description = 'Linearity',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.6' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'Derivatives of Exponential functions (e^x, a^x) and Logarithmic functions (ln x). e^x is unique as its own derivative. We learn the scaling factor ''ln a'' that appears when the base is not ''e''. These functions model organic growth and are ubiquitous in applied calculus.',
    description = 'Basic Transcendentals',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = '2.7' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'The Chain Rule is the most powerful tool in differentiation. It handles composite functions f(g(x)) by multiplying the ''outer'' derivative by the ''inner'' derivative. We visualize this as peeling an onion—differentiating layer by layer from outside in.',
    description = 'Product Rule',
    estimated_minutes = 14,
    updated_at = NOW()
WHERE id = '2.8' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'Implicit Differentiation allows us to find dy/dx when y cannot be isolated (like in circles x^2 + y^2 = 25). We treat y as a function y(x) and apply the Chain Rule, multiplying by y'' whenever we differentiate a y term. This unlocks the geometry of non-functions.',
    description = 'Quotient Rule',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '2.9' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'Continuity is the smooth, unbroken behavior of functions. A function is continuous at a point if the limit exists, the function value exists, and they are equal. We classify discontinuities: removable (holes), jump (breaks), and infinite (vertical asymptotes). Understanding these different types of breaks is essential for theorem application later.',
    description = 'Numerical Limits',
    estimated_minutes = 17,
    updated_at = NOW()
WHERE id = '1.4' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Limits involving infinity describe the long-run behavior of functions (horizontal asymptotes) and unbounded behavior (vertical asymptotes). We compare growth rates of function families—exponentials grow faster than polynomials—to quickly determine limits at infinity. This analysis is crucial for sketching the ''end behavior'' of rational functions.',
    description = 'Limit Laws',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '1.5' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'The Intermediate Value Theorem (IVT) is an existence theorem for continuous functions. It states that if you travel smoothly from point A to point B, you must cross every value in between. While intuitive, its proof power is immense: we use it to prove that equations have roots (solutions) without ever solving them.',
    description = 'Factoring/Conjugates',
    estimated_minutes = 21,
    updated_at = NOW()
WHERE id = '1.6' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Selecting procedures for limits means knowing when to use substitution, when to factor, and when to use the Squeeze Theorem. We synthesize our toolkit, learning to recognize the structure of limit problems quickly. This meta-skill prevents getting stuck on complex exams.',
    description = 'Strategy',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '1.7' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Continuity implies limits, but not vice-versa. We revisit the rigorous definition to connect limits to continuity on intervals. This section reinforces the idea that most ''nice'' functions (polynomials, sin, cos, e^x) are continuous everywhere, which justifies direct substitution.',
    description = 'Squeeze Theorem',
    estimated_minutes = 19,
    updated_at = NOW()
WHERE id = '1.8' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'The Chain Rule applied to standard differentiation rules. We revisit Power, Product, and Quotient rules but now with ''chain rule'' complexity. e.g., sin^2(3x). Handling multiple nested layers without losing terms is the key skill here.',
    description = 'Chain Rule',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = '3.1' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Unit 5 Test on Analytical Applications. Covers Mean Value Theorem, Extreme Value Theorem, and Curve Sketching. Justifying local extrema and points of inflection using derivative tests is required.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Analytical_unit_test' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'Review of Limits covers everything from the unit. We consolidate algebraic techniques, graphical reading, and theorem application. Special focus is given to piecewise functions, where limits often behave differently on either side of the ''break'' point.',
    description = 'Intervals',
    estimated_minutes = 21,
    updated_at = NOW()
WHERE id = '1.12' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Advanced Limit topics explore rarer forms and tougher algebraic conjugates. The goal is fluency: being able to see a 0/0 form and immediately know which algebraic scalpel to use to fix it.',
    description = 'Extensions',
    estimated_minutes = 24,
    updated_at = NOW()
WHERE id = '1.13' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Continuity on an open interval vs closed interval involves checking endpoints. We learn that a function can be continuous on [a, b] even if the limit doesn''t exist from the ''outside''. This subtle distinction is vital for rigorous proofs.',
    description = 'Asymptotes',
    estimated_minutes = 24,
    updated_at = NOW()
WHERE id = '1.14' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Connecting Limits to Asymptotes formally. A vertical asymptote is x=a where the limit is infinity. A horizontal asymptote is y=L where the limit at infinity is L. This dual definition is how we rigorously define the ''skeleton'' of a rational function''s graph.',
    description = 'End Behavior',
    estimated_minutes = 23,
    updated_at = NOW()
WHERE id = '1.15' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'The concept of ''Instantaneous Rate of Change'' is the pinnacle of Unit 1. We start measuring speed at a single instant, not just over an hour. This shift from average to instantaneous is the birth of Differential Calculus and the definition of the Derivative.',
    description = 'IVT',
    estimated_minutes = 24,
    updated_at = NOW()
WHERE id = '1.16' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Differentiating Inverse Trigonometric Functions arcsin, arccos, and arctan. Their derivatives are algebraic functions involving square roots and fractions (like 1/(1+x^2)). These formulas are essential for integration later, where they appear frequently in reverse.',
    description = 'Other Trig',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.10' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'This Unit 2 Test evaluates mastery of differentiation rules (Product, Quotient, Chain) and the ability to estimate derivatives from data. Conceptual questions about differentiability vs continuity are included.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Derivatives_unit_test' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'This chapter serves as the bridge between abstract calculus operations and the tangible world. We focus on interpreting the derivative not just as a slope on a graph, but as a rate of change in physical and practical contexts. You will learn to translate the derivative into language that describes how systems evolve over time. For instance, if a function represents the volume of water in a tank, its derivative tells us how fast the water is draining or filling at any precise moment.',
    description = 'Context',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '4.1' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'Calculus begins with Limits—the mathematical tool for analyzing the behavior of functions as they approach a specific point, even if they never quite reach it. We study how to estimate limits numerically by looking at tables of values and graphically by observing the trend of a curve. You will learn that a limit exists only if the left-hand approach matches the right-hand approach, a concept fundamental to continuity.',
    description = 'Avg vs Instant Rate',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '1.1' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Defining limits strictly is the next step. We move from intuitive ''approaching'' to rigorous analysis. We examine how functions behave near undefined points and how to interpret the notation lim(x->c) f(x). This lays the groundwork for the epsilon-delta definition, although our focus remains on the algebraic and graphical implications of limit existence.',
    description = 'Limit Notation',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '1.2' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Finding limits analytically is more precise than graphing. We master algebraic manipulation techniques: factoring to cancel holes, multiplying by conjugates to rationalize roots, and simplifying complex fractions. These ''tricks'' allow us to reveal the true limit of a function that initially appears as an indeterminate 0/0 form.',
    description = 'Graphical Limits',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '1.3' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Implicit Differentiation is revisited with higher complexity. We find second derivatives (d^2y/dx^2) implicitly, which often requires substituting the first derivative back into the equation. This measures concavity of curves like ellipses.',
    description = 'Implicit',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '3.2' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Differentiating Inverse Functions. If (a,b) is on f, then (b,a) is on f-inverse. The slopes are reciprocals: (f^-1)''(b) = 1/f''(a). We solve these problems without finding the inverse function formula, relying purely on the coordinate relationship.',
    description = 'Inverse Derivs',
    estimated_minutes = 14,
    updated_at = NOW()
WHERE id = '3.3' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Differentiating Inverse Trig Functions focus. We practice distinguishing between 1/sqrt(1-x^2) and 1/(1+x^2). Recognizing these forms is critical for recognizing integrals later. We also explore the restricted domains that make these functions invertible.',
    description = 'Inverse Trig',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '3.4' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Changing gears to geometry, we calculate the Area Between Curves. Instead of area to the axis, we find the area enclosed between two functions. The strategy is to slice the region into rectangles with height ''Top Function - Bottom Function''. Finding the intersection points to determine the integration bounds is often the first step. Drawing the graph is essential to identify which function is on top.',
    description = 'Area dx',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.4' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Selecting Procedures for Derivatives. Much like limits, we need a strategy phase. Is it a product? A chain? Implicit? We practice reading a function''s structure before diving into algebra to avoid ''rabbit holes'' of unnecessary complexity.',
    description = 'Strategy',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '3.5' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Calculating Higher-Order Derivatives. f'''', f'''''', etc. We interpret these physically: position -> velocity -> acceleration -> jerk. We also look for patterns in higher derivatives of cyclic functions like sin(x) or e^x.',
    description = 'Higher Order',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '3.6' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    description_2 = 'Straight-line motion is one of the most rigorously tested applications of the derivative. Here, we confine our study to particles moving along a single axis. This constraint allows us to deeply explore the relationships between position, velocity, and acceleration. Velocity is defined as the rate of change of position, while acceleration is the rate of change of velocity. ''At rest'' means velocity is zero; ''speeding up'' means velocity and acceleration share the same sign.',
    description = 'Motion',
    estimated_minutes = 19,
    updated_at = NOW()
WHERE id = '4.2' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'Related Rates problems involve multiple variables changing with time (e.g., x and y in a sliding ladder). We differentiate the geometric relationship with respect to time ''t'' to find how their rates are connected. Distinguishing constants from variables is crucial here. If a ladder slides, its length is constant (derivative 0), but its coordinates change.',
    description = 'Other Rates',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '4.3' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'Optimization involves finding the best solution (min cost, max area) under constraints. The process is standard: Model -> Domain -> Differentiate -> Critical Points -> Verify. Translating text into equations is often the hardest part. You will prove your optimum is global using the Extreme Value Theorem.',
    description = 'Intro RR',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '4.4' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'Local Linearity is a powerful concept that justifies why we can use simple linear models to approximate complex non-linear behaviors over short intervals. The central idea is that if you zoom in close enough on any differentiable curve, it looks like a straight line—specifically, its tangent line. We use this tangent line to estimate function values that would be difficult to calculate directly. This process, often called linearization, is fundamental to engineering and physics where approximate solutions are often sufficient. We will also introduce the concept of error analysis using concavity. By looking at the second derivative, we can predict whether our tangent line approximation lies above the curve (an overestimate) or below the curve (an underestimate). This qualitative check adds a layer of depth to your calculations, moving beyond just finding a number to understanding the geometry of the approximation.',
    description = 'Solving RR',
    estimated_minutes = 22,
    updated_at = NOW()
WHERE id = '4.5' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'Indeterminate forms like zero over zero or infinity over infinity have historically been mathematical roadblocks. L''Hôpital''s Rule gives us a systematic way to bypass these obstacles by shifting our focus from the functions themselves to their rates of change (derivatives). The intuition is elegant: if two functions are racing towards zero, the ratio of their values is eventually determined by the ratio of their speeds. If one approaches zero twice as fast as the other, the limit reflects that. We will cover the strict conditions required to apply this rule—it is not a magic wand for every limit, only indeterminate ones. We will also explore cases where you must apply the rule multiple times, peeling back layers of complexity until a determinate value is revealed. This chapter connects the very first topic of calculus (limits) with the powerful tools of differentiation you have now mastered.',
    description = 'L’Hospital',
    estimated_minutes = 20,
    updated_at = NOW()
WHERE id = '4.7' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    description_2 = 'The First Derivative Test allows us to decode the shape of a function''s graph without seeing it. The derivative serves as a compass: if it is positive, the function is rising; if negative, falling. By mapping these intervals of increase and decrease, we can identify local high points (relative maximums) and low points (relative minimums). A peak occurs naturally where the function switches from rising to falling, and a valley where it switches from falling to rising. We will use ''Sign Charts'' as a visual aid to organize this information. This tool effectively translates algebraic properties of the derivative into the qualitative geometric features of the curve. You will become proficient at sketching a function''s general shape knowing only the behavior of its derivative.',
    description = 'Inc/Dec',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '5.3' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'While the first derivative tells us direction, the second derivative tells us about the ''bending'' or curvature of the graph—its concavity. A function can increase while bending upwards (like a parabola) or increase while bending downwards (like a logarithmic curve). The second derivative distinguishes these cases. Positive concavity means the graph holds water like a cup; negative concavity means it spills water like an umbrella. We will identify ''Points of Inflection'', the specific locations where the concavity flips. We also introduce the Second Derivative Test, a shortcut for finding local extrema: a horizontal tangent at a concave-up portion must be a minimum. This chapter completes your toolkit for analyzing graph shapes.',
    description = '1st Deriv Test',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '5.4' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'This chapter is the ultimate synthesis of differential calculus skills. You will act as a curve sketcher, but instead of plotting points blindly, you will use the sophisticated tools of calculus. You will be given raw information—algebraic expressions or sign charts of the first and second derivatives—and tasked with reconstructing the original function. You must reconcile potentially conflicting clues: ''Function f is increasing here, but concave down there.'' This requires a high level of critical thinking and organizational skill. We will also solve ''matching'' problems, where you pair a function''s graph with the graph of its derivative, relying solely on features like slopes, intercepts, and concavity. It is a rigorous test of your visual and conceptual understanding.',
    description = 'Candidates Test',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '5.5' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'The Extreme Value Theorem (EVT) provides the theoretical assurance that optimization is possible. It states that a continuous function defined on a closed, finite interval must attain both an absolute maximum and an absolute minimum value. This theorem is the foundation for finding the ''best'' or ''worst'' outcomes in any scenario. We will develop a systematic ''Candidate Test'' to find these extrema. Since the highest or lowest points can only occur at peaks, valleys, or the very ends of the domain, our strategy is to check the derivative''s zeros (critical points), undefined points, and the interval endpoints. You will learn to methodically evaluate the function at this small list of candidates to declare a winner. This eliminates the need for guessing and provides a rigorous proof for the location of global extrema.',
    description = 'EVT',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '5.2' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'Optimization is the ''killer app'' of differential calculus—using math to make the best possible decision. Whether it is minimizing the cost of materials for a box, maximizing the area of a pasture, or finding the quickest route across a river, the process is universal. We translate a real-world scenario into a function of a single variable, determine the logical domain (constraints), and then use the derivative to find critical points. This chapter demands that you combine modeling skills with the analytical power of the Extreme Value Theorem. You will learn to justify your answer rigorously, proving that your solution is not just a local peak, but the absolute best outcome possible within the physical limits of the problem.',
    description = 'Concavity',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '5.6' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'Building on the previous section, we tackle more complex and abstract optimization problems. These might involve economic models (revenue/profit), distance minimization in coordinate geometry, or dynamic physics problems. The focus shifts slightly from setting up the problem—which is still critical—to efficiently solving it and verifying the results. We will revisit the First and Second Derivative tests specifically as tools for justification in these contexts. Often, the challenge lies in reducing a multivariable system (like radius and height) to a single variable using a constraint equation. Mastery here proves you can wield calculus as a practical tool for problem-solving.',
    description = '2nd Deriv Test',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '5.7' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'This final chapter of the unit serves as a comprehensive review and a bridge to deeper analysis. We revisit the behavior of implicit relations and inverse functions. We ensure you can seamlessly transition between graphical, numerical, and algebraic representations of functions and their derivatives. Special attention is paid to the inverse function theorem, analyzing the relationship between the slope of a function and the slope of its inverse at corresponding points. We also consolidate your understanding of continuity and differentiability, ensuring you can articulate exactly why a theorem applies or fails in a given scenario. This prepares you for the cumulative nature of the AP exam questions.',
    description = 'Sketching',
    estimated_minutes = 17,
    updated_at = NOW()
WHERE id = '5.8' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'We now apply the definite integral to real-world contexts, focusing on the Accumulation Function. The integral of a rate of change gives the ''Net Change'' in quantity. If you integrate the rate of water flow, you get the total change in water volume. If you integrate velocity, you get displacement (change in position). We distinguish this carefully from total distance traveled, which requires integrating the absolute value of velocity (speed). This chapter bridges the abstract math with physical reality, training you to explain the meaning of an integral expression in a sentence: ''The integral represents the total number of gallons leaked from time a to time b.''',
    description = 'Accumulation Funcs',
    estimated_minutes = 14,
    updated_at = NOW()
WHERE id = '6.5' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'U-Substitution is the primary technique for reversing the Chain Rule. When an integrand is a composite function, simple formulas fail. We look for an ''inner function'' whose derivative is also present in the integral (up to a constant). By substituting a new variable ''u'', we transform a complex integral into a simple, recognizable form. For definite integrals, this process requires careful handling of the domain—we must transform the x-bounds into u-bounds to match our new variable. This clean, elegant change of variables is one of the most frequently used tools in an integrator''s toolkit.',
    description = 'FTC 2',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '6.7' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = '(BC Only) Partial Fraction Decomposition allows us to integrate rational functions—ratios of polynomials—that simplify into sums of simpler fractions. By breaking a complex fraction into parts like A/(x-1) + B/(x+2), we can integrate each term easily using natural logarithms. This method relies heavily on algebraic skills to solve for the unknown coefficients A and B. It effectively turns a division problem into a sum problem, making integration feasible.',
    description = 'Substitution',
    estimated_minutes = 17,
    updated_at = NOW()
WHERE id = '6.9' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'This chapter connects limits to tangent lines, foreshadowing the derivative. We investigate the ''instantaneous rate of change'' as a limit of average rates. The difference quotient formula (f(x+h)-f(x))/h is introduced here, representing the slope of a secant line as the two points get infinitely close.',
    description = 'Synthesis',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '1.9' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Infinite discontinuities occur when limits explode to positive or negative infinity. We study vertical asymptotes and how to determine the sign of the infinity by testing values close to the asymptote. This behavior often signals a ''blow-up'' in a physical system, like infinite pressure.',
    description = 'Removable/Jump/Infinite',
    estimated_minutes = 20,
    updated_at = NOW()
WHERE id = '1.10' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'Limits of oscillating functions can often be solved using the Squeeze Theorem (or Sandwich Theorem). If a function is trapped between two others that approach the same limit, it must also go there. The classic example is x*sin(1/x) as x approaches 0.',
    description = '3-Part Definition',
    estimated_minutes = 22,
    updated_at = NOW()
WHERE id = '1.11' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    description_2 = 'The Derivative is defined as the limit of the difference quotient. It is technically the slope of the tangent line. We compute derivatives the ''long way'' using the limit definition to truly understand that differentiation is just a special limit calculation.',
    description = 'Slopes',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '2.1' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    description_2 = 'Connecting the graphs of f, f'', and f'''' is the ultimate test of understanding. We learn to look at a derivative graph and describe the original function (e.g., where f'' is positive, f is increasing). We deduce concavity from the slope of f''. Mastery here allows you to sketch curves blindly.',
    description = 'Connecting Graphs',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '5.9' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = '(BC Only) Integration by Parts corresponds to the Product Rule for differentiation. It is used when integrating the product of two unrelated functions, like x multiplied by e^x. The strategy involves choosing part of the integrand to differentiate (simpler) and part to integrate. We use the mnemonic LIDET (Log, Inverse Trig, Algebraic, Trig, Exponential) to guide this choice. This technique trades a hard integral for an easier one minus a boundary term. We will organize our work carefully to manage the signs and terms that arise.',
    description = 'Indefinite',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '6.8' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = '(BC Only) Improper Integrals extend the concept of integration to infinite intervals or functions with infinite discontinuities (vertical asymptotes). Since correctly calculating ''infinity'' is impossible, we define these integrals as limits. We evaluate the integral on a finite interval and then take the limit as the bound approaches infinity or the asymptote. You will learn to classify these integrals as ''convergent'' (approaching a finite number) or ''divergent'' (growing without bound). This concept is crucial for the later study of infinite series.',
    description = 'Alg Manipulation',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '6.10' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Exponential Growth and Decay models appear whenever the rate of change is proportional to the current amount (dy/dt = ky). This simple rule governs populations, radioactive decay, and compound interest. We derive the general solution y = Ce^(kt) and apply it to word problems. We focus on interpreting the parameters: C is the initial amount, and k is the growth constant. You will learn shortcuts involving half-life and doubling time to solve these problems efficiently.',
    description = 'Exponential',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.8' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = '(BC Only) Logistic Growth corrects the flaw of exponential models by introducing a ''carrying capacity''—a limit to growth. The rate of change slows down as the population nears this limit. You don''t need to solve the differential equation from scratch, but you must understand its qualitative behavior: the ''S'' shaped curve, the limit as time goes to infinity (carrying capacity), and the fact that growth is fastest exactly halfway to that capacity.',
    description = 'Logistic Models',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.9' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'The Average Value of a function generalizes the arithmetic mean. Geometrically, if the area under a curve were melted down into a perfect rectangle with the same base, its height would be the average value. The formula involves integrating the function and dividing by the interval width. We interpret this value in context: average velocity, average temperature, or average value of a stock. It is a direct application of the Net Change Theorem.',
    description = 'Avg Value',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.1' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'We return to motion one last time to integrate position, velocity, and acceleration. The critical distinction here is between Displacement (net change in position, integral of velocity) and Total Distance Traveled (sum of all movement, integral of absolute speed). We use these integrals to track a particle''s journey, finding its final position by adding the displacement to its starting point. This synthesizes differentiation and integration skills in a kinematic context.',
    description = 'Motion',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.2' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Accumulation applies to anything with a rate of change. We model problems involving fluid flowing in and out of tanks, people entering and leaving a venue, or snow falling and melting. The key equation is ''Amount Now = Initial Amount + Integral of Rate In - Integral of Rate Out''. These problems require carefully setting up integrals from word descriptions and interpreting the results as net changes in the total quantity.',
    description = 'Accumulation',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.3' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Sometimes, regions are simpler when sliced horizontally. In these cases, we integrate with respect to y. The rectangles have width ''Right Function - Left Function''. This requires rewriting functions in terms of y (x = g(y)). This flexibility allows us to tackle complex shapes that would require multiple integrals if we stuck to vertical slicing. It is a test of your spatial adaptability.',
    description = 'Area dy',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.5' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'We extend area to Volume with Known Cross Sections. Imagine a 3D solid whose base is a region in the xy-plane. If we slice it, every cross-section is a recognizable shape (square, semi-circle). The volume is found by accumulating (integrating) the area of these geometric slices across the base. The challenge is expressing the area of a single slice as a function of its position x.',
    description = 'Intersections',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.6' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Volumes of Revolution using the Disc Method. If we spin a region around an axis, it sweeps out a solid. Slicing this solid perpendicular to the axis gives circular discs. The volume is the integral of the area of these circles (πr^2). The radius ''r'' is the distance from the function to the rotation axis. We focus on visualization: identifying the radius and the correct axis of rotation.',
    description = 'Cross Sec 1',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.7' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Volumes of Revolution using the Washer Method. If the region is separated from the axis of rotation, the solid has a hole in the middle. The slices are rings (washers). We calculate the volume by subtracting the inner hole volume from the outer volume: π(R^2 - r^2). Identifying the Outer Radius (R) and Inner Radius (r) correctly is the critical step, often aided by a clear sketch.',
    description = 'Cross Sec 2',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.8' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = '(BC Only) Arc Length calculates the linear distance along a curving path. By summing the hypotenuses of infinitely small right triangles along the curve, we derive an integral formula involving the square root of 1 plus the derivative squared. These integrals are often complex and evaluated numerically, but the setup tests your understanding of the curve''s geometry.',
    description = 'Disc',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.9' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = '(BC Only) Surface Area of Revolution. When a curve is rotated, it generates a surface (like a vase). We calculate its area by integrating the circumference of the rotating band multiplied by its arc length width. The formula combines 2πr with the arc length term. Keeping track of whether you are rotating around the x-axis or y-axis determines the radius expression.',
    description = 'Disc Shift',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.10' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Volume with Disc/Washer Method Review. We consolidate rotation around x-axis, y-axis, and arbitrarily shifted axes (e.g., y=2). The key is accurately defining the radii R and r relative to the axis of rotation.',
    description = 'Washer',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.11' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Vector-Valued Functions formalize parametric motion into vector notation R(t) = <x(t), y(t)>. Position, velocity, and acceleration become vectors. The calculus operations are performed component-wise (differentiate x and y separately). This links calculus directly to physics, dealing with force and motion in two dimensions.',
    description = 'Vector Derivs',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.4' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Convergence of Power Series at Endpoints. Finding the Interval of Convergence requires testing the specific ''x'' values at the boundaries. The series often turns into a harmonic or alternating series at these points, requiring specific tests.',
    description = 'Abs/Cond',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.9' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Constructing Taylor Series from Old Series. Instead of taking derivatives, we substitute into known series like e^x or 1/(1-x). We can also differentiate or integrate series relative to ''x''. This is much faster than the definition.',
    description = 'AST Error',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.10' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Optimization Problems II. We tackle more complex geometric constraints, such as inscribing a cylinder in a sphere. The focus is on setting up the ''primary equation'' to maximize and the ''secondary equation'' to reduce variables. We also verify using the Second Derivative Test for ease.',
    description = 'Opt Intro',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '5.10' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'The second major branch of calculus, integration, begins with the concept of accumulation. Before we find exact values, we learn to approximate. We tackle the ''Area Problem'' by slicing a region under a curve into simple vertical rectangles. This method, known as Riemann Sums, allows us to estimate the total quantity accumulated—whether it is distance traveled or area covered—by summing the areas of these rectangles. We explore different estimation strategies: Left endpoints, Right endpoints, and Midpoints, analyzing how the increasing or decreasing nature of the function creates systematic overestimates or underestimates. This geometric approach builds the intuition that integration is fundamentally an infinite sum of infinitesimally clear slices.',
    description = 'Accumulation',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '6.1' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Here we formalize the Riemann sum into the ''Definite Integral''. This symbol represents the exact net signed area between a function and the x-axis. ''Signed'' is key—area above the axis accumulates positively, while area below counts negatively. We learn to evaluate these integrals conceptually using geometry formulas for known shapes like triangles, rectangles, and semicircles, without yet relying on algebraic rules. This emphasizes that an integral is not just a calculation, but a quantity representing the ''net change'' or ''total accumulation'' over an interval. We also explore the properties of integrals, such as linearity and how splitting an interval affects the total sum.',
    description = 'Riemann Sums',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '6.2' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'The Fundamental Theorem of Calculus (Part 1) is the crowning achievement linking the two halves of calculus. It reveals that differentiation and integration are inverse operations, much like multiplication and division. Specifically, if you define a function as the integral of another function (an accumulation function), the derivative of that new function recovers the original integrand. This powerful insight allows us to study functions defined solely by integrals—analyzing their increasing/decreasing behavior and concavity based on the graph of the integrand. This chapter focuses heavily on graphical analysis problems where you are given the graph of ''f'' and asked questions about an integral defined function ''g''.',
    description = 'Def Integral',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '6.3' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'FTC Part 2 gives us the computational superpower to evaluate definite integrals exactly, bypassing the tedious Riemann sums. It states that to find the integral of a rate of change, we simply need to find the ''antiderivative'' and evaluate the change between the endpoints. This transforms integration from an area estimation problem into an algebraic search for a function whose derivative matches our integrand. We will begin building our library of antiderivatives, reversing the power rule and trigonometric derivatives you memorized earlier. Mastery of this theorem is essential, as it validates the method we use for 90% of integral calculations.',
    description = 'FTC 1',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '6.4' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'This chapter is a technical workshop where we refine our skills in finding antiderivatives. We practice the reverse power rule, properties of integrals with constants and sums, and handling basic transcendental functions like sine, cosine, and e^x. Speed and accuracy are the goals here. We also revisit the concept of the indefinite integral (general family of antiderivatives) and the importance of the ''+ C'' constant of integration. You will learn to solve initial value problems, where knowing one point on the curve allows you to determine the specific solution function from the general family.',
    description = 'Properties',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '6.6' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Integrating Vector-Valued Functions (BC). We integrate each component (x(t) and y(t)) separately to find position from velocity vectors. We interpret the result as the change in position (displacement vector) over time.',
    description = 'Partial Fractions',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '6.12' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Integration Practice Review. A mixed bag of U-sub, Integration by Parts, and Partial Fractions. This section builds speed and recognition. You should be able to look at an integral and instantly identify the correct technique.',
    description = 'Improper Integrals',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '6.13' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Improper Integrals II. We look at integrals with infinite discontinuties in the *middle* of the interval. We must split the integral at the problem point and evaluate two limits. Failing to spot the discontinuity is a common trap.',
    description = 'Selecting Techniques',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '6.14' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Unit 6 Test covering Riemann Sums, properties of definite integrals, and the Fundamental Theorem of Calculus. Antiderivative techniques (U-sub) are tested heavily.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Integration_unit_test' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    description_2 = 'Unit 7 Test on Differential Equations. Slope fields, Separation of Variables, and particular solutions. Modeling exponential growth/decay is also assessed.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_DiffEq_unit_test' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    description_2 = 'Taylor Polynomial Remainder (Lagrange). We practice bounding the error R_n(x). The key challenge is finding the maximum value ''M'' of the (n+1)th derivative. We interpret the error bound as a ''worst-case scenario'' for our estimation.',
    description = 'Taylor Poly',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.11' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Representation of Functions as Power Series. We view functions like ln(1+x) or arctan(x) as infinite polynomials. This allows us to integrate ''impossible'' functions like e^(-x^2) by integrating their series term-by-term.',
    description = 'Lagrange',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.12' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Analytic Functions and Euler''s Formula. We see how e^(ix) = cos x + i sin x by comparing their Taylor series. This reveals the deep connection between exponentials and trigonometry.',
    description = 'Radius/Interval',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.13' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Unit 10 Review: Convergence Tests. A rapid-fire diagnostic session. Geometric -> P-series -> Alternating -> Ratio -> Limit Comparison. We refine the decision tree for choosing the most efficient test.',
    description = 'Finding Series',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.14' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Unit 10 Review: Series Construction. We practice building series for complex composite functions (e.g., x^2 * sin(2x)) and finding their radius of convergence. We also estimate definite integrals using series.',
    description = 'Ops on Series',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.15' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Unit 10 BC Test. Convergence Tests, Taylor Series construction, and Error Bounds (Lagrange/Alternating). This is the most computationally and conceptually dense test.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'BC_Series_unit_test' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Arc Length and Surface Area Review. We differentiate between the formula for length (ds) and surface area (2πr ds). Memorizing the precise standard forms for parametric, polar, and cartesian coordinates is essential.',
    description = 'Washer Shift',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.12' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Center of Mass and Probability (BC Optional/Extension). We use integrals to find the centroid of a region (weighted average position). This physically represents the balance point of a laminar shape.',
    description = 'Arc Length',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.13' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Unit 8 Test. Volume (Disc/Washer/Cross-section), Arc Length, and Accumulation problems. Setting up the correct integral bounds and radii is the focus.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_AppIntegration_unit_test' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    description_2 = 'Parametric Equations free us from the vertical line test. By defining x and y separately as functions of a parameter ''t'' (often time), we can describe any path in the plane—loops, spirals, and knots. We learn to find derivatives to analyze the slope of the path (dy/dx) and the motion along it. This model is ideal for describing 2D motion where horizontal and vertical movements are independent.',
    description = 'Parametric Derivs',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.1' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'The Second Derivative of parametric curves requires careful handling. It measures the concavity of the path. The formula is not just y''''/x''''; it is the time-derivative of the slope (dy/dx) divided by dx/dt. This unintuitive chain rule application is a frequent stumbling block. We use it to determine if a path is curving upwards or downwards.',
    description = 'Parametric 2nd Deriv',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.2' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'We adapt integration to parametric curves to find Arc Length and Area. For area, we integrate y times dx (converted to dx/dt dt). For arc length, we integrate the speed function. A critical detail is tracing the curve''s direction to ensure we find the area enclosed without canceling it out due to backtracking.',
    description = 'Parametric Arc Length',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.3' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'We analyze vector motion: Speed is the magnitude (length) of the velocity vector, a scalar quantity. Total Distance is the integral of speed. We also analyze the velocity vector to determine direction of motion. Understanding the distinction between the vector velocity and scalar speed is the main conceptual goal.',
    description = 'Vector Int',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.5' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Polar Coordinates introduce a new way to map the plane: using distance from the origin (r) and angle from the positive x-axis (θ). We learn to convert between Cartesian (x,y) and Polar (r,θ) forms. Calculating slopes dy/dx in polar requires the product rule, as x = r cosθ and r itself is a function of θ. This is often computationally heavy.',
    description = 'Vector Motion',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.6' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Polar Area is calculated differently. Instead of rectangles, we slice the region into thin sectors (pie slices) centered at the origin. The area of a sector depends on radius squared (1/2 r^2). The integral sums these sectors. Finding the correct angular bounds (intervals of θ) by finding intersection points or zeros is the most challenging part.',
    description = 'Polar Derivs',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.7' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Polar Arc Length measures the length of spirals and boundary curves. The formula is derived from the parametric length formula, adapted for polar relationships. It involves the square root of r^2 + (dr/dθ)^2. While the formula is straightforward, simplifying the trigonometric identities inside the integral often requires algebraic dexterity.',
    description = 'Polar Area',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.8' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Unit 9 Review: Parametric, Polar, and Vectors. We contrast the derivative rules for each system. Slope in parametric is dy/dt / dx/dt. Slope in polar is complex. Speed in vector is magnitude. This comparison helps keep the formulas distinct.',
    description = 'Area Between Polar',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.9' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Unit 9 BC Test. Parametric, Polar, and Vector-Valued functions. Derivatives, Area, and Arc Length in all three coordinate systems are covered.',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'BC_Unit9_unit_test' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    description_2 = 'Taylor Polynomials are the bridge between arithmetic and complex functions. We approximate complicated non-linear functions (like e^x or cos x) using simple polynomials. The key is matching the value and the derivatives at a center point. The more derivatives we match, the closer our polynomial hugs the original curve. This is the foundation of how calculators compute transcendentals.',
    description = 'Convergence',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.1' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Every approximation has error. Lagrange Error Bound gives us a mathematical guarantee of ''how bad'' our approximation could possibly be. It relies on finding the maximum possible value of the next unused derivative. Though the formula looks intimidating, it is just a worst-case scenario analysis. Mastering this bound allows you to state with confidence that your estimate is accurate to within a certain tolerance.',
    description = 'Geometric',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.2' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Taylor Series extend polynomials to infinity. If we match infinite derivatives, the polynomial *becomes* the function. You must memorize the four key Maclaurin series: e^x, sin x, cos x, and geometric series. We learn to manipulate these ''parent'' series—substituting, differentiating, or integrating them—to build series for new functions without starting from scratch.',
    description = 'nth Term',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.3' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Infinite Series Convergence is the study of whether an infinite sum adds up to a finite number. This diagnostic phase involves looking at the ''form'' of a series terms to choose the right test. Does it look geometric? Like a p-series? Do terms go to zero? Developing a diagnostic flow chart in your mind is essential for efficiency.',
    description = 'Integral Test',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.4' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Comparison Tests allow us to judge unknown series by comparing them to well-known ones (like harmonic or geometric series). Direct Comparison requires strict inequality; Limit Comparison is more flexible, checking if two series behave ''similarly'' in the long run. These tests formalize the intuition that ''this series shrinks fast enough to converge''.',
    description = 'p-Series',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.5' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Alternating Series flip signs (+ - + -). They are much easier to converge than positive series. The Alternating Series Test only asks: do the terms shrink to zero? If so, it converges. The Alternating Series Error Bound is also simple: the error is never larger than the first term you threw away. This simplicity makes them a favorite topic.',
    description = 'Comparison',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.6' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'The Ratio Test is the heavy lifter for series involving factorials or exponentials. It looks at the growth rate of consecutive terms. If the ratio is less than 1, the terms shrink fast enough to converge. This test is the primary tool for finding the ''Radius of Convergence'' for power series.',
    description = 'AST',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.7' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Power Series are functions built from infinite series, like f(x) = Σ a_n x^n. They have a domain called the Interval of Convergence where they make sense. We find this interval using the Ratio Test and then check the endpoints manually. Inside this interval, we can differentiate and integrate the series term-by-term, treating it like an infinite polynomial.',
    description = 'Ratio Test',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.8' AND topic_id = 'BC_Series';
UPDATE sections SET 
    description_2 = 'Implicit Relations Analysis. We analyze curves that aren''t functions, finding vertical tangents (where dx/dy = 0 or denominator of dy/dx is 0) and horizontal tangents. This connects calculus back to algebraic geometry and conic sections.',
    description = 'Solving Opt',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '5.11' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    description_2 = 'General Unit Test covering the recent topics. A comprehensive assessment of your understanding.',
    description = 'Comprehensive assessment covering all topics in Unit 5.',
    estimated_minutes = 462,
    updated_at = NOW()
WHERE id = 'unit_test' AND topic_id = 'ABBC_Analytical';
UPDATE sections SET 
    description_2 = 'Unit 5 Review covers the Mean Value Theorem, Extreme Value Theorem, and Curve Sketching. We verify hypotheses for theorems and ensure rigorous justification (e.g., ''Since f is continuous on [a,b]...''). This chapter solidifies the analytical language required for FRQs.',
    description = 'Implicit Behaviors',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '5.12' AND topic_id = 'Both_Analytical';

-- 2. Cleanup Legacy Columns
ALTER TABLE sections DROP COLUMN IF EXISTS description2;
ALTER TABLE sections DROP COLUMN IF EXISTS detailed_description;
ALTER TABLE sections DROP COLUMN IF EXISTS topic_introduction;
ALTER TABLE sections DROP COLUMN IF EXISTS chapter_detailed_description;
