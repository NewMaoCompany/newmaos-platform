-- =====================================================
-- COMPLETE QUESTIONS TABLE SCHEMA FIX
-- Run this in Supabase SQL Editor to add ALL missing columns
-- =====================================================

-- 1. Core question fields
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS topic_id TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS sub_topic_id TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS section_id TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS title TEXT DEFAULT 'Question';
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS prompt_type TEXT DEFAULT 'text';
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS version INTEGER DEFAULT 1;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS created_by UUID REFERENCES auth.users(id);
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- 2. Metadata fields
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS source TEXT DEFAULT 'self';
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS source_year INTEGER;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS notes TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'draft';

-- 3. Algorithm weights
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS weight_primary NUMERIC(5,2) DEFAULT 1.0;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS weight_supporting NUMERIC(5,2) DEFAULT 0.5;

-- 4. Content fields (if not exist)
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS prompt TEXT DEFAULT '';
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS latex TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS explanation TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS options JSONB DEFAULT '[]'::jsonb;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS correct_option_id TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS tolerance NUMERIC;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS micro_explanations JSONB;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS recommendation_reasons JSONB;

-- 5. Cache/legacy fields
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS skill_tags TEXT[];
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS error_tags TEXT[];

-- 6. Standard fields
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS course TEXT DEFAULT 'Both';
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS topic TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS type TEXT DEFAULT 'MCQ';
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS calculator_allowed BOOLEAN DEFAULT false;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS difficulty INTEGER DEFAULT 2;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS target_time_seconds INTEGER DEFAULT 120;

-- 7. Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_questions_topic_id ON public.questions(topic_id);
CREATE INDEX IF NOT EXISTS idx_questions_section_id ON public.questions(section_id);
CREATE INDEX IF NOT EXISTS idx_questions_status ON public.questions(status);
CREATE INDEX IF NOT EXISTS idx_questions_created_by ON public.questions(created_by);

-- 8. Disable RLS for development (enable in production)
ALTER TABLE public.questions DISABLE ROW LEVEL SECURITY;

-- Done! After running this, save should work.
