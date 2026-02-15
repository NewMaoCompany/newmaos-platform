-- =====================================================
-- NewMaoS AP Calculus Mastery - 数据库初始化脚本
-- 在 Supabase SQL Editor 中运行此文件
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- TABLES (数据表)
-- =====================================================

-- User profiles table (extends Supabase auth.users)
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

-- Questions table (题库)
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

-- Topic mastery table (主题掌握度 - 雷达图数据)
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

-- Activities table (活动记录)
CREATE TABLE IF NOT EXISTS public.activities (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type VARCHAR(20) NOT NULL CHECK (type IN ('quiz', 'practice', 'mastery')),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  score INTEGER CHECK (score IS NULL OR (score BETWEEN 0 AND 100)),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Notifications table (通知)
CREATE TABLE IF NOT EXISTS public.notifications (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  text TEXT NOT NULL,
  link VARCHAR(255) DEFAULT '/dashboard',
  unread BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Course progress table (课程进度)
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

-- Topic content table (主题内容 - 可编辑)
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
-- INDEXES (索引)
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
-- ROW LEVEL SECURITY (行级安全)
-- =====================================================

ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topic_mastery ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.course_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topic_content ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- POLICIES (安全策略)
-- =====================================================

-- User Profiles Policies
CREATE POLICY "Users can view own profile" ON public.user_profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.user_profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.user_profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Topic Mastery Policies
CREATE POLICY "Users can view own mastery" ON public.topic_mastery
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can manage own mastery" ON public.topic_mastery
  FOR ALL USING (auth.uid() = user_id);

-- Activities Policies
CREATE POLICY "Users can view own activities" ON public.activities
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own activities" ON public.activities
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Notifications Policies
CREATE POLICY "Users can view own notifications" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update own notifications" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "System can insert notifications" ON public.notifications
  FOR INSERT WITH CHECK (true);

-- Course Progress Policies
CREATE POLICY "Users can manage own course progress" ON public.course_progress
  FOR ALL USING (auth.uid() = user_id);

-- Questions Policies (public read, creator write)
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

-- Topic Content Policies (public read, creator write)
CREATE POLICY "Anyone can view topic content" ON public.topic_content
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Creators can manage topic content" ON public.topic_content
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.user_profiles WHERE id = auth.uid() AND is_creator = true)
  );

-- =====================================================
-- FUNCTIONS (函数)
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

-- Trigger for new user registration
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =====================================================
-- SEED DATA (初始数据)
-- =====================================================

-- Insert initial topic content for AB and BC courses
INSERT INTO public.topic_content (id, title, description, sub_topics) VALUES
  ('AB_Limits', 'Unit 1: Limits and Continuity', 'Limits and Continuity', '[]'::jsonb),
  ('AB_Derivatives', 'Unit 2: Differentiation: Definition and Fundamental Properties', 'Differentiation Definition', '[]'::jsonb),
  ('AB_Composite', 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', 'Composite Functions', '[]'::jsonb),
  ('AB_Applications', 'Unit 4: Contextual Applications of Differentiation', 'Contextual Applications', '[]'::jsonb),
  ('AB_Analytical', 'Unit 5: Analytical Applications of Differentiation', 'Analytical Applications', '[]'::jsonb),
  ('AB_Integration', 'Unit 6: Integration and Accumulation of Change', 'Integration and Accumulation of Change', '[]'::jsonb),
  ('AB_DiffEq', 'Unit 7: Differential Equations', 'Differential Equations', '[]'::jsonb),
  ('AB_AppIntegration', 'Unit 8: Applications of Integration', 'Applications of Integration', '[]'::jsonb),
  ('BC_Limits', 'Unit 1: Limits and Continuity', 'Limits and Continuity', '[]'::jsonb),
  ('BC_Derivatives', 'Unit 2: Differentiation: Definition and Fundamental Properties', 'Differentiation Definition', '[]'::jsonb),
  ('BC_Composite', 'Unit 3: Differentiation: Composite, Implicit, and Inverse Functions', 'Composite Functions', '[]'::jsonb),
  ('BC_Applications', 'Unit 4: Contextual Applications of Differentiation', 'Contextual Applications', '[]'::jsonb),
  ('BC_Analytical', 'Unit 5: Analytical Applications of Differentiation', 'Analytical Applications', '[]'::jsonb),
  ('BC_Integration', 'Unit 6: Integration and Accumulation of Change', 'Integration and Accumulation of Change', '[]'::jsonb),
  ('BC_DiffEq', 'Unit 7: Differential Equations', 'Differential Equations', '[]'::jsonb),
  ('BC_AppIntegration', 'Unit 8: Applications of Integration', 'Applications of Integration', '[]'::jsonb),
  ('BC_Unit9', 'Unit 9: Parametric Equations, Polar Coordinates, and Vector-Valued Functions', 'Parametric/Polar/Vector', '[]'::jsonb),
  ('BC_Series', 'Unit 10: Infinite Sequences and Series', 'Infinite Series', '[]'::jsonb)
ON CONFLICT (id) DO NOTHING;

-- =====================================================
-- DONE! 完成!
-- =====================================================
-- 数据库初始化完成。现在可以启动后端服务器了。
