-- =====================================================
-- FIX DM REPLIES
-- 1. Add reply_to_id to direct_messages
-- =====================================================

ALTER TABLE public.direct_messages
ADD COLUMN IF NOT EXISTS reply_to_id UUID REFERENCES public.direct_messages(id) ON DELETE SET NULL;
