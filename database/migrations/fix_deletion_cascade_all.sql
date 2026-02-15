-- ==============================================================================
-- COMPREHENSIVE USER DELETION CASCADING FIX (ROBUST VERSION)
-- Purpose: Ensure that deleting a user from auth.users (or user_profiles)
--          automatically wipes ALL related data in the entire system.
--          Includes checks for table existence to prevent errors.
-- ==============================================================================

BEGIN;

-- 1. USER PROFILES (The Root)
-- Link: public.user_profiles.id -> auth.users.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_profiles') THEN
        ALTER TABLE public.user_profiles DROP CONSTRAINT IF EXISTS user_profiles_id_fkey;
        ALTER TABLE public.user_profiles 
            ADD CONSTRAINT user_profiles_id_fkey 
            FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- 2. ECONOMY (Points)
-- Link: public.user_points.user_id -> public.user_profiles.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_points') THEN
        ALTER TABLE public.user_points DROP CONSTRAINT IF EXISTS user_points_user_id_fkey;
        ALTER TABLE public.user_points 
            ADD CONSTRAINT user_points_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.points_ledger.user_id -> public.user_profiles.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'points_ledger') THEN
        ALTER TABLE public.points_ledger DROP CONSTRAINT IF EXISTS points_ledger_user_id_fkey;
        ALTER TABLE public.points_ledger 
            ADD CONSTRAINT points_ledger_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.pending_points.user_id -> public.user_profiles.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'pending_points') THEN
        ALTER TABLE public.pending_points DROP CONSTRAINT IF EXISTS pending_points_user_id_fkey;
        ALTER TABLE public.pending_points ADD CONSTRAINT pending_points_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;
    END IF;
END $$;


-- 3. PROGRESS & LEARNING
-- Link: public.question_attempts.user_id -> auth.users.id
-- Checking standard location.
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'question_attempts') THEN
        ALTER TABLE public.question_attempts DROP CONSTRAINT IF EXISTS question_attempts_user_id_fkey;
        ALTER TABLE public.question_attempts 
            ADD CONSTRAINT question_attempts_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.user_progress.user_id -> auth.users.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_progress') THEN
        ALTER TABLE public.user_progress DROP CONSTRAINT IF EXISTS user_progress_user_id_fkey;
        ALTER TABLE public.user_progress 
            ADD CONSTRAINT user_progress_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.user_section_progress.user_id -> auth.users.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_section_progress') THEN
        ALTER TABLE public.user_section_progress DROP CONSTRAINT IF EXISTS user_section_progress_user_id_fkey;
        ALTER TABLE public.user_section_progress 
            ADD CONSTRAINT user_section_progress_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.course_progress.user_id -> auth.users.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'course_progress') THEN
        ALTER TABLE public.course_progress DROP CONSTRAINT IF EXISTS course_progress_user_id_fkey;
        ALTER TABLE public.course_progress 
            ADD CONSTRAINT course_progress_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.user_question_state.user_id -> auth.users.id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_question_state') THEN
        ALTER TABLE public.user_question_state DROP CONSTRAINT IF EXISTS user_question_state_user_id_fkey;
        ALTER TABLE public.user_question_state 
            ADD CONSTRAINT user_question_state_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;


-- 4. DIAGNOSTICS (Attempt Errors)
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'attempt_errors') THEN
        ALTER TABLE public.attempt_errors DROP CONSTRAINT IF EXISTS attempt_errors_attempt_id_fkey;
        ALTER TABLE public.attempt_errors 
            ADD CONSTRAINT attempt_errors_attempt_id_fkey 
            FOREIGN KEY (attempt_id) REFERENCES public.question_attempts(id) ON DELETE CASCADE;
    END IF;
END $$;


-- 5. SOCIAL & FORUM
-- Link: public.friend_requests (Sender/Receiver)
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'friend_requests') THEN
        ALTER TABLE public.friend_requests DROP CONSTRAINT IF EXISTS friend_requests_sender_id_fkey;
        ALTER TABLE public.friend_requests 
            ADD CONSTRAINT friend_requests_sender_id_fkey 
            FOREIGN KEY (sender_id) REFERENCES auth.users(id) ON DELETE CASCADE;

        ALTER TABLE public.friend_requests DROP CONSTRAINT IF EXISTS friend_requests_receiver_id_fkey;
        ALTER TABLE public.friend_requests 
            ADD CONSTRAINT friend_requests_receiver_id_fkey 
            FOREIGN KEY (receiver_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.channel_members.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'channel_members') THEN
        ALTER TABLE public.channel_members DROP CONSTRAINT IF EXISTS channel_members_user_id_fkey;
        ALTER TABLE public.channel_members 
            ADD CONSTRAINT channel_members_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.forum_messages
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'forum_messages') THEN
        -- user_id (common)
        IF EXISTS (SELECT FROM information_schema.columns WHERE table_name = 'forum_messages' AND column_name = 'user_id') THEN
            ALTER TABLE public.forum_messages DROP CONSTRAINT IF EXISTS forum_messages_user_id_fkey;
            ALTER TABLE public.forum_messages ADD CONSTRAINT forum_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
        END IF;
        -- sender_id (alternative)
        IF EXISTS (SELECT FROM information_schema.columns WHERE table_name = 'forum_messages' AND column_name = 'sender_id') THEN
            ALTER TABLE public.forum_messages DROP CONSTRAINT IF EXISTS forum_messages_sender_id_fkey;
            ALTER TABLE public.forum_messages ADD CONSTRAINT forum_messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES auth.users(id) ON DELETE CASCADE;
        END IF;
    END IF;
END $$;


-- Link: public.message_reactions.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'message_reactions') THEN
        ALTER TABLE public.message_reactions DROP CONSTRAINT IF EXISTS message_reactions_user_id_fkey;
        ALTER TABLE public.message_reactions 
            ADD CONSTRAINT message_reactions_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;


-- 6. SYSTEM & NOTIFICATIONS
-- Link: public.notifications.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'notifications') THEN
        ALTER TABLE public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;
        ALTER TABLE public.notifications 
            ADD CONSTRAINT notifications_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.user_activities.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_activities') THEN
        ALTER TABLE public.user_activities DROP CONSTRAINT IF EXISTS user_activities_user_id_fkey;
        ALTER TABLE public.user_activities 
            ADD CONSTRAINT user_activities_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.user_stats.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_stats') THEN
        ALTER TABLE public.user_stats DROP CONSTRAINT IF EXISTS user_stats_user_id_fkey;
        ALTER TABLE public.user_stats 
            ADD CONSTRAINT user_stats_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Link: public.user_checkins.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_checkins') THEN
        ALTER TABLE public.user_checkins DROP CONSTRAINT IF EXISTS user_checkins_user_id_fkey;
        ALTER TABLE public.user_checkins 
            ADD CONSTRAINT user_checkins_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;
    END IF;
END $$;


-- 7. ACHIEVEMENTS
-- Link: public.user_titles.user_id
DO $$ BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'user_titles') THEN
        ALTER TABLE public.user_titles DROP CONSTRAINT IF EXISTS user_titles_user_id_fkey;
        ALTER TABLE public.user_titles 
            ADD CONSTRAINT user_titles_user_id_fkey 
            FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;


COMMIT;
