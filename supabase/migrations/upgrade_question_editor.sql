-- Add new metadata fields to questions table
ALTER TABLE questions 
ADD COLUMN IF NOT EXISTS source text DEFAULT 'self',
ADD COLUMN IF NOT EXISTS source_year integer,
ADD COLUMN IF NOT EXISTS notes text,
ADD COLUMN IF NOT EXISTS weight_primary float DEFAULT 1.0,
ADD COLUMN IF NOT EXISTS weight_supporting float DEFAULT 0.5;

-- Create table for linking questions to error patterns (common wrong reasons)
CREATE TABLE IF NOT EXISTS question_error_patterns (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    question_id uuid REFERENCES questions(id) ON DELETE CASCADE NOT NULL,
    error_tag_id text NOT NULL, -- using text ID from error_tags dictionary
    description text, -- optional context for why this error applies here
    created_at timestamptz DEFAULT now()
);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_question_error_patterns_question ON question_error_patterns(question_id);

-- RLS for question_error_patterns
ALTER TABLE question_error_patterns ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access" ON question_error_patterns
    FOR SELECT TO public USING (true);

CREATE POLICY "Creators can insert/update/delete" ON question_error_patterns
    FOR ALL TO authenticated USING (
        EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND is_creator = true)
    );

-- Create table for immutable question versions
CREATE TABLE IF NOT EXISTS question_versions (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    question_id uuid REFERENCES questions(id) ON DELETE CASCADE NOT NULL,
    version integer NOT NULL,
    data jsonb NOT NULL, -- snapshot of the full question data
    created_at timestamptz DEFAULT now(),
    created_by uuid REFERENCES auth.users(id)
);

CREATE INDEX IF NOT EXISTS idx_question_versions_question ON question_versions(question_id);
ALTER TABLE question_versions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Creators can view versions" ON question_versions
    FOR SELECT TO authenticated USING (
        EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND is_creator = true)
    );
