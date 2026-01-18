-- =====================================================
-- SCHEMA ALIGNMENT MIGRATION
-- Aligns database with Question Editor Backend Logic
-- =====================================================

-- 1. Add missing metadata columns to questions table
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS source VARCHAR(50) DEFAULT 'self',
ADD COLUMN IF NOT EXISTS source_year INTEGER,
ADD COLUMN IF NOT EXISTS notes TEXT,
ADD COLUMN IF NOT EXISTS weight_primary NUMERIC(3,2) DEFAULT 1.0,
ADD COLUMN IF NOT EXISTS weight_supporting NUMERIC(3,2) DEFAULT 0.5,
ADD COLUMN IF NOT EXISTS error_tags TEXT[] DEFAULT '{}',
ADD COLUMN IF NOT EXISTS prompt_type VARCHAR(10) DEFAULT 'text';

-- 2. Create question_versions table
CREATE TABLE IF NOT EXISTS public.question_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    version INTEGER NOT NULL,
    data JSONB NOT NULL, -- Snapshot of the question data
    created_at TIMESTAMPTZ DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL
);

-- Enable RLS for versions
ALTER TABLE public.question_versions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Creators can view versions" ON public.question_versions
    FOR SELECT USING (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );

CREATE POLICY "Creators can insert versions" ON public.question_versions
    FOR INSERT WITH CHECK (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );


-- 3. Create question_error_patterns table (Question <-> ErrorTag Many-to-Many)
CREATE TABLE IF NOT EXISTS public.question_error_patterns (
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    error_tag_id VARCHAR(50) REFERENCES public.error_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (question_id, error_tag_id)
);

-- Enable RLS for error patterns
ALTER TABLE public.question_error_patterns ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Everyone can read question error patterns" ON public.question_error_patterns
    FOR SELECT USING (true);

CREATE POLICY "Creators can manage question error patterns" ON public.question_error_patterns
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
    );

-- 4. Ensure section_id exists (Redundant safety check from add_section_fk.sql)
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS section_id TEXT;
CREATE INDEX IF NOT EXISTS idx_questions_section_id ON public.questions(topic_id, section_id);

-- 5. Add GIN index for error_tags array search
CREATE INDEX IF NOT EXISTS idx_questions_error_tags ON public.questions USING GIN (error_tags);

-- Done
