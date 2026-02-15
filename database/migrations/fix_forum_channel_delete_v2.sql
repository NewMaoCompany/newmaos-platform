-- ==============================================================================
-- FIX: Forum Channel Deletion + Member Notification
-- 1. Add DELETE RLS policy so channel creators can delete their own channels
-- 2. Add INSERT policy so authenticated users can create channels
-- 3. Add trigger to notify all channel members before deletion
-- ==============================================================================

-- ============================================
-- PART 1: RLS Policies for forum_channels
-- ============================================

-- Allow channel creators to delete their own channels
DROP POLICY IF EXISTS "Creators can delete own channels" ON public.forum_channels;
CREATE POLICY "Creators can delete own channels"
ON public.forum_channels
FOR DELETE
USING (auth.uid() = creator_id);

-- Allow authenticated users to insert channels
DROP POLICY IF EXISTS "Auth users can create channels" ON public.forum_channels;
CREATE POLICY "Auth users can create channels"
ON public.forum_channels
FOR INSERT
WITH CHECK (auth.uid() IS NOT NULL);

-- ============================================
-- PART 2: Trigger to notify members on channel deletion
-- ============================================

CREATE OR REPLACE FUNCTION public.notify_members_on_channel_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Insert a notification for each member of the deleted channel
    INSERT INTO public.notifications (user_id, type, title, message, link, metadata, created_at)
    SELECT
        cm.user_id,
        'system',
        'Channel Deleted',
        'The channel "' || OLD.name || '" has been deleted by its owner.',
        '/forum',
        jsonb_build_object('channel_name', OLD.name, 'channel_id', OLD.id),
        NOW()
    FROM public.channel_members cm
    WHERE cm.channel_id = OLD.id
      AND cm.user_id != OLD.creator_id; -- Don't notify the deleter

    RETURN OLD;
END;
$$;

-- Create the trigger (BEFORE DELETE so channel_members still exist)
DROP TRIGGER IF EXISTS trg_notify_members_on_channel_delete ON public.forum_channels;
CREATE TRIGGER trg_notify_members_on_channel_delete
BEFORE DELETE ON public.forum_channels
FOR EACH ROW
EXECUTE FUNCTION public.notify_members_on_channel_delete();
