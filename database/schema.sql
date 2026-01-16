-- =====================================================
-- NewMaoS AP Calculus Mastery - Database Schema
-- Supabase PostgreSQL
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- TABLES
-- =====================================================

-- Users profile table (extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.user_profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  name VARCHAR(255),
  avatar_url TEXT,
  current_course VARCHAR(10) DEFAULT 'AB',
  problems_solved INTEGER DEFAULT 0,
  study_hours JSONB DEFAULT '[0,0,0,0,0,0,0]'::jsonb,
  streak_days INTEGER DEFAULT 0,
  percentile INTEGER DEFAULT 0,
  email_notifications BOOLEAN DEFAULT true,
  sound_effects BOOLEAN DEFAULT false,
  is_creator BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Questions table
CREATE TABLE IF NOT EXISTS public.questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  course VARCHAR(10) NOT NULL CHECK (course IN ('AB', 'BC', 'Both')),
  topic VARCHAR(100) NOT NULL,
  sub_topic_id VARCHAR(20),
  type VARCHAR(10) NOT NULL CHECK (type IN ('MCQ', 'Numeric', 'FRQ')),
  calculator_allowed BOOLEAN DEFAULT false,
  difficulty INTEGER DEFAULT 3 CHECK (difficulty BETWEEN 1 AND 5),
  target_time_seconds INTEGER DEFAULT 90,
  skill_tags TEXT[] DEFAULT '{}',
  error_tags TEXT[] DEFAULT '{}',
  prompt TEXT NOT NULL,
  latex TEXT,
  options JSONB DEFAULT '[]'::jsonb,
  correct_option_id VARCHAR(100),
  tolerance NUMERIC(10,4),
  explanation TEXT,
  micro_explanations JSONB,
  recommendation_reasons TEXT[] DEFAULT '{}',
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Topic mastery (radar data equivalent)
CREATE TABLE IF NOT EXISTS public.topic_mastery (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  subject VARCHAR(100) NOT NULL,
  mastery_score INTEGER DEFAULT 0 CHECK (mastery_score BETWEEN 0 AND 100),
  full_mark INTEGER DEFAULT 100,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, subject)
);

-- Activities
CREATE TABLE IF NOT EXISTS public.activities (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type VARCHAR(20) NOT NULL CHECK (type IN ('quiz', 'practice', 'mastery')),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  score INTEGER CHECK (score IS NULL OR (score BETWEEN 0 AND 100)),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Notifications
CREATE TABLE IF NOT EXISTS public.notifications (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  text TEXT NOT NULL,
  link VARCHAR(255) DEFAULT '/dashboard',
  unread BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Course progress
CREATE TABLE IF NOT EXISTS public.course_progress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  course_id VARCHAR(10) NOT NULL CHECK (course_id IN ('AB', 'BC')),
  status VARCHAR(20) DEFAULT 'Not Started' CHECK (status IN ('Not Started', 'In Progress', 'Paused', 'Completed')),
  current_module_index INTEGER DEFAULT 0,
  modules JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, course_id)
);

-- Topic content (editable content)
CREATE TABLE IF NOT EXISTS public.topic_content (
  id VARCHAR(50) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  sub_topics JSONB DEFAULT '[]'::jsonb,
  unit_test JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_questions_course ON public.questions(course);
CREATE INDEX IF NOT EXISTS idx_questions_topic ON public.questions(topic);
CREATE INDEX IF NOT EXISTS idx_questions_sub_topic ON public.questions(sub_topic_id);
CREATE INDEX IF NOT EXISTS idx_topic_mastery_user ON public.topic_mastery(user_id);
CREATE INDEX IF NOT EXISTS idx_activities_user ON public.activities(user_id);
CREATE INDEX IF NOT EXISTS idx_activities_created ON public.activities(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_notifications_user ON public.notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_unread ON public.notifications(user_id, unread);
CREATE INDEX IF NOT EXISTS idx_course_progress_user ON public.course_progress(user_id);

-- =====================================================
-- ROW LEVEL SECURITY
-- =====================================================

ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topic_mastery ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.course_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topic_content ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- POLICIES
-- =====================================================

-- User Profiles
CREATE POLICY "Users can view own profile" ON public.user_profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.user_profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.user_profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Topic Mastery
CREATE POLICY "Users can view own mastery" ON public.topic_mastery
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can manage own mastery" ON public.topic_mastery
  FOR ALL USING (auth.uid() = user_id);

-- Activities
CREATE POLICY "Users can view own activities" ON public.activities
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own activities" ON public.activities
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Notifications
CREATE POLICY "Users can view own notifications" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update own notifications" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "System can insert notifications" ON public.notifications
  FOR INSERT WITH CHECK (true);

-- Course Progress
CREATE POLICY "Users can manage own course progress" ON public.course_progress
  FOR ALL USING (auth.uid() = user_id);

-- Questions (public read, creator write)
CREATE POLICY "Anyone can view questions" ON public.questions
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Creators can insert questions" ON public.questions
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

CREATE POLICY "Creators can update questions" ON public.questions
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

CREATE POLICY "Creators can delete questions" ON public.questions
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

-- Topic Content (public read, creator write)
CREATE POLICY "Anyone can view topic content" ON public.topic_content
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Creators can manage topic content" ON public.topic_content
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

-- =====================================================
-- FUNCTIONS
-- =====================================================

-- Function to create user profile after signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    CONCAT('https://ui-avatars.com/api/?name=', COALESCE(NEW.raw_user_meta_data->>'name', 'User'), '&background=f9d406&color=1c1a0d&bold=true')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new user
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =====================================================
-- Initial Data
-- =====================================================

-- Note: Run the seed endpoint (/api/content/seed) after setting up
-- to populate initial topic content data.
