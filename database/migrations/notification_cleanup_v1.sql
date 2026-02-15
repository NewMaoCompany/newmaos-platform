-- Phase 23: Notification Read Status & Auto-Cleanup
-- 1. Add read_at column to track when a notification was viewed
ALTER TABLE public.notifications 
ADD COLUMN IF NOT EXISTS read_at TIMESTAMPTZ;

-- 2. Create trigger to automatically set read_at when unread becomes false
CREATE OR REPLACE FUNCTION public.handle_notification_read_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    -- If unread is changing from true to false, set read_at
    IF (OLD.unread = true AND NEW.unread = false) THEN
        NEW.read_at := NOW();
    -- If marked back as unread, clear read_at
    ELSIF (OLD.unread = false AND NEW.unread = true) THEN
        NEW.read_at := NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS on_notification_read ON public.notifications;
CREATE TRIGGER on_notification_read
    BEFORE UPDATE ON public.notifications
    FOR EACH ROW
    WHEN (OLD.unread IS DISTINCT FROM NEW.unread)
    EXECUTE FUNCTION public.handle_notification_read_timestamp();

-- 3. RPC to cleanup notifications read more than 3 days ago
CREATE OR REPLACE FUNCTION public.cleanup_read_notifications()
RETURNS void AS $$
BEGIN
    DELETE FROM public.notifications
    WHERE unread = false 
    AND read_at < (NOW() - INTERVAL '3 days');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
