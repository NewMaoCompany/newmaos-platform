# Supabase Database Schema

Export Time: 2026-02-06T02:34:41.583Z

## Database Statistics

- **Table Count**: 8
- **Total Columns**: 37

## Table List

- `questions`
- `skills`
- `error_tags`
- `question_skills`
- `user_section_progress`
- `recommendations`
- `forum_channels`
- `forum_messages`

## Table Structure Details

### `questions`

| Column Name | Inferred Type | Example Value |
|------|----------|--------|
| `id` | string | c351da6f-a1c7-4cc5-aa9f-efed76b3930b |
| `course` | string | Both |
| `topic` | string | Both_Limits |
| `sub_topic_id` | string | 1.14 |
| `type` | string | MCQ |
| `calculator_allowed` | boolean | false |
| `difficulty` | number | 5 |
| `target_time_seconds` | number | 140 |
| `skill_tags` | object | ["infinite_limits_asymptotes","limit_notation"] |
| `error_tags` | object | ["notation_misread"] |
| `prompt` | string | Which statement correctly interprets $\lim_{x\to 3 |
| `latex` | string | Which statement correctly interprets $\lim_{x\to 3 |
| `options` | object | [{"id":"A","type":"text","label":"A","value":"As $ |
| `correct_option_id` | string | A |
| `tolerance` | number | 0.001 |
| `explanation` | string | The notation $x\to 3^$- means approaching 3 from v |
| `micro_explanations` | object | {"A":"Correct. Vertical asymptotes occur where the |
| `recommendation_reasons` | object | ["infinite_limits_asymptotes"] |
| `created_by` | object | null |
| `created_at` | string | 2026-01-25T22:36:53.242986+00:00 |
| `updated_at` | string | 2026-02-01T02:30:30.035927+00:00 |
| `status` | string | published |
| `version` | number | 1 |
| `reasoning_level` | number | 5 |
| `mastery_weight` | number | 1.4 |
| `representation_type` | string | symbolic |
| `topic_id` | object | null |
| `section_id` | string | 1.14 |
| `source` | string | NewMaoS |
| `source_year` | number | 2026 |
| `notes` | object | null |
| `weight_primary` | number | 0.9 |
| `weight_supporting` | number | 0.1 |
| `title` | string | 1.14-P5 |
| `prompt_type` | string | text |
| `primary_skill_id` | string | infinite_limits_asymptotes |
| `supporting_skill_ids` | object | ["limit_notation"] |

### `skills`

*Table is empty, unable to infer structure*

### `error_tags`

*Table is empty, unable to infer structure*

### `question_skills`

*Table is empty, unable to infer structure*

### `user_section_progress`

*Table is empty, unable to infer structure*

### `recommendations`

*Table is empty, unable to infer structure*

### `forum_channels`

*Table is empty, unable to infer structure*

### `forum_messages`

*Table is empty, unable to infer structure*

