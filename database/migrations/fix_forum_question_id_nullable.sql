-- Fix: forum_messages.question_id should be nullable
-- Forum channel messages don't have a question_id (only discussion comments do)
-- The fix_forum_fk.sql incorrectly set it as NOT NULL

ALTER TABLE public.forum_messages ALTER COLUMN question_id DROP NOT NULL;

-- Also change type from TEXT to UUID if needed for consistency with questions.id
-- ALTER TABLE public.forum_messages ALTER COLUMN question_id TYPE UUID USING question_id::uuid;
