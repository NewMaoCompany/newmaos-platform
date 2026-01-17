-- =====================================================
-- NewMaoS Adaptive Learning Algorithm - Database Schema Migration
-- Run this AFTER init.sql in Supabase SQL Editor
-- This migration is ADDITIVE ONLY - it does NOT modify/delete existing data
-- =====================================================

-- =====================================================
-- PART 1: ADD NEW COLUMNS TO public.questions
-- (Preserves all existing columns)
-- =====================================================

-- Add status column for question lifecycle
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'active' 
CHECK (status IN ('draft', 'active', 'retired'));

-- Add version for question tracking
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS version INTEGER DEFAULT 1;

-- Add reasoning_level for cognitive complexity (1-5 scale)
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS reasoning_level INTEGER DEFAULT 3 
CHECK (reasoning_level BETWEEN 1 AND 5);

-- Add mastery_weight for algorithm weighting
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS mastery_weight NUMERIC(4,2) DEFAULT 1.0;

-- Add representation_type for problem format classification
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS representation_type VARCHAR(20) DEFAULT 'symbolic' 
CHECK (representation_type IN ('symbolic', 'graph', 'table', 'verbal', 'mixed'));

-- Create composite index for topic filtering
CREATE INDEX IF NOT EXISTS idx_questions_course_topic_subtopic 
ON public.questions(course, topic, sub_topic_id);

-- Create GIN index for skill_tags array search
CREATE INDEX IF NOT EXISTS idx_questions_skill_tags 
ON public.questions USING GIN (skill_tags);

-- Create index for active questions only
CREATE INDEX IF NOT EXISTS idx_questions_status 
ON public.questions(status) WHERE status = 'active';


-- =====================================================
-- PART 2: CREATE public.skills (Skill Dictionary)
-- =====================================================

CREATE TABLE IF NOT EXISTS public.skills (
    id VARCHAR(50) PRIMARY KEY,              -- e.g., 'u3_chain_rule'
    name VARCHAR(255) NOT NULL,              -- Human-readable name
    unit VARCHAR(50) NOT NULL,               -- e.g., 'Unit 3'
    prerequisites TEXT[] DEFAULT '{}'        -- Array of prerequisite skill IDs
);

-- Enable RLS
ALTER TABLE public.skills ENABLE ROW LEVEL SECURITY;

-- RLS: Authenticated users can read
CREATE POLICY "Authenticated users can view skills" ON public.skills
    FOR SELECT TO authenticated USING (true);

-- RLS: Only creators can write
CREATE POLICY "Creators can manage skills" ON public.skills
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );


-- =====================================================
-- PART 3: CREATE public.question_skills (Question-Skill Mapping)
-- =====================================================

CREATE TABLE IF NOT EXISTS public.question_skills (
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    skill_id VARCHAR(50) REFERENCES public.skills(id) ON DELETE CASCADE,
    weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0 AND 1),
    role VARCHAR(20) DEFAULT 'primary' CHECK (role IN ('primary', 'secondary')),
    PRIMARY KEY (question_id, skill_id)
);

-- Enable RLS
ALTER TABLE public.question_skills ENABLE ROW LEVEL SECURITY;

-- Index for skill-based lookups
CREATE INDEX IF NOT EXISTS idx_question_skills_skill 
ON public.question_skills(skill_id);

-- RLS: Authenticated users can read
CREATE POLICY "Authenticated users can view question_skills" ON public.question_skills
    FOR SELECT TO authenticated USING (true);

-- RLS: Only creators can write
CREATE POLICY "Creators can manage question_skills" ON public.question_skills
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );


-- =====================================================
-- PART 4: CREATE public.error_tags (Error Dictionary)
-- =====================================================

CREATE TABLE IF NOT EXISTS public.error_tags (
    id VARCHAR(50) PRIMARY KEY,              -- e.g., 'ERR_CHAIN_MISSING'
    name VARCHAR(255) NOT NULL,              -- Human-readable name
    category VARCHAR(50),                    -- e.g., 'conceptual', 'procedural', 'arithmetic'
    severity INTEGER DEFAULT 1 CHECK (severity BETWEEN 1 AND 5)
);

-- Enable RLS
ALTER TABLE public.error_tags ENABLE ROW LEVEL SECURITY;

-- RLS: Authenticated users can read
CREATE POLICY "Authenticated users can view error_tags" ON public.error_tags
    FOR SELECT TO authenticated USING (true);

-- RLS: Only creators can write
CREATE POLICY "Creators can manage error_tags" ON public.error_tags
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );


-- =====================================================
-- PART 5: CREATE public.question_attempts (Core Algorithm Data)
-- =====================================================

CREATE TABLE IF NOT EXISTS public.question_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL,
    is_correct BOOLEAN NOT NULL,
    selected_option_id VARCHAR(100),         -- For MCQ
    answer_numeric NUMERIC,                  -- For Numeric type
    time_spent_seconds INTEGER DEFAULT 0,
    attempt_no INTEGER DEFAULT 1,
    error_tags TEXT[] DEFAULT '{}',          -- Quick reference; formal relation in attempt_errors
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.question_attempts ENABLE ROW LEVEL SECURITY;

-- Index for user timeline queries
CREATE INDEX IF NOT EXISTS idx_attempts_user_time 
ON public.question_attempts(user_id, created_at DESC);

-- Index for question performance analysis
CREATE INDEX IF NOT EXISTS idx_attempts_user_question 
ON public.question_attempts(user_id, question_id);

-- Index for wrong answers analysis
CREATE INDEX IF NOT EXISTS idx_attempts_incorrect 
ON public.question_attempts(user_id, is_correct) WHERE is_correct = false;

-- RLS: Users can only access their own attempts
CREATE POLICY "Users can view own attempts" ON public.question_attempts
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own attempts" ON public.question_attempts
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own attempts" ON public.question_attempts
    FOR UPDATE USING (auth.uid() = user_id);


-- =====================================================
-- PART 6: CREATE public.user_skill_mastery (User Mastery per Skill)
-- =====================================================

CREATE TABLE IF NOT EXISTS public.user_skill_mastery (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    skill_id VARCHAR(50) REFERENCES public.skills(id) ON DELETE CASCADE,
    mastery_score NUMERIC(5,2) DEFAULT 0 CHECK (mastery_score BETWEEN 0 AND 100),
    confidence NUMERIC(3,2) DEFAULT 0 CHECK (confidence BETWEEN 0 AND 1),
    last_practiced TIMESTAMPTZ,
    streak_correct INTEGER DEFAULT 0,
    streak_wrong INTEGER DEFAULT 0,
    PRIMARY KEY (user_id, skill_id)
);

-- Enable RLS
ALTER TABLE public.user_skill_mastery ENABLE ROW LEVEL SECURITY;

-- Index for skill-based analysis
CREATE INDEX IF NOT EXISTS idx_user_skill_mastery_skill 
ON public.user_skill_mastery(skill_id);

-- Index for low mastery recommendations
CREATE INDEX IF NOT EXISTS idx_user_skill_mastery_low 
ON public.user_skill_mastery(user_id, mastery_score) WHERE mastery_score < 70;

-- RLS: Users can only access their own mastery
CREATE POLICY "Users can view own skill mastery" ON public.user_skill_mastery
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own skill mastery" ON public.user_skill_mastery
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own skill mastery" ON public.user_skill_mastery
    FOR UPDATE USING (auth.uid() = user_id);


-- =====================================================
-- PART 7: CREATE public.attempt_errors (Attempt-Error Mapping)
-- =====================================================

CREATE TABLE IF NOT EXISTS public.attempt_errors (
    attempt_id UUID REFERENCES public.question_attempts(id) ON DELETE CASCADE,
    error_tag_id VARCHAR(50) REFERENCES public.error_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (attempt_id, error_tag_id)
);

-- Enable RLS
ALTER TABLE public.attempt_errors ENABLE ROW LEVEL SECURITY;

-- Index for error analysis
CREATE INDEX IF NOT EXISTS idx_attempt_errors_tag 
ON public.attempt_errors(error_tag_id);

-- RLS: Users can only access errors linked to their own attempts
CREATE POLICY "Users can view own attempt errors" ON public.attempt_errors
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.question_attempts 
            WHERE id = attempt_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert own attempt errors" ON public.attempt_errors
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.question_attempts 
            WHERE id = attempt_id AND user_id = auth.uid()
        )
    );


-- =====================================================
-- PART 8: SEED INITIAL SKILL DATA (AP Calculus CED)
-- =====================================================

INSERT INTO public.skills (id, name, unit, prerequisites) VALUES
    -- Unit 1: Limits
    ('u1_limit_notation', 'Limit Notation', 'Unit 1', '{}'),
    ('u1_graphical_limits', 'Graphical Limits', 'Unit 1', '{u1_limit_notation}'),
    ('u1_numerical_limits', 'Numerical Limits', 'Unit 1', '{u1_limit_notation}'),
    ('u1_algebraic_limits', 'Algebraic Limit Techniques', 'Unit 1', '{u1_limit_notation}'),
    ('u1_squeeze_theorem', 'Squeeze Theorem', 'Unit 1', '{u1_algebraic_limits}'),
    ('u1_continuity', 'Continuity', 'Unit 1', '{u1_limit_notation}'),
    ('u1_discontinuities', 'Types of Discontinuities', 'Unit 1', '{u1_continuity}'),
    ('u1_ivt', 'Intermediate Value Theorem', 'Unit 1', '{u1_continuity}'),
    ('u1_asymptotes', 'Asymptotes', 'Unit 1', '{u1_limit_notation}'),
    
    -- Unit 2: Differentiation Basics
    ('u2_derivative_definition', 'Derivative Definition', 'Unit 2', '{u1_limit_notation}'),
    ('u2_power_rule', 'Power Rule', 'Unit 2', '{u2_derivative_definition}'),
    ('u2_sum_diff_rule', 'Sum/Difference Rules', 'Unit 2', '{u2_power_rule}'),
    ('u2_product_rule', 'Product Rule', 'Unit 2', '{u2_power_rule}'),
    ('u2_quotient_rule', 'Quotient Rule', 'Unit 2', '{u2_product_rule}'),
    ('u2_trig_derivatives', 'Trigonometric Derivatives', 'Unit 2', '{u2_power_rule}'),
    ('u2_exp_log_derivatives', 'Exponential/Log Derivatives', 'Unit 2', '{u2_power_rule}'),
    
    -- Unit 3: Composite, Implicit, Inverse
    ('u3_chain_rule', 'Chain Rule', 'Unit 3', '{u2_power_rule}'),
    ('u3_implicit_diff', 'Implicit Differentiation', 'Unit 3', '{u3_chain_rule}'),
    ('u3_inverse_functions', 'Inverse Function Derivatives', 'Unit 3', '{u3_chain_rule}'),
    ('u3_inverse_trig', 'Inverse Trig Derivatives', 'Unit 3', '{u3_inverse_functions, u2_trig_derivatives}'),
    
    -- Unit 4: Contextual Applications
    ('u4_motion', 'Motion (Position/Velocity/Accel)', 'Unit 4', '{u2_derivative_definition}'),
    ('u4_related_rates', 'Related Rates', 'Unit 4', '{u3_implicit_diff}'),
    ('u4_linearization', 'Linearization', 'Unit 4', '{u2_derivative_definition}'),
    ('u4_lhopital', 'L''Hôpital''s Rule', 'Unit 4', '{u2_derivative_definition}'),
    
    -- Unit 5: Analytical Applications
    ('u5_mvt', 'Mean Value Theorem', 'Unit 5', '{u2_derivative_definition, u1_continuity}'),
    ('u5_extrema', 'Extreme Values', 'Unit 5', '{u2_derivative_definition}'),
    ('u5_first_deriv_test', 'First Derivative Test', 'Unit 5', '{u5_extrema}'),
    ('u5_second_deriv_test', 'Second Derivative Test', 'Unit 5', '{u5_first_deriv_test}'),
    ('u5_concavity', 'Concavity', 'Unit 5', '{u5_second_deriv_test}'),
    ('u5_optimization', 'Optimization', 'Unit 5', '{u5_extrema}'),
    
    -- Unit 6: Integration
    ('u6_riemann_sums', 'Riemann Sums', 'Unit 6', '{}'),
    ('u6_ftc1', 'FTC Part 1', 'Unit 6', '{u6_riemann_sums}'),
    ('u6_ftc2', 'FTC Part 2', 'Unit 6', '{u6_ftc1}'),
    ('u6_antiderivatives', 'Antiderivatives', 'Unit 6', '{}'),
    ('u6_u_substitution', 'U-Substitution', 'Unit 6', '{u6_antiderivatives, u3_chain_rule}'),
    
    -- Unit 7: Differential Equations
    ('u7_slope_fields', 'Slope Fields', 'Unit 7', '{u2_derivative_definition}'),
    ('u7_separation_variables', 'Separation of Variables', 'Unit 7', '{u6_antiderivatives}'),
    ('u7_exponential_models', 'Exponential Growth/Decay', 'Unit 7', '{u7_separation_variables}'),
    
    -- Unit 8: Applications of Integration
    ('u8_avg_value', 'Average Value', 'Unit 8', '{u6_ftc2}'),
    ('u8_area_between', 'Area Between Curves', 'Unit 8', '{u6_ftc2}'),
    ('u8_volumes_disk', 'Disk Method', 'Unit 8', '{u8_area_between}'),
    ('u8_volumes_washer', 'Washer Method', 'Unit 8', '{u8_volumes_disk}'),
    ('u8_volumes_cross', 'Cross Sections', 'Unit 8', '{u8_area_between}')
ON CONFLICT (id) DO NOTHING;


-- =====================================================
-- PART 9: SEED INITIAL ERROR TAGS
-- =====================================================

INSERT INTO public.error_tags (id, name, category, severity) VALUES
    ('ERR_ALG_SIGN', 'Sign Error (+/-)', 'procedural', 2),
    ('ERR_TRIG_VAL', 'Incorrect Trig Value', 'conceptual', 3),
    ('ERR_DERIV_RULE', 'Misapplied Derivative Rule', 'conceptual', 3),
    ('ERR_CHAIN_MISSING', 'Forgot Chain Rule', 'conceptual', 4),
    ('ERR_CHAIN_EXTRA', 'Unnecessary Chain Rule', 'conceptual', 3),
    ('ERR_PRODUCT_MISSING', 'Forgot Product Rule', 'conceptual', 4),
    ('ERR_QUOTIENT_FORM', 'Quotient Rule Formula Error', 'procedural', 3),
    ('ERR_CONCEPTUAL', 'Conceptual Misunderstanding', 'conceptual', 4),
    ('ERR_ARITHMETIC', 'Simple Arithmetic Error', 'procedural', 1),
    ('ERR_BOUNDS', 'Integration Bounds Error', 'procedural', 3),
    ('ERR_NOTATION', 'Notation Error', 'procedural', 2),
    ('ERR_UNITS', 'Unit Conversion Error', 'procedural', 2),
    ('ERR_LIMIT_FORM', 'Indeterminate Form Misidentified', 'conceptual', 3),
    ('ERR_CONTINUITY', 'Continuity Condition Error', 'conceptual', 4),
    ('ERR_DOMAIN', 'Domain Restriction Ignored', 'conceptual', 3),
    ('ERR_ANTIDERIV', 'Antiderivative Error', 'procedural', 3),
    ('ERR_READ_GRAPH', 'Misread Graph', 'procedural', 2),
    ('ERR_READ_TABLE', 'Misread Table', 'procedural', 2)
ON CONFLICT (id) DO NOTHING;


-- =====================================================
-- DONE! 完成!
-- =====================================================
-- Adaptive algorithm schema upgrade complete.
-- Frontend: No breaking changes. Existing question creation UI unchanged.
-- Algorithm: Read from questions + question_attempts + user_skill_mastery + question_skills + skills
