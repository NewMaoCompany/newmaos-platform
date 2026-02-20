-- Pro Achievement System Migration
-- Adds: is_notified flag, new title categories (questions, posts),
-- question/post triggers, RPCs for notification queue, analysis squash.

-- ============================================================
-- 1. ADD is_notified COLUMN TO user_titles
-- ============================================================
ALTER TABLE public.user_titles 
ADD COLUMN IF NOT EXISTS is_notified BOOLEAN DEFAULT FALSE;

-- ============================================================
-- 2. EXPAND CATEGORY CHECK CONSTRAINT ON titles
-- ============================================================
DO $$
BEGIN
    ALTER TABLE public.titles DROP CONSTRAINT IF EXISTS titles_category_check;
    ALTER TABLE public.titles ADD CONSTRAINT titles_category_check 
        CHECK (category IN ('streak', 'mastery_unit', 'mastery_course', 'social', 'influence', 'seniority', 'questions', 'posts'));
END $$;

-- ============================================================
-- 3. SEED NEW TITLES (Questions Solved & Forum Posts)
-- ============================================================
INSERT INTO public.titles (id, name, description, category, threshold) VALUES
    -- Questions Solved Titles
    ('questions_1',    'First Answer',        'Answered your first question correctly.',         'questions', 1),
    ('questions_10',   'Quick Learner',       'Correctly answered 10 questions.',                'questions', 10),
    ('questions_50',   'Problem Solver',      'Correctly answered 50 questions.',                'questions', 50),
    ('questions_100',  'Century Scholar',     'Correctly answered 100 questions.',               'questions', 100),
    ('questions_500',  'Knowledge Machine',   'Correctly answered 500 questions.',               'questions', 500),
    ('questions_1000', 'Calculus Prodigy',    'Correctly answered 1000 questions.',              'questions', 1000),

    -- Forum Posts Titles
    ('posts_1',   'First Post',       'Published your first forum message.',            'posts', 1),
    ('posts_10',  'Active Voice',     'Published 10 forum messages.',                   'posts', 10),
    ('posts_50',  'Discussion Leader','Published 50 forum messages.',                   'posts', 50),
    ('posts_100', 'Forum Veteran',    'Published 100 forum messages.',                  'posts', 100),
    ('posts_500', 'Community Pillar', 'Published 500 forum messages.',                  'posts', 500)
ON CONFLICT (id) DO UPDATE SET 
    name = EXCLUDED.name, 
    description = EXCLUDED.description, 
    category = EXCLUDED.category, 
    threshold = EXCLUDED.threshold;

-- ============================================================
-- 4. TRIGGER: Question Attempts -> Unlock "questions" Titles
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_question_title_update()
RETURNS TRIGGER AS $$
DECLARE
    v_correct_count INTEGER;
BEGIN
    -- Only fire when the attempt is correct
    IF NEW.is_correct = TRUE THEN
        SELECT COUNT(*) INTO v_correct_count 
        FROM public.question_attempts 
        WHERE user_id = NEW.user_id AND is_correct = TRUE;

        PERFORM public.check_and_unlock_titles(NEW.user_id, 'questions', v_correct_count);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_question_titles ON public.question_attempts;
CREATE TRIGGER trg_question_titles
    AFTER INSERT ON public.question_attempts
    FOR EACH ROW EXECUTE FUNCTION public.handle_question_title_update();

-- ============================================================
-- 5. TRIGGER: Forum Messages -> Unlock "posts" Titles
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_post_title_update()
RETURNS TRIGGER AS $$
DECLARE
    v_post_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_post_count 
    FROM public.forum_messages 
    WHERE user_id = NEW.user_id;

    PERFORM public.check_and_unlock_titles(NEW.user_id, 'posts', v_post_count);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_post_titles ON public.forum_messages;
CREATE TRIGGER trg_post_titles
    AFTER INSERT ON public.forum_messages
    FOR EACH ROW EXECUTE FUNCTION public.handle_post_title_update();

-- ============================================================
-- 6. RPC: Get Unnotified Titles (for popup queue)
-- ============================================================
CREATE OR REPLACE FUNCTION public.get_unnotified_titles(p_user_id UUID)
RETURNS TABLE (
    title_id VARCHAR,
    title_name TEXT,
    title_description TEXT,
    title_category VARCHAR,
    unlocked_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ut.title_id,
        t.name,
        t.description,
        t.category,
        ut.unlocked_at
    FROM public.user_titles ut
    JOIN public.titles t ON t.id = ut.title_id
    WHERE ut.user_id = p_user_id 
      AND ut.is_notified = FALSE
    ORDER BY ut.unlocked_at ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 7. RPC: Mark Title as Notified (after popup shown)
-- ============================================================
CREATE OR REPLACE FUNCTION public.mark_title_notified(p_user_id UUID, p_title_id VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE public.user_titles
    SET is_notified = TRUE
    WHERE user_id = p_user_id AND title_id = p_title_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 8. RPC: Squash Analysis Notifications
-- Keeps only the single most recent unread analysis notification
-- per category prefix. Called on Pro upgrade/login to prevent flood.
-- ============================================================
CREATE OR REPLACE FUNCTION public.squash_analysis_notifications(p_user_id UUID)
RETURNS VOID AS $$
DECLARE
    v_prefix TEXT;
    v_prefixes TEXT[] := ARRAY[
        '[Analysis - Accuracy]',
        '[Analysis - Solved]',
        '[Analysis - Time]',
        '[Analysis - Streak]'
    ];
    v_keep_id INTEGER;
BEGIN
    FOREACH v_prefix IN ARRAY v_prefixes LOOP
        -- Find the most recent one to KEEP
        SELECT id INTO v_keep_id
        FROM public.notifications
        WHERE user_id = p_user_id 
          AND unread = TRUE
          AND text LIKE v_prefix || '%'
        ORDER BY created_at DESC
        LIMIT 1;

        -- Mark all OTHERS as read (not the latest one)
        IF v_keep_id IS NOT NULL THEN
            UPDATE public.notifications
            SET unread = FALSE
            WHERE user_id = p_user_id
              AND unread = TRUE
              AND text LIKE v_prefix || '%'
              AND id != v_keep_id;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 9. BACKFILL: Mark all EXISTING user_titles as notified
-- so old users don't get flooded with popups for past unlocks.
-- ============================================================
UPDATE public.user_titles SET is_notified = TRUE WHERE is_notified = FALSE;

-- ============================================================
-- 10. RLS: Allow users to call mark_title_notified on own rows
-- ============================================================
DROP POLICY IF EXISTS "Users can update own title notification" ON public.user_titles;
CREATE POLICY "Users can update own title notification" ON public.user_titles 
    FOR UPDATE USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
