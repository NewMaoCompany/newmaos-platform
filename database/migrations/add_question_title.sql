-- Add title column to questions table
ALTER TABLE questions ADD COLUMN IF NOT EXISTS title text NOT NULL DEFAULT 'Question';

-- Update existing questions to have a default title based on their ID suffix if needed, 
-- but default 'Question' is fine for now as user will update them.
