import json
import os

def escape_sql(value):
    if value is None:
        return "NULL"
    if isinstance(value, str):
        return "'" + value.replace("'", "''") + "'"
    if isinstance(value, bool):
        return "TRUE" if value else "FALSE"
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, (list, dict)):
        return "'" + json.dumps(value).replace("'", "''") + "'"
    return "NULL"

def escape_array(value, lowercase=False):
    if value is None:
        return "NULL"
    if not value:
        return "'{}'"
    # Check if list of dicts (user format) or list of strings
    formatted_items = []
    for v in value:
        if isinstance(v, dict):
            # Extract skill_id from object (handle both 'skill_id' and 'id')
            item_str = str(v.get('skill_id') or v.get('id') or '')
        else:
            item_str = str(v)
            
        if lowercase:
            item_str = item_str.lower()

        item_str = item_str.replace("'", "''")
        if item_str:
            formatted_items.append(f"'{item_str}'")
            
    return f"ARRAY[{', '.join(formatted_items)}]"

def main():
    input_file = 'database/limits_update_part3.json'
    output_file = 'database/update_unit1_limits_part3.sql'
    
    # Mapping New Questions (likely sequentially in JSON) to Old Titles
    # The JSON has 10 questions.
    # 1-5 correspond to 1.7-P1..P5
    # 6-10 correspond to 1.8-P1..P5
    
    target_titles = [
        "1.7-P1", "1.7-P2", "1.7-P3", "1.7-P4", "1.7-P5",
        "1.8-P1", "1.8-P2", "1.8-P3", "1.8-P4", "1.8-P5"
    ]

    with open(input_file, 'r') as f:
        questions = json.load(f)

    if len(questions) != len(target_titles):
        print(f"Warning: Number of questions ({len(questions)}) does not match target titles ({len(target_titles)})")
        # Proceeding with zip will truncate to shortest
        
    with open(output_file, 'w') as f:
        f.write("-- Update Unit 1 Limits Questions Part 3 (Chapters 1.7 & 1.8)\n")
        f.write("BEGIN;\n\n")

        for i, (q, old_title) in enumerate(zip(questions, target_titles)):
            new_title = q.get('title')
            
            updates = []
            
            # Core fields
            updates.append(f"prompt = {escape_sql(q.get('prompt'))}")
            updates.append(f"latex = {escape_sql(q.get('latex'))}")
            updates.append(f"options = {escape_sql(q.get('options'))}::jsonb")
            updates.append(f"explanation = {escape_sql(q.get('explanation'))}")
            updates.append(f"micro_explanations = {escape_sql(q.get('micro_explanations'))}::jsonb")
            updates.append(f"correct_option_id = {escape_sql(q.get('correct_option_id'))}")
            
            # Tags
            updates.append(f"skill_tags = {escape_array(q.get('skill_tags'), lowercase=True)}")
            updates.append(f"error_tags = {escape_array(q.get('error_tags'), lowercase=True)}")
            updates.append(f"recommendation_reasons = {escape_array(q.get('recommendation_reasons'))}")
            
            # Primary Skill
            prim_skill = q.get('primary_skill_id')
            if prim_skill:
                prim_skill = prim_skill.lower()
            updates.append(f"primary_skill_id = {escape_sql(prim_skill)}")
            
            # Supporting Skills
            updates.append(f"supporting_skill_ids = {escape_array(q.get('supporting_skill_ids'), lowercase=True)}")

            # Meta
            topic_id = q.get('topic_id')
            if topic_id == 'Both_Limit':
                topic_id = 'Both_Limits'
            updates.append(f"topic_id = {escape_sql(topic_id)}")
            
            # Sub Topic ID: "Unit1_1.7" -> "1.7"
            raw_sub_topic = q.get('sub_topic_id')
            if raw_sub_topic == "Unit1_1.7":
                raw_sub_topic = "1.7"
            elif raw_sub_topic == "Unit1_1.8":
                raw_sub_topic = "1.8"
            elif raw_sub_topic and raw_sub_topic.startswith('Unit1_'):
                 raw_sub_topic = raw_sub_topic.replace('Unit1_', '')
            updates.append(f"sub_topic_id = {escape_sql(raw_sub_topic)}")
            
            updates.append(f"section_id = {escape_sql(q.get('section_id'))}")
            
            # Difficulty
            diff = q.get('difficulty')
            if isinstance(diff, str) and diff.startswith('Level'):
                try:
                    diff_int = int(diff.replace('Level', ''))
                    updates.append(f"difficulty = {diff_int}")
                except:
                    updates.append(f"difficulty = {escape_sql(diff)}")
            else:
                updates.append(f"difficulty = {escape_sql(diff)}")

            updates.append(f"target_time_seconds = {escape_sql(q.get('target_time_seconds'))}")
            updates.append(f"updated_at = NOW()")
            updates.append(f"title = {escape_sql(new_title)}")
            
            # Course
            course_map = {
                "AP_Calculus_BC": "BC",
                "AP_Calculus_AB": "AB",
                "Both": "Both"
            }
            raw_course = q.get('course')
            mapped_course = course_map.get(raw_course, raw_course)
            updates.append(f"course = {escape_sql(mapped_course)}")
            
            updates.append(f"type = {escape_sql(q.get('type').upper() if q.get('type') else None)}")
            
            # Calculator Allowed
            calc = q.get('calculator_allowed')
            if calc == 'none':
                calc = False
            updates.append(f"calculator_allowed = {escape_sql(calc)}")
            
            updates.append(f"tolerance = {escape_sql(q.get('tolerance'))}")
            updates.append(f"status = {escape_sql(q.get('status'))}")
            updates.append(f"version = {escape_sql(q.get('version'))}")
            updates.append(f"reasoning_level = {escape_sql(q.get('reasoning_level'))}")
            updates.append(f"mastery_weight = {escape_sql(q.get('mastery_weight'))}")
            updates.append(f"source = {escape_sql(q.get('source'))}")
            updates.append(f"source_year = {escape_sql(q.get('source_year'))}")
            updates.append(f"notes = {escape_sql(q.get('notes'))}")
            
            updates.append(f"weight_primary = {escape_sql(q.get('weight_primary'))}")
            
            # Weight Supporting: Handle Dict or Float
            ws = q.get('weight_supporting')
            ws_val = 0.0
            if isinstance(ws, dict):
                # Take the first value if dictionary
                if ws:
                    ws_val = list(ws.values())[0]
            elif isinstance(ws, (int, float)):
                ws_val = ws
            updates.append(f"weight_supporting = {ws_val}") # No escape needed for float
            # Note: weight_supporting column is float8

            # Prompt Type Mapping
            ptype = q.get('prompt_type')
            if ptype == 'image':
                ptype = 'text_and_image'
            updates.append(f"prompt_type = {escape_sql(ptype)}")
            
            updates.append(f"representation_type = {escape_sql(q.get('representation_type'))}")

            f.write(f"-- Updating {old_title} -> {new_title}\n")
            f.write(f"UPDATE public.questions SET\n  ")
            f.write(",\n  ".join(updates))
            f.write(f"\nWHERE title = '{old_title}';\n\n")

        f.write("COMMIT;\n")
    
    print(f"Generated {output_file}")

if __name__ == "__main__":
    main()
