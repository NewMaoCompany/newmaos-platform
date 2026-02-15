-- Migration: Add question_id to forum_messages
-- Description: Enables associating forum messages with specific practice questions.

-- 1. Add question_id column
ALTER TABLE public.forum_messages 
ADD COLUMN IF NOT EXISTS question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE;

-- 2. Create index for performance
CREATE INDEX IF NOT EXISTS idx_forum_messages_question_id ON public.forum_messages(question_id);

-- 3. Update RLS (optional, existing policies based on user_id/channel_id should still work, 
-- but ensuring question_id doesn't break visibility)
-- No changes needed to existing SELECT policies as they are usually public for these tables.
