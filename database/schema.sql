-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.activities (
  id integer NOT NULL DEFAULT nextval('activities_id_seq'::regclass),
  user_id uuid NOT NULL,
  type character varying NOT NULL CHECK (type::text = ANY (ARRAY['quiz'::character varying, 'practice'::character varying, 'mastery'::character varying]::text[])),
  title character varying NOT NULL,
  description text,
  score integer CHECK (score IS NULL OR score >= 0 AND score <= 100),
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT activities_pkey PRIMARY KEY (id),
  CONSTRAINT activities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
CREATE TABLE public.attempt_errors (
  attempt_id uuid NOT NULL,
  error_tag_id character varying NOT NULL,
  CONSTRAINT attempt_errors_pkey PRIMARY KEY (attempt_id, error_tag_id),
  CONSTRAINT attempt_errors_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.question_attempts(id),
  CONSTRAINT attempt_errors_error_tag_id_fkey FOREIGN KEY (error_tag_id) REFERENCES public.error_tags(id)
);
CREATE TABLE public.course_progress (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  user_id uuid NOT NULL,
  course_id character varying NOT NULL CHECK (course_id::text = ANY (ARRAY['AB'::character varying, 'BC'::character varying]::text[])),
  status character varying DEFAULT 'Not Started'::character varying CHECK (status::text = ANY (ARRAY['Not Started'::character varying, 'In Progress'::character varying, 'Paused'::character varying, 'Completed'::character varying]::text[])),
  current_module_index integer DEFAULT 0,
  modules jsonb DEFAULT '[]'::jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT course_progress_pkey PRIMARY KEY (id),
  CONSTRAINT course_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
CREATE TABLE public.direct_chat_participants (
  chat_id uuid NOT NULL,
  user_id uuid NOT NULL,
  joined_at timestamp with time zone DEFAULT now(),
  CONSTRAINT direct_chat_participants_pkey PRIMARY KEY (chat_id, user_id),
  CONSTRAINT direct_chat_participants_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.direct_chats(id),
  CONSTRAINT direct_chat_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
);
CREATE TABLE public.direct_chats (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT direct_chats_pkey PRIMARY KEY (id)
);
CREATE TABLE public.direct_messages (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  chat_id uuid,
  user_id uuid,
  content text NOT NULL,
  is_read boolean DEFAULT false,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT direct_messages_pkey PRIMARY KEY (id),
  CONSTRAINT direct_messages_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.direct_chats(id),
  CONSTRAINT direct_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
);
CREATE TABLE public.error_tags (
  id character varying NOT NULL,
  name character varying NOT NULL,
  category character varying,
  severity integer DEFAULT 1 CHECK (severity >= 1 AND severity <= 5),
  unit text,
  CONSTRAINT error_tags_pkey PRIMARY KEY (id)
);
CREATE TABLE public.forum_channels (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE,
  name text NOT NULL,
  category text NOT NULL DEFAULT 'General'::text,
  description text,
  position integer DEFAULT 0,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT forum_channels_pkey PRIMARY KEY (id)
);
CREATE TABLE public.forum_messages (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  channel_id uuid,
  user_id uuid,
  content text NOT NULL,
  is_pinned boolean DEFAULT false,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  reply_to_id uuid,
  CONSTRAINT forum_messages_pkey PRIMARY KEY (id),
  CONSTRAINT forum_messages_reply_to_id_fkey FOREIGN KEY (reply_to_id) REFERENCES public.forum_messages(id),
  CONSTRAINT forum_messages_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.forum_channels(id),
  CONSTRAINT forum_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profiles(id)
);
CREATE TABLE public.notifications (
  id integer NOT NULL DEFAULT nextval('notifications_id_seq'::regclass),
  user_id uuid NOT NULL,
  text text NOT NULL,
  link character varying DEFAULT '/dashboard'::character varying,
  unread boolean DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT notifications_pkey PRIMARY KEY (id),
  CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
CREATE TABLE public.question_attempts (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  question_id uuid NOT NULL,
  is_correct boolean NOT NULL,
  selected_option_id character varying,
  answer_numeric numeric,
  time_spent_seconds integer DEFAULT 0,
  attempt_no integer DEFAULT 1,
  error_tags ARRAY DEFAULT '{}'::text[],
  created_at timestamp with time zone DEFAULT now(),
  question_version_id uuid,
  CONSTRAINT question_attempts_pkey PRIMARY KEY (id),
  CONSTRAINT question_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id),
  CONSTRAINT question_attempts_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id),
  CONSTRAINT question_attempts_question_version_id_fkey FOREIGN KEY (question_version_id) REFERENCES public.question_versions(id)
);
CREATE TABLE public.question_error_patterns (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  question_id uuid NOT NULL,
  error_tag_id text NOT NULL,
  description text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT question_error_patterns_pkey PRIMARY KEY (id),
  CONSTRAINT question_error_patterns_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id)
);
CREATE TABLE public.question_skills (
  question_id uuid NOT NULL,
  skill_id character varying NOT NULL,
  weight numeric DEFAULT 1.0 CHECK (weight >= 0::numeric AND weight <= 1::numeric),
  role character varying DEFAULT 'primary'::character varying CHECK (role::text = ANY (ARRAY['primary'::character varying, 'supporting'::character varying]::text[])),
  CONSTRAINT question_skills_pkey PRIMARY KEY (question_id, skill_id),
  CONSTRAINT question_skills_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id),
  CONSTRAINT question_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id)
);
CREATE TABLE public.question_versions (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  question_id uuid NOT NULL,
  version integer NOT NULL,
  snapshot jsonb NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT question_versions_pkey PRIMARY KEY (id),
  CONSTRAINT question_versions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id)
);
CREATE TABLE public.questions (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  course character varying NOT NULL CHECK (course::text = ANY (ARRAY['AB'::character varying, 'BC'::character varying, 'Both'::character varying]::text[])),
  topic character varying NOT NULL,
  sub_topic_id character varying,
  type character varying NOT NULL CHECK (type::text = ANY (ARRAY['MCQ'::character varying, 'Numeric'::character varying, 'FRQ'::character varying]::text[])),
  calculator_allowed boolean DEFAULT false,
  difficulty integer DEFAULT 3 CHECK (difficulty >= 1 AND difficulty <= 5),
  target_time_seconds integer DEFAULT 90,
  skill_tags ARRAY DEFAULT '{}'::text[],
  error_tags ARRAY DEFAULT '{}'::text[],
  prompt text NOT NULL,
  latex text,
  options jsonb DEFAULT '[]'::jsonb,
  correct_option_id character varying,
  tolerance numeric,
  explanation text,
  micro_explanations jsonb,
  recommendation_reasons ARRAY DEFAULT '{}'::text[],
  created_by uuid,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  status character varying DEFAULT 'active'::character varying CHECK (status::text = ANY (ARRAY['draft'::character varying, 'active'::character varying, 'published'::character varying, 'retired'::character varying]::text[])),
  version integer DEFAULT 1,
  reasoning_level integer DEFAULT 3 CHECK (reasoning_level >= 1 AND reasoning_level <= 5),
  mastery_weight numeric DEFAULT 1.0,
  representation_type character varying DEFAULT 'symbolic'::character varying CHECK (representation_type::text = ANY (ARRAY['symbolic'::character varying, 'graph'::character varying, 'table'::character varying, 'verbal'::character varying, 'mixed'::character varying]::text[])),
  topic_id character varying,
  section_id text,
  source text DEFAULT 'self'::text,
  source_year integer,
  notes text,
  weight_primary double precision DEFAULT 1.0,
  weight_supporting double precision DEFAULT 0.5,
  title text DEFAULT 'Question'::text,
  prompt_type text DEFAULT 'text'::text,
  primary_skill_id text,
  supporting_skill_ids ARRAY,
  CONSTRAINT questions_pkey PRIMARY KEY (id),
  CONSTRAINT questions_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id),
  CONSTRAINT fk_questions_topic_content FOREIGN KEY (topic_id) REFERENCES public.topic_content(id)
);
CREATE TABLE public.recommendations (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  question_id uuid NOT NULL,
  score numeric NOT NULL CHECK (score >= 0::numeric AND score <= 1::numeric),
  reason character varying NOT NULL,
  reason_detail text,
  skill_id character varying,
  priority integer DEFAULT 1,
  expires_at timestamp with time zone DEFAULT (now() + '24:00:00'::interval),
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT recommendations_pkey PRIMARY KEY (id),
  CONSTRAINT recommendations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id),
  CONSTRAINT recommendations_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id),
  CONSTRAINT recommendations_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id)
);
CREATE TABLE public.sections (
  id character varying NOT NULL,
  topic_id character varying NOT NULL,
  title character varying NOT NULL,
  description text DEFAULT ''::text,
  course_scope character varying DEFAULT 'both'::character varying CHECK (course_scope::text = ANY (ARRAY['both'::character varying, 'ab_only'::character varying, 'bc_only'::character varying]::text[])),
  estimated_minutes integer DEFAULT 15,
  has_lesson boolean DEFAULT true,
  has_practice boolean DEFAULT true,
  is_unit_test boolean DEFAULT false,
  sort_order integer DEFAULT 0,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  description_2 text,
  CONSTRAINT sections_pkey PRIMARY KEY (id)
);
CREATE TABLE public.skills (
  id character varying NOT NULL,
  name character varying NOT NULL,
  unit character varying NOT NULL,
  prerequisites ARRAY DEFAULT '{}'::text[],
  CONSTRAINT skills_pkey PRIMARY KEY (id)
);
CREATE TABLE public.topic_content (
  id character varying NOT NULL,
  title character varying NOT NULL,
  description text,
  sub_topics jsonb DEFAULT '[]'::jsonb,
  unit_test jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT topic_content_pkey PRIMARY KEY (id)
);
CREATE TABLE public.unit_mastery (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  user_id uuid NOT NULL,
  subject character varying NOT NULL,
  mastery_score integer DEFAULT 0 CHECK (mastery_score >= 0 AND mastery_score <= 100),
  full_mark integer DEFAULT 100,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  topic_id character varying,
  completion_rate numeric DEFAULT 0,
  accuracy_rate numeric DEFAULT 0,
  total_attempts integer DEFAULT 0,
  correct_attempts integer DEFAULT 0,
  unique_questions_solved integer DEFAULT 0,
  CONSTRAINT unit_mastery_pkey PRIMARY KEY (id),
  CONSTRAINT topic_mastery_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id),
  CONSTRAINT fk_topic_mastery_topic_content FOREIGN KEY (topic_id) REFERENCES public.topic_content(id)
);
CREATE TABLE public.user_profiles (
  id uuid NOT NULL,
  name character varying,
  avatar_url text,
  current_course character varying DEFAULT 'AB'::character varying,
  problems_solved integer DEFAULT 0,
  study_hours jsonb DEFAULT '[0, 0, 0, 0, 0, 0, 0]'::jsonb,
  streak_days integer DEFAULT 0,
  percentile integer DEFAULT 0,
  email_notifications boolean DEFAULT true,
  sound_effects boolean DEFAULT false,
  is_creator boolean DEFAULT false,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT user_profiles_pkey PRIMARY KEY (id),
  CONSTRAINT user_profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id)
);
CREATE TABLE public.user_question_state (
  user_id uuid NOT NULL,
  question_id uuid NOT NULL,
  is_starred boolean DEFAULT false,
  is_flagged boolean DEFAULT false,
  personal_tags ARRAY DEFAULT '{}'::text[],
  personal_note text,
  next_review_at timestamp with time zone,
  ease_factor numeric DEFAULT 2.5 CHECK (ease_factor >= 1.3),
  interval_days integer DEFAULT 1,
  review_count integer DEFAULT 0,
  last_attempt_id uuid,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT user_question_state_pkey PRIMARY KEY (user_id, question_id),
  CONSTRAINT user_question_state_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id),
  CONSTRAINT user_question_state_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id),
  CONSTRAINT user_question_state_last_attempt_id_fkey FOREIGN KEY (last_attempt_id) REFERENCES public.question_attempts(id)
);
CREATE TABLE public.user_section_progress (
  user_id uuid NOT NULL,
  section_id character varying NOT NULL,
  status character varying CHECK (status::text = ANY (ARRAY['in_progress'::character varying, 'completed'::character varying]::text[])),
  data jsonb DEFAULT '{}'::jsonb,
  score integer DEFAULT 0,
  total_questions integer DEFAULT 0,
  correct_questions integer DEFAULT 0,
  last_accessed_at timestamp with time zone DEFAULT now(),
  created_at timestamp with time zone DEFAULT now(),
  entity_type character varying DEFAULT 'section'::character varying CHECK (entity_type::text = ANY (ARRAY['course'::character varying, 'unit'::character varying, 'section'::character varying]::text[])),
  CONSTRAINT user_section_progress_pkey PRIMARY KEY (user_id, section_id),
  CONSTRAINT user_section_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
CREATE TABLE public.user_skill_mastery (
  user_id uuid NOT NULL,
  skill_id character varying NOT NULL,
  mastery_score numeric DEFAULT 0 CHECK (mastery_score >= 0::numeric AND mastery_score <= 100::numeric),
  confidence numeric DEFAULT 0 CHECK (confidence >= 0::numeric AND confidence <= 1::numeric),
  last_practiced timestamp with time zone,
  streak_correct integer DEFAULT 0,
  streak_wrong integer DEFAULT 0,
  CONSTRAINT user_skill_mastery_pkey PRIMARY KEY (user_id, skill_id),
  CONSTRAINT user_skill_mastery_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id),
  CONSTRAINT user_skill_mastery_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id)
);
CREATE TABLE public.user_stats (
  user_id uuid NOT NULL,
  total_attempts integer DEFAULT 0,
  correct_attempts integer DEFAULT 0,
  accuracy_rate numeric DEFAULT 0 CHECK (accuracy_rate >= 0::numeric AND accuracy_rate <= 100::numeric),
  unique_questions_attempted integer DEFAULT 0,
  streak_correct integer DEFAULT 0,
  streak_wrong integer DEFAULT 0,
  current_streak_days integer DEFAULT 0,
  longest_streak_days integer DEFAULT 0,
  total_time_spent_seconds bigint DEFAULT 0,
  last_practiced timestamp with time zone,
  last_streak_date date,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT user_stats_pkey PRIMARY KEY (user_id),
  CONSTRAINT user_stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
CREATE TABLE public.verification_codes (
  email text NOT NULL,
  code text NOT NULL,
  expires_at timestamp with time zone NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  metadata text,
  CONSTRAINT verification_codes_pkey PRIMARY KEY (email)
);