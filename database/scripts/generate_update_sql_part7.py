import json
import os

def escape_sql(value):
    if value is None:
        return "NULL"
    if isinstance(value, str):
        return "'" + value.replace("'", "''") + "'"
    if isinstance(value, bool):
        return "TRUE" if value else "FALSE"
    return str(value)

def escape_json(value):
    if value is None:
        return "null"
    return json.dumps(value)

def map_difficulty(level_str):
    mapping = {
        "Level1": 1,
        "Level2": 2,
        "Level3": 3,
        "Level4": 4,
        "Level5": 5
    }
    return mapping.get(level_str, 3)

def generate_sql():
    # Load the new questions
    with open('database/limits_update_part7.json', 'r') as f:
        new_questions = json.load(f)

    sql_statements = []
    
    # Mapping based on Title prefix in JSON
    # JSON has "U1C15_Q1...", "U1C16_Q1..."
    
    for q in new_questions:
        json_title = q.get('title', '')
        
        original_title = None
        if "U1C15_Q1" in json_title: original_title = "1.15-P1"
        elif "U1C15_Q2" in json_title: original_title = "1.15-P2"
        elif "U1C15_Q3" in json_title: original_title = "1.15-P3"
        elif "U1C15_Q4" in json_title: original_title = "1.15-P4"
        elif "U1C15_Q5" in json_title: original_title = "1.15-P5"
        elif "U1C16_Q1" in json_title: original_title = "1.16-P1"
        elif "U1C16_Q2" in json_title: original_title = "1.16-P2"
        elif "U1C16_Q3" in json_title: original_title = "1.16-P3"
        elif "U1C16_Q4" in json_title: original_title = "1.16-P4"
        elif "U1C16_Q5" in json_title: original_title = "1.16-P5"
        
        if not original_title:
            print(f"Skipping unknown title pattern: {json_title}")
            continue

        # Build UPDATE statement
        updates = []
        
        # Course - Force 'Both' to avoid varchar error
        updates.append(f"course = 'Both'")
        updates.append(f"topic = {escape_sql(q.get('topic', 'Both_Limits'))}")
        
        # Section ID mappings
        # U1.15 -> 1.15, U1.16 -> 1.16
        section_id = "1.15" if "U1C15" in json_title else "1.16"
        updates.append(f"sub_topic_id = '{section_id}'")
        updates.append(f"section_id = '{section_id}'")
        
        # Enforce uppercase MCQ
        q_type = q.get('type', 'MCQ').upper()
        if q_type == 'MCQ': 
            updates.append(f"type = 'MCQ'")
        else:
            updates.append(f"type = {escape_sql(q_type)}")

        updates.append(f"calculator_allowed = {escape_sql(q.get('calculator_allowed', False))}")
        updates.append(f"difficulty = {map_difficulty(q.get('difficulty'))}")
        updates.append(f"target_time_seconds = {q.get('target_time_seconds', 60)}")
        
        # Skill tags
        skills = q.get('skill_tags', [])
        if skills and isinstance(skills[0], dict):
             skills = [s['skill_id'] for s in skills]
        
        if skills:
            skills_sql = "ARRAY[" + ", ".join(f"'{s}'" for s in skills) + "]"
            updates.append(f"skill_tags = {skills_sql}")
        else:
             updates.append("skill_tags = ARRAY[]::text[]")

        # Error tags
        error_tags = q.get('error_tags', [])
        if error_tags:
            errors_sql = "ARRAY[" + ", ".join(f"'{e}'" for e in error_tags) + "]"
            updates.append(f"error_tags = {errors_sql}")
        
        updates.append(f"prompt = {escape_sql(q.get('prompt'))}")
        updates.append(f"latex = {escape_sql(q.get('latex'))}")
        
        # Options
        options = q.get('options', [])
        updates.append(f"options = {escape_sql(json.dumps(options))}")
        
        updates.append(f"correct_option_id = {escape_sql(q.get('correct_option_id'))}")
        updates.append(f"explanation = {escape_sql(q.get('explanation'))}")
        
        # Recommendation reasons
        recs = q.get('recommendation_reasons', [])
        if recs:
             recs_sql = "ARRAY[" + ", ".join(f"'{r}'" for r in recs) + "]"
             updates.append(f"recommendation_reasons = {recs_sql}")

        updates.append(f"status = {escape_sql(q.get('status', 'published'))}")
        
        # VERSION INCREMENT
        updates.append(f"version = version + 1")
        
        # Reasoning level
        rl = q.get('reasoning_level')
        if isinstance(rl, str):
            rl_map = {"Conceptual": 2, "fluency": 1, "skill": 2, "application": 3}
            rl = rl_map.get(rl.lower(), 2)
        updates.append(f"reasoning_level = {rl}")
        
        updates.append(f"mastery_weight = {escape_sql(q.get('mastery_weight', 1.0))}")
        updates.append(f"source = {escape_sql(q.get('source', 'NewMaoS'))}")
        updates.append(f"source_year = {q.get('source_year', 2026)}")
        updates.append(f"notes = {escape_sql(q.get('notes'))}")
        
        updates.append(f"weight_primary = {q.get('weight_primary', 1.0)}")
        updates.append(f"weight_supporting = {q.get('weight_supporting', 0.0)}")
        
        
        # prompt_type
        ptype = q.get('prompt_type', 'text')
        if ptype == 'image':
            ptype = 'text_and_image'
        updates.append(f"prompt_type = {escape_sql(ptype)}")
        updates.append(f"representation_type = {escape_sql(q.get('representation_type', 'symbolic'))}")

        updates.append("updated_at = NOW()")

        
        set_clause = ",\n  ".join(updates)
        
        sql = f"""
UPDATE public.questions
SET
  {set_clause}
WHERE title = '{original_title}';
"""
        sql_statements.append(sql)

    # Write to file
    with open('database/update_unit1_limits_part7.sql', 'w') as f:
        f.write("-- Update script for Unit 1.15 & 1.16 (Part 7)\n")
        f.write("\n".join(sql_statements))
        
    print("Generated database/update_unit1_limits_part7.sql")

if __name__ == "__main__":
    generate_sql()
