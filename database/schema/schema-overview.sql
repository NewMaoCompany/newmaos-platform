-- Supabase Schema Export
-- Generated: 2026-02-06T02:40:55.282Z
-- Database: https://xzpjlnkirboevkjzitcx.supabase.co

-- ==============================================
-- TABLES (11)
-- ==============================================

-- Table: sections
-- Rows: 122
-- Columns (13):
--   id: text
--   topic_id: text
--   title: text
--   description: text
--   course_scope: text
--   estimated_minutes: integer
--   has_lesson: boolean
--   has_practice: boolean
--   is_unit_test: boolean
--   sort_order: integer
--   created_at: timestamp
--   updated_at: timestamp
--   description_2: text

-- Table: questions
-- Rows: 755
-- Columns (37):
--   id: uuid
--   course: text
--   topic: text
--   sub_topic_id: text
--   type: text
--   calculator_allowed: boolean
--   difficulty: integer
--   target_time_seconds: integer
--   skill_tags: array
--   error_tags: array
--   prompt: text
--   latex: text
--   options: array
--   correct_option_id: text
--   tolerance: numeric
--   explanation: text
--   micro_explanations: jsonb
--   recommendation_reasons: array
--   created_by: null (nullable)
--   created_at: timestamp
--   updated_at: timestamp
--   status: text
--   version: integer
--   reasoning_level: integer
--   mastery_weight: numeric
--   representation_type: text
--   topic_id: null (nullable)
--   section_id: text
--   source: text
--   source_year: integer
--   notes: null (nullable)
--   weight_primary: numeric
--   weight_supporting: numeric
--   title: text
--   prompt_type: text
--   primary_skill_id: text
--   supporting_skill_ids: array

-- Table: skills
-- Rows: 0

-- Table: error_tags
-- Rows: 0

-- Table: question_skills
-- Rows: 0

-- Table: user_section_progress
-- Rows: 0

-- Table: question_attempts
-- Rows: 0

-- Table: user_stats
-- Rows: 0

-- Table: recommendations
-- Rows: 0

-- Table: forum_channels
-- Rows: 0

-- Table: forum_messages
-- Rows: 0


-- ==============================================
-- FUNCTIONS (8)
-- ==============================================

-- Function: get_user_stats
-- (需要查看migrations了解完整签名)

-- Function: get_radar_data
-- (需要查看migrations了解完整签名)

-- Function: get_daily_stats
-- (需要查看migrations了解完整签名)

-- Function: get_accuracy_history
-- (需要查看migrations了解完整签名)

-- Function: get_recent_activities
-- (需要查看migrations了解完整签名)

-- Function: submit_answer
-- (需要查看migrations了解完整签名)

-- Function: complete_session
-- (需要查看migrations了解完整签名)

-- Function: get_recommendations
-- (需要查看migrations了解完整签名)

