-- ==============================================================================
-- FIX: ADD ON DELETE CASCADE TO FOREIGN KEYS
-- Purpose: Allow deleting users from Supabase Dashboard (auth.users)
-- by strictly enforcing cascading deletes on related tables.
-- ==============================================================================

-- 1. FIX DIRECT DEPENDENCIES ON user_profiles
-- These must be handled because user_profiles will be deleted when auth.users is deleted.

-- 1.1 Direct Chat Participants (Remove user from chats)
ALTER TABLE public.direct_chat_participants
DROP CONSTRAINT IF EXISTS direct_chat_participants_user_id_fkey;

ALTER TABLE public.direct_chat_participants
ADD CONSTRAINT direct_chat_participants_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE CASCADE;

-- 1.2 Direct Messages (Keep messages but set user to NULL, or CASCADE - usually safe to keep for recipient)
-- Decision: SET NULL to preserve chat history for the other person
ALTER TABLE public.direct_messages
DROP CONSTRAINT IF EXISTS direct_messages_user_id_fkey;

ALTER TABLE public.direct_messages
ADD CONSTRAINT direct_messages_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE SET NULL;

-- 1.3 Forum Messages (Keep posts but set user to NULL)
ALTER TABLE public.forum_messages
DROP CONSTRAINT IF EXISTS forum_messages_user_id_fkey;

ALTER TABLE public.forum_messages
ADD CONSTRAINT forum_messages_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
ON DELETE SET NULL;


-- 2. FIX DIRECT DEPENDENCIES ON auth.users
-- These existing tables blocked deletion.

-- 2.1 User Profiles (The main profile table)
ALTER TABLE public.user_profiles
DROP CONSTRAINT IF EXISTS user_profiles_id_fkey;

ALTER TABLE public.user_profiles
ADD CONSTRAINT user_profiles_id_fkey
FOREIGN KEY (id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.2 Activities (User logs)
ALTER TABLE public.activities
DROP CONSTRAINT IF EXISTS activities_user_id_fkey;

ALTER TABLE public.activities
ADD CONSTRAINT activities_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.3 Course Progress
ALTER TABLE public.course_progress
DROP CONSTRAINT IF EXISTS course_progress_user_id_fkey;

ALTER TABLE public.course_progress
ADD CONSTRAINT course_progress_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.4 Notifications
ALTER TABLE public.notifications
DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;

ALTER TABLE public.notifications
ADD CONSTRAINT notifications_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.5 Question Attempts (User history)
ALTER TABLE public.question_attempts
DROP CONSTRAINT IF EXISTS question_attempts_user_id_fkey;

ALTER TABLE public.question_attempts
ADD CONSTRAINT question_attempts_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.6 Recommendations
ALTER TABLE public.recommendations
DROP CONSTRAINT IF EXISTS recommendations_user_id_fkey;

ALTER TABLE public.recommendations
ADD CONSTRAINT recommendations_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.7 Unit Mastery (Note: constraint name is topic_mastery_user_id_fkey in schema.sql)
ALTER TABLE public.unit_mastery
DROP CONSTRAINT IF EXISTS topic_mastery_user_id_fkey;

ALTER TABLE public.unit_mastery
ADD CONSTRAINT topic_mastery_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.8 User Question State
ALTER TABLE public.user_question_state
DROP CONSTRAINT IF EXISTS user_question_state_user_id_fkey;

ALTER TABLE public.user_question_state
ADD CONSTRAINT user_question_state_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.9 User Section Progress
ALTER TABLE public.user_section_progress
DROP CONSTRAINT IF EXISTS user_section_progress_user_id_fkey;

ALTER TABLE public.user_section_progress
ADD CONSTRAINT user_section_progress_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.10 User Skill Mastery
ALTER TABLE public.user_skill_mastery
DROP CONSTRAINT IF EXISTS user_skill_mastery_user_id_fkey;

ALTER TABLE public.user_skill_mastery
ADD CONSTRAINT user_skill_mastery_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.11 User Stats
ALTER TABLE public.user_stats
DROP CONSTRAINT IF EXISTS user_stats_user_id_fkey;

ALTER TABLE public.user_stats
ADD CONSTRAINT user_stats_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 2.12 Questions Created By (Don't delete questions, strict SET NULL)
ALTER TABLE public.questions
DROP CONSTRAINT IF EXISTS questions_created_by_fkey;

ALTER TABLE public.questions
ADD CONSTRAINT questions_created_by_fkey
FOREIGN KEY (created_by) REFERENCES auth.users(id)
ON DELETE SET NULL;
