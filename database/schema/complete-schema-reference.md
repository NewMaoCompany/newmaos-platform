# Supabase Database Complete Schema

**Export Time**: 2026/2/5 21:35:45

## 📊 Database Statistics

| Metric | Count |
|------|------|
| Total Tables | 10 |
| Tables with Data | 2 |
| Empty Tables | 8 |
| Total Columns | 50 |

## 📋 Table Classification

### Core Content

- `sections` - 13 columns 122 rows
- `questions` - 37 columns 755 rows

### Metadata

- `skills` - 0 columns (Empty)
- `error_tags` - 0 columns (Empty)
- `question_skills` - 0 columns (Empty)

### User & Progress

- `user_section_progress` - 0 columns (Empty)
- `user_stats` - 0 columns (Empty)

### Recommendations

- `recommendations` - 0 columns (Empty)

### Forum

- `forum_channels` - 0 columns (Empty)
- `forum_messages` - 0 columns (Empty)

## 📝 Table Structure Details

### `sections`

**Rows**: 122

| Column | Type | Nullable | Example Value |
|------|------|------|--------|
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
| `description_2` | text |  | This is the comprehensive Unit 1 Test. It covers l |

### `questions`

**Rows**: 755

| Column | Type | Nullable | Example Value |
|------|------|------|--------|
| `id` | uuid |  | c351da6f-a1c7-4cc5-aa9f-efed76b3930b |
| `course` | text |  | Both |
| `topic` | text |  | Both_Limits |
| `sub_topic_id` | text |  | 1.14 |
| `type` | text |  | MCQ |
| `calculator_allowed` | boolean |  | false |
| `difficulty` | integer |  | 5 |
| `target_time_seconds` | integer |  | 140 |
| `skill_tags` | array |  | ["infinite_limits_asymptotes","limit_notation"] |
| `error_tags` | array |  | ["notation_misread"] |
| `prompt` | text |  | Which statement correctly interprets $\lim_{x\to 3 |
| `latex` | text |  | Which statement correctly interprets $\lim_{x\to 3 |
| `options` | array |  | [{"id":"A","type":"text","label":"A","value":"As $ |
| `correct_option_id` | text |  | A |
| `tolerance` | numeric |  | 0.001 |
| `explanation` | text |  | The notation $x\to 3^$- means approaching 3 from v |
| `micro_explanations` | jsonb |  | {"A":"Correct. Vertical asymptotes occur where the |
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

### `skills`

*⚠️ Table is empty, unable to infer structure from data*

### `error_tags`

*⚠️ Table is empty, unable to infer structure from data*

### `question_skills`

*⚠️ Table is empty, unable to infer structure from data*

### `user_section_progress`

*⚠️ Table is empty, unable to infer structure from data*

### `user_stats`

*⚠️ Table is empty, unable to infer structure from data*

### `recommendations`

*⚠️ Table is empty, unable to infer structure from data*

### `forum_channels`

*⚠️ Table is empty, unable to infer structure from data*

### `forum_messages`

*⚠️ Table is empty, unable to infer structure from data*

