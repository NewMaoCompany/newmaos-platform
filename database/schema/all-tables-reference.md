# Supabase All Tables Export

**Export Time**: 2026/2/5 21:45:12
**Total Tables**: 29

## 📋 Complete Table List

| # | Table Name | Columns | Rows | Status |
|---|------|------|------|------|
| 1 | `activities` | 0 | 0 | Empty |
| 2 | `attempts_errors` | 0 | 0 | Empty |
| 3 | `attempts_lessons` | 0 | 0 | Empty |
| 4 | `direct_chat_participants` | 0 | 0 | Empty |
| 5 | `direct_chats` | 0 | 0 | Empty |
| 6 | `direct_messages` | 0 | 0 | Empty |
| 7 | `error_tags` | 0 | 0 | Empty |
| 8 | `forum_channels` | 0 | 0 | Empty |
| 9 | `forum_members` | 0 | 0 | Empty |
| 10 | `forum_messages` | 0 | 0 | Empty |
| 11 | `notifications` | 0 | 0 | Empty |
| 12 | `question_attempts` | 0 | 0 | Empty |
| 13 | `question_qna_patterns` | 0 | 0 | Empty |
| 14 | `question_skills` | 0 | 0 | Empty |
| 15 | `question_violations` | 0 | 0 | Empty |
| 16 | `questions` | 37 | 755 | ✓ |
| 17 | `recommendations` | 0 | 0 | Empty |
| 18 | `sections` | 13 | 122 | ✓ |
| 19 | `session_history` | 0 | 0 | Empty |
| 20 | `session_question_history` | 0 | 0 | Empty |
| 21 | `skills` | 0 | 0 | Empty |
| 22 | `topic_content` | 0 | 0 | Empty |
| 23 | `unit_mastery` | 0 | 0 | Empty |
| 24 | `user_profiles` | 13 | 3 | ✓ |
| 25 | `user_question_state` | 0 | 0 | Empty |
| 26 | `user_section_progress` | 0 | 0 | Empty |
| 27 | `user_skill_mastery` | 0 | 0 | Empty |
| 28 | `user_stats` | 0 | 0 | Empty |
| 29 | `verification_codes` | 0 | 0 | Empty |

## 📊 Grouped by Category

### Core Content

- `sections` (13 cols, 122 rows)
- `questions` (37 cols, 755 rows)
- `topic_content` (0 cols, 0 rows)

### Metadata

- `skills` (0 cols, 0 rows)
- `error_tags` (0 cols, 0 rows)
- `question_skills` (0 cols, 0 rows)
- `question_violations` (0 cols, 0 rows)
- `question_qna_patterns` (0 cols, 0 rows)

### User & Progress

- `user_profiles` (13 cols, 3 rows)
- `user_section_progress` (0 cols, 0 rows)
- `user_question_state` (0 cols, 0 rows)
- `user_skill_mastery` (0 cols, 0 rows)
- `user_stats` (0 cols, 0 rows)
- `unit_mastery` (0 cols, 0 rows)

### Session History

- `session_history` (0 cols, 0 rows)
- `session_question_history` (0 cols, 0 rows)
- `question_attempts` (0 cols, 0 rows)

### Practice Attempts

- `attempts_lessons` (0 cols, 0 rows)
- `attempts_errors` (0 cols, 0 rows)

### Recommendations System

- `recommendations` (0 cols, 0 rows)

### Forum

- `forum_channels` (0 cols, 0 rows)
- `forum_messages` (0 cols, 0 rows)
- `forum_members` (0 cols, 0 rows)

### Direct Messages

- `direct_chats` (0 cols, 0 rows)
- `direct_messages` (0 cols, 0 rows)
- `direct_chat_participants` (0 cols, 0 rows)

### Notifications

- `notifications` (0 cols, 0 rows)

### Others

- `activities` (0 cols, 0 rows)
- `verification_codes` (0 cols, 0 rows)

## 📝 Table Structure Details

### `activities`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `attempts_errors`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `attempts_lessons`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `direct_chat_participants`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `direct_chats`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `direct_messages`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `error_tags`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `forum_channels`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `forum_members`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `forum_messages`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `notifications`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `question_attempts`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `question_qna_patterns`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `question_skills`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `question_violations`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `questions`

**Rows**: 755
**Columns**: 37

| Column | Type | Nullable | Example |
|------|------|------|------|
| `id` | uuid |  | c351da6f-a1c7-4cc5-aa9f-efed76b3930b |
| `course` | text |  | Both |
| `topic` | text |  | Both_Limits |
| `sub_topic_id` | text |  | 1.14 |
| `type` | text |  | MCQ |
| `calculator_allowed` | boolean |  | false |
| `difficulty` | integer |  | 5 |
| `target_time_seconds` | integer |  | 140 |
| `skill_tags` | array |  | ["infinite_limits_asymptotes","limit_not |
| `error_tags` | array |  | ["notation_misread"] |
| `prompt` | text |  | Which statement correctly interprets $\l |
| `latex` | text |  | Which statement correctly interprets $\l |
| `options` | array |  | [{"id":"A","type":"text","label":"A","va |
| `correct_option_id` | text |  | A |
| `tolerance` | numeric |  | 0.001 |
| `explanation` | text |  | The notation $x\to 3^$- means approachin |
| `micro_explanations` | jsonb |  | {"A":"Correct. Vertical asymptotes occur |
| `recommendation_reasons` | array |  | ["infinite_limits_asymptotes"] |
| `created_by` | null | ✓ | null |
| `created_at` | timestamp |  | 2026-01-25T22:36:53.242986+00:00 |
| `updated_at` | timestamp |  | 2026-02-01T02:30:30.035927+00:00 |
| `status` | text |  | published |
| `version` | integer |  | 1 |
| `reasoning_level` | integer |  | 5 |
| `mastery_weight` | numeric |  | 1.4 |
| `representation_type` | text |  | symbolic |
| `topic_id` | null | ✓ | null |
| `section_id` | text |  | 1.14 |
| `source` | text |  | NewMaoS |
| `source_year` | integer |  | 2026 |
| `notes` | null | ✓ | null |
| `weight_primary` | numeric |  | 0.9 |
| `weight_supporting` | numeric |  | 0.1 |
| `title` | text |  | 1.14-P5 |
| `prompt_type` | text |  | text |
| `primary_skill_id` | text |  | infinite_limits_asymptotes |
| `supporting_skill_ids` | array |  | ["limit_notation"] |

### `recommendations`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `sections`

**Rows**: 122
**Columns**: 13

| Column | Type | Nullable | Example |
|------|------|------|------|
| `id` | text |  | Both_Limits_unit_test |
| `topic_id` | text |  | Both_Limits |
| `title` | text |  | Unit 1 Test |
| `description` | text |  |  |
| `course_scope` | text |  | both |
| `estimated_minutes` | integer |  | 10 |
| `has_lesson` | boolean |  | true |
| `has_practice` | boolean |  | true |
| `is_unit_test` | boolean |  | true |
| `sort_order` | integer |  | 0 |
| `created_at` | timestamp |  | 2026-01-29T21:06:13.523411+00:00 |
| `updated_at` | timestamp |  | 2026-01-31T19:42:27.29935+00:00 |
| `description_2` | text |  | This is the comprehensive Unit 1 Test. I |

### `session_history`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `session_question_history`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `skills`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `topic_content`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `unit_mastery`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `user_profiles`

**Rows**: 3
**Columns**: 13

| Column | Type | Nullable | Example |
|------|------|------|------|
| `id` | uuid |  | b55d71f0-0649-4ca1-ab0e-2bb06e7f286a |
| `name` | text |  | newmao |
| `avatar_url` | text |  | https://ui-avatars.com/api/?name=newmao& |
| `current_course` | text |  | AB |
| `problems_solved` | integer |  | 0 |
| `study_hours` | array |  | [0,0,0,"... +4 more"] |
| `streak_days` | integer |  | 0 |
| `percentile` | integer |  | 0 |
| `email_notifications` | boolean |  | true |
| `sound_effects` | boolean |  | false |
| `is_creator` | boolean |  | true |
| `created_at` | timestamp |  | 2026-01-16T23:45:01.551666+00:00 |
| `updated_at` | timestamp |  | 2026-01-16T23:45:01.551666+00:00 |

### `user_question_state`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `user_section_progress`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `user_skill_mastery`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `user_stats`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

### `verification_codes`

**Rows**: 0
**Columns**: 0

*Table is empty, unable to infer structure*

