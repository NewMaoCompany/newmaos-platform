-- ============================================
-- ADD SECTION_ID TO QUESTIONS
-- Enables strict foreign key relationship between questions and sections
-- ============================================

-- 1. Add section_id column if not exists
ALTER TABLE questions ADD COLUMN IF NOT EXISTS section_id TEXT;

-- 2. Migrate existing data from sub_topic_id (which stores the section ID like '1.1')
UPDATE questions 
SET section_id = sub_topic_id 
WHERE section_id IS NULL AND sub_topic_id IS NOT NULL;

-- 3. Add Composite Foreign Key Constraint
-- Validates that (topic_id, section_id) exists in sections table
-- This ensures the section actually belongs to the specified topic
ALTER TABLE questions
DROP CONSTRAINT IF EXISTS fk_questions_section;

ALTER TABLE questions
ADD CONSTRAINT fk_questions_section
FOREIGN KEY (topic_id, section_id)
REFERENCES sections (topic_id, id)
ON DELETE SET NULL;

-- 4. Create Index for performance
CREATE INDEX IF NOT EXISTS idx_questions_section_id 
ON questions(topic_id, section_id);
