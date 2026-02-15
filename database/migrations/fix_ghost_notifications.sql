-- ============================================================
-- FIX GHOST NOTIFICATIONS TRIGGER
-- Cleans up "Friend Request" and "Friend Accepted" notifications
-- when a friend_requests record is deleted (rejected or removed)
-- ============================================================

CREATE OR REPLACE FUNCTION public.cleanup_friend_notifications()
RETURNS TRIGGER AS $$
BEGIN
    -- 1. Clean up "Friend Request" notifications (sent to Receiver)
    -- Link format: '/forum?action=friend_request&sender_id=UID'
    DELETE FROM public.notifications
    WHERE user_id = OLD.receiver_id
      AND (
          link LIKE '%action=friend_request&sender_id=' || OLD.sender_id || '%'
          OR
          -- Also matches strict exact links if any
          link = '/forum?action=friend_request&sender_id=' || OLD.sender_id
      );

    -- 2. Clean up "Friend Accepted" notifications (sent to Sender)
    -- Link format: '/forum?action=friend_accepted&friend_id=UID'
    DELETE FROM public.notifications
    WHERE user_id = OLD.sender_id
      AND (
          link LIKE '%action=friend_accepted&friend_id=' || OLD.receiver_id || '%'
          OR
          link = '/forum?action=friend_accepted&friend_id=' || OLD.receiver_id
      );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Bind Trigger
DROP TRIGGER IF EXISTS on_friend_request_deleted ON public.friend_requests;
CREATE TRIGGER on_friend_request_deleted
    BEFORE DELETE ON public.friend_requests
    FOR EACH ROW EXECUTE FUNCTION public.cleanup_friend_notifications();
