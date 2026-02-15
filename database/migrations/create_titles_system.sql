-- Encouragement Titles System
-- 1. Create Titles Definition Table
CREATE TABLE IF NOT EXISTS public.titles (
    id VARCHAR(50) PRIMARY KEY, -- slug: e.g. 'streak_1'
    name TEXT NOT NULL,
    description TEXT,
    category VARCHAR(20) CHECK (category IN ('streak', 'mastery_unit', 'mastery_course', 'social', 'influence')),
    threshold INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create User Titles (Unlocked)
CREATE TABLE IF NOT EXISTS public.user_titles (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title_id VARCHAR(50) REFERENCES public.titles(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, title_id)
);

-- 3. Add Equipped Title to User Profiles
ALTER TABLE public.user_profiles 
ADD COLUMN IF NOT EXISTS equipped_title_id VARCHAR(50) REFERENCES public.titles(id) ON DELETE SET NULL;

-- 4. Enable RLS
ALTER TABLE public.titles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_titles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view titles" ON public.titles;
CREATE POLICY "Anyone can view titles" ON public.titles FOR SELECT USING (true);

DROP POLICY IF EXISTS "Users can view own titles" ON public.user_titles;
CREATE POLICY "Users can view own titles" ON public.user_titles FOR SELECT USING (auth.uid() = user_id);

-- 5. Seed Titles
INSERT INTO public.titles (id, name, description, category, threshold) VALUES
    -- Streak Titles
    ('streak_1', 'Day 1 Explorer', 'Logged in for the first time.', 'streak', 1),
    ('streak_30', 'Monthly Consistent', 'Maintained a 30-day streak.', 'streak', 30),
    ('streak_90', 'Quarterly Scholar', 'Maintained a 90-day streak.', 'streak', 90),
    ('streak_365', '1-Year Veteran', 'Maintained a 1-year streak.', 'streak', 365),
    ('streak_730', '2-Year Veteran', 'Maintained a 2-year streak.', 'streak', 730),
    ('streak_1095', '3-Year Veteran', 'Maintained a 3-year streak.', 'streak', 1095),
    ('streak_1460', '4-Year Veteran', 'Maintained a 4-year streak.', 'streak', 1460),
    ('streak_1825', '5-Year Veteran', 'Maintained a 5-year streak.', 'streak', 1825),
    ('streak_2190', '6-Year Veteran', 'Maintained a 6-year streak.', 'streak', 2190),
    ('streak_2555', '7-Year Veteran', 'Maintained a 7-year streak.', 'streak', 2555),
    ('streak_2920', '8-Year Veteran', 'Maintained a 8-year streak.', 'streak', 2920),
    ('streak_3285', '9-Year Veteran', 'Maintained a 9-year streak.', 'streak', 3285),
    ('streak_3650', '10-Year Hall of Fame', 'Maintained a legendary 10-year streak.', 'streak', 3650),
    
    -- Mastery Titles
    ('mastery_unit', 'Unit Master', 'Achieved 100% mastery in any unit.', 'mastery_unit', 1),
    ('mastery_course', 'Course Conqueror', 'Complete 100% of a course syllabus.', 'mastery_course', 1),
    
    -- Social Titles
    ('friends_1', 'Social Initiate', 'Added your first friend.', 'social', 1),
    ('friends_10', 'Community Regular', 'Grown your network to 10 friends.', 'social', 10),
    ('friends_100', 'Network Expert', 'Connected with 100 scholars.', 'social', 100),
    
    -- Influence Titles (Members in created channels)
    ('influence_1', 'Rising Leader', 'Someone joined a channel you created.', 'influence', 1),
    ('influence_10', 'Gathering Power', '10 members joined your channels.', 'influence', 10),
    ('influence_100', 'Regional Influence', '100 members joined your channels.', 'influence', 100),
    ('influence_1000', 'Global Visionary', '1000 members joined your channels.', 'influence', 1000),
    ('influence_owner', 'Channel Owner', 'Created your own community.', 'influence', 0)
ON CONFLICT (id) DO UPDATE SET 
    name = EXCLUDED.name, 
    description = EXCLUDED.description, 
    category = EXCLUDED.category, 
    threshold = EXCLUDED.threshold;

-- 6. Helper Function: Unlock Titles
CREATE OR REPLACE FUNCTION public.check_and_unlock_titles(p_user_id UUID, p_category VARCHAR, p_value INTEGER)
RETURNS VOID AS $$
BEGIN
    INSERT INTO public.user_titles (user_id, title_id)
    SELECT p_user_id, t.id
    FROM public.titles t
    WHERE t.category = p_category AND p_value >= t.threshold
    ON CONFLICT (user_id, title_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. Trigger for Social Titles (Friends)
CREATE OR REPLACE FUNCTION public.handle_friend_title_update()
RETURNS TRIGGER AS $$
DECLARE
    f_count INTEGER;
BEGIN
    IF (NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status != 'accepted')) THEN
        -- Check for sender
        SELECT COUNT(*) INTO f_count FROM public.friend_requests 
        WHERE (sender_id = NEW.sender_id OR receiver_id = NEW.sender_id) AND status = 'accepted';
        PERFORM public.check_and_unlock_titles(NEW.sender_id, 'social', f_count);
        
        -- Check for receiver
        SELECT COUNT(*) INTO f_count FROM public.friend_requests 
        WHERE (sender_id = NEW.receiver_id OR receiver_id = NEW.receiver_id) AND status = 'accepted';
        PERFORM public.check_and_unlock_titles(NEW.receiver_id, 'social', f_count);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_friend_titles ON public.friend_requests;
CREATE TRIGGER trg_friend_titles
    AFTER UPDATE ON public.friend_requests
    FOR EACH ROW EXECUTE FUNCTION public.handle_friend_title_update();

-- 8. Trigger for Influence Titles (Channel Members)
CREATE OR REPLACE FUNCTION public.handle_influence_title_update()
RETURNS TRIGGER AS $$
DECLARE
    v_creator_id UUID;
    v_member_count INTEGER;
BEGIN
    -- Get the creator of the channel
    SELECT creator_id INTO v_creator_id FROM public.forum_channels WHERE id = NEW.channel_id;
    
    IF v_creator_id IS NOT NULL THEN
        -- Count total members in ALL channels created by this user
        SELECT COUNT(*) INTO v_member_count 
        FROM public.channel_members cm
        JOIN public.forum_channels fc ON fc.id = cm.channel_id
        WHERE fc.creator_id = v_creator_id;
        
        PERFORM public.check_and_unlock_titles(v_creator_id, 'influence', v_member_count);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_influence_titles ON public.channel_members;
CREATE TRIGGER trg_influence_titles
    AFTER INSERT OR DELETE ON public.channel_members
    FOR EACH ROW EXECUTE FUNCTION public.handle_influence_title_update();

-- 8b. Trigger for Channel Owner Title
CREATE OR REPLACE FUNCTION public.handle_channel_creation_title()
RETURNS TRIGGER AS $$
BEGIN
    -- Unlock "Channel Owner" title when someone creates their first channel
    IF NEW.creator_id IS NOT NULL THEN
        PERFORM public.check_and_unlock_titles(NEW.creator_id, 'influence', 0);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_channel_creation_titles ON public.forum_channels;
CREATE TRIGGER trg_channel_creation_titles
    AFTER INSERT ON public.forum_channels
    FOR EACH ROW EXECUTE FUNCTION public.handle_channel_creation_title();

-- 9. Trigger for Mastery Titles (Unit Completion)
CREATE OR REPLACE FUNCTION public.handle_mastery_title_update()
RETURNS TRIGGER AS $$
DECLARE
    v_topic_id VARCHAR;
    v_total_sections INTEGER;
    v_completed_sections INTEGER;
BEGIN
    IF (NEW.status = 'completed') THEN
        SELECT topic_id INTO v_topic_id FROM public.sections WHERE id = NEW.section_id;
        
        IF v_topic_id IS NOT NULL THEN
            SELECT COUNT(*) INTO v_total_sections FROM public.sections WHERE topic_id = v_topic_id;
            SELECT COUNT(DISTINCT sp.section_id) INTO v_completed_sections 
            FROM public.user_section_progress sp
            JOIN public.sections s ON s.id = sp.section_id
            WHERE sp.user_id = NEW.user_id AND sp.status = 'completed' AND s.topic_id = v_topic_id;
            
            IF v_completed_sections >= v_total_sections AND v_total_sections > 0 THEN
                -- Extract unit number from topic_id (e.g., 'U1' -> 1, 'U10' -> 10)
                PERFORM public.check_and_unlock_titles(NEW.user_id, 'mastery_unit', CAST(SUBSTRING(v_topic_id FROM '[0-9]+') AS INTEGER));
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_unit_mastery_titles ON public.user_section_progress;
CREATE TRIGGER trg_unit_mastery_titles
    AFTER INSERT OR UPDATE ON public.user_section_progress
    FOR EACH ROW EXECUTE FUNCTION public.handle_mastery_title_update();

-- 10. Trigger for Course Mastery Titles
CREATE OR REPLACE FUNCTION public.handle_course_mastery_title_update()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.status = 'Completed') THEN
        -- Unlock AB (1) or BC (2) title based on course name
        IF NEW.course_name = 'AP Calculus AB' THEN
            PERFORM public.check_and_unlock_titles(NEW.user_id, 'mastery_course', 1);
        ELSIF NEW.course_name = 'AP Calculus BC' THEN
            PERFORM public.check_and_unlock_titles(NEW.user_id, 'mastery_course', 2);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_course_mastery_titles ON public.course_progress;
CREATE TRIGGER trg_course_mastery_titles
    AFTER INSERT OR UPDATE ON public.course_progress
    FOR EACH ROW EXECUTE FUNCTION public.handle_course_mastery_title_update();
