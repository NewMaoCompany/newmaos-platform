# Supabase Complete Database Export

**导出时间**: 2026/2/5 21:40:46
**数据库**: https://xzpjlnkirboevkjzitcx.supabase.co
**Schema**: public

## 📊 总览

| 类型 | 数量 |
|------|------|
| Tables | 11 |
| Views | 0 |
| Functions (RPCs) | 8 |
| Enums | 0 |
| RLS Policies | 0 |

## 📋 Tables

### `sections`

**行数**: 122

| 列名 | 类型 | 可空 |
|------|------|------|
| `id` | text |  |
| `topic_id` | text |  |
| `title` | text |  |
| `description` | text |  |
| `course_scope` | text |  |
| `estimated_minutes` | integer |  |
| `has_lesson` | boolean |  |
| `has_practice` | boolean |  |
| `is_unit_test` | boolean |  |
| `sort_order` | integer |  |
| `created_at` | timestamp |  |
| `updated_at` | timestamp |  |
| `description_2` | text |  |

### `questions`

**行数**: 755

| 列名 | 类型 | 可空 |
|------|------|------|
| `id` | uuid |  |
| `course` | text |  |
| `topic` | text |  |
| `sub_topic_id` | text |  |
| `type` | text |  |
| `calculator_allowed` | boolean |  |
| `difficulty` | integer |  |
| `target_time_seconds` | integer |  |
| `skill_tags` | array |  |
| `error_tags` | array |  |
| `prompt` | text |  |
| `latex` | text |  |
| `options` | array |  |
| `correct_option_id` | text |  |
| `tolerance` | numeric |  |
| `explanation` | text |  |
| `micro_explanations` | jsonb |  |
| `recommendation_reasons` | array |  |
| `created_by` | null | ✓ |
| `created_at` | timestamp |  |
| `updated_at` | timestamp |  |
| `status` | text |  |
| `version` | integer |  |
| `reasoning_level` | integer |  |
| `mastery_weight` | numeric |  |
| `representation_type` | text |  |
| `topic_id` | null | ✓ |
| `section_id` | text |  |
| `source` | text |  |
| `source_year` | integer |  |
| `notes` | null | ✓ |
| `weight_primary` | numeric |  |
| `weight_supporting` | numeric |  |
| `title` | text |  |
| `prompt_type` | text |  |
| `primary_skill_id` | text |  |
| `supporting_skill_ids` | array |  |

### `skills`

**行数**: 0

### `error_tags`

**行数**: 0

### `question_skills`

**行数**: 0

### `user_section_progress`

**行数**: 0

### `question_attempts`

**行数**: 0

### `user_stats`

**行数**: 0

### `recommendations`

**行数**: 0

### `forum_channels`

**行数**: 0

### `forum_messages`

**行数**: 0

## ⚙️ Functions (RPCs)

### `get_user_stats`

(需要查看migrations了解完整签名)

### `get_radar_data`

(需要查看migrations了解完整签名)

### `get_daily_stats`

(需要查看migrations了解完整签名)

### `get_accuracy_history`

(需要查看migrations了解完整签名)

### `get_recent_activities`

(需要查看migrations了解完整签名)

### `submit_answer`

(需要查看migrations了解完整签名)

### `complete_session`

(需要查看migrations了解完整签名)

### `get_recommendations`

(需要查看migrations了解完整签名)

