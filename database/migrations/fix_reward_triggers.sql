-- Fix Missing Triggers for the Pending Points System
-- Ensures that the triggers are properly attached to their respective tables.

-- 1. Like Points Trigger
DROP TRIGGER IF EXISTS trigger_award_like_points ON public.message_reactions;
CREATE TRIGGER trigger_award_like_points
    AFTER INSERT ON public.message_reactions
    FOR EACH ROW
    EXECUTE FUNCTION award_like_points();

-- 2. Comment Points Trigger
DROP TRIGGER IF EXISTS trigger_award_comment_points ON public.forum_messages;
CREATE TRIGGER trigger_award_comment_points
    AFTER INSERT ON public.forum_messages
    FOR EACH ROW
    EXECUTE FUNCTION award_comment_points();

-- 3. Friend Points Trigger
DROP TRIGGER IF EXISTS trigger_award_friend_points ON public.friend_requests;
CREATE TRIGGER trigger_award_friend_points
    AFTER UPDATE ON public.friend_requests
    FOR EACH ROW
    EXECUTE FUNCTION award_friend_points();

-- Also ensure the functions are SECURITY DEFINER so they can bypass RLS on pending_points
ALTER FUNCTION award_like_points() SECURITY DEFINER;
ALTER FUNCTION award_comment_points() SECURITY DEFINER;
ALTER FUNCTION award_friend_points() SECURITY DEFINER;
