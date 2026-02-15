-- Add reply_to_id column to forum_messages for threaded replies
ALTER TABLE public.forum_messages
ADD COLUMN IF NOT EXISTS reply_to_id UUID REFERENCES public.forum_messages(id) ON DELETE CASCADE;

-- Add index for performance
CREATE INDEX IF NOT EXISTS idx_forum_messages_reply_to_id ON public.forum_messages(reply_to_id);
