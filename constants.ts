import { Question, TopicMastery, Activity, User, CourseState, CourseType, UnitContent, AppNotification } from './types';

export const INITIAL_USER: User = {
  id: "", // Start empty
  name: "", // Start empty
  email: "", // Start empty
  avatarUrl: "", // Start empty
  currentCourse: 'AB',
  masteryRate: 0,
  problemsSolved: 0,
  studyHours: [0, 0, 0, 0, 0, 0, 0], // M T W T F S S
  streakDays: 0,
  percentile: 0, // 0 indicates unranked/new
  preferences: {
    emailNotifications: true,
    soundEffects: false
  },
  isCreator: false
};

export const INITIAL_RADAR_DATA: TopicMastery[] = [
  { subject: 'Limits', A: 0, fullMark: 100 },
  { subject: 'Derivatives', A: 0, fullMark: 100 },
  { subject: 'Composite', A: 0, fullMark: 100 },
  { subject: 'Contextual Applications', A: 0, fullMark: 100 },
  { subject: 'Analytical Applications', A: 0, fullMark: 100 },
  { subject: 'Integration', A: 0, fullMark: 100 },
  { subject: 'Diff Eq', A: 0, fullMark: 100 },
  { subject: 'App of Int', A: 0, fullMark: 100 },
  { subject: 'Parametric/Polar', A: 0, fullMark: 100 },
  { subject: 'Series', A: 0, fullMark: 100 },
];

export const INITIAL_NOTIFICATIONS: AppNotification[] = [
  { id: 1, text: "Welcome to NewMaoS! Start your first session.", time: "Just now", unread: true, link: '/practice' },
];

// --- Metadata for Question Builder ---

export const SKILL_TAGS = [
  { id: '1.A', label: '1.A Identify the question' },
  { id: '1.B', label: '1.B Identify math info' },
  { id: '1.C', label: '1.C Identify values/params' },
  { id: '1.D', label: '1.D Identify values from graph' },
  { id: '1.E', label: '1.E Apply appropriate procedures' },
  { id: '2.A', label: '2.A Identify concepts' },
  { id: '2.B', label: '2.B Identify math relationships' },
  { id: '3.A', label: '3.A Apply theorems' },
  { id: '3.B', label: '3.B Connect concepts' },
  { id: '3.C', label: '3.C Confirm hypotheses' },
  { id: '3.D', label: '3.D Use exact notation' }
];

export const ERROR_TAGS = [
  { id: 'ERR_ALG_SIGN', label: 'Sign Error (+/-)' },
  { id: 'ERR_TRIG_VAL', label: 'Incorrect Trig Value' },
  { id: 'ERR_DERIV_RULE', label: 'Misapplied Derivative Rule' },
  { id: 'ERR_CHAIN_MISSING', label: 'Forgot Chain Rule' },
  { id: 'ERR_CONCEPTUAL', label: 'Conceptual Misunderstanding' },
  { id: 'ERR_ARITHMETIC', label: 'Simple Arithmetic Error' },
  { id: 'ERR_BOUNDS', label: 'Integration Bounds Error' },
  { id: 'ERR_NOTATION', label: 'Notation Error' }
];

export const RECOMMENDATION_REASON_CODES = [
  { id: 'LOW_MASTERY', label: 'Low Topic Mastery' },
  { id: 'HIGH_ERROR_FREQUENCY', label: 'High Error Frequency' },
  { id: 'SPACED_REVIEW_DUE', label: 'Spaced Repetition Due' },
  { id: 'STREAK_BUILDER', label: 'Confidence Builder' },
  { id: 'CHALLENGE_TOPIC', label: 'Advanced Challenge' }
];

// --- STRICT AP COURSE STRUCTURE (CED) ---

// Unit 1: Limits and Continuity
const UNIT1_SUBTOPICS = [
  { id: '1.1', title: '1.1 Introducing Calculus: Can Change Occur at an Instant?', description: 'Avg vs Instant Rate', estimatedMinutes: 10, content: '' },
  { id: '1.2', title: '1.2 Defining Limits and Using Limit Notation', description: 'Limit Notation', estimatedMinutes: 15, content: '' },
  { id: '1.3', title: '1.3 Estimating Limit Values from Graphs', description: 'Graphical Limits', estimatedMinutes: 10, content: '' },
  { id: '1.4', title: '1.4 Estimating Limit Values from Tables', description: 'Numerical Limits', estimatedMinutes: 10, content: '' },
  { id: '1.5', title: '1.5 Determining Limits Using Algebraic Properties of Limits', description: 'Limit Laws', estimatedMinutes: 15, content: '' },
  { id: '1.6', title: '1.6 Determining Limits Using Algebraic Manipulation', description: 'Factoring/Conjugates', estimatedMinutes: 20, content: '' },
  { id: '1.7', title: '1.7 Selecting Procedures for Determining Limits', description: 'Strategy', estimatedMinutes: 15, content: '' },
  { id: '1.8', title: '1.8 Determining Limits Using the Squeeze Theorem', description: 'Squeeze Theorem', estimatedMinutes: 15, content: '' },
  { id: '1.9', title: '1.9 Connecting Multiple Representations of Limits', description: 'Synthesis', estimatedMinutes: 10, content: '' },
  { id: '1.10', title: '1.10 Exploring Types of Discontinuities', description: 'Removable/Jump/Infinite', estimatedMinutes: 15, content: '' },
  { id: '1.11', title: '1.11 Defining Continuity at a Point', description: '3-Part Definition', estimatedMinutes: 15, content: '' },
  { id: '1.12', title: '1.12 Confirming Continuity over an Interval', description: 'Intervals', estimatedMinutes: 10, content: '' },
  { id: '1.13', title: '1.13 Removing Discontinuities', description: 'Extensions', estimatedMinutes: 15, content: '' },
  { id: '1.14', title: '1.14 Connecting Infinite Limits and Vertical Asymptotes', description: 'Asymptotes', estimatedMinutes: 15, content: '' },
  { id: '1.15', title: '1.15 Connecting Limits at Infinity and Horizontal Asymptotes', description: 'End Behavior', estimatedMinutes: 15, content: '' },
  { id: '1.16', title: '1.16 Working with the Intermediate Value Theorem', description: 'IVT', estimatedMinutes: 15, content: '' }
];

// Unit 2: Differentiation: Definition and Fundamental Properties
const UNIT2_SUBTOPICS = [
  { id: '2.1', title: '2.1 Defining Average and Instantaneous Rates of Change at a Point', description: 'Slopes', estimatedMinutes: 15, content: '' },
  { id: '2.2', title: '2.2 Defining the Derivative of a Function and Using Derivative Notation', description: 'Notation', estimatedMinutes: 20, content: '' },
  { id: '2.3', title: '2.3 Estimating Derivatives of a Function at a Point', description: 'Estimation', estimatedMinutes: 15, content: '' },
  { id: '2.4', title: '2.4 Connecting Differentiability and Continuity: Determining When Derivatives Do and Do Not Exist', description: 'Differentiability', estimatedMinutes: 15, content: '' },
  { id: '2.5', title: '2.5 Applying the Power Rule', description: 'Power Rule', estimatedMinutes: 10, content: '' },
  { id: '2.6', title: '2.6 Derivative Rules: Constant, Sum, Difference, and Constant Multiple', description: 'Linearity', estimatedMinutes: 10, content: '' },
  { id: '2.7', title: '2.7 Derivatives of cos x, sin x, e^x, and ln x', description: 'Basic Transcendentals', estimatedMinutes: 15, content: '' },
  { id: '2.8', title: '2.8 The Product Rule', description: 'Product Rule', estimatedMinutes: 15, content: '' },
  { id: '2.9', title: '2.9 The Quotient Rule', description: 'Quotient Rule', estimatedMinutes: 15, content: '' },
  { id: '2.10', title: '2.10 Finding the Derivatives of Tangent, Cotangent, Secant, and/or Cosecant Functions', description: 'Other Trig', estimatedMinutes: 15, content: '' }
];

// Unit 3: Differentiation: Composite, Implicit, and Inverse Functions
const UNIT3_SUBTOPICS = [
  { id: '3.1', title: '3.1 The Chain Rule', description: 'Chain Rule', estimatedMinutes: 20, content: '' },
  { id: '3.2', title: '3.2 Implicit Differentiation', description: 'Implicit', estimatedMinutes: 20, content: '' },
  { id: '3.3', title: '3.3 Differentiating Inverse Functions', description: 'Inverse Derivs', estimatedMinutes: 15, content: '' },
  { id: '3.4', title: '3.4 Differentiating Inverse Trigonometric Functions', description: 'Inverse Trig', estimatedMinutes: 15, content: '' },
  { id: '3.5', title: '3.5 Selecting Procedures for Calculating Derivatives', description: 'Strategy', estimatedMinutes: 15, content: '' },
  { id: '3.6', title: '3.6 Calculating Higher-Order Derivatives', description: 'Higher Order', estimatedMinutes: 15, content: '' }
];

// Unit 4: Contextual Applications of Differentiation
const UNIT4_SUBTOPICS = [
  { id: '4.1', title: '4.1 Interpreting the Meaning of the Derivative in Context', description: 'Context', estimatedMinutes: 15, content: '' },
  { id: '4.2', title: '4.2 Straight-Line Motion: Connecting Position, Velocity, and Acceleration', description: 'Motion', estimatedMinutes: 20, content: '' },
  { id: '4.3', title: '4.3 Rates of Change in Applied Contexts other than Motion', description: 'Other Rates', estimatedMinutes: 15, content: '' },
  { id: '4.4', title: '4.4 Introduction to Related Rates', description: 'Intro RR', estimatedMinutes: 20, content: '' },
  { id: '4.5', title: '4.5 Solving Related Rates Problems', description: 'Solving RR', estimatedMinutes: 25, content: '' },
  { id: '4.6', title: '4.6 Approximating Values of a Function Using Local Linearity and Linearization', description: 'Linearization', estimatedMinutes: 15, content: '' },
  { id: '4.7', title: '4.7 Using L’Hospital’s Rule for Finding Limits of Indeterminate Forms', description: 'L’Hospital', estimatedMinutes: 15, content: '' }
];

// Unit 5: Analytical Applications of Differentiation
const UNIT5_SUBTOPICS = [
  { id: '5.1', title: '5.1 Using the Mean Value Theorem', description: 'MVT', estimatedMinutes: 15, content: '' },
  { id: '5.2', title: '5.2 Extreme Value Theorem, Global Versus Local Extrema, and Critical Points', description: 'EVT', estimatedMinutes: 20, content: '' },
  { id: '5.3', title: '5.3 Determining Intervals on Which a Function Is Increasing or Decreasing', description: 'Inc/Dec', estimatedMinutes: 15, content: '' },
  { id: '5.4', title: '5.4 Using the First Derivative Test to Find Relative (Local) Extrema', description: '1st Deriv Test', estimatedMinutes: 15, content: '' },
  { id: '5.5', title: '5.5 Using the Candidates Test to Find Absolute (Global) Extrema', description: 'Candidates Test', estimatedMinutes: 20, content: '' },
  { id: '5.6', title: '5.6 Determining Concavity of Functions over Their Domains', description: 'Concavity', estimatedMinutes: 15, content: '' },
  { id: '5.7', title: '5.7 Using the Second Derivative Test to Find Extrema', description: '2nd Deriv Test', estimatedMinutes: 15, content: '' },
  { id: '5.8', title: '5.8 Sketching Graphs of Functions and Their Derivatives', description: 'Sketching', estimatedMinutes: 20, content: '' },
  { id: '5.9', title: '5.9 Connecting a Function, Its First Derivative, and Its Second Derivative', description: 'Connecting Graphs', estimatedMinutes: 15, content: '' },
  { id: '5.10', title: '5.10 Introduction to Optimization Problems', description: 'Opt Intro', estimatedMinutes: 15, content: '' },
  { id: '5.11', title: '5.11 Solving Optimization Problems', description: 'Solving Opt', estimatedMinutes: 25, content: '' },
  { id: '5.12', title: '5.12 Exploring Behaviors of Implicit Relations', description: 'Implicit Behaviors', estimatedMinutes: 15, content: '' }
];

// Unit 6: Integration and Accumulation of Change
const UNIT6_SUBTOPICS_COMMON = [
  { id: '6.1', title: '6.1 Exploring Accumulations of Change', description: 'Accumulation', estimatedMinutes: 15, content: '' },
  { id: '6.2', title: '6.2 Approximating Areas with Riemann Sums', description: 'Riemann Sums', estimatedMinutes: 20, content: '' },
  { id: '6.3', title: '6.3 Riemann Sums, Summation Notation, and Definite Integral Notation', description: 'Def Integral', estimatedMinutes: 15, content: '' },
  { id: '6.4', title: '6.4 The Fundamental Theorem of Calculus and Accumulation Functions', description: 'FTC 1', estimatedMinutes: 20, content: '' },
  { id: '6.5', title: '6.5 Interpreting the Behavior of Accumulation Functions Involving Area', description: 'Accumulation Funcs', estimatedMinutes: 15, content: '' },
  { id: '6.6', title: '6.6 Applying Properties of Definite Integrals', description: 'Properties', estimatedMinutes: 15, content: '' },
  { id: '6.7', title: '6.7 The Fundamental Theorem of Calculus and Definite Integrals', description: 'FTC 2', estimatedMinutes: 15, content: '' },
  { id: '6.8', title: '6.8 Finding Antiderivatives and Indefinite Integrals - Basic Rules and Notation', description: 'Indefinite', estimatedMinutes: 15, content: '' },
  { id: '6.9', title: '6.9 Integrating Using Substitution', description: 'Substitution', estimatedMinutes: 20, content: '' },
  { id: '6.10', title: '6.10 Integrating Functions Using Long Division and Completing the Square', description: 'Alg Manipulation', estimatedMinutes: 20, content: '' }
];

const UNIT6_BC_ONLY_PART = [
  { id: '6.11', title: '6.11 (BC ONLY) Using Integration by Parts', description: 'Integration by Parts', estimatedMinutes: 20, content: '' },
  { id: '6.12', title: '6.12 (BC ONLY) Integrating Using Linear Partial Fractions', description: 'Partial Fractions', estimatedMinutes: 20, content: '' },
  { id: '6.13', title: '6.13 (BC ONLY) Evaluating Improper Integrals', description: 'Improper Integrals', estimatedMinutes: 20, content: '' },
];

const UNIT6_COMMON_END = [
  { id: '6.14', title: '6.14 Selecting Techniques for Antidifferentiation', description: 'Selecting Techniques', estimatedMinutes: 20, content: '' }
];

const UNIT6_SUBTOPICS_AB = [...UNIT6_SUBTOPICS_COMMON, ...UNIT6_COMMON_END];
const UNIT6_SUBTOPICS_BC = [...UNIT6_SUBTOPICS_COMMON, ...UNIT6_BC_ONLY_PART, ...UNIT6_COMMON_END];


// Unit 7: Differential Equations
const UNIT7_COMMON_PART_1 = [
  { id: '7.1', title: '7.1 Modeling Situations with Differential Equations', description: 'Modeling', estimatedMinutes: 15, content: '' },
  { id: '7.2', title: '7.2 Verifying Solutions for Differential Equations', description: 'Verifying', estimatedMinutes: 15, content: '' },
  { id: '7.3', title: '7.3 Sketching Slope Fields', description: 'Slope Fields', estimatedMinutes: 20, content: '' },
  { id: '7.4', title: '7.4 Reasoning Using Slope Fields', description: 'Reasoning', estimatedMinutes: 15, content: '' },
];

const UNIT7_BC_ONLY_PART_1 = [
  { id: '7.5', title: '7.5 (BC ONLY) Approximating Solutions Using Euler’s Method', description: 'Euler Method', estimatedMinutes: 20, content: '' }
];

const UNIT7_COMMON_PART_2 = [
  { id: '7.6', title: '7.6 Finding General Solutions Using Separation of Variables', description: 'Separation', estimatedMinutes: 20, content: '' },
  { id: '7.7', title: '7.7 Finding Particular Solutions Using Initial Conditions and Separation of Variables', description: 'Particular Sol', estimatedMinutes: 20, content: '' },
  { id: '7.8', title: '7.8 Exponential Models with Differential Equations', description: 'Exponential', estimatedMinutes: 15, content: '' }
];

const UNIT7_BC_ONLY_PART_2 = [
  { id: '7.9', title: '7.9 (BC ONLY) Logistic Models with Differential Equations', description: 'Logistic Models', estimatedMinutes: 20, content: '' }
];

const UNIT7_SUBTOPICS_AB = [...UNIT7_COMMON_PART_1, ...UNIT7_COMMON_PART_2];
const UNIT7_SUBTOPICS_BC = [...UNIT7_COMMON_PART_1, ...UNIT7_BC_ONLY_PART_1, ...UNIT7_COMMON_PART_2, ...UNIT7_BC_ONLY_PART_2];

// Unit 8: Applications of Integration
const UNIT8_COMMON = [
  { id: '8.1', title: '8.1 Finding the Average Value of a Function on an Interval', description: 'Avg Value', estimatedMinutes: 15, content: '' },
  { id: '8.2', title: '8.2 Connecting Position, Velocity, and Acceleration Functions Using Integrals', description: 'Motion', estimatedMinutes: 15, content: '' },
  { id: '8.3', title: '8.3 Using Accumulation Functions and Definite Integrals in Applied Contexts', description: 'Accumulation', estimatedMinutes: 15, content: '' },
  { id: '8.4', title: '8.4 Finding the Area Between Curves Expressed as Functions of x', description: 'Area dx', estimatedMinutes: 20, content: '' },
  { id: '8.5', title: '8.5 Finding the Area Between Curves Expressed as Functions of y', description: 'Area dy', estimatedMinutes: 20, content: '' },
  { id: '8.6', title: '8.6 Finding the Area Between Curves That Intersect at More Than Two Points', description: 'Intersections', estimatedMinutes: 20, content: '' },
  { id: '8.7', title: '8.7 Volumes with Cross-Sections - Squares and Rectangles', description: 'Cross Sec 1', estimatedMinutes: 20, content: '' },
  { id: '8.8', title: '8.8 Volumes with Cross-Sections - Triangles and Semicircles', description: 'Cross Sec 2', estimatedMinutes: 20, content: '' },
  { id: '8.9', title: '8.9 Volume with Disc Method - Revolving Around x- or y-axis', description: 'Disc', estimatedMinutes: 20, content: '' },
  { id: '8.10', title: '8.10 Volume with Disc Method - Revolving Around Other Axes', description: 'Disc Shift', estimatedMinutes: 20, content: '' },
  { id: '8.11', title: '8.11 Volume with Washer Method - Revolving Around x- or y-axis', description: 'Washer', estimatedMinutes: 20, content: '' },
  { id: '8.12', title: '8.12 Volume with Washer Method - Revolving Around Other Axes', description: 'Washer Shift', estimatedMinutes: 20, content: '' }
];

const UNIT8_BC_ONLY = [
  { id: '8.13', title: '8.13 (BC ONLY) The Arc Length of a Smooth, Planar Curve and Distance Traveled', description: 'Arc Length', estimatedMinutes: 20, content: '' }
];

const UNIT8_SUBTOPICS_AB = [...UNIT8_COMMON];
const UNIT8_SUBTOPICS_BC = [...UNIT8_COMMON, ...UNIT8_BC_ONLY];

// Unit 9: Parametric, Polar, and Vector-Valued Functions (BC ONLY)
const UNIT9_SUBTOPICS_BC = [
  { id: '9.1', title: '9.1 (BC ONLY) Defining and Differentiating Parametric Equations', description: 'Parametric Derivs', estimatedMinutes: 20, content: '' },
  { id: '9.2', title: '9.2 (BC ONLY) Second Derivatives of Parametric Equations', description: 'Parametric 2nd Deriv', estimatedMinutes: 20, content: '' },
  { id: '9.3', title: '9.3 (BC ONLY) Finding Arc Lengths of Curves Given by Parametric Equations', description: 'Parametric Arc Length', estimatedMinutes: 15, content: '' },
  { id: '9.4', title: '9.4 (BC ONLY) Defining and Differentiating Vector-Valued Functions', description: 'Vector Derivs', estimatedMinutes: 15, content: '' },
  { id: '9.5', title: '9.5 (BC ONLY) Integrating Vector-Valued Functions', description: 'Vector Int', estimatedMinutes: 15, content: '' },
  { id: '9.6', title: '9.6 (BC ONLY) Solving Motion Problems Using Parametric and Vector-Valued Functions', description: 'Vector Motion', estimatedMinutes: 20, content: '' },
  { id: '9.7', title: '9.7 (BC ONLY) Defining Polar Coordinates and Differentiating in Polar Form', description: 'Polar Derivs', estimatedMinutes: 20, content: '' },
  { id: '9.8', title: '9.8 (BC ONLY) Finding the Area of a Polar Region or the Area Bounded by a Single Polar Curve', description: 'Polar Area', estimatedMinutes: 20, content: '' },
  { id: '9.9', title: '9.9 (BC ONLY) Finding the Area of the Region Bounded by Two Polar Curves', description: 'Area Between Polar', estimatedMinutes: 20, content: '' }
];

// Unit 10: Infinite Sequences and Series (BC ONLY)
const UNIT10_SUBTOPICS_BC = [
  { id: '10.1', title: '10.1 (BC ONLY) Defining Convergent and Divergent Infinite Series', description: 'Convergence', estimatedMinutes: 15, content: '' },
  { id: '10.2', title: '10.2 (BC ONLY) Working with Geometric Series', description: 'Geometric', estimatedMinutes: 20, content: '' },
  { id: '10.3', title: '10.3 (BC ONLY) The nth-Term Test for Divergence', description: 'nth Term', estimatedMinutes: 15, content: '' },
  { id: '10.4', title: '10.4 (BC ONLY) Integral Test for Convergence', description: 'Integral Test', estimatedMinutes: 20, content: '' },
  { id: '10.5', title: '10.5 (BC ONLY) Harmonic Series and p-Series', description: 'p-Series', estimatedMinutes: 15, content: '' },
  { id: '10.6', title: '10.6 (BC ONLY) Comparison Tests for Convergence', description: 'Comparison', estimatedMinutes: 20, content: '' },
  { id: '10.7', title: '10.7 (BC ONLY) Alternating Series Test for Convergence', description: 'AST', estimatedMinutes: 15, content: '' },
  { id: '10.8', title: '10.8 (BC ONLY) Ratio Test for Convergence', description: 'Ratio Test', estimatedMinutes: 20, content: '' },
  { id: '10.9', title: '10.9 (BC ONLY) Determining Absolute or Conditional Convergence', description: 'Abs/Cond', estimatedMinutes: 15, content: '' },
  { id: '10.10', title: '10.10 (BC ONLY) Alternating Series Error Bound', description: 'AST Error', estimatedMinutes: 15, content: '' },
  { id: '10.11', title: '10.11 (BC ONLY) Finding Taylor Polynomial Approximations of Functions', description: 'Taylor Poly', estimatedMinutes: 20, content: '' },
  { id: '10.12', title: '10.12 (BC ONLY) Lagrange Error Bound', description: 'Lagrange', estimatedMinutes: 20, content: '' },
  { id: '10.13', title: '10.13 (BC ONLY) Radius and Interval of Convergence of Power Series', description: 'Radius/Interval', estimatedMinutes: 20, content: '' },
  { id: '10.14', title: '10.14 (BC ONLY) Finding Taylor or Maclaurin Series for a Function', description: 'Finding Series', estimatedMinutes: 20, content: '' },
  { id: '10.15', title: '10.15 (BC ONLY) Representing Functions as Power Series', description: 'Ops on Series', estimatedMinutes: 20, content: '' }
];

// --- EXPORTED DATA STRUCTURES ---

// Used by Course Navigator (Dashboard/Sidebar)
export const COURSE_TOPICS: Record<CourseType, { id: string; subject: string; count: number }[]> = {
  AB: [
    { id: 'ABBC_Limits', subject: 'Unit 1: Limits and Continuity', count: 0 },
    { id: 'ABBC_Derivatives', subject: 'Unit 2: Differentiation: Definition and Fundamental Properties', count: 0 },
    { id: 'ABBC_Composite', subject: 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', count: 0 },
    { id: 'ABBC_Applications', subject: 'Unit 4: Contextual Applications of Differentiation', count: 0 },
    { id: 'ABBC_Analytical', subject: 'Unit 5: Analytical Applications of Differentiation', count: 0 },
    { id: 'ABBC_Integration', subject: 'Unit 6: Integration and Accumulation of Change', count: 0 },
    { id: 'ABBC_DiffEq', subject: 'Unit 7: Differential Equations', count: 0 },
    { id: 'ABBC_AppIntegration', subject: 'Unit 8: Applications of Integration', count: 0 },
  ],
  BC: [
    { id: 'ABBC_Limits', subject: 'Unit 1: Limits and Continuity', count: 0 },
    { id: 'ABBC_Derivatives', subject: 'Unit 2: Differentiation: Definition and Fundamental Properties', count: 0 },
    { id: 'ABBC_Composite', subject: 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', count: 0 },
    { id: 'ABBC_Applications', subject: 'Unit 4: Contextual Applications of Differentiation', count: 0 },
    { id: 'ABBC_Analytical', subject: 'Unit 5: Analytical Applications of Differentiation', count: 0 },
    { id: 'ABBC_Integration', subject: 'Unit 6: Integration and Accumulation of Change', count: 0 },
    { id: 'ABBC_DiffEq', subject: 'Unit 7: Differential Equations', count: 0 },
    { id: 'ABBC_AppIntegration', subject: 'Unit 8: Applications of Integration', count: 0 },
    { id: 'BC_Unit9', subject: 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', count: 0 },
    { id: 'BC_Series', subject: 'Unit 10: Infinite Sequences and Series', count: 0 },
  ]
};

// Used by TopicDetail and QuestionCreator to populate subtopics
// Used by TopicDetail and QuestionCreator to populate subtopics
export const COURSE_CONTENT_DATA: Record<string, UnitContent> = {
  // SHARED Mappings (ABBC)
  'ABBC_Limits': { id: 'ABBC_Limits', title: 'Unit 1: Limits and Continuity', description: 'Limits and Continuity', subTopics: UNIT1_SUBTOPICS },
  'ABBC_Derivatives': { id: 'ABBC_Derivatives', title: 'Unit 2: Differentiation: Definition and Fundamental Properties', description: 'Differentiation Definition', subTopics: UNIT2_SUBTOPICS },
  'ABBC_Composite': { id: 'ABBC_Composite', title: 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', description: 'Composite Functions', subTopics: UNIT3_SUBTOPICS },
  'ABBC_Applications': { id: 'ABBC_Applications', title: 'Unit 4: Contextual Applications of Differentiation', description: 'Contextual Applications', subTopics: UNIT4_SUBTOPICS },
  'ABBC_Analytical': { id: 'ABBC_Analytical', title: 'Unit 5: Analytical Applications of Differentiation', description: 'Analytical Applications', subTopics: UNIT5_SUBTOPICS },
  // NOTE: Integration, DiffEq, AppIntegration have mixed content. 
  // We point them to the BC superset in constants for now, but UI should filter based on scope if using DB.
  // Actually, let's use the BC superset (Logic: Contains everything) and rely on UI to hide unmatched scope.
  'ABBC_Integration': { id: 'ABBC_Integration', title: 'Unit 6: Integration and Accumulation of Change', description: 'Integration and Accumulation of Change', subTopics: UNIT6_SUBTOPICS_BC },
  'ABBC_DiffEq': { id: 'ABBC_DiffEq', title: 'Unit 7: Differential Equations', description: 'Differential Equations', subTopics: UNIT7_SUBTOPICS_BC },
  'ABBC_AppIntegration': { id: 'ABBC_AppIntegration', title: 'Unit 8: Applications of Integration', description: 'Applications of Integration', subTopics: UNIT8_SUBTOPICS_BC },

  // BC Only Mappings (Unit 9/10)
  'BC_Unit9': { id: 'BC_Unit9', title: 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', description: 'Parametric/Polar/Vector', subTopics: UNIT9_SUBTOPICS_BC },
  'BC_Series': { id: 'BC_Series', title: 'Unit 10: Infinite Sequences and Series', description: 'Infinite Series', subTopics: UNIT10_SUBTOPICS_BC },
};

export const INITIAL_LINE_DATA = [
  { day: 'Day 1', value: 0 },
  { day: 'Day 2', value: 0 },
  { day: 'Day 3', value: 0 },
  { day: 'Day 4', value: 0 },
  { day: 'Day 5', value: 0 },
  { day: 'Day 6', value: 0 },
  { day: 'Today', value: 0 },
];

export const INITIAL_ACTIVITIES: Activity[] = [];

export const INITIAL_COURSES: Record<'AB' | 'BC', CourseState> = {
  AB: {
    id: 'AB',
    title: 'AP Calculus AB',
    status: 'Not Started',
    currentModuleIndex: 0,
    modules: [
      { id: 'm1', title: 'Limits & Continuity', progress: 0, status: 'active' },
      { id: 'm2', title: 'Differentiation', progress: 0, status: 'locked' }
    ]
  },
  BC: {
    id: 'BC',
    title: 'AP Calculus BC',
    status: 'Not Started',
    currentModuleIndex: 0,
    modules: [
      { id: 'm1', title: 'Infinite Sequences and Series', progress: 0, status: 'active' },
      { id: 'm2', title: 'Parametric Equations', progress: 0, status: 'locked' }
    ]
  }
};

export const PRACTICE_QUESTIONS: Question[] = [];